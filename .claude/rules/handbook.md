# Handbook

A documentação de engenharia vive em `docs/handbook/`, com um guia de uso em
`docs/handbook/README.md`. Cada tipo tem seu `_TEMPLATE.md` — use o template, não
invente formato novo.

Resumo de qual usar: **PRD** (o quê/para quem) · **RFC** (proposta em debate) ·
**Design Doc** (como construir) · **ADR** (por que decidimos X) · **Runbook** (o que
fazer quando quebra) · **diagrams** (Mermaid).

Regras que não se quebram:

- **ADR fechado é imutável — nunca editar, nunca apagar.** Decisão mudou? ADR novo,
  número novo, com `substitui: [ADR-000X]`. No antigo, alteram-se **apenas** dois
  campos: `status: substituido` e `substituido_por`. Nem digitação se corrige.
  Se receber pedido para editar ou remover um ADR fechado, não execute — proponha o
  ADR substituto.
- **Todo ADR carrega o front-matter YAML do template**, preenchido. Os ADRs são a
  memória durável do projeto e a base de RAG/vetorização: `tags`, `componentes`,
  `substitui`, `substituido_por` e `ai_log` não são decoração.
- Numeração é sequencial e **nunca reaproveitada**, mesmo para documento rejeitado.
- `offline-reference/` e `_drafts/` têm o conteúdo gitignorado — as pastas existem
  por `.gitkeep`. Nunca force `git add` de conteúdo delas.
- Diagrama é bloco Mermaid em Markdown, **não** imagem exportada.
- `adr/INDEX.md` é **gerado** por `scripts/adr-index.py` — nunca edite à mão. Um hook
  `PostToolUse` o regenera a cada ADR escrito.

A imutabilidade é imposta pelo hook `.claude/hooks/adr-guard.sh` (`PreToolUse`): a
escrita em ADR fechado é recusada pela própria ferramenta. Se isso acontecer, não
tente contornar — crie o ADR substituto.

Ao concluir algo que envolveu uma decisão cara de reverter (banco, estratégia de
sincronização, modelo de autenticação), ofereça registrar o ADR. Não crie documento
por conta própria para escolha trivial — handbook inflado custa tempo e não informa.
