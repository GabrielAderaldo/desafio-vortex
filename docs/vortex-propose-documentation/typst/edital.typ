// Edital do desafio técnico — Laboratório Vortex (UNIFOR)
//
// Transcrição formatada do PDF original (pdfs/PS_Full_Stack_compressed.pdf).
// Compilar:  typst compile edital.typ
//
// IMPORTANTE — duas vozes neste documento:
//   · texto corrido       = edital oficial, transcrito literalmente
//   · blocos "Anotação"   = comentários do Gabriel, feitos sobre o PDF
// A distinção é visual e deliberada: confundir uma com a outra faria parecer que a
// banca exige o que é, na verdade, uma decisão de projeto do candidato.

#set document(
  title: "Edital de Desafio Técnico — Laboratório Vortex",
  author: "Laboratório Vortex — UNIFOR",
)

#set page(
  paper: "a4",
  margin: (x: 2.4cm, y: 2.6cm),
  numbering: "1 / 1",
  number-align: center,
)

#set text(
  font: ("Helvetica Neue", "Helvetica", "Arial"),
  size: 10.5pt,
  lang: "pt",
  region: "br",
  hyphenate: true,
)

#set par(justify: true, leading: 0.72em, spacing: 1.15em)

// Paleta
#let azul = rgb("#1e3a5f")
#let azul-claro = rgb("#4a90d9")
#let cinza = rgb("#5a5a5a")
#let ambar = rgb("#8a6d1f")
#let vermelho = rgb("#8f2d2d")
#let verde = rgb("#1e5f3a")

#set heading(numbering: none)

#show heading.where(level: 1): it => block(
  above: 1.8em, below: 0.9em,
  text(size: 15pt, weight: 700, fill: azul, it.body),
)
#show heading.where(level: 2): it => block(
  above: 1.4em, below: 0.7em,
  text(size: 12pt, weight: 700, fill: azul, it.body),
)
#show heading.where(level: 3): it => block(
  above: 1.1em, below: 0.5em,
  text(size: 10.5pt, weight: 700, fill: cinza, it.body),
)

#show link: it => text(fill: azul-claro, it)
#show strong: it => text(weight: 700, fill: azul.darken(15%), it)

// ─── Componentes ────────────────────────────────────────────────────────────

// Nota ou aviso que consta no documento ORIGINAL
#let caixa(titulo, cor, corpo) = block(
  width: 100%,
  inset: (x: 12pt, y: 10pt),
  radius: 3pt,
  fill: cor.lighten(92%),
  stroke: (left: 3pt + cor),
  above: 1.2em, below: 1.2em,
)[
  #text(weight: 700, size: 9pt, fill: cor, tracking: 0.6pt)[#upper(titulo)]
  #v(-0.4em)
  #text(size: 9.8pt)[#corpo]
]

// Anotação MANUSCRITA do Gabriel sobre o PDF — não é texto do edital
#let anotacao(corpo) = block(
  width: 100%,
  inset: (x: 12pt, y: 10pt),
  radius: 3pt,
  fill: rgb("#fdfaf0"),
  stroke: (paint: ambar.lighten(40%), thickness: 0.8pt, dash: "dashed"),
  above: 1.2em, below: 1.2em,
)[
  #text(weight: 700, size: 8.5pt, fill: ambar, tracking: 0.6pt)[
    ✎ ANOTAÇÃO DO CANDIDATO — NÃO FAZ PARTE DO EDITAL
  ]
  #v(-0.3em)
  #text(size: 9.8pt, style: "italic", fill: rgb("#4a4033"))[#corpo]
]

#let obrigatorio = box(
  inset: (x: 5pt, y: 2pt), radius: 2pt, fill: vermelho.lighten(88%),
  text(size: 8pt, weight: 700, fill: vermelho)[OBRIGATÓRIO],
)
#let bonus = box(
  inset: (x: 5pt, y: 2pt), radius: 2pt, fill: verde.lighten(88%),
  text(size: 8pt, weight: 700, fill: verde)[BÔNUS],
)

