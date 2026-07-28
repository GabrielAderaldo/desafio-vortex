# Passa Adiante

> Uma plataforma de desapego de material acadêmico no campus da UNIFOR — que responde
> à pergunta que a doação normalmente deixa em aberto: **serviu para alguém?**

Desafio técnico — **Laboratório Vortex**.

Existe hoje, num ponto de ônibus do campus da UNIFOR, uma geladeira velha onde qualquer
estudante pode deixar material que não usa mais. A ideia é ótima e a execução é
invisível: ela é *"mal cuidada e super apagada"*, e quem passa sem estar procurando
por ela vê apenas *"lixo na rua"*. Mais importante — quem deixa material lá **nunca
descobre se ele serviu**.

Essa frase veio de uma entrevista real, de alguém que usou a geladeira:

> *"cheguei a deixar minhas apostilas lá uma vez, porém fiquei **INSEGURO se realmente
> foi útil** ou eu estava só 'espalhando lixo'."*

O **Passa Adiante** não tenta facilitar a doação — a geladeira já tem fricção quase
zero e mesmo assim falha. Ele **fecha o gesto**: quem publica um item descobre que
alguém real o recebeu, e a vitrine mostra sinais de que o sistema está vivo, não
abandonado.

O contato entre as pessoas acontece **fora** do sistema, no TORPEDO UNIFOR — o chat
institucional que os estudantes já têm. Não construímos mais um canal de mensagens.

📄 **O raciocínio completo** — pesquisa com estudantes, hipóteses e o corte de escopo —
está em [`docs/discovery/`](docs/discovery/).

