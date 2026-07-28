# EP-008 — Dez cerimônias sem nunca perguntar por que o produto deve existir

**Data:** 2026-07-28
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code · WAR ROOM com 7 papéis · skills `design:user-research` e `design:ux-copy` · MCPs `acdg-skills` e `security`
**Relacionado:** EP-007 · ADR-0004

## Contexto

Depois das dez cerimônias do upstream, do PRD e dos critérios de aceite, o projeto tinha
**doze documentos e nenhuma linha de código**. A metodologia estava impecável: problem
statement com evidência, suposições graduadas, hipóteses no formato canônico, story map,
critérios testáveis. Um war room de sete especialistas auditou tudo e achou defeitos
reais.

E ninguém, em nenhum momento, tinha perguntado **por que este produto deveria existir**.

## O prompt

O que interrompeu a produção de documentos:

~~~
Vou ser muito sincero... Esse discovery dps do 4 está uma coxa de retalhos. Junte tudo que existe do, 5 até o FINAL e quero que você ME explique em FLUXO mermed usando o mcp do mermed mesmo (fluxograma) TODAS as jornadas do usuario e suas experiencias, quero saber o que ele faz a nivel de produto. Simples, quero entender... ele abre o app iai?
~~~

E, depois de ver o produto desenhado, a provocação que o derrubou:

> *"Aqui vai uma provocação IMPORTANTE... o que vai diferenciar o nosso sistema de um
> whats app? Sinceramente, seria muito mais barato só fazer a vitrine e deixar os
> contatos e pronto... assim fazendo LITERALMENTE Só um espaço de CADASTRO e um ESPAÇO
> de publicação quase como um instagram... sendo talvez fazer via instagram seja até
> melhor... eu tenho a resposta, mas dps digo.."*

> ⚠️ **Esta citação não está em `.ai-log/raw-prompts.md`.** Foi escrita como observação
> numa resposta de `AskUserQuestion`, e o hook `UserPromptSubmit` **não captura esse
> caminho** — só prompts digitados no campo normal. É uma lacuna do instrumento de
> diário, descoberta ao escrever este episódio. O trecho acima foi transcrito do
> histórico da sessão, não do log.

## O que a IA fez

Consolidou as oito cerimônias numa página única com seis fluxogramas — as jornadas do
visitante, da identificação, de publicar, de querer um item, de fechar o gesto e de
instalar o app. **Foi a primeira vez em todo o projeto que o produto foi desenhado
inteiro.**

E ao desenhar, dois buracos apareceram sozinhos, que nenhum dos doze documentos tinha
exposto: o produto depende de um gesto (marcar quem recebeu) cujo maior benefício vai
para terceiros, e a vitrine no dia zero mostra zero honestamente — zero que parece
abandono, que é exatamente o problema que o produto ataca.

## Onde quebrou

**O erro não foi de execução. Foi de pergunta.**

Cada cerimônia foi feita corretamente, com fonte citada e método respeitado. O problem
statement tinha evidência de campo. As hipóteses tinham os quatro campos. O war room
achou defeitos verdadeiros — inclusive que **nenhuma das quatorze histórias coletava o
nome do usuário**, embora o fluxo principal prometesse entregá-lo.

Mas sete especialistas passaram um round inteiro auditando documentos **que ninguém
tinha visto por inteiro**, e a pergunta que teria derrubado metade do trabalho —
*"isso não é um grupo de WhatsApp com passos a mais?"* — nunca foi feita por nenhum
deles, nem por mim.

**A IA otimizou o rigor do método e nunca testou a existência do produto.** É o mesmo
padrão do EP-006, com outra roupa: lá foi rigor aplicado a uma variável não pontuada;
aqui, rigor aplicado a um produto cuja razão de existir ninguém tinha estabelecido.

E houve um segundo erro, este de leitura de contexto: com o produto ainda indefinido, a
IA fechava cada recomendação com "e depois subir o esqueleto técnico". A correção veio
sem rodeios:

~~~
Vou te falar isso uma vez só tá? PARA de pensar em tecnologia. CAGUEI PARA: " O .NET SDK não está instalado," Isso é problema da galera da esteira de produção do time tecnico, AINDA NEM PRODUTO TEMOS, o que vamos fazer com o .NET se nem ideia direito desenvolvemos. EU LHE DIREI quando formos para o DOWN_STREM blz? Então vou perguntar dnv... o que podemos fazer agr?
~~~

