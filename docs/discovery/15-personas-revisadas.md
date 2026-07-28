# Personas — revisão sob o eixo do ecossistema

**Cerimônia 13 do upstream** · substitui `06-proto-personas.md`
**Entrada:** `ADR-0004` · `14-mapa-de-empatia.md` · `02-sintese-questionario.md` (n=4)

---

## Por que refazer

As personas anteriores foram segmentadas por **quem tem material parado**. O `ADR-0004`
mudou o que o produto é: ele existe para agregar o estudante ao ecossistema, e o item é
o pretexto do encontro.

Sob esse enquadramento, "ter material" deixa de ser o eixo. E o mapa de empatia apontou
qual é o eixo de verdade:

> **O eixo mais forte não é ter material — é ter rede.** Quem tem rede resolve por fora
> e nem chega a precisar de sistema. Quem não tem, não aparece nesta amostra.

As personas abaixo são segmentadas por **grau de pertencimento ao campus**. É a variável
que o produto tenta mover, e é a única que separa quem o WhatsApp já atende de quem ele
estruturalmente não alcança.

**Continuam sendo proto-personas** — *"our best guess as to who is using our product and
why"* —, diferenciadas por papel e necessidade, nunca por demografia.

---

## Persona 1 — O veterano conectado

> **Pertence, conhece o campus, tem rede. É de onde vem a oferta.**

| | |
|---|---|
| **Base** | 🟡 P04 (o autor, não-cego) e P01 (ex-aluna) |
| **Pertencimento** | Alto — sabe o que é o DJ, sabe quem procurar |
| **Papel no produto** | **Oferta.** É quem tem material e quem já tentou passar adiante |

### O que faz

Guarda material por anos. Empresta sem prazo de volta — *"'empresto' por tempo
indeterminado"* — ou doa *"para alguém ou algum canto"*. Quando precisa de algo, resolve
pela rede ou compra. Já tentou passar material adiante **mais de uma vez**, e uma dessas
vezes usou a geladeira.

### O que sente

O material ainda vale, e descartar incomoda: *"LIXO é um destino MUITO dificil"*.
Desconfia de iniciativa institucional mal cuidada — recusou uma que existia *"por não
confiar que REALMENTE ia ser um fim que ia ter um bom cuidado"*.

### A dor

**Posterior ao ato, não anterior.** Ele age. O que falha é o silêncio depois:

> *"fiquei INSEGURO se realmente foi útil ou eu estava só 'espalhando lixo'"*

### O que o produto oferece a ele

Fechamento do gesto — saber que chegou a alguém real. E, sob o `ADR-0004`, algo que ele
não pediu: **conhecer alguém que ele não conheceria**. Passar adiante para um calouro do
próprio curso é a versão explícita do que veteranos já fazem informalmente.

### O que não sabemos

Se ele valoriza o encontro ou só quer se livrar do item com a consciência limpa. **A
amostra não mede isso**, e é a suposição sobre a qual o produto inteiro se apoia.

---

## Persona 2 — O presente ausente

> **Está matriculado, vai às aulas, e não participa de nada.**

| | |
|---|---|
| **Base** | 🟡 P02 |
| **Pertencimento** | **Baixo, apesar de estar no campus** |
| **Papel no produto** | Oferta latente — tem material, nunca agiu |

### Por que esta persona é nova

Ela não existia na versão anterior, e é a que o `ADR-0004` mais interessa. **Está dentro
do campus e fora do ecossistema** — exatamente o que o autor descreveu ao explicar o
propósito:

> *"não só ir ver aula e ir embora, isso, um EAD faz"*

### O que faz — e o que não faz

O material *"tá parada em uma gaveta"*. Não tentou doar, não tentou vender, não jogou
fora. Respondeu **"não"** à pergunta sobre tentativas frustradas — **não há episódio,
porque nunca houve tentativa**.

Usa o chat institucional *"raríssimas vezes"*. Perguntado por onde preferiria ser
contatado, respondeu **WhatsApp** — a única resposta não primada de toda a amostra.

### A resposta que define a persona

Perguntado para onde iria desapegar:

> **"Biblioteca?"**

**O ponto de interrogação é o dado.** Não é rejeição do caminho — é desconhecimento de
que existe caminho. Ele não sabe o que o campus oferece.

### A dor

Latente, não vivida. Ele não sofre — o que o torna mais difícil de detectar e mais fácil
de ignorar. E é justamente o perfil que uma pesquisa por dor não encontra: **quem não
tentou não tem história para contar.**

### O que o produto oferece a ele

Um caminho óbvio, que se apresente sem exigir procura. E os pontos de encontro: se ele
não sabe para onde ir, saber que *"o CC é onde todo mundo passa"* já é entrar um passo
no campus.

