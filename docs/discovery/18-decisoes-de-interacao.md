# Decisões de interação — o ciclo de reserva

**Cerimônia 16 do upstream**
**Entrada:** `17-modelagem-de-dominio.md` · `ADR-0004` · `PRD-0001` ·
`12-historias-e-criterios-de-aceite.md` · `16-modelo-de-dados-por-perfil.md` ·
`15-personas-revisadas.md` · `14-mapa-de-empatia.md` · `02-sintese-questionario.md` ·
`09-corte-de-escopo.md` · `data/locais-campus.toml`
**Alimenta:** os critérios de aceite que faltam (C1, C8, C9, C13) e a W0

> **Rótulos.** `verificado` — li o arquivo · `documentado` — fonte canônica afirma, com
> autor, obra e página · `inferido` — leitura minha, pode estar errada.
>
> **Nada de UX de memória.** Toda afirmação de método abaixo vem do MCP `acdg-skills`,
> domínio `design-ux-ui`, com linha e página. As fontes estão ao fim.

---

## 0. A restrição que decide as quatro

Antes de qualquer tela, três ausências combinadas produzem **um** problema, e as quatro
decisões são respostas a ele:

| Ausência | Onde está decidida |
|---|---|
| **Não existe busca por texto** | `PRD-0001:109` · `09-corte-de-escopo.md:87` |
| **Não existe notificação, e-mail ou push** | `PRD-0001:111` · `09-corte-de-escopo.md:89` |
| **O uso é episódico — duas ou três vezes por ano** | `PRD-0001:42` |

Somadas: **o produto não alcança ninguém, e quem volta não lembra de nada.** Toda
informação que alguém precisa receber tem de estar legível numa tela que essa pessoa
tenha caminho determinístico para reabrir — porque ela não vai ser avisada, não vai
procurar por texto, e não vai lembrar do título.

`documentado` — Steve Krug, *Não Me Faça Pensar, Revisitado (3ª ed.)*, **p. 95**:

> *"Dado o poder da pesquisa e o número de pessoas que preferem pesquisar a navegar, a
> menos que um site seja muito pequeno e muito bem organizado, cada página deve ter uma
> caixa de pesquisa ou um link para uma página de pesquisa."*

E Thiago Tamosauskas, *Arquitetura da Informação e UX*, **p. 25**:

> *"Sistemas suplementares incluem sitemaps, busca, Índices A a Z e Guias. São fatores
> críticos para garantir a usabilidade e encontrabilidade em sites muito grandes. São
> como botes salvavidas para quando a navegação padrão não atende o usuário."*

**Não temos o bote.** Cortar a busca é decisão certa — o edital não a pede e ela é escopo
que nós adicionaríamos (`09-corte-de-escopo.md:87`) —, mas ela só é sustentável se a
navegação padrão atender sozinha. Hoje ela não atende: quem demonstra interesse não tem
uma única tela sua no produto.

**Este documento não reabre o corte da busca.** Ele paga o preço dele.

---

## Decisões 1 e 2 — decididas juntas, porque são a mesma

O lead pediu que fossem decididas juntas. Elas são mais que amarradas: são **um caminho de
volta e a redundância dele**.

### A escolha

> **1. O código mora na página do anúncio. E existe uma tela "Meus interesses", cujo
> único trabalho é reabrir aquela página.**
>
> **2. Item reservado continua na vitrine, com o selo "Reservado". Sai só quando o
> destino é confirmado.**

Não é "uma ou outra". São **duas rotas para o mesmo lugar**, e cada uma cobre o buraco da
outra:

| Rota | Serve quem | Falha quando |
|---|---|---|
| **Vitrine com selo** | Ana, Bruno, Carla, e quem nunca se identificou | A vitrine cresce e a Ana não lembra do título |
| **"Meus interesses"** | Só quem se identificou e clicou | A pessoa não abre o app |

A segunda linha da coluna direita é o limite honesto e vale dizer agora, não no rodapé:
**nenhuma das duas alcança quem não abre o produto.** O que elas garantem é outra coisa —
que quem abrir entenda em um olhar. Isso é o máximo que um produto sem notificação pode
prometer, e prometer mais seria o pitch que o `ADR-0004:81` proíbe.

### A alternativa descartada, e por quê

**Descartado: só a página do anúncio, sem "Meus interesses".**

Foi a opção mais barata na mesa, e ela quebra em quatro pontos verificáveis:

1. **Não há caminho de volta.** Sem busca e sem histórico, a Ana só reencontra o anúncio
   rolando a vitrine — o que é possível hoje, com seed, e deixa de ser em qualquer
   volume. Krug, **p. 24**: *"Não me faça pensar! (…) É o princípio primordial - o ulmate
   e disjuntor ao decidir se um projeto funciona ou não."*
2. **O anúncio pode ter sido removido.** `17-modelagem-de-dominio.md:515-521` registra a
   transição `Reservado → Removido` e a consequência: *"o recebedor não é avisado — ele
   descobre lendo"*. Sem uma tela dela, **não existe onde ler**. A Ana fica com um código
   de um anúncio que sumiu e nenhuma superfície que explique.