// ─── Capa ───────────────────────────────────────────────────────────────────

#align(center)[
  #v(0.5cm)
  #text(size: 9pt, fill: cinza, tracking: 2.5pt)[UNIVERSIDADE DE FORTALEZA]

  #v(0.3cm)
  #text(size: 26pt, weight: 800, fill: azul)[LABORATÓRIO VORTEX]

  #v(0.25cm)
  #line(length: 45%, stroke: 1.2pt + azul-claro)
  #v(0.25cm)

  #text(size: 13pt, weight: 600, fill: cinza)[
    Edital de Desafio Técnico
  ]

  #v(0.1cm)
  #text(size: 10.5pt, fill: cinza)[
    Processo Seletivo para Estágio Full-Stack
  ]

  #v(0.6cm)

  #block(
    width: 88%,
    inset: 12pt,
    radius: 4pt,
    fill: azul.lighten(95%),
    stroke: 0.5pt + azul.lighten(60%),
  )[
    #text(size: 11.5pt, weight: 700, fill: azul)[
      Marketplace de Economia Circular
    ]
    #linebreak()
    #text(size: 10pt, fill: cinza)[Desapego Universitário]
    #v(0.2em)
    #text(size: 9.5pt, weight: 600, fill: vermelho)[Prazo: 15 dias]
  ]
]

#v(0.8cm)

// ─── Abertura ───────────────────────────────────────────────────────────────

Olá, candidato(a)! Seja muito bem-vindo(a) à etapa prática do processo seletivo para o
Laboratório de Inovação Vortex. Nosso objetivo com este desafio *não* é avaliar se você
decorou sintaxe de código ou se consegue criar um sistema perfeito sem ajuda, mas sim
medir a sua *capacidade de aprender, resolver problemas, arquitetar soluções e entregar
um produto funcional*.

Sabemos que você pode estar no início do seu curso (seja ADS, Ciência da Computação,
Engenharia ou afins). Por isso, estruturamos este desafio para ser desafiador, porém
perfeitamente realizável por quem tem proatividade e vontade de pesquisar. Além disso,
o uso de ferramentas de *Inteligência Artificial Generativa* (como ChatGPT, Claude,
Copilot, etc.) é *explicitamente permitido e bem-vindo*, desde que utilizado de forma
consciente e documentado, conforme explicaremos adiante.

= 1. O Desafio: Marketplace de Economia Circular do Campus

Você deverá desenvolver uma plataforma web/mobile focada no desapego e na economia
circular dentro do ambiente universitário. O objetivo do sistema é permitir que
estudantes cadastrem itens para doação ou venda (livros, xerox, calculadoras
científicas, componentes eletrônicos, jalecos, móveis, etc.), facilitando o acesso a
materiais para quem está ingressando na universidade.

O projeto deve ser concebido como uma *aplicação única* integrando uma *API RESTful*
(Backend) e uma *interface responsiva instalável* (Frontend PWA).

#anotacao[
  Pelas frases acima, decidi criar um único repositório em nível de *monorepo*. Para
  isso vou ter que usar uma tecnologia que facilite isso, e pensei em várias que dão
  isso "de graça". Atualmente estou em dúvida entre o *Deno* moderno 2.9.x, que tem
  uma boa ferramenta de workspaces e monorepos
  (#link("https://docs.deno.com/runtime/fundamentals/workspaces/")[docs.deno.com/runtime/fundamentals/workspaces]),
  *ou Dart*, cujo próprio `pubspec` é incrível para separar packages e binários, entre
  outras coisas.

  Porém sinto que fazer em *TypeScript/JavaScript* pode ser o mais "correto" para a
  natureza deste processo seletivo — usar Dart 100% pode ser algo muito "rebelde" e
  ser visto com maus olhos.
]

== 1.1. Escopo de Funcionalidades e Telas

