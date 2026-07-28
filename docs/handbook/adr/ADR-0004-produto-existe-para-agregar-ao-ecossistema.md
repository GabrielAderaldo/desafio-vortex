---
id: ADR-0004
titulo: Tratar o produto como instrumento de vínculo no campus, não como marketplace de itens
status: aceito
data: 2026-07-28
decisores: [Gabriel Aderaldo]
tags: [produto, proposito, enquadramento, ecossistema, discovery]
componentes: [api, web]
substitui: []
substituido_por: null
relacionados: [PRD-0001, ADR-0003]
ai_log: [EP-008]
---

# ADR-0004 — Tratar o produto como instrumento de vínculo no campus, não como marketplace de itens

## Contexto

O upstream produziu dez cerimônias, um PRD e critérios de aceite. O problema estava
enquadrado como **"o gesto sem resposta"**: existe uma geladeira velha no ponto de
ônibus do campus onde estudantes deixam material, e quem deixa nunca descobre se
serviu — *"fiquei INSEGURO se realmente foi útil ou eu estava só 'espalhando lixo'"*.

Esse enquadramento sobreviveu a um war room de sete papéis e a uma auditoria que
derrubou todas as marcas de evidência do worksheet. Nenhum dos sete perguntou por que o
produto deveria existir.

A pergunta veio do autor, depois de ver o produto desenhado inteiro pela primeira vez:

> *"o que vai diferenciar o nosso sistema de um whats app? Sinceramente, seria muito
> mais barato só fazer a vitrine e deixar os contatos e pronto (…) sendo talvez fazer
> via instagram seja até melhor"*

**O produto como estava especificado não sobrevive a ela.** Se é vitrine mais contato,
é um grupo de WhatsApp pior — porque não tem as pessoas dentro. E o grupo já resolve a
dor original: você posta, alguém responde, você entrega e sabe que serviu. A insegurança
da geladeira não existe ali, porque o canal é identificado e síncrono.

Duas forças adicionais restringem a decisão:

- **O TORPEDO UNIFOR é recomendação, não integração.** Não há API. O produto não sabe
  se a mensagem chegou nem se a pessoa existe lá.
- Um benchmark de dados secundários mostra que **o problema já foi resolvido várias
  vezes** — Trokaí (UFMG), UniStore, Tradr (Harvard), Commutatio (UFAL). Ver
  `docs/discovery/13-benchmark.md`.

## Decisão

> **O produto existe para agregar o estudante ao ecossistema da universidade; o item é
> o pretexto do encontro, não o objeto do serviço.**

## Consequências

### Positivas

- **Responde à provocação de forma estrutural, não por opinião.** Um grupo privado não
  pode, por natureza, apresentar duas pessoas que não se conhecem — é fechado por
  definição, e o calouro do primeiro semestre não está em nenhum. Um sistema aberto do
  campus pode. Não é diferença de funcionalidade; é diferença de topologia.
- **Explica o discovery em vez de descartá-lo.** A geladeira falha por ser **anônima**,
  e anônimo é o oposto de vínculo. *"Fiquei inseguro se foi útil"* deixa de ser falta de
  informação e passa a ser falta de vínculo — se você entrega na mão de alguém que
  agradece, a insegurança não existe. O que faltava nunca foi o dado; era a pessoa.
- **Resolve o defeito que o war room encontrou em H-10.** O papel de DDD mostrou que o
  produto dependia de um ato — marcar quem recebeu — cujo maior benefício vai para
  terceiros. Sob este enquadramento isso deixa de ser defeito e vira coerência: o
  registro alimenta a rede, e a rede é o produto.
- **A Persona 3 para de depender de escassez econômica.** Ela era "o calouro que precisa
  de material", e os dados mostravam que calouro compra novo. Como "quem ainda não está
  no ecossistema", ela é o único perfil que o WhatsApp estruturalmente não alcança.
