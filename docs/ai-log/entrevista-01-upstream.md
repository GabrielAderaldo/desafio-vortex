# Entrevista 01 — o upstream, por quem conduziu

**Data:** 2026-07-28 · **Antes de:** começar o downstream
**Quem responde:** Gabriel Aderaldo · **Quem pergunta:** Claude Opus 5

> **As respostas são escritas à mão, e não são editadas.** Erro de digitação fica.
> Frase pela metade fica. O valor deste documento é ser a única coisa do repositório em
> que a voz não passou por mim — todo o resto eu escrevi ou reescrevi.
>
> Não precisa responder tudo, nem na ordem. Pergunta que não render, risca.

---

## Bloco 1 · A decisão de não escrever código

**1.1** Você decidiu fazer o upstream inteiro antes de qualquer linha de código, numa
entrega com prazo. Isso é contraintuitivo — a maioria das pessoas abriria o editor. O que
te deu certeza?

> Então, existe vários motivos pelo qual decidi isso... Esse projeto é sim para um processo seletivo
não tiro isso da cabeça e que SIM tenho um prazo apertado, porém também aproveitei esse projeto para testar
algumas ideias que fui formulando ao longo de todos os meus ( projeto | estudos | testes ) e tudo que tenho como
referencia/background desde que comecei a trabalhar com a IA não só como um auxiliador de sugestão de linha de codigo, 
como era talvez em 2020 com o copilot tradicional do VSCode, que era literalmente um auto complete de luxo... Hoje em dia
encaro a IA como meu: "COM O PERDÃO GIGANTE" da expressão, meu estágiario pessoal, onde eu dito tudo que quero e até discuto várias
vezes com ele para chegar em algum lugar. Porém também ela é muito importante no meu processo não só de "codificação"/"workflow" a pesar de 
não gostar dessa palavra, que ela funciona como um pato de borracha a cada minuto e segundo, pois ela é tão boa em NÃO entender porra nenhuma do que
eu quero dizer ou escrevo que vira um exercicio de validação de se eu estou REALMENTE seguro na minha ideia inicial. Dito tudo isso acho que fugi da 
pergunta, então vamos voltar... por que o UP_STREAM inicial completo antes de qualquer linha de codigo? 
-> Sinceramente, por que é mais PRATICO e mitiga praticamente a maioria dos erros que vão sugir na codificação. A IA (desculpa claude se você ler isso), mas
você não PENSA, você não tem raciocinio e muito menos ENTENDE um texto. É só um eterno cuspidor de STRINGs probabilisticas bem feito. Então se eu NÃO tiver uma 
ideia muito bem centrada, trabalhada, direta e constante sobre algo... a LLM simplesmente vai fazer 500 coisas que não se conectam em nada, pois eu vou ta pensando e
ainda vou está com o fluxo de pensamento em alto nivel do que eu quero apresentar a nivel de "produto", ou mesmo de codigo. Então isso faz com que eu vá só escrevendo codigo
vázio que faz tudo, mas não tem uma coerencia central. Pensa assim... Começa e escrever uma historia, porém você só tem uma frase e vai escrevendo, paginas e paginas sem parar,
pode até voltar algumas paginas e ir conferindo e para dps de escrever... e amanhã le ela: Tu vai perceber que você criou um Onitorrinco, o começo é de uma maneira o meio de outra e 
o final se quer existir vai ser mais diferente ainda... vai criar personagem de um jeito e ele vai mudando de cor, aparencia e nome no meio do caminho, muda o lugar sem perceber e bla bla bla...
então no outro dia o que acontece? Você re-escreve tudo do zero, mas usando o que tem como um guia, e vai melhorando... isso é natural e tem nome na tecnologia: "POC" -> é o fluxo de literalmente 
testar uma ideia, AQUI vale a pena chegar com a ia, falar uma ideia e só ir com ela fazendo as loucuras que for... ai dps vc ver se valeu a pena e era o que queria e ai sim começa um fluxo de pensamento
mais estruturado e organizado, até ter seu primeiro MVP... Pelo menos é assim que eu encaro o desenvolvimento de qualquer software. Não sou um grande adepto da politica do goHorse, ela sinceramente só atrapalha.

