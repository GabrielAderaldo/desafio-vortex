# Priorização de suposições

**Cerimônia 3 do upstream** · Lean UX cap. 3 (risco × grau de desconhecimento)
**Conduzida por:** WAR ROOM — papéis `produto`, `tecnico`, `cetico`
**Entrada:** `04-assumptions-worksheet.md` · `02-sintese-questionario.md` (Achado 7)

---

## A função-objetivo — declarada, porque sem ela a ordem é indecidível

O war room travou numa ambiguidade que ninguém tinha visto: **"qual suposição causa
mais dano" não tem resposta enquanto não se disser *dano em quê*.** Dois papéis
produziram rankings opostos e ambos estavam certos — mediam contra objetivos
diferentes, e nenhum havia declarado qual.

**Função-objetivo adotada: a nota do edital** — os quatro eixos da seção 6.

| Eixo | O que mede |
|---|---|
| 1 | Git/README, clareza das instruções, **Diário de Bordo preenchido** |
| 2 | Domínio técnico e autoria, demonstrados no vídeo |
| 3 | Requisitos obrigatórios funcionando — rotas REST, PWA, responsividade |
| 4 | Uso inteligente e curadoria de IA |

**Consequência aceita:** suposições cuja falsidade não move nenhum desses eixos são
rebaixadas, por mais interessantes que sejam. Isso é escolha declarada, não descuido.

---

## Placar das marcas — depois da auditoria e do Achado 7

Régua com uma quarta marca, proposta no war room: **🔴⚠ — não testada, com
contra-evidência nos dados.** Ela não existia, e é a mais perigosa: esses itens estavam
registrados como simples desconhecimento quando têm sinal contrário.

| ID | Worksheet | Agora | O que mudou |
|---|---|---|---|
| **B01** necessidade | 🟢 | **🟡** | P04 respondeu não-cego. Mas o **Achado 7** dá episódio concreto e artefato verificável — fica 🟡 melhor fundamentado que antes |
| **B02** solução | 🔴 | **🟡** | **Achado 7 fortalece:** *"fiquei inseguro se realmente foi útil"* é demanda literal por confirmação. A **causalidade** (confirmar *resolve*) segue não testada |
| **B03** clientes iniciais | 🟡 | **🟡** | — |
| **B04** valor nº1 | 🟡 (🟢 receita) | **🟡**, cláusula "não receita" **removida** | Contradizia o Achado 5. Dinheiro é **portão acima de um limiar**, não motivo primário |
| **B05** benefícios | 🟡 | **🟡** | Culpa do descarte agora tem episódio (Achado 7) |
| **B06** aquisição | 🔴 | **🔴** | — |
| **B08** concorrência | 🟢 | **🟡** | "4/4" não fechava. Mas o concorrente agora tem **nome e endereço**: a geladeira. Falta incluir *"comprar novo / da faculdade"* (P01, P03) |
| **B09** vantagem | 🔴 | **🔴** | Regrade proposto e derrubado — o contraexemplo era não-caso |
| **B10** maior risco | 🟢 | **🟡** | Um caso, e é o autor. Mas o risco agora é **caracterizado**: parecer abandonado, "lixo na rua" |
| **B11** mitigação | 🔴 | **🔴⚠** | Identidade institucional **não responde** a *"bom cuidado"*, que é a objeção literal |
| **B12.1** demanda | 🔴 | **reescrita → 🔴⚠** | *"alguém prefere item usado de estranho a comprar novo"*. Contra: P01 e P03 compraram novo |
| **B12.2** cold start | 🔴 | **🔴⚠** | U01 recontado: só P02 e P04 têm material |
| **B12.3** segundo uso | 🔴 | **🔴⚠** | Um relato contra (*"empresto por tempo indeterminado (…) ou algum canto"*), três silêncios. **Não é refutação** |
| **B12.4** TORPEDO | 🔴 | **🟡** | **Parcialmente resolvido:** a busca existe, **por nome ou parte do nome**. Falta testar se um estranho é efetivamente respondido |
| **U01** quem é o usuário | 🟢/🔴 | **🟡/🔴** | "4/4 têm material" somava estados opostos. São **2 de 4**, um é o autor |
| **U02** onde se encaixa | 🟡 | **🟡** | — |
| **U03** que problemas resolve | 🟢/🟡 | **🟡/🟡** | Herda a queda de B01 |
| **U04** quando e como | 🔴 | **🔴** | Lacuna do instrumento |
| **U05** que features | 🔴 | **🔴** | Cerimônia 7 |
| **U06** como deve parecer | 🔴 | **🟡** | **Achado 7 preenche:** *cuidado e vivo*, não institucional. Eu havia chutado "institucional" — e instituição é quem abandonou a geladeira |

**Nenhum 🟢 sobreviveu à auditoria.** De 3 evidenciadas / 5 parciais / 10 não testadas,
para **0 evidenciadas · 11 parciais · 4 não testadas · 4 com contra-evidência**.

O Achado 7 recuperou quatro itens (B02, B08, B10, U06) — não por argumento, mas porque
o concorrente real foi finalmente caracterizado.

---

## Ordem de risco sob a nota do edital

Critério: **que dano concreto na nota** a falsidade causa. A maior parte do worksheet
não entra, e esse é o ponto.

