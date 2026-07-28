// =============================================================================
//  Passa Adiante — Síntese do Upstream
//  Desafio técnico · Laboratório Vortex · UNIFOR
// =============================================================================

#let tinta      = rgb("#1C1F1A")
#let tinta-mole = rgb("#4A5147")
#let apagado    = rgb("#6E766A")
#let ambar      = rgb("#B4530A")
#let musgo      = rgb("#4D7C5A")
#let alerta     = rgb("#A3342A")
#let fundo      = rgb("#FBFBF8")
#let linha      = rgb("#DDDED6")
#let ambar-leve = rgb("#FAF0E6")
#let musgo-leve = rgb("#EDF3EE")
#let cinza-leve = rgb("#F1F2F0")

#let display = "Avenir Next"
#let corpo   = "Charter"
#let mono    = "Menlo"

#set document(
  title: "Passa Adiante — Síntese do Upstream",
  author: "Gabriel Vieira Soriano Aderaldo",
)

#set page(
  paper: "a4",
  margin: (top: 2.6cm, bottom: 2.4cm, left: 2.4cm, right: 2.4cm),
  fill: fundo,
  footer: context {
    set text(font: mono, size: 7.5pt, fill: apagado)
    if counter(page).get().first() > 1 [
      #grid(columns: (1fr, auto),
        align(left)[PASSA ADIANTE · síntese do upstream],
        align(right)[#counter(page).display()])
    ]
  },
)

#set text(font: corpo, size: 10.5pt, fill: tinta, lang: "pt", region: "br")
#set par(justify: true, leading: 0.72em, spacing: 1.15em, first-line-indent: 0em)

#show heading: set text(font: display, fill: tinta, hyphenate: false)
#let parte = counter("parte")
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  parte.step()
  block(above: 0.4em, below: 1.1em)[
    #context text(font: mono, size: 8pt, fill: ambar, tracking: 1.6pt)[
      PARTE #parte.display()
    ]
  ]
  block(above: 0em, below: 1.4em)[#text(size: 26pt, weight: 600)[#it.body]]
  line(length: 100%, stroke: 0.6pt + linha)
  v(0.6em)
}
#show heading.where(level: 2): it => block(above: 1.9em, below: 0.75em)[
  #text(size: 15pt, weight: 600)[#it.body]
]
#show heading.where(level: 3): it => block(above: 1.4em, below: 0.55em)[
  #text(size: 11.5pt, weight: 600, fill: tinta-mole)[#it.body]
]

#show raw.where(block: false): it => box(
  fill: cinza-leve, inset: (x: 3.5pt, y: 1.5pt), outset: (y: 2.5pt), radius: 2pt,
  text(font: mono, size: 8.5pt, fill: tinta-mole)[#it]
)

#show link: it => text(fill: ambar)[#it]

// ── componentes ──────────────────────────────────────────────────────────────

#let fala(quem, texto) = block(
  width: 100%, breakable: false, fill: white, stroke: (left: 2.5pt + musgo, rest: 0.5pt + linha),
  inset: (x: 14pt, y: 12pt), radius: 2pt, above: 1.2em, below: 1.2em,
)[
  #text(font: mono, size: 7.5pt, fill: musgo, tracking: 0.8pt)[#upper(quem)]
  #v(0.35em)
  #text(size: 10pt, style: "italic", fill: tinta-mole)[#texto]
]

#let destaque(titulo, corpo-txt) = block(
  width: 100%, breakable: false, fill: ambar-leve, stroke: (left: 2.5pt + ambar),
  inset: (x: 14pt, y: 12pt), radius: 2pt, above: 1.3em, below: 1.3em,
)[
  #text(font: display, size: 10.5pt, weight: 600, fill: ambar)[#titulo]
  #v(0.4em)
  #text(size: 9.8pt)[#corpo-txt]
]

#let nota(corpo-txt) = block(
  width: 100%, breakable: false, fill: cinza-leve, inset: (x: 13pt, y: 11pt), radius: 2pt,
  above: 1.2em, below: 1.2em,
)[#text(size: 9.5pt, fill: tinta-mole)[#corpo-txt]]

#let episodio(num, titulo, subtitulo, conteudo) = {
  block(above: 2.4em, below: 0.9em)[
    #grid(columns: (auto, 1fr), gutter: 12pt, align: horizon,
      block(fill: tinta, radius: 3pt, inset: (x: 9pt, y: 6pt))[
        #text(font: mono, size: 9pt, fill: fundo, weight: 600)[EP-#num]
      ],
      text(font: display, size: 14pt, weight: 600)[#titulo]
    )
    #v(0.3em)
    #text(font: display, size: 9.5pt, fill: apagado, style: "italic")[#subtitulo]
  ]
  conteudo
}

