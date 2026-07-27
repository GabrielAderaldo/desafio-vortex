---
name: premissas-derrubadas-round-shell
description: Premissas que os papéis do war room afirmaram como verificadas e que não sobreviveram a teste
metadata:
  type: project
---

Afirmações feitas com rótulo "verificado" no round de 2026-07-26 que **não** se sustentaram.

**Why:** três papéis convergiram em "não migre agora" e a convergência foi tratada como
força da conclusão. Parte dela era a mesma premissa passando adiante sem exame.

**How to apply:** antes de aceitar um número ou um bloqueio institucional num round futuro,
checar se o comando foi rodado e se dois papéis não estão citando a mesma fonte.

- **"Bash é nativo, zero dependência."** Falso para o `bash`. `/bin/bash` é 3.2.57;
  `statusline.sh` quebra nele (`partes[*]: unbound variable`, array vazio sob `set -u`).
  Funciona no Mac do Gabriel só porque há um **bash 5.3.9 do brew** no PATH — que o
  CLAUDE.md global nem lista em `brew leaves`. Dependência real e não documentada.
- **"ADR-0001 é imutável e bloqueia automação em TS."** A RFC-0001 que fundamenta o ADR já
  autoriza o contrário, em duas passagens: `dax` "pode ser adotado *dentro* de um script
  sem conflito" e "para escrever os scripts de automação em TypeScript em vez de shell".
  Não há contradição a resolver nem supersessão a fazer.
- **"O avaliador é usuário imaginário."** É stakeholder documentado: ADR-0001 ("É um
  desafio técnico avaliado", "tanto para o avaliador quanto para o agente") e RFC-0001
  ("o avaliador do desafio clona o projeto e não sabe por onde começar"). O que **não**
  está no repo é o *enunciado* — coisa diferente.
- **"Migrar hoje escolheria o runtime pela porta dos fundos."** Já escolhido: há 387 linhas
  de Python em `scripts/`, contra 213 de bash, e o `Contexto` do ADR-0001 cita
  `python3 scripts/adr-index.py` como motivação. A pureza que o argumento protege não existe.
- **Números de latência conflitantes, ambos rotulados "verificado":** um papel reportou
  bash 35,4 ms vs deno 15,0 (2,4×); outro, bash 27,4 vs deno 25,1 (1,09×). Medição própria:
  ~22 ms. Ninguém cruzou.

Ver [[objecoes-encerradas-com-evidencia]] e [[defeitos-invariantes-de-linguagem]].
