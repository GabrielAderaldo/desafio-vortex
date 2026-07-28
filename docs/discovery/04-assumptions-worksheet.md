# Assumptions Worksheet

**Cerimônia 2 do upstream** · Lean UX cap. 3 (worksheet de Giff Constable)
**Entrada:** `03-problem-statement.md` · `02-sintese-questionario.md`
**Saída:** insumo da cerimônia 3 (priorização por risco)

---

## Como ler

Cada suposição tem um **ID** (referenciável nas hipóteses) e um **grau de evidência**:

| Marca | Significado |
|---|---|
| 🟢 **Evidenciada** | Sustentada por convergência no discovery (duas ou mais pessoas, sem contato) |
| 🟡 **Parcial** | Sinal fraco, dividido, ou apoiado por uma única pessoa |
| 🔴 **Não testada** | Suposição pura. Nada no discovery a sustenta *nem* a refuta |

O objetivo do exercício, nas palavras do livro, é *"collect statements that reflect what
you and your team think might be true"* — **não** chegar a acordo. Onde há tensão,
ela está registrada em vez de resolvida.

> **Adaptação declarada.** O worksheet original é de time cross-functional. Aqui foi
> preenchido por uma pessoa com os dados de quatro entrevistas na mesa. O livro autoriza
> adaptar (*"you can adapt the questions to your situation as you see fit"*), mas a
> divergência de opiniões que ele busca **não existe estruturalmente aqui** — o que
> aumenta o risco de suposição confortável passar batida. As marcas 🔴 são a defesa.

---

## Suposições de negócio

### B01 — Necessidade 🟢
**Os usuários precisam de um destino confiável e verificável para o material acadêmico
que não usam mais — não de um lugar para anunciar.**

P01 e P04 convergiram sem contato. P04 recusou um canal existente.

### B02 — Solução 🔴
**Essa necessidade se resolve tornando visível quem recebeu o item, o que aconteceu com
ele, e que o destinatário é alguém identificável do campus.**

**A necessidade está evidenciada; esta solução não.** Ninguém disse que isso resolveria
— é a nossa aposta. É a suposição mais cara do documento: todo o produto se apoia nela.

### B03 — Clientes iniciais 🟡
**Os primeiros usuários são estudantes em fim de ciclo — formandos, veteranos, quem
trancou ou evadiu — com material acumulado e sem uso.**

P01 (evadida) e P02 (gaveta) encaixam no perfil. Mas nenhum dos dois **agiu**; o
discovery mostra que têm o material, não que usariam algo.

### B04 — Valor nº 1 🟡
**O que o usuário mais quer é a certeza de que o material foi para alguém que precisava
— não receita, não espaço.**

Nenhum dos quatro se descreveu como vendedor (🟢 para a parte da receita). Mas
**a parte do espaço tem contra-evidência**: P01 jogou tudo fora por *"acumular muita
poeira e não tinha onde guardá-las"*. Espaço venceu a certeza naquele caso. **Tensão
registrada, não resolvida.**

### B05 — Benefícios adicionais 🟡
**Liberar espaço físico, evitar a culpa do descarte, e uma pequena receita quando o item
tem valor alto.**

Culpa do descarte: P04, *"LIXO é um destino MUITO difícil"*. Receita acima de um
limiar: P02 e P03 convergiram (calculadora, notebook).

### B06 — Aquisição 🔴
**Os usuários chegarão por divulgação institucional — e o endosso da universidade é
parte do mecanismo de confiança, não só um canal de marketing.**

Ninguém foi perguntado como descobriria o produto. **Risco alto e não testado.** Note a
circularidade: a confiança depende do endosso institucional, e conseguir endosso
institucional está fora do nosso controle.

### B07 — Receita — *não se aplica*
Não há modelo de negócio: é um desafio técnico avaliado por banca. Registrado porque a
**ausência** tem consequência de design — sem pressão de monetização, não há razão para
comissão, taxa, anúncio ou growth hack. O produto pode ser honesto de graça.

### B08 — Concorrência 🟢
**A concorrência é a inércia (a gaveta), o lixo e a rede pessoal — não outro
aplicativo.**

Convergência de 4/4. Na pergunta "para onde iria primeiro", as respostas foram amigos,
"biblioteca?", conhecido do mesmo curso e instituições. **Zero menções a app,
marketplace, OLX ou grupo de turma.**

### B09 — Vantagem 🔴
**Venceremos porque a rede pessoal só alcança quem você já conhece, e o lixo não dá
nenhuma satisfação.**

**Ninguém reclamou de alcance limitado.** A insatisfação com a rede pessoal é inferência
nossa. É plausível que a rede pessoal seja *suficiente* para quem tem rede — e que o
problema só exista para quem não tem.

### B10 — Maior risco de produto 🟢 *(o risco é evidenciado; a mitigação não)*
**O maior risco é construir um sistema de confiança que as pessoas não reconheçam como
confiável — ou seja, reproduzir exatamente a iniciativa que P04 recusou.**

