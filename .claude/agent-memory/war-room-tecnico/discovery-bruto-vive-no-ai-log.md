---
name: discovery-bruto-vive-no-ai-log
description: Respostas de discovery podem estar só em .ai-log/raw-prompts.md (gitignorado) — grep no arquivo de respostas não prova ausência
metadata:
  type: reference
---

`docs/discovery/01-questionario-proto-personas_respostas.md` contém **só P01, P02 e P03**.
As respostas de **P04 (o autor)** estão em `.ai-log/raw-prompts.md`, linhas 740-758, entradas
de **2026-07-27 23:28 e 23:29** — as 10 perguntas respondidas. `verificado`.

**Why:** em 2026-07-27 eu e o papel `produto` rodamos o mesmo grep no arquivo de respostas,
vimos o mesmo vazio, e ambos concluímos "sem fonte auditável". Errado — o hook `UserPromptSubmit`
grava todo prompt no log bruto, que é **gitignorado** e por isso invisível a `git ls-files` e a
qualquer busca restrita a arquivos versionados. Dois papéis, a mesma inferência barata de checar,
ninguém checou. É o padrão do [[EP-006]] com outro objeto.

**How to apply:** antes de afirmar que um dado de discovery não tem fonte, **grepar
`.ai-log/raw-prompts.md`**. "Não está no arquivo esperado" ≠ "não existe".

**Armadilha ao citar:** as citações da síntese foram **normalizadas ortograficamente** em
relação ao log — o bruto tem `"MUITO dificil"` (sem acento) e `"pessoal de mais"` (separado);
a síntese grafa `"MUITO difícil"` e `"pessoal demais"`. Por isso `grep` da string da síntese
devolve zero. Buscar por fragmento frouxo, e lembrar que
`.claude/rules/diario-de-bordo.md` exige o bruto **"inteiro, sem maquiar"**.
