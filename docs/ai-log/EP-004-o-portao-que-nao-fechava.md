# EP-004 — O portão que eu declarei testado três vezes e não fechava

**Data:** 2026-07-26
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code — sessão principal como mediador + 4 subagentes (`war-room-tecnico`, `war-room-produto`, `war-room-cetico`, `investigador`)
**Commits relacionados:** `8121b85`

## Contexto

Eu tinha acabado de montar o formato WAR ROOM: papéis com lentes diferentes discutem
uma questão até restarem hipóteses defensáveis, com a sessão principal como mediador.
Queria testá-lo com uma dúvida real, não com um exercício.

A dúvida era sobre linguagem de script. O que voltou foi outra coisa.

## O prompt

~~~
Pronto, vamos agora testar o /war-room com a pergunta que eu já queria fazer... QUERO BANIR O .sh desse projeto EM tudo incluindo nos .config das IA e do VSCode, vale a pena e podemos usar o justfile no lugar?
~~~

## O que a IA respondeu

O mediador enquadrou o round assim: *"3 arquivos `.sh`, 213 linhas"*, e pediu aos
papéis que avaliassem se valia migrar.

Os quatro rodaram. Vieram medições sólidas — que portar **alonga** o código (59 linhas
de bash viram 78 em TS, +32%), que `/usr/bin/jq` é assinado pela Apple e não é
dependência externa, que a diferença de latência entre linguagens cabe 300× dentro do
timeout de 5 s.

E o cético abriu com isto:

> *"Os três corrigiram a **contagem**. Ninguém corrigiu o **verbo**."*

## Onde quebrou

**Três coisas quebraram, e as três eram minhas.**

**1. O enquadramento estava errado.** Não eram 3 superfícies de shell, eram 5 — faltavam
o bash inline que eu mesmo escrevera dentro do `settings.json` e dois blocos no
`Justfile`. Pior: enquadrei como "migrar código existente" quando a pergunta era
prospectiva — não existe `.vscode/` nem uma linha de aplicação no repo. Isso tornou
invisível a opção mais barata (regra que vale só para código novo), e os três papéis
convergiram porque *a pergunta só admitia uma resposta*.

**2. Um bloqueio institucional que eu tinha inventado.** Eu havia afirmado que a
política contradiria o ADR-0001, fechado e imutável. O cético foi ler: a RFC que
fundamenta o ADR diz o contrário, explicitamente, em duas passagens — *"dax pode ser
adotado independentemente desta decisão, para escrever os scripts de automação em
TypeScript em vez de shell"*. O ADR decide o **runner**, não a linguagem dos scripts.

**3. O bypass.** O `adr-guard.sh` liberava qualquer `Edit` que só tocasse
`status`/`substituido_por` — sem validar o **valor** novo. Dois Edits normais furavam
o único controle de integridade do handbook:

```
1. status: aceito → proposto     ← passava
2. edita o corpo inteiro          ← ADR "proposto" está aberto
```

Reproduzi antes de corrigir:

```
=== PASSO 1: rebaixar status aceito → proposto ===
(saída vazia = permitido)
=== PASSO 2: com status proposto, o corpo fica editável? ===
(saída vazia = permitido)
```

Junto vieram mais quatro: o guard **falhava aberto** sem `jq`; um nome de arquivo com
aspas gerava JSON inválido, que o Claude Code descarta (outro fail-open); a
`statusline.sh` quebrava no `/bin/bash` 3.2 de fábrica, porque o repo dependia sem
declarar do bash 5.3 do brew; e o hook de log gravava um **fence vazio com timestamp
correto** quando o redactor falhava — o modo de falha mais difícil de notar, porque a
contagem de entradas continua batendo.

**O que me incomoda não é a existência dos bugs. É que eu havia escrito "testado" três
vezes sobre esse hook**, em três mensagens diferentes, exibindo saídas de teste que
passavam. Todos os testes que escrevi verificavam o caminho que eu tinha em mente.
Nenhum tentou *furar* a regra.

## Como eu conduzi até a solução

Cortei a discussão de linguagem e fui no que estava quebrado:

~~~
corrige os 5 bugs primeiro, o bypass é o mais urgente
~~~

Antes de aceitar as correções, exigi que cada bug fosse **reproduzido** e depois
**re-testado**. Dois dos testes de verificação falharam por erro do próprio teste —
um `env PATH=/nonexistent bash` que não achava o bash (exit 127) e um payload JSON com
`\n` literal — e nos dois casos a IA declarou que o erro era do teste, não resultado.

A correção do bypass não foi bloquear mais: foi validar o **valor** da transição. A
partir de um status fechado só se pode ir para `substituido` ou `descontinuado`.
Bloquear tudo teria tornado impossível marcar um ADR como substituído — o remédio
óbvio mataria o protocolo.

## O que ficou

**Um teste que só percorre o caminho feliz não é um teste de portão.** O `adr-guard`
tinha oito casos de teste passando. Nenhum perguntava "como eu furaria isso?". A
diferença entre verificar que a fechadura tranca e verificar que a porta não abre por
outro lado é a diferença entre os oito testes que eu escrevi e o único que o cético
escreveu.

**Falha aberta é pior que ausência de proteção.** Sem `jq`, o guard saía 0 — e exit 0
é permissão. O handbook inteiro se apoiava numa garantia que sumia em silêncio se um
binário faltasse. Agora sai 2 e bloqueia.

**Quatro dos cinco bugs eram invariantes de linguagem.** O bypass, o `###` colidindo no
log, a promessa falsa de proteção contra `rm` e o `exit 0` sempre — todos portariam
1:1 para TypeScript. A pergunta que eu fiz ("qual linguagem?") não endereçava nada do
que estava quebrado. A resposta útil não estava na resposta; estava no que a
investigação encontrou de caminho.

**Sobre o formato:** o valor do war room veio inteiro do papel adversarial. Os outros
três produziram análises boas e convergentes — e convergiram porque herdaram a moldura
errada do mediador. Um formato multiagente sem alguém encarregado de atacar a premissa
não é discussão, é o mesmo raciocínio dito de três maneiras.