#let numero(n, rotulo) = align(center)[
  #text(font: display, size: 22pt, weight: 600, fill: ambar)[#n]
  #v(-0.35em)
  #text(font: mono, size: 7.5pt, fill: apagado)[#rotulo]
]

// ── CAPA ─────────────────────────────────────────────────────────────────────

#page(margin: (top: 5cm, bottom: 3cm, left: 3cm, right: 3cm), footer: none)[
  #text(font: mono, size: 8.5pt, fill: ambar, tracking: 2.4pt)[
    LABORATÓRIO VORTEX · DESAFIO TÉCNICO
  ]

  #v(1.4cm)

  #text(font: display, size: 44pt, weight: 600)[Passa Adiante]

  #v(0.15cm)
  #text(font: display, size: 17pt, fill: tinta-mole)[
    Como se decide o que construir #linebreak() antes de escrever a primeira linha
  ]

  #v(1.5cm)
  #line(length: 38%, stroke: 1.5pt + ambar)
  #v(1.5cm)

  #block(width: 82%)[
    #text(size: 11pt, fill: tinta-mole)[
      Este documento conta o que aconteceu entre receber um edital e ter um produto
      definido. Não é um relatório de features: é o registro de um processo que mudou
      de ideia três vezes, errou em público, e foi corrigido por perguntas que só um
      humano faria.

      #v(0.5em)
      Vem junto o Diário de Bordo completo — nove episódios de trabalho com IA
      generativa, incluindo os erros — e uma entrevista respondida à mão, sem edição.
    ]
  ]

  #v(1fr)

  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(font: mono, size: 7.5pt, fill: apagado, tracking: 1pt)[AUTOR]
      #v(0.3em)
      #text(size: 10.5pt)[Gabriel Vieira Soriano Aderaldo]
      #v(0.2em)
      #text(size: 9pt, fill: apagado)[Ciência da Computação · UNIFOR]
    ],
    [
      #text(font: mono, size: 7.5pt, fill: apagado, tracking: 1pt)[PERÍODO]
      #v(0.3em)
      #text(size: 10.5pt)[26 a 28 de julho de 2026]
      #v(0.2em)
      #text(size: 9pt, fill: apagado)[18 cerimônias · 9 episódios · 0 linhas de código]
    ]
  )
]

// ── SUMÁRIO ──────────────────────────────────────────────────────────────────

#page(footer: none)[
  #text(font: display, size: 22pt, weight: 600)[O que tem aqui dentro]
  #v(0.4cm)
  #line(length: 100%, stroke: 0.6pt + linha)
  #v(0.8cm)

  #set text(size: 10.5pt)
  #show outline.entry.where(level: 1): it => {
    v(11pt, weak: true)
    text(font: display, weight: 600, size: 11.5pt)[#it]
  }
  #outline(title: none, indent: 1.2em, depth: 2)

  #v(1fr)
  #nota[
    *Uma observação sobre como isto foi escrito.* Tudo neste documento passou pela mão
    de uma IA, menos uma coisa: as respostas da entrevista, na última parte. Elas estão
    exatamente como foram digitadas — erro de digitação, palavrão e frase pela metade
    inclusive. É a única parte em que a voz não foi filtrada, e é de propósito.
  ]
]

// =============================================================================
= Afinal, o que é isso aqui?
// =============================================================================

Todo desafio técnico começa igual: você recebe um documento, lê os requisitos, e a
vontade é abrir o editor e começar a escrever. É o que quase todo mundo faz.

Este projeto fez o contrário. Passou dois dias inteiros sem escrever uma única linha de
código de aplicação — e o que saiu disso são dezoito cerimônias de descoberta de produto,
dois documentos de decisão arquitetural, um modelo de domínio, e um produto que mudou de
ideia três vezes antes de alguém encostar num teclado.

A pergunta óbvia é: *por quê?* E a resposta está na entrevista no fim deste documento,
dita por quem decidiu:

