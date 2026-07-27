---
name: hooks-startup-benchmark
description: Números medidos de startup de hook por linguagem (bash+jq, Deno, Bun, Python, Perl) neste Mac — bash ganha no early-exit e perde no caminho longo
metadata:
  type: reference
---

# Startup de hook por linguagem — medido

**Verificado em 2026-07-26**, M2 / 8 GB / macOS 26.5.1. Harness:
`scratchpad/bench-hooks/bench2.py` (20 exec por impl, ordem intercalada entre
implementações a cada rodada para diluir ruído térmico; reporta **mediana**).

Implementações portadas do `adr-guard.sh` real e **validadas como equivalentes**
nos 3 cenários (early-exit / deny / supersessão-permitida): mesma decisão, mesmo
tamanho de saída (637 bytes no deny).

## Medianas (ms)

| impl | A: early-exit (~99% dos Edit) | B: deny (lê arquivo + emite JSON) |
|---|---|---|
| bash 3.2 + jq (atual) | **11.9** | 27.4 |
| bun | 15.8 | **16.7** |
| python 3.14 | 20.8 | 20.9 |
| deno run | 24.2 | 25.1 |
| `/usr/bin/true` (baseline fork/exec) | 1.8 | 2.0 |

**A inversão é o achado:** o bash é o mais rápido no caminho curto (2 spawns de jq)
e o **mais lento** no caminho longo, porque spawna **11 subprocessos** (4 jq, 3 awk,
2 basename, 2 cat — contado com `bash -x | grep -c`). Cada `$(...)` é um fork.

## Outros números medidos

- **Perl é o mais barato dos runtimes**: `redact-secrets.pl` completo = **6.2 ms**;
  `perl -e ''` = 3.0 ms. Portá-lo para TS/Python custaria 3-4x mais startup.
- `ai-log-prompt.sh` completo (UserPromptSubmit, inclui o Perl) = **26.6 ms**.
- Transpile de `.ts` inédito custa só ~2 ms (deno) / ~1 ms (bun) — o cache não é o
  gargalo. O que custa é o **primeiro spawn após ociosidade**: 208 ms (deno) /
  128 ms (bun), coerente com paginar binários de 79 MB / 60 MB
  (bash 1.2 MB + jq 1.4 MB + perl 0.1 MB).
- `node` rodando `.ts` nativo: 89 ms (A) — type-stripping caro, pior opção.

## Contexto de magnitude

O `timeout` configurado nos hooks do projeto é **5 s**; o default de `command` hook é
**10 min** (30 s para UserPromptSubmit). Toda a diferença entre linguagens cabe em
±15 ms — três ordens de grandeza abaixo do orçamento. **Performance não é argumento
decisório aqui**, em nenhuma direção.
