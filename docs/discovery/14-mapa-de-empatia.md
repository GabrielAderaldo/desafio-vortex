# Mapa de empatia

**Cerimônia 12 do upstream**
**Método:** os seis quadrantes, do material de referência do autor
**Insumo:** `01-questionario-proto-personas_respostas.md` (n=4) + follow-up de 2026-07-28
**Alimenta:** a revisão das proto-personas sob o eixo do `ADR-0004`

---

## ⚠️ Dois dos seis quadrantes não têm dado

O instrumento perguntou comportamento e preferência. **Não perguntou o que a pessoa
ouve nem o que ela vê** — os dois quadrantes que capturam o ambiente ao redor dela.

| Quadrante | Situação |
|---|---|
| O que **fala e faz** | 🟢 Bem coberto — foi o foco do instrumento |
| Quais são as **dores** | 🟢 Bem coberto |
| Quais são as **necessidades** | 🟡 Parcial — derivadas das dores, poucas ditas diretamente |
| O que **pensa e sente** | 🟡 Inferido das falas, nunca perguntado |
| O que **vê** | 🔴 Um relato isolado, e por acidente |
| O que **ouve** | 🔴 **Nenhum dado** |

Preencher os dois últimos com suposição arrumadinha seria pior que deixá-los vazios —
um mapa de empatia inventado dá a sensação de conhecer o usuário sem conhecer. Estão
marcados, com as perguntas que faltaram.

## E quem está no mapa é metade do produto

Os quatro respondentes são **veteranos ou ex-alunos, com material acumulado**. Nenhum
ingressante respondeu. Sob o `ADR-0004`, o eixo é *quem está dentro × quem está fora do
ecossistema* — e **este mapa cobre só quem já está dentro**.

O lado que o produto existe para alcançar não tem uma linha aqui.

---

## O que fala e faz 🟢

O quadrante mais confiável, porque é o único construído sobre comportamento passado.

**Guarda, empresta sem volta, ou joga fora — nunca faz circular por canal organizado.**

> P02: *"Ta parada em uma gaveta"*
> P04: *"o meu material ele fica guardado (…) ou 'empresto' por tempo indeterminado, ou doou ele para alguém ou algum canto"*
> P01: *"Joguei minhas apostilas e trabalhos todas no lixo pois começaram a acumular muita poeira e não tinha onde guarda-las"*

**Quando precisa, compra — não procura usado.**

> P03: *"comprei novo"*
> P01: *"costumava sempre optar por comprar os materiais já prontos e cedidos na própria faculdade"*
> P04: *"a maioria são materias na internet que eu imprimo pelo campus"*

**Recorre à rede pessoal antes de qualquer sistema.**

> P01: *"perguntaria para meus amigos se eles conhecem alguém que precisa"*
> P03: *"iria dar pra algum conhecido q esteja cursando a msm coisa"*
> P04: *"eu tenho algumas instituições que eu iria contactar"*

**Já tentou e já desistiu.**

> P04: *"Já sim, e já passei mais de uma vez"* · e sobre a geladeira: *"cheguei a deixar minhas apostilas do ensino médio lá uma vez"*
> P01: *"já quis doar todas as minhas apostilas do ensino médio porém não consegui ir a fundo"*

---

## Quais são as dores 🟢

**Não saber se serviu** — a dor central, e é posterior ao ato.

> P04: *"fiquei INSEGURO se realmente foi útil ou eu estava só 'espalhando lixo'"*

**Não confiar no destino**, a ponto de recusar um canal que existe.

> P04: *"não confiar que REALMENTE ia ser um fim que ia ter um bom cuidado para mim"*

**Não achar para onde ir.**

> P01: *"não consegui ir a fundo para descobrir um local seguro e objetivo"*
> P02, perguntado para onde iria: *"Biblioteca?"* — com interrogação

**O descarte incomoda, mas o espaço vence.**

> P04: *"LIXO é um destino MUITO dificil"*
> P01 jogou tudo fora — *"acumular muita poeira e não tinha onde guarda-las"*

**Expor dado pessoal.**

> P04: *"Eu não gostaria de compartilhar meu numero, acho pessoal de mais"*
> P02: *"Não, preferiria meu nome"*

---

## Quais são as necessidades 🟡

Derivadas das dores acima. Só as duas primeiras foram ditas com todas as letras.

