---
name: superficie-de-shell-do-projeto
description: Onde o shell vive de fato neste repo — não são só os 3 .sh; há shell inline no settings.json e nas receitas do Justfile
metadata:
  type: project
---

# A superfície de shell não são 3 arquivos

**Verificado em 2026-07-26.** Quem discutir "política sem shell" precisa contar isto,
não só os `.sh`:

| local | linhas | natureza |
|---|---|---|
| `.claude/statusline.sh` | 55 | bash |
| `.claude/hooks/adr-guard.sh` | 92 | bash + jq + awk |
| `.claude/hooks/ai-log-prompt.sh` | 66 | bash + jq + grep, chama o Perl |
| **`.claude/settings.json` → `PostToolUse`** | 1 linha densa | **shell INLINE** (`$(jq ...)` + `case` + `python3`), sem arquivo |
| **`Justfile`** (2 receitas) | — | `#!/usr/bin/env bash` embutido |
| `.claude/hooks/redact-secrets.pl` | 80 | **Perl, não shell** |
| `scripts/adr-index.py`, `split-lean-ux.py` | 267 + 120 | **Python já em produção no repo** |

**Why:** o pedido do war room falava em "213 linhas de bash" (55+92+66 = confere), mas
uma política "sem shell" que só olhasse os `.sh` deixaria passar o pior pedaço — o
one-liner do `PostToolUse`, que é shell sem arquivo, sem teste e sem revisão.

**How to apply:** ao discutir migração ou política, sempre incluir o `settings.json` e
o `Justfile` no escopo. E lembrar que o repo **já é poliglota** (bash + Perl + Python):
"adotar TypeScript" adicionaria uma 4ª linguagem, não substituiria uma.

Ver [[perl-redactor-fora-do-alcance]] e [[shell-vs-ts-linhas-derrubado]].
