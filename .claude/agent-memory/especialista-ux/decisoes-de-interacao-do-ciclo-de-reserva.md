---
name: decisoes-de-interacao-do-ciclo-de-reserva
description: As quatro decisões de interação do ciclo de reserva, e a restrição que decidiu as quatro
metadata:
  type: project
---

Decididas em 2026-07-28 e escritas em `docs/discovery/18-decisoes-de-interacao.md`.
**O que a memória guarda é a restrição, porque ela decide as próximas também.**

**A restrição:** sem busca por texto (`PRD-0001:109`) + sem notificação (`PRD-0001:111`) +
uso episódico (`PRD-0001:42`) = **o produto não alcança ninguém, e quem volta não lembra
de nada.** Toda informação que alguém precisa receber tem de estar legível numa tela que
essa pessoa tenha caminho determinístico para reabrir.

As quatro, em uma linha cada:

1. **Código na página do anúncio + tela "Meus interesses"** — as duas, como rotas
   redundantes para o mesmo lugar
2. **Item reservado fica na vitrine com selo** — a vitrine é o único canal de aviso que
   sobrou depois do corte de notificações
3. **"Entreguei, mas não consegui o código" existe, e não é escondido** — é secundário,
   custa 3 atos contra 2, e deixa marca permanente. **Esconder é a resposta errada**
   (Krug, p. 204: esconder corrói a boa vontade e não impede)
4. **O interesse não some quando a reserva é desfeita** — apagá-lo faria a interface
   afirmar "ela não quer mais", que o sistema não observou; e quem desfez pode ter sido o
   anunciante

**Why:** as decisões 3 e 4 dependem de linhas que são do Gabriel (C8 e C9 de
`17-modelagem-de-dominio.md`). A 1 e a 2 são o que torna sustentável o corte da busca —
**se qualquer uma das duas cair, a busca por texto volta a ser necessária.**

**How to apply:** antes de cortar uma tela do lado de quem se interessa, verifique se ela
não é o caminho de volta de alguém. Ver [[vocabulario-do-ciclo-de-reserva]] e
[[fontes-ux-ja-citadas]].
