---
name: validar-mermaid-localmente
description: Como parsear os blocos Mermaid de um .md sem enviar nada para fora — mermaid 11 + jsdom, com as três armadilhas
metadata:
  type: reference
---

`just check` **não valida Mermaid**. Diagrama quebrado passa no portão e só aparece quando
alguém abre o arquivo. Verificado funcionando em 2026-07-28 (6 diagramas, mermaid 11).

Receita, no scratchpad da sessão:

1. `pnpm add mermaid@11 jsdom` — **`npm install` é bloqueado por hook aqui**, o PM é `pnpm`.
2. Extrair os blocos com regex ```` ```mermaid\n(.*?)``` ```` para arquivos `.mmd`.
3. Script ESM que monta um DOM antes de importar o mermaid:

```js
import { JSDOM } from 'jsdom';
const dom = new JSDOM('<!DOCTYPE html><body></body>', {pretendToBeVisual:true});
for (const k of ['window','document','HTMLElement','Element','Node','DOMParser','NodeFilter','SVGElement'])
  Object.defineProperty(globalThis, k, {value: k==='window'?dom.window:dom.window[k], configurable:true, writable:true});
const mermaid = (await import('./node_modules/mermaid/dist/mermaid.esm.mjs')).default;
mermaid.initialize({startOnLoad:false});
await mermaid.parse(src);   // lança em erro de sintaxe
```

**As três armadilhas, em ordem de aparição:**

- `npm install` → hook manda usar `pnpm`.
- Sem DOM, todo diagrama falha com **`purify.addHook is not a function`** — é o DOMPurify,
  **não** é erro de sintaxe. Se todos os diagramas falham com a mesma mensagem, é ambiente.
- `global.navigator = …` lança `Cannot set property navigator of #<Object> which has only a
  getter` no Node 24 — use `Object.defineProperty`.

**O que passou sem problema nos labels:** `<b>`, `<br/>`, emoji, `«»`, `·`, `▾`, `─`, `—`,
`subgraph ID["título com emoji"]`, e definir nó dentro da aresta (`A -->|"x"| B["…"]`).