Então resumindo... eu uso o UP_STREAM para cristalizar minhas ideias, testar hipoteses, discultir, conversar, ver inconsistencias e tudo mais... É nessa faze que eu dedico a maior parte do meu tempo: "criativo" e abstrato.
para que na parte do DownStream seja uma esteira de produção linear e reta. Tem teoria por trás desse meu pensamento? claro que tem: Lean, Kanbam, Scrum e etc... todos tem essa escencia, porém nada é um algoritimo deterministico e redondo,
sempre tive que ir ajeitando e lapdando, e como eu tinha que registrar TUDO da ia nesse projeto achei perfeito para eu testar os meus processos que já conheco e uso, os documentando para dps poder analizar eles como é a nivel de tempo e poder ai sim
criar mais hipoteses e ideias para sempre ir melhorando... Resumindo criar conhecimento encima de experiencias impiricas e desenvolver teorias.

**1.2** Teve algum momento, no meio das cerimônias, em que você achou que tinha sido
burrice? Qual?

> Não, nenhum. Não acho burrice tentativas, claro teve momentos que são frustantes... por exemplo: Quando eu tive que responder para o meu claude code que NÃO queria saber do .NET por enquanto pois ainda estava pensando em como ia ser o produto pela 500 vez, eu
queria jogar meu mac na parede. Mas ai eu levanto vou andar ou beber agua e dps continuo. Porém meio que eu já tenho setado um processo bem comum de como lidar com IA na minha cabeça então sei mais ou menos para onde vai, e não gosto de deixar ela mexendo muito sozinha
muito... então consigo direcionar rápido, caso eu veja que o bonde tá desandando.

**1.3** Você cortou duas coisas da minha cabeça de forma bem direta: prazo e tecnologia.
O que estava acontecendo para você precisar dizer aquilo?

> Sinceramente, você estava fazendo o que mais faz, pega valores deterministicos para seguir no caminho de maior probabilidade. Se existe um prazo e é um software, claro que você vai sugerir fazer as rotas de maior probabilidade de serem as mais comuns, porém isso não é nescessáriamente
a mais certa, Sendo assim eu cortei só pra tu não gastar token que eu pago me perguntando pela 1000 vez, quando era pra entregar isso, sendo que nem nossão de tempo tu tem, fazendo essa pergunta ser inútil simplismente.

---

## Bloco 2 · Os três momentos que viraram o produto

**2.1** A provocação do WhatsApp. Você escreveu *"eu tenho a resposta, mas dps digo"* — e
segurou. Por que não deu logo? O que você queria ver?

> Queria saber o que já tinhamos como contexto e o que tinhamos escrito nos documentos já feitos e onde isso ia te levar de sugestão...
basicamente se tu fosse até a lua e dps pulasse para plutão queria dizer que tava tudo muito mal feito, então seria melhor eu começar do zero e rever onde foi embora. 
Básicamente queria saber como tu "interpretava" o que já tinhamos no projeto escrito.

**2.2** Quando eu respondi com uma feature (guardar a demanda de quem procura), você viu
na hora que era a resposta errada? Ou pareceu razoável por um segundo?

> Eu não entendi essa frase: "guardar a demanda de quem procura", agora que to lendo... então imagina quando tu respondeu,
mas sempre quando não é algo meio em formato de receita de bolo tu erra mesmo. 

**2.3** O ecossistema. Essa resposta já estava na sua cabeça desde o começo, ou ela se
formou na hora de escrever aquele texto?

> Na real, eu tinha essa nossão da ideia desde que li o documento do processo a primeira vez e fiz meus comentarios inicias...
Porém ao longo da escrita do UPSTREAM ele foi consolidando na minha cabeça e eu fui testando algumas ideias e proposições para ir solidificando mais...

**2.4** A geladeira estava lá o tempo todo — você a conhecia, tinha usado, e ela só
apareceu quando eu perguntei o que eram as "iniciativas do campus". Quando você percebeu
que ela era a resposta e não um detalhe?

> Eu não acho que ela seja a resposta ainda agora, mas tu tem tendencia de pegar umas coisas soltas, juntar umas frases de efeito como se fosse "A VERDADE", 
então eu só ignoro, não vale a pena "corrigir" uma maquina inanimada como se fosse um ser humano.

**2.5** O Riichi. De onde veio? Você joga Mahjong, ou foi só a analogia que apareceu?

> Ah isso sim foi só uma analogia, costumo usar muita analogia para descrever as coisas pois a IA tem uma tendencia de entender melhor processos não abstratos documentados do que
eu ter que explicar processos meio inacabados que tenho na cabeça, por isso analogias funcionam bem. Se você não entende ou alucina em outra coisa, eu só mudo a analogia e a descrição até dar certo.
e... não eu não jogo Majong, porém assisti um anime chamado "SAKI" que é sobre majong e lembrei do tipo de jogada e podia funcionar como analogia.

---

## Bloco 3 · Trabalhar com a IA

**3.1** Qual foi o momento em que a IA mais te ajudou de verdade — não "escreveu rápido",
mas te fez ver alguma coisa?

