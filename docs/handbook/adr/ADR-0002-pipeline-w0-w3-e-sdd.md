---
id: ADR-0002
titulo: Adotar a pipeline W0→W3 e o SDD como processo de engenharia
status: aceito
data: 2026-07-27
decisores: [Gabriel Aderaldo]
tags: [processo, tdd, bdd, pipeline, auditoria, qualidade]
componentes: [repo, processo]
substitui: []
substituido_por: null
relacionados: [ADR-0001, RFC-0003]
ai_log: []
---

# ADR-0002 — Adotar a pipeline W0→W3 e o SDD como processo de engenharia

## Contexto

Este projeto será desenvolvido majoritariamente com assistência de IA, e o Diário de
Bordo já registra quatro episódios em que trabalho aparentemente pronto continha
defeito — incluindo um portão de integridade declarado testado três vezes que podia
ser furado com dois comandos normais ([EP-004](../../ai-log/EP-004-o-portao-que-nao-fechava.md)).

A lição desses episódios é consistente: **"parece pronto" não é sinal confiável.** O
que separa trabalho verificado de trabalho plausível é a existência de um portão
mecânico que o autor não controla.

O processo aqui adotado — pipeline **W0→W3** — foi desenvolvido empiricamente pelo
autor ao longo de projetos anteriores, e opera hoje em produção num monorepo com 453
tickets fechados e taxa de rejeição em revisão de 2,5%. Este ADR o formaliza neste
repositório em escala proporcional, e registra a fundamentação teórica que ele havia
alcançado por tentativa e erro.

## Decisão

Adotamos duas camadas de processo:

1. **Pipeline W0→W3** — toda mudança auditável percorre quatro estágios em ordem:
   **W0 RED** (testes que falham) → **W1 GREEN** (implementação mínima) →
   **W2 REVIEW** (auditoria read-only) → **W3 QUALITY** (portão verde).
