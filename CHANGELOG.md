# Changelog

Todas as mudanças relevantes deste projeto são documentadas neste arquivo.

O formato é baseado em [Keep a Changelog 1.1.0](https://keepachangelog.com/pt-BR/1.1.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

> **Escreva para humanos, não para máquinas.** Um dump de `git log` não é changelog:
> commits são para quem mantém o código, changelog é para quem usa o resultado.
>
> Tipos válidos de entrada: `Adicionado`, `Modificado`, `Descontinuado`, `Removido`,
> `Corrigido`, `Segurança`.

## [Não publicado]

### Adicionado

- Estrutura de documentação em `docs/handbook/` — ADR, RFC, Design Doc, PRD, Runbook
  e diagramas Mermaid, com templates baseados nas referências canônicas de cada formato.
- Diário de Bordo da IA em `docs/ai-log/`, com captura automática de prompts via hook
  `UserPromptSubmit` e redação de segredos.
- Guarda de imutabilidade dos ADRs (`PreToolUse`) e geração automática do índice de
  decisões (`PostToolUse`).
- `Justfile` como ponto único de entrada das tarefas do repositório, com a receita
  `just check` servindo de portão de verificação ([ADR-0001](docs/handbook/adr/ADR-0001-adotar-just-como-task-runner.md)).

---

<!--
Formato de uma versão publicada:

## [1.0.0] - 2026-08-10

### Adicionado
- Nova funcionalidade visível para quem usa.

### Corrigido
- Bug que afetava o usuário, descrito pelo sintoma e não pela causa no código.

[1.0.0]: https://github.com/GabrielAderaldo/<repo>/releases/tag/v1.0.0
-->
