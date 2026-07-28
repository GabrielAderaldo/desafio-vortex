# Benchmark

**Cerimônia 11 do upstream** — a que faltava
**Método:** pesquisa desk (dados secundários) + observação do campus
**Entrada:** `ADR-0004` · `02-sintese-questionario.md`

---

## Por que este documento existe, e por que ele veio tarde

O material de referência do autor lista quatro perguntas que um product discovery
precisa responder. Três foram respondidas ao longo das dez cerimônias. **Uma nunca foi
tocada:**

> *"O problema já foi resolvido por outras pessoas? Se sim, o que vai nos diferenciar
> deles, por que faz sentido gastar tempo e recurso para realizar esse produto?"*

Durante todo o discovery, o único concorrente estudado foi a geladeira do ponto de
ônibus — que é **não-consumo**, não produto. Nenhuma solução digital foi examinada, e o
enquadramento do problema foi construído sem saber o que já existia.

**O critério deste benchmark é o do material de referência**, e ele não é o intuitivo:

> *"O objetivo do benchmark não é analisar o MELHOR produto e sim o principal, ou seja o
> mais usado ou o mais popular. (…) o objetivo do benchmark é estudar como ele chegou
> nesse patamar, o que faz ele continuar lá a tanto tempo e como ele se relaciona com
> seus clientes."*

Por isso o grupo de WhatsApp entra aqui como concorrente de primeira linha, apesar de
não ser um produto de desapego. **Ele é o principal.**

---

## Parte 1 — O que já conecta pessoas dentro de um campus

Ordenado pelo que mais se usa, não pelo que funciona melhor.

### Grupo de WhatsApp de turma · **o concorrente real**

| | |
|---|---|
| **Como funciona** | Alguém posta foto e descrição; quem quer responde; combinam no privado |
| **Por que domina** | Custo zero, todo mundo já está lá, notificação nativa, e **confiança social** — é gente da sua sala, não um estranho |
| **Resolve a dor da geladeira?** | **Sim.** Canal identificado e síncrono: você entrega e sabe que serviu |

**O que ele estruturalmente não pode fazer:** é fechado por definição. Você precisa ser
adicionado por alguém que já te conhece. **Um grupo privado não apresenta duas pessoas
que não se conhecem** — e o calouro do primeiro semestre não está em nenhum.

Defeitos menores, que sozinhos não justificariam construir nada: o anúncio afunda sob
200 mensagens; não existe estado (ninguém sabe se o item ainda está disponível — daí o
"já foi" depois da mensagem); e não há filtro nem memória agregada.

**O que aprendemos:** a barreira de entrada precisa ser mais baixa que a de entrar num
grupo, e o produto só se justifica no que o grupo não alcança — **quem está fora de
todos eles**.

### Centros acadêmicos, atléticas e ligas

Existem para agregar, têm legitimidade institucional e alcançam além da turma. Mas
dependem de **adesão ativa** — você precisa procurar, ir a uma reunião, se filiar. E
tendem a concentrar quem já é engajado.

**O que aprendemos:** legitimidade institucional ajuda na confiança. Exigir filiação
mata o alcance.

### Monitoria e grupos de estudo

O canal de troca de conhecimento que **já é institucional e funciona**. Formal,
vinculado a disciplina, com papéis definidos.

**O que aprendemos:** a universidade já reconhece troca entre pares como valor. O que
não existe é o caminho **informal** — o que ninguém agenda.

### A geladeira do ponto de ônibus · **o benchmark que originou tudo**

| | |
|---|---|
| **Como funciona** | Deixa e vai embora. Fricção fisicamente mínima |
| **Por que é usada** | Está no caminho, não pede nada, não julga |
| **Por que falha** | *"mal cuidada e super apagada"*, *"parece mais lixo na rua"* — e quem deixa nunca sabe se serviu |

É o **EAD do desapego**: você usa o campus e não participa dele. Anônima dos dois lados.

**O que aprendemos:** fricção baixa não basta. E foi ela que provou isso — o canal mais
fácil possível existe, foi usado, e o problema persistiu.

### Mural físico e caixa de sucata do bloco D

Mesmo diagnóstico da geladeira, na fala do respondente: *"parecia mais LIXO que algo
bom"*. **Duas iniciativas independentes recebendo o mesmo julgamento** — o problema não
é a implementação de nenhuma delas, é o formato: **depósito anônimo não gera vínculo.**

### TORPEDO UNIFOR

Chat institucional. Busca por nome ou parte do nome — verificado no aplicativo pelo
autor. **Não há API; qualquer uso é recomendação, não integração.**

Dos quatro entrevistados, **um usa com regularidade**. Mas três de quatro o consideram
apropriado para assunto de campus.

**O que aprendemos:** existe um canal institucional aceito que não expõe telefone. Ele é
o destino do contato, e nunca uma dependência técnica.

---

## Parte 2 — Produtos digitais que já resolveram isto

`documentado` — pesquisa desk, 2026-07-28. **O problema foi resolvido várias vezes, e em
universidades brasileiras.**

