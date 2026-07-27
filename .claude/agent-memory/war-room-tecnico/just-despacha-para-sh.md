---
name: just-despacha-para-sh
description: just roda TODA linha de receita via `sh -cu` — política de "sem shell script" é incoerente com o ADR-0001
metadata:
  type: project
---

**Verificado** (2026-07-26, just 1.57.0): receitas sem shebang são executadas por
`sh -cu`. Teste provou glob (`*.ts`), pipe (`| tr`) e `$( )` todos ativos, com
`$0 = sh` e processo pai `just`. O setting `shell` do Justfile está `null` (padrão).

Ou seja: `adr-index`, `adr-check`, `check`, `ci` — todas passam por shell hoje.
Só `refs-vscode` e `refs-claude` têm shebang bash explícito (18 e 34 linhas de corpo).

**Why:** o ADR-0001 (status `aceito`, imutável) adotou `just` como task runner único.
`just` é, por construção, um despachante de shell. Uma regra "sem shell script no
projeto" contradiz uma decisão fechada sem passar pelo protocolo de supersessão.

**How to apply:** se alguém propuser política anti-shell, exigir que ela seja escrita
como **escopo**, não como proibição — ex.: "sem lógica de decisão em `.sh` standalone;
receitas do Justfile continuam sendo shell de invocação". Uma proibição literal exigiria
ADR novo substituindo o 0001. Ver [[hooks-falham-abertos]].
