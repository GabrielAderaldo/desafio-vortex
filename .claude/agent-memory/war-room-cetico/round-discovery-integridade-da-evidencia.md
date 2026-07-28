---
name: round-discovery-integridade-da-evidencia
description: Round de 2026-07-27 (discovery/proto-personas) — o que caiu na auditoria das marcas 🟢, o que sobreviveu e o defeito do instrumento
metadata:
  type: project
---

Auditoria das 18 suposições de `docs/discovery/04-assumptions-worksheet.md` contra as
respostas brutas. **Não reabrir o que está listado como encerrado.**

**Why:** o mediador atribuiu as marcas 🟢/🟡/🔴 sozinho, a partir de 4 entrevistas — uma
delas sendo ele mesmo. O risco não era má-fé, era contaminação de ordem.

**How to apply:** ao usar qualquer 🟢 do worksheet como base de decisão, checar antes se
o ponto está na lista "caiu" abaixo.

## Caiu — verificado no log bruto e nas respostas

- **"P01 e P04 convergiram sem contato" é falso.** `.ai-log/raw-prompts.md`: 23:19 o autor
  pede análise do arquivo de respostas de P01–P03; 23:28/23:29 ele responde como P04.
  Ordem invertida = P04 não foi cego. Derruba a base de B01 e do enquadramento D.
- **P04 não existe no arquivo de respostas brutas.** Só nos prompts (gitignorados) e
  `docs/discovery/` estava untracked. Cadeia de evidência não publicável.
- **"4/4 têm material parado" (U01) é falso.** P01 jogou tudo fora, P03 disse "uso mais
  nada da faculdade". Só P02 e P04 ainda têm material — e P04 é o autor.
- **B04 contradiz o Achado 5.** B04 marca 🟢 em "não receita"; o Achado 5 chama de
  "convergência forte" P02 e P03 dizendo que cobrariam por calculadora/notebook.
- **B08 "4/4"**: P02 respondeu "Biblioteca?" (com interrogação) e é descontado por baixo
  engajamento na limitação 5 — não dá para descontar e contar na convergência.

## Defeito do instrumento — não repetir em questionário futuro

**Q6 nomeia o TORPEDO e Q7 pergunta o canal preferido logo em seguida.** P01 e P03
responderam "torpedo/chat da unifor". O único que nomeou canal não primado foi P02
("WhatsApp") — e é exatamente o rotulado "contra-evidência". Ordem de pergunta contaminou
o Achado 3.

**Regra geral: nunca nomear a solução antes de perguntar o que a pessoa faria.** Resposta
primada parece dado. Vale para todo questionário futuro deste projeto.

> Estado em 2026-07-28: foi o **único** achado meu não aplicado na revisão do discovery —
> todas as correções sobre P04 e contagem entraram; a de ordem de pergunta, não.

## Sobreviveu ao ataque — não reabrir

- **Citações de P04 são verbatim.** Conferidas uma a uma contra `.ai-log/raw-prompts.md`
  linhas 740–758. Nenhuma maquiada.
- **Convergência P02×P03 no eixo valor-do-item** (livro doa / calculadora e notebook cobra)
  é real e independente. É o achado mais bem sustentado do discovery inteiro — melhor que
  B01.
- **Q2 e Q3 perguntam comportamento passado, não intenção.** Metodologia correta, declarada
  no preâmbulo do instrumento.
- **O mediador registrou sozinho** a quebra da premissa de P04 sobre matrícula "interna" vs
  vitrine pública, e a tensão PWA × uso episódico. Boas capturas, não atacar.

## Modo de falha dominante da sala: buscar num lugar, concluir sobre o conjunto

**Três ocorrências no mesmo round.** `produto` e `tecnico`: grep no arquivo de respostas,
não acharam P04, concluíram "sem fonte auditável" — estava no log de prompts. `uxcopy`:
grep nas histórias e no PRD, concluiu "ninguém decidiu sobre seed" — estava em
`09-corte-de-escopo.md:98-108`, com regra explícita.

**A defesa que funcionou foi sempre outro papel conferindo, nunca o rigor de quem afirmou.**
Antes de aceitar "X não existe / ninguém decidiu", rodar `grep -rn` no diretório inteiro.
Custa segundos.

## O eco se repetiu — em 24h, com outro objeto

`produto` e `tecnico` rodaram o mesmo grep, viram que P04 não está no arquivo de respostas
e concluíram, os dois, "citação sem fonte auditável". **Errado** — as respostas estão em
`.ai-log/raw-prompts.md:740-758`, verbatim. Nenhum dos dois abriu o log.

Mesmo padrão do EP-006 (dois papéis medem, ninguém cruza), agora na forma **convergência
na observação, eco na inferência**. Quando dois papéis chegam ao mesmo achado, checar se
pararam no mesmo arquivo.

## Função-objetivo decidida: **nota do edital** (Gabriel, 2026-07-27)