| # | Item | Dano na nota |
|---|---|---|
| **1** | **A citação seletiva → episódio do Diário de Bordo** | **Eixos 1 e 4.** O Diário é conteúdo obrigatório (linha 121) e sua omissão é *"severamente penalizada"* (108-109). Único item da lista que se resolve com **texto, não código** |
| **2** | **U05 — quais features** | **Eixo 3.** Escopo é o único mecanismo que protege os requisitos obrigatórios. Cada feature a mais tira segundos de dois blocos cronometrados do vídeo |
| **3** | **B02 (i)+(iii) — a segunda identidade** | **Eixo 3.** Bloco de código que nenhum eixo pontua diretamente. Custo cortado pela solução do `tecnico` (FK `anuncio.entregue_para → interesse.id`), e o funil de autenticação **se paga**: é bônus explícito (linha 59) |
| **4** | **B12.4 — o TORPEDO alcança um estranho** | **Eixos 2 e 3.** Se falso, ou o pitch afirma o que a demo não mostra, ou o contato vira código. **Parcialmente resolvido**: a busca por nome existe |
| **5** | **A base de evidência de B01/B10** | **Eixo 1 e o minuto 0:00–1:00.** Mitigado pelo Achado 7, que trocou uma inferência por um episódio verificável |

### Rebaixados, com o motivo — é aqui que a decisão dói

- **B12.1 (a demanda) — dano na nota: ZERO.** Nenhum eixo avalia se a demanda existe.
  É o item de **maior esforço de testar** e **menor retorno** sob esta função-objetivo.
  Testá-la exige acesso a ingressantes, e o recrutamento disponível reproduz o mesmo
  buraco da amostra atual. **Fica como risco aceito e declarado.** Se for testado, que
  seja escolha explícita — não subproduto deste ranking.
- **B12.3 sai do ranking de risco e vira decisão de escopo.** O valor-verdade dela não
  move a nota; só a decisão de *construir para ela* move. Reaparece como o item 3.
- **U02 × PWA — dano zero.** O edital exige **demonstrar** a instalação (seção 5), não
  que alguém adote. A tensão é real de produto e irrelevante na nota.

---

## Preços aceitos, escritos para não sumirem

**1. B12.4 vai para a construção não testada na dimensão que decide.** Foi desenhado um
teste que envolveria mandar mensagem no TORPEDO para alguém que não pediu para ser
cobaia. **Vetado** — contatar terceiro para testar produto sem consentimento prévio não
é experimento. O teste que sobrou confirma que **existe busca por nome**, não que um
estranho seja respondido. Preço de uma decisão correta, registrado.

**2. Não existe experimento barato e honesto para a causalidade de B02.** A precondição
(alguém quer saber o destino) é testável por comportamento passado — *"quando você
emprestou ou doou, você chegou a saber o que aconteceu? procurou saber?"*. Já há **um**
resultado, e ele corta contra: P04 relata emprestar *"por tempo indeterminado"* e doar
*"para alguém ou algum canto"*. A **causalidade** — confirmar o destino *resolve* a
insegurança — só se testa com protótipo, que é código. **Risco declarado.**

**3. O produto responde "serviu a alguém", não "foi bem cuidado".** A objeção literal de
P04 é sobre *"um fim que ia ter um bom cuidado"*. Identidade institucional não responde
isso. **O pitch não pode prometer o que o artefato não faz** — se o vídeo disser
"resolvemos a desconfiança" e a demo mostrar uma matrícula, a lacuna aparece no único
minuto em que o discovery é avaliado.

---

## Divergência registrada, não resolvida

`produto` põe a base de evidência de B01/B10 em **#1**, por raio de explosão: as
cerimônias 4–10 se apoiam nela. `cetico` põe em **#5**, porque nenhum eixo avalia
proto-persona, outcome ou story map.

Mesmo item, tamanhos opostos — catastrófico para um, conserto de parágrafo para o
outro. O Achado 7 reduziu a distância entre as duas posições, sem eliminá-la.

---

## Não verificados — o que fica em aberto

**Resolvido durante o round:**

- ✅ **O TORPEDO tem busca?** Sim, por **nome ou parte do nome** — não por matrícula.
  Consequência: o contato público precisa expor o nome. Ver `03-problem-statement.md`.
- ✅ **O que são as "iniciativas do campus"?** A geladeira do ponto de ônibus e a caixa
  de sucata do bloco D. Ver Achado 7 — reorganizou o discovery inteiro.

**Aberto:**

| Item | Quem resolve |
|---|---|
| Um estranho que manda mensagem no TORPEDO é respondido? | não testável sem envolver terceiro sem consentimento |
| A geladeira e a caixa seguem lá? Outras pessoas as conhecem? | P01, P02 e P03 **não foram perguntados** sobre elas |
| Ingressantes — a demanda existe não atendida? | exige acesso que a amostra atual não tem |
| Cursos com material caro (medicina, direito) | 3 de 4 respondentes são de computação |
| O 4º convidado externo vai responder? | uma mensagem |

---

## Regra metodológica adotada

**Nunca nomear a solução antes de perguntar o que a pessoa faria.** A pergunta 6 do
instrumento nomeia o TORPEDO e a 7 pergunta o canal preferido — duas das três respostas
de apoio vieram primadas. A única resposta não primada (P02, "WhatsApp") era justamente
a rotulada "contra-evidência". Anotado no instrumento; vale para qualquer questionário
futuro.
