---
name: stack-darto-viabilidade
description: Darto 1.3.0 testado de ponta a ponta — JSON + SSR Mustache + validação de body coexistem; números de boot, latência e compilação AOT
metadata:
  type: project
---

# Darto funciona — medido em 2026-07-27, Dart 3.12.1 / macOS arm64

Sonda em `scratchpad/darto-probe/app` (pode não existir mais; recriar em 10 min).

## Versões reais no pub.dev (o README offline está atrasado)

`docs/handbook/offline-reference/stack/darto/README.md` diz `darto: ^1.2.0`.
O publicado é **1.3.0** (2026-07-09). darto_view 1.0.2, darto_validator 1.4.0,
darto_openapi 1.1.0, darto_cli 1.2.0, zard 1.4.0.

## Números

| Medida | Valor | Comando |
|---|---|---|
| `dart pub get` cache **frio** (55 deps) | **2.41 s** | `PUB_CACHE=<tmp> /usr/bin/time -p dart pub get` |
| `dart compile exe` | **1.73 s** | `/usr/bin/time -p dart compile exe bin/app.dart -o server` |
| Binário AOT (macOS arm64) | **6.389.200 B** | `stat -f %z server` |
| Boot **AOT** (spawn → porta aceita) | **11,6–23,3 ms** (mediana ~15) | `boot.py aot` |
| Boot **JIT** (`dart run`) | **695–901 ms** | `boot.py jit` |
| p50 GET JSON (AOT) | 0,18–0,22 ms | 100 reqs após warmup |
| RSS do container | 11,52 MiB | `docker stats --no-stream` |

**60x de diferença entre `dart run` e o binário AOT.** Em dev, o custo é o `dart run`.

## As três rotas coexistem no mesmo `Darto()`

Verificado com um único `main`: `c.ok({...})` → `application/json`;
`c.render('index', {...})` com `viewEngine(MustacheEngine(viewsPath:'views'))` →
`text/html`; `zValidator('json', schema)` → 201 no válido, **400** no inválido com
`{"error":"Validation failed","target":"json","issues":[...]}`.

Runtime deps do darto core: só `mime` + `crypto`. `darto_view` puxa `mustache_template 2.0.5`.

## Armadilhas encontradas

- `MustacheEngine` lê os `.mustache` **do disco** em runtime → o Dockerfile precisa
  de `COPY views/`, senão o SSR quebra em produção (o `darto build` não copia).
- Top-level `final` em Dart é **lazy** — medir boot com `final t0 = ...` no topo do
  arquivo dá valor negativo. Medir de fora, por conexão TCP.
- `darto gen client flutter` exige `lib/app.dart` exportando `createApp()`.

Ver [[stack-openapi-code-first]], [[stack-docker-dart]], [[stack-persistencia-dart]].
