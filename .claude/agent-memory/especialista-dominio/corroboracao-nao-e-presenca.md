---
name: corroboracao-nao-e-presenca
description: O que o código de confirmação prova e o que não prova — e por que DestinoConfirmado é observado sem que EntregaConfirmada passe a existir
metadata:
  type: project
---

**O código de confirmação evidencia corroboração, nunca presença.** Modelado em
`docs/discovery/17-modelagem-de-dominio.md` §5.3.

O que o sistema observa, literalmente: *uma sessão do anunciante apresentou uma cadeia de
caracteres que o sistema gerou e revelou apenas ao lado do recebedor.*

| Evidencia | Não evidencia |
|---|---|
| Que a informação atravessou de um lado ao outro | Que as duas pessoas estiveram no mesmo lugar |
| Cooperação entre as duas contas | Que o item mudou de mãos |
| Que o anunciante **não fechou sozinho** | Que há duas pessoas distintas por trás das contas |

**Why:** é [[observa-o-ato-nunca-o-fato]] aplicada a um mecanismo que parece provar mais do
que prova. `DestinoConfirmado` é evento **observado** — o sistema é testemunha do próprio
segredo. Mas `EntregaConfirmada` continua não existindo, e escrever *"entrega confirmada"*
na interface reintroduz a mentira do `Entregue` com um mecanismo mais convincente atrás, o
que a torna pior.

**How to apply, três coisas:**

1. **A afirmação é condicional.** Se o código for adivinhável ou tentável à vontade,
   `DestinoConfirmado` degrada silenciosamente a declaração unilateral — nada parece
   quebrado, e só a verdade se perde. O mecanismo é downstream; a dependência é do modelo.
2. **`I17` é a invariante crítica:** o código nunca aparece para o anunciante, **inclusive
   no JSON bruto**. Mesma forma de `I11`, mesmo motivo.
3. **`ReservaDesfeita.porQuem` diz quem encerrou, nunca de quem foi a falha.** O anunciante
   que desfaz costuma ser quem foi deixado esperando — ele desfaz para liberar o item.
   Qualquer reputação futura construída sobre esse campo puniria o comportamento certo.

**O verbo "confirmar" tem o mesmo defeito de sujeito que "autenticar":** qualifica a
**reserva** ou o **destino**, nunca a **entrega**, e nunca com o sistema como sujeito.
