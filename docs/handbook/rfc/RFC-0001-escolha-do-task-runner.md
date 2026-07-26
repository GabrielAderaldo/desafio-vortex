# RFC-0001 — Escolha do task runner do projeto

- **Status:** Aceito
- **Autor:** Gabriel Vieira Soriano Aderaldo
- **Data:** 2026-07-26
- **Discussão:** —
- **Resultado:** [ADR-0001](../adr/ADR-0001-adotar-just-como-task-runner.md) — decisão travada em 2026-07-26

## Resumo

O projeto precisa de um ponto único de entrada para tarefas repetitivas — regenerar
o índice de ADRs, rodar testes, subir o ambiente, validar o CI. Esta RFC compara sete
candidatos com **medições reais executadas nesta máquina** e recomenda um.

## Motivação

Hoje as tarefas do repositório são invocadas na mão:

```bash
python3 scripts/adr-index.py
python3 scripts/adr-index.py --check
```

Três problemas concretos com isso:

1. **Não são descobríveis.** Quem clona o repositório não tem como saber que existem
   sem ler o `.claude/settings.json` ou vasculhar `scripts/`.
2. **Divergem do CI.** O comando que roda na máquina e o que roda no pipeline são
   escritos duas vezes, em lugares diferentes, e saem de sincronia em silêncio.
3. **Vão se multiplicar.** Com backend, frontend e PWA, a lista cresce para migrations,
   seeds, build do Service Worker, testes por pacote. Sem um índice, viram folclore.

Custo de não fazer nada: o avaliador do desafio clona o projeto e não sabe por onde
começar. Num desafio técnico, isso é perda direta.

## Explicação didática

Um *task runner* é um índice executável de comandos do projeto. Em vez de decorar

```bash
python3 scripts/adr-index.py --check
```

você roda `just adr-check`, e `just --list` mostra tudo que existe com a descrição
de cada item. É o `npm run` genérico — sem estar preso ao ecossistema Node.

A diferença para o `make`: o `make` foi feito para **compilar C**, e trata toda tarefa
como se fosse um arquivo a ser gerado a partir de outro. Rodar comandos é um uso lateral
que ele tolera. Daí vêm as armadilhas conhecidas — exigir TAB literal em vez de espaços,
`.PHONY` para toda tarefa que não gera arquivo, e nenhuma forma nativa de listar o que
existe.

## Explicação técnica

### Método de medição

Cada ferramenta recebeu a **mesma definição de três tarefas** (`hello`, `check`, e
`ci` dependendo de `check`), no formato nativo de cada uma. O overhead é a média de
20 execuções da tarefa trivial, com tudo já em cache — mede o custo fixo do runner,
não o do comando.

Ambiente: macOS 26.5.2, Apple M2 (arm64), 8 GB RAM.

### Resultados

| Ferramenta | Versão | Overhead | Config | Dependência extra |
|------------|--------|----------|--------|-------------------|
| **xc** | 0.9.0 | **4 ms** | `README.md` | binário Go (5 MB) |
| **deno task** | 2.9.3 | **8 ms** | `deno.json` | **nenhuma** (se o projeto usar Deno) |
| **just** | 1.57.0 | **10 ms** | `Justfile` | binário Rust (5,5 MB) |
| **Task** | 3.52.0 | 20 ms | `Taskfile.yml` | binário Go (49 MB) |
| **dax** | 0.42.0 | 56 ms | `.ts` | lib JSR (baixa da rede na 1ª vez) |
| **moon** | 2.4.5 | 121 ms | `.moon/` + `moon.yml` | binário Rust (44 MB) |
| **cargo-make** | 0.37.24 | 169 ms | `Makefile.toml` | Rust/cargo (17 MB) |

### Recursos verificados

| | Autodoc | Deps entre tarefas | Cache/fingerprint | Argumentos |
|---|---|---|---|---|
| **just** | ✅ melhor da lista — o comentário vira a descrição | ✅ | ❌ | ✅ posicionais |
| **deno task** | ⚠️ lista, mas mostra o comando, não uma descrição | ✅ via `&&` | ❌ | ✅ |
| **Task** | ✅ campo `desc:` | ✅ `deps:` (paralelo) | ✅ **confirmado** | ✅ |
| **xc** | ⚠️ o README **é** a doc, mas o `--list` exige TTY | ✅ `requires:` | ❌ | ✅ |
| **moon** | ✅ | ✅ | ✅ avançado | ✅ |
| **cargo-make** | ✅ | ✅ | parcial | ✅ |
| **dax** | n/a — é código, não config | n/a | ❌ | n/a |

Saída real do `just --list`:

```
Available recipes:
    check # Verifica algo
    ci    # Roda check antes
    hello # Diz olá
```