#fala("Gabriel, sobre a decisão de não escrever código")[
  Sinceramente, por que é mais PRATICO e mitiga praticamente a maioria dos erros que vão
  sugir na codificação. \[...\] se eu NÃO tiver uma ideia muito bem centrada, trabalhada,
  direta e constante sobre algo... a LLM simplesmente vai fazer 500 coisas que não se
  conectam em nada.
]

E a analogia que ele usa para explicar é boa demais para eu resumir:

#fala("ainda ele")[
  Pensa assim... Começa e escrever uma historia, porém você só tem uma frase e vai
  escrevendo, paginas e paginas sem parar \[...\] e amanhã le ela: Tu vai perceber que
  você criou um Onitorrinco, o começo é de uma maneira o meio de outra e o final se quer
  existir vai ser mais diferente ainda.
]

O upstream existe para não produzir ornitorrincos.

== O que você vai ler aqui

Este documento tem quatro partes, e elas ficam progressivamente mais honestas.

A *primeira* conta como o problema foi descoberto — incluindo a parte em que ele foi
descoberto errado, duas vezes. A *segunda* mostra o produto que saiu disso, e o que ele
deliberadamente não faz. A *terceira* é o Diário de Bordo: nove episódios de trabalho com
IA, cada um deles registrando um erro real e como ele foi pego. A *quarta* é uma
entrevista sem edição nenhuma.

Se você só tem tempo para uma, leia a terceira. É onde as coisas dão errado.

// =============================================================================
= A parte em que o problema é descoberto errado
// =============================================================================

O edital pedia um marketplace de economia circular no campus: estudantes cadastram
material que não usam mais, outros encontram. CRUD, vitrine, PWA. Direto ao ponto.

O primeiro instinto foi construir exatamente isso. O segundo foi perguntar para quem
seria.

== Quatro pessoas, e uma pergunta que ninguém tinha feito

A pesquisa foi pequena e o documento assume isso desde a primeira linha: quatro
respondentes, sendo um deles o próprio autor. Não é estatística e nunca foi tratada como
tal — o instrumento inteiro foi desenhado para render *comportamento passado*, não
intenção declarada.

#nota[
  *Por que isso importa.* Perguntar "você usaria um app assim?" produz um "sim" que não
  vale nada. Perguntar "o que você fez com o material do semestre passado?" produz uma
  história. O questionário aplicado tinha dez perguntas e nenhuma delas era do primeiro
  tipo.
]

As respostas convergiram num lugar inesperado. Ninguém falou em falta de lugar para
anunciar. O que apareceu foi outra coisa:

#fala("P01, ex-aluna de Jornalismo")[
  já quis doar todas as minhas apostilas do ensino médio porém não consegui ir a fundo
  para descobrir um local seguro e objetivo para fazer isso
]

#fala("P02, Engenharia de Computação — perguntado para onde iria desapegar")[
  Biblioteca?
]

Aquele ponto de interrogação virou uma persona inteira. Não é rejeição do caminho — é
desconhecimento de que existe caminho.

== A geladeira

Mas o achado que reorganizou o projeto veio de uma pergunta lateral, feita quase por
acaso: *o que exatamente são essas "iniciativas do campus" que você mencionou?*

#fala("P04 — e esta resposta mudou o produto")[
  existem uma geladeira velha no ponto de onibus do campus que você pode deixar o que
  quiser nela, é otima ideia por que vira uma partilha de conhecimento PUBLICO, porém,
  ela é mal cuidada e super apagada de qualquer coisa, se não for alguém que ativamente
  quis olhar para ela... parece mais lixo na rua. \[...\] cheguei a deixar minhas
  apostilas do ensino médio lá uma vez, porém fiquei INSEGURO se realmente foi útil ou eu
  estava só "espalhando lixo".
]

Existe, no campus da UNIFOR, uma geladeira velha num ponto de ônibus onde qualquer pessoa
pode deixar material para quem quiser. *Fricção zero.* Você chega e larga.

E mesmo assim não funciona.

#destaque("O que a geladeira provou")[
  Se o problema fosse "desapegar dá trabalho", a geladeira teria resolvido. Ela tem a
  menor fricção fisicamente possível, foi usada, e o problema continuou. *Facilitar o ato
  de anunciar não é a alavanca.* O que falha é o que acontece depois: o gesto fica sem
  resposta.
]

== E aí veio a provocação que derrubou tudo

Com o produto desenhado e documentado, veio a pergunta que nenhuma cerimônia do método
tinha feito:

