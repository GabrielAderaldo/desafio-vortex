# CLAUDE.md — Desafio Vortex

Desafio técnico do **Laboratório Vortex**: monorepo com backend, frontend e PWA.
Docker e Compose são obrigatórios (Engine 29.x, Compose 5.x).

## Tarefas

Toda tarefa repetitiva do repositório é uma receita no `Justfile`. Use `just --list`
para descobrir o que existe — não invente comandos soltos nem os documente fora dali.

- `just check` é o **portão de verificação**: rode antes de considerar um trabalho
  pronto, e **mostre a saída** em vez de afirmar que passou.
- Ao escrever receita com `docker --format`, dobre **só a abertura** das chaves:
  `{{{{.Name}}`. É a colisão conhecida entre `just` e Go templates (ver ADR-0001).

## Como trabalhar aqui

- **Verifique antes de afirmar.** Rode o comando e mostre a saída. Se um teste falhar
  por erro seu de sintaxe ou payload, diga que foi erro do teste — não deixe passar
  como resultado.
- **Versões entram como número explícito**, nunca como "a mais recente". Conhecimento
  de modelo sobre versão tem prazo de validade (ver `docs/ai-log/EP-002`).
- **O harness é o Claude Code.** Não há GitHub Copilot neste projeto e não haverá;
  settings `github.copilot.*` não se aplicam.
- Documentação offline em `docs/handbook/offline-reference/` (gitignorada, populada
  por `just refs`). Prefira consultá-la a buscar na web — ela está na versão que o
  projeto usa. Arquivos `_full.txt` são grandes: use `grep` com âncora, nunca leia
  inteiros.

## Onde estão as regras

Este arquivo é carregado por inteiro em toda sessão, então fica curto de propósito.
As regras detalhadas vivem em `.claude/rules/`:

| Arquivo | Assunto |
|---------|---------|
| `handbook.md` | ADR/RFC/Design Doc/PRD/Runbook — e a imutabilidade dos ADRs |
| `diario-de-bordo.md` | Episódios de IA em `docs/ai-log/` |
| `segredos.md` | Convenção `[SECRET:NOME]` e `[NOLOG]` |

Regras com `paths:` no front-matter só carregam quando você toca arquivos que casam
com o glob — use isso ao criar regras de `apps/api/` ou `apps/web/`.
