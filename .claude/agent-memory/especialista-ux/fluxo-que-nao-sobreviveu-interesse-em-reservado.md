---
name: fluxo-que-nao-sobreviveu-interesse-em-reservado
description: Uma decisão de interação minha (esconder o botão Tenho interesse em item reservado) foi derrubada pelos critérios de aceite — e por quê
metadata:
  type: project
---

**Em `18-decisoes-de-interacao.md:170` eu decidi:** item reservado não mostra o botão
"Tenho interesse" — no lugar, a linha *"Já reservado para outra pessoa"*. O argumento era
bom: *"a interface não deve oferecer e depois negar"*.

**Não sobreviveu.** `12-historias-e-criterios-de-aceite.md` v2 (`H-08`) decidiu o contrário:
**é possível registrar interesse em item reservado** — *"quem chega sabe que há alguém na
frente"*. Desenhei para `12` em `20-wireflows-e-mensagens.md` (`E-08`), como aviso antes do
ato e não como erro.

**Why:** minha decisão era **derivação** de `I3` do modelo de domínio (*"anúncio que não
está Disponível não aceita novos interesses"*). Derivação não sobrevive à premissa mudar, e
`12` é a decisão do Gabriel e a entrada da W0 — o que vira teste é o critério de aceite.

**E `12` é melhor produto**, o que é a parte que dói e vale guardar: quem vê "já tem alguém"
e quer mesmo assim é exatamente quem a Decisão 4 protege — se a reserva for desfeita, o nome
já está na lista. Sob a minha versão, essa pessoa não tinha como entrar na fila.

**How to apply:** antes de escrever "o botão não existe", pergunte se o ato negado tem valor
**condicional** — se a condição pode se desfazer sozinha (e aqui pode, `I19`), negar hoje
custa a fila de amanhã. E: **decisão minha que deriva de invariante de domínio é frágil por
construção**; marcar a dependência é o mínimo.

Ver [[decisoes-de-interacao-do-ciclo-de-reserva]] e
[[referencia-por-identificador-nao-por-linha]].