- **Poder escolher o que expõe** — P03: *"gostaria de ter a opção de inserir qualquer coisa, como um e-mail profissional ou um @ de alguma rede social"*
- **Saber para onde levar** — P01, perguntada sobre o que faltou no questionário: *"acho que uma pergunta sobre lugares/postos de doação ou troca de materiais acadêmicos"*
- Um destino em que consiga confiar sem ter que investigar
- Saber que o material chegou a alguém
- Não precisar decidir preço — nenhum dos quatro se descreveu como vendedor
- Descartar sem culpa

> **A necessidade que a P01 nomeou sozinha é a que virou os pontos de encontro.** Ela
> pediu, sem ser perguntada, uma pergunta sobre **lugares**. O `data/locais-campus.toml`
> responde a isso — e vale registrar que a ideia tem origem numa entrevista, não numa
> reunião.

---

## O que pensa e sente 🟡

**Inferido das falas. O instrumento nunca perguntou diretamente.**

- **O material ainda vale alguma coisa** — ninguém disse "é lixo". Guardar por anos é o comportamento de quem atribui valor.
- **Desapegar é adiável.** Não há urgência em nenhuma resposta; o gatilho sempre é externo — poeira, mudança, falta de espaço.
- **Desconfia do institucional mal cuidado.** Duas iniciativas independentes receberam o mesmo julgamento de P04: *"parece mais lixo na rua"*, *"parecia mais LIXO que algo bom"*.
- **Não se vê como vendedor.** Três dos quatro doariam; a venda só aparece acima de um limiar de valor, e P02 nem consegue nomear o critério: *"não sei explicar do que mas depende"*.
- **Sobre expor a matrícula, o grupo está dividido** — e é a única divergência real da amostra.

---

## O que vê 🔴

Quase nada, e o pouco que existe entrou por acidente — veio do follow-up sobre a
geladeira, não de uma pergunta sobre o ambiente.

> P04: *"ela é mal cuidada e super apagada de qualquer coisa, se não for alguém que ativamente quis olhar para ela… **parece mais lixo na rua**"*

**Duas leituras possíveis, e nenhuma testada:** ou o campus não oferece sinal visível de
que existe circulação de material, ou oferece e ninguém repara. A resposta de P02 —
*"Biblioteca?"* — sugere a primeira, mas é uma pessoa e uma interrogação.

**O que faltou perguntar:** *"Você já viu alguém no campus oferecendo ou procurando
material? Onde?"* · *"Tem algum lugar onde você repara que ficam coisas largadas?"*

---

## O que ouve 🔴

**Nenhum dado.** Ninguém foi perguntado sobre o que colegas, veteranos, professores ou
o centro acadêmico dizem sobre material, custo de curso ou desapego.

É a maior lacuna do mapa, e não é lacuna qualquer: **sob o `ADR-0004`, o produto existe
para criar vínculo — e "o que se ouve" é justamente onde o vínculo social aparece.**
Saber se alguém já ouviu *"pede pro fulano do quinto semestre"* diria mais sobre a rede
do campus que qualquer pergunta sobre itens.

**O que faltou perguntar:** *"Alguém já te indicou onde conseguir material?"* ·
*"Você já ouviu falar de alguém que passou material adiante?"* · *"O que os veteranos
falam sobre o que comprar no começo do curso?"*

---

## As divergências, registradas em vez de resolvidas

| Tema | Divergência |
|---|---|
| **Matrícula pública** | P01 tranquila (*"não é um dado sensível para mim"*) · P02 recusa (*"preferiria meu nome"*) · P03 aceita mas quer escolher · P04 aceita sob uma premissa que o produto quebraria |
| **Canal de contato** | P02 escolheu **WhatsApp** — e é a **única resposta não primada** da pergunta, já que a anterior nomeava o TORPEDO |
| **Doar ou cobrar** | P01 doaria sempre · P02 e P03 convergem num limiar de valor · P04 *"não acho que cobraria"* |

---

## O que este mapa entrega para as personas

1. **O eixo mais forte não é ter material — é ter rede.** Quem tem rede resolve por fora
   (P01, P03) e nem chega a precisar de sistema. Quem não tem, não aparece nesta amostra.
2. **A dor é posterior ao ato**, não anterior. Persona que hesita em doar não existe nos
   dados; existe persona que doou e ficou sem resposta.
3. **O gatilho é sempre externo** — poeira, mudança, fim de ciclo. Nenhuma persona acorda
   querendo desapegar.
4. **Ninguém é vendedor**, e o eixo doar/cobrar é o valor do item, não o perfil da pessoa.
5. **Falta metade do mapa**: o lado de quem chega ao campus, que é justamente quem o
   `ADR-0004` diz que o produto existe para alcançar.
