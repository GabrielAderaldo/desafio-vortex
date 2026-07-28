# Histórias de usuário e critérios de aceite

**Cerimônia 10 do upstream** · INVEST, via `acdg-skills`
**Entrada:** `PRD-0001` · `10-story-map.md` · `17-modelagem-de-dominio.md` · `18-decisoes-de-interacao.md`
**Saída:** a entrada da **W0** da pipeline

> **Versão 2 — 2026-07-28.** A primeira versão descrevia um item com dois estados
> (*disponível* / *entregue*) e uma marcação unilateral. O ciclo de reserva com código
> de confirmação mudou estado, evento, linguagem e superfície. Reescrito por inteiro em
> vez de emendado, para não sobrar critério falando do produto anterior.
>
> O que entrou: os três estados, o código, o cancelamento pelos dois lados, o limite de
> uma reserva ativa, os locais de encontro, a tela de "Meus interesses". O que saiu: a
> matrícula, inteira.

---

## O padrão, na fonte

> *"INVEST (…) **Independent**, **Negotiable**, **Valuable**, **Estimable**, **Small**,
> **Testable**."* — *Histórias de Usuário 4.0*

**A W0 escreve os testes derivados destes critérios, e eles precisam falhar pelo motivo
certo.** Critério vago não gera teste — gera teste inventado. Cada um abaixo é escrito
como comportamento observável.

---

## Decisões de produto que sustentam os critérios

| # | Decisão | Origem |
|---|---|---|
| **D1** | Categorias **fixas, por tipo de item** — Livros e apostilas · Calculadoras e instrumentos · Eletrônicos e componentes · Vestuário acadêmico · Móveis e organização · Outros | cerimônia 10 |
| **D2** | **Doação ou venda** é uma escolha; preço só existe, e só é obrigatório, quando "venda" está selecionado | cerimônia 10 |
| **D3** | A vitrine pública mostra que o item **encontrou destino**; só quem publicou vê **quem recebeu** | cerimônia 10 |
| **D4** | Os **locais de encontro** ficam no perfil como padrão e são **ajustáveis por anúncio**. O local do anúncio é **cópia tirada na publicação**, não referência viva — mudar o perfil não move o ponto de anúncios já publicados | decisão do autor, 2026-07-28 |
| **D5** | A **matrícula não existe** no sistema. Identidade é nome de exibição auto-declarado, e a sessão usa identificador gerado | `16-modelo-de-dados-por-perfil.md` |
| **D6** | O **código de confirmação** é segredo de transação, **não dado pessoal** — pode ser retido no dispositivo | decisão do autor, 2026-07-28 |
| **D7** | O contador da landing soma **confirmados e declarados** — "encontrou destino" é verdadeiro nos dois casos | decisão do autor, 2026-07-28 |

## Os três estados de um item

| Estado | Na vitrine | Aceita interesse | Quem muda |
|---|---|---|---|
| **Disponível** | sim | sim | — |
| **Reservado** | **sim, com selo** | sim | quem publicou reserva |
| **Encerrado** | não | não | confirmação por código, ou declaração |

**Encerrado tem dois sabores:** *confirmado* (as duas partes participaram, via código) e
*declarado* (só quem publicou afirma). A distinção é registrada e visível a quem publicou.

## Regra de escrita que vale para toda a interface

**Nenhuma frase usa pronome de terceira pessoa com gênero.** O nome de exibição é livre e
auto-declarado — não há como inferir pronome, e errar misgendera uma pessoa real.
Escreve-se *"desfez a reserva"*, nunca *"ela desfez"*.

---

## Fatia 0 — Habilitadores

Não entregam valor a uma pessoa do campus. Registrados separadamente para não serem
confundidos com histórias.

