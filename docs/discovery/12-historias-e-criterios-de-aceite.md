# Histórias de usuário e critérios de aceite

**Cerimônia 10 do upstream** · INVEST, via `acdg-skills`
**Entrada:** `PRD-0001` · `10-story-map.md` · `11-matriz-de-requisitos.md`
**Saída:** a entrada da **W0** da pipeline

> **Por que os critérios importam mais que as histórias aqui.** A W0 escreve os testes
> *derivados dos critérios de aceite* e eles precisam falhar **pelo motivo certo**.
> Critério vago não gera teste — gera teste inventado. Cada critério abaixo é escrito
> como **comportamento observável**, não como intenção.

---

## O padrão, na fonte

> *"INVEST é um acrônimo (…) que pode nos ajudar a revisar as histórias de usuário para
> verificar se elas foram bem escritas. **Independent** (deve ser independente),
> **Negotiable** (deve ser negociável), **Valuable** (deve agregar valor para o cliente),
> **Estimable** (deve ser possível estimá-la), **Small** (deve ser pequena),
> **Testable** (deve ser testável)."* — *Histórias de Usuário 4.0*

---

## Decisões que faltavam, propostas com fundamentação

As três perguntas em aberto do PRD-0001. **Confirmar antes da W0** — mas nenhuma bloqueia
a leitura das histórias.

### D1 — Categorias: fixas, por tipo de item

O edital exemplifica *"Livros, Engenharia, Computação"* — uma lista **heterogênea**:
"Livros" é tipo de item, "Engenharia" e "Computação" são áreas. Misturar os dois eixos
quebra o filtro (um livro de cálculo pertence a qual?).

**Proposta — por tipo, cobrindo todos os itens que o edital cita:**

| Categoria | Cobre |
|---|---|
| Livros e apostilas | livros, xerox, apostilas |
| Calculadoras e instrumentos | calculadoras científicas |
| Eletrônicos e componentes | componentes eletrônicos, notebook |
| Vestuário acadêmico | jalecos |
| Móveis e organização | móveis |
| Outros | escape obrigatório |

**Fixas**, não livres: lista livre produz "Livro", "livros", "LIVRO" e o filtro deixa de
funcionar — e filtro por categoria é requisito obrigatório (1.4).

### D2 — Doação e preço: uma escolha, com o preço dependente

