---
name: stack-darto-verificada
description: Prova de conceito Darto+Mustache+SQLite rodou end-to-end (CRUD, SSR, HTMX partial, Docker); ecossistema satélite tem <3 meses e docs dessincronizadas
metadata:
  type: project
---

Em 2026-07-27 subi um probe real do Darto 1.3.0 fora do repo e **tudo o que o
edital exige funcionou**: CRUD JSON, filtro por query, SSR Mustache, partial HTMX
no mesmo handler via header `HX-Request`, e content negotiation na mesma URL.
Container Debian slim = 163 MB, ~47 MB RAM sob carga, ~2000-2400 rps, 0 erros.
`dart compile exe` = 2,3 s / binário 6,3 MB.

**Why:** a dúvida do war room era se um framework de 21 likes / 1960 downloads
aguentaria o desafio de 15 dias. Aguenta — o gargalo não é o Darto.

**How to apply:** não repetir a investigação de viabilidade básica. O risco
mudou de lugar; ele está nos itens abaixo, não no core.

## Armadilhas confirmadas por teste (não repetir a descoberta)

- **`c.render()` do core NÃO é template engine** — recebe HTML pronto e aplica um
  layout em Dart. Mustache vem de `darto_view` (pacote separado, publicado
  2026-05-24, 52 downloads/30d).
- **Docs do `dartonic_sqlite` estão dessincronizadas da API real do
  `dartonic_core` 1.0.1.** O README mostra `sqliteTable('t', {...})` com Map;
  a API real exige subclassar `Table` com `integer('id')` (nome obrigatório).
  `sqliteTable()` virou `RawTable` untyped, explicitamente desencorajado no
  source. Ler o source, não o README.
- **Docker: `libsqlite3-0` do Debian não basta.** O FFI do Dart abre
  `libsqlite3.so`, e o pacote runtime só instala `libsqlite3.so.0`. Precisa de
  symlink ou `libsqlite3-dev`. Falha só em runtime, com o build passando verde.
- **`Column._pending` é lista estática global** no `dartonic_core`: criar coluna
  fora de um construtor de `Table` polui a próxima tabela instanciada.
- **`darto_openapi` é code-first, não spec-first** — descreve a rota em Dart,
  valida o body de verdade (400 com `issues`) e serve `/openapi.json`. Não lê
  spec escrito à mão.

## Datas de publicação (bus factor: autor único, evandersondev)

`darto` 1.3.0 existe desde 2025-03-13 (39 versões). Todo o resto é recente:
`darto_view`/`darto_validator` 2026-05-24, `darto_openapi` 2026-05-30,
`dartonic_core`+`dartonic_sqlite` **2026-07-09** (1-2 versões cada).
As deps pesadas por baixo são maduras (`sqlite3` 2.9.4, `mustache_template` 2.0.5)
— o risco está na camada fina, não no fundo da pilha.

Ver [[bun-build-nao-typecheck]] e [[htmx-history-localstorage]].