/ Landing Page Pública (Web/Desktop): Uma página de apresentação do projeto que
  explique a proposta de economia circular no campus, exiba *estatísticas simuladas* do
  sistema e contenha uma *vitrine pública* listando os últimos itens anunciados com
  filtros básicos por categoria (ex: Livros, Engenharia, Computação). Deve conter
  botões claros de chamada para ação (CTA) convidando o usuário a anunciar ou buscar
  itens.

/ Aplicação Mobile (PWA): Quando acessado por um dispositivo móvel (ou simulador), o
  sistema deve oferecer a experiência de um aplicativo nativo. O usuário autenticado ou
  identificado deve ser capaz de preencher um formulário para *anunciar um item*
  (título, descrição, categoria, preço ou indicação de doação, e uma URL de imagem
  simulada) e *visualizar seus próprios anúncios* cadastrados.

= 2. Requisitos Técnicos do Projeto

Para garantir a equidade na avaliação e permitir que tanto candidatos iniciantes quanto
avançados demonstrem seu valor, dividimos os requisitos em *critérios obrigatórios*
(mínimos) e *diferenciais* (bônus).

== 2.1. Backend (API RESTful)

#obrigatorio *Requisitos Mínimos*

- Criação de uma *API REST* estruturada em qualquer linguagem ou framework de sua
  preferência (Node.js/TypeScript, Python/FastAPI, Java/Spring Boot, C\#/.NET, PHP,
  etc.).
- Implementação dos *endpoints básicos (CRUD)* para gerenciamento de anúncios: criar,
  listar, filtrar e deletar.
- *Persistência de dados funcional.* Pode ser um banco em arquivo (como SQLite) ou em
  memória (estruturas de dados ou instâncias voláteis), desde que o sistema funcione
  perfeitamente durante os testes.
- Retorno e envio de dados *estritamente no formato JSON*.

#bonus *Requisitos Diferenciais*

- *Autenticação básica* de usuários (ex: JWT) ou separação por IDs de usuário.
- *Tratamento robusto de erros* e validação de campos obrigatórios nas requisições.
- Uso de *banco de dados relacional ou não-relacional real* em container ou nuvem
  (ex: PostgreSQL, MongoDB).

#anotacao[
  Basicamente está dizendo: *use Docker e Docker Compose*. Até porque usar Kubernetes
  para isto seria usar um tanque Scorpion (referência a Halo) para matar uma minhoca.
]

== 2.2. Frontend & PWA

#obrigatorio *Requisitos Mínimos*

- Desenvolvimento da interface utilizando *tecnologias web modernas* (React, Vue.js,
  Angular ou HTML5/CSS3/JavaScript puro bem estruturados).
- *Configuração de PWA:* é *obrigatória* a inclusão de um manifesto de aplicativo web
  válido (`manifest.json`) e um *Service Worker* básico que permita que a aplicação
  seja "instalada" na tela inicial de um dispositivo mobile.
- *Responsividade completa:* a interface deve se adaptar perfeitamente de uma Landing
  Page rica no desktop para uma experiência fluida de aplicativo no mobile.

#anotacao[
  Aqui, sinceramente, é usar o design de *grid 12 | 6 | 4* — o famoso formato suíço de
  layout. Mas vou pensar melhor nisso ainda.
]

#bonus *Requisitos Diferenciais*

- *Estratégias de cache no Service Worker* para funcionamento ou visualização offline
  de dados já carregados.
- Utilização de *TypeScript* no Frontend.

#anotacao[
  Isto é o que está me inclinando a *não* ir para o Dart total.
]

- Interface polida com componentes visuais modernos, *feedback visual de carregamento*
  e transições suaves.

#anotacao[
  Vou, com toda a certeza, usar alguma diretriz já criada de algum *Design System*
  pronto — como o do Notion, Material Design, ou o da Apple. Mas ainda vale pensar.
]

#caixa("Nota sobre Deploy", azul-claro)[
  Realizar o *deploy real* da API (em serviços gratuitos como Render, Railway ou
  Fly.io) e do Frontend (Vercel, Netlify ou GitHub Pages), disponibilizando os links
  funcionais, é considerado um *fortíssimo diferencial bônus* e demonstra excelente
  desenvoltura técnica.
]