3. **A `I18` não tem onde acontecer.** `17:1445` já tinha nomeado a lacuna:
   *"Onde o recebedor encontra o próprio código (…) não existe 'meus interesses' em
   nenhuma história (…) sem ela `I18` não tem onde acontecer."*
4. **É o lado que o `ADR-0004` diz existir para alcançar.** A Persona 3 — *"quem ainda
   não pertence"*, `15-personas-revisadas.md:127-160` — só aparece no produto como
   interessada. Dar a ela zero superfície é entregar zero produto ao lado que justifica o
   produto. `documentado` no ADR aceito, `ADR-0004:68-70`.

**Descartado: item reservado sai da vitrine.**

Três motivos, e o segundo é o que decide:

1. **A vitrine é o único canal de aviso que sobrou.** Krug, **p. 88**, sobre os propósitos
   negligenciados da navegação: *"Ele nos diz o que está aqui. Ao tornar a hierarquia
   visível, a navegação nos diz o que o site contém. Navegação revela conteúdo! E revelar
   o site pode ser ainda mais importante do que nos orientar ou situar."* Cortada a
   notificação, revelar é a única coisa que resta.
2. **Sair e voltar é pior que ficar.** A reserva não expira (`I21`) e qualquer um dos dois
   lados pode desfazê-la (`I19`). Um item que some da vitrine e reaparece dias depois,
   sem explicação, é a interface piscando. Krug, **p. 204**, sobre o que corrói a boa
   vontade: *"Escondendo informações que eu quero (…) O efeito usual é diminuir a boa
   vontade."* O selo "Reservado" é a mesma informação, dita.
3. **O concorrente literal é uma geladeira abandonada.** *"parece mais lixo na rua"*
   (`02-sintese-questionario.md:229`). Uma vitrine onde as coisas somem em silêncio é uma
   geladeira. Uma vitrine onde um item diz "Reservado" hoje e "Disponível" amanhã é a
   coisa se mexendo — e é o **sinal de vida** que `H-12` pede (`12:257-270`) sem inventar
   um número, porque é fato observado.

### O custo que a escolha 2 paga, declarado

Um item `Reservado` **ocupa lugar na vitrine e não é oferta nenhuma**. É a agravante que
`17:1311-1319` registrou em C5, e ela é real: sem prazo de reserva, a vitrine pode
acumular itens retidos. Não se manifesta em 15 dias com dados de seed.

**O que eu não fiz para mitigar, e por quê:**

- **Não mudei a ordenação.** `H-01` (`12:99`) manda listar do mais recente ao mais antigo.
  Reservar não muda a data de publicação, então o item afunda sozinho. Empurrar reservados
  para o fim faria um item *subir* ao voltar a disponível, o que é movimento que a pessoa
  não causou e não entende.
- **Não criei filtro "só disponíveis".** O edital pede filtro por categoria e só
  (`09-corte-de-escopo.md:66`). Um segundo eixo de filtro é escopo novo, e é a resposta
  errada para um problema de volume que este ciclo não terá.

### O que a pessoa vê, em ordem, quando funciona

**Ana, logo depois de o João reservar para ela** — ela abre o app por qualquer porta:

1. Menu identificado mostra dois itens: **Meus anúncios** · **Meus interesses**
2. Toca em "Meus interesses" → lista com um card: o livro de Cálculo, foto, selo
   **"Reservado para você"**
3. Toca no card → página do anúncio, e o topo dela é o bloco do código:
   - Faixa **"Reservado para você"**
   - O nome do João e o contato que ele escolheu expor
   - O(s) ponto(s) de encontro do anúncio
   - **O código**, em caracteres grandes
   - Um botão **Copiar código**

**Bruno, que também se interessou e não foi escolhido** — ele não recebe nada, e descobre
por leitura, nos dois lugares:

1. Vitrine → o card do livro de Cálculo tem o selo **"Reservado"** e, no lugar do botão,
   a linha "Já reservado para outra pessoa"
2. "Meus interesses" → o mesmo card, com o mesmo selo

**Ninguém é nomeado para o Bruno.** `D3` (`12:60-66`) já proíbe a vitrine de dizer quem
recebeu; a mesma regra vale para quem foi reservado.

### O que a pessoa vê quando dá errado

| Situação | O que ela vê |
|---|---|
| **Ana abre "Meus interesses" e nunca clicou em nada** | Estado vazio (copy abaixo) |
| **João removeu o anúncio enquanto estava reservado** | O card em "Meus interesses" perde o código e ganha a linha "Este anúncio foi removido por quem publicou." A página do anúncio devolve a mesma frase, não um 404 seco |
| **Ana está no campus, sem sinal, na hora do encontro** | ⚠️ **Ela não vê o código.** Ver `U2` na §5 — é contradição real e a mitigação é copy, não cache |
| **Bruno tenta se interessar num item reservado** | O botão não existe. No lugar: "Já reservado para outra pessoa." `I3` (`17:761`) proíbe o interesse; a interface não deve oferecer e depois negar |
| **A vitrine inteira está reservada ou vazia** | Estado vazio da vitrine — já tem critério (`12:101`) e continua sem copy escrita. Ver `U5` |

