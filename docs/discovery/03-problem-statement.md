# Problem Statement

**Cerimônia 1 do upstream** · Lean UX cap. 3, template adaptado para greenfield
**Enquadramento adotado:** D reescrito — *o gesto sem resposta*
**Evidência:** `02-sintese-questionario.md`, com o **Achado 7** (a geladeira) como base

> **Versão 2.** A primeira versão enquadrava D como *"o destino em que se confia"*,
> supondo que a desconfiança **precede** a entrega. O follow-up que caracterizou as
> "iniciativas do campus" mostrou o contrário: o canal foi **usado**, e a dúvida veio
> **depois**. O que mudou está no Achado 7.

---

## Nota sobre a adaptação do template

O template original assume um produto existente que **deixou** de atingir seus
objetivos. O livro autoriza o caso greenfield: *"some teams — especially teams starting
from scratch — may not have a clear problem statement. That's okay."*

Aqui o "sistema atual" **não é software** — e, ao contrário da versão 1 deste
documento, ele agora tem nome, endereço e um episódio de uso registrado.

---

## O statement

> No campus da UNIFOR, o destino do material acadêmico que alguém não usa mais é
> decidido por uma **geladeira velha no ponto de ônibus**, onde qualquer um pode deixar
> o que quiser; por uma **caixa de sucata no bloco D**; e, fora isso, por gavetas, pelo
> lixo e pela rede pessoal de amigos. A geladeira existe para ser exatamente o que
> queremos construir — *"partilha de conhecimento público"* entre estudantes, com
> fricção praticamente nula.
>
> Observamos que ela falha em três pontos ao mesmo tempo. Está **mal cuidada e apagada**,
> a ponto de *"parecer mais lixo na rua"*. **Só é encontrada por quem já foi
> deliberadamente procurá-la.** E quem deixa material ali **nunca descobre se ele
> serviu**. O efeito é que o gesto de desapegar fica sem resposta — e a dúvida
> *"foi útil, ou eu estava só espalhando lixo?"* é o que impede a próxima vez.
>
> **Como podemos dar resposta ao gesto de desapegar — de modo que quem entrega saiba
> que o material serviu, e que o sistema pareça vivo o bastante para ser encontrado por
> quem precisa?**

---

## A evidência que sustenta cada parte

Todas as citações são de P04, no follow-up de 2026-07-28, salvo indicação. Elas são
localizáveis por `grep` na fonte — ver a regra de citação em `02-sintese`.

| Afirmação do statement | Evidência |
|---|---|
| A geladeira existe e aceita qualquer coisa | *"geladeira velha no ponto de ônibus do campus que você pode deixar o que quiser nela"* |
| O modelo é o que queremos | *"é ótima ideia por que vira uma partilha de conhecimento PÚBLICO"* |
| Está abandonada | *"mal cuidada e super apagada"* · *"parece mais lixo na rua"* |
| Não é descoberta | *"se não for alguém que ativamente quis olhar para ela"* |
| O gesto fica sem resposta | *"fiquei INSEGURO se realmente foi útil ou eu estava só 'espalhando lixo'"* |
| O julgamento se repete em outra iniciativa | Caixa de sucata do bloco D — *"parecia mais LIXO que algo bom"* |
| Descartar incomoda | *"LIXO é um destino MUITO dificil"* [sic] |
| O material fica parado | P02: *"tá parada em uma gaveta"* |
| Alguém já procurou destino e não achou | P01: *"não consegui ir a fundo para descobrir um local seguro e objetivo"* — **sobre apostilas do ensino médio** |
| O caminho atual é a rede pessoal | P01: *"perguntaria para meus amigos"* · P03: *"dar pra algum conhecido"* |

---

## Por que o enquadramento A foi descartado

Registrado porque a decisão oscilou duas vezes, e a razão final é diferente da inicial.

**A** dizia: o material não circula porque desapegar dá trabalho; logo, otimize o ato
de anunciar.

**A geladeira tem a menor fricção fisicamente possível** — chega e larga, sem cadastro,
sem foto, sem formulário. Foi usada. O problema persistiu. Facilitar o ato de anunciar
não é a alavanca.