= 3. O Fator Inteligência Artificial e o "Diário de Bordo"

No mercado atual e no Laboratório Vortex, encaramos a IA Generativa como uma ferramenta
indispensável de produtividade. Não queremos proibir seu uso, pois sabemos que ela
acelera o aprendizado. *Queremos avaliar como você a utiliza* para resolver problemas
complexos.

Para validar o uso correto e ético, é *obrigatório* que você mantenha e publique um
*Diário de Bordo da IA*. No arquivo `README.md` principal do seu repositório Git, você
deverá criar uma seção dedicada a documentar essa parceria, respondendo aos seguintes
tópicos:

/ Ferramentas Utilizadas: Liste quais IAs você utilizou ao longo dos 15 dias (ex:
  ChatGPT, Claude, GitHub Copilot, v0, Lovable, etc.).

/ Estratégia de Engenharia de Prompts: Forneça *exemplos reais* (copie e cole) de pelo
  menos *2 ou 3 prompts complexos* que você escreveu para destravar o desenvolvimento
  — por exemplo, como pediu para estruturar o Service Worker do PWA, ou como pediu
  ajuda para depurar um erro específico de banco de dados.

/ Compartilhamento de Histórico #text(fill: cinza)[(opcional, mas recomendado)]: Se
  utilizou ferramentas que permitem gerar links públicos de conversas, inclua o link de
  pelo menos um chat longo de desenvolvimento no qual você debateu arquitetura ou
  resolução de bugs com a IA.

/ Reflexão Crítica: Descreva brevemente um momento em que a IA gerou um *código errado,
  incompleto ou uma "alucinação"*, e explique como você identificou o erro e guiou a
  ferramenta para a solução correta.

#caixa("Aviso Importante", vermelho)[
  Se a banca avaliadora identificar que o código foi *100% gerado por IA* sem que o
  candidato demonstre compreender a lógica implementada, ou caso o *Diário de Bordo
  seja omitido*, a solução será *severamente penalizada*.
]

= 4. Regras de Entrega e Repositório Git

Toda a sua solução deve ser disponibilizada em um *repositório público* no GitHub ou
GitLab até o prazo final estabelecido pela organização do processo seletivo.

O repositório deve conter um arquivo `README.md` na raiz, escrito de forma clara e
profissional para o leitor, contendo *obrigatoriamente*:

+ Título do projeto e uma descrição resumida da proposta.
+ *Instruções passo a passo* de como rodar o Backend e o Frontend localmente:
  pré-requisitos, comandos de instalação de dependências e comandos de execução.
+ Relação de *tecnologias, frameworks e bibliotecas* principais adotadas.
+ O *Diário de Bordo da IA* preenchido conforme as diretrizes da Seção 3.
+ Links para a aplicação rodando em produção, caso tenha feito o deploy opcional.

= 5. Processo de Avaliação: O Vídeo Prático

A avaliação técnica *não considerará apenas a leitura fria do código*. O principal
critério de triagem e validação da autoria do projeto será a entrega de um *vídeo com
duração máxima e estrita de 6 minutos*.

Você deve hospedar este vídeo em uma plataforma acessível (YouTube como não-listado,
Google Drive com permissão pública de visualização, Loom ou Vimeo) e incluir o link no
formulário de submissão.

O tempo do vídeo deve ser *rigorosamente dividido* conforme a estrutura cronometrada:

#v(0.3em)

