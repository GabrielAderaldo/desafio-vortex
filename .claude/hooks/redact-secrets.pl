#!/usr/bin/env perl
# Filtro stdin -> stdout: substitui credenciais reais por [REDIGIDO: ...].
#
# Rede de segurança do log de prompts. A convenção [SECRET:NOME] já evita que o
# valor entre no prompt; isto existe para o dia em que você colar o valor sem
# pensar — um curl inteiro, um .env, uma resposta de erro com o header Authorization.
#
# Sai com código 9 se redigiu alguma coisa, 0 se o texto passou íntegro.
# O chamador usa isso para avisar que houve vazamento e o segredo deve ser rotacionado.
#
# Testar isoladamente:
#   echo 'AWS_SECRET=AKIAIOSFODNN7EXAMPLE' | ./redact-secrets.pl

use strict;
use warnings;

my $text = do { local $/; <STDIN> };
$text = '' unless defined $text;
my $original = $text;

# --- Blocos de chave privada (PEM, OpenSSH, PGP) ---
$text =~ s/-----BEGIN[^\n-]*PRIVATE KEY[^\n-]*-----.*?-----END[^\n-]*PRIVATE KEY[^\n-]*-----/[REDIGIDO: chave privada]/gs;
$text =~ s/-----BEGIN PGP PRIVATE KEY BLOCK-----.*?-----END PGP PRIVATE KEY BLOCK-----/[REDIGIDO: chave PGP]/gs;

# --- Tokens com prefixo reconhecível (baixíssimo falso positivo) ---
$text =~ s/\bsk-ant-[A-Za-z0-9_\-]{20,}/[REDIGIDO: token Anthropic]/g;
$text =~ s/\bsk-proj-[A-Za-z0-9_\-]{20,}/[REDIGIDO: token OpenAI]/g;
$text =~ s/\bsk-[A-Za-z0-9]{32,}/[REDIGIDO: token]/g;
$text =~ s/\bgithub_pat_[A-Za-z0-9_]{20,}/[REDIGIDO: PAT GitHub]/g;
$text =~ s/\bgh[pousr]_[A-Za-z0-9]{30,}/[REDIGIDO: token GitHub]/g;
$text =~ s/\bglpat-[A-Za-z0-9_\-]{15,}/[REDIGIDO: token GitLab]/g;
$text =~ s/\bAKIA[0-9A-Z]{16}\b/[REDIGIDO: AWS access key id]/g;
$text =~ s/\bASIA[0-9A-Z]{16}\b/[REDIGIDO: AWS session key id]/g;
$text =~ s/\bAIza[A-Za-z0-9_\-]{30,}/[REDIGIDO: chave Google]/g;
$text =~ s/\bxox[baprse]-[A-Za-z0-9\-]{10,}/[REDIGIDO: token Slack]/g;
$text =~ s/\btskey-[a-z]+-[A-Za-z0-9\-]{10,}/[REDIGIDO: chave Tailscale]/g;
$text =~ s/\bAC[a-f0-9]{32}\b/[REDIGIDO: Twilio SID]/g;
$text =~ s/\bdop_v1_[a-f0-9]{60,}/[REDIGIDO: token DigitalOcean]/g;
$text =~ s/\bAGE-SECRET-KEY-1[0-9A-Z]{50,}/[REDIGIDO: chave age]/g;

# --- JWT (três segmentos base64url) ---
$text =~ s/\beyJ[A-Za-z0-9_\-]{8,}\.[A-Za-z0-9_\-]{8,}\.[A-Za-z0-9_\-]{8,}/[REDIGIDO: JWT]/g;

# --- Credenciais embutidas em URL: https://user:senha@host ---
$text =~ s{(\w+://[^\s:/@]+):([^\s@/]{4,})@}{$1:[REDIGIDO]\@}g;

# --- Headers de autorização ---
$text =~ s/\b(Authorization\s*:\s*(?:Bearer|Basic|Token)\s+)[A-Za-z0-9_\-\.=+\/]{16,}/$1\[REDIGIDO\]/gi;

# --- Atribuições genéricas: CHAVE=valor ---
# Só dispara quando o valor parece um literal. Referências e placeholders passam:
#   API_KEY=$UMBLER_KEY        -> intacto (referência a variável)
#   API_KEY=[SECRET:UMBLER]    -> intacto (nossa convenção)
#   API_KEY={{ secrets.X }}    -> intacto (template)
#   API_KEY=xxxxxxxxxxxx       -> intacto (placeholder óbvio)
#   API_KEY=1f3a9c...          -> REDIGIDO
$text =~ s{
    (?<! \[ )                       # não casar o SECRET de [SECRET:NOME]
    \b( \w* (?: API[_-]?KEY | APIKEY | TOKEN | SECRET | PASSWORD | PASSWD
              | SENHA | ACCESS[_-]?KEY | PRIVATE[_-]?KEY | CLIENT[_-]?SECRET
              | AUTH[_-]?TOKEN | BWS[_-]?ACCESS[_-]?TOKEN ) \w* )
    ( \s* [:=] \s* )
    ( ["']? )
    (?!                             # placeholders, templates e referências a env
        \$ | \[ | < | \{\{ | %\( | \#\{
      | x{3,} | X{3,} | \.\.\. | your[_-] | seu[_-] | my[_-]
      | changeme | placeholder | example | dummy | test
      | process\.env | os\.environ | System\.getenv | Deno\.env
      | import\.meta | ENV\[ | ENV\. | getenv | config\. | this\. | self\.
      | ["']?\s*$
    )
    (?!                             # qualquer referência pontuada (obj.prop.prop)
        [A-Za-z_\$][\w\$]* (?: \.[\w\$]+ )+ [\s;,\)\]\}]* (?:\n|$)
    )
    ( [^\s"'\n]{12,} )
    \3
}{$1$2$3\[REDIGIDO\]$3}gxi;

print $text;
exit($text ne $original ? 9 : 0);
