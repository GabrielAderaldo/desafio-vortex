---
name: mcp-acdg-skills-por-http
description: Como alcançar o MCP acdg-skills quando as ferramentas mcp__acdg-skills__* não estão expostas no contexto do subagente
metadata:
  type: reference
---

O MCP `acdg-skills` é servidor **HTTP** (`type: "http"`, configurado em `~/.claude.json`
como servidor global, não no `.mcp.json` do projeto). Em contextos de subagente as
ferramentas `mcp__acdg-skills__*` podem não estar expostas, e `ToolSearch` também não.

**Saída:** falar JSON-RPC direto com o endpoint por HTTP. `initialize` devolve o
`mcp-session-id` no header; as chamadas seguintes levam esse header e
`Accept: application/json, text/event-stream`. Ferramentas: `skills_buscar`,
`skills_citar`, `skills_cross_ref`.

**Why:** a regra deste papel é que afirmação sobre DDD sem citação é opinião. Sem acesso ao
MCP, ou eu cito de memória (proibido) ou entrego o trabalho rotulado como `inferido`
inteiro. O caminho HTTP resolve sem violar nada.

**How to apply:** escrever um cliente mínimo em Python no scratchpad da sessão e chamá-lo
por Bash. `skills_citar` devolve **página e autor**, que é o que a legenda dos diagramas
exige. Use `verificarTerms` para detectar citação alucinada — ele confirma quais termos
aparecem no bloco extraído.

Detalhe útil: o índice é por seção (`\section*{...}`), então o match aponta para o começo
do bloco, não para a frase. Quando a definição procurada não aparece no preview mas o
`grounding` é alto, varra as linhas vizinhas com `skills_citar` e `contexto: 12`.