### A copy

**Menu (pessoa identificada)**

```
Meus anúncios
Meus interesses
```

**Cabeçalho de "Meus interesses"**

```
Meus interesses
Os itens em que você tocou "Tenho interesse".
```

> A segunda linha existe porque a navegação também ensina o site — Krug, p. 88:
> *"Ele nos diz como usar o site."* Com uso episódico, a pessoa não lembra por que essa
> tela existe.

**Estado vazio de "Meus interesses"**

```
Você ainda não demonstrou interesse em nada.

Quando tocar em "Tenho interesse" num item, ele aparece aqui — e é daqui
que você volta para achá-lo depois.

[ Ver o que está disponível ]
```

> Estrutura da skill `ux-copy`: *o que isto é + por que está vazio + como começar*. A
> frase do meio é a que carrega o peso: ela promete o caminho de volta, que é o motivo de
> a tela existir.

**Bloco do código, na página do anúncio (visão da Ana)**

```
Reservado para você

Combine com João Pedro e mostre este código quando se encontrarem.

    K7QF2M                                   [ Copiar código ]

Só você tem este código. João Pedro precisa digitá-lo para registrar
que o livro chegou a alguém.

Este código continua aqui mesmo sem internet.

Onde encontrar: Praça do CC · Biblioteca Central
Falar com João Pedro: @joaopedro no TORPEDO

Não vou mais poder pegar
```

**Selo na vitrine e em "Meus interesses"**

| Estado | Selo | Linha no lugar do botão |
|---|---|---|
| `Disponível` | — | `[ Tenho interesse ]` |
| `Reservado`, para outra pessoa | `Reservado` | "Já reservado para outra pessoa" |
| `Reservado`, para você | `Reservado para você` | "Mostre o código no encontro" |
| Anúncio removido | — | "Este anúncio foi removido por quem publicou." |

**Formato do código — é decisão de interação, não de mecanismo**

Seis caracteres, alfabeto sem ambiguidade visual (**sem** `O`/`0`, `I`/`1`/`l`), exibido
em caixa alta e monoespaçado. O campo de digitação **aceita minúsculas e ignora espaços**.

`inferido`: seis caracteres é o limite do que alguém lê em voz alta e digita no celular
sem errar, e o encontro é presencial e apressado. **Quão inadivinhável o código precisa
ser é do técnico** (`17:1448`) — o que é meu é que a resistência não pode ser comprada
alongando o código, porque cada caractere a mais é um erro de digitação a mais num
encontro que tem trinta segundos.

---

## Decisão 3 — o João entregou e a Ana sumiu

### A escolha

> **"Entreguei, mas não consegui o código" existe. O sistema passa a ter dois níveis:
> confirmado pelos dois lados, e declarado por um. O atalho não é escondido — ele é
> secundário, mais caro em atos, e deixa marca permanente.**

### As alternativas descartadas

**Descartado: desfazer a reserva e devolver à vitrine.**

É a pior das três, e o motivo não é de usabilidade — é de propósito. O item não existe
mais. Devolvê-lo à vitrine faz o produto publicar uma oferta falsa, e o custo cai em cima
de **um terceiro**: alguém se interessa, atravessa o campus, e ouve do João que já foi.
O produto inteiro existe contra uma iniciativa que *"parece mais lixo na rua"*
(`02-sintese-questionario.md:229`). Devolver fantasma à vitrine é fabricar exatamente
isso, com o nosso nome em cima.

**Descartado: nada — fica reservado para sempre.**

É honesto e é a falha mais cara que este produto pode ter. `H-11` é descrita em
`12:248` como *"a história que justifica o produto"*: **ver que o item chegou a alguém**.
Um produto cuja única promessa é fechar o gesto, e que trava na hora de fechar, reproduz
dentro do app a dor que o discovery encontrou fora dele:

> *"cheguei a deixar minhas apostilas do ensino médio lá uma vez, porém fiquei **INSEGURO
> se realmente foi útil** ou eu estava só 'espalhando lixo'"* — `02-sintese-questionario.md:234-235`

O João que entregou e não consegue registrar fica **exatamente** onde estava antes da
geladeira ter um app.

### O quão escondido precisa ser — e a resposta é: não escondido

O risco que o lead nomeou é correto: se for fácil demais, vira o caminho padrão e o código
perde o sentido. A tentação óbvia é esconder o atalho. **Esconder é a resposta errada**, e
tem contra-argumento documentado — Krug, **p. 204**:

