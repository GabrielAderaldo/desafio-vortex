---
name: stack-openapi-code-first
description: darto_openapi é code-first (Dart → openapi.json), não spec-first; e /docs depende de CDN, quebrando offline
metadata:
  type: project
---

# OpenAPI no Darto é code-first — não spec-first

**Fato:** `darto_openapi` 1.1.0 gera a spec **a partir do código Dart**. Não existe
gerador de rotas/handlers a partir de um `openapi.yaml`. `darto gen client flutter`
também lê o código (exige `lib/app.dart` exportando `createApp()`), não uma spec.

**Why:** a proposta do desafio fala em "OpenAPI spec-first". Com este ecossistema,
spec-first só é possível escrevendo o YAML à mão e validando o `/openapi.json`
emitido contra ele (contract test), ou trocando de ferramenta.

**How to apply:** ao redigir arquitetura/ADR, chamar de "single source of truth em
Dart, spec derivada" — não de spec-first. Se spec-first for requisito duro, o gap
precisa de uma ferramenta externa (ex.: diff do `/openapi.json` contra um YAML
versionado no CI).

## Verificado rodando

- Emite `"openapi": "3.1.0"` com `paths`, `requestBody`, `required`, constraints.
- `Req(json: Schema.object({...}))` valida de verdade: POST inválido → **400** com
  `{"error":"Validation failed","issues":{"json":["body.name: length must be ≥ 1", ...]}}`.
- `app.use(api.docs())` monta `GET /openapi.json` e `GET /docs`.
- **`GET /docs` devolve 350 bytes** — é um shell que carrega o Scalar **de CDN**.
  Sem internet, a página de docs não renderiza. Relevante para demo offline/vídeo.
- Caminho alternativo: `zard` schema + `.toOpenApiSchema()` (`darto_validator`) faz
  um schema validar **e** documentar.
