---
name: produto-hipoteses-abertas
description: Hipóteses de produto levantadas em war rooms deste repo, com o sinal que as confirma ou refuta — consultar antes de reabrir o mesmo debate
metadata:
  type: project
---

Hipóteses no formato Lean UX cap. 3 levantadas em WAR ROOM. Cada uma traz o sinal
observável. **Ao reabrir o assunto, cheque primeiro se o sinal já apareceu.**

## 2026-07-26 — Linguagem dos scripts do harness (`.claude/hooks/*`, statusline)

Contexto do round: 3 arquivos `.sh` / 213 linhas, todos com contrato stdin-JSON →
stdout-JSON do Claude Code. Repo com **zero código de aplicação** na data. Runtime da
aplicação ainda não decidido.

- **H1 (teste de fumaça do harness)** — instrumentar cada script com fixture de entrada
  e saída esperada, *independente da linguagem*.
  Sinal: quebrar um hook de propósito faz `just check` falhar; e ao fim dos 15 dias
  `.ai-log/raw-prompts.md` não tem buraco de dias.
- **H2 (migrar os scripts para a linguagem da aplicação)** — só depois do runtime
  decidido.
  Sinal de verdade: o Gabriel altera um hook sozinho quando o protocolo mudar.
  **Sinal de refutação: se em 15 dias nenhum hook precisar de alteração, o custo de
  leitura que a migração pagaria nunca chegou.**
- **H3 (política "sem shell" vira regra com limite verificável)** — em vez de banimento.
  Sinal: nenhum arquivo do repo viola a regra publicada. Banimento total **já nasceria
  violado** pelas receitas `refs-vscode`/`refs-claude` do `Justfile` e pelo one-liner
  shell inline em `.claude/settings.json` (PostToolUse).

**Why:** o risco central do round era resolver com elegância a preferência do Gabriel
por linguagem, quando a dor verificável é outra — hook que falha **em silêncio** (todo
caminho de erro dos scripts termina em `exit 0` sem aviso), e a matéria-prima do diário
some sem ninguém notar.

**How to apply:** se alguém propuser de novo migrar/banir shell, peça primeiro o sinal
de H2. Ver [[projeto-quem-e-o-usuario]] antes de argumentar com "o avaliador".

## 2026-07-27 — Stack da aplicação (Dart/Darto + Mustache + HTMX/Alpine + SW em TS)

Contexto: dia 2 de 15, ainda **zero arquivo de aplicação** (`.dart`/`.ts`/`.html`
inexistentes; só `docs/`, `.claude/` e `.claude/settings.json`). README 100% template.

- **H1 (orçamento de conceitos do vídeo)** — o trecho 3:00–5:00 são 120 s para
  "arquitetura de pastas + rotas do backend + lógica do SW". Cada tecnologia visível
  divide esse orçamento.
  Sinal: **ensaio gravado do trecho, no dia 5, sem cortes e sem nota, dentro de 2 min.**
  Se estourar ou pular o SW, há conceito demais. Refutação limpa se ele gravar tranquilo.
- **H2 (anunciar sem cadastro)** — autenticação é **bônus** no edital, e o texto aceita
  "autenticado **ou identificado**" e "separação por IDs de usuário". Logo, tela de login
  antes do primeiro anúncio é escopo não pedido.
  Sinal: do ícone instalado até o item na vitrine em < 40 s narráveis, < 4 toques.
- **H3 (spike vertical timeboxado decide a stack)** — em vez de debate: formulário →
  persistência → item na vitrine, com prazo fechado.
  Sinal de refutação combinado **antes**: estourou o prazo, ou ele precisou aceitar código
  que não sabe explicar → troca para a stack que ele já defende, sem novo war room.

**Ponto de produto que ninguém tinha nomeado:** com HTMX quase não sobra "estado de
frontend", e o edital deixa escolher entre explicar o SW **ou** o estado. A escolha da
stack empurra 100% do peso de autoria para o **Service Worker** — ele vira a peça mais
importante a ser escrita à mão e entendida linha a linha.

**How to apply:** antes de reabrir "qual stack", peça o resultado de H3. Antes de propor
mais uma tecnologia (Turbo, OpenAPI spec-first, auth), diga de qual dos 120 s ela sai.
Ver [[usuario-gabriel-perfil]] para as anotações dele no edital.

## 2026-07-27 — Priorização de risco das 18 suposições (cerimônia 3)

