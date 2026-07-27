# Diário de Bordo da IA — episódios completos

Registro cru dos momentos em que a IA foi usada para destravar o desenvolvimento.
A versão curada (3 episódios) está na seção **Diário de Bordo da IA** do
[README principal](../../README.md).

A unidade de registro é o **episódio de destrave**, não o dia. Um dia sem nada
relevante não vira entrada; um dia com dois bugs difíceis vira dois arquivos.

## Índice

| # | Episódio | Data | Ferramenta | Houve erro da IA? |
|---|----------|------|------------|-------------------|
| [EP-001](EP-001-escolha-do-task-runner.md) | Escolher um task runner sem ter dado para decidir | 2026-07-26 | Claude Opus 5 via Claude Code | Parcial — escape de sintaxe errado na 1ª tentativa |
| [EP-002](EP-002-versao-do-compose-quase-corrigida-errado.md) | A IA quase me "corrigiu" com informação desatualizada | 2026-07-26 | Claude Opus 5 via Claude Code | **Sim** — versão do Compose desatualizada |
| [EP-003](EP-003-permissoes-do-agente-errado.md) | Documentei as permissões da ferramenta errada | 2026-07-26 | Claude Opus 5 via Claude Code | **Sim** — settings do Copilot num projeto sem Copilot |
| [EP-004](EP-004-o-portao-que-nao-fechava.md) | O portão que eu declarei testado três vezes e não fechava | 2026-07-26 | Claude Opus 5 + 4 subagentes (WAR ROOM) | **Sim** — 5 bugs, incluindo bypass da imutabilidade dos ADRs |
| [EP-005](EP-005-a-teoria-que-confirmou-a-pratica.md) | Quando a teoria confirma a prática em vez de corrigi-la | 2026-07-27 | Claude Opus 5 + MCP `acdg-skills` | Menor — bug de parser; e as lacunas foram declaradas, não preenchidas |

## Segredos nos prompts

Duas camadas, porque a primeira depende de você lembrar e a segunda não:

| Marcador | Efeito |
|----------|--------|
| `[SECRET:NOME]` | Convenção: você referencia a chave em vez de colar o valor. O Claude resolve de `~/.secrets` em runtime. Como o valor nunca entra no prompt, o log fica íntegro e legível |
| `[NOLOG]` | O prompt inteiro não é registrado — só um stub. Para quando você precisa mesmo colar um valor real |
| _(automático)_ | `redact-secrets.pl` varre todo prompt e troca credenciais reais por `[REDIGIDO]`, avisando na UI. Cobre o dia em que você esquecer os dois acima |

⚠️ A redação protege o **arquivo**, não o terminal nem o transcript da sessão. Se o
aviso de detecção aparecer, rotacione a chave.

## Como registrar um episódio

1. Todo prompt enviado ao Claude Code cai automaticamente em `.ai-log/raw-prompts.md`
   (via hook `UserPromptSubmit`, ver `.claude/hooks/ai-log-prompt.sh`). Esse arquivo
   não vai pro Git — é rascunho.
2. Quando algo travar e destravar, copie `_TEMPLATE.md` para `EP-00N-<slug>.md` e
   preencha puxando o prompt real do arquivo bruto.
3. Adicione a linha no índice acima.
4. Nos commits que nasceram daquele episódio, use o trailer:

   ```
   AI-Log: EP-003
   ```

   Assim `git log --grep="AI-Log"` liga o histórico do código ao diário.

5. **Commite o episódio no dia em que ele aconteceu.** Os timestamps dos commits
   são o que separa um diário mantido de um diário reconstruído na véspera.

## Transcripts completos

`transcripts/` guarda exports integrais de conversas longas (debate de
arquitetura, sessão de debug). Preferível a link público: não expira e o
avaliador não precisa sair do repositório.