*(Histórico: A foi marcado "refutado" na v1 com base numa citação truncada; reaberto
quando a citação foi restaurada; e refutado de novo pelo Achado 7 — desta vez por um
caso de uso real, não por uma frase pela metade.)*

---

## Constraints declarados

O Lean UX é explícito sobre a função destes: *"You need constraints for group work.
They provide the guardrails that keep the team grounded and aligned."*

### Impostos pelo edital

| Constraint | Origem |
|---|---|
| API REST devolvendo **JSON estrito** | linha 56, obrigatório |
| **PWA instalável** — `manifest.json` + Service Worker | seção 2.2, obrigatório |
| Landing rica no desktop **e** app fluido no mobile | seção 2.2, obrigatório |
| Vitrine pública com **filtro por categoria** | seção 1.1, obrigatório |
| **Sem upload de arquivo** — "URL de imagem simulada" | seção 1.1 |
| Estatísticas da landing **podem ser simuladas** | seção 1.1, autorizado explicitamente |
| Endpoints: criar, listar, filtrar, deletar | linha 52 — a sigla diz CRUD, a enumeração omite o *update* |
| **O fluxo precisa caber em 2 minutos de demo** | seção 5 — constraint de **design**, não de entrega |
| O Diário de Bordo é **conteúdo obrigatório** do README | linha 121; omissão é *"severamente penalizada"* (108-109) |

### Decididos pelo projeto

| Constraint | Origem |
|---|---|
| F# no backend, SPA React, sessão por cookie `HttpOnly` | [ADR-0003](../handbook/adr/ADR-0003-stack-fsharp-spa-e-sessao-por-cookie.md) |
| Docker + Compose obrigatórios | `CLAUDE.md` |
| **Não construir canal de comunicação próprio** — o contato sai pelo TORPEDO UNIFOR | decisão do autor, 2026-07-27 |
| **O contato público precisa expor o nome, não a matrícula** | ver abaixo |

#### Por que nome e não matrícula

**Verificado por P04 em 2026-07-28: a busca do TORPEDO é por nome ou parte do nome —
não por matrícula.** Um anúncio que exibisse apenas a matrícula tornaria o contato
impossível por construção: ninguém encontra ninguém digitando o número.

Isso converge com o que os entrevistados já pediam por outra razão — P02: *"Não,
preferiria meu nome"*; P03 queria escolher o que aparece. A matrícula fica como
**identidade interna**, o que também elimina a exposição de dado institucional numa
vitrine pública (ver a premissa quebrada de P04 em `02-sintese`, Achado 4).

---

## O que este enquadramento deliberadamente não ataca

- **A demanda.** Nenhum ingressante respondeu ao questionário. Otimizamos o lado da
  oferta e mantemos a demanda como **suposição declarada** (B12.1).
- **Logística de entrega.** Onde as pessoas se encontram fica fora — o contato sai do
  sistema por decisão.
- **Reputação entre pares em escala.** Nota, review, histórico público de transações.
- **Verificar que o material foi bem tratado.** A objeção literal de P04 é sobre
  *"bom cuidado"*, e identidade institucional **não responde a isso** — saber que o
  recebedor tem matrícula não diz que ele cuidará do material. O produto responde
  *"serviu a alguém"*, **não** *"foi bem cuidado"*. Registrado porque a diferença é
  real e o pitch não pode prometer o que o artefato não faz.

---

## Como saberemos que atacamos o problema certo

Sem benchmark, nenhuma métrica significa nada: *"none of your metrics will be meaningful
if you don't have a benchmark in place prior to writing your hypotheses."*

**Benchmark, qualitativo:** existe hoje um canal de fricção quase nula (a geladeira),
ele foi usado, e o usuário saiu com a dúvida *"foi útil ou eu estava só espalhando
lixo?"* — sem nunca obter resposta. Nenhum dos quatro respondentes passou material
adiante por canal organizado com retorno.

**O sinal de sucesso**, portanto, é qualitativo antes de quantitativo: alguém que já
deixou material na geladeira olhar para esta tela e conseguir apontar **o que ela
responde que a geladeira não respondeu** — indicando algo concreto na interface, não a
intenção do sistema.