> *"Escondendo informações que eu quero. (…) O efeito usual é diminuir a boa vontade e
> garantir que eles fiquem ainda mais irritados quando encontrarem o número e ligarem.
> Por outro lado, se o número 800 estiver à vista (…) saber de alguma forma que eles podem
> ligar se quiserem é suficiente para manter as pessoas procurando as informações no site
> por mais tempo."*

Esconder não impede o atalho: atrasa, irrita, e quem o encontra chega com raiva do produto.
O que impede um atalho de virar padrão **não é a dificuldade de achá-lo — é ele não ser
mais barato que o caminho certo, e dizer o que custa.** Três mecanismos, em ordem:

**1. Ordem e peso, não ocultação.** Na página do anúncio reservado, visão do João, o
caminho primário é o campo de código: um input e um botão, no topo. A saída declarada é
**uma linha de texto abaixo**, com peso de corpo — não um botão, não um destaque, não um
menu escondido atrás de três pontinhos. Está na mesma tela, na mesma rolagem, em segundo
lugar. A hierarquia visual já responde "qual é o normal aqui".

**2. O atalho custa mais atos que o caminho certo.**

| Caminho | Atos |
|---|---|
| Confirmar com o código | digitar + tocar = **2** |
| Declarar sem o código | tocar no link + ler o diálogo + tocar em confirmar = **3, e uma leitura** |

Ninguém escolhe o caminho mais longo por preguiça. Isso é a inversão de fricção correta:
o atrito fica onde o custo é epistêmico, não onde a pessoa sofre.

**3. A marca é permanente e visível para quem declarou.** Se declarar for gratuito e
invisível, vira padrão em uma semana. Se deixar uma marca honesta na tela de quem
declarou, o custo é social e é o custo certo. O item declarado carrega, em "Meus
anúncios", **"declarado por você"** ao lado de "encontrou destino". Para sempre.

**O que eu deliberadamente não fiz:**

- **Nenhum relógio.** Considerei revelar o link só depois de N dias de reserva. Descartado:
  com uso episódico, a pessoa que volta em três semanas encontraria uma interface
  diferente da que deixou e não saberia por quê — é o oposto de "não me faça pensar". E
  introduz um relógio num produto cuja regra é *"adiar é o estado padrão, não uma ação"*
  (`I21`, `17:784`).
- **Nenhum limite de tentativas visível ao João.** Limitar tentativa de código é
  segurança e é do técnico.

**O limite honesto:** isto é um dispositivo de incentivo, não um controle. Um João
determinado declara tudo. Vale registrar que o modelo já classificou assim a regra irmã —
o limite de uma reserva ativa: *"Regra cuja violação não corrompe nada não é invariante
verdadeira"* (`17:734`).

### O que a pessoa vê, em ordem, quando funciona

**João, no caminho certo:**

1. "Meus anúncios" → o livro de Cálculo com o selo **"Reservado para Ana Beatriz"**
2. Toca → página do anúncio, e o topo é o campo do código
3. No encontro, a Ana mostra a tela dela; ele digita `K7QF2M` e toca em **Confirmar**
4. A tela troca, na mesma página, sem navegação: **"Encontrou destino"**, com
   "confirmado com Ana Beatriz" e a data
5. O anúncio sai da vitrine pública (`I5`)

**João, no caminho declarado:**

1. Passos 1 e 2 iguais
2. Toca em "Entreguei, mas não consegui o código"
3. Diálogo com a consequência escrita
4. Confirma → mesma tela final, com **"declarado por você"** em vez de "confirmado com"

### O que a pessoa vê quando dá errado

| Situação | O que ela vê |
|---|---|
| **Código digitado errado** | Erro no próprio campo, sem recarregar a tela |
| **Código de outra reserva, válido em outro anúncio** | **A mesma mensagem.** Distinguir vazaria a existência de outros códigos |
| **João tenta reservar para alguém que já tem reserva aberta** (`P1`) | Erro na lista de interessados, sem dizer onde nem o quê |
| **João tenta confirmar um anúncio que a Ana acabou de liberar** | "Esta reserva foi desfeita. O anúncio voltou para a vitrine." |

### A copy

**Página do anúncio reservado — visão do João**

```
Reservado para Ana Beatriz
Reservado em 14 de agosto

Peça o código para Ana Beatriz no encontro e digite aqui:

[ ______ ]   [ Confirmar ]

Entreguei, mas não consegui o código
Desfazer a reserva
```

**Erro de código**

```
Esse código não confere. Confira com Ana Beatriz — são 6 caracteres,
e maiúsculas ou minúsculas dão no mesmo.
```

> Estrutura da skill `ux-copy` para erro: *o que aconteceu + por quê + como resolver*. A
> terceira parte aqui é "confira com a pessoa", porque o produto não tem outra saída a
> oferecer, e fingir que tem seria pior.

**Diálogo de encerramento declarado**