| # | Habilitador | Critério de aceite |
|---|---|---|
| **E-01** | A aplicação sobe inteira por um comando | `docker compose up` deixa API e frontend acessíveis, sem passo manual adicional |
| **E-02** | O frontend obtém dados da API | A página inicial exibe itens vindos de requisição HTTP real — não de dado embutido |
| **E-03** | Os dados sobrevivem a reinício | Um item criado continua existindo depois de derrubar e subir os contêineres |
| **E-04** | Toda resposta da API é JSON | Toda resposta — **inclusive de erro** — tem `Content-Type: application/json` e corpo JSON válido |
| **E-05** | Os locais do campus estão disponíveis | A lista de pontos de encontro vem do arquivo curado; item não pode referenciar local fora dela |

> **E-04 é requisito obrigatório do edital** e o caso que escapa é a **resposta de erro**,
> que muitos frameworks devolvem em HTML por padrão. O teste da W0 precisa cobrir o
> caminho de erro, não só o feliz.

---

## Fatia 1 — O obrigatório

### H-01 · Ver o que está disponível

> Como **estudante do campus**, quero ver os itens que outras pessoas estão oferecendo,
> para descobrir se tem algo que eu preciso.

- [ ] A vitrine é acessível **sem identificação**
- [ ] Cada item exibe título, categoria, imagem e se é doação ou o preço
- [ ] Os itens aparecem **do mais recente para o mais antigo**
- [ ] Itens **encerrados não aparecem**
- [ ] Itens **reservados aparecem, com selo visível** *(ver H-15)*
- [ ] Com a base vazia, a vitrine exibe estado vazio — **não** tela em branco nem erro

### H-02 · Filtrar por categoria

> Como **estudante procurando material**, quero filtrar por categoria, para não percorrer
> itens que não me servem.

- [ ] Existe filtro com as categorias de **D1**
- [ ] Selecionar uma categoria exibe **somente** itens dela
- [ ] É possível limpar o filtro
- [ ] Categoria sem itens exibe estado vazio, **não** erro
- [ ] O filtro é aplicado **pela API**, não descartando resultados no navegador

> Filtrar no cliente passa no teste visual e falha no requisito: o edital pede o endpoint
> de **filtrar**.

### H-03 · Entender a proposta

> Como **visitante que nunca ouviu falar disto**, quero entender o que é e para que
> serve, para decidir se me interessa.

- [ ] A página inicial explica a proposta de economia circular no campus
- [ ] Exibe contadores **refletindo o que está na base**, nunca números fixos na página
- [ ] O contador de destinos **soma confirmados e declarados** *(D7)*
- [ ] Exibe **dois** CTAs distintos: anunciar um item e procurar itens
- [ ] Ambos levam ao lugar correspondente

### H-04 · Publicar um item

> Como **estudante com material sem uso**, quero publicar um item, para que alguém que
> precise possa encontrá-lo.

- [ ] O formulário aceita: título, descrição, categoria, doação/venda, preço *(se venda)*, endereço de imagem, **locais de encontro**
- [ ] **Título, categoria e doação/venda são obrigatórios**
- [ ] Preço é obrigatório **se e somente se** "venda" estiver selecionado
- [ ] Os **locais vêm pré-selecionados do perfil** e podem ser alterados neste item *(D4)*
- [ ] Os locais aparecem como **uma linha de resumo com ação de alterar**, não como seletor aberto — o seletor só abre para quem for mudar
- [ ] A **descrição nasce fechada**, com uma ação para abrir. O campo existe e é enviado normalmente quando preenchido
- [ ] O local gravado no anúncio é **cópia**: alterar o perfil depois **não muda** anúncios já publicados *(D4)*
- [ ] Enviar sem campo obrigatório exibe **qual** campo falta — não mensagem genérica
- [ ] Categoria fora da lista de D1 é **rejeitada pela API**, com erro em JSON
- [ ] Local fora da lista curada é **rejeitado pela API**, com erro em JSON
- [ ] A API rejeita endereço de imagem cujo esquema não seja `http` ou `https`
- [ ] Publicado, o item aparece na vitrine
- [ ] O formulário cabe em **uma tela de celular sem rolagem**, com a descrição fechada e os locais em resumo