Este risco não é teórico: existe um caso documentado de recusa a uma solução existente,
pelo motivo exato que estamos tentando atacar.

### B11 — Mitigação 🔴
**Mitigamos com ancoragem institucional (matrícula da UNIFOR como identidade
verificável) somada à visibilidade do destino.**

Não testada. Ver a tensão de B06.

### B12 — O que mataria o projeto se fosse falso

| ID | Suposição | Evidência |
|---|---|---|
| **B12.1** | **Existe demanda.** Alguém do outro lado quer o material | 🔴 **Nenhum ingressante respondeu.** A maior lacuna do discovery |
| **B12.2** | Existe oferta suficiente para a vitrine não nascer vazia (*cold start*) | 🔴 Não testada |
| **B12.3** | As pessoas **voltam** ao sistema para confirmar o destino do item | 🔴 Não testada — e exige um **segundo uso**, que é onde a maioria dos produtos morre |
| **B12.4** | O TORPEDO funciona como canal de contato | 🔴 **Contra-evidência direta:** 3 de 4 não o usam. Ver furo abaixo |

---

## ⚠️ O furo operacional em B12.4

A decisão de usar o TORPEDO como canal de contato foi validada na dimensão errada.

- **Aceitação** — 3 de 4 acham apropriado para assunto de campus. ✅
- **Uso** — 1 de 4 abre o aplicativo com regularidade. ❌

São coisas diferentes, e o loop precisa das duas. **Uma pessoa que recebe mensagem num
canal que não abre nunca responde.** O anúncio vira um beco sem saída, e a experiência
resultante — "mandei mensagem e ninguém respondeu" — é *pior* para a confiança do que
não ter canal nenhum. Ataca exatamente B01, que é a fundação do produto.

Isso **não** derruba a decisão: o TORPEDO continua sendo o único canal que não expõe
dado pessoal (P04: *"não gostaria de compartilhar meu número, acho pessoal demais"*).
Mas exige tratamento explícito, e a saída provável já veio do discovery — **P03 pediu
para escolher o canal**: *"gostaria de ter a opção de inserir qualquer coisa, como um
e-mail profissional ou um @ de alguma rede social"*.

---

## Suposições de usuário

### U01 — Quem é o usuário? 🟡
**Dois papéis, não dois perfis de pessoa:** quem desapega e quem procura. A mesma pessoa
pode ser os dois em momentos diferentes.

Quem desapega: 🟢 (4/4 têm material parado ou descartado).
Quem procura: 🔴 **ausente da amostra**.

### U02 — Onde o produto se encaixa na vida? 🟡
**Em momentos de transição — fim de semestre, mudança de casa, formatura, trancamento,
faxina. Não é uso recorrente.**

P01 agiu quando o material *"começou a acumular muita poeira"*: o gatilho foi um evento
físico, não uma intenção. O uso é **episódico**, disparado por evento externo.

> **Tensão com o requisito de PWA.** O edital exige um app instalável na tela inicial.
> Se o uso é episódico — duas ou três vezes por ano —, **a proposta de valor de instalar
> é fraca**. Isso não dispensa o requisito (é obrigatório), mas significa que a
> instalação precisa ser justificada por outra coisa que não a frequência. Registrado
> para as cerimônias 6 e 7.

### U03 — Que problemas resolve? 🟢 / 🟡
Primário: **a incerteza sobre o destino** (🟢). Secundários: espaço físico e a culpa do
descarte (🟡).

### U04 — Quando e como é usado? 🔴
**Anúncio:** em casa, durante faxina ou mudança, no celular, com o item na mão.
**Descoberta:** início de semestre, celular ou desktop.

**Inteiramente não testada.** Nenhuma pergunta do questionário cobriu contexto de uso —
lacuna do instrumento, não dos respondentes.

### U05 — Que features importam? 🔴
Cadastro rápido de anúncio e visibilidade de quem recebeu. Tratado a fundo na cerimônia 7.

### U06 — Como deve parecer e se comportar? 🔴
**Precisa parecer institucional e oficial, não marketplace genérico** — porque a
confiança vem da ancoragem no campus (B11), e um visual de e-commerce trabalharia contra
isso.

Inferência a partir de B10/B11. Ninguém foi perguntado sobre aparência.

---

## Resumo para a cerimônia 3

| Grau | IDs |
|---|---|
| 🟢 **Evidenciadas** (3) | B01, B08, B10 · parte de U03 |
| 🟡 **Parciais** (5) | B03, B04, B05, U01, U02 |
| 🔴 **Não testadas** (10) | B02, B06, B09, B11, B12.1–B12.4, U04, U05, U06 |

**Dez das dezoito suposições não têm nenhuma evidência.** Entre elas está **B02** — a
aposta de solução sobre a qual o produto inteiro se apoia — e **B12.1**, a existência
de demanda.

Isso não é motivo para parar: o Lean UX existe justamente para trabalhar assim. Mas é
motivo para que a cerimônia 3 priorize por **risco × desconhecimento**, e não pela
suposição mais confortável de defender.