#table(
  columns: (auto, 1fr, 1fr),
  inset: (x: 8pt, y: 7pt),
  align: (center + horizon, left, left),
  stroke: 0.4pt + rgb("#c8c8c8"),
  fill: (_, y) => if y == 0 { azul.lighten(90%) },

  table.header(
    text(weight: 700, size: 9pt, fill: azul)[Tempo],
    text(weight: 700, size: 9pt, fill: azul)[Conteúdo exigido],
    text(weight: 700, size: 9pt, fill: azul)[O que a banca avalia],
  ),

  [#text(weight: 700)[0:00 – 1:00] \ #text(size: 8.5pt, fill: cinza)[1 minuto]],
  [*Pitch e visão geral* \ #text(size: 9pt)[Apresentação pessoal e contextualização rápida da sua proposta de marketplace para o campus.]],
  [#text(size: 9pt)[Capacidade de síntese, comunicação clara e entendimento do problema de negócio proposto.]],

  [#text(weight: 700)[1:00 – 3:00] \ #text(size: 8.5pt, fill: cinza)[2 minutos]],
  [*Demonstração prática* \ #text(size: 9pt)[Gravação de tela mostrando a Landing Page no desktop e, em seguida, simulando a navegação mobile (ou direto no celular), testando o PWA: criar anúncio, listar e instalar na tela inicial.]],
  [#text(size: 9pt)[Funcionalidade real do sistema, interface do usuário (UI/UX), responsividade e validação do funcionamento como PWA.]],

  [#text(weight: 700)[3:00 – 5:00] \ #text(size: 8.5pt, fill: cinza)[2 minutos]],
  [*Explicação técnica do código* \ #text(size: 9pt)[Abertura do VS Code. Guiar a banca pela arquitetura das pastas, mostrar as principais rotas do backend e a lógica do Service Worker ou manipulação de estado do frontend.]],
  [#text(size: 9pt)[Domínio técnico, organização de código, clareza na explicação lógica e comprovação de autoria do desenvolvimento.]],

  [#text(weight: 700)[5:00 – 6:00] \ #text(size: 8.5pt, fill: cinza)[1 minuto]],
  [*Uso prático da IA* \ #text(size: 9pt)[Explicar como a IA foi integrada na rotina de desenvolvimento. Mostrar no README ou no navegador os prompts ou discussões marcantes e como refinou os retornos.]],
  [#text(size: 9pt)[Maturidade no uso de ferramentas de IA generativa, senso crítico para corrigir erros e capacidade de curadoria.]],
)

= 6. Resumo dos Critérios de Avaliação

A nota final do desafio técnico será composta pela *média ponderada* dos seguintes
eixos:

/ Qualidade e Completude da Entrega #text(fill: cinza)[(Git & README)]: Organização do
  código, clareza das instruções de execução e preenchimento correto do Diário de Bordo
  da IA.

/ Domínio Técnico e Autoria #text(fill: cinza)[(vídeo — trecho de código)]: Capacidade
  de explicar o próprio código com propriedade, demonstrando que de fato compreende a
  lógica de programação subjacente à solução gerada.

/ Atendimento aos Requisitos Obrigatórios: Funcionamento correto das rotas REST no
  backend e cumprimento das diretrizes de responsividade e PWA no frontend.

/ Uso Inteligente e Curadoria de IA: Avaliação se o candidato usou a IA como um
  *catalisador de conhecimento* ou apenas como um *gerador automatizado cego* —
  punindo cópias sem critério e valorizando o uso analítico.

#v(0.6em)

#align(center)[
  #block(width: 92%, inset: 11pt, radius: 4pt, fill: azul.lighten(95%))[
    #text(size: 10pt, style: "italic", fill: azul)[
      Desejamos muito sucesso no desenvolvimento da sua solução. Use os 15 dias para
      explorar novas tecnologias, errar rápido, corrigir com apoio da IA e construir
      algo do qual você se orgulhe. Nos vemos na banca de avaliação.
    ]
  ]
]

#v(1cm)

#line(length: 100%, stroke: 0.4pt + rgb("#c8c8c8"))
#v(-0.3em)
#text(size: 8pt, fill: cinza)[
  Transcrição formatada do edital original
  (`pdfs/PS_Full_Stack_compressed.pdf`). Os blocos marcados com ✎ são anotações do
  candidato sobre o documento e *não integram o edital*.
]