2. **SDD** — trabalho que nasce de decisão de produto ou domínio passa antes por
   especificação, em escala de feature. Baseado no [GitHub Spec Kit](https://github.com/github/spec-kit),
   adaptado.

O estado de cada ticket vive em **Markdown com front-matter YAML**, versionado, em
`docs/pipeline/` — mesmo mecanismo já usado pelos ADRs, com índice gerado e transições
validadas por hook.

## Fundamentação canônica

### W0 e W1 — o ciclo do TDD

> "Mas como obtemos código limpo que funciona? Muitas forças nos desviam de código
> limpo, ou mesmo de código que funciona. Sem pedir conselhos aos nossos medos, aqui
> está o que fazemos: conduzimos o desenvolvimento com testes automatizados, um estilo
> de desenvolvimento chamado Desenvolvimento Guiado por Testes (TDD). No Desenvolvimento
> Guiado por Testes,
> - **Escrevemos código novo apenas se um teste automatizado falhou**
> - Eliminamos duplicação"
>
> — *(Linha 84, p. 3, Kent Beck, TDD: Desenvolvimento Guiado por Testes)*

A separação entre W0 e W1 é a materialização literal dessa regra: W0 **não pode**
escrever código de produção, e W1 só existe porque W0 falhou.

### A esteira em estágios — fail-first

> "Very early on in doing CI, my then-colleagues at Thoughtworks and I realized the
> value in sometimes having multiple stages inside a build. (…) If we run all the tests
> together, and if we're waiting for our large-scoped slow tests to finish, we may not
> be able to get fast feedback when our fast tests fail. **And if the fast tests fail,
> there probably isn't much sense in running the slower tests anyway!** A solution to
> this problem is to have different stages in our build, creating what is known as a
> build pipeline. (…) This build pipeline concept gives us a nice way of tracking the
> progress of our software as it clears each stage, helping give us insight into the
> quality of our software."
>
> — *(Linha 3291, p. 244, Sam Newman, Building Microservices)*

É a justificativa formal da ordem das waves e da parada no primeiro vermelho. Newman
também registra que **estágios manuais são legítimos** dentro de uma pipeline — o que
fundamenta os gates humanos do SDD.

### BDD como origem dos testes de W0

> "The idea of using examples to guide development of features and stories has been
> used by many teams for years. We see it as a tried-and-true, valuable approach. (…)
> Concrete examples of desired and undesired system behavior help teams build a shared
> understanding of each feature and story."
>
> — *(Linha 720, Janet Gregory e Lisa Crispin, Agile Testing Condensed)*

Os critérios de aceite do ticket são escritos como exemplos concretos, e é deles que
os testes de W0 derivam — não da leitura do código.

### Linhagens reconhecidas, sem citação no corpus local

Registradas por honestidade; não foram verificadas contra fonte primária aqui:

- **Inspeção formal de código** (Michael Fagan, IBM, 1976) — origem do code review como
  etapa distinta da escrita, o que fundamenta W2 ser **read-only**.
- **Jidoka / "parar a linha"** (Toyota Production System; trazido ao software por Mary
  e Tom Poppendieck, *Lean Software Development*, 2003) — fundamenta a política de
  regressão zero.
- **Specification by Example** (Gojko Adzic, 2011) — citado na bibliografia de
  *Gerenciamento de Requisitos* (linha 2546) do corpus, sem texto primário disponível.

## Consequências

### Positivas

- O portão deixa de depender de julgamento: W1 só começa se W0 provou vermelho, e o
  ticket só fecha com as quatro waves cumpridas.
- Cada mudança tem rastro auditável em Markdown versionado — legível por quem clona o
  repositório, sem instalar ferramenta alguma.
- Os testes nascem dos critérios de aceite, não da implementação, o que reduz o teste
  escrito para passar no código que já existe.
- O processo é o mesmo para trabalho humano e de IA. A auditoria não pergunta quem
  escreveu.

### Negativas

- **Custo por mudança sobe.** Um ajuste de três linhas passa a exigir ticket, quatro
  waves e relatórios. Em projeto sob prazo, isso é tempo real.
- Risco de o processo virar teatro: relatório escrito sem o comando ter rodado. A
  mitigação é exigir **saída literal colada** no relatório, nunca afirmação.
- Mais arquivos no repositório e mais um índice a manter atualizado.

### Neutras

- Introduz vocabulário próprio (wave, gate, round) que precisa ser aprendido.
- `docs/pipeline/` passa a existir ao lado de `docs/handbook/`, com propósitos
  distintos: handbook é **decisão**, pipeline é **execução**.

## Alternativas consideradas

| Alternativa | Por que não |
|-------------|-------------|
| **`STATE.json` + CLI de estado** (o que existe no core-api) | ~350 linhas de máquina de estado para manter, com duplicação entre o JSON canônico e o Markdown gerado. O autor testou em produção e não quis repetir aqui. |
| **[Backlog.md](https://github.com/MrLesk/Backlog.md)** (6,3k estrelas, MIT, MCP nativo) | Sério candidato. Descartado porque os status são fixos — To Do / In Progress / Done / Archived — e **não modelam W0→W3**, que é o núcleo do processo. Adotá-lo seria adaptar o processo à ferramenta. Suas ideias de *Definition of Done* e separação entre critérios de aceite e notas foram aproveitadas. |
| **[git-bug](https://github.com/git-bug/git-bug)** (10k estrelas) | Eliminado por armazenar issues como **objetos git, não arquivos** ("_not files!_"). Não é legível sem a ferramenta, não aparece em `grep` nem em diff — o oposto de memória auditável. |
| **GitHub Issues** | Depende de rede e de conta; o estado não vive no clone. |
| **Sem processo formal** | É o que produziu os quatro episódios do Diário de Bordo. |

## Implicações para o código

- **Passa a valer:** toda mudança auditável abre ticket em `docs/pipeline/` e percorre
  W0→W3. Critérios de aceite viram os testes de W0. Relatório de wave cola a **saída
  literal** do comando.
- **Deixa de valer:** implementar antes de existir teste falhando; declarar wave
  cumprida sem o relatório correspondente; fechar ticket com wave pendente.
- **Regressão zero:** qualquer vermelho que apareça na sessão é tratado como regressão
  a corrigir, tenha ou não sido causado pelo diff atual. Ver `.claude/rules/pipeline.md`.
- **Onde isso aparece:** `docs/pipeline/`, `docs/handbook/process/`,
  `.claude/rules/pipeline.md`, e o portão `just check`.