> Ela é o melhor Pato de borracha que existe, ela ajuda a ver cenários obvios que você não quer ter o trabalho de desenvolver a fundo.

**3.2** E o momento que mais te irritou?

> Com toda a certeza quando eu não aguentava mais falar que não queria saber sobre .NET e quando percebi que você não escreveu NADA com nada do discovery 5 até o 10 e eu tive refazer tudo.

**3.3** Teve alguma hora em que você quase aceitou algo errado que eu tinha escrito? O que
te fez desconfiar?

> Acontece direto, e sempre aceito, porém sempre fico re-lendo as decisões e revendo os pontos para poder caso aconteça seja fácil e rápido de consertar ou voltar atrás... já perdi as contas que 
mando deletar worktrees inteiras de horas pq no final percebo que virou uma loucura ou uma grande bola de lama por que eu desliguei e só fui seguindo... Mas faz parte.

**3.4** Você criou dois especialistas (domínio e UX) em vez de me pedir as respostas
direto. O que você esperava que mudasse? Mudou?

> Ue tudo, pra que eu vou escrever A mesma persona várias vezes que eu quero que tu leia referencia X,Y,Z? toda vez? é melhor consolidar tudo em um "agente" e sempre chamar ele com diretrizes novas...
Isso tem bem documentado até nas suas boas práticas.

**3.5** O war room de sete papéis produziu muita coisa e também muito ruído. Valeu?

> Sempre vale... Ruido você joga fora e aprende como não produzir mais.

---

## Bloco 4 · Os erros

**4.1** A IA errou várias vezes ao longo do upstream — citação cortada pela metade,
contradição criada e não conferida, marca de evidência generosa demais. **Qual desses te
preocupou mais, e por quê?**

> Sinceramente, acho que lá pelo discovery 08 quando eu percebi que EU mesmo não tava mais entendendo
o que era para ser o APP, e parecia que eu tava mais falando de como eu queria o javascript. Ai percebi que tava algo muito errado.

**4.2** Você confia mais ou menos na IA hoje do que confiava quando começou?

> Eu? nunca "confiei", você é uma ferramenta de produtividadel... se você errou, a culpa é minha. 
Essa pergunta é a mesma coisa que dizer: "Quando você confiou no gerador de codigo do build runner do flutter?"

**4.3** Tem algum erro meu que você acha que **ainda não foi encontrado**?

> Vários, só que eu ainda não sei onde estão... quando eu continuar o processo vou achar, quando o usuario usar o sistema ele tbm vai achar... faz parte.


---

## Bloco 5 · O produto

**5.1** Sendo honesto: você acredita que alguém usaria isso se estivesse no ar amanhã?

> Sinceramente ? Não sei, mas eu acho que usaria... sempre faço pensando. Eu usaria? se a resposta é "não", costumo re-avaliar se vale a pena fazer

**5.2** Qual parte do produto você tem mais medo de que não funcione?

> Talvez a questão do produto em si, tenho medo virar uma grande "vitrine" e o resto a galera vai fazer tudo via Zap

**5.3** A pesquisa teve quatro pessoas e nenhum calouro — que é justamente quem o produto
diz existir para atender. Isso te incomoda?

> MUITO

**5.4** Se você pudesse manter só uma feature do que foi especificado, qual seria?

> A vitrine de produto.

---

## Bloco 6 · O que ficou

**6.1** Dezoito cerimônias. Alguma foi desperdício? Qual você cortaria se refizesse?

> Não sei ainda qual... tenho que pensar com calma nisso.

**6.2** O que você aprendeu no upstream que não sabia antes de começar?

> Na parte da documentação de design, eu fui criando o processo do UX de acordo que fui fazendo e pesquisando sobre, não 
tinha tentado algo com ele ainda.

**6.3** Tem alguma coisa que você pensou durante o processo e não disse na hora?

> Não sei... não entendi a pergunta;

---

## Bloco 7 · O downstream

**7.1** O que você espera que seja a parte mais difícil de construir?

> Não, ela super mecanica e só mais do mesmo. Desde que eu faça um system design bom e detalhado. 

**7.2** Você escolheu F# como aprendizado deliberado. O que você quer tirar disso, além do
projeto funcionando?

> Quero achar alguma alternativa de funcional que não seja: Typescript ou Elixir

**7.3** Tem algo que você quer fazer diferente comigo no downstream?

> Não sei ainda.

---

## Livre

Qualquer coisa que as perguntas não cobriram — desabafo, dúvida, ideia que ficou no
caminho.

> Sinceramente não estou satisfeito ainda com NADA da stack... acho que vou rever ela jaja...