Contexto: worksheet `docs/discovery/04-assumptions-worksheet.md` com 18 suposições.
Correções de evidência aceitas no round estão em [[projeto-quem-e-o-usuario]].

- **H10 (a janela para alcançar ingressante é 2026-08-03)** — `documentado` (busca web,
  **não conferido** na Resolução CEPE nº 45, que é a fonte oficial): **2026.2 da UNIFOR
  começa em 3 de agosto de 2026**, com acolhida dos ingressantes no mesmo dia; matrícula
  6–31 de julho. Em 2026-07-28 o campus está em **recesso** — cartaz/fila produz silêncio
  de campus vazio, que é refutação falsa. A população ausente da amostra (ingressantes)
  fica fisicamente reunida em 3/8, dentro do prazo do desafio. **Não há janela melhor no
  ano.** Fila da xerox superamostra quem já resolveu pagando — serve para a B12.1
  reformulada ("por que não procurou usado?"), não para demanda **não atendida**.
  Regra: **teste de um lado só** — resposta nomeando item é sinal, silêncio não é nada.
  Cartaz fixo, **nunca abordagem** (abordar seleciona quem "parece com ele").
- **H4 — POSIÇÃO RETIRADA por mim.** B12.3 não é o #1: é **mitigável por design a custo
  quase zero.** O anunciante já tem razão para voltar (tirar o item da lista, o `DELETE`
  que o edital dá) — basta o caminho barato ser *"marcar como entregue"* em vez de
  *"deletar"*. E o "Tenho interesse" (sessão exigida para revelar contato) cria o **único
  evento dentro do sistema** capaz de disparar a volta, já que o handoff está fora.
  **O #1 passa a ser a base de evidência de B01/B10/D**, por raio de explosão: as
  cerimônias 4–10 são todas construídas sobre o enquadramento D, nada mitiga isso por
  design, e o item que carrega o peso é que o único apoio externo da barreira de
  confiança é sobre material do **ensino médio**.
  Registro do erro, porque ele se repetiu: meu critério escorregou **duas vezes** de
  *quanto custa estar errado* para *quanto custa saber* ("custa uma mensagem",
  "invisível para os instrumentos"). Facilidade de teste e observabilidade **não são
  dano**. Contexto original de H4: B02 causa mais dano se falsa, mas é
  aposta de classe de solução, cara de testar e já fechada pelo enquadramento D. B12.3
  ("a pessoa volta para confirmar o destino") é a **precondição mecânica** de B02 e é
  invisível para todos os instrumentos: nenhuma das 10 perguntas do questionário toca em
  retorno/segundo uso, e a demo do edital (linha 152: "criar anúncio, listar e instalar")
  também não. **Um produto que morre em B12.3 demonstra perfeitamente.**
  Teste barato e legítimo (do cético) é **pergunta de comportamento passado**, nunca
  "você voltaria?" — intenção declarada é recusada pelo próprio instrumento
  (`01-questionario-proto-personas.md:24-26`): *"quando você emprestou ou doou material,
  chegou a saber o que aconteceu? Procurou saber?"*. Teste forte: concierge, 1 semana.
  **Contra-evidência já existente**, e vale muito por cortar contra o próprio autor:
  `.ai-log/raw-prompts.md:741`, P04 — *"'empresto' por tempo indeterminado, ou doou ele
  para alguém ou algum canto"*. Placar honesto: **1 relato contra, 3 silêncios.**
- **H5 (B13 — o receptor aceita aparecer publicamente como quem recebeu)** — suposição
  **ausente do worksheet**, nomeada neste round. Doar é socialmente favorável; aparecer
  como quem recebeu de graça carrega marcador de ter precisado. Se falsa, a feature de
  confirmação de recebimento é código morto.
- **H6 (o gatilho é espaço, o filtro é confiança)** — **não resolve** a tensão de B04:
  o cético levantou leitura rival igualmente compatível com os dados (*sob pressão de
  espaço o filtro é pulado inteiro*, o que é pior para o produto). Registrar as duas.
  **Mas as duas convergem na mesma decisão**, e por isso não precisamos separá-las: o
  **lixo tem SLA de 30 segundos**, nunca ganhamos dele em latência, e a janela boa é a
  fase "gaveta", não a "faxina". Ressalva: a fase gaveta é **n=1 externo** (P02).
