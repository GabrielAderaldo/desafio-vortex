---
name: enquadramento-do-mediador
description: O enquadramento inicial do round costuma carregar o erro que todos os papéis herdam — checá-lo primeiro
metadata:
  type: feedback
---

Antes de atacar as hipóteses dos outros papéis, atacar o **enunciado do round**.

**Why:** em 2026-07-26 o mediador abriu com "3 arquivos .sh, 213 linhas". Os três papéis
corrigiram a contagem e nenhum questionou o *verbo*. A pergunta do Gabriel era
"quero banir o `.sh` **deste projeto em tudo**... podemos usar o Justfile no lugar?" —
uma regra prospectiva num repo com zero linha de aplicação, mais a menção a config de
**VS Code**, que não existe no repo. Todos os três precificaram uma **migração** de código
já escrito. Custo de migração é irrelevante para uma regra de "não escrever mais".

**How to apply:** em todo round, separar explicitamente três perguntas que se disfarçam
de uma: (a) o que fazer com o código que já existe, (b) que regra vale para o código que
ainda não existe, (c) qual palavra está sendo usada de forma ambígua. Aqui, "banir o `.sh`"
pode ser a *extensão de arquivo* (barato, deixa os blocos `#!/usr/bin/env bash` do Justfile
de pé) ou a *execução de shell* (mata o `just`, que despacha via `sh -cu`). Ninguém
perguntou qual, e as duas leituras têm custos opostos.

Ver [[premissas-derrubadas-round-shell]].
