# Memória — WAR ROOM técnico

- [Hooks falham abertos](hooks-falham-abertos.md) — sem `jq` ou com JSON quebrado, o adr-guard deixa passar em silêncio. Verificado.
- [Latência de runtimes no M2](latencia-runtimes-m2.md) — Deno (15 ms) bate bash+jq (35 ms); `node`/`bun` somem em PATH limpo.
- [just despacha para sh](just-despacha-para-sh.md) — toda receita passa por `sh -cu`; política "sem shell" contradiz o ADR-0001.
- [Stack Darto verificada](stack-darto-verificada.md) — probe real passou (CRUD/SSR/HTMX/Docker); armadilhas: libsqlite3.so, docs do dartonic dessincronizadas.
- [bun build não faz typecheck](bun-build-nao-typecheck.md) — passou verde com 2 erros de tipo; exige `tsc --noEmit` separado.
- [HTMX grava history no localStorage](htmx-history-localstorage.md) — dados do usuário vazam pro localStorage; `Cache-Control` não protege.
- [Edital não pede contato nem status](edital-nao-pede-contato-nem-status.md) — grep verificado: canal de contato e loop de confirmação são escopo auto-imposto; sem `update` nos endpoints.
- [Discovery bruto vive no ai-log](discovery-bruto-vive-no-ai-log.md) — P04 não está no arquivo de respostas; está em `.ai-log/raw-prompts.md:740-758`, gitignorado.