- **H7 — REFUTADA no mesmo round, e a conclusão certa é a oposta.** Eu afirmei que
  doação-primeiro otimiza a faixa onde somos menos necessários. As duas premissas caíram:
  o **único fracasso documentado da amostra é com apostilas** (faixa barata, `respostas:22`),
  e para item caro **existe mercado funcionando** (OLX, Marketplace, Enjoei) — a rede
  pessoal não precisa resolver o notebook porque o mercado resolve. Logo: **a faixa cara
  vaza para os marketplaces existentes independente do que a gente construa, e a faixa
  barata é a única com buraco.** Doação-primeiro na faixa barata é o posicionamento certo,
  e bate com o edital (linhas 21-22, "quem está ingressando").

**Riscos aceitos sem testar, com justificativa:** **B06** (aquisição por endosso
institucional) — fora de controle, não há lançamento, não muda nenhuma decisão de design.
Recomendação: dizer isso em voz alta no vídeo em vez de fingir.

- **H8 (a precondição de B02 é testável barato; a causalidade não é)** — contra a tese
  de que "não existe experimento honesto para B02". Protótipo de papel **não é código**
  (Lean UX `05-mvps-and-experiments.md:151-164`) e concierge observa comportamento sem
  survey (`05:98`). O teste: **oferecer uma doação real à mão** — *"conheço alguém do
  curso X que precisa de [item], topa passar?"* — e medir **quantos perguntam quem vai
  receber antes de dizer sim, e o que perguntam**. O que perguntam é a especificação das
  cláusulas de B02. O que fica sem teste é a causalidade ("visibilidade *resolve*
  desconfiança") — entra como risco declarado.
- **H9 (o entregável tem prazo, o produto não)** — o experimento mais barato da sala é
  do técnico e vem antes de todos os meus: **ensaio seco de 2 min narrando as cinco
  batidas da demo sobre mockups estáticos, cronometrado. ~15 min.** Folga estimada:
  15-20 s de 120. Restrição derivada: **o "destino visível" precisa ser um estado em que
  o app já está quando a câmera chega** (dado semeado), não um estado que a demo produz.

- **H15 (a garantia prévia está REFUTADA — o concorrente é uma geladeira)** — o
  follow-up de 2026-07-28 em `01-...respostas.md:164` caracterizou as "pequenas
  iniciativas": **uma geladeira velha no ponto de ônibus** e **uma caixa de sucata no
  bloco D**. P04: *"cheguei a deixar minhas apostilas do ensino médio lá uma vez, porém
  fiquei INSEGURO se realmente foi útil ou eu estava só 'espalhando lixo'"*.
  **Ele usou.** Logo: (a) minha leitura de que o ato de fé é na entrega e não depois está
  **contrariada pelo caso fundador**; (b) `02:38-40` ("o canal existia e ele optou por não
  usar") cai — não é recusa prévia, é **abandono após uso**; (c) a cláusula **(ii)** de
  B02 ("o que aconteceu com ele"), que cortamos, é a **mais bem evidenciada do produto** —
  e segue pagando **zero** em todos os quatro eixos.
  **Modo de falha do concorrente é estético:** *"mal cuidada e super apagada"*, a ponto de
  **parecer a própria coisa que existia para evitar**. Isso tira **U06** de 🔴.
  Ressalva que corta a favor: P04 é o não-cego e o follow-up foi primado, mas o conteúdo
  **contradiz a versão conveniente anterior dele**.
  ⚠️ **O selo (degrau 1) sobrevive, mas o argumento para ele caiu pela terceira vez.**
  Vale só o estrutural: *construímos porque não aposta em nenhuma suposição 🔴*. Escrever
  "porque o usuário quer garantia prévia" agora é falso.
- **H17 (a vitrine vazia É a geladeira)** — decisão: o seed vira habilitador com critério
  verificável. **Toda categoria exposta no filtro devolve ≥3 itens** (não "≥M categorias
  distintas" — chip que devolve zero é o sinal "super apagada"; categoria sem conteúdo não
  aparece no filtro), **≥12 no total** (preenche a grade no desktop, onde a demo começa),
  sem passo manual. Os números são `inferido`; a **regra** de que toda categoria visível
  tem conteúdo é o que não pode cair. Quarto critério, da lente de produto: **o conteúdo
  do seed precisa ser plausível** — "Livro 1, Livro 2" reproduz o mesmo sinal de abandono.
  Motivo forte, de [[H15]]: uma vitrine vazia é o modo de falha documentado do concorrente
  real, na palavra do usuário.
- **H22 (recência > volume, e seed com data fixa apodrece)** — achado do `uxcopy`: as
  palavras do modo de falha são **`mal cuidada`** e **`super apagada`**, nenhuma sobre
  quantidade. **O inimigo não é a tela vazia, é a tela sem sinal de cuidado** — uma marca
  de recência trabalha mais que um contador de volume.
  ⚠️ Armadilha: **se as datas do seed forem fixas, o sinal de vida vira sinal de
  abandono sozinho** ("há 2 dias" → "há 3 meses" quando alguém clonar o repo), que é
  literalmente a história da geladeira, no pior momento possível. E o `requisitos` deu o
  argumento interno, melhor que o meu: **H-12:264 ("exibe atividade recente") passa verde
  no dia 1 e vira falso sem nada quebrar.**
  ⚠️ **Eu propus datas retroativas/espalhadas e RETIREI** — o `uxcopy` me derrubou com o
  critério que eu mesmo defendia. A distinção que faltava: **o título é ficção sobre o
  mundo; a data é afirmação do sistema sobre a própria história.** "Existe um anúncio de
  Calculadora HP 50g" é verdadeiro; "publicado há 2 dias" é **falso e o sistema sabe**,
  porque ele criou o registro agora. Separam-se por **quem observou o evento**.
  Confissão para o registro: eu empurrei as datas 24h para trás **para encobrir um bug de
  fuso horário**, e vendi como *"remove o modo de falha em vez de detectá-lo"*. E defendi
  18 carimbos iguais como "lê como fixture" — ou seja, **preferi uma mentira porque ela
  parecia melhor**, defendendo o critério de plausibilidade que eu mesmo escrevi.
  **Cláusula correta:** as datas do seed são **o instante em que o seed rodou**, sem
  retroação — e **o seed executa na subida do container, não no build da imagem** (se
  rodar no build, as datas ficam cozidas e o apodrecimento volta, invisível). Assim quem
  clonar em outubro sobe e a landing diz **"último item publicado hoje"**: verdade
  literal, mais forte que qualquer "há 2 dias" fabricado. Critério de teste vira exato —
  *"a data do item mais recente é a do boot"*. Se o container rodar 3 meses parado e a
  copy disser "há 3 meses", **está correto: o sistema está parado.**
  O **fuso** volta a ser decisão de W0 (UTC no armazenamento, fuso explícito na
  renderização) + critério negativo: **nenhum item exibido tem data posterior a `now()`**,
  e a faixa < 24h precisa de um termo que aguente o zero.
  Fronteira da honestidade: simular **dados** é autorizado, simular **resultados** não —
  **não marcar o seed como sintético na interface**; dizer no README.
- **H23 (a interface entrega a resolução do medo sem nomeá-lo)** — eu errei ao dizer que
  a copy "responde à frase *espalhando lixo*". Ela responde ao **medo**, não à frase.
  *"Seu livro está com a Marina"* faz o trabalho; *"não foi para o lixo"* faz o trabalho
  **e planta a dúvida** em quem não a trouxe. Regra geral do `uxcopy`, e vale para tudo
  que este war room produziu: **o avaliador leu o discovery, o estudante não.**
  Verbo do CTA: **"publicar"** — a palavra é escolha nossa sem lastro de usuário, mas a
  **exigência de neutralidade de modo** é documentada (edital linha 21, *"doação ou
  venda"*) e sustentada pelo Achado 5. "Desapegar" e "anunciar" estão **excluídos por
  evidência negativa** (ver [[H16]]).
- **H20 (a vitrine não exibe o nome de quem publicou)** — o T0 rodou (`respostas:172`):
  a busca do TORPEDO é **por nome, ou parte do nome**. Logo **nome é chave de
  endereçamento**, e nome na vitrine torna o gate contornável — some a telemetria e some
  o gatilho de segunda visita com que [[H4]] foi rebaixada. Nome e canal se revelam
  **juntos, atrás do gate**. Restrição de produto que vai junto: **esconder o nome não
  pode virar esconder a pessoa** — o card precisa sinalizar gente atrás, senão vira
  catálogo automático, primo do "super apagada".
  ⚠️ **Eu propus *"publicado por um membro do campus"* e estava errado** — sob a opção C
  não temos "membro", temos alguém que informou endereço que casa com regex. Regra que
  substitui: **o card pode afirmar que existe um autor; não pode caracterizá-lo.** O
  honesto é um **fato sobre o sistema** (há autor, e falar com ele exige se identificar),
  não uma alegação sobre a pessoa. Nada que descreva quem publicou aparece antes do gate.
  Formulação do `tecnico` que generaliza: **o card, o selo e o pitch são três renderizações
  do mesmo fato e precisam dizer a mesma coisa.**
  E ao escolher o chat do campus como canal, o campo **vem pré-preenchido** e explica —
  nunca rejeita apelido depois de digitado. Mas a frase não pode ser *"o nome do seu
  cadastro"* (não há cadastro da universidade para consultar; o nome é autodeclarado) e sim
  ***"o chat do campus busca por nome — use exatamente como você aparece lá"***.
- **H21 (o critério do seed é de TELA, não de API)** — erro meu corrigido pelo
  `requisitos`: escrevi "`GET /api/anuncios` devolve ≥12" quando o efeito desejado é a
  tela não parecer apagada; recorte esconde metade e o critério passa verde com o objetivo
  falho. Forma certa: *"a vitrine exibe ao menos 12; ao filtrar por qualquer categoria
  mostrada, exibe ao menos 3"*. **E o seed deve ser MAIOR que o limite** (~18 base / 12 na
  tela): se couber inteiro, *"últimos itens anunciados"* (edital linha 32) nunca demonstra
  nada. Defesa complementar do `requisitos`: **o edital autorizou simular dados** (linha
  31) — simulamos dados e recusamos simular resultados, ou seja, **fazemos menos do que
  foi autorizado**. Vale no README e na narração do minuto 0:00–1:00.
- **H19 (base vazia mostra o bloco com 0)** — não esconder o bloco de estatísticas.
  Razão decisiva: **um 0 visível é o único alarme de que o seed de [[H17]] falhou**; bloco
  escondido + seed que não roda = página que parece razoável e ninguém percebe.
  ⚠️ **Retirei a palavra "ainda"** que eu tinha proposto junto: ela colide com a lista de
  proibidas do `uxcopy`, cujo caso central é *"ninguém demonstrou interesse **ainda**"* —
  promessa por pressuposição feita a quem tem um bem em jogo. Recusei o meio-termo
  (proibir por família de estado vazio): **regra de lint com exceção custa mais do que a
  palavra vale**, e alguém aplicaria a exceção justamente onde ela machuca. Com [[H17]] o
  visitante real nunca vê base vazia, e [[H22]] resolve melhor o mesmo problema. O que
  sustentava a decisão era o bloco presente e o 0 — o resto era decoração minha.
- **H18 (congela o nome, remove o contato)** — depois da entrega, "meus itens" mostra o
  **nome de exibição congelado no momento da marcação** (é a memória do gesto — a tela
  responde ao *"fiquei INSEGURO se realmente foi útil"*) e **não mostra o contato**, nem
  vivo nem congelado (a conversa acabou; canal aberto para transação encerrada é
  superfície sem função). Resolve os dois lados em vez de escolher: a exposição **diminui**
  frente às duas alternativas. Mesma regra de [[H14]] — identificar não é ser encontrável.
  ⚠️ A FK `anuncio.entregue_para → interesse.id` implementa "referência viva" **por
  omissão**: silêncio aqui é decisão tomada por uma célula de tabela.
  Resíduo declarado: congelar preserva exposição **já ocorrida**, para uma pessoa, sobre
  transação da qual ela participou. Exclusão de dados é outro mecanismo, fora dos 15 dias.
- **H16 (vocabulário: quase tudo é primado)** — do papel `uxcopy`, verificado por grep:
  **"desapegar"** e **"anunciar/anúncio"** aparecem só em **enunciado** (4× cada) e
  **zero vezes em resposta**; **"item"** não existe no corpus. Logo o CTA do edital e o
  nome do produto saem do léxico primado. Correção minha à contagem dele: **"lixo" são
  duas pessoas (P01 1× + P04 4×), não três** — e P04 é o não-cego.
  **"Espalhando lixo"** é a frase mais forte do corpus para o medo de quem doa: não é
  "não confio no destino", é **"tenho medo de que meu gesto tenha sido lixo"**.
- **H12 (a palavra na tela é a feature — "identificado", nunca "verificado")** — decisão
  fechada: regex de domínio institucional no cadastro (~15 min), **não** confirmação por
  e-mail (~meio dia + container). O argumento não é preço: **a rede pessoal, que é o
  concorrente real por B08, tem zero verificação e accountability total.** O que faz um
  doador entregar é a contraparte ser **atribuível** — nome, endereço plausível, gesto
  registrado —, não um checkmark. Modelo de ameaça: ninguém forja identidade de aluno
  para ganhar uma apostila usada. String obrigatória: *"informou o e-mail institucional"*.
  Nunca "verificado", nunca check verde — **o ícone mente tão bem quanto a palavra**, e a
  mesma regra vale na narração do vídeo. Confirmação por e-mail é anti-abuso em escala,
  problema de produção, não da decisão de confiança individual.
- **H14 (identificar ≠ ser encontrável)** — regra que apareceu **três vezes** com roupas
  diferentes (matrícula, e-mail institucional do regex, identidade do receptor):
  **nenhum dado coletado para identificar vira dado de contato sem um ato de escolha da
  pessoa.** No schema: `email_institucional` interno e nunca serializado; `contato_valor`
  escolhido para publicação. É o pedido literal de P03 (`respostas:112`). Escrita assim,
  a quarta instância não precisa de war room.
- **H13 (o botão declara a consequência antes do toque)** — ao manifestar interesse, a
  pessoa fica exposta **ao anunciante** (não ao público; B13 segue intocada). É o mínimo
  necessário, mas só é consentido se ela souber antes: o botão diz *"o anunciante vai ver
  seu nome e o contato que você escolheu publicar"*. E a lista de interessados mostra
  **identidade + ordem de chegada, nada mais** — curso e tempo de espera são
  simultaneamente os campos que convidam o doador a julgar quem merece e os que ampliam
  a exposição. Uma decisão resolve as duas.

**Retratações deste round** (ver [[projeto-quem-e-o-usuario]]): meus regrades de **B09**
(contraexemplo era um não-caso — quem nunca tentou não fracassou) e de **B12.1** caíram.
B12.1 como escrita é trivialmente verdadeira; a versão com peso é ***"alguém prefere um
item usado de um estranho a comprar novo na faculdade"*** — reescrever antes de graduar.
Também retratei a cláusula (iii) de B02 ("destinatário identificável do campus"): ela
exige exatamente o **B13** que eu mesmo nomeei. Sobrevive só como *propriedade* — "a
contraparte é membro verificado" — nunca como nome público.

- **H11 (sob a função-objetivo "nota do edital", quase nenhuma suposição de produto
  pontua)** — os quatro eixos da seção 6 são: Git/README/**Diário de Bordo**, Domínio
  Técnico e **Autoria**, **Requisitos Obrigatórios**, e **Curadoria de IA**. Nenhum é
  "qualidade do discovery". O entendimento do problema aparece só no critério do minuto
  0:00–1:00 da seção 5. Consequência: **o discovery não pontua pelo acerto; pontua pelo
  eixo 4** ("punindo cópias sem critério e valorizando o uso analítico") e pelo eixo 1.
  Um war room com retratações registradas é artefato do eixo 4, não do eixo 3.
  **Corolário (do cético, verificado):** defeito no discovery é **oportunidade, não
  risco** — `.ai-log/` é gitignorado (`.gitignore:4`), então a banca não consegue ver o
  erro sozinha. Não corrigir custa quase nada; corrigir **e narrar** no minuto 5:00–6:00
  pontua. Mas a oportunidade só existe se **`docs/discovery/` for commitado** (estava
  untracked) e se o episódio **colar as linhas brutas inline** — o que
  `.claude/rules/diario-de-bordo.md` já exige. E o edital, linha 102-104, pede caso de
  **código** errado: o caso de citação truncada **soma, não substitui**.

**Why:** o worksheet listava B02, B12.1 e B12.3 como riscos paralelos; eles são
**serialmente dependentes**, então testar B02 isolado é impossível — testa-se o elo de
cima. E o modo de falha deste formato apareceu ao vivo: eu e o técnico rodamos o mesmo
grep, tiramos a mesma conclusão errada e a chamamos de convergência. **Convergência na
observação não é convergência na inferência.**

**How to apply:** antes de priorizar de novo, cheque se alguém já rodou o ensaio seco de
H9 e o concierge de H4/H8. Ao propor "validar a demanda", diga **por qual canal se
alcança um ingressante** — a rede pessoal do autor não alcança; o canal proposto é o
**balcão da xerox do campus** (físico), que seleciona por quem está gastando dinheiro
para obter material agora. **Se esse canal falhar, isso não é motivo para dar de ombros:
é o argumento para cortar as features que dependem da demanda.**
