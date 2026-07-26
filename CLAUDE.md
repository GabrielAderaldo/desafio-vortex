# CLAUDE.md — Desafio Vortex

## Tarefas

Toda tarefa repetitiva do repositório é uma receita no `Justfile`. Use `just --list`
para descobrir o que existe — não invente comandos soltos nem os documente fora dali.

- `just check` é o **portão de verificação**: rode antes de considerar um trabalho
  pronto, e mostre a saída em vez de afirmar que passou.
- Ao escrever receita com `docker --format`, dobre **só a abertura** das chaves:
  `{{{{.Name}}`. É a colisão conhecida entre `just` e Go templates (ver ADR-0001).

## Handbook

A documentação de engenharia vive em `docs/handbook/`, com um guia de uso em
`docs/handbook/README.md`. Cada tipo tem seu `_TEMPLATE.md` — use o template, não
invente formato novo.

Resumo de qual usar: **PRD** (o quê/para quem) · **RFC** (proposta em debate) ·
**Design Doc** (como construir) · **ADR** (por que decidimos X) · **Runbook** (o que
fazer quando quebra) · **diagrams** (Mermaid).

Regras que não se quebram:

- **ADR fechado é imutável — nunca editar, nunca apagar.** Decisão mudou? ADR novo,
  número novo, com `substitui: [ADR-000X]`. No antigo, alteram-se **apenas** dois
  campos: `status: substituido` e `substituido_por`. Nem digitação se corrige.
  Se receber pedido para editar ou remover um ADR fechado, não execute — proponha o
  ADR substituto.
- **Todo ADR carrega o front-matter YAML do template**, preenchido. Os ADRs são a
  memória durável do projeto e a base de RAG/vetorização: `tags`, `componentes`,
  `substitui`, `substituido_por` e `ai_log` não são decoração.
- Numeração é sequencial e **nunca reaproveitada**, mesmo para documento rejeitado.
- `offline-reference/` e `_drafts/` têm o conteúdo gitignorado — as pastas existem
  por `.gitkeep`. Nunca force `git add` de conteúdo delas.
- Diagrama é bloco Mermaid em Markdown, **não** imagem exportada.
- `adr/INDEX.md` é **gerado** por `scripts/adr-index.py` — nunca edite à mão. Um hook
  `PostToolUse` o regenera a cada ADR escrito.

A imutabilidade é imposta pelo hook `.claude/hooks/adr-guard.sh` (`PreToolUse`): a
escrita em ADR fechado é recusada pela própria ferramenta. Se isso acontecer, não
tente contornar — crie o ADR substituto.

Ao concluir algo que envolveu uma decisão cara de reverter (banco, estratégia de
sincronização, modelo de autenticação), ofereça registrar o ADR. Não crie documento
por conta própria para escolha trivial — handbook inflado custa tempo e não informa.

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
