---
name: hooks-contrato-e-linguagem
description: Contrato de hook do Claude Code é agnóstico de linguagem — verificado rodando hooks Deno/TS e Python exec-form de verdade (CC 2.1.220)
metadata:
  type: reference
---

# Contrato de hook: nada exige shell

**Verificado em 2026-07-26, Claude Code 2.1.220, macOS 26.5.1 arm64.**

Testes rodados num projeto isolado no scratchpad (`projeto-teste-hook/`), com
`claude -p ... --debug-file`:

- Hook `UserPromptSubmit` com shebang `#!/usr/bin/env -S deno run --allow-read ...`
  (TypeScript puro, sem shell) → **rodou**, o `additionalContext` chegou ao modelo.
- Hook `PreToolUse` em **exec form** (`"command": "python3"`, `"args": [...]`) →
  **rodou** e o `permissionDecision: deny` foi honrado; o Write foi bloqueado.
- O debug confirma: `Successfully parsed and validated hook JSON output`.

## Schema (documentado, `_full.txt` linhas 65777-65796)

| campo | efeito |
|---|---|
| `command` | com `args`, é o **executável** a spawnar; sem `args`, é string passada a `sh -c` |
| `args` | presente → **exec form**, spawn direto, **sem shell nenhum** |
| `shell` | `"bash"`/`"powershell"`. **Ignorado quando `args` está setado** |

Não há nenhuma restrição de linguagem em lugar algum da doc. A doc oficial inclusive
aponta um exemplo de hook em Python (`bash_command_validator_example.py`, linha 23103).

O aviso de segurança (linha ~68510) diz "hooks execute shell commands with your full
user permissions" — é sobre **privilégio**, não sobre exigir shell.

Ver [[hooks-startup-benchmark]] para o custo de cada linguagem.
