---
name: referencia-por-identificador-nao-por-linha
description: Referência a documento vivo do discovery cita identificador (D3, I11, U2), nunca arquivo:linha — as linhas envelhecem em horas neste repo
metadata:
  type: project
---

**Citar `arquivo:linha` de documento do `docs/discovery/` que ainda está sendo reescrito
produz ponteiro morto em horas.** Verificado em 2026-07-28: `18-decisoes-de-interacao.md`
foi escrito às 05:58; `12-historias-e-criterios-de-aceite.md` v2 (06:12) e `PRD-0001`
(06:13) mudaram depois, e **quatro referências de `18` deixaram de apontar para o que
dizem** — `PRD-0001:109`→`120`, `PRD-0001:111`→`122`, `17:727`→`726`, `12:60-66`→`12:35`.
Registrado como `W-7` em `20-wireflows-e-mensagens.md`.

**Why:** este projeto trata citação não-localizável como defeito real, não cosmético —
`02-sintese-questionario.md:304-315` adotou a regra de citação depois de dois analistas
independentes buscarem strings publicadas e receberem zero resultados. Ponteiro errado tem
o mesmo efeito e é mais fácil de produzir.

**How to apply:**

- **Documento vivo** (discovery, PRD em revisão) → cite o **identificador**: `D3`, `I11`,
  `H-08`, `U2`, `C6`, ou o nome da seção.
- **Arquivo estável** (ADR fechado, `data/locais-campus.toml`, edital) → linha vale.
- Antes de reusar referência de documento anterior meu, **rode `sed -n 'Np' arquivo`** e
  confira. Levou 30 segundos e achou quatro erros.
- Ao encontrar ponteiro morto em documento aprovado, **não corrija o documento** — registre
  a correção no documento novo. `18` foi aprovado como está.

Ver [[fluxo-que-nao-sobreviveu-interesse-em-reservado]].