- **A entrega presencial deixa de ser custo do processo e passa a ser o produto
  acontecendo.**

### Negativas

- **Nada do que o produto entrega mede vínculo.** O sistema observa itens publicados,
  interesses registrados e entregas declaradas — nunca se as pessoas se conheceram, nem
  se aquilo virou alguma coisa. **O propósito é maior do que qualquer coisa que o
  artefato consiga demonstrar**, e isso é permanente, não uma limitação de escopo.
- **O pitch fica mais fácil de exagerar.** "Conectamos o campus" é uma frase que a demo
  não sustenta. Continua valendo a regra: o pitch afirma o que a tela renderiza.
- **Abre pressão por escopo que não vai ser construído** — monitoria, carona, resumo,
  grupos de estudo. A visão passa a ser maior que a entrega, e a diferença precisa ser
  dita em voz alta em vez de disfarçada.
- **O edital não pontua isto.** Nenhum dos quatro eixos avalia propósito de produto. O
  ganho aparece em um único lugar: o minuto 0:00–1:00 do vídeo, que a seção 5 destina a
  *"entendimento do problema de negócio"*.

### Neutras

- Curso e semestre deixam de ser demografia descartável e viram **eixo de conexão** — a
  informação relevante passa a ser quem é de onde, não quem tem o quê.
- Venda fica marginal: transação comercial coloca duas pessoas em contato, mas o vínculo
  que ela cria é comercial. Não contradiz a decisão; apenas não a serve.
- O enquadramento anterior **não é revogado** — é subsumido. "O gesto sem resposta"
  descreve corretamente o sintoma; este ADR nomeia a causa.

## Alternativas consideradas

| Alternativa | Por que não |
|-------------|-------------|
| **Manter "o gesto sem resposta"** como enquadramento único | Descreve o sintoma e não sobrevive à pergunta do WhatsApp: o grupo da turma resolve a mesma dor, de graça, com as pessoas já dentro |
| **Guardar a demanda de quem procura** (proposta da IA) | Feature de eficiência de matching. Responde *o que o sistema faz*, não *para que serve* — e um produto que só otimiza transação continua sendo um WhatsApp com passos a mais |
| **Fazer no Instagram ou num grupo** | Considerado seriamente e é mais barato. Falha no mesmo ponto: alcança quem já está na rede de alguém. Não apresenta desconhecidos |
| **Marketplace de itens, assumido como tal** | É o que o edital descreve literalmente, e o benchmark mostra que já existe — Trokaí, UniStore, Tradr. Entregar mais um não justifica o esforço nem rende o que dizer no vídeo |
| **Ampliar o escopo para monitoria, carona e conhecimento** | Coerente com o propósito e recusado deliberadamente pelo autor: *"Recomendo manter o escopo por questão de ser um processo seletivo, mas sim! é essa ideia de expansão que queremos."* Propósito amplo, escopo estreito |

## Implicações para o código

- **Passa a valer:** o que o sistema registra são **encontros entre pessoas**, não
  movimentações de estoque. O registro de interesse é o início de uma conexão e o evento
  central do domínio; a marcação de entrega confirma que o encontro aconteceu.
- **Passa a valer:** informação que ajuda alguém a se situar no campus — curso, semestre
  — é relevante para o modelo, ainda que opcional e auto-declarada.
- **Deixa de valer:** qualquer métrica de volume como sinal de sucesso — itens
  publicados, GMV, transações concluídas. São *output*, e o benchmark mostra que
  otimizá-las produz mais um marketplace.
- **Deixa de valer:** tratar o contato fora do sistema como limitação a ser eliminada. É
  onde o vínculo acontece; a ambição do produto é **apresentar**, não intermediar.
- **Onde isso aparece:** no modelo de domínio (o que é agregado e o que é evento), na
  landing (o que a página promete), na tela de "meus itens" (o que se mostra de quem
  recebeu) e no roteiro do minuto 0:00–1:00.