#fala("Gabriel, no meio do processo")[
  o que vai diferenciar o nosso sistema de um whats app? Sinceramente, seria muito mais
  barato só fazer a vitrine e deixar os contatos e pronto \[...\] sendo talvez fazer via
  instagram seja até melhor... eu tenho a resposta, mas dps digo..
]

E ele estava certo. Um grupo de WhatsApp *já resolve* a dor da geladeira: você posta a
foto do livro, alguém responde, você entrega e sabe que serviu. O canal é identificado e
síncrono. A insegurança não existe ali.

A IA respondeu com uma feature. Errou.

#fala("A resposta certa, dele")[
  A vitrine é o produto. \[...\] o objetivo do projeto é o "DESAPEGA" ou seja é a pessoa
  passar a diante para outro o que existe e criar uma rede de colaboração entre ALUNOS |
  Pessoas que frequentam o campos, e no macro? Criar conecções que antes não existiam...
  \[...\] uma UNIVERSIDADE é um ecosistema inteiro, e esse projeto deve ajudar nisso, deve
  aproximar, deve-se estimular.
]

#destaque("A diferença é estrutural, não de funcionalidade")[
  Um grupo de WhatsApp *conecta quem já está conectado*. Ele é fechado por definição —
  você precisa ser adicionado por alguém que já te conhece. O calouro do primeiro semestre
  não está em nenhum, e é exatamente ele que mais precisa.

  Um sistema aberto do campus pode apresentar duas pessoas que não se conhecem. Isso não
  é uma feature que falta no WhatsApp; é uma propriedade que ele não pode ter.
]

E isso não jogou o discovery fora — explicou ele. A geladeira falha porque é *anônima*,
e anônimo é o oposto de vínculo. *"Fiquei inseguro se foi útil"* não é falta de
informação; é falta de pessoa. Se você entrega na mão de alguém que agradece, a
insegurança nunca aparece.

// =============================================================================
= O produto que saiu disso
// =============================================================================

O enquadramento final ficou registrado num documento de decisão arquitetural, e cabe numa
frase:

#align(center)[
  #block(width: 88%, inset: (y: 10pt))[
    #text(font: display, size: 13.5pt, weight: 600, fill: ambar)[
      O produto existe para agregar o estudante ao ecossistema da universidade. O item é o
      pretexto do encontro, não o objeto do serviço.
    ]
  ]
]

== Como funciona, em sete passos

#grid(columns: (auto, 1fr), gutter: 14pt, row-gutter: 11pt,
  text(font: mono, size: 9pt, fill: ambar)[01],
  [Alguém publica um item — título, categoria, se é doação ou venda, e *onde costuma estar no campus*.],
  text(font: mono, size: 9pt, fill: ambar)[02],
  [O item aparece na vitrine pública. Qualquer pessoa vê, sem se identificar.],
  text(font: mono, size: 9pt, fill: ambar)[03],
  [Quem quer o item toca em *Tenho interesse* — e é isso que revela o contato de quem publicou. O clique não é burocracia: é como se obtém o contato.],
  text(font: mono, size: 9pt, fill: ambar)[04],
  [As duas pessoas conversam #text(fill: apagado)[fora do produto], no chat institucional que o campus já tem.],
  text(font: mono, size: 9pt, fill: ambar)[05],
  [Quem publicou *reserva* o item para uma delas. O item ganha um selo, e quem vai receber ganha um *código*.],
  text(font: mono, size: 9pt, fill: ambar)[06],
  [Encontram-se #text(fill: apagado)[num ponto conhecido do campus] — o DJ, o CC, a biblioteca.],
  text(font: mono, size: 9pt, fill: ambar)[07],
  [Quem recebe mostra o código. Quem publicou digita e confirma. *O gesto fecha.*],
)

#v(0.4em)

#nota[
  Os dois passos em cinza acontecem *fora do produto*, e isso é decisão, não lacuna. O
  campus já tem um chat institucional; construir outro seria pedir que as pessoas adotem
  um lugar novo para fazer o que já fazem.
]

== Duas ideias que valem mais que o resto

=== O código, e por que ele existe

Até certo ponto do projeto, "entregue" era uma declaração unilateral: quem publicou
marcava, e o sistema acreditava. O problema é que o sistema não sabia de nada — e um
estado chamado `Entregue` num sistema que nunca viu entrega nenhuma está mentindo no
próprio nome.

