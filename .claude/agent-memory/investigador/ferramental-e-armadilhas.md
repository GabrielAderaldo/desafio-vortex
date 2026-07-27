---
name: ferramental-e-armadilhas
description: Como medir e testar neste ambiente — o que não existe no macOS, como evitar viés de benchmark, como testar hooks de verdade sem sujar o projeto
metadata:
  type: reference
---

# Ferramental de investigação neste ambiente

## Não existe nesta máquina (erros que já cometi)

- **`timeout`** — não existe no macOS (é `gtimeout`, do coreutils, não instalado).
  `timeout 180 claude ...` retorna **rc=127** e o teste falha silenciosamente.
- **`hyperfine`** — não instalado. Usar harness em Python com `time.perf_counter()`.
- `date +%N` não funciona no `date` do BSD.

## Como medir sem viés

Medir com `t0=$(python3 -c ...)` em volta do comando **inclui o spawn do próprio
python3** e polui o resultado (mediu 43 ms para o Deno onde o valor real era 24 ms).
Medir **de dentro** de um único processo Python, com `subprocess.run`, e comparar só
valores relativos.

Rodadas sequenciais por implementação sofrem viés térmico — a 1ª rodada deu bash 13 ms
e a 2ª deu 25 ms para o mesmo comando. **Intercalar a ordem** (embaralhar as impls a
cada rodada) estabilizou tudo: desvio caiu para <1 ms.

Sempre incluir `/usr/bin/true` como baseline de fork/exec puro (~1.8 ms aqui) para
separar custo de runtime de custo de processo.

## Testar hook de verdade (sem tocar no projeto)

Receita que funcionou (Claude Code 2.1.220):

1. Projeto isolado no scratchpad com `.claude/settings.json` próprio.
2. `claude -p "<prompt>" --debug-file <path> --permission-mode acceptEdits`
3. O hook escreve num arquivo de prova (`prova.log`) **e** devolve JSON com um marcador
   único; conferir os dois — o arquivo prova que executou, o marcador prova que o
   Claude Code consumiu a saída.

`--debug hooks` **não** escreve em stderr de forma capturável com `2>`; usar
`--debug-file <path>`. `PermissionRequest` não dispara com `-p` (documentado); usar
`PreToolUse` para testar decisão de permissão.

## Ferramentas MCP não chegam a subagente (2026-07-27)

Rodando como subagente de war room, o toolset era só Read/Bash/Write/Edit/WebSearch/
WebFetch — **sem `ToolSearch`**, portanto sem `mcp__dart__*`, `mcp__docker-docs__*`,
`mcp__security__*`, `mcp__reverse-proxy__*`. Não adianta o orquestrador pedir "carregue
com ToolSearch". Substitutos que funcionaram igual ou melhor:

| Em vez de | Usar |
|---|---|
| `mcp__dart__pub_dev_search` | `curl -s https://pub.dev/api/packages/<p>` e `.../score` — devolve `grantedPoints`, `likeCount`, `downloadCount30Days` e tags como `is:discontinued` |
| `mcp__docker-docs__*` | `curl -s https://hub.docker.com/v2/repositories/library/<img>/tags` para tamanho por arquitetura |
| `mcp__security__*` | `raw.githubusercontent.com/OWASP/CheatSheetSeries/master/cheatsheets/<X>.md` via WebFetch |

## Medir tamanho de imagem Docker sem se enganar

`docker image inspect --format '{{.Size}}'` e `docker save | wc -c` dão valores
inconsistentes com manifest list (OrbStack/containerd). Os dois confiáveis:
- `docker images --tree` → colunas **Size** e **Content size** (o que trafega).
- `docker create` + `docker export | wc -c` → rootfs descompactado real.

## `dart pub get` com cache isolado

`~/.pub-cache` já tinha darto/dartonic (1,4 GB) — mediria cache quente sem avisar.
`export PUB_CACHE=<scratchpad>/pubcache-frio` isola de verdade e revela o custo real
de um clone limpo. Não esquecer de exportar em **toda** chamada Bash (o cwd e o env
resetam entre chamadas).

## Onde estão os artefatos

`scratchpad/bench-hooks/` — `bench2.py` (harness bom), `adr-guard.ts`, `adr_guard.py`
(ports validados), payloads dos 3 cenários. `scratchpad/projeto-teste-hook/` — projeto
de prova dos hooks não-shell.

## Doc offline

`docs/handbook/offline-reference/claude-code/_full.txt` (6.4 MB). Hooks reference
começa na **linha 65429**; tabela de campos de command hook em **65777**; exec/shell
form em **65787**; segurança em **68505**; limites/timeouts em **23005**.
