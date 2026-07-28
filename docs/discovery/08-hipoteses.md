# Hypothesis statements

**Cerimônia 6 do upstream** · Lean UX cap. 3
**Entrada:** `06-proto-personas.md` · `07-outcomes.md` · `03-problem-statement.md`

> **Correção de ordem.** A lista original punha o brainstorm de features na cerimônia 7,
> depois desta. O livro pede o contrário: *"To create your hypothesis statements, start
> assembling the building blocks. Put together a list of outcomes (…), a definition of
> the personas (…), and **a set of the features** you believe might work."* O brainstorm
> está embutido abaixo como insumo, e a cerimônia 7 passa a ser o **corte e priorização**
> das features — que é onde o escopo é de fato decidido.

---

## Insumo — features candidatas

Agrupadas por qual dos três defeitos da geladeira (Achado 7) elas atacam. O edital é
citado onde a feature já é obrigatória — nesses casos não há escolha, só desenho.

### Ataca a **confirmação** (*"fiquei inseguro se realmente foi útil"*)

| Feature | Origem |
|---|---|
| Marcar item como entregue, registrando **para quem** | núcleo do enquadramento D |
| Botão "Tenho interesse" — o gate que produz o registro | desenho do `tecnico` (FK `anuncio.entregue_para → interesse.id`) |
| Ver o que aconteceu com os itens que **eu** publiquei | edital: *"visualizar seus próprios anúncios"* (obrigatório) |

### Ataca o **sinal de vida** (*"mal cuidada e super apagada… parece mais lixo na rua"*)

| Feature | Origem |
|---|---|
| Atividade recente na vitrine — o que saiu, e quando | Achado 7 |
| Estatísticas na landing | edital, seção 1.1 (obrigatório) — **e o edital autoriza simular** |
| Estado visível do item: disponível / reservado / entregue | consequência de marcar entrega |

### Ataca a **descoberta** (*"se não for alguém que ativamente quis olhar para ela"*)

| Feature | Origem |
|---|---|
| Vitrine pública com os últimos itens | edital (obrigatório) |
| Filtro por categoria | edital (obrigatório) |
| Landing explicando a proposta, com CTA | edital (obrigatório) |

### Contato e identidade

| Feature | Origem |
|---|---|
| Exibir **nome**, não matrícula, e apontar para o TORPEDO | verificado: a busca é por nome |
| Escolher o que aparece publicamente (nome, e-mail, handle) | P03 pediu; P02 queria nome |
| Sessão por matrícula — identidade interna | ADR-0003 + Achado 4 |

> **Convergência que vale registrar:** o edital exige *"estatísticas simuladas"* na
> landing, e o nosso problema exige que o sistema **pareça vivo**. São a mesma feature.
> O requisito obrigatório mais decorativo do edital é, aqui, o que ataca o defeito
> central do concorrente real.
>
> **Com uma ressalva que não pode ser perdida:** estatística simulada apresentada como
> real é mentira de produto. O edital autoriza para a demonstração; a interface deve
> deixar claro o que é semente e o que é atividade real. Tratado na cerimônia 7.

---

## Formato adotado

O de quatro campos, do cap. 3 — verificado no original:

> **Acreditamos que** \[fazer isto / construir esta funcionalidade / criar esta experiência\]
> **para** \[estas pessoas / personas\]
> **vai alcançar** \[este resultado\]
> **Saberemos que é verdade quando virmos** \[este sinal de mercado, medida quantitativa ou insight qualitativo\]

Duas regras do livro, respeitadas abaixo:

- **Um outcome por hipótese.** *"When you see that happening, split the hypothesis into
  two parts — you want each statement to refer to only one outcome."*
- **O quarto campo não precisa ser numérico.** *"When you look for success metrics,
  remember that it's not all numbers."*

E uma regra nossa, herdada de `07-outcomes.md`: cada hipótese declara se seu sinal é
**observável neste ciclo** (nível 2) ou **só com o produto em operação** (nível 1).
Hipótese cujo sinal não é observável não é hipótese ruim — é hipótese que entra como
risco declarado, e fingir o contrário seria inventar métrica.

---

## H1 — A confirmação do destino

> **Acreditamos que** registrar e exibir para quem o item foi entregue
> **para** quem já desapegou e ficou sem resposta *(Persona 1 — "Entreguei e nunca soube")*
> **vai alcançar** o fechamento do gesto: a pessoa saber que o material serviu a alguém
> **Saberemos que é verdade quando virmos** alguém que já deixou material na geladeira
> olhar para esta tela e **apontar o que ela responde que a geladeira não respondeu**,
> indicando algo concreto na interface — não a intenção do sistema.

| | |
|---|---|
| **Nível do sinal** | 2 — **observável neste ciclo**, com os respondentes do discovery |
| **Suposição que carrega** | B02 🟡 — a precondição tem apoio (*"fiquei inseguro se realmente foi útil"*); a causalidade, não |
| **Sinal negativo** | A pessoa dizer *"é a mesma coisa"* ou não achar nada concreto para apontar. Vale descobrir antes do vídeo |

**É a hipótese central.** Se ela cair, o enquadramento D perde o mecanismo e o produto
vira uma vitrine comum.

---

## H2 — A segunda entrega

> **Acreditamos que** fechar o gesto com a confirmação de destino
> **para** quem já desapegou *(Persona 1)*
> **vai alcançar** que a pessoa desapegue de novo
> **Saberemos que é verdade quando virmos** alguém publicar um segundo item **depois**
> de ter recebido a confirmação do primeiro.

