---
id: ADR-000N
titulo: <título curto no imperativo — "Usar PostgreSQL como banco primário">
status: proposto            # proposto | aceito | rejeitado | descontinuado | substituido
data: AAAA-MM-DD            # data da decisão, não da última edição
decisores: [Gabriel Aderaldo]
tags: []                    # [persistencia, offline, autenticacao, build]
componentes: []             # [api, web, contratos, infra]
substitui: []               # [ADR-0003] — decisões que esta torna obsoletas
substituido_por: null       # ADR-0009 — preenchido QUANDO for superado
relacionados: []            # [RFC-0002, DD-0001, PRD-0001]
ai_log: []                  # [EP-003] — episódios do Diário de Bordo que originaram isto
---

# ADR-000N — <título>

> Formato de Michael Nygard. O front-matter acima é **obrigatório** e existe para
> tornar este arquivo legível por máquina — ver "Por que os metadados" no fim.

## Contexto

Qual força está em jogo? Descreva a situação **neutra e factualmente** — restrições
técnicas, prazo, time, o que já existe no sistema, requisito do desafio. Quem ler
daqui a seis meses precisa entender a pressão do momento sem ter estado lá.

Escreva no presente ("o app precisa funcionar offline"), não no futuro condicional.
Não defenda a decisão aqui — isso é a próxima seção.

## Decisão

O que foi decidido, em voz ativa e afirmativa:

> "Vamos usar X."

Uma frase. Se precisar de três parágrafos para dizer o que foi decidido, ou a
decisão não está madura, ou são várias decisões e cada uma merece seu ADR.

## Consequências

O que passa a ser verdade depois desta decisão — **boas e ruins, sem maquiar.** Um
ADR que só lista vantagens não foi uma decisão, foi uma justificativa.

### Positivas

- <o que fica mais fácil / mais rápido / mais seguro>

### Negativas

- <o que fica mais difícil, mais caro, ou que dívida técnica isso cria>

### Neutras

- <o que muda sem ser claramente melhor ou pior: novo conceito no time, nova dependência>

## Alternativas consideradas

| Alternativa | Por que não |
|-------------|-------------|
| <opção B> | <motivo honesto — "não conheço bem" é motivo válido e comum> |
| <opção C> | <...> |

Não invente alternativas para parecer rigoroso. Liste as que você de fato pesou.

## Implicações para o código

Como esta decisão se manifesta na prática. É a seção que transforma o ADR de registro
histórico em **regra ativa** — e a que mais rende quando um agente de IA lê o handbook
antes de escrever código.

- **Passa a valer:** <padrão, convenção ou biblioteca que agora é o caminho certo>
- **Deixa de valer:** <o que não se deve mais fazer, mesmo que ainda exista no código>
- **Onde isso aparece:** <caminhos, módulos ou camadas afetadas>

---

## Por que os metadados

Este handbook trata os ADRs como **memória de longo prazo** do projeto, legível por
pessoas e por máquina. O front-matter é o que permite, sem reprocessar nada depois:

| Uso | O que o campo habilita |
|-----|------------------------|
| Recuperação por assunto | `tags` e `componentes` filtram antes de qualquer busca semântica — reduz ruído em RAG |
| Grafo de decisões | `substitui` / `substituido_por` reconstroem a linha do tempo de como o projeto mudou de ideia |
| Rastreamento de causa | Ao investigar um bug, `componentes` leva direto às decisões que moldaram aquela área |
| Auditoria de processo | `ai_log` cruza a decisão com o episódio de IA que a originou |
| Vetorização | Metadados viram *payload* junto ao embedding; sem eles o chunk perde procedência |

Por isso o campo `status` é o **único** que se edita num ADR aceito. Todo o resto é
imutável: um ADR editado retroativamente corrompe o histórico exatamente na parte que
o torna útil — o raciocínio de quem decidiu com a informação que tinha na época.