O código resolve isso. Ele nasce quando a reserva acontece, vai *só* para quem vai
receber, e quem publicou precisa dele para fechar o ciclo. Ninguém fecha sozinho.

#destaque("O que o código prova — e o que ele não prova")[
  *Prova:* que as duas pessoas participaram.

  *Não prova:* que o encontro foi presencial. Nada impede mandar o código por mensagem, e
  o produto não tenta impedir — policiar isso exigiria localização, que o modelo de dados
  recusa explicitamente.

  Ainda assim é uma mudança de patamar: sai de *"uma pessoa afirmou"* para *"as duas
  participaram"*.
]

=== Os pontos de encontro, que resolvem três coisas de uma vez

O anúncio indica onde a pessoa costuma estar — o DJ, o CC, a biblioteca. Lugares
conhecidos, movimentados, fáceis de achar.

#grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
  block(fill: white, stroke: 0.5pt + linha, inset: 11pt, radius: 2pt)[
    #text(font: display, size: 10pt, weight: 600)[Segurança]
    #v(0.3em)
    #text(size: 9pt, fill: tinta-mole)[Ninguém marca encontro com um estranho num canto vazio do campus.]
  ],
  block(fill: white, stroke: 0.5pt + linha, inset: 11pt, radius: 2pt)[
    #text(font: display, size: 10pt, weight: 600)[Onboarding]
    #v(0.3em)
    #text(size: 9pt, fill: tinta-mole)[O calouro *aprende onde ficam os lugares* enquanto pega um livro emprestado.]
  ],
  block(fill: white, stroke: 0.5pt + linha, inset: 11pt, radius: 2pt)[
    #text(font: display, size: 10pt, weight: 600)[Propósito]
    #v(0.3em)
    #text(size: 9pt, fill: tinta-mole)[O encontro deixa de ser abstrato e vira um lugar com nome e história.]
  ],
)

O "DJ" é o exemplo perfeito do que significa pertencer ao campus: o apelido vem dos
blocos D e J, e por anos foi onde o pessoal de tecnologia se reunia para jogar card game.
Veterano sabe o que é. Calouro não. *O produto ensina esse vocabulário* — e essa ideia
nasceu de uma entrevista, não de uma reunião: a P01, perguntada sobre o que faltou no
questionário, pediu sozinha *"uma pergunta sobre lugares/postos de doação"*.

== O que o produto deliberadamente não faz

#grid(columns: (auto, 1fr), gutter: 12pt, row-gutter: 9pt,
  text(size: 9.5pt, weight: 600)[Chat interno],
  text(size: 9.5pt, fill: tinta-mole)[O campus já tem um. Construir outro é pedir que adotem um lugar novo para o que já fazem.],
  text(size: 9.5pt, weight: 600)[Avaliação de pessoas],
  text(size: 9.5pt, fill: tinta-mole)[Não responde à objeção real, que é sobre o material ter bom cuidado. Saber quem é a pessoa não diz como ela vai tratar a coisa.],
  text(size: 9.5pt, weight: 600)[Notificações],
  text(size: 9.5pt, fill: tinta-mole)[O uso é episódico — duas ou três vezes por ano. Avisar quem abre o app tão pouco é incômodo, não serviço.],
  text(size: 9.5pt, weight: 600)[Busca por texto],
  text(size: 9.5pt, fill: tinta-mole)[Não foi pedida pelo edital e não apareceu em nenhuma entrevista.],
  text(size: 9.5pt, weight: 600)[Verificar quem é da UNIFOR],
  text(size: 9.5pt, fill: tinta-mole)[Não há como. E o produto assume isso: nenhuma tela afirma identidade, porque nenhuma pode.],
)

// =============================================================================
= Diário de Bordo: nove episódios
// =============================================================================

Esta é a parte em que as coisas dão errado.

Cada episódio abaixo registra um momento em que a IA errou — ou em que o processo errou —
e como o erro foi encontrado. Nenhum foi escrito depois, para parecer bem: todos foram
registrados no dia, com o prompt original preservado sem maquiagem.

#nota[
  *Por que isso é o mais importante do documento.* Um diário em que a IA nunca erra não
  convence ninguém que já usou uma. O que separa uso maduro de uso ingênuo não é a
  ausência de erro — é ter método para encontrá-lo antes que ele vire código.
]

