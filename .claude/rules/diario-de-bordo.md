# Diário de Bordo da IA

Todo prompt enviado neste repo é registrado em `.ai-log/raw-prompts.md` pelo hook
`UserPromptSubmit` (`.claude/hooks/ai-log-prompt.sh`). O arquivo é gitignored — é
matéria-prima. Os episódios curados ficam em `docs/ai-log/` e esses sim vão pro Git.

Ao terminar algo que envolveu destravar um problema não-trivial com IA, ofereça
registrar o episódio a partir de `docs/ai-log/_TEMPLATE.md`. Não crie episódio por
conta própria para tarefa mecânica.

O prompt no episódio é **copiado do arquivo bruto, inteiro, sem maquiar**. Um diário
com prompts reescritos para parecerem melhores não serve para nada.

**Registre também quando a IA erra.** A seção de reflexão crítica do README pede um
caso concreto e verificável — o sintoma que denunciou o erro, e a correção de rumo.
Episódio em que a IA nunca erra não convence ninguém que já usou uma.

Commits nascidos de um episódio levam o trailer:

```
AI-Log: EP-00N
```