```
Encerrar sem o código?

O anúncio sai da vitrine e fica registrado como entrega declarada por
você — o Passa Adiante não viu a outra pessoa participar. Isso não pode
ser desfeito.

Se Ana Beatriz ainda puder mostrar o código, vale esperar: com o código,
o registro fica confirmado pelos dois lados.

[ Encerrar sem o código ]   [ Voltar ]
```

> Regra da skill `ux-copy` para diálogo de confirmação: rotular os botões com a ação, não
> com "OK/Cancelar", e descrever a consequência. E o título é a pergunta específica —
> "Encerrar sem o código?", nunca "Tem certeza?".

**Tela final, em "Meus anúncios"**

```
Encontrou destino · confirmado com Ana Beatriz · 14 de agosto
```

```
Encontrou destino · declarado por você · 14 de agosto
```

**A frase que a interface não pode dizer, em lugar nenhum:**
> ❌ "Entrega confirmada" · ❌ "Entrega registrada" · ❌ "Item entregue"

`17:546-548` já proíbe: *"O que foi confirmado é a **reserva**; a entrega o sistema
continua sem ver."* Repito aqui porque é na copy que a mentira volta.

---

## Decisão 4 — a Ana desiste. O interesse dela some?

### A escolha

> **O interesse fica. O que muda é o que o João vê: o nome da Ana continua na lista,
> marcado com "desfez a reserva" e a data. Ele pode reservar para ela de novo — sabendo.**

Não é a opção (a) nem a (b) de `17:1367` (C9). É a (b) com um significado diferente: o
`Interesse` ganha estado, mas o estado não é *retirado* — é **"já foi reservado e a
reserva foi desfeita, por [quem]"**.

### As alternativas descartadas

**Descartado: o interesse some junto com a reserva.**

Dois motivos, e o primeiro é o mesmo princípio que governa o modelo inteiro:

1. **Some é uma afirmação sobre o mundo.** O produto não pergunta o motivo do
   cancelamento e não distingue "desisti" de "agora não". Apagar o interesse faz a
   interface afirmar que a Ana não quer mais o livro — e o sistema não viu isso.
   `17:35` é a regra: *"O sistema observa o ato. Nunca observa o fato."* `17:942` diz o
   mesmo para este caso exato: *"O sistema observa qual lado encerrou; o motivo é
   permanentemente inobservável."*
2. **Quem desfez pode ter sido o João.** `ReservaDesfeita` carrega `porQuem`
   (`17:923`). Se apagar o interesse for consequência automática, **o João que desfaz a
   reserva apaga a Ana da própria lista sem querer** — e ela, com uso episódico, não volta
   para clicar de novo. O produto puniria quem fez a coisa certa, que é o erro que
   `17:1192-1196` já mandou não cometer com `porQuem`.

**Descartado: um diálogo de confirmação quando o João reserva de novo para a mesma
pessoa.** Considerei "Reservar de novo para Ana Beatriz? Esta reserva já foi desfeita uma
vez." Descartado: a marca na lista já informa, e um diálogo em cima de uma informação já
lida é fazer a pessoa pensar duas vezes na mesma coisa. Krug, p. 24.

### O que a pessoa vê, em ordem, quando funciona

**Ana desistindo:**

1. Página do anúncio reservado para ela → toca em "Não vou mais poder pegar"
2. Diálogo com a consequência
3. Confirma → a mesma página perde o bloco do código e volta a mostrar o anúncio como
   disponível, com a linha "Você desfez esta reserva."
4. Em "Meus interesses", o card volta ao selo neutro, com a mesma linha

**João, depois:**

1. "Meus anúncios" → o livro voltou ao selo **"Disponível"**, com "3 interessados"
2. Toca → a lista, na ordem de `H-09` (mais recente primeiro), com a marca:

```
Bruno Lima              tocou em "Tenho interesse" em 12 de agosto   [ Reservar ]
Carla Souza             tocou em "Tenho interesse" em 11 de agosto   [ Reservar ]
Ana Beatriz             desfez a reserva em 15 de agosto             [ Reservar ]
```

**Bruno e Carla:** o selo "Reservado" some da vitrine e de "Meus interesses". O botão
"Tenho interesse" não volta para eles — eles já se interessaram, e `I1` (`12:205`) impede
o segundo registro. Voltam a ver o item como qualquer item disponível em que já tocaram.

### O que a pessoa vê quando dá errado

| Situação | O que ela vê |
|---|---|
| **Ana desfaz e se arrepende** | Nada de especial: o botão "Tenho interesse" já foi usado, o interesse continua registrado, e o João pode reservar de novo. **Ela não precisa fazer nada** — e é por isso que o interesse não some |
| **Os dois desfazem quase ao mesmo tempo** | Quem chega em segundo vê "Esta reserva já foi desfeita." O estado final é o mesmo, e o produto não precisa dizer quem chegou primeiro |
| **João desfaz sem avisar** | A Ana descobre lendo — a página do anúncio diz "Quem publicou desfez esta reserva." É o mesmo mecanismo do preterido, e só existe porque a Decisão 1 lhe deu uma tela |

### A copy