#episodio("001", "A escolha do task runner", "Quando não há dado, admita que não há")[
  A primeira decisão do projeto foi qual ferramenta usar para automatizar tarefas. A IA
  produziu uma comparação convincente entre alternativas — e nenhuma daquelas afirmações
  tinha sido verificada.

  *O que ficou:* decisão sem dado é chute com formatação bonita. O projeto passou a exigir
  que toda afirmação viesse rotulada como *verificado*, *documentado* ou *inferido* — e a
  regra sobreviveu até o último episódio.
]

#episodio("002", "A correção que estava errada", "Conhecimento de modelo tem prazo de validade")[
  A IA tentou "corrigir" a versão do Docker Compose declarada no projeto, com confiança
  total, usando informação desatualizada. A correção teria quebrado o que funcionava.

  *O que ficou:* versões entram no projeto como número explícito, nunca como "a mais
  recente". O modelo não sabe em que ano está.
]

#episodio("003", "Documentei a ferramenta errada", "Configurar sem verificar o alvo")[
  Foram escritas configurações detalhadas de permissão para uma ferramenta que este
  projeto não usa e nunca usaria. Documentação impecável, produto errado.

  *O que ficou:* antes de configurar, confirmar qual ferramenta está em jogo. Parece
  óbvio; foi preciso errar para virar regra.
]

#episodio("004", "O portão que eu declarei testado três vezes", "E que não fechava")[
  Um mecanismo de proteção foi declarado testado — três vezes, com oito casos passando — e
  tinha um contorno alcançável com duas edições comuns. Os testes viviam em mensagens de
  chat e morriam com elas; nada os re-executava.

  *O que ficou:* uma suíte de testes de verdade, com 54 casos, ligada ao portão de
  verificação. E o hábito de *validar por sabotagem*: quebrar o mecanismo de propósito
  para ver se o teste pega.
]

#episodio("005", "Quando a teoria confirma a prática", "O episódio sem erro")[
  Nem todo episódio é sobre falha. Aqui, a fundamentação teórica encontrada depois
  confirmou uma decisão que já tinha sido tomada por intuição — e o registro serve para
  isso: mostrar que intuição informada às vezes chega antes da bibliografia.
]

#episodio("006", "Três stacks num dia", "E a pergunta que estava errada")[
  Quatro agentes especializados debateram uma escolha de tecnologia por horas, com testes
  reais, medições e benchmarks. Um deles abriu o edital, leu a seção de critérios de
  avaliação, e mostrou que *nenhum dos eixos pontuava escolha de stack*.

  E as medições tinham um problema pior: o benchmark que "validou" uma das opções reportou
  #box[*2062 requisições por segundo, zero erros*] — medindo contra banco vazio, com o
  método de escrita retornando erro 500 em todos os casos. O caminho que quebrava não
  estava no teste.

  *O que ficou:* investigação profunda não protege contra a pergunta errada. E existe uma
  diferença enorme entre *medir* e *concluir*.
]

#episodio("007", "A citação pela metade", "E a geladeira que ninguém tinha perguntado")[
  Este é o erro mais desconfortável do projeto, e não é uma alucinação.

  Uma resposta de entrevista dizia: *"Já sim, e já passei mais de uma vez, porém tem
  algumas pequenas iniciativas que existem no campus que eu decidi NÃO usar..."*. A IA
  publicou *só a segunda metade* e concluiu que aquilo refutava uma hipótese — quando a
  primeira metade dizia exatamente o contrário.

  Não foi invenção: foi *uma citação real, cortada no ponto em que apoiava a conclusão que
  estava sendo construída*, dentro de um documento que se apresentava como evidência.

  #destaque("Por que esse tipo de erro é pior que alucinação")[
    API inventada quebra no primeiro teste. Citação truncada é publicada, vira base de
    decisão, e *não dá para pegar lendo* — porque o documento fica bom. Só dá comparando
    com a fonte.
  ]

  *Como foi pego:* um papel cético foi instruído a conferir cada citação contra o arquivo
  bruto. Rodou uma busca pela frase e recebeu zero resultados.

  *O que ficou:* texto entre aspas tem que ser localizável por busca na fonte. Ortografia
  se corrige com colchetes, nunca dentro das aspas — e a IA tinha "corrigido" acentos
  dentro de citações, o que quebrou a busca e fez *dois analistas independentes*
  concluírem que as citações não tinham origem.
]

