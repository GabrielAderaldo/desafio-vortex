# EP-006 — Três stacks num dia, e a pergunta que estava errada

**Data:** 2026-07-27
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code · WAR ROOM com 4 subagentes · MCPs `security`, `docker-docs`, `reverse-proxy`, `acdg-skills`, `dart`
**Commits relacionados:** `5eefa8f`, `edc7eaf`, `2f3b9dd`

## Contexto

Com o edital finalmente no repositório, comecei o system design. Em poucas horas
propus **três stacks diferentes** — Dart com Darto servindo HTML, depois F# com
TanStack Start, depois F# com SPA React. Cada mudança tinha uma razão que eu só
consegui articular quando questionado.

## O prompt

O que abriu a investigação mais cara do dia:

~~~
Na realidade quero sim, por que sinceramente quero testar a viabilidade dessas tecnologias em um projeto real
~~~

E, algumas trocas depois, os dois que reviraram a decisão:

~~~
Sinceramente em questão do tanstack? é que, to sem paciencia para usar coisas que vão fazer "magica" como por exemplo o astro que vai abstrair tudo de mim e parecer LowCode sabe? quero que quando der problema eu saiba o que quebrou e não passar 500 horas debugando um browser que nem erro mostra...
~~~

~~~
é que eu quero o SSR, pois sinceramente queria fazer um login SIMPLES mas seguro... sem export JWT no cliente entende? nem que, façamos na mão que tbm não é TÃO complexo se usarmos uma tecnica de BFF sabe
~~~

## O que a IA respondeu

Abri um WAR ROOM com quatro papéis para pressionar a stack Dart. Antes, baixei a
documentação de todas as tecnologias em discussão para consulta offline — 23 arquivos,
660 KB — e conectei os MCPs de segurança, Docker e proxy reverso.

Os três primeiros papéis rodaram **probes reais**: instalaram o Darto, subiram
servidor, mediram latência, construíram imagens Docker, testaram SQLite e Postgres,
mediram o tamanho real das bibliotecas de frontend.

O cético entrou depois e derrubou metade do que os outros disseram.

## Onde quebrou

**Quatro erros, e o primeiro foi meu, de enquadramento.**

**1. Eu abri o war room com a pergunta errada.** Enquadrei como *"a stack se
sustenta?"* — pergunta de viabilidade. O cético foi ler a seção 6 do edital, que
ninguém tinha aberto:

> "Os quatro eixos são Git/README, domínio técnico e autoria no vídeo, requisitos
> obrigatórios, e uso inteligente de IA. **Nenhum eixo pontua escolha de stack.** Ela
> só pode *perder* ponto ou *custar* tempo de vídeo. Não ganha nada por si."

Passamos horas otimizando uma variável não pontuada. **Segunda vez que erro o
enquadramento de um war room** — a primeira está no EP-004.

**2. Afirmei "HTMX + Alpine ≈ 29 KB" de memória.** O investigador mediu: **97.584
bytes brutos**. Os 29 KB eram brotli. Ele registrou a lição melhor do que eu diria:
*"é o bruto que paga o parse no dispositivo"*.

**3. Um papel afirmou que spec-first era impossível em Dart.** O cético montou um
projeto com `yaml` + `json_schema`, leu o `openapi.yaml` em runtime e validou 7 de 7
casos com **~30 linhas de glue**. A afirmação defensável seria "não existe middleware
pronto" — e a diferença entre isso e "impossível" são 30 linhas.

**4. A probe que "validou" a stack só fazia o R do CRUD.** `POST` retornava **500** em
todos os payloads testados. Os "2062 req/s, zero erros" foram medidos contra banco
vazio, serializando `{"data":[]}` — e sem erros porque o único caminho que errava não
estava no benchmark. Isso foi reportado como validação da stack.

## Como eu conduzi até a solução

Duas intervenções minhas mudaram o rumo mais do que qualquer análise.

A primeira foi explicar **por que** o TanStack me incomodava — não era config, era
opacidade. Isso derrubou a própria proposta que eu tinha acabado de fazer: TanStack
Start tem roteamento gerado em build, `createServerFn` que disfarça chamada de rede
como função local, e hidratação, cujo erro é notoriamente ilegível. Meu critério
apontava para longe da minha própria escolha.

A segunda foi dizer que queria SSR **por causa de segurança de sessão**. Aí a IA foi
ao OWASP pelo MCP em vez de responder de memória, e trouxe o Session Management Cheat
Sheet:

> "Do not store authentication tokens, session IDs, JWTs (…) in `localStorage` or
> `sessionStorage` (…) **a single XSS vulnerability discloses every token**. Use
> `HttpOnly; Secure; SameSite=Strict` cookies (preferred) or a Backend-for-Frontend
> (BFF) pattern."

Minha intuição estava certa — e o SSR era o meio errado de chegar lá. **`HttpOnly` é
propriedade do cookie, não do modo de renderização.** Uma SPA obtém a mesma garantia.

Perguntei então o que o SSR daria de segurança que eu não tivesse pego. A resposta
honesta foi "quase nada": o único ganho estrutural seria não expor a API — e o edital
**exige** expor, na linha 56.

## O que ficou

**Investigação profunda não protege contra a pergunta errada.** Quatro agentes, quase
400 mil tokens, probes reais com Docker e benchmark — e todo esse rigor foi aplicado
a uma questão que a seção 6 do edital tornava secundária. O cético gastou trinta
segundos abrindo um arquivo que ninguém tinha aberto e reposicionou o round inteiro.

**Mudar de ideia três vezes num dia não foi desperdício — foi o processo funcionando.**
Cada stack morreu por uma razão diferente e nomeável: a primeira por acumular
problemas de cache e uma dependência descontinuada; a segunda por contrariar meu
próprio critério de transparência; a terceira sobreviveu porque os critérios ficaram
explícitos antes da escolha. O ADR-0003 registra os três como alternativas com o
motivo da recusa, para a discussão não voltar.

**A lição sobre a IA é sobre a diferença entre medir e concluir.** As medições dos
papéis foram excelentes e reprodutíveis — imagens Docker, bytes, milissegundos. As
conclusões tiradas delas foram frágeis: um benchmark contra banco vazio virou "a stack
aguenta", e um POST quebrado não impediu ninguém de chamar a probe de validação. O
número estava certo; o que ele provava, não.

**E uma que já apareceu antes e repetiu:** dois papéis mediram coisas contraditórias —
163 MB e 15,5 MB para "a imagem" — ambos rotularam "verificado", e ninguém cruzou. Era
o mesmo padrão do EP-004. Rotular o próprio grau de certeza não serve de nada se
ninguém lê o rótulo do outro.
