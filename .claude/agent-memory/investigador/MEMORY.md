# Memória do Investigador — desafio-vortex

## Claude Code: hooks
- [Contrato de hook e linguagem](hooks-contrato-e-linguagem.md) — nada exige shell; exec form (`args`) spawna qualquer executável. Verificado rodando hooks Deno e Python.
- [Benchmark de startup por linguagem](hooks-startup-benchmark.md) — bash 11.9ms no early-exit, 27.4ms no caminho longo; Bun 16ms; Perl 6ms. Tudo ≪ timeout de 5s.

## Ambiente
- [Disponibilidade de runtimes](runtimes-disponibilidade.md) — jq e perl vêm com o macOS; `/usr/bin/python3` é shim do Xcode; deno/bun/node exigem instalação.

## Este repo
- [Superfície de shell do projeto](superficie-de-shell-do-projeto.md) — não são só os 3 `.sh`: há shell inline no `settings.json` e no `Justfile`.
- [Perl redactor fora do alcance](perl-redactor-fora-do-alcance.md) — `redact-secrets.pl` é o mais rápido e o mais arriscado de portar; política "sem shell" não o alcança.

## Stack candidata (war room 2026-07-27)
- [Darto é viável — medido](stack-darto-viabilidade.md) — 1.3.0; JSON+SSR+validação coexistem; boot AOT ~15ms vs `dart run` ~800ms; `pub get` frio 2,4s.
- [Persistência em Dart](stack-persistencia-dart.md) — `dartonic` está discontinued; o mesmo schema NÃO roda em SQLite e Postgres.
- [Docker + Dart](stack-docker-dart.md) — scratch dá 15,5 MB; Alpine não roda AOT; `libsqlite3.so` falta mesmo com `libsqlite3-0`.
- [Bytes de HTMX/Alpine](stack-frontend-bytes.md) — 50 e 45 KiB bruto; "14/15 KB" só vale em brotli.
- [OpenAPI é code-first](stack-openapi-code-first.md) — `darto_openapi` deriva spec do Dart; `/docs` puxa Scalar de CDN.
- [HTTPS local e SW](stack-https-local-pwa.md) — `localhost` já é secure context; Caddy é opcional e cobra CA no keychain.

## Suposições derrubadas
- [TS/Python não encurtam o código](shell-vs-ts-linhas-derrubado.md) — port do `adr-guard` ficou +32% (TS) e +46% (Python) em linhas de código.

## Ferramentas de investigação
- [Ferramental e armadilhas](ferramental-e-armadilhas.md) — onde ficam os benchmarks, o que não existe no macOS, como medir sem viés.