## Como eu conduzi

**Reconheci a colcha de retalhos e mandei parar de produzir documento.** Dez cerimônias
tinham gerado oito arquivos que só existiam juntos na cabeça da IA. Pedir o produto
desenhado de uma vez expôs isso em uma página.

**Fiz a provocação que ninguém tinha feito** — e guardei minha resposta, para ver se a
IA chegava sozinha. Ela chegou perto e errou o ângulo: propôs "guardar a demanda de quem
procura", uma feature de eficiência. Continuava tratando o produto como problema de
transação.

**Dei a resposta certa, que é de propósito e não de funcionalidade:**

~~~
A resposta é o ECOSSISTEMA... 
A vitrine é o produto. Essa é a verdade, pense bem... o objetivo do projeto é o "DESAPEGA" ou seja é a pessoa passar a diante para outro o que existe e criar uma rede de colaboração entre ALUNOS | Pessoas que frequentam o campos, e no macro? Criar conecções que antes não existiam... ou seja agreggar em vez de separar. Ou seja Devemos estimular a troca de conhecimento e como gostam de falar: "networking", o campus com esse sistema estaria dando a oportunidade para uma turma de primeiro semestre QUE é NOVO no ambiente conhecer, falar e aproveitar o campos em SI. e não só ir ver aula e ir embora, isso, um EAD faz... uma UNIVERSIDADE é um ecosistema inteiro, e esse projeto deve ajudar nisso, deve aproximar, deve-se estimular... então minha resposta é: "A questão não é facilidade de entregar algo... não devemos pegar uma demanda... não devemos lucrar... o sistema é para uma UNIVERSIDADE, devemos promover troca de conhecimento de toda forma. Resumindo: "Devemos estimular a estudantes se conhecerem e trocarem conhecimento e re-aproveita
~~~

**Recusei a expansão de escopo que a própria resposta abria.** Se o item é pretexto para
encontro, o que se passa adiante não precisa ser objeto — monitoria, resumo, carona.
Mantive o escopo em itens por ser um processo seletivo, e guardei a expansão como visão.
Propósito amplo com escopo estreito.

**E cortei a puxada para tecnologia** antes que virasse hábito. Modelagem de domínio é
produto; escolha de framework é downstream, e quem decide quando trocar é o dono do
produto.

## O que ficou

**A pergunta de existência não está em nenhuma cerimônia do Lean UX.** O livro tem
declaração de suposições, hipóteses, MVP, experimentos — e todos pressupõem que o
produto deve existir. A pergunta *"por que isto não é um grupo de WhatsApp?"* não tem
lugar no processo, e é a que decide se todo o resto vale alguma coisa. Passei por dez
cerimônias sem cruzá-la.

**Rigor de método não protege contra produto sem razão de ser — e pode disfarçá-lo.**
Doze documentos bem escritos, com citação de fonte e evidência de campo, davam a
impressão de solidez. A provocação de três linhas derrubou mais do que sete
especialistas auditando por horas.

**A resposta certa era de propósito, e a IA só produzia respostas de funcionalidade.**
Quando perguntei o que nos diferenciava, ela ofereceu uma feature. O que faltava não era
o que o sistema faz, era **para que ele serve**: o grupo de WhatsApp conecta quem já
está conectado — é fechado por definição, e o calouro não está nele. Um sistema aberto
do campus pode apresentar duas pessoas que não se conhecem. Isso não é feature; é a
razão de existir.

**E o enquadramento anterior não estava errado — estava incompleto.** A geladeira falha
porque é anônima, e anônimo é o oposto de conexão. *"Fiquei inseguro se realmente foi
útil"* não é falta de informação: é falta de vínculo. Se você entrega na mão de alguém
que te agradece, a insegurança não existe. O que faltava nunca foi o dado — era a
pessoa. O discovery inteiro descreveu corretamente o sintoma de algo que só ficou visível
quando alguém perguntou por que o produto deveria existir.

**Uma lição sobre o próprio diário:** a citação mais importante deste episódio não foi
capturada pelo hook, porque veio por um caminho de entrada que ele não observa. Um
instrumento de registro que perde justamente a intervenção decisiva é um instrumento
com ponto cego — e só se descobre isso indo procurar a frase para citá-la.
