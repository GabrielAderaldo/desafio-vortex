---
name: produto-hipoteses-abertas
description: Hipóteses de produto levantadas em war rooms deste repo, com o sinal que as confirma ou refuta — consultar antes de reabrir o mesmo debate
metadata:
  type: project
---

Hipóteses no formato Lean UX cap. 3 levantadas em WAR ROOM. Cada uma traz o sinal
observável. **Ao reabrir o assunto, cheque primeiro se o sinal já apareceu.**

## 2026-07-26 — Linguagem dos scripts do harness (`.claude/hooks/*`, statusline)

Contexto do round: 3 arquivos `.sh` / 213 linhas, todos com contrato stdin-JSON →
stdout-JSON do Claude Code. Repo com **zero código de aplicação** na data. Runtime da
aplicação ainda não decidido.

- **H1 (teste de fumaça do harness)** — instrumentar cada script com fixture de entrada
  e saída esperada, *independente da linguagem*.
  Sinal: quebrar um hook de propósito faz `just check` falhar; e ao fim dos 15 dias
  `.ai-log/raw-prompts.md` não tem buraco de dias.
- **H2 (migrar os scripts para a linguagem da aplicação)** — só depois do runtime
  decidido.
  Sinal de verdade: o Gabriel altera um hook sozinho quando o protocolo mudar.
  **Sinal de refutação: se em 15 dias nenhum hook precisar de alteração, o custo de
  leitura que a migração pagaria nunca chegou.**
- **H3 (política "sem shell" vira regra com limite verificável)** — em vez de banimento.
  Sinal: nenhum arquivo do repo viola a regra publicada. Banimento total **já nasceria
  violado** pelas receitas `refs-vscode`/`refs-claude` do `Justfile` e pelo one-liner
  shell inline em `.claude/settings.json` (PostToolUse).

**Why:** o risco central do round era resolver com elegância a preferência do Gabriel
por linguagem, quando a dor verificável é outra — hook que falha **em silêncio** (todo
caminho de erro dos scripts termina em `exit 0` sem aviso), e a matéria-prima do diário
some sem ninguém notar.

**How to apply:** se alguém propuser de novo migrar/banir shell, peça primeiro o sinal
de H2. Ver [[projeto-quem-e-o-usuario]] antes de argumentar com "o avaliador".

## 2026-07-27 — Stack da aplicação (Dart/Darto + Mustache + HTMX/Alpine + SW em TS)

Contexto: dia 2 de 15, ainda **zero arquivo de aplicação** (`.dart`/`.ts`/`.html`
inexistentes; só `docs/`, `.claude/` e `.claude/settings.json`). README 100% template.

- **H1 (orçamento de conceitos do vídeo)** — o trecho 3:00–5:00 são 120 s para
  "arquitetura de pastas + rotas do backend + lógica do SW". Cada tecnologia visível
  divide esse orçamento.
  Sinal: **ensaio gravado do trecho, no dia 5, sem cortes e sem nota, dentro de 2 min.**
  Se estourar ou pular o SW, há conceito demais. Refutação limpa se ele gravar tranquilo.
- **H2 (anunciar sem cadastro)** — autenticação é **bônus** no edital, e o texto aceita
  "autenticado **ou identificado**" e "separação por IDs de usuário". Logo, tela de login
  antes do primeiro anúncio é escopo não pedido.
  Sinal: do ícone instalado até o item na vitrine em < 40 s narráveis, < 4 toques.
- **H3 (spike vertical timeboxado decide a stack)** — em vez de debate: formulário →
  persistência → item na vitrine, com prazo fechado.
  Sinal de refutação combinado **antes**: estourou o prazo, ou ele precisou aceitar código
  que não sabe explicar → troca para a stack que ele já defende, sem novo war room.

**Ponto de produto que ninguém tinha nomeado:** com HTMX quase não sobra "estado de
frontend", e o edital deixa escolher entre explicar o SW **ou** o estado. A escolha da
stack empurra 100% do peso de autoria para o **Service Worker** — ele vira a peça mais
importante a ser escrita à mão e entendida linha a linha.

**How to apply:** antes de reabrir "qual stack", peça o resultado de H3. Antes de propor
mais uma tecnologia (Turbo, OpenAPI spec-first, auth), diga de qual dos 120 s ela sai.
Ver [[usuario-gabriel-perfil]] para as anotações dele no edital.
