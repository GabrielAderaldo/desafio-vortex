---
name: bun-build-nao-typecheck
description: bun build apaga tipos sem verificar — passou verde com 2 erros de tipo gritantes; só tsc --noEmit pega
metadata:
  type: project
---

`bun build` **não faz typecheck**. Verificado em 2026-07-27: compilei um
Service Worker com `const x: number = j.data[0].titulo` (string→number) e acesso
a campo inexistente. `bun build` → "Bundled 1 module", **exit 0**. O mesmo
arquivo em `tsc --noEmit --lib ESNext,WebWorker --strict` acusa os dois erros
(TS2322 e TS2339).

**Why:** a proposta preliminar da stack usava "TypeScript no SW compilado com
`bun build` (0,08 s)" como se o TS estivesse dando garantia de contrato. Não
está — o bun só apaga as anotações. Isso é segurança falsa: os tipos gerados do
OpenAPI não protegem nada se nada os verifica.

**How to apply:** sempre que alguém propuser `bun build` como a etapa de
"compilar TypeScript", exigir um `tsc --noEmit` separado no CI / pre-commit /
receita do just. O par correto é `tsc --noEmit` (verifica) + `bun build`
(empacota). Ao rodar tsc para Service Worker, usar `--lib ESNext,WebWorker` —
incluir `DOM` junto causa centenas de erros TS6200/TS2374 por conflito de
definições (foi erro meu na primeira tentativa, não bug do projeto).

Cadeia que funciona, medida: Dart code-first → `/openapi.json` →
`openapi-typescript` (26,5 ms) → `.d.ts` → `tsc --noEmit` + `bun build` (8 ms,
869 bytes minificado).

Ver [[stack-darto-verificada]].
