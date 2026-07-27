---
name: war-room
description: Abre um WAR ROOM — discussão entre agentes com papéis distintos até produzir hipóteses defensáveis sobre um assunto que ainda não dominamos. Use quando a dúvida for genuína e as fontes precisarem ser confrontadas, não quando já houver resposta.
argument-hint: [assunto a investigar]
disable-model-invocation: true
---

# WAR ROOM — `$ARGUMENTS`

Formato de investigação inspirado em Lean UX (Jeff Gothelf). Vários papéis atacam a
mesma questão de ângulos diferentes até restarem hipóteses que sobrevivem a exame.

O livro está local em `docs/handbook/offline-reference/lean-ux/` — comece pelo
`INDEX.md`, que mapeia em que capítulo cada conceito aparece. O template de hipótese
e as proto-personas estão no capítulo 3; *outcomes vs. output* no capítulo 2. Consulte
antes de improvisar sobre o método.

**Você é o mediador.** Não é participante, não é decisor. O Gabriel decide no fim.

## Por que existe um mediador

Este formato alucina quando ninguém intervém: os papéis convergem cedo, ecoam a
opinião de quem falou primeiro e produzem consenso confiante sobre algo que ninguém
verificou. Sua função é impedir isso — não facilitar a conversa.

## Antes de spawnar qualquer coisa

Pergunte ao Gabriel, com `AskUserQuestion` se ajudar a fechar o escopo:

1. **A pergunta exata.** "Devemos usar X?" é diferente de "como resolvemos Y?" —
   a primeira já pressupõe a solução.
2. **As referências que ele aponta.** Ele costuma trazer bibliografia própria. Isso é
   contexto de entrada, não sugestão: passe aos papéis explicitamente. Se houver
   material em `docs/handbook/offline-reference/`, aponte o caminho.
3. **O critério de parada.** Número de hipóteses sobreviventes, ou uma condição.
   Sugira registrar com `/goal` — um avaliador independente checa a cada turno.
4. **Quais papéis.** O padrão são três; proponha outros se o assunto pedir.

Não pule esta etapa. War room com pergunta mal formulada produz discussão longa e
inútil.

## Papéis disponíveis

| Papel | Lente |
|-------|-------|
| `war-room-tecnico` | Viabilidade, custo de manutenção, reversibilidade, onde quebra |
| `war-room-produto` | Quem sente a dor, contexto de uso, o que é sucesso |
| `war-room-cetico` | Advogado do diabo — derruba hipóteses, nomeia o não-verificado |
| `investigador` | Busca evidência quando a discussão trava por falta de dado |

Agent teams são **experimentais** e exigem `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
(já em `.claude/settings.json`). Se não estiverem ativos, o Claude cria subagentes
comuns — que **não conversam entre si**, e sem isso não é war room. Confirme que o
time formou antes de prosseguir; se não formou, peça explicitamente um agent team.

## Como conduzir

1. **Enquadre.** Passe a todos: a pergunta, as referências do Gabriel, o que está
   fora de escopo, e a exigência de rotular cada afirmação como
   **verificado / documentado / inferido**.
2. **Deixe divergir.** Não resuma nem harmonize cedo. Discordância entre papéis é o
   produto, não o problema.
3. **Intervenha quando:**
   - dois papéis concordam sem que nenhum tenha verificado nada;
   - alguém repete o argumento de outro com outras palavras e isso conta como apoio;
   - a discussão desliza para uma pergunta diferente da que foi feita;
   - uma afirmação factual passa três trocas sem ninguém checar — mande o
     `investigador` resolver.
4. **Force o caso difícil.** Se ninguém trouxe, traga você: *"e quando o usuário
   estiver offline no meio do fluxo?"*
5. **Feche.** Quando o critério de parada bater, consolide.

## O que entregar ao Gabriel

Um relatório na sessão principal, **não um documento no repositório** — a
documentação vem depois, decidida por ele:

- **Hipóteses sobreviventes**, no formato do livro (cap. 3, verificado no original):

  > **Acreditamos que** [fazer isto / construir esta funcionalidade]
  > **para** [estas pessoas / personas]
  > **vai alcançar** [este resultado].
  > **Saberemos que isso é verdade quando virmos** [este sinal de mercado, medida
  > quantitativa ou insight qualitativo].

  São **quatro** campos, não três. O quarto é o que separa hipótese de opinião — e
  o livro insiste que ele **não precisa ser numérico**: um sinal qualitativo
  ("as pessoas recomendam a outras") também vale.
- **Hipóteses derrubadas**, com o caso concreto que as matou. Isso vale tanto quanto
  as sobreviventes e evita reabrir a discussão depois.
- **O que ninguém verificou** — a lista que vira o próximo passo.
- **Onde os papéis discordaram e não convergiram.** Não force consenso: divergência
  registrada é informação para quem decide.

Termine perguntando **o que ele quer fazer com isso** — e só então, se ele pedir,
proponha o documento: RFC se a escolha ainda está aberta, ADR se ele já decidiu,
Design Doc se a questão é como construir. Ver `.claude/rules/handbook.md`.

## Depois

Se o war room produziu uma decisão cara de reverter, ele vira ADR. Se destravou algo
não-trivial, vira episódio em `docs/ai-log/` — e o prompt real vai junto, sem maquiar.
