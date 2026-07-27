# RFC-0003 — Board visual da pipeline (estilo Trello)

- **Status:** Adiado
- **Autor:** Gabriel Vieira Soriano Aderaldo
- **Data:** 2026-07-27
- **Discussão:** —
- **Resultado:** —

> **Placeholder deliberado.** Registrado no momento em que a ideia surgiu, para não se
> perder. Seções sem conteúdo verificado ficam vazias de propósito.

## Resumo

Renderizar os tickets de `docs/pipeline/` como um quadro visual de colunas — uma por
wave — em vez de apenas a tabela markdown do `INDEX.md`.

## Motivação

O `INDEX.md` responde *"qual é o estado de cada ticket"*, mas não dá a leitura
espacial que um board dá: quantos itens estão empilhados em W2, onde está o gargalo,
o que não se move há dias. Com poucos tickets a tabela basta; com muitos, não.

## O que já está pronto para isso

A decisão de guardar estado em front-matter (ADR-0002) já entrega o que um board
precisaria:

- `scripts/pipeline-index.py` **já parseia** todos os tickets e conhece status, waves,
  rounds e componentes.
- O status mapeia direto para colunas: `aberto → w0 → w1 → w2 → w3 → verde`.
- `rounds > 1` em W2 é exatamente o sinal de "item preso" que um board destaca.

Ou seja: o dado já existe estruturado. Falta só a renderização.

## Caminhos possíveis (nenhum avaliado a fundo)

| Caminho | Ideia |
|---------|-------|
| **HTML estático** | O script emite um `board.html` com colunas em CSS grid. Zero dependência, abre no navegador, versionável ou gitignorado |
| **Artifact publicado** | Página hospedada e compartilhável por link, útil se alguém além do autor precisar ver |
| **TUI no terminal** | Coerente com o fluxo ser CLI-first, mas é o de maior custo de manutenção |
| **Extensão do `INDEX.md`** | Mermaid não tem tipo "kanban" nativo estável; provavelmente insuficiente |

## Por que está adiado

Não há tickets ainda. Um board para zero itens é enfeite, e o `INDEX.md` cobre bem a
escala inicial. Construir antes de sentir a falta é o erro que o próprio processo tenta
evitar.

## Gatilho para reabrir

- **A tabela do `INDEX.md` deixar de caber numa tela** — na prática, algo entre 15 e 20
  tickets.
- Aparecer necessidade de mostrar progresso a alguém que não vai ler markdown.
- Surgir gargalo recorrente numa wave que a tabela não deixa evidente.

## Questões em aberto

- O board é **gerado** (derivado do front-matter, read-only) ou **interativo** (arrastar
  move o ticket, reescrevendo o arquivo)? A segunda opção introduz um segundo escritor
  do estado, o que contraria a decisão de fonte única do ADR-0002.
- Vai para o Git ou fica gitignorado como artefato derivado?
