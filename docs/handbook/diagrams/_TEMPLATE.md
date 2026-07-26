# DIA-<nome-do-diagrama>

- **Representa:** <que parte do sistema>
- **Data:** AAAA-MM-DD
- **Relacionado:** <DD-000X, ADR-000X, PRD-000X>

> Diagramas em [Mermaid](https://mermaid.js.org/) renderizam nativamente no GitHub,
> vivem em texto e aparecem no `git diff` — que é a razão de não usar imagem exportada
> aqui. Um PNG desatualizado mente em silêncio; um bloco Mermaid errado dá para revisar
> em code review.

## Contexto

Uma ou duas frases: o que este diagrama mostra e por que ele existe. Diagrama sem
legenda é enigma.

## Diagrama

```mermaid
flowchart LR
  A[Componente] --> B[Componente]
```

## Notas

O que o diagrama **não** mostra. Toda representação omite algo — dizer o que foi
omitido de propósito evita conclusão errada de quem só olha a figura.

---

## Formas úteis para este projeto

### Fluxo de decisão

```mermaid
flowchart TD
  A[Início] --> B{Condição?}
  B -- Sim --> C[Caminho A]
  B -- Não --> D[Caminho B]
```

### Sequência — ideal para autenticação e sincronização

```mermaid
sequenceDiagram
  autonumber
  participant U as Usuário
  participant C as Cliente
  participant S as Servidor
  U->>C: Ação
  C->>S: Requisição
  S-->>C: Resposta
  Note over C: Estado local atualizado
```

### Máquina de estados — ideal para fila offline

```mermaid
stateDiagram-v2
  [*] --> Rascunho
  Rascunho --> NaFila: usuário salva
  NaFila --> Enviando: conexão volta
  Enviando --> Sincronizado: 2xx
  Enviando --> Conflito: 409
  Conflito --> NaFila: resolvido
  Sincronizado --> [*]
```

### Entidade-relacionamento

```mermaid
erDiagram
  USUARIO ||--o{ REGISTRO : cria
  REGISTRO }o--|| CATEGORIA : pertence
```

### Cronograma

```mermaid
gantt
  dateFormat YYYY-MM-DD
  title Marcos
  section Backend
  Modelagem :a1, 2026-07-27, 3d
  API       :after a1, 5d
```

> **Dica de revisão:** se o diagrama não cabe numa tela sem rolagem, ele está tentando
> explicar duas coisas. Divida em dois.