> **Os cinco campos que o edital nomeia — título, descrição, categoria, preço-ou-doação e
> endereço de imagem — existem todos.** O que muda é a forma: descrição colapsada e locais
> em resumo. Nenhum campo obrigatório foi removido para caber na tela.

### H-05 · Ver meus itens

> Como **estudante que publicou**, quero ver o que publiquei e em que estado está, para
> acompanhar meus itens.

- [ ] Exibe **apenas** os itens de quem está pedindo
- [ ] Cada item mostra o estado: **disponível, reservado ou encerrado**
- [ ] Item encerrado mostra se foi **confirmado** ou **declarado**
- [ ] Sem identificação, o acesso é **negado** — com erro em JSON, não com lista vazia
- [ ] Quem não publicou nada vê estado vazio com convite a publicar

### H-06 · Remover um item

> Como **estudante que publicou**, quero remover um item, para que ninguém procure algo
> que não está mais disponível.

- [ ] Quem publicou consegue remover o próprio item
- [ ] Removido, some da vitrine
- [ ] Remover item **reservado** é permitido, e **libera a reserva** de quem estava esperando
- [ ] Tentar remover item de outra pessoa é **negado**
- [ ] Tentar remover item inexistente devolve erro em JSON

### H-07 · Instalar na tela inicial

> Como **estudante no celular**, quero instalar o Passa Adiante na tela inicial, para
> abri-lo como aplicativo.

- [ ] Existe manifesto **válido**, com nome, ícones e modo de exibição
- [ ] O Service Worker registra sem erro no console
- [ ] O navegador oferece a instalação
- [ ] Instalado, abre **sem barra de endereço**
- [ ] Usável de 320 px a 1920 px, **sem rolagem horizontal**

---

## Fatia 2 — O diferencial

### H-08 · Demonstrar interesse e obter o contato

> Como **estudante interessado em um item**, quero avisar que quero, para descobrir como
> falar com quem publicou.

- [ ] Quem **não** está identificado **não vê** a forma de contato — em lugar nenhum da resposta, inclusive no JSON bruto
- [ ] Registrar interesse exige identificação
- [ ] Registrado, o contato é revelado
- [ ] A mesma pessoa registrar interesse duas vezes **não cria dois registros**
- [ ] Não é possível registrar interesse no próprio item
- [ ] **É possível** registrar interesse em item **reservado** — quem chega sabe que há alguém na frente
- [ ] Não é possível registrar interesse em item **encerrado**, e a resposta de erro **não contém o contato**

> O primeiro e o último critérios são de **segurança**, não de interface: esconder na tela
> e mandar no JSON é vazamento, e rejeitar vazando no corpo do erro é o mesmo defeito por
> outra porta.

### H-09 · Ver quem se interessou

> Como **estudante que publicou**, quero ver quem se interessou, para escolher para quem
> vou entregar.

- [ ] Exibe a lista de interessados, do mais recente ao mais antigo
- [ ] Só quem publicou vê essa lista
- [ ] Cada interessado aparece com o **nome de exibição** — nunca com identificador interno
- [ ] Interessado cuja reserva foi desfeita **continua na lista**, marcado *(D8, abaixo)*
- [ ] Sem interessados, exibe estado vazio — **sem prometer que alguém aparecerá**

### H-10 · Reservar para alguém

> Como **estudante que vai entregar**, quero reservar o item para uma pessoa, para que os
> outros saibam que já tem alguém e eu tenha como confirmar depois.

- [ ] Quem publicou escolhe **um** dos interessados e reserva
- [ ] Só é possível reservar para alguém que **demonstrou interesse** — não um nome digitado
- [ ] Reservado, o item passa a exibir **selo na vitrine** e continua visível
- [ ] Ao reservar, o sistema gera um **código**, visível **apenas** para quem vai receber
- [ ] O código **não aparece** para quem publicou, em nenhuma resposta, inclusive no JSON bruto
- [ ] Ninguém além de quem publicou consegue reservar
- [ ] Uma pessoa só pode ter **uma reserva ativa** por vez, como recebedora
- [ ] **Nenhum lembrete ou cobrança** é disparado quando um item fica muito tempo reservado