**Link de saída, visão da Ana**

```
Não vou mais poder pegar
```

> Escolhido sobre "Cancelar reserva" e "Desistir". Os dois nomeiam um estado interno do
> sistema; este nomeia o que a pessoa vive, e não a acusa de nada. **"Desistir" carrega
> julgamento** e o produto não sabe o motivo — pode ser mudança de horário, não desistência.

**Diálogo, visão da Ana**

```
Desfazer a reserva?

O livro de Cálculo volta para a vitrine e outras pessoas podem se
interessar por ele.

Seu interesse continua registrado. Se João Pedro reservar para você de
novo, você recebe um código novo.

[ Desfazer a reserva ]   [ Manter ]
```

> A segunda frase é a que faz esta decisão valer a pena: ela diz que sair não é
> definitivo, o que é exatamente a diferença entre "desisti" e "agora não" que o produto
> não consegue perguntar.

**Marca na lista de interessados, visão do João**

| Quem desfez | Copy |
|---|---|
| A pessoa reservada | `Ana Beatriz · desfez a reserva em 15 de agosto` |
| O próprio João | `Ana Beatriz · você desfez esta reserva em 15 de agosto` |

**Regra de copy que sai daqui e vale para o produto inteiro:**

> **Nenhuma frase da interface usa pronome de terceira pessoa com gênero para se referir a
> outra pessoa.** O nome de exibição é livre e auto-declarado (`16:58`) — não há como
> inferir pronome dele, e errar é um dano real e gratuito. Escreve-se **"desfez a
> reserva"**, nunca "ela desfez"; **"quem publicou"**, nunca "o dono".

`inferido`, e é a única regra deste documento que eu aplicaria retroativamente a toda a
copy já escrita.

**Erro do `P1` — João tentando reservar para quem já tem reserva aberta**

```
Não foi possível reservar para Ana Beatriz agora.

Cada pessoa pode ter uma reserva em aberto de cada vez. Escolha outro
interessado, ou tente mais tarde.
```

> **Custo de privacidade, declarado:** esta mensagem revela ao João que a Ana tem uma
> reserva em algum lugar. É inevitável — é a regra sendo aplicada. O que a copy protege é
> **qual** anúncio, e `17:727` diz que mostrar isso *"seria vazamento"*.

---

## 5. O custo nos 2 minutos, e o que sai no lugar

O roteiro do bloco de 2 minutos está em `09-corte-de-escopo.md:116-129` e já tem sete
trechos. As quatro decisões acrescentam **uma tela nova** ("Meus interesses") e mudam a
forma de um trecho.

| Decisão | O que ela custa no vídeo |
|---|---|
| **1 — código na página do anúncio** | **Zero.** A página do anúncio já está no roteiro |
| **1 — tela "Meus interesses"** | **Zero, porque ela não entra no vídeo.** Ver abaixo |
| **2 — selo na vitrine** | **Zero, e é ganho.** Uma passagem pela vitrine passa a mostrar duas coisas |
| **3 — link declarado** | **Zero.** É uma linha na tela e uma frase de narração. Caminho de exceção não se demonstra em 2 minutos |
| **4 — marca na lista** | **Zero.** Não cabe e não deve caber |

**O único custo real é de forma:** o trecho *"Interesse → marcar entregue"* vira
*"Interesse → reservar → mostrar o código → digitar → confirmar"*. São dois atos a mais, e
é o trecho que `09-corte-de-escopo.md:128` chama de *"o diferencial, e o único trecho que
não é CRUD"*. Ele fica mais longo e fica melhor: é a única coisa na demo que exige duas
pessoas.

**O que eu tiraria em troca:** o trecho *"Ver na vitrine"* logo depois de criar o anúncio.
A vitrine aparece de novo, mais tarde, com o selo "Reservado" — e ali ela mostra que o
sistema reagiu, que é a coisa que valia mostrar. **Uma passagem pela vitrine em vez de
duas.**

**Por que "Meus interesses" fica fora do vídeo:** demonstrar as duas contas custa a troca
de sessão, que é o gasto mais caro de tempo numa demo. O código pode ser mostrado na
página do anúncio, aberta na segunda sessão, sem passar pela lista. A tela existe para
uso real, não para a gravação — e essa distinção é a diferença entre construir um produto
e construir um roteiro.

**Não cronometrei**, e `09-corte-de-escopo.md:136` já registrou por quê: *"Estimar
durações aqui seria chute; o teste real é gravar."*

---

## 6. Contradições encontradas, com arquivo e linha

Numeradas `U1…U6` para não colidir com a série `C` de `17-modelagem-de-dominio.md`. **Não
decidi nenhuma que seja de produto.**

### U1 · A confirmação bilateral está cortada, e a Decisão 3 escolhe uma saída

Já é a **C8** do domínio (`17:1336-1365`), e o que acrescento é que **a Decisão 3 consome
a saída (b)**: *"permitir que o anunciante feche sem código, com o estado dizendo que foi
unilateral (…) daria dois estados finais honestos"* (`17:1364`).

