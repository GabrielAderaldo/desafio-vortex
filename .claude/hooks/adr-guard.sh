#!/usr/bin/env bash
# Guarda de imutabilidade dos ADRs.
#
# Bloqueia Edit/Write/MultiEdit em ADRs cujo front-matter tenha status fechado
# (aceito, rejeitado, descontinuado, substituido).
#
# A única edição permitida num ADR fechado é a transição de supersessão. Bloquear
# tudo tornaria impossível marcar um ADR como substituído — mas permitir "qualquer
# edição que só toque status/substituido_por" abre um bypass em dois passos:
# rebaixar `aceito` para `proposto` e depois editar o corpo à vontade. Por isso o
# valor NOVO do status é validado, não apenas qual campo foi tocado.
#
# ALCANCE — o que este hook NÃO protege:
#   O matcher é Edit|Write|MultiEdit. Um `rm` ou `git checkout` via Bash não passa
#   por aqui e apaga o arquivo sem obstáculo. Isto é um portão de escrita por
#   ferramenta de edição, não uma garantia de integridade do arquivo.
#
# Falha FECHADA: sem `jq` disponível, sai com código 2 (bloqueia) em vez de deixar
# passar em silêncio. Um portão que falha aberto é pior que nenhum portão, porque
# dá confiança sem entregar proteção.

set -uo pipefail

# --- Dependências: sem jq não há decisão possível, então negue -----------------
if ! command -v jq >/dev/null 2>&1; then
  echo "adr-guard: 'jq' não encontrado no PATH — bloqueando por precaução." >&2
  exit 2
fi

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

# --- A partir daqui o ADR está FECHADO ---------------------------------------

nome=$(basename "$file")
ident=$(campo_fm id "$file")
[ -z "$ident" ] && ident="${nome%.md}"

# Emite a negação. O JSON é montado por `jq -n --arg`, não por heredoc: um nome de
# arquivo com aspas quebrava o heredoc, e JSON inválido é descartado pelo Claude
# Code — ou seja, virava permissão silenciosa.
negar() {
  jq -n --arg motivo "$1" \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$motivo}}'
  exit 0
}

motivo_padrao="ADR imutável: $nome está com status '$status' e seu conteúdo não pode ser alterado.

Para mudar a decisão, o protocolo é criar um ADR NOVO:
  1. Novo arquivo, número novo, 'status: aceito' e 'substitui: [$ident]'.
  2. Neste aqui, alterar SOMENTE 'status: substituido' e 'substituido_por:'.

O texto de um ADR fechado preserva o raciocínio de quem decidiu com a informação da época — editá-lo destrói exatamente o que o torna útil. Ver docs/handbook/README.md."

# Só Edit pode conter uma transição de supersessão. Write reescreve o arquivo
# inteiro e MultiEdit aplica várias mudanças de uma vez: ambos são negados sempre.
[ "$tool" = "Edit" ] || negar "$motivo_padrao"

old=$(printf '%s' "$input" | jq -r '.tool_input.old_string // ""')
new=$(printf '%s' "$input" | jq -r '.tool_input.new_string // ""')

# Todas as linhas não vazias devem ser de campos cuja alteração é permitida.
somente_campos_permitidos() {
  printf '%s' "$1" | awk '
    /^[[:space:]]*$/ { next }
    /^(status|substituido_por):/ { permitidas++; next }
    { proibidas++ }
    END { exit (proibidas > 0 || permitidas == 0) ? 1 : 0 }
  '
}

somente_campos_permitidos "$old" && somente_campos_permitidos "$new" \
  || negar "$motivo_padrao"

# O campo certo não basta: o VALOR novo precisa ser uma transição legítima.
# A partir de um status fechado só se pode ir para `substituido` (houve um ADR
# sucessor) ou `descontinuado` (a decisão saiu de vigor sem substituto).
# Rebaixar para `proposto` ou `aceito` reabriria o arquivo para edição livre —
# era exatamente o bypass de dois passos.
novo_status=$(printf '%s' "$new" | awk '
  index($0, "status:") == 1 {
    sub(/^status:[[:space:]]*/, "")
    sub(/[[:space:]]*#.*$/, "")
    gsub(/[[:space:]"'"'"']/, "")
    print
    exit
  }')

if [ -n "$novo_status" ]; then
  case "$novo_status" in
    substituido|descontinuado) ;;
    *)
      negar "ADR imutável: tentativa de rebaixar $nome de '$status' para '$novo_status'.

A partir de um status fechado, as únicas transições válidas são:
  · status: substituido    (quando existe um ADR sucessor — preencha substituido_por)
  · status: descontinuado  (quando a decisão saiu de vigor sem substituto)

Rebaixar para '$novo_status' reabriria o documento para edição livre, o que anula a
imutabilidade. Se a decisão mudou, escreva um ADR novo que substitua este."
      ;;
  esac
fi

exit 0  # transição de supersessão legítima — permitida
