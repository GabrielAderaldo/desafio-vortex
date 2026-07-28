---
name: contradicoes-abertas-do-modelo
description: As treze contradições que a modelagem de domínio encontrou nos documentos do Passa Adiante — quais foram decididas, quais continuam abertas, todas com arquivo e linha
metadata:
  type: project
---

Detalhadas em `docs/discovery/17-modelagem-de-dominio.md` §10. **Verifique o status antes
de recomendar qualquer coisa a partir daqui** — C1, C2, C4 e C6 mudaram em 2026-07-28.

## Resolvidas pelas decisões de 2026-07-28

| # | Assunto | Como fechou |
|---|---|---|
| **C1** | Locais sem critério de aceite | 🟡 **meio.** Modelo resolvido (perfil como padrão, ajustável por anúncio — ratifica `16:84`). **Critério de aceite continua faltando e continua bloqueando W0** |
| **C2** | Matrícula em cinco documentos | 🟢 some inteira. Resta corrigir os cinco arquivos, sendo `12:286` o urgente (é critério de aceite) |
| **C4** | `Entregue` mente | 🟢 morreu junto com o estado binário |
| **C6** | Destino registrado por engano | 🟢 `ReservaDesfeita` é o caminho de volta |

## Novas, e as três primeiras são contra documento aprovado

| # | Contradição | Arquivo:linha |
|---|---|---|
| **C8** | **Confirmação bilateral está cortada** — e o ciclo de reserva a constrói | `PRD-0001:104-106`, `09-corte-de-escopo.md:93` |
| **C11** | *"Não há fila automática **nem reserva**"* e *"continua disponível"* | `PRD-0001:152`, `PRD-0001:153` |
| **C12** | Risco de múltiplas identidades aceito *"porque não existe (…) **limite por pessoa**"* — e agora existe | `16-modelo-de-dados-por-perfil.md:171` |
| **C9** | Desistir da reserva retira o `Interesse`? | não escrito em lugar nenhum |
| **C10** | `DestinoConfirmado` é terminal? | idem. Recomendo sim |
| **C13** | Anúncio reservado sai da vitrine ou fica com selo? | `12:233` × `12:100`. Recomendo ficar com selo |

## Continuam abertas de antes

**C3** (curso e semestre sem consumidor) · **C5** (vitrine viva × anúncio que não expira —
**agravada**: agora a reserva também não expira, e item reservado é pior que item parado) ·
**C7** (`ADR-0004:112`, ambiguidade de "confirma" — **e agora proponho ADR novo para o
ciclo de reserva**, não substituto do 0004).

**Why:** o repositório impõe que ADR aceito não se edita e que trabalho alheio não se
reverte sem consultar. Apontar com arquivo e linha, e parar aí, é o comportamento correto.

**How to apply:** o que bloqueia W0 de verdade hoje é **C1 (metade que falta), C8, C9,
C10 e C13** — as três últimas viram teste em qualquer resposta. C3, C5 e C7 não bloqueiam e
não devem ser reapresentadas a cada sessão.