🎨 **As jornadas e os wireflows** estão no
[Figma](https://www.figma.com/community/file/1663876864232938978)
e, como snapshot versionado, em [`docs/design/exportado/`](docs/design/exportado/).

## Sumário

- [Tecnologias](#tecnologias)
- [Pré-requisitos](#pré-requisitos)
- [Rodando localmente](#rodando-localmente)
- [Variáveis de ambiente](#variáveis-de-ambiente)
- [Estrutura do repositório](#estrutura-do-repositório)
- [Aplicação em produção](#aplicação-em-produção)
- [Diário de Bordo da IA](#-diário-de-bordo-da-ia)

---

## Tecnologias

Decisões registradas em [ADR-0003](docs/handbook/adr/ADR-0003-stack-fsharp-spa-e-sessao-por-cookie.md).

### Backend

| Tecnologia | Versão | Por que foi escolhida |
|------------|--------|------------------------|
| F# / .NET | <!-- PENDENTE-FATIA-0 --> | Linguagem funcional com tipos algébricos e *exhaustiveness checking* — estados impossíveis do anúncio não compilam. Escolhida também como aprendizado deliberado num projeto com consequência real |
| ASP.NET Core | <!-- PENDENTE-FATIA-0 --> | Ecossistema maduro por trás do F#, com duas décadas de rede de segurança |
| *(framework HTTP)* | <!-- PENDENTE-FATIA-0 --> | Falco, Giraffe ou Minimal APIs — decisão deliberadamente adiada para a primeira fatia vertical, por ser reversível |

### Frontend

| Tecnologia | Versão | Por que foi escolhida |
|------------|--------|------------------------|
| React + TypeScript | <!-- PENDENTE-FATIA-0 --> | TypeScript pleno é bônus do edital. React dá território familiar para explicar no vídeo, contrabalançando o F# |
| Vite | <!-- PENDENTE-FATIA-0 --> | Build direto, sem geração de código escondida — critério declarado de **debugabilidade** |
| Service Worker | — | Escrito à mão, não gerado. É um dos itens que o edital pede para explicar no vídeo |

### Infraestrutura e ferramentas

| Ferramenta | Versão | Uso |
|------------|--------|-----|
| Docker + Compose | Engine 29.4.0 | Subir aplicação e banco. Obrigatório neste projeto |
| [just](https://github.com/casey/just) | — | Ponto único de entrada das tarefas ([ADR-0001](docs/handbook/adr/ADR-0001-adotar-just-como-task-runner.md)). `just check` é o portão de verificação |
| Typst | — | Compilação do edital em PDF |

> **Por que não SSR, e por que não `localStorage`:** a sessão usa cookie
> `HttpOnly; Secure; SameSite=Strict`. O OWASP Session Management Cheat Sheet é explícito
> — *"a single XSS vulnerability discloses every token"* — e `HttpOnly` é propriedade **do
> cookie**, não do modo de renderização. Uma SPA obtém a mesma garantia que SSR daria.

---

## Pré-requisitos

| Requisito | Versão mínima | Como verificar |
|-----------|---------------|----------------|
| Docker + Docker Compose | Engine 29.x | `docker -v` |
| .NET SDK | <!-- PENDENTE-FATIA-0 --> | `dotnet --version` |
| Node.js | <!-- PENDENTE-FATIA-0 --> | `node -v` |
| `just` *(opcional)* | — | `just --list` |

---

## Rodando localmente

<!-- PENDENTE-FATIA-0: preencher quando a fatia 0 (esqueleto ambulante) subir.
     Não escrever comandos antes de executá-los — ver docs/discovery/10-story-map.md -->

> ⚠️ **Esta seção ainda não está preenchida.** O código de aplicação não existe neste
> momento do projeto, e comandos de execução não são escritos antes de serem executados.
> Serão preenchidos assim que a primeira fatia vertical subir.

---

## Variáveis de ambiente

<!-- PENDENTE-FATIA-0 -->

> ⚠️ Preenchida junto com a seção acima.
>
> Nenhum valor real de credencial é commitado. O `.env.example` conterá apenas as chaves
> com valores fictícios.

---

## Estrutura do repositório

```
.
├── apps/
│   ├── api/            # Backend F# — API REST, JSON estrito     (fatia 0)
│   └── web/            # Frontend React + TypeScript, PWA        (fatia 0)
├── docs/
│   ├── discovery/      # O upstream do produto: pesquisa, hipóteses, escopo
│   ├── handbook/       # ADRs, RFCs, design docs, runbooks
│   ├── ai-log/         # Diário de Bordo da IA — episódios completos
│   └── pipeline/       # Tickets W0→W3
├── scripts/            # Automação (índices, conversões)
├── Justfile            # Todas as tarefas do repositório
└── README.md
```

---

## Aplicação em produção

| Ambiente | URL | Hospedagem |
|----------|-----|------------|
| Frontend | <!-- PENDENTE --> | |
| API | <!-- PENDENTE --> | |

*(Deploy é bônus no desafio.)*

---

## 🤖 Diário de Bordo da IA

Esta seção documenta como a IA generativa foi usada no desenvolvimento. O registro
completo — **7 episódios**, com os prompts brutos e os erros — está em
[`docs/ai-log/`](docs/ai-log/).

Cada episódio é rastreável no histórico do Git:

```bash
git log --grep="AI-Log" --oneline
```

### Ferramentas utilizadas

| Ferramenta | Onde foi usada | Por quê |
|------------|----------------|---------|
| **Claude Opus 5** (via Claude Code, no terminal) | Arquitetura, discovery do produto, auditoria de documentos, automação do repositório | Lê o repositório inteiro e executa comandos — o que permite **verificar** o que afirma, em vez de só sugerir |
| **Subagentes em WAR ROOM** (mesmo modelo, papéis distintos) | Decisões com caminhos concorrentes: escolha de stack, priorização de suposições | Um papel *cético* explicitamente encarregado de derrubar as conclusões dos outros — e as minhas |
| **MCP servers** (OWASP Security, Docker, referências de requisitos) | Consulta à documentação canônica durante decisões | Trechos citados da fonte, com linha e página, em vez de conhecimento de memória — que tem prazo de validade |

### Estratégia de engenharia de prompts

O padrão que funcionou: **explicar o critério, não pedir a solução.** Quando eu digo
*o que me incomoda* em vez de *o que quero*, a IA consegue derrubar propostas — inclusive
as minhas.

#### 1. Dizer o critério fez a IA derrubar a minha própria escolha

**Situação:** eu tinha acabado de propor TanStack Start para o frontend. Em vez de pedir
a configuração, expliquei o que me incomodava:

~~~
Sinceramente em questão do tanstack? é que, to sem paciencia para usar coisas que vão fazer "magica" como por exemplo o astro que vai abstrair tudo de mim e parecer LowCode sabe? quero que quando der problema eu saiba o que quebrou e não passar 500 horas debugando um browser que nem erro mostra...
~~~

**Resultado:** a IA aplicou o critério contra a proposta que eu mesmo tinha feito —
TanStack Start gera rotas em build, disfarça chamada de rede como função local e usa
hidratação, cujo erro é notoriamente ilegível. **Meu próprio critério apontava para
longe da minha escolha.** Virou SPA React + Vite.
· [EP-006](docs/ai-log/EP-006-tres-stacks-num-dia.md)

#### 2. Descrever a intuição, não a solução, corrigiu a arquitetura

**Situação:** eu queria SSR, e disse o motivo em vez de pedir a implementação:

~~~
é que eu quero o SSR, pois sinceramente queria fazer um login SIMPLES mas seguro... sem export JWT no cliente entende? nem que, façamos na mão que tbm não é TÃO complexo se usarmos uma tecnica de BFF sabe
~~~

**Resultado:** a IA foi ao OWASP pelo MCP em vez de responder de memória, e trouxe o
Session Management Cheat Sheet. **A intuição estava certa e o meio, errado:** `HttpOnly`
é propriedade do cookie, não do modo de renderização — uma SPA obtém a mesma garantia.
O SSR caiu, a segurança ficou. · [ADR-0003](docs/handbook/adr/ADR-0003-stack-fsharp-spa-e-sessao-por-cookie.md)

#### 3. Definir o método antes de deixar a ferramenta escolher um

**Situação:** com a stack decidida e zero código escrito, a saída natural seria começar
a programar. Em vez disso:

~~~
Então, primeira coisa que devemos fazer, sinceramente sinto que é toda a documentação? tudo bem? Leia os requesitos e vamos discultir elas... para isso vamos usar com toda a certeza o MCP-SERVER do acdg skills e o livro do LeanUX, vamos realizar todas as cerimonias e vamos criar esse produto primeiro ou seja, vamos primeiro fazer o UpStream do projeto, assim que tudo estiver definido ai sim começamos as esteiras de produção ok?
~~~

**Resultado:** oito cerimônias de Lean UX, um questionário aplicado a colegas reais, e o
enquadramento do problema decidido com evidência em vez de intuição. Sem esse prompt, a
sessão teria ido direto para arquitetura de pastas. · [EP-007](docs/ai-log/EP-007-a-citacao-pela-metade-e-a-geladeira.md)

### Reflexão crítica

**Dois erros, e o segundo é mais interessante que uma alucinação comum.**

#### O erro de código: um benchmark que media o caminho que funcionava

**O que a IA propôs:** durante a avaliação de uma stack candidata (Dart + Darto), um
subagente construiu uma prova de conceito, rodou um benchmark e reportou **"2062 req/s,
zero erros"** como validação de que a stack aguentava o projeto.

**Como eu percebi o erro:** pedi para outro papel — o cético — auditar. Ele foi ler o
código da probe e encontrou o que ninguém tinha verificado: **o `POST` retornava 500 em
todos os payloads testados.** A prova de conceito só fazia o **R** do CRUD. Os "2062
req/s" foram medidos contra **banco vazio**, serializando `{"data":[]}` — e os "zero
erros" existiam porque o único caminho que quebrava **não estava no benchmark**.

**Como eu corrigi o rumo:** o número estava certo; o que ele provava, não. A stack foi
descartada por outros motivos, mas o episódio mudou como eu leio relatório de IA — passei
a exigir que cada afirmação venha rotulada como **verificado / documentado / inferido**,
e que "verificado" traga a saída do comando junto.
· [EP-006](docs/ai-log/EP-006-tres-stacks-num-dia.md)

#### O erro que me preocupou mais: uma citação verdadeira, cortada no lugar conveniente

**O que a IA propôs:** durante a pesquisa com usuários, eu respondi uma pergunta assim:

> *"**Já sim, e já passei mais de uma vez**, porém tem algumas pequenas iniciativas que
> existem no campus que eu decidi NÃO usar por não confiar…"*

A IA publicou **apenas a segunda metade** no documento de síntese e concluiu que o
relato *"refuta diretamente a hipótese de que o problema é ausência ou dificuldade de
canal"*. Mas *"já passei mais de uma vez"* diz exatamente o contrário — é fricção
recorrente, e sustenta a hipótese que estava sendo descartada.

**Como eu percebi o erro:** não percebi lendo — o documento estava convincente. Apareceu
quando o papel cético foi conferir as citações **contra o arquivo bruto** e rodou
`grep "passei mais de uma vez" docs/`, que devolveu **vazio**.

**Como eu corrigi o rumo:** mandei restaurar a frase inteira e reabrir o enquadramento
que tinha sido descartado. Depois respondi a uma pergunta que ninguém tinha feito — o
que eram as tais "iniciativas do campus" — e a resposta (a geladeira) reorganizou o
discovery inteiro, refutando o mesmo enquadramento **pela razão certa**, com um caso real.

**O que isso mudou no meu uso da ferramenta:** eu esperava que erro de IA fosse
alucinação — uma API que não existe, uma versão errada. Esse tipo quebra no primeiro
teste. O que apareceu foi mais fino: **evidência real, recortada no ponto em que
apoiava a conclusão**, dentro de um documento que se apresentava como prova. Não dá para
pegar lendo, porque o texto fica *bom*. Só dá comparando com a fonte.

Duas regras saíram daí, e valem para o resto do projeto:

1. **Texto entre aspas tem que ser localizável por `grep` na fonte.** A IA também tinha
   "corrigido" a ortografia dentro das aspas — `dificil` → `difícil` —, o que quebrou a
   busca e fez **dois analistas independentes** concluírem que as citações não tinham
   fonte. Ortografia se corrige com `[sic]`, nunca dentro das aspas.
2. **O material bruto fica preservado e separado do material interpretado**, para que a
   auditoria seja sempre possível.

· [EP-007](docs/ai-log/EP-007-a-citacao-pela-metade-e-a-geladeira.md)

### Histórico de conversas

<!-- PENDENTE: link público da conversa, se houver -->

Os prompts brutos são capturados automaticamente por um hook `UserPromptSubmit` e ficam
fora do Git (contêm material não curado). Os episódios em
[`docs/ai-log/`](docs/ai-log/) trazem os prompts **copiados na íntegra, sem maquiar** —
inclusive erros de digitação.

---

## Autor

**Gabriel Vieira Soriano Aderaldo**
[GitHub](https://github.com/GabrielAderaldo)
