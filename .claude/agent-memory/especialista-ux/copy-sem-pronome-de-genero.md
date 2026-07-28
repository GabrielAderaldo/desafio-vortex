---
name: copy-sem-pronome-de-genero
description: Regra de copy do Passa Adiante — nenhuma frase da interface usa pronome de terceira pessoa com gênero para se referir a outra pessoa
metadata:
  type: project
---

**Nenhuma frase da interface do Passa Adiante usa pronome de terceira pessoa com gênero
para se referir a outra pessoa.** Escreve-se *"desfez a reserva"*, nunca *"ela desfez"*;
*"quem publicou"*, nunca *"o dono"*.

**Why:** o nome de exibição é livre e auto-declarado (`docs/discovery/16-modelo-de-dados-por-perfil.md:58`)
e o produto opera sob zero trust — não há como inferir pronome de um nome digitado, e
errar misgendera uma pessoa real. É a mesma família da regra que já proíbe a interface de
afirmar identidade (`16:148-157`): o produto não afirma o que não observou, e gênero é a
forma mais fácil de quebrar isso sem perceber.

**How to apply:** vale em toda copy de interface, erro, e-mail de log e nome de estado —
inclusive na copy já escrita antes desta regra. Onde a frase precisar de sujeito, use o
nome de exibição, *"quem publicou"*, *"quem recebeu"* ou a segunda pessoa. Foi decidida em
`docs/discovery/18-decisoes-de-interacao.md`, Decisão 4, e é a única regra daquele
documento que se aplica retroativamente.

Ver [[vocabulario-do-ciclo-de-reserva]].
