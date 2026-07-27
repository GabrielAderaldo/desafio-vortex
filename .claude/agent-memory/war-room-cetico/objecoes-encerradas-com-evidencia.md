---
name: objecoes-encerradas-com-evidencia
description: Pontos do war room "banir .sh" já resolvidos com evidência executada — não reabrir sem fato novo
metadata:
  type: project
---

Round de 2026-07-26 ("banir o `.sh` do projeto, usar Justfile?"). Estes pontos foram
fechados com comando rodado, não com opinião. **Não reabrir sem fato novo.**

**Encerrados a favor do bash / contra a migração:**
- `/usr/bin/jq` é da Apple (`com.apple.jq`, assinado, universal). jq **não** é dependência
  externa no macOS. Reproduzido com `codesign -dv`.
- Hooks do Claude Code aceitam qualquer executável — não há restrição de linguagem.
- Portar `adr-guard` não encurta o código (bash 59 → TS 78 → Python 86 linhas).
- `just` despacha toda receita via `sh -cu`. Confirmado com `ps -o command= -p $$` dentro
  de uma receita.

**Encerrados contra o bash / a favor de mexer:**
- `adr-guard.sh` **falha aberta**: sempre `exit 0` e decide via stdout. Docs do Claude Code
  (`offline-reference/claude-code/_full.txt:3972`) dizem que quando o JSON de stdout falha
  validação de schema, só `exit 2` bloqueia. Reproduzido: nome com aspas → JSON inválido.
- `ai-log-prompt.sh` grava entrada com cabeçalho e fence **vazio** se o redactor sair com
  código ≠ 0/9 — perda de dado que *parece* sucesso. Reproduzido com stub `exit 3`.

Ver [[premissas-derrubadas-round-shell]] para o que caiu.