> O código nunca chegar a quem publicou é o que impede a confirmação unilateral. Se ele
> puder ser obtido ou adivinhado pelo lado que confirma, todo o mecanismo volta a ser
> declaração — **sem que nada pareça quebrado**.

### H-11 · Confirmar com o código

> Como **estudante que entregou o item**, quero confirmar com o código, para registrar
> que aquilo chegou a alguém de verdade.

**É a história que justifica o produto.** Se só uma sobreviver, é esta.

- [ ] Quem publicou digita o código e o item passa a **encerrado, confirmado**
- [ ] Código errado exibe erro e **não** encerra
- [ ] O item encerrado exibe, **para quem publicou**, quem recebeu
- [ ] A vitrine pública mostra apenas que o item **encontrou destino** — nunca quem recebeu *(D3)*
- [ ] Existe o caminho **"entreguei, mas não consegui o código"**, que encerra o item como **declarado**
- [ ] Esse caminho é **link de texto, não botão**, e exige uma confirmação a mais que o fluxo normal
- [ ] Item encerrado por declaração exibe **marca permanente** em "Meus itens"
- [ ] Item encerrado **não volta** a nenhum outro estado

### H-12 · Ver que o sistema está vivo

> Como **visitante**, quero perceber que há movimento aqui, para não achar que é um lugar
> abandonado.

- [ ] A página inicial exibe atividade recente
- [ ] Os números **vêm da base**, nunca fixos na página
- [ ] **Com a base vazia, a página não exibe zeros** — exibe uma frase que diz a mesma verdade sem o número
- [ ] Essa frase **não promete atividade futura** nem afirma que algo já aconteceu
- [ ] Nenhum texto afirma atividade que não aconteceu

> **Por que não os zeros.** *"0 itens encontraram destino"* é verdadeiro e desanimador — e
> desanimar é exatamente o defeito da geladeira, que *"parece mais lixo na rua"*. A frase
> diz a mesma verdade sem o número.
>
> **O viés está declarado:** entre duas formulações verdadeiras, esta é a escolhida por
> ser mais animadora. É a única vez no produto em que isso acontece, e por isso o critério
> seguinte existe — a frase não pode escorregar para promessa.

> Escrever *"1.247 itens já encontraram destino"* no HTML cumpriria o requisito de
> "estatísticas simuladas" e seria mentira. O edital autoriza simular **dados**, não
> simular **resultados**.

### H-13 · Desfazer a reserva

> Como **qualquer um dos dois lados**, quero desfazer a reserva, para que o item volte a
> circular quando não vai dar certo.

- [ ] Tanto quem publicou quanto quem ia receber podem desfazer
- [ ] Desfeita, o item volta a **disponível** e o código deixa de valer
- [ ] O sistema registra **qual lado desfez** — nunca de quem foi a falha
- [ ] O interesse **não é apagado**: continua na lista, marcado como reserva desfeita *(D8)*
- [ ] Desfazer **libera o limite** de reserva ativa de quem ia receber

> **D8 — o interesse sobrevive ao cancelamento.** Apagar faria a interface afirmar que a
> pessoa não quer mais, e o sistema observa o ato, nunca o fato. E **quem desfez pode ter
> sido quem publicou** — apagar automaticamente o faria excluir alguém da própria lista
> sem querer.

### H-14 · Ver meus interesses

> Como **estudante que demonstrou interesse**, quero ver os itens que eu quis e em que pé
> estão, para saber onde eu estou em cada um e achar meu código.

- [ ] Exibe os itens em que a pessoa demonstrou interesse, com o estado de cada um
- [ ] Item reservado **para essa pessoa** exibe o **código**
- [ ] Item reservado **para outra pessoa** exibe isso, sem identificar quem
- [ ] Item **encerrado com essa pessoa como destino** exibe que encontrou destino, e a data
- [ ] Item removido ou encerrado por outro caminho aparece com o estado atual
- [ ] Sem identificação, o acesso é **negado** com erro em JSON

