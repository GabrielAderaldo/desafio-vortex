---
name: hooks-falham-abertos
description: Hooks do Claude Code falham ABERTO — adr-guard.sh não protege nada se jq sumir ou se o JSON de saída quebrar; medido em 2026-07-26
metadata:
  type: project
---

**Hook que não emite decisão válida = ação PERMITIDA.** Documentado em
`docs/handbook/offline-reference/claude-code/_full.txt` linha 22670: *"Any other exit
code: the action proceeds."* Exit 0 + stdout vazio também é "allow".

Consequências **verificadas por teste** em `.claude/hooks/adr-guard.sh` (2026-07-26):

- **Sem `jq` no PATH** → o script emite stdout vazio, sai 0, e a edição num ADR
  `status: aceito` **passa em silêncio**. A guarda de imutabilidade some sem aviso.
  `jq` está em `/usr/bin/jq` (Apple, macOS) — mas **não** existe em container Debian/Alpine limpo.
- **JSON montado por interpolação de string** (`cat <<EOF`) quebra se um valor
  interpolado contiver `"`. Reproduzido com um ADR chamado `ADR-0009-a"b.md`:
  saída inválida → decisão descartada → fail-open. Barra invertida no nome **não** quebra.
- O caminho feliz está correto: `\n` sai escapado, JSON válido, `MultiEdit` é barrado.

**Why:** um portão de segurança que falha aberto é pior que nenhum portão, porque
gera confiança injustificada. O modo de falha é silencioso — ninguém percebe.

**How to apply:** qualquer hook de bloqueio novo (PreToolUse) precisa de (a) teste que
prove que ele **bloqueia**, não só que roda, e (b) teste do modo degradado (dependência
ausente). Se a saída for JSON, serializar com um serializador de verdade
(`JSON.stringify`, `json.dumps`), nunca com heredoc. Ver [[latencia-runtimes-m2]].
