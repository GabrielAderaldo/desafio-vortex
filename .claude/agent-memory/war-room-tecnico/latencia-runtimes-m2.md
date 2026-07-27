---
name: latencia-runtimes-m2
description: Medições de startup neste M2/8GB — Deno é MAIS RÁPIDO que bash+jq; node e bun não existem em PATH limpo
metadata:
  type: project
---

Medido em 2026-07-26, M2 8 GB, média de 30 execuções após warmup, lendo JSON do stdin:

| Runtime | ms/exec |
|---|---:|
| perl (redact-secrets.pl real) | 6.9 |
| **deno 2.9.3** | **14.3** |
| bash + 2 forks de jq | 16.3 |
| bun 1.3.14 | 19.3 |
| python3 3.14 (homebrew) | 19.7 |
| node 24 / python3 do sistema | 30.3 |

Scripts reais: `adr-guard.sh` **35.4 ms** vs porte equivalente em Deno **15.0 ms** (2.4× mais
rápido — o bash forka `jq` 4× e `awk` 2×). `statusline.sh` 30.0 ms. `adr-index.py --check` 26 ms.

**Suposição derrubada:** "shell é mais leve que um runtime". Falso aqui — o custo do
bash não é o interpretador, são os forks de subprocesso.

Armadilhas de ambiente verificadas:
- `node` e `bun` **não existem** em PATH limpo. `node` só resolve via symlink
  per-sessão do fnm (`~/.local/state/fnm_multishells/<pid>_<ts>`). `deno` (2.7.8 no
  brew), `python3` e `jq` estão em paths estáveis do sistema.
- Há **dois Denos**: 2.9.3 em `~/.deno/bin` (vence no PATH) e 2.7.8 em `/opt/homebrew/bin`.
- `deno run` **não faz typecheck** — tipos são documentação até rodar `deno check` (8 ms cacheado).
- `deno run` sem permissão e sem TTY **falha rápido** (exit 1), não trava.
- `#!/usr/bin/env -S deno run --allow-read` funciona no macOS.
- `/usr/bin/env bash` resolve o bash 5.3 do brew; `/bin/bash` é 3.2.57. Os scripts atuais
  rodam nos dois (e até em `sh`).

**How to apply:** não usar latência como argumento pró-bash. Se um hook precisar de
runtime, Deno é o de menor atrito (path estável, zero deps, offline com
`--cached-only --no-remote`). Evitar `node`/`bun` em shebang de hook — path instável.
Ver [[hooks-falham-abertos]] e [[just-despacha-para-sh]].
