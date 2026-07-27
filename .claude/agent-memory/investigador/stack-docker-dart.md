---
name: stack-docker-dart
description: Imagem oficial dart existe; multi-stage scratch dá 15,5 MB. Alpine NÃO roda binário Dart AOT e libsqlite3-0 sozinho não basta
metadata:
  type: project
---

# Docker + Dart — medido em 2026-07-27 (Docker 29.4.0 / OrbStack, arm64)

## Imagem base

`library/dart` no Docker Hub (namespace `library/` = Official Image), 3.915.210 pulls.
Tags: `3.12.2`, `stable`, `beta`. ~310 MB comprimido por arquitetura.

## Tamanhos medidos do runtime

| Base do stage final | `docker images --tree` Size | Content size (o que trafega) | Funciona? |
|---|---|---|---|
| `FROM scratch` + `COPY /runtime/` | **15,5 MB** | **4,62 MB** | ✅ |
| `alpine:3.21` | 24,1 MB | 7,05 MB | ❌ |
| `debian:bookworm-slim` | 161 MB | 34,5 MB | ✅ |

Rootfs descompactado do scratch: **10.767.360 B** (`docker export | wc -c`).
Camadas: `/runtime/` 3,71 MB + binário 7,19 MB + views 4,1 kB.
Build inteiro (com pull da base): 27,9 s. Rebuild com cache: ~5 s.

## Alpine não funciona — verificado

`docker run --rm darto-probe:alpine` → `exec /app/bin/server: no such file or
directory`. Binário Dart AOT é ligado a **glibc**; Alpine é musl. Não existe flag
do `dart compile exe` que resolva.

## Armadilha do SQLite em container (custou um build)

`package:sqlite3` faz `DynamicLibrary.open('libsqlite3.so')` — **sem** sufixo de
versão. O pacote Debian `libsqlite3-0` instala só `libsqlite3.so.0`
(o symlink `.so` vem do `-dev`). Resultado em `FROM scratch` **e** em
`debian:bookworm-slim + libsqlite3-0`:

```
Failed to load dynamic library 'libsqlite3.so': ... No such file or directory
```

Correção verificada (funciona, sem puxar o `-dev`):

```dockerfile
RUN apt-get install -y --no-install-recommends libsqlite3-0 ca-certificates \
 && ln -s /usr/lib/$(uname -m)-linux-gnu/libsqlite3.so.0 \
          /usr/lib/$(uname -m)-linux-gnu/libsqlite3.so
```

**Se o app usar SQLite, o `FROM scratch` de 15,5 MB deixa de ser opção** (a menos
que se copie a .so à mão). Postgres, sendo pure Dart, não tem esse problema.

## `darto build` já gera Dockerfile

`darto_cli` 1.2.0 emite exatamente o padrão `dart:stable` → `FROM scratch` +
`/runtime/` + `ca-certificates.crt`. **Não copia `views/`** — quebra o SSR Mustache.
