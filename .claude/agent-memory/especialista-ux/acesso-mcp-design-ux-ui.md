---
name: acesso-mcp-design-ux-ui
description: Como alcançar o MCP acdg-skills (domínio design-ux-ui) quando as tools MCP não estão expostas ao subagente — cliente curl JSON-RPC
metadata:
  type: reference
---

O MCP `acdg-skills` é HTTP remoto (`https://mcp-server.tailf5e6ca.ts.net:8443/acdg-skills/mcp`,
registrado em `~/.claude.json`). **Subagentes deste time não recebem as tools
`mcp__acdg-skills__*`** — só o agente principal. Sem elas, a regra "nada de UX de memória"
fica impossível de cumprir.

Saída: falar JSON-RPC direto por `curl`. Sequência que funciona (verificada em 2026-07-28):

1. `POST` com `method: "initialize"`, header `Accept: application/json, text/event-stream`
   → o `mcp-session-id` volta no header da resposta
2. `POST` `notifications/initialized` com o header `mcp-session-id`
3. `POST` `tools/call` com `skills_buscar` / `skills_citar`

O domínio `design-ux-ui` **não está no enum de `dominio`** — use
`arquivo: "shared-references/design-ux-ui/<nome>.md"` ou `todos: true`.

Os cinco arquivos: `nao-me-faca-pensar--krug.md` · `design-centrado-no-usuario--lowdermilk.md` ·
`estrategias-de-ux--levy.md` · `articulando-decisoes-de-design--greever.md` ·
`arquitetura-da-informacao-e-ux--tamosauskas.md`.

`skills_citar` aceita `verificarTerms` e devolve `GROUNDING OK` ou `PARCIAL` — **use sempre**,
é o que separa citação verificada de alucinação. Ver [[fontes-ux-ja-citadas]].