O *fingerprinting* do **Task** foi confirmado funcionando:

```
1ª execução:  COMPILANDO (caro)
2ª execução:  task: Task "build" is up to date     ← pulou
3ª execução:  COMPILANDO (caro)                    ← após alterar a entrada
```

### Observações de campo

- **cargo-make e moon** são 12× a 17× mais lentos que o `just`. Ambos resolvem
  problemas de monorepo grande (cache distribuído, grafo de projetos) que este projeto
  não tem.
- **moon** exige `moon init` + `.moon/workspace.yml` + escopo de projeto configurado
  antes de rodar qualquer coisa. Falhou com `No default project has been configured`
  na primeira tentativa.
- **xc** é o mais rápido e a ideia é a mais elegante da lista, mas seu `--list`
  interativo falha sem TTY — o que o torna frágil em CI e em hooks.
- **dax** não é um runner: é uma biblioteca para escrever automação **em TypeScript**.
  Compete com o shell dentro do script, não com o `just`. Os 56 ms são o custo de subir
  o Deno e resolver a dependência.

### Compatibilidade com Docker e Compose

O projeto usará **obrigatoriamente Docker e Compose**. Ambiente verificado:

| | Instalado | Mais recente |
|---|---|---|
| Docker Engine | 29.4.0 (via OrbStack) | 29.6.2 |
| Docker Compose | **v5.1.2** | v5.3.1 (2026-07-07) |

Isso torna a compatibilidade com containers um critério de primeira ordem, não um
detalhe. Três dimensões foram testadas.

#### 1. Conflito de sintaxe com Go templates ⚠️ decisivo

Os comandos `docker ... --format` usam **Go templates**, com a sintaxe `{{.Campo}}`.
Runners que também usam `{{ }}` para interpolação entram em colisão direta.

Teste com `docker compose ps --format "table {{.Name}}\t{{.Status}}"`:

| Runner | Resultado |
|--------|-----------|
| **deno task** | ✅ **passa literal, funciona de primeira** — não tem sintaxe de template |
| **just** | ⚠️ colide, mas **o erro é visível** (sai `NAME}}`) e há escape documentado |
| **Task** | 🚨 **falha em silêncio** — engoliu `{{.Name}}` e executou `--format "table \t"` |

O comportamento do **Task é o mais perigoso**: nenhum erro, nenhum aviso, e o comando
roda com o formato vazio. Um pipeline construído sobre isso quebra sem sintoma.

No `just`, o escape é dobrar **apenas a abertura** — `{{{{.Name}}`, não `{{{{.Name}}}}`:

```just
# ✅ correto
ps:
    @docker compose ps --format "table {{{{.Name}}\t{{{{.Status}}"
```

#### 2. Disponibilidade dentro das imagens base

| Imagem | `just` | `go-task` | `deno` | `xc` / `moon` |
|--------|--------|-----------|--------|---------------|
| **Alpine 3** (`apk`) | ✅ 1.48.1 | ✅ 3.51.1 | ✅ 2.7.4 | ❌ |
| **Debian bookworm** (`apt`) | ❌ ausente | ❌ | ❌ | ❌ |

Ressalva importante: isso pesa **pouco** no uso pretendido. O runner roda no **host**,
orquestrando `docker compose` de fora — não precisa estar dentro da imagem. Só passa a
importar se o CI executar dentro de um container Debian, e nesse caso a instalação é
um binário baixado, não uma compilação.

#### 3. Orquestração real do Compose

Cenário testado de ponta a ponta: `postgres:18-alpine` com healthcheck +
`node:24-alpine` com `depends_on: service_healthy`.

```just
up:
    docker compose up -d --wait
run +cmd:
    docker compose run --rm api {{cmd}}
```

Resultados: `just up` subiu os dois serviços aguardando os healthchecks (17,3 s, com
pull das imagens). `just run node --version` executou dentro do container e retornou
`v24.18.0`. Argumentos variádicos funcionam; comandos com parênteses exigem `sh -c`,
como em qualquer shell.

### Compatibilidade com o Claude Code

Ambiente verificado: **VS Code 1.130.0** com a extensão `anthropic.claude-code`,
**sem Copilot** — e sem intenção de adotá-lo. O VS Code é interface e agregador de
harness; o agente é o Claude Code.

#### O que importa não é a extensão do editor

A intuição inicial — "preciso de uma extensão do `just` para o agente usá-lo" — está
errada. O Claude Code **não invoca task providers do VS Code**: ele roda comandos pela
ferramenta `Bash`. Extensões de editor servem ao humano (realce de sintaxe), não ao
agente.

O que governa é o sistema de permissões do próprio Claude Code, em
`.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["Bash(just *)"],
    "deny": ["Bash(just deploy*)"]
  }
}
```

