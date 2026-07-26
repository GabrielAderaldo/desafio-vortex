---
id: ADR-0001
titulo: Adotar just como task runner do projeto
status: aceito
data: 2026-07-26
decisores: [Gabriel Aderaldo]
tags: [tooling, automacao, dx, agentes]
componentes: [repo, infra]
substitui: []
substituido_por: null
relacionados: [RFC-0001]
ai_log: []
---

# ADR-0001 — Adotar `just` como task runner do projeto

## Contexto

O repositório já tem tarefas repetitivas invocadas na mão (`python3 scripts/adr-index.py`)
e vai ganhar muitas outras: subir o ambiente, rodar migrations, testar cada pacote,
validar o CI. Nada indica ao recém-chegado que essas tarefas existem.

Três forças pesam neste momento:

1. **É um desafio técnico avaliado.** Alguém vai clonar o repositório e precisa
   descobrir como operá-lo sem ler o `.claude/settings.json`.
2. **Docker e Compose são obrigatórios** (Engine 29.4.0, Compose v5.1.2). O runner
   vai orquestrar `docker compose` o tempo todo.
3. **O runtime da aplicação ainda não foi decidido** — depende do enunciado do desafio,
   que ainda não está no repositório.

O harness é o Claude Code, operado pelo VS Code como interface. Não há Copilot e não
haverá.

A [RFC-0001](../rfc/RFC-0001-escolha-do-task-runner.md) comparou sete candidatos com
medições executadas nesta máquina.

## Decisão

Adotamos **`just`** como task runner único do repositório, com um `Justfile` na raiz.

## Consequências

### Positivas

- Um `just --list` autodocumentado passa a ser a porta de entrada do projeto, tanto
  para o avaliador quanto para o agente.
- A permissão do Claude Code se reduz a uma regra de prefixo, `Bash(just *)`, em vez de
  liberar `docker`, `pnpm` e `python3` separadamente. O `Justfile` vira **contrato de
  capacidades** versionado e revisável.
- A receita `just check` serve como portão de verificação — a prática de maior impacto
  segundo a documentação oficial do Claude Code.
- Local e CI passam a chamar exatamente os mesmos comandos, eliminando a divergência
  silenciosa entre os dois.
- Não pré-compromete o runtime: orquestra igual, seja Node, Deno ou Bun rodando dentro
  dos containers.

### Negativas

- **Colisão de sintaxe com Go templates.** `just` usa `{{ }}` para interpolação, e
  `docker ... --format "{{.Name}}"` também. O escape é dobrar **apenas a abertura**:
  `{{{{.Name}}`. Afeta só comandos com `--format`; `up`, `down`, `run`, `exec` e `logs`
  passam intactos.
- **Mais um binário para instalar.** Não está no `apt` do Debian (está no `apk` do
  Alpine). Se o CI rodar em container Debian, exige baixar o binário.
- **`Bash(just *)` autoriza qualquer receita do arquivo**, inclusive as adicionadas
  depois, sem novo consentimento. Mitigação: `deny` explícito para receitas destrutivas,
  já que `deny` vence `allow` sempre.
- Uma camada de indireção a mais ao depurar (`just up` → `docker compose up`).

### Neutras

- Novo arquivo na raiz (`Justfile`).
- O projeto passa a depender de uma ferramenta mantida por poucas pessoas. Mitigação:
  o `Justfile` é legível como texto — sem o `just` instalado, ainda dá para ler e
  executar os comandos na mão.

## Alternativas consideradas

| Alternativa | Por que não |
|-------------|-------------|
| **`deno task`** | Tecnicamente o melhor com Docker — único **sem colisão** com Go templates, e com dependência zero. Descartado porque exigiria um `deno.json` na raiz de um projeto cujo runtime ainda não foi decidido. **É a alternativa a revisitar se o enunciado levar a aplicação para Deno.** |
| **`Task` (go-task)** | **Desqualificado por falhar em silêncio**: engoliu `{{.Name}}` e executou `docker compose ps --format "table \t"` sem erro nenhum. Num projeto com Docker obrigatório, isso quebra pipelines sem sintoma. |
| **`xc`** | O mais rápido (4 ms) e conceitualmente o mais elegante, mas o `--list` exige TTY (frágil em CI e hooks) e mistura automação com o `README.md`, que num desafio é a vitrine. |
| **`moon`** | 121 ms de overhead e exige `moon init` + `workspace.yml` + escopo de projeto. Desenhado para monorepos grandes com cache distribuído — porte de problema diferente. |
| **`cargo-make`** | 169 ms, o mais lento dos sete. Sem ganho que compense. |
| **`make`** | Semântica de arquivo-alvo, exige TAB literal, sem `--list` nativo, sem argumentos nomeados. |
| **`scripts` do `package.json`** | Amarraria as tarefas do repositório ao gerenciador de pacotes de um dos pacotes do monorepo. |
| **Não adotar runner** | Legítimo com duas tarefas; insustentável com backend, frontend e PWA. |

## Implicações para o código

- **Passa a valer:** toda tarefa repetitiva do repositório vira receita no `Justfile`,
  com um comentário acima que serve de descrição no `--list`. O CI chama as mesmas
  receitas que o desenvolvedor chama localmente.
- **Deixa de valer:** documentar comandos soltos no `README.md` ou espalhá-los entre
  `package.json`, hooks e arquivos de CI.
- **Onde isso aparece:** `Justfile` (raiz), `.claude/settings.json` (regra
  `Bash(just *)`), e futuramente o workflow de CI.
- **Ao escrever receitas com `docker --format`:** dobrar a abertura das chaves —
  `{{{{.Name}}`. Há um lembrete no topo do `Justfile`.
