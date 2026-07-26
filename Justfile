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

# Baixa a documentação de agentes do VS Code para consulta offline (gitignorada)
refs-vscode:
    #!/usr/bin/env bash
    set -euo pipefail
    dest="docs/handbook/offline-reference/vscode-agents"
    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    echo "→ clonando vscode-docs (sparse, sem blobs)…"
    git clone --depth 1 --filter=blob:none --sparse \
      https://github.com/microsoft/vscode-docs.git "$tmp/repo" --quiet
    git -C "$tmp/repo" sparse-checkout set docs/agents docs/agent-customization docs/chat --quiet 2>/dev/null \
      || git -C "$tmp/repo" sparse-checkout set docs/agents docs/agent-customization docs/chat
    sha="$(git -C "$tmp/repo" rev-parse HEAD)"
    data="$(git -C "$tmp/repo" log -1 --format=%cd --date=short)"
    rm -rf "$dest"; mkdir -p "$dest"
    cp -R "$tmp/repo/docs/agents" "$tmp/repo/docs/agent-customization" "$tmp/repo/docs/chat" "$dest/"
    curl -sL --max-time 30 https://code.visualstudio.com/llms.txt -o "$dest/_llms-index.txt"
    # FONTE.md preserva a procedência — sem isso a doc envelhece em silêncio
    printf '# Fonte — Documentação de agentes do VS Code\n\n- Origem: https://github.com/microsoft/vscode-docs\n- Commit: `%s`\n- Data do commit: %s\n- Sincronizado por: `just refs-vscode`\n\nA maior parte da doc assume GitHub Copilot; este projeto usa Claude Code.\nAs seções de conceito valem em geral, mas as settings `github.copilot.*` não.\n' \
      "$sha" "$data" > "$dest/FONTE.md"
    echo "✅ $(find "$dest" -name '*.md' | wc -l | tr -d ' ') arquivos em $dest ($(du -sh "$dest" | cut -f1))"

# Portão de verificação — o que precisa passar antes de considerar o trabalho pronto
check: adr-check
    @echo "✅ verificações passaram"

# Mesmas verificações que o CI roda, para não divergirem
ci: check
