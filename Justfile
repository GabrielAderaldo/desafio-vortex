# Justfile — tarefas do repositório.  Rode `just` para ver todas.
#
# Decisão registrada em docs/handbook/adr/ADR-0001-adotar-just-como-task-runner.md
#
# ⚠️  ARMADILHA CONHECIDA — Go templates do Docker
# `just` usa {{ }} para interpolar, e `docker --format` também. Para escrever um
# template literal, dobre APENAS A ABERTURA:
#
#     ✅  docker compose ps --format "table {{{{.Name}}\t{{{{.Status}}"
#     ❌  docker compose ps --format "table {{{{.Name}}}}\t{{{{.Status}}}}"
#
# Afeta só comandos com --format. `up`, `down`, `run`, `exec` e `logs` passam intactos.

# Lista as tarefas disponíveis
default:
    @just --list

# Regenera docs/handbook/adr/INDEX.md a partir do front-matter dos ADRs
adr-index:
    @python3 scripts/adr-index.py

# Falha se o índice de ADRs estiver desatualizado
adr-check:
    @python3 scripts/adr-index.py --check

# Portão de verificação — o que precisa passar antes de considerar o trabalho pronto
check: adr-check
    @echo "✅ verificações passaram"

# Mesmas verificações que o CI roda, para não divergirem
ci: check
