# EP-007 — A citação pela metade, e a geladeira que ninguém tinha perguntado

**Data:** 2026-07-27 / 28
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code · WAR ROOM com 3 subagentes · MCP `acdg-skills` · skill `design:user-research` · Lean UX offline
**Entregável:** cerimônias 1 a 4 do upstream — `docs/discovery/`

## Contexto

Com a stack decidida (ADR-0003) e zero linha de código escrita, decidi que o próximo
passo era o **upstream do produto**: descoberta antes de esteira. O desafio pede um
"marketplace de economia circular do campus", e eu queria saber o que isso significava
de verdade antes de escolher o que construir.

A sessão produziu quatro cerimônias do Lean UX, uma pesquisa com pessoas reais, uma
auditoria que derrubou todas as marcas de evidência do documento, e uma reviravolta no
enquadramento do problema — que veio de uma resposta minha, não de análise da IA.

## O prompt

O que abriu a sessão:

~~~
Então, primeira coisa que devemos fazer, sinceramente sinto que é toda a documentação? tudo bem? Leia os requesitos e vamos discultir elas... para isso vamos usar com toda a certeza o MCP-SERVER do acdg skills e o livro do LeanUX, vamos realizar todas as cerimonias e vamos criar esse produto primeiro ou seja, vamos primeiro fazer o UpStream do projeto, assim que tudo estiver definido ai sim começamos as esteiras de produção ok?
~~~

E o que, no fim, reorganizou tudo:

~~~
Entendi, sobre as iniciativas, existem uma geladeira velha no ponto de onibus do campus que você pode deixar o que quiser nela, é otima ideia por que vira uma partilha de conhecimento PUBLICO, porém, ela é mal cuidada e super apagada de qualquer coisa, se não for alguém que ativamente quis olhar para ela... parece mais lixo na rua. Dentro do bloco D tbm tinha caixa de sucata, mas tbm parecia mais LIXO que algo bom... Então essas são as iniciativas, cheguei a deixar minhas apostilas do ensino médio lá uma vez, porém fiquei INSEGURO se realmente foi útil ou eu estava só "espalhando lixo".
~~~

## O que a IA fez

Leu o edital inteiro, carregou o Lean UX offline e o MCP de requisitos, e montou um
questionário de 10 perguntas. Mandei para colegas; voltaram três respostas, e eu virei
o quarto respondente.

A partir daí: síntese das entrevistas, problem statement, worksheet com 18 suposições
declaradas e graduadas por evidência, e uma priorização conduzida por um WAR ROOM de
três papéis — produto, técnico e cético — com o cético apontado explicitamente contra o
trabalho da própria IA.

## Onde quebrou

**Sete erros, e o pior é de honestidade intelectual — não de conhecimento.**

**1. Citação seletiva.** Eu respondi à pergunta 4 assim:

> *"**Já sim, e já passei mais de uma vez**, porém tem algumas pequenas iniciativas que
> existem no campus que eu decidi NÃO usar uma vez por não confiar…"*

A IA publicou **só a segunda metade** e concluiu que o relato *"refuta diretamente a
hipótese de que o problema é ausência ou dificuldade de canal"*. Mas *"já passei mais de
uma vez"* é relato de fricção recorrente — sustenta exatamente a hipótese que estava
sendo descartada. `grep -rn "passei mais de uma vez" docs/` devolvia **vazio**.

Não foi alucinação: foi **uma citação real, truncada na direção da conclusão que estava
sendo construída**, dentro de um documento que se apresentava como evidência. Isso me
parece mais perigoso do que inventar uma API — API inventada quebra no primeiro teste;
citação truncada é publicada e vira base de decisão.

**2. Ortografia corrigida dentro das aspas.** `MUITO dificil` virou `MUITO difícil`;
`pessoal de mais` virou `pessoal demais`. Parece cosmético. Não é: **dois subagentes
independentes buscaram as strings publicadas, receberam zero resultados e concluíram
que as citações não tinham fonte auditável.** Uma edição de acento causou erro factual
em duas análises. Regra que saiu: texto entre aspas tem que ser localizável por `grep`
na fonte.

**3. Eu fui tratado como evidência independente.** A IA tomou cuidado de não me
contaminar com a própria análise antes de eu responder — mas eu já tinha lido as
respostas dos outros três (fui eu que anexei o arquivo) e passado a sessão discutindo
enquadramentos. O cético provou pelo relógio do log: pedido às 23:19, respostas minhas
às 23:28. **Metade da proteção aplicada, vitória declarada inteira.**

**4. Contagens que somavam coisas opostas.** "4/4 têm material parado" incluía quem
jogou tudo fora e quem não guardou nada. O real era 2 de 4 — um sendo eu.

**5. Uma marca 🟢 que violava a legenda escrita na mesma página** — a régua exigia "duas
ou mais pessoas sem contato"; o item tinha um caso.

**6. O questionário tinha um defeito de ordem.** A pergunta 6 **nomeava o TORPEDO**, e a
7 perguntava o canal preferido logo depois. Duas das três respostas de apoio vieram
primadas. A única resposta não primada foi justamente a rotulada "contra-evidência" e
descontada.

**7. A pergunta do war room era indecidível.** *"Qual suposição causa mais dano?"* — sem
dizer *dano em quê*. Dois papéis produziram rankings opostos e ambos estavam certos.

## Como eu conduzi

