---
name: ferramental-e-armadilhas
description: Como medir e testar neste ambiente — o que não existe no macOS, como evitar viés de benchmark, como testar hooks de verdade sem sujar o projeto
metadata:
  type: reference
---

# Ferramental de investigação neste ambiente

## Não existe nesta máquina (erros que já cometi)

- **`timeout`** — não existe no macOS (é `gtimeout`, do coreutils, não instalado).
  `timeout 180 claude ...` retorna **rc=127** e o teste falha silenciosamente.
- **`hyperfine`** — não instalado. Usar harness em Python com `time.perf_counter()`.
- `date +%N` não funciona no `date` do BSD.

## Como medir sem viés

Medir com `t0=$(python3 -c ...)` em volta do comando **inclui o spawn do próprio
python3** e polui o resultado (mediu 43 ms para o Deno onde o valor real era 24 ms).
Medir **de dentro** de um único processo Python, com `subprocess.run`, e comparar só
valores relativos.

Rodadas sequenciais por implementação sofrem viés térmico — a 1ª rodada deu bash 13 ms
e a 2ª deu 25 ms para o mesmo comando. **Intercalar a ordem** (embaralhar as impls a
cada rodada) estabilizou tudo: desvio caiu para <1 ms.

Sempre incluir `/usr/bin/true` como baseline de fork/exec puro (~1.8 ms aqui) para
separar custo de runtime de custo de processo.

## Testar hook de verdade (sem tocar no projeto)

Receita que funcionou (Claude Code 2.1.220):

1. Projeto isolado no scratchpad com `.claude/settings.json` próprio.
2. `claude -p "<prompt>" --debug-file <path> --permission-mode acceptEdits`
3. O hook escreve num arquivo de prova (`prova.log`) **e** devolve JSON com um marcador
   único; conferir os dois — o arquivo prova que executou, o marcador prova que o
   Claude Code consumiu a saída.

`--debug hooks` **não** escreve em stderr de forma capturável com `2>`; usar
`--debug-file <path>`. `PermissionRequest` não dispara com `-p` (documentado); usar
`PreToolUse` para testar decisão de permissão.

## Onde estão os artefatos

`scratchpad/bench-hooks/` — `bench2.py` (harness bom), `adr-guard.ts`, `adr_guard.py`
(ports validados), payloads dos 3 cenários. `scratchpad/projeto-teste-hook/` — projeto
de prova dos hooks não-shell.

## Doc offline

`docs/handbook/offline-reference/claude-code/_full.txt` (6.4 MB). Hooks reference
começa na **linha 65429**; tabela de campos de command hook em **65777**; exec/shell
form em **65787**; segurança em **68505**; limites/timeouts em **23005**.