#episodio("008", "Dez cerimônias sem perguntar por quê", "O erro que não foi de execução")[
  Dez cerimônias de método, doze documentos, um comitê de sete especialistas auditando
  tudo com fonte citada. E ninguém, em momento nenhum, perguntou *por que este produto
  deveria existir*.

  A pergunta veio do humano — a provocação do WhatsApp — e derrubou mais em três linhas do
  que horas de auditoria.

  *O que ficou:* a pergunta de existência não está em nenhuma cerimônia do método. O livro
  tem declaração de suposições, hipóteses, MVP, experimentos — e todos pressupõem que o
  produto deve existir. *Rigor metodológico pode disfarçar produto sem razão de ser, e
  disfarçou.*

  E uma lição sobre o próprio diário: a citação mais importante do episódio não estava no
  registro, porque tinha sido escrita por um caminho que o mecanismo de captura não
  observava. Um instrumento que perde justamente a intervenção decisiva é um instrumento
  com ponto cego — e só se descobre indo procurar a frase para citá-la.
]

#episodio("009", "O upstream fechado", "E o que os especialistas pegaram")[
  O trecho final produziu mais correções ao trabalho da própria IA do que qualquer outro —
  e todas vieram de alguém *abrir o arquivo e conferir*, nunca de alguém pensar mais.

  A pior: ao reescrever os critérios de aceite, a IA criou uma contradição com o modelo de
  domínio e não conferiu. Três documentos passaram a discordar. Um especialista encontrou,
  e o argumento que ele usou para escolher entre as versões *era melhor que o da IA* — a
  decisão certa foi tomada por acidente.

  *O que ficou:* o modo de falha não é falta de inteligência. É confiar na memória do que
  se escreveu.

  E uma nota boa: o mecanismo de captura corrigido no episódio anterior registrou as duas
  citações mais importantes deste. *A lacuna foi fechada a tempo de servir ao episódio
  seguinte.*
]

== O que os nove episódios têm em comum

#v(0.9em)

#grid(columns: (1fr, 1fr, 1fr), gutter: 16pt,
  numero("9", "episódios"),
  numero("7", "com erro real"),
  numero("0", "encontrados por reflexão"),
)

#v(1.1em)

Nenhum erro deste projeto foi encontrado por alguém pensando com mais cuidado. Todos
foram encontrados por alguém *comparando o que estava escrito com a fonte* — rodando o
comando, abrindo o arquivo, conferindo a citação.

É por isso que o projeto acumulou tanta infraestrutura de verificação: uma suíte de testes
para os próprios mecanismos de automação, um registro automático de tudo que foi pedido à
IA, e a regra de que toda afirmação vem rotulada pelo grau de confiança.

// =============================================================================
= A entrevista, sem edição
// =============================================================================

Esta última parte é a única do documento em que a voz não passou por nenhum filtro. As
perguntas foram feitas pela IA; as respostas foram escritas à mão e estão exatamente como
foram digitadas.

#nota[
  *Nada aqui foi corrigido* — nem digitação, nem concordância, nem as críticas diretas à
  ferramenta que escreveu o resto deste documento. Editar teria sido perder o que ela tem
  de melhor.
]

== Sobre trabalhar com IA

#fala("Sobre o que a IA é, no processo dele")[
  Hoje em dia encaro a IA como meu: "COM O PERDÃO GIGANTE" da expressão, meu estágiario
  pessoal, onde eu dito tudo que quero e até discuto várias vezes com ele para chegar em
  algum lugar. Porém também ela é muito importante no meu processo \[...\] que ela funciona
  como um pato de borracha a cada minuto e segundo, pois ela é tão boa em NÃO entender
  porra nenhuma do que eu quero dizer ou escrevo que vira um exercicio de validação de se
  eu estou REALMENTE seguro na minha ideia inicial.
]

#fala("E, sem meias palavras")[
  A IA (desculpa claude se você ler isso), mas você não PENSA, você não tem raciocinio e
  muito menos ENTENDE um texto. É só um eterno cuspidor de STRINGs probabilisticas bem
  feito.
]

#fala("Perguntado se confia mais ou menos na IA hoje")[
  Eu? nunca "confiei", você é uma ferramenta de produtividadel... se você errou, a culpa é
  minha. Essa pergunta é a mesma coisa que dizer: "Quando você confiou no gerador de codigo
  do build runner do flutter?"
]

== Sobre o que mais irritou

