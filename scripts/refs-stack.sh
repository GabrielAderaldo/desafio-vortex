#!/usr/bin/env bash
# Baixa a documentação das tecnologias candidatas do projeto para consulta offline.
#
# Nem toda fonte publica llms.txt. Quando não há, buscamos o Markdown de origem no
# repositório de documentação — que é a fonte real do site, sem a camada de HTML.
#
# Tudo vai para docs/handbook/offline-reference/stack/, que é gitignorada.

set -uo pipefail

BASE="docs/handbook/offline-reference/stack"
HOJE="$(date +%F)"
falhas=0

baixar() { # destino-relativo, url
  local dest="$BASE/$1" url="$2"
  mkdir -p "$(dirname "$dest")"
  if curl -sfL --max-time 60 "$url" -o "$dest"; then
    printf "  ✅ %-42s %6s\n" "$1" "$(du -h "$dest" | cut -f1)"
  else
    printf "  ⚠️  %-42s FALHOU\n" "$1"
    rm -f "$dest"; falhas=$((falhas + 1))
  fi
}

# Clona só um subdiretório de um repo grande, sem baixar blobs desnecessários.
sparse() { # destino-relativo, repo-url, caminho-no-repo
  local dest="$BASE/$1" repo="$2" caminho="$3"
  local tmp; tmp="$(mktemp -d)"
  if git clone --depth 1 --filter=blob:none --sparse "$repo" "$tmp/r" --quiet 2>/dev/null \
     && git -C "$tmp/r" sparse-checkout set "$caminho" --quiet 2>/dev/null \
     && [ -d "$tmp/r/$caminho" ]; then
    rm -rf "$dest"; mkdir -p "$(dirname "$dest")"
    cp -R "$tmp/r/$caminho" "$dest"
    printf "  ✅ %-42s %6s (%s arquivos)\n" "$1" \
      "$(du -sh "$dest" | cut -f1)" "$(find "$dest" -type f | wc -l | tr -d ' ')"
  else
    printf "  ⚠️  %-42s FALHOU\n" "$1"; falhas=$((falhas + 1))
  fi
  rm -rf "$tmp"
}

echo "→ Backend — Dart e Darto"
baixar "darto/README.md"            "https://raw.githubusercontent.com/evandersondev/darto/main/README.md"
baixar "darto/dartonic.md"          "https://raw.githubusercontent.com/evandersondev/dartonic/main/README.md"

echo "→ Contrato — OpenAPI"
baixar "openapi/spec-3.1.1.md"      "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/versions/3.1.1.md"

echo "→ Frontend — hipermídia e reatividade leve"
HTMX_RAW="https://raw.githubusercontent.com/bigskysoftware/htmx/master/www/content"
baixar "htmx/docs.md"               "$HTMX_RAW/docs.md"
baixar "htmx/reference.md"          "$HTMX_RAW/reference.md"
baixar "htmx/api.md"                "$HTMX_RAW/api.md"
baixar "htmx/events.md"             "$HTMX_RAW/events.md"
baixar "alpine/_llms.txt"           "https://alpinejs.dev/llms.txt"
# O sparse clone falha aqui também; os arquivos individuais resolvem.
TURBO_RAW="https://raw.githubusercontent.com/hotwired/turbo-site/main/_source/handbook"
for cap in 01_introduction 02_drive 03_page_refreshes 04_frames 05_streams \
           06_native_adapters 07_building 08_making_transformations; do
  baixar "turbo/${cap}.md" "$TURBO_RAW/${cap}.md"
done

# O sparse clone do mdn/content falha — o repositório é grande demais e o cone mode
# não resolve estes caminhos. Os arquivos individuais funcionam via raw, então é
# assim que buscamos. Caminhos conferidos em 2026-07-27; um 404 aqui significa que a
# página mudou de lugar no MDN.
echo "→ PWA — Service Worker, manifest e offline (MDN)"
MDN_RAW="https://raw.githubusercontent.com/mdn/content/main/files/en-us"
baixar "mdn/service-worker-api.md"      "$MDN_RAW/web/api/service_worker_api/index.md"
baixar "mdn/service-worker-global-scope.md" "$MDN_RAW/web/api/serviceworkerglobalscope/index.md"
baixar "mdn/cache-api.md"               "$MDN_RAW/web/api/cache/index.md"
baixar "mdn/progressive-web-apps.md"    "$MDN_RAW/web/progressive_web_apps/index.md"
baixar "mdn/pwa-caching.md"             "$MDN_RAW/web/progressive_web_apps/guides/caching/index.md"
baixar "mdn/view-transition-api.md"     "$MDN_RAW/web/api/view_transition_api/index.md"

echo "→ Build e runtime"
baixar "bun/_llms.txt"              "https://bun.com/docs/llms.txt"

echo "→ Infra"
baixar "docker/_llms.txt"           "https://docs.docker.com/llms.txt"

cat > "$BASE/FONTE.md" <<EOF
# Fonte — documentação da stack candidata

Baixado em **$HOJE** por \`just refs-stack\`.

| Tecnologia | Origem | Formato |
|-----------|--------|---------|
| Darto / Dartonic | github.com/evandersondev | README do repositório |
| OpenAPI 3.1.1 | github.com/OAI/OpenAPI-Specification | especificação normativa |
| HTMX | github.com/bigskysoftware/htmx | fonte markdown do site |
| Alpine.js | alpinejs.dev/llms.txt | índice llms.txt |
| Turbo (Hotwire) | github.com/hotwired/turbo-site | handbook |
| Service Worker · PWA · View Transitions | github.com/mdn/content | páginas MDN em markdown |
| Bun | bun.com/docs/llms.txt | índice llms.txt |
| Docker | docs.docker.com/llms.txt | índice llms.txt |

## O que NÃO está aqui, e por quê

- **Caddy, Traefik, Envoy, Pingora** — já disponíveis pelo MCP \`reverse-proxy\`.
- **OWASP** (cheat sheets, MASTG, CI/CD Top 10, OAuth BCP, Docker Bench) — MCP \`security\`.
- **Docker completo** — o MCP \`docker-docs\` tem a documentação inteira; aqui fica só o índice.
- **Dart core** — sem llms.txt e sem repositório de docs em markdown navegável. A referência
  da linguagem está em dart.dev, online. O MCP \`dart\` cobre pacotes e análise.

## Aviso

Documentação de terceiros, cada uma sob sua própria licença. Está aqui só para consulta
local; a pasta é gitignorada e nada disto é redistribuído.

**Registre a versão ao usar.** Estes arquivos vêm do \`main\` dos repositórios e envelhecem
em silêncio.
EOF

echo
echo "total: $(du -sh "$BASE" | cut -f1) · $(find "$BASE" -type f | wc -l | tr -d ' ') arquivos"
[ "$falhas" -gt 0 ] && echo "⚠️  $falhas fonte(s) falharam"
exit 0
