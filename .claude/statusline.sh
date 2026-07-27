#!/usr/bin/env bash
# Statusline do Claude Code — recebe um JSON de contexto no stdin.
#
# Mostra, nesta ordem: modelo · uso do contexto · custo · branch git · sujeira no
# working tree. O uso de contexto vem primeiro por ser o recurso mais escasso da
# sessão: performance degrada conforme ele enche, e sem medidor ninguém percebe.

set -uo pipefail

# O locale pt_BR usa vírgula como separador decimal: `printf '%.2f' 1.2345` devolve
# "1,00" — para no ponto e descarta os centavos. O JSON sempre traz ponto, então
# fixamos o locale numérico em C.
export LC_NUMERIC=C

entrada=$(cat)

j() { printf '%s' "$entrada" | jq -r "$1 // empty" 2>/dev/null; }

modelo=$(j '.model.display_name')
dir=$(j '.workspace.current_dir')
custo=$(j '.cost.total_cost_usd')
usados=$(j '.context.used_tokens')
total=$(j '.context.total_tokens')

partes=()

[ -n "$modelo" ] && partes+=("\033[1;35m${modelo}\033[0m")

# Contexto: verde até 50%, amarelo até 80%, vermelho acima.
#
# Os valores são validados como inteiros antes da aritmética. `$(( ))` do shell
# expande variáveis recursivamente: um campo não-numérico aborta o script sob
# `set -u`, e em versões sem `-u` seria um vetor de execução de comando.
ehnum() { case "$1" in ''|*[!0-9]*) return 1 ;; *) return 0 ;; esac; }

if ehnum "${usados:-}" && ehnum "${total:-}" && [ "$total" -gt 0 ]; then
  pct=$(( usados * 100 / total ))
  if   [ "$pct" -lt 50 ]; then cor="32"
  elif [ "$pct" -lt 80 ]; then cor="33"
  else                         cor="31"
  fi
  partes+=("\033[0;${cor}m${pct}% ctx\033[0m")
fi

if [ -n "$custo" ]; then
  fmt=$(printf '%.2f' "$custo" 2>/dev/null) && partes+=("\033[0;36m\$${fmt}\033[0m")
fi

# Git: branch + contagem de arquivos sujos.
if [ -n "$dir" ] && git -C "$dir" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$dir" branch --show-current 2>/dev/null)
  [ -z "$branch" ] && branch=$(git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  sujos=$(git -C "$dir" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if [ "$sujos" -gt 0 ]; then
    partes+=("\033[0;33m⎇ ${branch}*${sujos}\033[0m")
  else
    partes+=("\033[0;32m⎇ ${branch}\033[0m")
  fi
fi

# `${partes[*]}` com array vazio sob `set -u` é erro no bash 3.2 — que é o bash que
# vem de fábrica no macOS (/bin/bash, 3.2.57). O `+` só expande se o array tiver
# elementos, mantendo o script compatível com 3.2 e 5.x.
[ ${#partes[@]} -eq 0 ] && exit 0
printf '%b' "$(IFS='│'; echo "${partes[*]}")" | sed 's/│/ │ /g'
