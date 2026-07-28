---
name: observa-o-ato-nunca-o-fato
description: A premissa epistêmica do Passa Adiante — o sistema observa o ato, nunca o fato — e as três decisões de modelo que ela governa
metadata:
  type: project
---

**O sistema observa o ato. Nunca observa o fato.** É a generalização de
`docs/discovery/16-modelo-de-dados-por-perfil.md:18-20` para todo o domínio, e é a espinha
da modelagem registrada em `docs/discovery/17-modelagem-de-dominio.md`.

Observa que alguém digitou um nome; não que o nome seja dela. Observa o clique em "Tenho
interesse"; não que a pessoa exista. Observa a marcação do destinatário; **não a entrega**.

**Why:** o produto não tem integração com Unifor Online nem API do TORPEDO, e `ADR-0004`
declara que o propósito (vínculo) é permanentemente inobservável. Sem essa frase, o modelo
promete saber o que não sabe.

**How to apply:** ela decide três coisas de uma vez e economiza re-derivá-las —
(1) o nome dos estados: `Entregue` mente, `DestinoRegistrado` não; (2) a separação de
eventos entre observado e declarado; (3) por que a identidade é contexto à parte. Antes de
aceitar qualquer nome de estado ou de evento novo neste projeto, pergunte se o sistema
presenciou o que o nome afirma. Ver [[modelo-dois-bounded-contexts]] e
[[contradicoes-abertas-do-modelo]].
