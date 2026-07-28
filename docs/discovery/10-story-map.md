# User Story Map

**Cerimônia 8 do upstream** · Jeff Patton, via `acdg-skills`
**Entrada:** `09-corte-de-escopo.md` · `08-hipoteses.md`
**Saída:** as fatias que viram tickets da pipeline W0→W3

---

## O método, na fonte

> *"User story mapping é uma técnica de mapeamento que visa mostrar informações do
> backlog de produto de maneira descomplicada e visualmente acessível."*
> — *Gerenciamento de Requisitos de Software*, p. 136

E os níveis:

> *"Podemos definir as **atividades** como as ações principais que pessoas usuárias
> desejam executar. (…) essas atividades de alto nível **encabeçam** story maps (…)
> elencadas de maneira paralela, uma ao lado da outra."*

Aqui: **atividades** na horizontal (a jornada, em ordem narrativa) e **fatias** na
vertical (o que se constrói primeiro).

---

## A espinha dorsal

A jornada de um item, do anúncio ao gesto fechado. Lida da esquerda para a direita.

| A1 | A2 | A3 | A4 | A5 | A6 | A7 |
|---|---|---|---|---|---|---|
| **Chegar** | **Explorar** | **Publicar** | **Demonstrar interesse** | **Combinar** | **Registrar destino** | **Ver o que aconteceu** |

> ⚠️ **A5 acontece fora do sistema.** É o TORPEDO UNIFOR, por decisão do autor (H4).
> Está no mapa mesmo assim porque **o mapa é da jornada, não do software** — e deixar o
> vão visível é o ponto: é exatamente ali que o produto escolhe não estar, e é o trecho
> onde qualquer coisa pode dar errado sem que a gente saiba.

---

## Passos, por atividade

| | A1 Chegar | A2 Explorar | A3 Publicar | A4 Interesse | A5 Combinar | A6 Registrar | A7 Acompanhar |
|---|---|---|---|---|---|---|---|
| **Passos** | Ver a landing | Ver últimos itens | Abrir o formulário | Clicar "Tenho interesse" | *(fora)* Buscar o nome no TORPEDO | Ver quem se interessou | Abrir "Meus anúncios" |
| | Entender a proposta | Filtrar por categoria | Preencher título, descrição, categoria | Identificar-se, se ainda não | *(fora)* Mandar mensagem | Escolher quem levou | Ver estado de cada item |
| | Ver que há atividade | Abrir um item | Marcar doação ou preço | Ver o contato revelado | *(fora)* Combinar entrega | Marcar como entregue | Ver o destino registrado |
| | Instalar na tela inicial | | Colar URL da imagem | | | | |
| **Persona** | 3 *(suposta)* | 3 *(suposta)* | 1, 2 | 3 *(suposta)* | ambas | 1, 2 | 1, 2 |
| **Hipótese** | H3 | H3 | — | H4, H5 | H4 | **H1** | **H1, H2** |

**Onde o produto ganha ou perde:** A6 e A7 carregam H1 e H2 — as duas hipóteses que
sustentam o enquadramento. Todo o resto é infraestrutura para chegar até ali.

**E onde ele está mais exposto:** A4 e A5. Se o gate de interesse não for atravessado, ou
se o contato pelo TORPEDO não funcionar, A6 nunca acontece — e A6 é o produto.

---

## As fatias

### Fatia 0 — Esqueleto ambulante

**Nada de produto. Prova que a stack existe.**

| | |
|---|---|
| **Atravessa** | React → `fetch` → API F# → banco → resposta JSON na tela |
| **Entrega** | `GET /api/anuncios` devolvendo lista (vazia ou de seed), renderizada pelo front, tudo subindo por `docker compose up` |
| **Por que primeiro** | O ADR-0003 registra que o **`.NET` SDK não está instalado** e que a escolha do framework F# — Falco, Giraffe ou Minimal APIs — *"fica para a fatia vertical decidir"*. Essa é a fatia vertical |
| **Risco que remove** | O maior não-verificado técnico do projeto: que essa combinação suba junta |