A avaliação é **`deny` → `ask` → `allow`, e o primeiro match vence**. Um `deny` bloqueia
mesmo que um `allow` mais amplo casasse, e **`deny` não admite exceções** — é isso que
torna seguro ter uma allowlist generosa: a denylist é a fronteira real.

#### Por que isso favorece um task runner

Sem runner, autorizar o agente exige liberar `Bash(docker *)`, `Bash(pnpm *)`,
`Bash(python3 *)` — cada um com superfície ampla e argumentos arbitrários. Com runner,
a allowlist vira **uma única regra de prefixo**, e o que esse prefixo pode executar está
escrito num arquivo versionado e revisável em code review.

O `Justfile` funciona como **contrato de capacidades** do agente: ampliar o que ele pode
fazer passa a ser um commit revisável, não uma configuração local invisível.

Isso também atende diretamente à primeira recomendação da documentação oficial —
*"dê ao Claude uma forma de verificar o próprio trabalho"*. Uma receita `just check` que
encadeia lint, testes e `adr-check` é exatamente o portão de verificação que a Anthropic
recomenda: o agente roda, lê o resultado e itera sem depender de alguém revisando.

Some-se que `just --list` é autodescritivo: o agente descobre as tarefas com suas
descrições num comando, sem ler `package.json`, `compose.yaml` e `scripts/` para inferir
o que existe — economia direta de contexto, que a documentação identifica como o
**recurso mais escasso** de uma sessão.

#### Limitações registradas

- **A extensão do `just` para VS Code está abandonada.** `mkhl/vscode-just` é a única
  com *TaskProvider*, mas está na **v0.0.3, último commit em maio de 2024**. As demais
  (`nefrob.vscode-just-syntax`, `sclu1034.justfile`) fazem apenas realce de sintaxe.
  Impacto: baixo — afeta conforto de edição, não a operação do agente.
- **`Bash(just *)` autoriza qualquer receita do arquivo.** Se uma receita destrutiva for
  adicionada depois, ela entra na allowlist sem novo consentimento. Mitigação: um `deny`
  explícito para receitas perigosas, já que `deny` vence `allow` sempre.

## Desvantagens

Adotar qualquer runner tem custo real:

- **Mais uma coisa para instalar.** Exceto `deno task`, todos exigem um binário que o
  avaliador do desafio pode não ter. Mitigação: o `Justfile` é legível — mesmo sem o
  `just` instalado, dá para ler e copiar o comando.
- **Mais um arquivo na raiz.** Um repositório com `Justfile`, `deno.json`,
  `package.json`, `docker-compose.yml` e `README.md` já começa denso.
- **Risco de indireção.** `just build` que chama `pnpm build` que chama `vite build`
  é uma camada a mais para depurar quando quebra.
- **Abandono.** `just` e `xc` são mantidos por poucas pessoas. `deno task` só morre
  se o Deno morrer.

## Alternativas e justificativa

### Não fazer nada

Continuar invocando `python3 scripts/adr-index.py` na mão. É a opção de menor custo
imediato, e legítima enquanto houver duas tarefas. Perde valor rápido: o projeto terá
backend, frontend e PWA, e nenhum lugar dirá quais comandos existem.

### `package.json` → `scripts`

O caminho de menor atrito **se** a aplicação for Node. Mas amarra as tarefas do
repositório ao gerenciador de pacotes de um dos pacotes do monorepo, e a raiz de um
monorepo com `scripts` que chamam pacotes filhos vira sopa rapidamente.

### Por que não `deno task`, que tem zero dependência

É a opção mais tentadora, e seria a escolha se a aplicação fosse em Deno. O problema é
de **ordem**: o runtime da aplicação ainda não foi decidido — falta o enunciado do
desafio. Adotar `deno task` agora significa colocar um `deno.json` na raiz de um projeto
que provavelmente será Node + pnpm, só para rodar tarefas. Isso confunde quem lê.

O `just` é **ortogonal ao runtime**: funciona igual chamando `pnpm`, `deno`, `bun`,
`python3` ou `docker`. Escolhê-lo agora não pré-compromete a decisão que ainda não
temos informação para tomar.

### Por que não `Task`, que tem cache — e por que ele foi desqualificado

O *fingerprinting* é real e foi confirmado funcionando. Mas ele paga por si em builds
caros, e neste projeto o que se repete são comandos de milissegundos. YAML também é
mais verboso que a sintaxe do `just`, e o binário é 9× maior.

O que o **desqualifica**, porém, não é nada disso: é **falhar em silêncio com Go
templates**. Num projeto que usa Docker obrigatoriamente, `docker ... --format
"{{.Campo}}"` é comando de rotina, e o Task apaga a expressão sem emitir erro. O
comando roda, o pipeline segue verde, e a saída está vazia.

