# Memória — WAR ROOM técnico

- [Hooks falham abertos](hooks-falham-abertos.md) — sem `jq` ou com JSON quebrado, o adr-guard deixa passar em silêncio. Verificado.
- [Latência de runtimes no M2](latencia-runtimes-m2.md) — Deno (15 ms) bate bash+jq (35 ms); `node`/`bun` somem em PATH limpo.
- [just despacha para sh](just-despacha-para-sh.md) — toda receita passa por `sh -cu`; política "sem shell" contradiz o ADR-0001.
