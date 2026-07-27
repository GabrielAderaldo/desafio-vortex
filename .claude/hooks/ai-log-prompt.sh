#!/usr/bin/env bash
# Captura todo prompt enviado ao Claude Code em .ai-log/raw-prompts.md.
#
# Matéria-prima bruta para o Diário de Bordo da IA: registra tudo, sem filtro
# editorial. A curadoria é manual e vira os episódios em docs/ai-log/.
#
# Duas proteções contra vazamento de credencial no arquivo:
#   [NOLOG]  em qualquer posição do prompt  -> nada é registrado, só um stub
#   redact-secrets.pl                       -> redige credenciais reais que
#                                              escaparem (rede de segurança)
#
# Só escreve em stdout no caso raro de detecção — e aí em JSON de controle, para
# virar aviso ao usuário. Texto solto no stdout de um UserPromptSubmit seria
# injetado no contexto do Claude e cobrado em toda mensagem.

set -uo pipefail

input=$(cat)

prompt=$(printf '%s' "$input" | jq -r '.prompt // empty' 2>/dev/null)
[ -z "$prompt" ] && exit 0

cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
session=$(printf '%s' "$input" | jq -r '.session_id // empty' 2>/dev/null)

root="${CLAUDE_PROJECT_DIR:-${cwd:-$PWD}}"
log_dir="$root/.ai-log"
mkdir -p "$log_dir" 2>/dev/null || exit 0
log="$log_dir/raw-prompts.md"

stamp=$(date '+%Y-%m-%d %H:%M')

# O marcador HTML é o delimitador de entrada para qualquer parsing; o `###` logo
# abaixo é só para leitura humana. Prompts colados frequentemente contêm linhas
# começando com `### ` (este arquivo já tinha 36 delas para 23 entradas reais), então
# contar cabeçalhos markdown superestima o número de entradas.
emit_header() {
  printf '\n---\n\n<!-- ai-log:entry -->\n### %s · sessão `%s`\n\n' "$stamp" "${session:0:8}"
}

# --- [NOLOG]: o prompt inteiro fica de fora ---
if printf '%s' "$prompt" | grep -qF '[NOLOG]'; then
  { emit_header; printf '_(prompt omitido do log — marcado com [NOLOG])_\n'; } \
    >> "$log" 2>/dev/null
  exit 0
fi

# --- Redação automática ---
# Contrato do redactor: exit 0 = nada mudou · exit 9 = redigiu algo.
# Qualquer outro código é falha dele, e o texto em `safe` não é confiável.
redactor="$(dirname "$0")/redact-secrets.pl"
if [ -x "$redactor" ]; then
  safe=$(printf '%s' "$prompt" | "$redactor")
  leaked=$?
else
  safe=$prompt
  leaked=0
fi

# Falha do redactor gravava um fence VAZIO com timestamp correto — o pior modo de
# falha possível, porque a contagem de entradas continua batendo e a perda passa
# despercebida em revisão. Agora a falha é registrada de forma legível e avisada na
# UI. O prompt não é gravado: se o redactor não rodou, não há garantia de que
# credenciais foram removidas.
falhou=0
case "$leaked" in
  0|9) [ -z "$safe" ] && [ -n "$prompt" ] && falhou=1 ;;
  *)   falhou=1 ;;
esac

if [ "$falhou" -eq 1 ]; then
  { emit_header
    printf '> ⛔ **PROMPT NÃO REGISTRADO** — `redact-secrets.pl` falhou (exit %s).\n' "$leaked"
    printf '> O conteúdo foi omitido porque não há garantia de que credenciais foram\n'
    printf '> removidas. Corrija o redactor e recupere este prompt do transcript.\n'
  } >> "$log" 2>/dev/null
  printf '%s' '{"systemMessage":"O redactor de segredos falhou — este prompt NAO foi registrado no .ai-log. Corrija .claude/hooks/redact-secrets.pl; o diario esta com uma lacuna.","suppressOutput":true}'
  exit 0
fi

# Fence com ~~~ para não quebrar quando o prompt contém blocos ``` .
{
  emit_header
  [ "$leaked" -eq 9 ] && printf '> ⚠️ Credencial real detectada e redigida automaticamente.\n\n'
  printf '~~~\n%s\n~~~\n' "$safe"
} >> "$log" 2>/dev/null

# Avisa na UI. Se o filtro atuou, o valor passou pelo terminal e pelo histórico
# da sessão — redigir o log não desfaz isso, então a chave deve ser rotacionada.
if [ "$leaked" -eq 9 ]; then
  printf '%s' '{"systemMessage":"Credencial real detectada no prompt e redigida do .ai-log. Ela ainda passou pelo terminal e pelo transcript da sessao — considere rotacionar. Use [SECRET:NOME] para referenciar segredos sem colar o valor.","suppressOutput":true}'
fi

exit 0
