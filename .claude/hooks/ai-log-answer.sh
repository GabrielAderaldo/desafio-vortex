#!/usr/bin/env bash
# Captura as respostas do Gabriel ao AskUserQuestion em .ai-log/raw-prompts.md.
#
# Por que existe: o hook UserPromptSubmit só observa o campo de prompt. Respostas
# dadas pelo componente de pergunta — inclusive as observações escritas à mão, que
# costumam ser as intervenções mais decisivas — passavam sem registro. O EP-008
# documenta o caso: a provocação que derrubou o enquadramento do produto inteiro
# ("o que vai diferenciar o nosso sistema de um whats app?") foi escrita como
# observação e não estava no log.
#
# Registra a pergunta feita pelo Claude e a resposta dada, com as mesmas duas
# proteções do hook de prompt:
#   [NOLOG]  em qualquer posição da resposta -> nada é registrado, só um stub
#   redact-secrets.pl                        -> redige credenciais que escaparem
#
# Silencioso em stdout, exceto JSON de controle. PostToolUse com stdout solto vira
# ruído no contexto do Claude.

set -uo pipefail

input=$(cat)

tool=$(printf '%s' "$input" | jq -r '.tool_name // empty' 2>/dev/null)
[ "$tool" != "AskUserQuestion" ] && exit 0

cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
session=$(printf '%s' "$input" | jq -r '.session_id // empty' 2>/dev/null)

# --- A pergunta feita ---
# Sem as perguntas, a resposta fica sem sentido no log: "Recomendado" não diz nada
# solto. Cabeçalho e enunciado bastam; as opções seriam ruído.
perguntas=$(printf '%s' "$input" | jq -r '
  [ .tool_input.questions[]?
    | "- **" + (.header // "?") + "** · " + (.question // "") ]
  | join("\n")
' 2>/dev/null)

# --- A resposta dada ---
# O formato do tool_response varia (string, array de blocos, objeto). Tentar as três
# e cair para o JSON cru: perder a intervenção do Gabriel por causa de forma é
# exatamente o defeito que este hook existe para corrigir.
resposta=$(printf '%s' "$input" | jq -r '
  .tool_response
  | if   type == "string" then .
    elif type == "array"  then ([ .[] | if type == "object" then (.text // tojson) else tostring end ] | join("\n"))
    elif type == "object" then (.text // .content // tojson)
    else tojson end
' 2>/dev/null)

[ -z "$resposta" ] && exit 0

root="${CLAUDE_PROJECT_DIR:-${cwd:-$PWD}}"
log_dir="$root/.ai-log"
mkdir -p "$log_dir" 2>/dev/null || exit 0
log="$log_dir/raw-prompts.md"

stamp=$(date '+%Y-%m-%d %H:%M')

# Marcador próprio: quem for parsear precisa distinguir resposta de prompt, e a
# curadoria dos episódios precisa saber por qual caminho a fala entrou.
emit_header() {
  printf '\n---\n\n<!-- ai-log:answer -->\n### %s · sessão `%s` · resposta a pergunta\n\n' \
    "$stamp" "${session:0:8}"
}

# --- [NOLOG] ---
if printf '%s' "$resposta" | grep -qF '[NOLOG]'; then
  { emit_header; printf '_(resposta omitida do log — marcada com [NOLOG])_\n'; } \
    >> "$log" 2>/dev/null
  exit 0
fi

# --- Redação automática ---
# Mesmo contrato do hook de prompt: exit 0 = nada mudou · exit 9 = redigiu algo.
redactor="$(dirname "$0")/redact-secrets.pl"
if [ -x "$redactor" ]; then
  safe=$(printf '%s' "$resposta" | "$redactor")
  leaked=$?
else
  safe=$resposta
  leaked=0
fi

falhou=0
case "$leaked" in
  0|9) [ -z "$safe" ] && [ -n "$resposta" ] && falhou=1 ;;
  *)   falhou=1 ;;
esac

if [ "$falhou" -eq 1 ]; then
  { emit_header
    printf '> ⛔ **RESPOSTA NÃO REGISTRADA** — `redact-secrets.pl` falhou (exit %s).\n' "$leaked"
    printf '> Omitida porque não há garantia de que credenciais foram removidas.\n'
  } >> "$log" 2>/dev/null
  printf '%s' '{"systemMessage":"O redactor de segredos falhou — esta resposta NAO foi registrada no .ai-log.","suppressOutput":true}'
  exit 0
fi

{
  emit_header
  [ "$leaked" -eq 9 ] && printf '> ⚠️ Credencial real detectada e redigida automaticamente.\n\n'
  if [ -n "$perguntas" ]; then
    printf '**Perguntado:**\n\n%s\n\n**Respondido:**\n\n' "$perguntas"
  fi
  printf '~~~\n%s\n~~~\n' "$safe"
} >> "$log" 2>/dev/null

if [ "$leaked" -eq 9 ]; then
  printf '%s' '{"systemMessage":"Credencial real detectada na resposta e redigida do .ai-log. Ela ainda passou pelo terminal e pelo transcript — considere rotacionar.","suppressOutput":true}'
fi

exit 0
