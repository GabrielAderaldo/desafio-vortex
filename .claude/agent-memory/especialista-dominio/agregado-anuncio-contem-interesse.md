---
name: agregado-anuncio-contem-interesse
description: Anúncio é raiz de agregado e contém Interesse, Reserva e CódigoDeConfirmação; Pessoa é agregado próprio em BC-2 — as invariantes que justificam, e a revisão de fronteira que já foi feita
metadata:
  type: project
---

**`Anúncio` é raiz de agregado e `Interesse` é entidade dentro dele.** A invariante que
fecha a fronteira é `H-10` / `12-historias-e-criterios-de-aceite.md:232`: *"Só é possível
marcar alguém que demonstrou interesse — não um nome digitado"*. Não há como garantir isso
transacionalmente com `Interesse` fora. Reforçada por `12:205` (unicidade do interesse por
anúncio).

**`Pessoa` é agregado próprio em BC-2.** O meio de contato vive nela, não no anúncio —
consequência: o contato revelado é sempre o **atual**, nunca retrato do momento do
interesse.

**Why:** invariante determina fronteira de agregado, e nada mais (Vernon, *IDDD*, p. 450).

**How to apply:** referências entre agregados só por identidade — `Anúncio` guarda
`AnuncianteId`, cada `Interesse` guarda `InteressadoId`. É o que torna **estrutural** o
critério de segurança de `H-08` (`12:202`) em vez de dependente de alguém lembrar de
filtrar o campo. O mesmo argumento passou a valer para `I17`, o código.

## A revisão de fronteira está feita — não a refaça

A versão anterior desta memória declarava: *"se aparecer 'desistir do interesse' ou aviso
ao preterido, `Interesse` ganha ciclo próprio e a fronteira precisa ser reexaminada."*
**Os dois gatilhos dispararam com a decisão do ciclo de reserva (2026-07-28), a revisão
foi feita em `17-modelagem-de-dominio.md` §5.1.1, e a fronteira NÃO se moveu.**

- O aviso ao preterido virou **leitura** do estado `Reservado`, não notificação. Leitura é
  projeção e nunca define agregado.
- A desistência desfaz a **`Reserva`**, não o `Interesse`.
- Mesmo se o produto decidir que desistir retira o interesse, `Interesse` ganha **estado**,
  não **independência** — e ganhar estado não move fronteira.

**O ciclo inteiro coube no agregado que já existia:** `Reserva` e `CódigoDeConfirmação` são
**Value Objects** dentro de `Anúncio`. `Reserva` é VO e não entidade porque o produto
**cortou o histórico de reservas** (o contador de "quantas vezes foi reservado"), e sem
histórico não há o que identificar. O código é VO pela igualdade por valor (Vernon, p. 292)
e pela ausência de fio de continuidade (Evans, p. 48).

**O que NÃO coube, e é a exceção:** o limite de uma reserva ativa por pessoa. Ver
[[limite-de-reserva-e-precondicao]].

Ver [[modelo-dois-bounded-contexts]] e [[observa-o-ato-nunca-o-fato]].
