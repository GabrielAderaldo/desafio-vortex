---
name: premissa-aceita-nao-se-propaga
description: Premissa aceita num contexto não se propaga sozinha para o contexto seguinte — o cálculo fica obsoleto sem aviso
metadata:
  type: feedback
---

Depois de **aceitar** uma premissa de outro papel, releia as próprias afirmações anteriores
e posteriores que dependem dela. A aceitação não se propaga sozinha.

**Why:** no round de discovery (2026-07-27/28) aceitei do `tecnico` que "o recebedor já está
no sistema pelo gate de contato" — e um parágrafo depois afirmei que o mecanismo que **eu**
estava propondo *"exige o recebedor dentro do sistema, que é o degrau caro"*. Mesmo erro do
outro lado: ele precificou uma cláusula como a mais cara sob uma leitura e não reprecificou
quando a leitura mudou.

Nos dois casos **o valor estava certo quando foi calculado** e ficou obsoleto sem aviso. Não
há detecção barata: só alguém recalculando. É o modo de falha que o formato de war room pega
e que uma pessoa sozinha não pegaria — e é diferente de estar errado, porque nada no texto
sinaliza que envelheceu.

**How to apply:** ao escrever "aceito X", varrer o que já foi dito que pressupõe ¬X. Vale
especialmente para custos, preços e rankings — são os que mais dependem de premissa e os
que menos avisam quando ela muda.

Ver [[enquadramento-do-mediador]] e [[round-discovery-integridade-da-evidencia]].
