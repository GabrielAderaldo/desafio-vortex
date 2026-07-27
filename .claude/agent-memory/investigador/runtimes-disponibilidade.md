---
name: runtimes-disponibilidade
description: O que é nativo do macOS vs. o que exige instalação — jq e perl VÊM com o macOS, python3 do sistema é shim do Xcode, deno/bun não vêm em lugar nenhum
metadata:
  type: reference
---

# Disponibilidade de runtime num clone limpo

**Verificado em 2026-07-26** com `codesign -dv --verbose=2 /usr/bin/<bin>`.
Assinatura `Authority=Software Signing` + `Identifier=com.apple.*` prova origem Apple.

## Nativo do macOS 26 (não precisa instalar nada)

| binário | identifier | nota |
|---|---|---|
| `/usr/bin/jq` | `com.apple.jq` | **jq 1.7.1-apple. Vem com o macOS a partir do Sequoia (15).** Surpresa — desfaz a suposição de que jq é dependência externa **no macOS**. |
| `/usr/bin/perl` | `com.apple.perl` | 5.34.1 |
| `/bin/bash` | `com.apple.bash` | **3.2.57** (GPLv2, congelado). `/bin/sh` e `/bin/zsh` idem. |
| `/usr/bin/awk`, `sed`, `grep`, `basename`, `ruby` | `com.apple.*` | |

## NÃO nativo

- **`/usr/bin/python3` é um shim do `xcode-select`** (`com.apple.dt.xcode_select.tool-shim-public`),
  não um Python. Nesta máquina resolve para 3.9.6 **porque há Xcode instalado**
  (`xcode-select -p` → `/Applications/Xcode.app/...`). **Num Mac sem Command Line Tools
  ele dispara o prompt de instalação do Xcode em vez de rodar.** Python3 NÃO é garantido.
- **deno**: `~/.deno/bin/deno` 2.9.3 (79 MB). Existe também a fórmula brew `deno`; o
  PATH pega a instalação standalone. Duas instalações coexistindo.
- **bun**: `~/.bun/bin/bun` 1.3.14 (60 MB). **Não é brew**, instalação standalone.
- **node**: v24.16.0 via **fnm** — path é um multishell efêmero
  (`~/.local/state/fnm_multishells/<pid>_<ts>/bin/node`). **Esse path muda a cada shell**;
  nunca hardcodar node em hook.

## Armadilha de PATH no shebang

`#!/usr/bin/env bash` nesta máquina resolve para **bash 5.3 do brew**, não o 3.2 do
sistema. Ou seja, os scripts do projeto rodam num bash diferente conforme o PATH.
**Testado:** `statusline.sh` roda idêntico em bash 3.2, bash 5.3 e `/bin/sh` — não usa
nada de bash 4+. O risco é teórico hoje, mas real se alguém usar `${var,,}`, arrays
associativos ou `mapfile`.

Em **Linux**: bash sim, jq **não** (precisa `apt install jq`), perl geralmente sim,
python3 geralmente sim. A garantia do jq é uma peculiaridade do macOS recente.

Ver [[hooks-startup-benchmark]] e [[hooks-contrato-e-linguagem]].
