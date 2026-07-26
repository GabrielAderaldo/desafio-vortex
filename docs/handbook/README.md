# Handbook

Documentação de engenharia deste projeto. Cada tipo de documento responde a uma
pergunta diferente — a confusão mais comum é escrever um ADR quando o caso pedia
um Design Doc, ou um Design Doc quando bastava um ADR.

## Qual documento usar

| Tipo | Responde | Quando se escreve | Muda depois? |
|------|----------|-------------------|--------------|
| [PRD](prd/) | **O quê** e **para quem** | Antes de desenhar solução | Vira baseline; mudança é nova versão |
| [RFC](rfc/) | **Proposta aberta a debate** | Quando há mais de um caminho e a escolha não é óbvia | Vive enquanto está em discussão; termina em decisão |
| [Design Doc](design-docs/) | **Como** vai ser construído | Depois do "o quê", antes de codar | Acompanha o design enquanto ele vive |
| [ADR](adr/) | **Por que** escolhemos X em vez de Y | No momento exato da decisão | **Nunca.** É imutável — ver regra abaixo |
| [Runbook](runbooks/) | **O que fazer** quando quebra | Depois que existe algo em operação | Vive e é corrigido a cada incidente |
| [Diagramas](diagrams/) | **Como se encaixa** visualmente | Junto do documento que ele ilustra | Acompanha o que representa |
| [CHANGELOG](../../CHANGELOG.md) | **O que mudou** para quem usa | A cada release | Append-only |

### A regra de ouro do ADR

**Um ADR fechado nunca é editado nem apagado.** Não é convenção de estilo, é
requisito estrutural — o resto desta seção explica por quê.

Quando uma decisão muda, o protocolo é sempre o mesmo:

1. Escreve-se um **ADR novo**, com número novo, `status: aceito`.
2. No novo, `substitui: [ADR-000X]`.
3. No antigo, altera-se **exclusivamente** dois campos: `status: substituido` e
   `substituido_por: ADR-000Y`.
4. O texto do antigo permanece intacto — inclusive as partes que o tempo provou erradas.

A única edição permitida num ADR fechado é a do seu `status` e do `substituido_por`.
Nada mais. Nem correção de digitação, nem "melhorar a redação", nem apagar um que
"não vale mais".

### Por que a imutabilidade é obrigatória

Um ADR não registra o que é verdade hoje. Registra **o que se sabia, o que se temia e
o que se decidiu naquele momento**. Editar retroativamente apaga exatamente a parte
que tem valor.

Um histórico intacto de decisões é a base de coisas que um repositório comum não
oferece:

| O que se torna possível | Como |
|--------------------------|------|
| **Memória durável** | A decisão e seu motivo sobrevivem à sessão, ao contexto e à troca de ferramenta |
| **Convenções recuperáveis** | "Por que codificamos assim aqui?" tem resposta com data e autor, não folclore |
| **Rastreio de causa** | Um bug numa área remete às decisões que a moldaram, com o raciocínio anexo |
| **Análise pré-mudança** | Antes de alterar algo, dá para ler o que já foi tentado e por que foi descartado |
| **Trilha de auditoria** | A cadeia `substitui` → `substituido_por` reconstrói a evolução completa do projeto |
| **RAG e vetorização** | Documentos estáveis, com front-matter de metadados, são indexáveis sem reprocessamento a cada mudança |

Esse último ponto depende dos anteriores: um corpus **mutável** é um corpus que
precisa ser reindexado, cujos embeddings apontam para texto que já não existe, e cuja
procedência não pode ser verificada. Imutabilidade é o que faz o handbook servir tanto
para quem lê quanto para uma máquina que o consulta.

Por isso todo ADR carrega front-matter YAML — `tags`, `componentes`, `substitui`,
`substituido_por`, `ai_log`. Ver `adr/_TEMPLATE.md` para o contrato completo dos campos.

### A regra é imposta pelo harness, não pela boa vontade

Duas automações sustentam o que está escrito acima:

**1. Guarda de imutabilidade** — `.claude/hooks/adr-guard.sh`

Hook `PreToolUse` que **bloqueia** qualquer escrita em `ADR-*.md` cujo `status` seja
fechado. Não depende de ninguém lembrar da regra: a ferramenta recusa a edição e
explica o protocolo de supersessão.

O que ele deixa passar, de propósito:

| Situação | Resultado |
|----------|-----------|
| Editar o corpo de um ADR fechado | 🚫 bloqueado |
| Sobrescrever um ADR fechado com `Write` | 🚫 bloqueado |
| Alterar **só** `status:` e `substituido_por:` | ✅ permitido — é a transição de supersessão |
| Editar um ADR `proposto` | ✅ permitido — ainda está em aberto |
| Criar um ADR novo | ✅ permitido |
| Editar o `_TEMPLATE.md` | ✅ permitido — não é um ADR |

**2. Índice automático** — `scripts/adr-index.py`

Gera `adr/INDEX.md` a partir dos front-matters: decisões em vigor, histórico completo,
grafo Mermaid de supersessão e índices por componente e por tag. Um hook `PostToolUse`
o regenera sozinho a cada ADR escrito — o índice nunca precisa de manutenção manual.

```bash
python3 scripts/adr-index.py           # regenera
python3 scripts/adr-index.py --check   # exit 1 se desatualizado (útil em CI)
```

Ele também **audita os elos**: ADR que diz substituir outro sem reciprocidade, `id`
duplicado, `substituido_por` apontando para ADR inexistente, status inválido. Tudo
sai numa seção de inconsistências no próprio índice — exatamente o tipo de erro que um
índice mantido à mão esconderia.

## Convenção de nomes

```
adr/ADR-0001-titulo-em-kebab-case.md
rfc/RFC-0001-titulo-em-kebab-case.md
design-docs/DD-0001-titulo-em-kebab-case.md
prd/PRD-0001-titulo-em-kebab-case.md
runbooks/RB-nome-do-procedimento.md
diagrams/DIA-nome-do-diagrama.md
```

Numeração sequencial, com zero à esquerda, **nunca reaproveitada**. Se um ADR for
rejeitado, o número morre com ele.

## O que sobe pro Git e o que não sobe

Todas as pastas existem no repositório. Duas têm o conteúdo ignorado e são mantidas
por um `.gitkeep`:

| Pasta | Versionada? | Por quê |
|-------|-------------|---------|
| `adr/` `rfc/` `design-docs/` `prd/` `runbooks/` `diagrams/` | ✅ Sim | São o registro de engenharia — é o que se quer ler daqui a seis meses |
| `offline-reference/` | ❌ Conteúdo ignorado | Documentação de terceiros: pesada, com licença alheia, e polui todo `git diff`. O `README.md` de lá diz como repopular |
| `_drafts/` | ❌ Conteúdo ignorado | Rascunho é pensamento em voz alta. Sobe quando vira documento, não antes |

## Dose recomendada

Este projeto tem prazo. Documentação existe para reduzir retrabalho, não para
provar esforço — um handbook inflado com ADR de escolha de linter custa tempo e não
informa ninguém.

Regra prática: **escreva um ADR quando a decisão for cara de reverter.** Escolha de
banco, estratégia de sincronização offline, modelo de autenticação — sim. Nome de
variável de ambiente, versão de `prettier` — não.

## Referências de cada formato

- **ADR** — [adr.github.io](https://adr.github.io/) · [artigo original de Michael Nygard (2011)](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- **RFC** — [RFCs do Rust](https://github.com/rust-lang/rfcs) · [Scaling Engineering Teams via Writing Things Down](https://blog.pragmaticengineer.com/scaling-engineering-teams-via-writing-things-down-rfcs/)
- **Design Doc** — [Design Docs at Google, por Malte Ubl](https://www.industrialempathy.com/posts/design-docs-at-google/)
- **PRD** — [Guia de requisitos ágeis da Atlassian (pt-BR)](https://www.atlassian.com/br/agile/product-management/requirements) · [Templates do Lenny's Newsletter](https://www.lennysnewsletter.com/p/my-favorite-product-management-templates)
- **Runbook** — [Runbooks públicos do GitLab SRE](https://gitlab.com/gitlab-com/runbooks) · [PagerDuty Incident Response](https://response.pagerduty.com/)
- **CHANGELOG** — [Keep a Changelog 1.1.0 (pt-BR)](https://keepachangelog.com/pt-BR/1.1.0/)
- **Diagramas** — [Mermaid.js](https://mermaid.js.org/)

## Relação com o Diário de Bordo

O [`docs/ai-log/`](../ai-log/) é vizinho, não filho, deste handbook. A diferença:

- **Handbook** — o que foi decidido e como o sistema funciona.
- **Diário de Bordo** — como a IA participou de chegar lá.

Um ADR pode citar um episódio (`ver EP-003`) quando a decisão nasceu de uma sessão
com IA. É justamente o cruzamento que torna o registro verificável.