O edital pede *"preço **ou** indicação de doação"* — é escolha, não dois campos
independentes. As entrevistas convergiram em que o critério é o **valor do item**
(P02: *"não cobraria por livros mas algo como calculadora ou equipamentos talvez
cobraria"*; P03: *"Doaria se fosse algo não muito caro (…) Notebook eu tentaria
revender"*).

**Proposta:** um seletor **doação | venda**. Preço só existe, e só é obrigatório, quando
"venda" está selecionado.

### D3 — A tela de destino: público vê o estado, dono vê o destinatário

A dor original é sobre **utilidade**, não identidade. E quem recebeu é um terceiro cujo
dado não deve ir para a web aberta.

**Proposta:** a vitrine pública mostra apenas que o item **encontrou destino**. Quem
publicou vê, em seus próprios itens, **quem recebeu**.

---

## Fatia 0 — Habilitadores

Não são histórias de usuário: nenhuma entrega valor a uma pessoa. Registradas como
habilitadores para não serem confundidas.

| # | Habilitador | Critério de aceite |
|---|---|---|
| **E-01** | A aplicação sobe inteira por um comando | `docker compose up` deixa API e frontend acessíveis, sem passo manual adicional |
| **E-02** | O frontend obtém dados da API | A página inicial exibe itens vindos de uma requisição HTTP real — não de dado embutido no código |
| **E-03** | Os dados sobrevivem a reinício | Um item criado continua existindo depois de derrubar e subir os contêineres |
| **E-04** | Toda resposta da API é JSON | Toda resposta — inclusive de erro — tem `Content-Type: application/json` e corpo JSON válido |

> **E-04 é requisito obrigatório do edital** (*"estritamente no formato JSON"*, linha 56)
> e o caso que costuma escapar é a **resposta de erro**, que muitos frameworks devolvem
> em HTML por padrão. O teste da W0 precisa cobrir o caminho de erro, não só o feliz.

---

## Fatia 1 — O obrigatório

### H-01 · Ver o que está disponível

> Como **estudante do campus**, quero ver os itens que outras pessoas estão oferecendo,
> para descobrir se tem algo que eu preciso.

**Critérios de aceite**

- [ ] A vitrine é acessível **sem identificação**
- [ ] Cada item exibe título, categoria, imagem e se é doação ou o preço
- [ ] Os itens aparecem **do mais recente para o mais antigo**
- [ ] Itens que já encontraram destino **não aparecem** entre os disponíveis
- [ ] Com a base vazia, a vitrine exibe uma mensagem de estado vazio — **não** uma tela em branco nem erro

### H-02 · Filtrar por categoria

> Como **estudante procurando material**, quero filtrar por categoria, para não percorrer
> itens que não me servem.

**Critérios de aceite**

- [ ] Existe um filtro com as categorias de **D1**
- [ ] Selecionar uma categoria exibe **somente** itens dela
- [ ] É possível limpar o filtro e voltar a ver tudo
- [ ] Categoria sem itens exibe estado vazio, **não** erro
- [ ] O filtro é aplicado **pela API**, não descartando resultados no navegador

> A última linha existe porque filtrar no cliente passa no teste visual e falha no
> requisito: o edital pede o endpoint de **filtrar** (linha 52).

### H-03 · Entender a proposta

> Como **visitante que nunca ouviu falar disto**, quero entender em 10 segundos o que é
> e para que serve, para decidir se me interessa.

**Critérios de aceite**

- [ ] A página inicial explica a proposta de economia circular no campus
- [ ] Exibe estatísticas do sistema — **refletindo o que está na base**, nunca números fixos escritos na página
- [ ] Exibe **dois** CTAs distintos: anunciar um item e procurar itens
- [ ] Ambos levam ao lugar correspondente

### H-04 · Publicar um item

> Como **estudante com material sem uso**, quero publicar um item, para que alguém que
> precise possa encontrá-lo.

**Critérios de aceite**

- [ ] O formulário aceita: título, descrição, categoria, doação/venda, preço *(se venda)*, endereço de imagem
- [ ] **Título, categoria e doação/venda são obrigatórios**
- [ ] Preço é obrigatório **se e somente se** "venda" estiver selecionado
- [ ] Enviar sem campo obrigatório exibe **qual** campo falta — não uma mensagem genérica
- [ ] Categoria fora da lista de D1 é **rejeitada pela API**, com erro em JSON
- [ ] Publicado, o item aparece na vitrine
- [ ] O formulário cabe em **uma tela de celular sem rolagem**

> O último critério vem do constraint dos 2 minutos de demo — está aqui como critério
> testável para não virar boa intenção.

### H-05 · Ver meus itens

> Como **estudante que publicou**, quero ver o que publiquei e em que estado está, para
> acompanhar meus itens.

**Critérios de aceite**

- [ ] Exibe **apenas** os itens de quem está pedindo
- [ ] Cada item mostra o estado: disponível ou entregue
- [ ] Sem identificação, o acesso é **negado** — com erro em JSON, não com lista vazia
- [ ] Quem não publicou nada vê estado vazio com convite a publicar

> ⚠️ **Dependência que a matriz de requisitos encontrou.** H-05 é requisito obrigatório
> (1.9) e está na fatia 1, mas a sessão completa só chega na fatia 2. **A fatia 1 precisa
> de identidade mínima** — ainda que provisória — ou esta história não é implementável.
> É a única violação consciente de *Independent* neste documento.

### H-06 · Remover um item

> Como **estudante que publicou**, quero remover um item, para que ninguém procure algo
> que não está mais disponível.

**Critérios de aceite**

- [ ] Quem publicou consegue remover o próprio item
- [ ] Removido, some da vitrine
- [ ] Tentar remover item de outra pessoa é **negado**
- [ ] Tentar remover item inexistente devolve erro em JSON, **não** falha genérica

### H-07 · Instalar na tela inicial

> Como **estudante no celular**, quero instalar o Passa Adiante na tela inicial, para
> abri-lo como aplicativo.

**Critérios de aceite**

- [ ] Existe manifesto **válido**, com nome, ícones e modo de exibição
- [ ] O Service Worker registra sem erro no console
- [ ] O navegador oferece a instalação
- [ ] Instalado, abre **sem barra de endereço**
- [ ] A aplicação é usável de 320 px a 1920 px, **sem rolagem horizontal**

---

## Fatia 2 — O diferencial

### H-08 · Demonstrar interesse e obter o contato

> Como **estudante interessado em um item**, quero avisar que quero, para descobrir como
> falar com quem publicou.

**Critérios de aceite**

- [ ] Quem **não** está identificado **não vê** a forma de contato — em lugar nenhum da resposta, inclusive no JSON bruto
- [ ] Registrar interesse exige identificação
- [ ] Registrado, o contato é revelado
- [ ] A mesma pessoa registrar interesse duas vezes **não cria dois registros**
- [ ] Não é possível registrar interesse no próprio item
- [ ] Não é possível registrar interesse em item já entregue

> O primeiro critério é de **segurança**, não de interface: esconder na tela e mandar no
> JSON é vazamento. O teste tem que inspecionar a resposta da API.

### H-09 · Ver quem se interessou

> Como **estudante que publicou**, quero ver quem se interessou, para escolher para quem
> vou entregar.

**Critérios de aceite**

- [ ] Exibe a lista de interessados, do mais recente ao mais antigo
- [ ] Só quem publicou vê essa lista
- [ ] Sem interessados, exibe estado vazio — **sem prometer que alguém aparecerá**
- [ ] Cada interessado aparece com a identificação **que ele mesmo escolheu expor**

### H-10 · Marcar quem recebeu

> Como **estudante que entregou o item**, quero registrar quem recebeu, para saber que
> serviu a alguém.

**Critérios de aceite**

- [ ] Quem publicou marca **um** dos interessados como quem recebeu
- [ ] Só é possível marcar alguém que **demonstrou interesse** — não um nome digitado
- [ ] Marcado, o item passa a "entregue" e sai da vitrine pública
- [ ] Quem publicou pode **corrigir** o destinatário depois
- [ ] Item entregue **não aceita** novos interesses
- [ ] Ninguém além de quem publicou consegue marcar
- [ ] **Nenhum lembrete ou cobrança** é disparado quando um item fica muito tempo sem ser marcado

> O último critério é uma decisão de produto virada em teste: o uso é episódico, e cobrar
> quem usa duas vezes por ano é incômodo. Está aqui para que ninguém "melhore" o produto
> adicionando lembretes depois.

### H-11 · Ver o destino dos meus itens

> Como **estudante que doou**, quero ver que meu item chegou a alguém, para saber que não
> foi para o lixo.

**É a história que justifica o produto.** Se só uma sobreviver, é esta.

**Critérios de aceite**

- [ ] Item entregue exibe, para quem publicou, **quem recebeu**
- [ ] A vitrine pública mostra apenas que o item **encontrou destino** — nunca quem recebeu *(D3)*
- [ ] Item disponível não exibe destinatário nenhum
- [ ] A informação é visível **sem passos extras** — na mesma tela de "meus itens"

### H-12 · Ver que o sistema está vivo

> Como **visitante**, quero perceber que há movimento aqui, para não achar que é um
> lugar abandonado.

**Critérios de aceite**

- [ ] A página inicial exibe atividade recente — itens que encontraram destino
- [ ] Os números **vêm da base**, nunca fixos na página
- [ ] Base vazia exibe um estado inicial honesto — **não** números inventados
- [ ] Nenhum texto afirma atividade que não aconteceu

> Este é o critério que impede a saída fácil: escrever *"1.247 itens já encontraram
> destino"* no HTML cumpriria o requisito de "estatísticas simuladas" e seria mentira.
> O edital autoriza simular **dados**, não simular **resultados**.

---

## Fatia 3 — Bônus

### H-13 · Escolher o que exponho

> Como **estudante que publica**, quero escolher o que aparece como meu contato, para não
> expor o que não quero.

**Critérios de aceite**

- [ ] É possível escolher entre nome, e-mail ou identificador de rede
- [ ] O escolhido é o que aparece a quem demonstrou interesse
- [ ] **A matrícula nunca aparece publicamente**, em nenhuma resposta da API
- [ ] Sem escolha registrada, o padrão é o **nome** — sem o qual o contato pelo chat do campus é impossível *(a busca é por nome)*

### H-14 · Ver o que já carreguei, sem conexão

> Como **estudante no campus com sinal ruim**, quero rever itens que já vi, para não
> perder o que estava consultando.

**Critérios de aceite**

- [ ] Itens já carregados continuam visíveis sem conexão
- [ ] A interface indica que os dados podem estar desatualizados
- [ ] Publicar sem conexão **não** finge sucesso — informa que não foi possível
- [ ] **Nenhuma resposta contendo dado de pessoa identificada é armazenada em cache**

> O último é restrição do ADR-0003, e é de segurança: cache de resposta autenticada
> vaza dado entre sessões no mesmo navegador.

---

## Revisão INVEST

| Critério | Estado |
|---|---|
| **I**ndependent | ⚠️ Uma violação consciente: **H-05 depende de identidade mínima** na fatia 1. Registrada, não escondida |
| **N**egotiable | ✅ Os critérios descrevem comportamento, não solução técnica. Nenhum cita rota, tabela ou biblioteca |
| **V**aluable | ⚠️ **E-01 a E-04 não agregam valor a uma pessoa** — por isso estão separados como *habilitadores*, não como histórias |
| **E**stimable | ✅ Todas são pequenas o bastante para serem dimensionadas |
| **S**mall | ⚠️ **H-04 é a maior** (seis campos, validação condicional, regra de categoria). Se precisar dividir: publicar sem validação, depois validação |
| **T**estable | ✅ Todo critério é observável. Onde havia intenção — *"formulário simples"* — virou verificação: *"cabe em uma tela de celular sem rolagem"* |

---

## O que estas histórias deliberadamente não cobrem

| Ausente | Motivo |
|---|---|
| Confirmação por quem recebeu | Cortado na cerimônia 7 — dependeria da suposição mais frágil |
| Conversa dentro do sistema | O contato sai pelo chat do campus |
| Avaliação ou reputação | Não responde à objeção real, que é sobre cuidado com o material |
| Busca por texto | Não pedida pelo edital nem por nenhuma entrevista |
| Editar item publicado | Remover e republicar resolve |
| Notificações | Uso episódico |
