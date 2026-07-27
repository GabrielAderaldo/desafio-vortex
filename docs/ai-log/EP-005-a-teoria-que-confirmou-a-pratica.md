# EP-005 — Quando a teoria confirma a prática em vez de corrigi-la

**Data:** 2026-07-27
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code + MCP `acdg-skills`
**Commits relacionados:** `4f59c23`

## Contexto

Eu tenho um processo de engenharia próprio — a pipeline **W0→W3** — que criei por
tentativa e erro ao longo de projetos anteriores e que hoje opera num monorepo com 453
tickets fechados. Nunca o fundamentei: ele nasceu de intuição sobre TDD e BDD, não de
leitura.

Para trazê-lo a este projeto, eu precisava de mais que copiar. Precisava de lastro
teórico — algo que sustentasse cada decisão do processo diante de quem perguntasse
"por que quatro estágios?" ou "por que revisão separada da escrita?".

## O prompt

~~~
Na realidade isso é MEU hardness original que eu criei e uso em todos os meus processos/projetos que faço, porém esse do core-api é de um projeto GIGANTE que tenho e bem maduro, eu queria pegar sim algumas ideias já consolidadas dele... COM TODA A CERTEZA quero pegar a base do SDD e da minha pipeline interna de que chamo de W0 -> W3, então assim preciso só formalizar aqui de alguma maneira para mostrar em evidencia e com teoria para referenciar teoricamente tudo que estou usando, para não aparecer as coisas do nada. Com isso, o W0 -> W3 sinceramente foi feito por mim com base em tentativa e erro e impirismo na base do processo do TDD e do BDD, já o SDD eu peguei como base no speckit da microsoft.
~~~

## O que a IA respondeu

Em vez de citar de memória, usou o MCP `acdg-skills` — o mesmo corpus canônico que eu
já uso no outro projeto — com `skills_buscar` seguido de `skills_citar` e verificação
de *grounding* por termos.

O resultado mais forte veio de onde eu não esperava. Sam Newman, em *Building
Microservices* (p. 244), descreve a arquitetura da minha pipeline sem saber que ela
existe:

> "If we run all the tests together, and if we're waiting for our large-scoped slow
> tests to finish, we may not be able to get fast feedback when our fast tests fail.
> **And if the fast tests fail, there probably isn't much sense in running the slower
> tests anyway!** A solution to this problem is to have different stages in our build,
> creating what is known as a build pipeline."

E, algumas linhas adiante: *"Some stages may be manual."* — que é exatamente a
justificativa dos gates humanos que eu tinha colocado por instinto.

Kent Beck (p. 3) deu a separação entre W0 e W1: *"Escrevemos código novo apenas se um
teste automatizado falhou."* Gregory & Crispin deram a origem dos testes de W0 nos
critérios de aceite.

## Onde quebrou

**Não quebrou — e é esse o ponto do episódio.**

Eu esperava que a fundamentação corrigisse o processo em algum ponto. Não corrigiu.
Cada decisão que eu havia tomado por empirismo tinha correspondente publicado: a ordem
dos estágios, a parada no primeiro vermelho, os gates manuais, os testes derivados de
exemplos.

Duas coisas, porém, ficaram **sem** lastro verificável, e a IA declarou isso em vez de
preencher:

- **Inspeção formal de Fagan (IBM, 1976)** — a raiz de W2 ser read-only.
- **Jidoka / Toyota Production System** — a raiz da política de regressão zero.

Ambas estão no ADR marcadas como *"linhagem reconhecida, sem citação no corpus local"*.
Poderiam ter virado citação plausível de memória. Não viraram — e isso é o
anti-padrão #12 do meu próprio harness (*"citar de memória"*) sendo evitado no lugar
onde eu não estaria olhando.

Houve um erro técnico menor no caminho: o parser do índice usava
`dados.get("outcome", "")`, que devolve `None` quando a chave existe com valor nulo —
o valor padrão só se aplica se a chave estiver ausente. Quebrou na primeira execução
com ticket real e foi corrigido antes de entrar no portão.

## Como eu conduzi até a solução

Meu segundo prompt mudou o rumo mais do que o primeiro:

~~~
Faz a versão proporcional, com ADR + process/
Agora LHE respondendo sobre o ("W0→W3 completo aqui — com STATE.json, CLI de estado, 4 waves obrigatórias por ticket") -> Foi um experimento QUE eu não gostei, então fico pensando... Pode me sugerir opções melhores para fazermos isso? por que SIM precisamos de algo em memoria fisica externa para auditar e guardar estádos. Os tickets eu gosto, mas pode ser melhor escrito ou formuládos.
~~~

Depois pedi que procurasse alternativas open source maduras antes de construir. Foram
avaliadas três, e o resultado inverteu a intuição: **o projeto mais popular era o menos
adequado.**

- **git-bug** (10 mil estrelas) — eliminado por gravar issues como *objetos git, não
  arquivos*. Invisível em `grep` e em diff, ilegível sem instalar a ferramenta.
- **Backlog.md** (6,3 mil estrelas, MIT, MCP nativo para Claude Code) — sério
  candidato, descartado porque seus status são fixos (To Do / In Progress / Done) e
  **não modelam W0→W3**. Adotá-lo seria adaptar meu processo à ferramenta.

Ficou o front-matter YAML próprio, reusando a máquina que já existia para os ADRs.

## O que ficou

**Convergência independente é evidência, não coincidência.** Um processo construído por
tentativa e erro que reproduz, ponto a ponto, o que foi publicado por Newman em 2015 e
Beck em 2002 não é folclore pessoal — é a solução que o problema impõe a quem insiste
nele tempo suficiente.

Isso muda o que a fundamentação serve para fazer. Eu buscava respaldo para mostrar a
terceiros; o que ganhei foi **vocabulário**. "Build pipeline com estágios e fail-fast"
comunica em cinco palavras o que eu explicava em três parágrafos.

**A segunda lição é sobre o não-encontrado.** As duas lacunas — Fagan e jidoka — valem
mais registradas do que preenchidas. Um documento que cita tudo com a mesma confiança
esconde onde a evidência acaba; um que marca as lacunas diz ao leitor exatamente onde
duvidar.

**E a terceira:** pesquisar alternativas antes de construir quase sempre economiza
trabalho — mas nem sempre. Aqui as duas ferramentas maduras foram descartadas por
motivos concretos, e a pesquisa serviu para *justificar* o código próprio em vez de
evitá-lo. O ADR registra ambas com o motivo da recusa, o que impede a discussão de
voltar daqui a um mês.