| Arquivo:linha | O que diz |
|---|---|
| `PRD-0001:104-106` | *"Fora de escopo: **Confirmação pelo lado de quem recebeu**"* |
| `09-corte-de-escopo.md:93` | *"**Confirmação bilateral de recebimento** — Exigiria o recebedor voltar ao sistema"* |
| `12-historias-e-criterios-de-aceite.md:323` | *"Confirmação por quem recebeu — Cortado na cerimônia 7"* |

**Isto é linha do Gabriel, não minha.** Eu entrego o desenho que a saída (b) exige; a
existência do segundo estado terminal é decisão de produto.

### U2 · O código precisa ser lido no campus, e a única tela que precisa funcionar offline é a que não pode ser cacheada

**Nova, e é minha.** Duas regras aprovadas colidem no momento do encontro:

| Arquivo:linha | O que diz |
|---|---|
| `12-historias-e-criterios-de-aceite.md:289-291` | `H-14`: *"Como **estudante no campus com sinal ruim**, quero rever itens que já vi"* |
| `12-historias-e-criterios-de-aceite.md:299` | *"**Nenhuma resposta contendo dado de pessoa identificada é armazenada em cache**"* — restrição de segurança do `ADR-0003` |

O código é dado de pessoa identificada, e `I18` (`17:781`) diz que só a pessoa reservada o
vê. **O encontro acontece no campus, que é o cenário que `H-14` nomeia como de sinal
ruim** — e a tela que precisa funcionar ali é justamente a que a regra proíbe cachear.

**Não proponho quebrar a regra de cache.** A mitigação é de interação e está na copy:
*"Anote ou tire um print — o sinal no campus pode falhar na hora."* É uma mitigação
honesta e fraca, e prefiro dizer isso a fingir que resolvi.

> ✅ **Resolvida em 2026-07-28, e não pela mitigação.** O Gabriel decidiu que **o código
> não é dado pessoal** — são poucos caracteres, sem nome e sem contato, válidos para uma
> transação. Foi reclassificado como segredo de transação e **pode ser retido no
> dispositivo** (`12` D6). A regra de cache continua valendo para nome, contato e lista de
> interessados.
>
> A copy foi trocada por *"Este código continua aqui mesmo sem internet."* — que descreve
> o comportamento real, em vez de pedir que a pessoa contorne uma limitação que deixou de
> existir.

### U3 · Três critérios de aceite descrevem dois estados, e agora são quatro

**Alimentam a W0 diretamente.**

| Arquivo:linha | O que diz | O que ficou errado |
|---|---|---|
| `12:157` | *"Cada item mostra o estado: disponível ou entregue"* | São quatro estados, e "entregue" está morto (`17:532`) |
| `12:207` | *"Não é possível registrar interesse em item já entregue"* | `I3` foi generalizada para *"não está `Disponível`"* (`17:761`) |
| `12:233` | *"Marcado, o item passa a 'entregue' e **sai da vitrine pública**"* | Com três estados, não diz mais em qual momento sai. É a **C13** (`17:1418`), e a Decisão 2 a responde |

### U4 · O verbo do produto mudou e as histórias não

`PRD-0001:86` e `12:224` (`H-10`) dizem **"marcar quem recebeu"**. O glossário novo
(`17:820-824`) tem **reservar**, **recebedor**, **confirmar**. `H-10` inteira precisa ser
reescrita, e é a história que vira teste.

### U5 · O rótulo da tela do anunciante tem dois nomes

| Arquivo:linha | Rótulo |
|---|---|
| `09-corte-de-escopo.md:68` · `PRD-0001` | **"Meus anúncios"** |
| `12:149` (`H-05`) | **"Ver meus itens"** |

`documentado` — Tamosauskas, **p. 25**: *"O objetivo do rótulo é comunicar a informação
eficientemente usando o mínimo de espaço na tela e de espaço cognitivo do usuário."* Um
rótulo com dois nomes gasta os dois. `17:842-854` já decidiu que **anúncio** é o registro
e **item** é o objeto físico. A tela lista registros: **"Meus anúncios"**, e "Meus
interesses" é o par simétrico.

E `12:101` pede um estado vazio para a vitrine que **nunca foi escrito**. Não escrevi:
é da alçada do `uxcopy`, e a copy da vitrine não é uma das quatro decisões.

### U6 · O corte da busca só é sustentável por causa das Decisões 1 e 2

**Nova, e é uma dependência que nenhum documento registra.** `09-corte-de-escopo.md:87`
corta a busca textual com o argumento correto de que é escopo que nós adicionaríamos.
Esse corte fica de pé porque o selo na vitrine e "Meus interesses" cobrem o caminho de
volta. **Se qualquer uma das duas cair, a busca volta a ser necessária** — e aí ela deixa
de ser escopo que nós adicionamos e passa a ser consequência de um corte anterior.

