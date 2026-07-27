---
name: stack-frontend-bytes
description: HTMX e Alpine medidos em bytes — "14 KB / 15 KB" é brotli, não gzip nem bruto; e o SW em TypeScript compila em 598 B
metadata:
  type: project
---

# Bytes reais de HTMX + Alpine — medido em 2026-07-27

Versões correntes resolvidas pelo unpkg: **htmx.org 2.0.10**, **alpinejs 3.15.12**.

| Arquivo | bruto | gzip -9 | brotli -q11 | zstd -19 |
|---|---|---|---|---|
| `htmx.min.js` | **51.238 B** (50,0 KiB) | 16.595 B | **14.996 B** | 15.927 B |
| `alpinejs/cdn.min.js` | **46.346 B** (45,3 KiB) | 16.720 B | **15.120 B** | 16.089 B |
| **soma** | 97.584 B (95,3 KiB) | 32.800 B | **29.620 B** | — |

Comando: `curl -sL -o f.js https://unpkg.com/<pkg>@<ver>/dist/<file>` +
`stat -f %z` / `gzip -9 -c | wc -c` / `brotli -q 11 -c | wc -c`.

## O que isso derruba

"~14 KB e ~15 KB" é **brotli**, e só brotli. Com gzip são ~16,2 e ~16,3 KiB;
**sem compressão são 50 e 45 KiB** — e é o número bruto que paga o custo de parse
no dispositivo. Ao citar o tamanho, dizer sempre qual compressão.

unpkg serve `content-encoding: gzip` por padrão (br só se o cliente pedir).
`brotli` e `zstd` estão instalados via Homebrew nesta máquina.

## Service Worker em TypeScript — sem toolchain pesada

`sw.ts` com `/// <reference lib="webworker" />` + `declare const self:
ServiceWorkerGlobalScope`:

- `deno check sw.ts` → passa (Deno 2.9.3), sem `tsconfig`, sem `node_modules`.
- `bun build sw.ts --outfile dist/sw.js --minify` → **20 ms**, **598 B**
  (gzip 341 B, brotli 288 B). Bun 1.3.14.
- `tsc` **não** está no PATH desta máquina; `npx` 11.13.0 está.
