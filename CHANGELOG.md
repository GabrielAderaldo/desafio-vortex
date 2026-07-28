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

- **Upstream do produto** em `docs/discovery/` — cerimônias 1 a 4 do Lean UX: problem
  statement, 18 suposições declaradas e graduadas por evidência, priorização de risco e
  proto-personas. O problema foi enquadrado como **o gesto sem resposta**: quem entrega
  material no campus nunca descobre se ele serviu.
- Pesquisa com pessoas reais (4 entrevistas estruturadas), com o instrumento, as
  respostas brutas e a síntese versionados — incluindo os defeitos do próprio
  instrumento e as limitações da amostra.
- Cerimônias 5 a 8: outcomes, cinco hipóteses no formato de quatro campos, corte de
  escopo e story map com as quatro fatias que virarão tickets da pipeline.
- **Matriz de rastreabilidade dos requisitos** do edital — cada exigência obrigatória
  citada literalmente, mapeada para onde é atendida, com o estado atual.

### Modificado

- **README preenchido** — nome do projeto, proposta ancorada no problema real do campus,
  tecnologias com a justificativa de cada escolha, e o **Diário de Bordo da IA completo**:
  ferramentas, três prompts reais e a reflexão crítica com dois casos de erro. As seções
  que dependem de código executável ficaram marcadas com `PENDENTE`, porque comandos não
  são escritos antes de serem executados.

- Estrutura de documentação em `docs/handbook/` — ADR, RFC, Design Doc, PRD, Runbook
  e diagramas Mermaid, com templates baseados nas referências canônicas de cada formato.
- Diário de Bordo da IA em `docs/ai-log/`, com captura automática de prompts via hook
  `UserPromptSubmit` e redação de segredos.
- Guarda de imutabilidade dos ADRs (`PreToolUse`) e geração automática do índice de
  decisões (`PostToolUse`).
- Pipeline **W0→W3** com estado em front-matter e seis invariantes auditadas
  ([ADR-0002](docs/handbook/adr/ADR-0002-pipeline-w0-w3-e-sdd.md)), fundamentada em
  Kent Beck, Sam Newman e Gregory & Crispin.
- Suíte com 37 casos de teste dos hooks, validada por sabotagem, ligada ao
  `just check`.
- Formato WAR ROOM — quatro papéis com memória de projeto, para decisões com caminhos
  defensáveis concorrentes.
- Documentação offline de 5 ecossistemas (Claude, VS Code, Lean UX, stack candidata),
  populada por `just refs`.
- Edital do desafio transcrito em Typst, separando o texto oficial das anotações do
  candidato.
- Decisão de stack: **F# + SPA React + sessão por cookie `HttpOnly`**
  ([ADR-0003](docs/handbook/adr/ADR-0003-stack-fsharp-spa-e-sessao-por-cookie.md)).
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