> **Por que o terceiro critério existe.** Quem recebe demonstra interesse, conversa,
> atravessa o campus e mostra o código — e, sem ele, termina sem nada na tela, enquanto
> quem entrega ganha o gesto fechado. O rótulo custa uma linha e equilibra os dois lados.
>
> **O contra-argumento, registrado:** essa pessoa estava lá e já sabe. É o mesmo motivo
> que enfraquece o registro para quem entrega. A diferença assumida é que aqui o valor é
> o histórico do que já passou pelas mãos dela no campus, não a informação em si.

> Sem esta tela, quem se interessa não tem superfície nenhuma no produto — e o código não
> tem onde ser lido. Ela é o espelho de "Meus itens".

### H-15 · Saber que o item já tem alguém

> Como **estudante que se interessou**, quero ver que o item já foi reservado, para
> decidir se espero ou procuro outro.

- [ ] Item reservado exibe selo na vitrine e na própria página
- [ ] O selo **não identifica** para quem foi reservado
- [ ] Voltando a disponível, o selo some

---

## Fatia 3 — Bônus

### H-16 · Escolher o que exponho

> Como **estudante que publica**, quero escolher o que aparece como meu contato, para não
> expor o que não quero.

- [ ] É possível escolher entre nome, e-mail ou identificador de rede
- [ ] O escolhido é o que aparece a quem demonstrou interesse
- [ ] Sem escolha registrada, o padrão é o **nome**

### H-17 · Definir meus locais habituais

> Como **estudante que publica com frequência**, quero deixar meus pontos definidos, para
> não escolher de novo a cada anúncio.

- [ ] O perfil aceita um ou mais locais da lista curada
- [ ] Anúncio novo nasce com eles pré-selecionados *(D4)*
- [ ] Alterar o perfil **não muda** anúncios já publicados

### H-18 · Ver o que já carreguei, sem conexão

> Como **estudante no campus com sinal ruim**, quero rever o que já vi, para não perder o
> que estava consultando.

- [ ] Itens já carregados continuam visíveis sem conexão
- [ ] A interface indica que os dados podem estar desatualizados
- [ ] Publicar sem conexão **não** finge sucesso — informa que não foi possível
- [ ] **Nenhuma resposta contendo nome, contato ou lista de interessados é retida em cache**
- [ ] **O código de confirmação é retido** e permanece legível sem conexão *(D6)*

> **D6 — por que o código é exceção.** Ele não é dado pessoal: são poucos caracteres, sem
> nome e sem contato, válidos para uma transação. Quem o obtivesse, no máximo apareceria
> no lugar de outra pessoa para pegar um item. **E é a única tela que precisa funcionar
> exatamente onde o sinal falha** — no campus, no momento do encontro. A regra continua
> valendo para todo o resto.

---

## Revisão INVEST

| Critério | Estado |
|---|---|
| **I**ndependent | ⚠️ **H-05 depende de identidade mínima** na fatia 1, e **H-11 depende de H-10 e H-14** — o código precisa existir e ter onde ser lido. Cadeia declarada |
| **N**egotiable | ✅ Nenhum critério cita rota, tabela ou biblioteca |
| **V**aluable | ⚠️ **E-01 a E-05 não agregam valor a uma pessoa** — por isso estão separados |
| **E**stimable | ✅ |
| **S**mall | ⚠️ **H-04 e H-11 são as maiores.** H-11 divide em confirmar-por-código e encerrar-por-declaração, se precisar |
| **T**estable | ✅ Onde havia intenção, virou verificação |

## O que ficou pendente — não decidido

- **Logout** não existe em nenhuma história. O campus é ambiente de dispositivo compartilhado, e o produto instala como app
- **CSRF, `HttpOnly`, `SameSite` e regeneração de sessão**: cinco propriedades decididas no ADR-0003 e **zero critérios** que as testem. Decisão sem critério não vira teste
- **Se a marca "declarado" aparece fora de "Meus itens"** — decidido que não, sem forma de saber se isso enfraquece o incentivo
- **Estado vazio da vitrine**: a copy não foi escrita
