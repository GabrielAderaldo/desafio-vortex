---
name: perl-redactor-fora-do-alcance
description: redact-secrets.pl é Perl, não shell — política "sem shell" não o alcança; e ele é o script mais rápido e mais difícil de portar do repo
metadata:
  type: reference
---

# `redact-secrets.pl`: o caso que a política não alcança

**Verificado em 2026-07-26.** `.claude/hooks/redact-secrets.pl`, 80 linhas, filtro
stdin→stdout que substitui credenciais por `[REDIGIDO: ...]`. Sai **9** se redigiu,
**0** se o texto passou íntegro — o `ai-log-prompt.sh` usa esse código para avisar na
UI que a chave deve ser rotacionada.

Testado com valores fake públicos:

- `AWS_SECRET=AKIAIOSFODNN7EXAMPLE` → `[REDIGIDO: AWS access key id]`, rc=9 ✔
- `API_KEY=[SECRET:UMBLER]` → intacto, rc=0 ✔ (respeita a convenção do projeto)
- `API_KEY=$UMBLER_KEY` → intacto, rc=0 ✔ (referência a env preservada)

## Por que fica de fora de qualquer política "sem shell"

**Perl não é shell.** Uma regra "sem shell" o deixa passar por definição — se a
intenção era reduzir linguagens, a regra erra o alvo; se a intenção era tirar quoting
frágil, ele já não tem esse problema.

## Por que portá-lo é a pior ideia das três

1. **É o mais rápido do repo**: 6.2 ms com todos os regexes; `perl -e ''` = 3.0 ms.
   Deno custaria 24 ms, Bun 16 ms, Python 21 ms. Portar **piora** 3-4x.
2. **É o único código de segurança.** A regra final é um regex `/x` de 20 linhas com
   lookbehind, dois lookaheads negativos aninhados e backreference `\3` para casar a
   aspa de abertura. Reescrever isso em JS esbarra em diferenças reais de engine
   (JS não tem `/x`; lookbehind de largura variável tem suporte distinto). **Um bug de
   port aqui não quebra o build — vaza credencial em silêncio.**
3. Perl 5.34 é **nativo do macOS** (`com.apple.perl`) — zero dependência.

Ver [[runtimes-disponibilidade]], [[hooks-startup-benchmark]].
