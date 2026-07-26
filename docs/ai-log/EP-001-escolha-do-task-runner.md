# EP-001 — Escolher um task runner sem ter dado para decidir

**Data:** 2026-07-26
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code
**Commits relacionados:** `fb68418`

## Contexto

O repositório já tinha tarefas invocadas na mão e ia ganhar muitas outras. Eu tinha
uma lista de sete candidatos a task runner (`just`, `deno task`, `dax`, `Task`, `xc`,
`moon`, `cargo-make`) e nenhum critério objetivo para escolher — só a descrição que
cada projeto faz de si mesmo.

## O prompt

~~~
Pronto faça aqui dentro do propio projeto, ai nosso docs vai ser usado pela primeira vez...
Vamos criar um "spike" e SUPER documentado para decidir, qual dessas tecnologias vamos
usar: [lista das 7 ferramentas com descrições copiadas de fontes diversas]
~~~

## O que a IA respondeu

Em vez de comparar as descrições, instalou as sete e rodou a **mesma definição de três
tarefas** em cada formato, medindo 20 execuções:

```
xc 4ms · deno task 8ms · just 10ms · Task 20ms · dax 56ms · moon 121ms · cargo-make 169ms
```

Depois testou cada uma contra o requisito real do projeto — Docker obrigatório.

## Onde quebrou

**Não foi a resposta que quebrou, foram três suposições minhas e da IA:**

1. **O `moon` falhou na primeira execução** — `No default project has been configured`.
   A documentação não menciona que exige `moon init` + `workspace.yml` + escopo antes
   de rodar qualquer coisa.
2. **O `xc` precisa de TTY** para o `--list`. Funciona no terminal, quebra em CI e hook.
3. **O mais grave: o `Task` falha em silêncio com Go templates.** Ao rodar
   `docker compose ps --format "table {{.Name}}\t{{.Status}}"`, ele engoliu a expressão
   e executou `--format "table \t"` — sem erro, sem aviso, saída vazia. O `just` colide
   com a mesma sintaxe, mas erra de forma visível (`NAME}}`).

A IA também errou o escape do `just` na primeira tentativa: escreveu `{{{{.Name}}}}`
quando o correto é dobrar **apenas a abertura**, `{{{{.Name}}`.

## Como eu conduzi até a solução

Forcei o teste contra o requisito real em vez de aceitar o benchmark isolado:

~~~
Quero que você aproveite e veja a compatibilidade dele com containers ok? Por que tenha
em MENTE vamos OBRIGATORIAMENTE usar docker e docker-compose
~~~

Foi esse recorte que revelou a falha silenciosa do `Task` — que o benchmark de velocidade
jamais mostraria, e que teria virado bug de pipeline semanas depois.

A decisão final não seguiu o mais rápido nem o mais completo. Seguiu um critério de
**ordem**: o runtime da aplicação ainda não está decidido, e o `just` é o único
candidato ortogonal a essa escolha. O `deno task` — tecnicamente superior com Docker,
único sem colisão de sintaxe — ficou registrado no ADR com o gatilho explícito para
revisitar.

## O que ficou

Ferramenta que **erra alto** vale mais que ferramenta que **erra calada**. O `Task` é
mais rápido que o `moon`, tem cache real e sintaxe mais familiar — e mesmo assim foi
desqualificado, porque apagar uma expressão sem emitir erro transforma um pipeline verde
em mentira.

E benchmark sozinho não decide nada: os 4 ms de diferença entre o primeiro e o terceiro
colocado foram irrelevantes perto de um único teste feito contra a restrição real do
projeto.
