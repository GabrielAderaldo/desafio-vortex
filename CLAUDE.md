# CLAUDE.md — Desafio Vortex

## Diário de Bordo da IA

Todo prompt enviado neste repo é registrado em `.ai-log/raw-prompts.md` pelo hook
`UserPromptSubmit` (`.claude/hooks/ai-log-prompt.sh`). O arquivo é gitignored — é
matéria-prima. Os episódios curados ficam em `docs/ai-log/` e esses sim vão pro Git.

Ao terminar algo que envolveu destravar um problema não-trivial com IA, ofereça
registrar o episódio a partir de `docs/ai-log/_TEMPLATE.md`. Não crie episódio por
conta própria para tarefa mecânica.

Commits nascidos de um episódio levam o trailer:

```
AI-Log: EP-00N
```

## Convenção de segredos

`[SECRET:NOME]` no prompt do Gabriel significa: **o valor existe no cofre, resolva
de lá em runtime.** Nunca peça o valor, nunca imprima, nunca cole em arquivo.

Exemplo — ele escreve:

> "chama o endpoint de DNS da Umbler usando a `[SECRET:UMBLER_API_KEY]`"

O que fazer:

- Referenciar como `$UMBLER_API_KEY` no código/comando, lendo do ambiente.
- Se não estiver carregada, dizer qual variável falta — nunca sugerir colar o valor
  no chat. As fontes são `~/.secrets/.secrets`, `~/.config/secrets/.secrets.toml` e
  o cofre `sops`/`age` (ver `~/Desktop/Projetos/GUIA-SEGREDOS-SOPS-AGE.md`).
- Se precisar que ele rode algo que exponha a chave, pedir que ele mesmo execute com
  o prefixo `!` no prompt, em vez de você ler o valor.

`[NOLOG]` em qualquer posição do prompt faz o hook não registrar aquele prompt.
Usado quando ele precisa mesmo colar um valor real (ex: debugar por que um token
específico está sendo rejeitado).

Se um segredo real escapar, `redact-secrets.pl` substitui por `[REDIGIDO]` no log e
avisa na UI. Isso protege o arquivo, **não** o terminal nem o transcript da sessão —
nesse caso, recomende rotacionar a chave.
