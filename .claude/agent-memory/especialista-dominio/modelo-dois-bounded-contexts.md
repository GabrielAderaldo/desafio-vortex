---
name: modelo-dois-bounded-contexts
description: Passa Adiante tem dois bounded contexts (Passa Adiante e Identidade Declarada) — a razão que sustenta o split e os contextos que eu propus e descartei
metadata:
  type: project
---

O domínio do Passa Adiante tem **dois** bounded contexts, não mais. Modelado em
`docs/discovery/17-modelagem-de-dominio.md` (cerimônia 15, 2026-07-28).

- **BC-1 · Passa Adiante** — Core. Anúncio, Interesse, Destino, e a Vitrine (Generic) dentro.
- **BC-2 · Identidade Declarada** — Supporting. Pessoa, ContatoPúblico.
- Relação: **Customer-Supplier** com BC-2 como Supplier (upstream) expondo um **Open Host
  Service**. BC-1 pode depender de BC-2; **BC-2 nunca pode depender de `Anúncio`.**

**Why:** a razão linguística (a palavra *pessoa* muda de significado ao cruzar a linha) é
verdadeira mas fraca sozinha. A razão que decide é a **porta**: a política da UNIFOR é
centralizar no Unifor Online. No dia em que a identidade vier de lá, BC-2 inteiro é
substituído por um ACL e **BC-1 não é tocado**. Fundir `Pessoa` em `Anúncio` transformaria
essa troca em reescrita. O mesmo vale para a expansão declarada (monitoria, carona,
resumo): todos precisam de identidade, nenhum precisa de anúncio.

**How to apply:** o custo de manter o split hoje é zero — é limite de módulo num
código-base só. Se alguém propuser fundir os dois "porque é um projeto pequeno", a resposta
é a porta, não a pureza.

**Onde a reputação moraria, se um dia existir (hoje fora de escopo — `09-corte:90`):**
num **BC-3 · Confiança**, novo, downstream de BC-1. **Nunca dentro de BC-2** — reputação lá
faria `Pessoa` depender de `Anúncio` e fecharia a porta do Unifor Online, que é a única
razão do split. A fronteira de hoje **não fecha essa porta e nada precisa mudar agora**;
o que a tornou transitável foi o código de confirmação, que produz um evento de troca
concluída que **um lado só não consegue forjar**. Ver [[corroboracao-nao-e-presenca]] e
`17-modelagem-de-dominio.md` §9.1.

**Contextos que propus e descartei — não os traga de volta sem argumento novo:**

- **Vitrine pública × Meus anúncios como contextos separados.** É a mesma `Anúncio` com a
  mesma invariante, vista por duas projeções com autorizações diferentes (D3). **Leitura é
  projeção e nunca define agregado nem contexto.** É a falsa fronteira mais tentadora deste
  produto.
- **Locais de Encontro como bounded context.** Hoje `data/locais-campus.toml` não tem
  invariante que o software garanta, nem ciclo de vida dentro do software. Sem invariante
  não há agregado. É **Published Language** consumido em **Conformist**. A invariante em
  espera está no próprio arquivo (linhas 16-19): no dia em que locais puderem ser sugeridos
  por quem publica, `Local` ganha ciclo de vida e aí nasce o contexto.
- **Doação × Venda**, **Onboarding do calouro**, **Estatísticas** — nenhum tem termo
  próprio, invariante ou estado.

Ver [[observa-o-ato-nunca-o-fato]] e [[agregado-anuncio-contem-interesse]].
