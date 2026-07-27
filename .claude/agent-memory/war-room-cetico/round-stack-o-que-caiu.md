---
name: round-stack-o-que-caiu
description: Round da stack (Dart+Darto+HTMX) — afirmações rotuladas "verificado" que caíram sob teste, e as que sobreviveram
metadata:
  type: project
---

Round de 2026-07-27 ("a stack Dart+Darto+Mustache+HTMX+Alpine+SW/TS se sustenta?").
Testado com comando rodado. **Não reabrir sem fato novo.**

## Caíram (com o caso concreto)

- **"Spec-first é impossível no ecossistema Dart; não existe validador que leia
  `openapi.yaml`."** Falso. `yaml` + `json_schema` 5.2.2 lê o `openapi.yaml` em runtime,
  extrai `components.schemas.X` e pega 7/7 violações (minLength, enum, minimum, required,
  `additionalProperties:false`, tipo). ~30 linhas. E o `validator` do darto é genérico
  ("Hono-style, use any validation logic"), então pluga direto. Limite honesto: testado com
  OpenAPI **3.1** (JSON Schema 2020-12); 3.0.x diverge em `nullable`/`exclusiveMinimum`.
- **"A probe faz CRUD."** `POST /api/anuncios` devolve **500** em 4 payloads distintos:
  `type 'Null' is not a subtype of type 'String' in type cast`. Só o **R** funciona.
- **"JSON + SSR + partial HTMX na mesma rota."** São rotas separadas: `/anuncios` (text/html)
  e `/api/anuncios` (json). `Accept: application/json` em `/anuncios` ainda devolve
  `text/html`. Não há content negotiation.
- **"2062/2436 rps, 0 erros."** Medido contra `{"data":[]}` — banco vazio.
- **"163 MB vs 15,5 MB" não é contradição nem comparação.** São binários diferentes
  (`/app/server` porta 3000 vs `/app/bin/server` porta 3111). A scratch só tem a rota `/`,
  sem persistência.
- **"Postgres preserva o scratch."** O ganho de 147 MB na imagem custa 416 MB de
  `postgres:17-alpine` ao lado. Total do compose: 163 MB (sqlite) vs ~431 MB (postgres).
- **"29 KB de HTMX+Alpine"** (técnico). Reproduzido: raw **97.584** / gzip **32.792** /
  brotli **29.619**. O investigador estava certo.

## Sobreviveram (e o que sustentou)

- Mustache não é do darto core — `c.render()` recebe **string HTML**, não arquivo de
  template. `darto_view` = 52 dl/30d, 1 like.
- `dartonic` `isDiscontinued=true` na API do pub.dev (`isUnlisted` é false — o "unlisted"
  era filtro de busca, não flag).
- `bun build` não checa tipos: exit 0 e bundle de 220 bytes com 2 erros de tipo.
  `bun x tsc --noEmit` pega os dois **sem precisar de Node**.
- HTMX grava snapshot em localStorage: doc offline `stack/htmx/docs.md:918` —
  "shared-use / public computers"; `historyCacheSize:10`. Mitigação: `hx-history="false"`,
  1 atributo.

Ver [[round-stack-nao-verificado]] e [[enquadramento-do-mediador]].