Nenhuma feature do edital é cumprida aqui, e isso é intencional. Uma fatia que atravessa
raso vale mais que três camadas prontas que nunca se falaram.

### Fatia 1 — O obrigatório

**Tudo que o edital exige, e nada além.**

| Atividade | O que entra |
|---|---|
| A1 | Landing com proposta, vitrine dos últimos itens, CTA |
| A2 | Filtro por categoria |
| A3 | Formulário completo, `POST` com validação |
| A7 | "Meus anúncios" (listar os próprios) |
| — | `DELETE` de anúncio |
| — | PWA: `manifest.json` + Service Worker, instalável |
| — | Responsividade desktop ↔ mobile |

**Por que antes do diferencial:** escopo é o item #2 do ranking de risco, e o eixo 3
avalia *"funcionamento correto das rotas REST"* e *"cumprimento das diretrizes de
responsividade e PWA"*. Esta fatia é o que a nota cobra. Terminada, existe entrega
avaliável.

### Fatia 2 — O diferencial

**O enquadramento D. É o que separa a entrega de um CRUD.**

| Atividade | O que entra | Hipótese |
|---|---|---|
| A4 | "Tenho interesse" como gate — revela o contato a quem se identifica | H4 |
| A4 | Sessão por matrícula (`HttpOnly`, ADR-0003) | — |
| A6 | Lista de interessados; marcar entregue escolhendo entre eles | **H1** |
| A6 | Estado do item: disponível / entregue | H1, H3 |
| A7 | "Meus anúncios" mostrando o destino registrado | **H1, H2** |
| A1 | Atividade recente na vitrine | H3 |

**Ganha dois bônus do edital de passagem:** autenticação (linha 59) e tratamento de erros
com validação (linha 60).

### Fatia 3 — Bônus e acabamento

| O que entra | Origem |
|---|---|
| Escolher o que aparece no contato — nome, e-mail ou handle | **H5** — a hipótese com evidência mais direta, e a mais barata |
| Cache offline no Service Worker | bônus do edital |
| Feedback de carregamento, transições | bônus do edital |
| Deploy | *"fortíssimo diferencial"* |

> **H5 está na fatia 3 e é a hipótese mais bem sustentada do upstream.** A razão é de
> dependência, não de valor: ela pressupõe o contato existindo (fatia 2). Se a fatia 3
> não for inteiramente construída, **H5 é o primeiro item dela** — está registrado aqui
> para não virar sobra.

---

## O caminho mínimo até "o produto faz o que promete"

Fatia 0 → Fatia 1 → Fatia 2. Ao fim da fatia 2, a espinha dorsal está atravessada de
ponta a ponta e o pitch pode afirmar o que a demo mostra.

**Antes disso não pode.** Com só as fatias 0 e 1, o produto é uma vitrine de anúncios —
funcional, dentro do edital, e **sem responder ao problema que o discovery levantou**. O
vídeo, nesse caso, precisa dizer isso, e não "resolvemos a desconfiança" (preço aceito
nº 3 da cerimônia 3).

---

## O que este mapa deliberadamente não tem

| Ausente | Motivo |
|---|---|
| Uma raia para a Persona 3 | Ela é 🔴⚠ suposição pura. Dar-lhe raia própria seria tratá-la como as outras duas |
| A5 detalhada | Está fora do sistema por decisão. Detalhar seria fingir controle sobre o TORPEDO |
| Confirmação do recebedor | Cortado na cerimônia 7 — dependeria de B12.3, a suposição mais frágil |
| Estimativas | Não são variável deste projeto |

---

## Próximo passo

As fatias 0 a 3 são a matéria dos tickets da pipeline. Cada uma abre com critérios de
aceite derivados das hipóteses (cerimônia 10) — e são esses critérios que a **W0**
converte em testes que devem falhar pelo motivo certo.
