# Proto-personas

> ⚠️ **SUPERADO por `15-personas-revisadas.md`.** Estas personas foram segmentadas por
> *quem tem material parado*. O [ADR-0004](../handbook/adr/ADR-0004-produto-existe-para-agregar-ao-ecossistema.md)
> mudou o produto para "agregar o estudante ao ecossistema", e o mapa de empatia mostrou
> que o eixo real é **grau de pertencimento**, não posse de material.
>
> Mantido como está, sem edição, porque registra o raciocínio com a informação
> disponível na época — e porque a comparação entre as duas versões é o que mostra o
> que a mudança de enquadramento fez.

**Cerimônia 4 do upstream** · Lean UX cap. 3
**Entrada:** `02-sintese-questionario.md` (n=4, com o Achado 7) · `03-problem-statement.md`

---

## O que uma proto-persona é — e o que estas não são

O livro é explícito: proto-personas são *"our best guess as to who is using (or will
use) our product and why"*, criadas **a partir de suposições** e corrigidas pela
pesquisa depois — não o produto de meses de campo. E manda diferenciá-las **por
necessidade e papel, não por demografia**: *"Try to differentiate the personas around
needs and roles rather than by demographic."*

Por isso elas estão nomeadas pelo **comportamento**, não por nome próprio, idade ou
curso. Nada aqui prevê comportamento a partir de quem a pessoa é; tudo prevê a partir
do que ela **já fez**.

**Cada persona declara sua base de evidência.** Duas nascem de relatos reais; uma é
suposição pura e está marcada como tal.

---

## Persona 1 — "Entreguei e nunca soube"

**A persona central. É dela que o problem statement fala.**

| | |
|---|---|
| **Papel** | Já desapegou. Não é hesitante — é reincidente frustrado |
| **Momento** | Depois do ato, não antes |
| **Base** | 🟡 P04 (episódio da geladeira) + P01 (tentativa que não achou destino) |

### Comportamento observado

Age. Já entregou material a um canal público — ou tentou, repetidamente. Não precisa ser
convencido a doar: *"Já sim, e já passei mais de uma vez"*. Resiste ativamente ao
descarte — *"LIXO é um destino MUITO dificil"* [sic] — e usa contornos sociais para não
decidir: empresta *"por tempo indeterminado"*, doa *"para alguém ou algum canto"*.

### Necessidade e frustração

A frustração **não é a entrega**. É o silêncio depois:

> *"fiquei INSEGURO se realmente foi útil ou eu estava só 'espalhando lixo'"*

Precisa saber que o material **serviu a alguém**. Sem isso, a próxima vez não acontece —
não por má vontade, mas porque o gesto anterior nunca fechou.

### O que o produto poderia fazer

Confirmar o destino: quem pegou, e que existe alguém do outro lado. **Não** prometer que
o material foi bem tratado — a objeção literal é sobre *"bom cuidado"*, e o produto não
responde isso (ver `05-priorizacao`, preço aceito nº 3).

### Ressalva

O episódio vem de **P04, que é o autor** e respondeu não-cego. É mitigado por descrever
um **artefato físico verificável** e um **uso concreto**, não uma opinião sobre o
produto — mas segue sendo uma pessoa.

---

## Persona 2 — "Está na gaveta e eu não sei pra onde"

| | |
|---|---|
| **Papel** | Tem o material. Nunca agiu |
| **Momento** | Antes de qualquer tentativa |
| **Base** | 🟡 P02 |

### Comportamento observado

O material está guardado — *"tá parada em uma gaveta"* — e **nada aconteceu**. Não
tentou doar, não tentou vender, não jogou fora. Não relata frustração porque **não
houve episódio**: respondeu "não" à pergunta sobre tentativas que falharam.

Perguntado para onde iria, respondeu com uma **dúvida**, não com um destino:

> *"Biblioteca?"*

Esse ponto de interrogação é o dado. Não é rejeição do caminho — é **desconhecimento de
que existe caminho**.

### Necessidade e frustração

Precisa de um destino **óbvio**: algo que se apresente sem exigir pesquisa. A frustração
é latente, não vivida — o que a torna mais difícil de detectar e mais fácil de ignorar.

