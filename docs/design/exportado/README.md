# Artefatos de design — snapshot exportado

**Fonte viva:** [VORTEX — PROCESSO SELETIVO no Figma](https://www.figma.com/community/file/1663876864232938978)
**Snapshot de:** 2026-07-28

> **Estas imagens são cópia, não original.** Se elas divergirem do Figma, **o Figma está
> certo** — é lá que o artefato é editado. O snapshot existe para que o repositório seja
> autossuficiente: quem clona vê o que foi projetado sem depender de link externo,
> permissão de acesso ou do arquivo continuar existindo.

## Por que as duas coisas

| | Serve para | Falha quando |
|---|---|---|
| **Link do Figma** | Ver a versão atual, navegar, editar, usar o histórico nativo de versões | O acesso é revogado, o arquivo é movido, ou quem lê está offline |
| **PNG no repositório** | Estar sempre disponível, aparecer no README, sobreviver ao tempo | O Figma muda e ninguém reexporta — vira retrato de um momento passado |

Nenhum dos dois basta sozinho. Por isso os dois.

## O que tem aqui

| Arquivo | O que mostra |
|---|---|
| `journey-map-jornada-a.png` | A jornada de quem passa material adiante. Cinza = fora do produto · âmbar = dentro, e o produto fica mudo |
| `journey-map-jornada-b.png` | A jornada de quem chega ao campus. **Vermelho marca os dois buracos**: onde a pessoa deveria descobrir o produto e não há canal, e onde a jornada dela termina sem fechamento |
| `wireflow-chegar-e-olhar.png` | Dois atos até ver um item, sem identificação em passo nenhum |
| `wireflow-publicar.png` | Identificação, formulário e a lista dos próprios itens |
| `wireflow-reservar-e-confirmar.png` | **O único trecho do produto que não é CRUD.** O código não aparece em nenhuma das quatro telas — e isso é o que a figura torna verificável |
| `wireflow-desfazer.png` | A mesma transição vista pelos dois lados, que é o que justifica o modelo guardar *quem* desfez |

## O texto que sustenta cada um

As imagens não se explicam sozinhas. O raciocínio, as alternativas descartadas e as
contradições encontradas estão em:

- [`docs/discovery/19-jobs-to-be-done.md`](../../discovery/19-jobs-to-be-done.md) — as job stories e as duas jornadas
- [`docs/discovery/20-wireflows-e-mensagens.md`](../../discovery/20-wireflows-e-mensagens.md) — os wireflows e o guia de mensagens de erro

## Como reexportar

Os artefatos são gerados no Figma e exportados como PNG. Ao alterar o arquivo, reexporte
e **atualize a data no topo deste README** — snapshot sem data é pior que snapshot
nenhum, porque parece atual.