| Produto | Onde | O que faz |
|---|---|---|
| **[Trokaí](https://ufmg.br/comunicacao/noticias/estudantes-da-ufmg-criam-aplicativo-para-trocas-e-doacoes-de-roupas)** | UFMG, feito por estudantes | Vender, trocar ou doar roupas, com discurso de moda consciente e economia compartilhada |
| **[UniStore](https://apps.apple.com/us/app/unistore/id6742156858)** | universitário, multicategoria | Materiais de estudo, roupas, eletrônicos, móveis — *"ambiente seguro e confiável para negociações entre estudantes e professores"* |
| **[Commutatio](https://noticias.ufal.br/servidor/noticias/2023/2/veja-a-nova-ferramenta-para-trocas-e-doacoes-entre-os-setores-da-ufal)** | UFAL, institucional | Troca de bens **entre setores** da universidade — administrativo, não estudantil |
| **[Plug Doações](https://www.ufrgs.br/jornal/plataforma-digital-faz-mediacao-de-doacoes-de-aparelhos-eletronicos-para-estudantes-de-baixa-renda/)** | nacional | Conecta quem doa computador a estudante de baixa renda. **Assimétrico por desenho** |
| **[Tradr](https://www.projetodraft.com/conheca-o-tradr-um-aplicativo-de-compra-troca-e-doacao-de-objetos-incubado-em-harvard/)** | incubado em Harvard | Compra, troca e doação de objetos |
| **[Classificados Catraca Livre](https://catracalivre.com.br/economize/confira-sites-e-aplicativos-que-facilitam-trocas-doacoes-e-emprestimos-de-objetos/)** | aberto | Loja online gratuita com recurso de troca |

### O padrão que atravessa todos eles

**Todos são organizados em torno do objeto.** Trocar, doar, vender, mediar. O sucesso de
cada um se mede em itens que circularam ou em pessoas atendidas.

**Nenhum se propõe a aproximar quem não se conhece.** A conexão, quando acontece, é
subproduto da transação — nunca o objetivo declarado.

O **Plug Doações** é o mais explícito nisso: doador de um lado, estudante carente de
outro, papéis fixos. É assistência, não rede — e assistência não cria par, cria
hierarquia.

**Isso é o que sustenta o ADR-0004.** Não estamos entrando num espaço vazio — o espaço
está cheio. Mas está cheio de produtos que otimizam a circulação de coisas, e o
diferencial declarado é outro: **usar a coisa como pretexto para o encontro.**

### O que copiar sem cerimônia

- **Categoria por tipo de item.** UniStore usa e funciona; nossa decisão D1 chegou ao
  mesmo lugar por outro caminho.
- **Recorte de comunidade fechada.** Todos restringem a um campus ou instituição. O
  recorte é o que gera a confiança que uma plataforma aberta não tem.
- **Doação e venda convivendo.** Trokaí e Tradr não separam. Reforça D2 — o critério é o
  valor do item, não o perfil da pessoa.

### O que não copiar

- **Linguagem de negociação.** UniStore fala em *"negociações"*; a nossa população não é
  vendedora — nenhum dos quatro entrevistados se descreveu assim.
- **Papéis fixos de doador e beneficiário.** É o desenho do Plug Doações e trabalha
  contra vínculo entre pares.
- **Discurso de sustentabilidade como fachada.** Trokaí lidera com "moda consciente".
  Ninguém, em quatro entrevistas, mencionou meio ambiente — o que apareceu foi
  **culpa** (*"LIXO é um destino MUITO dificil"*) e **incerteza sobre o destino**.

---

## Parte 3 — Fora do campus

| | O que faz bem | Por que não serve aqui |
|---|---|---|
| **OLX / Enjoei** | Alcance, busca, reputação acumulada | Otimizados para venda entre estranhos, com desconfiança embutida no desenho. Encontro é risco a mitigar, não valor |
| **Facebook Marketplace** | Já tem as pessoas, gratuito | Sem recorte de campus. Vizinhança geográfica não é comunidade |
| **Instagram** | Perfil persistente, alcance por descoberta | Broadcast, não encontro. Post não tem estado — o item aparece disponível para sempre. E exige **manter** um perfil |
| **Little Free Library** | Modelo físico de fricção zero, replicado mundialmente | É a geladeira. Mesmo defeito: anônimo dos dois lados |

**O padrão:** todos tratam o encontro presencial como **custo a minimizar**. Aqui ele é
o produto.

---

## O que este benchmark responde

| Pergunta do material de referência | Resposta |
|---|---|
| O problema já foi resolvido? | **Sim, várias vezes** — inclusive em universidades brasileiras |
| O que nos diferencia? | Todos organizam em torno do objeto. **Nenhum se propõe a aproximar quem não se conhece** |
| Por que gastar tempo nisto? | Porque o concorrente principal — o grupo de WhatsApp — **não pode**, por topologia, alcançar quem está fora de toda rede |
| Nosso público está atendido? | Quem já tem rede, sim. **Quem não tem, por ninguém** |

## Limitações honestas

1. **Pesquisa desk, não uso.** Nenhum dos produtos citados foi instalado ou testado. O
   que sabemos vem de notícia e descrição de loja — **inclui o discurso de marketing de
   cada um**, não o comportamento real.
2. **Não sabemos se algum deles vingou.** Trokaí é notícia da UFMG; nada indica se
   continua ativo. Produto universitário morre com a turma que o criou, e isso é um dado
   que não temos.
3. **O campus da UNIFOR não foi mapeado.** Centros acadêmicos, atléticas e murais entram
   aqui por conhecimento geral do formato, **não por observação local**. Só a geladeira,
   a caixa do bloco D e o TORPEDO são verificados.
4. **Nenhum benchmark de conexão social** — Discord de curso, Reddit de universidade,
   Meetup. Se o produto é sobre vínculo, esses são os concorrentes que faltam olhar.