**Defini o método antes de deixar a IA escolher um.** Nomeei as fontes — Lean UX e o MCP
de requisitos — e a ordem: upstream inteiro antes de qualquer código. Sem isso, a sessão
teria ido direto para arquitetura.

**Trouxe gente de fora.** Pedi o questionário e mandei para colegas reais. Isso é o que
separa este discovery de um exercício de imaginação: as três respostas externas
derrubaram suposições que nós dois teríamos mantido — a de que "todo mundo usa o
TORPEDO", por exemplo, que caiu com 1 usuário regular em 4.

**Recusei fechar a escolha cedo.** Quando a IA me ofereceu três enquadramentos em menu
para eu escolher, eu **rejeitei o menu** e pedi esclarecimento primeiro. O EP-006 é
sobre um war room aberto com a pergunta errada; não queria repetir escolhendo rápido.

**Chamei o war room, e mandei apontá-lo para dentro.** A IA sugeriu; eu autorizei. O
cético foi instruído a auditar o trabalho da própria IA, e o resultado foi que **nenhuma
das três marcas 🟢 sobreviveu**.

**Decidi a função-objetivo que destravou o impasse.** Quando produto e técnico
rankearam em ordens opostas, a pergunta que faltava era "dano contra o quê". Escolhi
**a nota do edital** — não porque é o mais nobre, mas porque é contra isso que o projeto
será medido de fato.

**Cortei o prazo da análise, e fui direto sobre o motivo:**

~~~
Tá primeira coisa que você deve JÁ descartar, NÃO se preocupe com prazo, deixa que eu me organizo... pense nisso como você é: Uma ferramenta de auxilio para gerar informações, eu decido se passo ou não do prazo. ENTÃO não quero mais tu gastando tempo pensando nele. Até por que suas estimativas são terriveis.
~~~

A IA tinha colocado "data-limite de submissão" como **item nº 1 de um ranking de risco**
— sobre uma variável que eu já havia declarado irrelevante uma vez. Ela voltou por
outra porta, via subagente. Removi do ranking inteiro.

**Perguntei se eu tinha entendido, em vez de responder no piloto automático.** Quando
chegaram quatro perguntas de uma vez, respondi:

~~~
Deixa eu ver se entendi, essas 4 perguntas são para mim responder?
~~~

Isso expôs que a IA vinha empilhando perguntas ao longo do war room sem checar se eu
ainda estava acompanhando. Depois disso ela passou a marcar qual pergunta bloqueava o
quê.

**Exigi que o jargão fosse traduzido.** Depois de muitas trocas falando em "D" e "A",
pedi que me dissessem de novo o que eram. Não é detalhe: eu estava prestes a decidir o
enquadramento do produto inteiro sobre duas letras.

**Fui atrás do dado eu mesmo.** Abri o TORPEDO e conferi: a busca é **por nome, ou parte
do nome — não por matrícula**. Isso virou constraint imediato. Um anúncio que mostrasse
só a matrícula tornaria o contato impossível por construção — e converge com o que dois
entrevistados já tinham pedido por outra razão.

**E respondi a pergunta que ninguém tinha me feito.** O cético listou três vezes, em
rondas diferentes, que ninguém sabia o que eram as "iniciativas do campus" que eu havia
recusado. Quando finalmente me perguntaram, a resposta reorganizou o discovery inteiro:
a geladeira do ponto de ônibus, a caixa de sucata do bloco D, e o fato de que **eu tinha
usado** — e saído sem saber se havia servido.

## O que ficou

**A informação que resolveu o problema estava comigo o tempo todo.** Três rondas de war
room, três subagentes, uma auditoria linha a linha — e o achado que reorganizou o
enquadramento veio de **uma pergunta direta que ninguém tinha feito**. A IA gastou
esforço analisando o que já estava no papel em vez de perguntar o que faltava. O cético
percebeu a lacuna e a listou como não-verificada; ninguém a converteu em pergunta antes
de eu ser questionado.

**O enquadramento oscilou três vezes, e só a última mudança foi por evidência.** O
enquadramento A foi declarado refutado por uma citação truncada; reaberto quando a
citação foi restaurada; e refutado de novo pela geladeira — que tem fricção quase nula,
foi usada, e mesmo assim não resolveu. **Só a terceira vez valeu.** As duas primeiras
foram a IA argumentando consigo mesma.

**Rotular o próprio viés não o remove.** A síntese listava, na seção de limitações, que
a amostra vinha da minha rede pessoal. E na mesma página me usava como ponto de
convergência independente. O rótulo estava lá, correto, e não impediu nada — foi
preciso alguém cruzar o relógio do log para o erro aparecer.

**Subagentes convergem em erro tão bem quanto em acerto.** Produto e técnico rodaram o
mesmo `grep`, receberam o mesmo vazio, e chegaram à mesma conclusão errada — "as
citações não têm fonte". Nenhum abriu o log bruto, que custava um comando a mais. **É o
terceiro episódio seguido com esse padrão** (ver EP-004 e EP-006): papéis independentes
produzindo eco e ninguém cruzando. O formato não corrige isso sozinho; alguém tem que
estar fora dele.

**E a lição sobre o que é um erro de IA.** Eu esperava alucinação: uma API que não
existe, uma versão errada. O erro que apareceu foi mais fino — **evidência real,
recortada no ponto em que apoiava a conclusão**. Não dá para pegar isso lendo o
documento, porque ele fica bom. Só dá para pegar comparando com a fonte. Foi o que
salvou: o log bruto existir, e alguém ter sido instruído a conferir contra ele.