Uma ferramenta que erra ruidosamente é preferível a uma que erra em silêncio. O `just`
colide com a mesma sintaxe, mas o estrago aparece na cara de quem rodou.

### Por que não `xc`, que é lindo conceitualmente

Documentação executável casa perfeitamente com o espírito do handbook, e ele foi o mais
rápido dos sete. Dois problemas: o `--list` depende de TTY (frágil em CI), e misturar
automação com o `README.md` — que num desafio técnico é a **vitrine** do projeto —
prejudica os dois. O README deve convencer um avaliador; um `Justfile` não precisa.

## Precedentes

- **`just`** é usado por projetos Rust de porte (incluindo partes da toolchain do
  próprio Rust) exatamente por ser um `make` sem a semântica de build.
- **`Task`** tem adoção forte no ecossistema Go e em pipelines de infraestrutura, onde
  o cache compensa.
- **`moon`** foi desenhado para monorepos grandes, com cache distribuído — a Google
  resolve o mesmo problema com Bazel. É a categoria certa para o problema errado aqui.
- **`deno task`** segue a linha do próprio Deno de embutir a toolchain (`fmt`, `lint`,
  `test`, `check`) em vez de terceirizar.

## Recomendação

**Adotar `just`.**

Os quatro motivos, em ordem de peso:

1. **Não pré-compromete o runtime.** É a única escolha que não força uma decisão sobre
   Node/Deno/Bun antes de termos o enunciado. Orquestra `docker compose` igual, seja
   qual for a linguagem que rodar dentro dos containers.
2. **Melhor autodocumentação da lista.** O comentário acima da tarefa *é* a descrição
   no `--list`. Nenhuma duplicação, nenhum campo `desc:` para esquecer de preencher.
3. **Legível sem estar instalado.** Um avaliador sem `just` lê o `Justfile` e entende
   os comandos. Um `Taskfile.yml` com `deps` e templates, nem tanto.
4. **Overhead irrelevante** (10 ms) e binário de 5,5 MB.
5. **Vira contrato de capacidades para o Claude Code.** Uma única regra
   `Bash(just *)` substitui liberar `docker`, `pnpm`, `python3` e `deno` separadamente,
   e o que o agente pode executar fica num arquivo versionado e revisável. Uma receita
   `just check` também serve como o **portão de verificação** que a documentação oficial
   da Anthropic aponta como a prática de maior impacto.

**Custo aceito conscientemente:** a colisão de `{{ }}` com Go templates do Docker.
É contornável (`{{{{.Name}}`), o erro é visível quando esquecido, e afeta só os
comandos com `--format` — não `up`, `down`, `run`, `exec` ou `logs`. Registrar esse
escape no próprio `Justfile`, como comentário no topo, elimina a pegadinha.

Segunda opção: **`deno task`**, caso o enunciado leve a aplicação para Deno. Ele foi o
**único a lidar com Go templates sem conflito algum**, e tem dependência zero. Se a
decisão de runtime cair para Deno, esta RFC deve ser revisitada — o argumento nº 1
deixa de valer e ele passa à frente.

Descartados: **`Task`** (falha em silêncio com Go templates — ver acima), `moon` e
`cargo-make` (lentos e desenhados para outro porte de problema), `xc` (frágil sem TTY
e polui o README), `dax` (resolve outro problema — é biblioteca de automação, não
runner; pode ser adotado *dentro* de um script sem conflito).

## Questões em aberto

- **Runtime da aplicação.** Depende do enunciado. Se for Deno, revisitar `deno task`.
- **Fronteira do `just`.** Ele orquestra as tarefas do repositório ou também as de cada
  pacote do monorepo? Proposta: só a raiz; cada pacote mantém seus próprios scripts, e
  o `Justfile` delega.
- **CI.** Instalar o `just` no runner ou chamar os comandos direto? Instalar mantém
  local e CI idênticos, ao custo de um passo no workflow. Se o CI rodar dentro de um
  container **Debian**, o `just` não está no `apt` e precisa ser baixado como binário;
  em **Alpine**, `apk add just` resolve.
- **Imagem base dos serviços.** Alpine tem os runners no repositório e imagens menores;
  Debian tem melhor compatibilidade com binários nativos de npm. Decisão separada, mas
  que interage com esta.

## Possibilidades futuras

- Se o build ficar lento, migrar para `Task` pelo *fingerprinting* — as tarefas
  transferem quase sem alteração.
- Se o monorepo crescer muito além do previsto, `moon` volta à mesa.
- `dax` pode ser adotado independentemente desta decisão, para escrever os scripts de
  automação em TypeScript em vez de shell.