#fala("Perguntado sobre o momento de maior irritação")[
  Com toda a certeza quando eu não aguentava mais falar que não queria saber sobre .NET e
  quando percebi que você não escreveu NADA com nada do discovery 5 até o 10 e eu tive
  refazer tudo.
]

#fala("Sobre por que precisou cortar os assuntos de prazo e tecnologia")[
  Sinceramente, você estava fazendo o que mais faz, pega valores deterministicos para
  seguir no caminho de maior probabilidade. \[...\] Sendo assim eu cortei só pra tu não
  gastar token que eu pago me perguntando pela 1000 vez, quando era pra entregar isso,
  sendo que nem nossão de tempo tu tem.
]

== Sobre as decisões

#fala("Sobre por que segurou a resposta da provocação")[
  Queria saber o que já tinhamos como contexto e o que tinhamos escrito nos documentos já
  feitos e onde isso ia te levar de sugestão... basicamente se tu fosse até a lua e dps
  pulasse para plutão queria dizer que tava tudo muito mal feito.
]

#fala("Sobre a geladeira — e discordando da própria IA que escreveu este documento")[
  Eu não acho que ela seja a resposta ainda agora, mas tu tem tendencia de pegar umas
  coisas soltas, juntar umas frases de efeito como se fosse "A VERDADE", então eu só
  ignoro, não vale a pena "corrigir" uma maquina inanimada como se fosse um ser humano.
]

#fala("Sobre de onde veio a analogia do Mahjong")[
  costumo usar muita analogia para descrever as coisas pois a IA tem uma tendencia de
  entender melhor processos não abstratos documentados do que eu ter que explicar processos
  meio inacabados que tenho na cabeça \[...\] e... não eu não jogo Majong, porém assisti um
  anime chamado "SAKI" que é sobre majong e lembrei do tipo de jogada.
]

== Sobre o produto, sem otimismo

#fala("Perguntado se acredita que alguém usaria")[
  Sinceramente ? Não sei, mas eu acho que usaria... sempre faço pensando. Eu usaria? se a
  resposta é "não", costumo re-avaliar se vale a pena fazer
]

#fala("Perguntado do que tem mais medo")[
  Talvez a questão do produto em si, tenho medo virar uma grande "vitrine" e o resto a
  galera vai fazer tudo via Zap
]

#fala("Perguntado se incomoda a pesquisa não ter nenhum calouro — que é quem o produto diz atender")[
  MUITO
]

#fala("Perguntado se há erros da IA ainda não encontrados")[
  Vários, só que eu ainda não sei onde estão... quando eu continuar o processo vou achar,
  quando o usuario usar o sistema ele tbm vai achar... faz parte.
]

#fala("E a última linha da entrevista, sobre o que ainda incomoda")[
  Sinceramente não estou satisfeito ainda com NADA da stack... acho que vou rever ela jaja.
]

// =============================================================================
= O que vem depois
// =============================================================================

O upstream fechou. O que existe agora é um produto definido do problema até a frase que
aparece quando alguém digita o código errado — e nenhuma linha de código de aplicação.

#destaque("O que este documento não é")[
  Não é uma demonstração de que o processo funcionou. Isso só se sabe depois de
  construído, e o próprio autor diz na entrevista que não sabe se alguém usaria.

  É o registro de *como se decidiu*, com os erros no meio. Se o produto der errado, este
  documento continua sendo verdadeiro — e provavelmente vai mostrar onde a decisão errada
  foi tomada.
]

A próxima fase é a esteira de produção: transformar dezoito cerimônias em software que
sobe, com testes escritos antes do código. O material está pronto — cada critério de
aceite foi escrito como comportamento observável, exatamente para virar teste.

E se algo der errado lá, vai virar o episódio dez.

#v(2em)
#line(length: 100%, stroke: 0.6pt + linha)
#v(0.8em)

#text(size: 9pt, fill: apagado)[
  *Repositório completo, com todos os documentos citados:* #link("https://github.com/GabrielAderaldo/desafio-vortex")[github.com/GabrielAderaldo/desafio-vortex] \
  *Jornadas e wireflows:* #link("https://www.figma.com/community/file/1663876864232938978")[figma.com/community/file/1663876864232938978] \
  #v(0.5em)
  Documento gerado em Typst. Os nove episódios completos estão em `docs/ai-log/`, e a
  entrevista integral em `docs/ai-log/entrevista-01-upstream.md`.
]