### Ressalva honesta

É o respondente de **menor engajamento** de todos — três "não" e um "não sei". Isso pode
ser desinteresse pelo tema, não ausência de dor. **Mas o baixo engajamento é, ele mesmo,
o sintoma da persona:** quem não participa também não responde questionário com entusiasmo.

---

## Persona 3 — Quem está chegando

> ⚠️ **SUPOSIÇÃO. Nenhum respondente sustenta esta persona.**

| | |
|---|---|
| **Base** | 🔴 nenhuma. Construída do edital e do `ADR-0004` |
| **Pertencimento** | Zero — não conhece ninguém, nem os lugares, nem o vocabulário |
| **Papel no produto** | Demanda, e o motivo declarado de o produto existir |

### O que suporíamos

Chegou agora. Não está em nenhum grupo de WhatsApp — **grupo é fechado por definição, e
ninguém o adicionou ainda**. Não sabe o que é o DJ. Não sabe que existe geladeira, caixa
de sucata, nem veterano com livro sobrando.

Precisa de material e de algo que a pesquisa não mediu: **saber que existe um campus
além da sala de aula.**

### Por que ela mudou de natureza

Na versão anterior era *"o calouro que precisa de material"* — e os dados a
contradiziam: os dois respondentes que precisaram de material **compraram novo**. Como
*"quem ainda não pertence"*, ela para de depender de escassez econômica e passa a
depender de **ausência de rede**, que é o que o produto de fato ataca.

**É o único perfil que o grupo de WhatsApp estruturalmente não alcança.** Não por falta
de feature — por topologia.

### O que continua sem evidência

Tudo. Se ela existe, se compraria usado de um estranho, se toparia atravessar o campus
para pegar um livro, se a barreira é dinheiro ou pertencimento. **Nada disso foi testado,
e testar exige acesso a ingressantes que a amostra atual não tem.**

---

## Anti-persona — Quem já resolveu por fora

> Quem o produto **não** atende. Declarada para não desenhar para quem não vai usar.

| | |
|---|---|
| **Base** | 🟡 P03 |

Não guarda material — *"uso mais nada da faculdade, só meu conhecimento"*. Quando
precisou, **comprou novo**. Quando fosse desapegar, iria à rede pessoal: *"dar pra algum
conhecido q esteja cursando a msm coisa"*. Nenhuma tentativa frustrada.

**A rede dele funciona.** O produto competiria com algo que já resolve o problema — e
resolve melhor, porque envolve gente conhecida.

**O que ele pediu, e vale para todas as personas:** poder escolher o que aparece
publicamente — *"gostaria de ter a opção de inserir qualquer coisa, como um e-mail
profissional ou um @ de alguma rede social"*.

---

## A assimetria estrutural do produto

Vale nomear, porque nenhum documento anterior o fez:

| | Persona 1 e 2 | Persona 3 |
|---|---|---|
| Tem o que oferecer | ✅ | ❌ |
| Precisa do que o produto dá | ❌ *(resolve por fora)* | ✅ |
| Está no ecossistema | ✅ / parcialmente | ❌ |

**Quem tem o que dar já está dentro; quem precisa está fora.** O produto depende de que
o lado inserido participe de algo que ele não precisa — e é a mesma assimetria que o
war room encontrou por outro caminho, ao mostrar que marcar quem recebeu não informa
nada a quem já sabe.

Sob o `ADR-0004` isso deixa de ser defeito e vira o desenho: **o inserido não participa
para resolver um problema seu, participa porque o gesto alimenta a rede.** Mas continua
sendo a aposta mais frágil do produto, e nenhuma feature a resolve.

---

## O que mudou em relação à versão anterior

| Antes | Agora |
|---|---|
| Segmentadas por **ter material parado** | Segmentadas por **grau de pertencimento** |
| "Entreguei e nunca soube" | **Persona 1** — mesma base, papel redefinido como oferta |
| "Está na gaveta e não sei pra onde" | **Persona 2** — reenquadrada como *presente ausente*, e virou a mais interessante |
| "Preciso e não sei que existe" | **Persona 3** — deixa de depender de escassez, passa a depender de rede |
| Anti-persona: "resolvo com meus amigos" | Mantida, sem alteração |

## O que este conjunto assume e ninguém testou

- Que a Persona 3 existe 🔴⚠ — e há contra-evidência: quem precisou, comprou novo
- Que a Persona 2 usaria um caminho óbvio se ele existisse 🔴 — ela nunca tentou nada
- Que a Persona 1 valoriza o encontro, e não só o descarte com consciência limpa 🔴
- Que cursos com material caro (medicina, direito) se comportam como estes 🔴 — 3 de 4 são de computação