Sobre cobrar: o critério é o **valor do item**, e emerge sem que a pessoa consiga
nomeá-lo — *"não sei explicar do que mas depende. Acho que eu não cobraria por livros
mas algo como calculadora ou equipamentos talvez cobraria"*.

### O que o produto poderia fazer

Ser encontrável sem esforço deliberado, e apresentar o caminho inteiro de uma vez.
Aceitar tanto doação quanto venda **sem forçar a escolha antes da hora** — o critério
existe, mas não está articulado na cabeça de quem decide.

### Ressalva

É o respondente de **menor engajamento** do conjunto (três "não" e um "não sei"). O
silêncio dele pode ser desinteresse pelo tema, não ausência de dor. **Também é a única
resposta não primada** sobre canal de contato — escolheu WhatsApp espontaneamente, e por
isso pesa mais nessa pergunta específica do que o engajamento geral sugere.

---

## Persona 3 — "Preciso e não sei que existe"

> ⚠️ **SUPOSIÇÃO PURA — nenhum respondente sustenta esta persona.**
>
> Nenhum ingressante respondeu ao questionário. Esta persona é construída a partir do
> edital (*"facilitando o acesso a materiais para quem está ingressando"*) e de uma
> inferência do Achado 7 — **não** de observação. Está aqui porque metade de um
> marketplace não pode ser omitida do modelo; **não** está aqui porque temos evidência.

| | |
|---|---|
| **Papel** | Precisa do material. Não sabe que a oferta existe |
| **Base** | 🔴⚠ suposição, com **contra-evidência**: P01 comprava da faculdade e P03 *"comprei novo"* |

### O que suporíamos

Que existe alguém que preferiria um item usado de um estranho do campus a comprar novo,
e que não o encontra porque a oferta é invisível — o defeito que o Achado 7 nomeia:
*"se não for alguém que ativamente quis olhar para ela"*.

### A contra-evidência, que não pode ser escondida

Os dois respondentes que precisaram de material **compraram novo** ou compraram da
faculdade. Nenhum dos quatro conseguiu material de veterano. O fluxo veterano → calouro
que o edital toma como dado **não apareceu em nenhum relato**.

### Por que ela fica no documento assim mesmo

Porque omiti-la seria fingir que o produto é de mão única. Mas ela **não pode informar
decisão de design** com o mesmo peso das outras duas — e onde isso acontecer, é erro a
apontar.

---

## Anti-persona — "Resolvo com meus amigos"

Quem o produto **não** atende, declarado para não desenhar para quem não vai usar.

| | |
|---|---|
| **Base** | 🟡 P03 |

Não guarda material — *"uso mais nada da faculdade, só meu conhecimento"*. Quando
precisou, **comprou novo**. Quando fosse desapegar, iria à rede pessoal: *"dar pra algum
conhecido q esteja cursando a msm coisa"*. Não relata nenhuma tentativa frustrada.

**Não tem a dor.** A rede pessoal dele funciona, e o produto competiria com algo que já
resolve o problema — e resolve melhor, porque envolve gente conhecida.

**O que ele mesmo pediu, e que vale para todas as personas:** poder **escolher** o que
aparece publicamente — *"gostaria de ter a opção de inserir qualquer coisa, como um
e-mail profissional ou um @ de alguma rede social"*. É a solução mais barata do
discovery inteiro e satisfaz os quatro respondentes de uma vez.

---

## O que este conjunto assume, e ninguém testou

| Suposição | Estado |
|---|---|
| Persona 1 e Persona 2 são **pessoas diferentes**, não a mesma em momentos distintos | 🔴 não testado — é plausível que sejam a mesma pessoa antes e depois do primeiro uso |
| A Persona 3 existe | 🔴⚠ suposição com contra-evidência |
| A anti-persona é minoria | 🔴 não testado — a amostra tem 1 de 4, o que não diz nada sobre proporção |
| Cursos com material caro (medicina, direito, engenharia com jaleco) se comportam como estes | 🔴 3 de 4 respondentes são de computação |

**O modo de falha que o livro descreve** — a equipe que criou "Susan" e descobriu em
campo que o usuário real era "Timothy" — é exatamente o risco aqui, e a Persona 3 é onde
ele mora. Corrigir isso exigiria falar com ingressantes, e a amostra atual não alcança.