| | |
|---|---|
| **Nível do sinal** | **1 — NÃO observável neste ciclo.** Exige operação real e um segundo uso |
| **Suposição que carrega** | B12.3 🔴⚠ — **um relato contra**: P04 empresta *"por tempo indeterminado"* e doa *"para alguém ou algum canto"*, comportamento incompatível com voltar para conferir |
| **Decisão** | Entra como **risco declarado**. Não há experimento honesto pré-código: perguntar *"você voltaria?"* é intenção declarada, que o instrumento recusa |

**É o outcome que prediz todos os outros** (`07-outcomes.md`) e é o que temos menos
condição de verificar. Essa assimetria é a mais desconfortável do upstream, e está aqui
escrita em vez de diluída.

---

## H3 — O sinal de vida

> **Acreditamos que** exibir atividade recente — o que saiu, quando, e quantos itens já
> encontraram destino
> **para** quem chega à vitrine sem ter ido procurá-la *(Persona 3 — suposição)*
> **vai alcançar** que o sistema não seja lido como abandonado
> **Saberemos que é verdade quando virmos** alguém descrever a tela **sem usar palavras
> como "parado", "vazio", "abandonado"** — e, no negativo, quando alguém repetir sobre
> ela o julgamento que fez da geladeira: *"parece mais lixo na rua"*.

| | |
|---|---|
| **Nível do sinal** | 2 — observável, mostrando a interface |
| **Suposição que carrega** | U06 🟡 — *cuidado e vivo*, não institucional |
| **Tensão não resolvida** | A geladeira falha por abandono **físico**. Nada garante que uma tela falhe ou tenha sucesso pelos mesmos motivos — 🔴 em `07-outcomes.md` |

---

## H4 — O contato que sai do sistema

> **Acreditamos que** exibir o **nome** do anunciante e apontar para o TORPEDO UNIFOR
> **para** quem se interessou por um item
> **vai alcançar** que o contato aconteça sem construirmos canal próprio
> **Saberemos que é verdade quando virmos** alguém conseguir localizar o anunciante no
> TORPEDO **a partir apenas do que a tela mostra**.

| | |
|---|---|
| **Nível do sinal** | 2 — **parcialmente verificado**: a busca por nome existe, conferida pelo autor no app |
| **Suposição que carrega** | B12.4 🟡 |
| **Preço aceito** | Não testamos se um estranho é **respondido** — testar exigiria envolver terceiro sem consentimento, o que foi vetado. Vai para a construção não testado nessa dimensão |

**Nota de desenho:** foi a verificação no TORPEDO que tornou esta hipótese formulável.
Antes dela, o anúncio exibiria a matrícula — e a busca por número não existe, o que
tornaria o contato **impossível por construção**.

---

## H5 — A escolha do que se expõe

> **Acreditamos que** deixar cada pessoa escolher o que aparece publicamente — nome,
> e-mail ou handle
> **para** todas as personas
> **vai alcançar** que ninguém deixe de publicar por desconforto com exposição
> **Saberemos que é verdade quando virmos** os respondentes que recusaram a matrícula
> pública se dizerem confortáveis com a alternativa que escolheram.

| | |
|---|---|
| **Nível do sinal** | 2 — observável |
| **Base** | P02: *"Não, preferiria meu nome"* · P03: *"gostaria de ter a opção de inserir qualquer coisa"* |
| **Custo** | Um campo. É a solução mais barata do discovery inteiro e satisfaz os quatro respondentes |

---

## ⚠️ A hipótese que falta, e que ninguém sabe formular

**H1 depende de alguém clicar "Tenho interesse".** Mas H4 manda o contato acontecer
**fora do sistema**, no TORPEDO. O caminho comum é:

> ver o anúncio → combinar pelo TORPEDO → receber o item → **nunca ter clicado em nada**

Nesse caminho, quem publicou **não tem quem marcar como destinatário**. As saídas
conhecidas, nenhuma boa:

| Saída | Problema |
|---|---|
| Deixar em branco | A tela de destinos nasce vazia — identificado como **pior que não ter a tela** |
| Marcar alguém que apenas demonstrou interesse | Registra destino errado. Destrói o lastro que é a razão de existir da feature |
| Exigir o clique antes de liberar o contato | Fricção artificial, e é o que a geladeira **não** tinha — o defeito que não é nosso |

**Não resolvo isto aqui.** É a decisão central da cerimônia 7, e ela é uma escolha entre
**cobertura** (registrar mais entregas, com menos certeza) e **lastro** (registrar
menos, com mais certeza). Registrada como escolha explícita porque descobri-la depois,
implementando, seria pior.

---

## Resumo

| # | Hipótese | Sinal | Suposição | Estado |
|---|---|---|---|---|
| **H1** | Confirmação do destino | Nível 2 | B02 | 🟡 central |
| **H2** | A segunda entrega | **Nível 1** | B12.3 | 🔴⚠ risco declarado |
| **H3** | Sinal de vida | Nível 2 | U06 | 🟡 |
| **H4** | Contato fora do sistema | Nível 2 | B12.4 | 🟡 parcialmente verificado |
| **H5** | Escolha do que se expõe | Nível 2 | — | 🟢 evidência direta de dois respondentes |

**H5 é a única com apoio direto e explícito de respondentes**, e é a mais barata.
**H2 é a mais importante e a menos verificável.** Essa inversão é o retrato honesto de
onde este upstream chegou.
