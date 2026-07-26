#!/usr/bin/env bash
# Guarda de imutabilidade dos ADRs.
#
# Bloqueia Edit/Write/MultiEdit em ADRs cujo front-matter tenha status fechado
# (aceito, rejeitado, descontinuado, substituido).
#
# A ÚNICA edição permitida num ADR fechado é a transição de supersessão — alterar
# `status:` e `substituido_por:`. Este script deixa essa passar e barra o resto,
# porque bloquear tudo tornaria impossível marcar um ADR como substituído.
#
# Sai 0 sempre; a decisão vai no JSON de stdout (permissionDecision).

set -uo pipefail

input=$(cat)

tool=$(printf '%s' "$input" | jq -r '.tool_name // empty')
file=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')

[ -z "$file" ] && exit 0

# Só arquivos ADR-*.md — o _TEMPLATE.md nunca é um ADR e continua editável.
case "$(basename "$file")" in
  ADR-*.md) ;;
  *) exit 0 ;;
esac

# Só dentro da pasta de ADRs do handbook.
case "$file" in
  */docs/handbook/adr/*) ;;
  *) exit 0 ;;
esac

# Arquivo ainda não existe: é ADR novo sendo criado. Liberado.
[ -f "$file" ] || exit 0

# Extrai um campo escalar do primeiro bloco de front-matter, sem comentário inline.
campo_fm() {
  awk -v chave="$1" '
    /^---[[:space:]]*$/ { blocos++; if (blocos > 1) exit; next }
    blocos == 1 && index($0, chave ":") == 1 {
      sub(/^[^:]*:[[:space:]]*/, "")
      sub(/[[:space:]]*#.*$/, "")
      gsub(/[[:space:]"'"'"']/, "")
      print
      exit
    }
  ' "$2" 2>/dev/null
}

status=$(campo_fm status "$file")

case "$status" in
  aceito|rejeitado|descontinuado|substituido) ;;
  *) exit 0 ;;  # proposto, vazio ou desconhecido → ADR ainda aberto
esac

# --- A partir daqui o ADR está FECHADO -------------------------------------

# Verifica se um texto contém apenas linhas de campos cuja alteração é permitida.
somente_campos_permitidos() {
  printf '%s' "$1" | awk '
    /^[[:space:]]*$/ { next }
    /^(status|substituido_por):/ { permitidas++; next }
    { proibidas++ }
    END { exit (proibidas > 0 || permitidas == 0) ? 1 : 0 }
  '
}

if [ "$tool" = "Edit" ]; then
  old=$(printf '%s' "$input" | jq -r '.tool_input.old_string // ""')
  new=$(printf '%s' "$input" | jq -r '.tool_input.new_string // ""')
  if somente_campos_permitidos "$old" && somente_campos_permitidos "$new"; then
    exit 0  # transição de supersessão — permitida
  fi
fi

nome=$(basename "$file")
ident=$(campo_fm id "$file")
[ -z "$ident" ] && ident="${nome%.md}"

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "ADR imutável: $nome está com status '$status' e não pode ser editado nem apagado.\n\nPara mudar a decisão, o protocolo é criar um ADR NOVO:\n  1. Novo arquivo, número novo, 'status: aceito' e 'substitui: [$ident]'.\n  2. Neste aqui, alterar SOMENTE 'status: substituido' e 'substituido_por:'.\n\nO texto de um ADR fechado preserva o raciocínio de quem decidiu com a informação da época — editá-lo destrói exatamente o que o torna útil. Ver docs/handbook/README.md."
  }
}
EOF

exit 0