Registrado para que ninguém corte uma das duas achando que corta uma tela.

---

## 7. O que estas decisões exigem do modelo — para o `especialista-dominio`

**Não modelei.** Aponto o que muda e onde o próprio documento de domínio já discutiu.

| Decisão | O que ela exige | Onde já está discutido |
|---|---|---|
| **3** | Um segundo estado terminal, ou um qualificador em `DestinoConfirmado`, distinguindo confirmado de declarado | `17:1362-1365`, saída (b) de C8 |
| **4** | `Interesse` guarda que houve uma reserva desfeita e **por quem** — sem ressuscitar histórico de reservas | `17:463-468` já autorizou a forma: *"ganhar estado não é ganhar independência"*. O que muda é o significado: não é `retirado`, é `reserva desfeita` |
| **1** | Nada. `I18` (`17:781`) passa a ter onde acontecer | `17:1445` |
| **2** | Nada. `I5` fica restrita a `DestinoConfirmado`; `I3` já foi generalizada | `17:1424-1433`, C13 |

**A Decisão 4 tem um efeito colateral bom que vale nomear:** ela mantém `I4` intacta (o
reservado é sempre um dos interessados) sem exigir que a Ana volte a clicar em "Tenho
interesse", o que `I1` impediria de qualquer forma.

---

## 8. O que não consegui decidir, e o que faltou

| O que | O que faltou |
|---|---|
| **Se o contador da landing conta destinos declarados junto com os confirmados** | Decisão de produto. *"Encontrou destino"* é verdadeiro para os dois (`PRD-0001:87`), então contá-los juntos não mente — mas somar níveis diferentes de evidência num número é exatamente o que `12:267` vigia. **Recomendo contar juntos e não distinguir na landing**, porque a distinção só informa quem participou daquele gesto |
| **Se a marca "declarado por você" aparece para quem não é o anunciante** | Decidi que **não** — só em "Meus anúncios". Mas não tenho como saber se isso enfraquece o incentivo a ponto de o atalho virar padrão. **Só uso real diria**, e não haverá uso real neste ciclo |
| **Se "Meus interesses" é rótulo bom** | *Interesses* é polissêmico em português — hobbies, juros. No menu, ao lado de "Meus anúncios", o par desambigua. Sozinho num breadcrumb, talvez não. **Descartei "Itens que eu quero"** (longo demais para menu mobile) e **"Meus pedidos"** (afirma uma transação que não houve). Fico com "Meus interesses" e registro a dúvida |
| **Quanto tempo o trecho do ciclo de reserva consome no vídeo** | Não cronometrei, por decisão de `09-corte-de-escopo.md:136`. **O teste é gravar**, e é o único jeito de saber se o corte que propus na §5 basta |
| **Se a Persona 3 abre o app uma segunda vez** | É a suposição mais frágil do produto (`PRD-0001:169`), e as Decisões 1 e 4 dependem inteiramente dela. Nenhum ingressante foi entrevistado. **Não é lacuna deste documento — é a lacuna do produto**, e está assumida desde o discovery |

---

## Fontes

Todas obtidas via MCP `acdg-skills`, domínio `design-ux-ui` (`skills_buscar` +
`skills_citar`), com linha e página verificadas na chamada. **Nenhuma citada de memória.**

| Obra | Páginas usadas | Para quê |
|---|---|---|
| Steve Krug, *Não Me Faça Pensar, Revisitado (3ª ed.)* | **p. 24** (a primeira lei) · **p. 88** (os propósitos negligenciados da navegação) · **p. 95** (quem prefere pesquisar a navegar) · **p. 204** (esconder informação corrói a boa vontade) | §0, Decisões 1, 2, 3, 4 |
| Thiago Tamosauskas, *Arquitetura da Informação e UX* | **p. 18** (sistemas de rotulação) · **p. 25** (busca como bote salva-vidas) | §0, `U5` |
| Tom Greever, *Articulando Decisões de Design* | **p. 124** (converter "gosto" em "funciona") | O método deste documento inteiro: cada decisão traz o que quebra na alternativa, não a preferência |

E as skills da Anthropic em `~/.claude/plugins/cache/knowledge-work-plugins/design/1.2.0/skills/`:
**`ux-copy`** — as estruturas de erro (*o que aconteceu + por quê + como resolver*), de
estado vazio (*o que é + por que está vazio + como começar*) e de diálogo de confirmação
(*rotular o botão com a ação, descrever a consequência*) são de lá, e estão aplicadas
literalmente em cada bloco de copy acima.

**A citação que organiza o formato deste documento** — Greever, p. 124:

> *"O modo mais importante de fazer isso é ajudar nossos clientes para que, em vez de
> falarem do que gostam e não gostam (isto é, de suas preferências), eles passem a falar
> do que funciona e não funciona (isto é, da eficácia do design)."*

É por isso que nenhuma das quatro decisões acima diz que uma opção é melhor. Cada uma diz
**o que quebra** na que foi descartada, com arquivo e linha.
