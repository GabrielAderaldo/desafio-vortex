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

# Baixa a documentação do ecossistema Claude (Code, API e Design) para consulta offline
refs-claude:
    #!/usr/bin/env bash
    set -euo pipefail
    b="docs/handbook/offline-reference"
    hoje="$(date +%F)"

    echo "→ Claude Code…"
    mkdir -p "$b/claude-code"
    curl -sSL --max-time 60  https://code.claude.com/docs/llms.txt      -o "$b/claude-code/_index.txt"
    curl -sSL --max-time 240 https://code.claude.com/docs/llms-full.txt -o "$b/claude-code/_full.txt"

    echo "→ Claude API…"
    mkdir -p "$b/claude-api"
    curl -sSL --max-time 60  https://docs.claude.com/llms.txt      -o "$b/claude-api/_index.txt"
    curl -sSL --max-time 600 https://docs.claude.com/llms-full.txt -o "$b/claude-api/_full.txt"

    # Claude Design não tem llms.txt — os artigos são baixados um a um, por ID.
    # Se um novo artigo surgir, ninguém é notificado: acrescente à lista na mão.
    echo "→ Claude Design (sem índice — lista manual)…"
    mkdir -p "$b/claude-design"
    for a in 14604416-get-started-with-claude-design \
             14604397-set-up-your-design-system-in-claude-design \
             14604406-claude-design-admin-guide-for-team-and-enterprise-plans ; do
      out="$b/claude-design/${a#*-}.md"
      if curl -sfL --max-time 30 "https://support.claude.com/en/articles/$a.md" -o "$out"; then
        echo "  ✅ ${a#*-}"
      else
        echo "  ⚠️  ${a#*-} indisponível — artigo pode ter mudado de slug"; rm -f "$out"
      fi
    done

    for d in claude-code claude-api claude-design; do
      printf "%-14s %s\n" "$d" "$(du -sh "$b/$d" | cut -f1)"
    done
    echo "⚠️  Os FONTE.md não são regerados por esta receita — revise as datas neles."

# Baixa TODA a documentação offline (VS Code + Claude)
refs: refs-vscode refs-claude

# Testa os hooks contra os casos que já quebraram (ver docs/ai-log/EP-004)
test-hooks:
    @python3 scripts/test-hooks.py

# Salva o .ai-log fora do repositório (gitignored, sem backup seria cópia única)
log-backup:
    #!/usr/bin/env bash
    # O .ai-log é matéria-prima do Diário de Bordo, que é entregável — e é
    # gitignored, então o Git não o protege. Guarda as 10 versões mais recentes.
    set -euo pipefail
    origem=".ai-log/raw-prompts.md"
    [ -f "$origem" ] || { echo "nada a salvar: $origem não existe"; exit 0; }
    destino="${AI_LOG_BACKUP_DIR:-$HOME/.local/share/ai-log-backups}/desafio-vortex"
    mkdir -p "$destino"
    carimbo="$(date +%Y%m%d-%H%M%S)"
    cp "$origem" "$destino/raw-prompts-$carimbo.md"
    # Rotação: mantém as 10 mais recentes.
    ls -1t "$destino"/raw-prompts-*.md 2>/dev/null | tail -n +11 | while read -r velho; do
      rm -f "$velho"
    done
    echo "✅ $(du -h "$origem" | cut -f1) → $destino/raw-prompts-$carimbo.md"
    echo "   ($(ls -1 "$destino"/raw-prompts-*.md | wc -l | tr -d ' ') cópias guardadas)"

# Regenera docs/pipeline/INDEX.md e audita as invariantes W0→W3
pipeline-index:
    @python3 scripts/pipeline-index.py

# Falha se o índice da pipeline estiver desatualizado ou houver invariante violada
pipeline-check:
    @python3 scripts/pipeline-index.py --check

# Compila o edital em Typst para PDF
edital:
    @cd docs/vortex-propose-documentation/typst && typst compile edital.typ && echo "✅ edital.pdf"

# Portão de verificação — o que precisa passar antes de considerar o trabalho pronto
check: adr-check pipeline-check test-hooks
    @echo "✅ verificações passaram"

# Mesmas verificações que o CI roda, para não divergirem
ci: check
