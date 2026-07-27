---
name: produto-hipoteses-abertas
description: Hipóteses de produto levantadas em war rooms deste repo, com o sinal que as confirma ou refuta — consultar antes de reabrir o mesmo debate
metadata:
  type: project
---

Hipóteses no formato Lean UX cap. 3 levantadas em WAR ROOM. Cada uma traz o sinal
observável. **Ao reabrir o assunto, cheque primeiro se o sinal já apareceu.**

## 2026-07-26 — Linguagem dos scripts do harness (`.claude/hooks/*`, statusline)

Contexto do round: 3 arquivos `.sh` / 213 linhas, todos com contrato stdin-JSON →
stdout-JSON do Claude Code. Repo com **zero código de aplicação** na data. Runtime da
aplicação ainda não decidido.

- **H1 (teste de fumaça do harness)** — instrumentar cada script com fixture de entrada
  e saída esperada, *independente da linguagem*.
  Sinal: quebrar um hook de propósito faz `just check` falhar; e ao fim dos 15 dias
  `.ai-log/raw-prompts.md` não tem buraco de dias.
- **H2 (migrar os scripts para a linguagem da aplicação)** — só depois do runtime
  decidido.
  Sinal de verdade: o Gabriel altera um hook sozinho quando o protocolo mudar.
  **Sinal de refutação: se em 15 dias nenhum hook precisar de alteração, o custo de
  leitura que a migração pagaria nunca chegou.**
- **H3 (política "sem shell" vira regra com limite verificável)** — em vez de banimento.
  Sinal: nenhum arquivo do repo viola a regra publicada. Banimento total **já nasceria
  violado** pelas receitas `refs-vscode`/`refs-claude` do `Justfile` e pelo one-liner
  shell inline em `.claude/settings.json` (PostToolUse).

**Why:** o risco central do round era resolver com elegância a preferência do Gabriel
por linguagem, quando a dor verificável é outra — hook que falha **em silêncio** (todo
caminho de erro dos scripts termina em `exit 0` sem aviso), e a matéria-prima do diário
some sem ninguém notar.

**How to apply:** se alguém propuser de novo migrar/banir shell, peça primeiro o sinal
de H2. Ver [[projeto-quem-e-o-usuario]] antes de argumentar com "o avaliador".