Exigir a declaração do objetivo antes de aceitar qualquer ranking de risco — três objetivos
plausíveis davam três #1 diferentes. Fixado o objetivo, o efeito é brutal e vale relembrar:

- **Suposição de produto quase nunca move a nota.** Os quatro eixos da seção 6 são
  Git/README, autoria no vídeo, requisitos obrigatórios, uso de IA.
- **B12.1 (demanda) tem dano ZERO na nota** e é a mais cara de testar. Testá-la é escolha
  declarada ("quero o produto real"), nunca resultado de priorização por risco.
- **B12.3 sai do ranking de risco e vira decisão de escopo**: o valor-verdade não move a
  nota, só a decisão de construir para ela move.
- **Cerimônias 4–10 erradas não custam ponto** — nenhum eixo avalia proto-persona, outcome,
  story map ou PRD. Divergência registrada com `produto`, que as rankeia por raio de explosão.
- Nada avalia se o mecanismo de confiança **funciona**. Logo vence o mais barato — com a
  condição de que **o pitch não prometa o que o artefato não faz**.

Maior risco real não está no worksheet: **a data-limite de submissão**, desconhecida.

## Objeções minhas que morreram nesta rodada — não reabrir

- **"O framing D afasta do mínimo obrigatório do edital."** Errado: o edital penaliza requisito
  ausente, não endpoint a mais (seção 6). O custo do verbo extra é **tempo de build e de
  vídeo**, nunca conformidade.
- **"O dano de B12.4 ser falsa fica no pitch."** Incompleto. Se o TORPEDO não alcança
  estranho, a decisão de não construir canal próprio (`03-problem-statement.md:80`) cai e
  contato vira código.
- **"Não existe experimento barato e honesto para B02."** Forte demais — montei uma dicotomia
  survey-ou-código que não é exaustiva. Protótipo de papel e concierge são a terceira família.
  Formulação correta: **a precondição de B02 é testável barato; a causalidade não é.**
- **"Verificação de destino exige uma segunda identidade cara."** Não exige: o recebedor já
  se autenticou no gate de contato, por motivo próprio. `entregue_para` como FK e
  `interesse.motivo` custam **+1 coluna cada**. Eu aceitei essa premissa para a FK e não a
  propaguei ao mecanismo que eu mesmo propus um parágrafo depois — **erro de consistência,
  não de fato.**
- **Eu disse "verbatim" e não era.** A síntese normalizou ortografia dentro das aspas
  (`dificil`→`difícil`, `de mais`→`demais`). Foi isso que fez o grep dos dois colegas dar zero
  e produziu o erro "sem fonte auditável". **Regra: texto entre aspas tem que ser localizável
  por grep na fonte** — corrigir com colchetes, nunca dentro das aspas.

## Citação seletiva no Achado 1 (achado do `produto`)

`raw-prompts.md:743`, P04 na pergunta 4: **"Já sim, e já passei mais de uma vez"**, antes do
"porém tem algumas pequenas iniciativas...". Essa metade não está em documento nenhum
(`grep -rn` → vazio) e é relato de **fricção recorrente** — corta contra `02-sintese:38-40`,
que usa a mesma resposta para declarar refutada a hipótese de fricção de canal.
**O enquadramento A, marcado refutado em `02:190`, volta a ficar aberto.**

## Checagem obrigatória: o argumento prova demais?

Aconteceu **duas vezes na mesma sessão**, em direções opostas. `ddd` usou "o sistema não
afirma o que não observa" contra o estado *reservado* — o mesmo princípio engole *entregue*,
que é o núcleo do enquadramento. Eu usei "atividade que não aconteceu" contra semear
entregas — o mesmo teste bane o item semeado, que já está autorizado.

**Antes de usar um princípio para barrar X, aplicá-lo ao que já foi aprovado.** Se barra
junto, o princípio não é o motivo — é outra coisa, e é ela que tem que ser escrita.

## Usar a regra afiada que já está escrita, não a frouxa que serve

Eu tinha citado `09-corte-de-escopo.md:107` (*"simular dados, não simular resultados"*) e
depois fui buscar o critério 4 do H-12 para sustentar a mesma conclusão — mais frouxo, e
foi por onde o argumento quebrou. **Quando duas regras do repo sustentam a mesma conclusão,
usar a mais restrita.**

## Padrão a vigiar: critério de ranking que escorrega para mensurabilidade

`produto` justificou o mesmo #1 duas vezes com propriedades que **não são dano**: "é barato
de testar" e depois "é invisível aos instrumentos". Perguntar sempre: isso é *quanto custa
estar errado* ou *quanto custa saber*?

## Categoria que falta na régua

"🔴 com contra-evidência" não existe na legenda (`04-assumptions-worksheet.md:15-17`) e é a
mais perigosa: B12.3 e B12.2 estão marcadas como desconhecimento tendo sinal contrário nos
dados. Proposta do `produto`, e é boa.

Ver [[enquadramento-do-mediador]] e [[round-stack-nao-verificado]].
