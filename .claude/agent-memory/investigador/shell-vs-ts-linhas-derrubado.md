---
name: shell-vs-ts-linhas-derrubado
description: SUPOSIÇÃO DERRUBADA — portar bash para TS/Python não reduz linhas; aumenta 32%/46%. Medido portando o adr-guard.sh inteiro.
metadata:
  type: reference
---

# Derrubado: "TypeScript deixaria os scripts menores"

**Falso, medido em 2026-07-26.** Portei o `adr-guard.sh` inteiro para TS e Python
(`scratchpad/bench-hooks/adr-guard.ts` e `adr_guard.py`), preservando comportamento —
validado nos 3 cenários (early-exit, deny, supersessão permitida): mesma decisão,
saída byte-compatível em tamanho (637 B).

| impl | total | **linhas de código** | comentário |
|---|---|---|---|
| `adr-guard.sh` | 92 | **59** | 17 |
| `adr-guard.ts` | 98 | **78** (+32%) | 7 |
| `adr_guard.py` | 103 | **86** (+46%) | 1 |

Contagem: `wc -l` menos linhas vazias menos linhas iniciando com `#`//`//`.

## Por que

O bash terceiriza trabalho para `jq`/`awk`/`case`, que são densos por natureza. Em TS
e Python você escreve explicitamente o parse de front-matter, o guard de JSON inválido
e a serialização.

**O argumento honesto pró-migração não é volume, é legibilidade pontual.** O pior
trecho do bash é o quoting aninhado do awk dentro da função `campo_fm`:

    gsub(/[[:space:]"'"'"']/, "")

Isso é `'` escapado dentro de aspas simples dentro de um programa awk dentro de bash.
O equivalente em TS é `.replace(/[\s"']/g, "")`. Uma linha, quatro camadas de quoting
a menos. É esse tipo de coisa que justifica migração — não contagem de linhas.
