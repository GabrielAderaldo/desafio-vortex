---
name: projeto-quem-e-o-usuario
description: Neste repo não há usuário final — os afetados são Gabriel, o avaliador do desafio e os agentes de IA; e os critérios do avaliador são desconhecidos
metadata:
  type: project
---

Nas decisões de ferramental/harness deste repositório **não existe usuário final**. Os
três afetados são:

1. **Gabriel** — mantém o repo sob prazo, ver [[usuario-gabriel-perfil]].
2. **O avaliador do desafio** — clona, lê e roda. Nunca conversou com o Gabriel. Seus
   primeiros minutos são `README.md`, a aplicação rodando, o `git log` e
   `docs/ai-log/` (o desafio pede diário de uso de IA).
3. **Agentes de IA** que operam no repo — leem `CLAUDE.md` como lei. Regra escrita que
   o código contradiz gera churn e hesitação.

**Buraco recorrente: o enunciado do desafio não está no repositório.** Sem ele, tudo o
que se afirma sobre o que o avaliador valoriza é **inferido**. Ninguém sabe se harness/
tooling sequer entra na nota. Duas fantasias simétricas a evitar: "o avaliador penaliza
bash" e "o avaliador admira hooks em TypeScript" — nenhuma tem apoio.

**Why:** o formato WAR ROOM existe para impedir solução elegante para problema que
ninguém tem; sem enunciado, o risco de inventar o usuário é máximo.

**How to apply:** antes de justificar qualquer decisão com "o avaliador vai perceber X",
rotule como inferido e diga o que faria a afirmação ser verificável. Se o enunciado
entrar no repo, atualize esta memória — ela deixa de ser válida.
