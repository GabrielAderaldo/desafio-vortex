# EP-009 — O upstream fechado, e o que os especialistas pegaram que eu não vi

**Data:** 2026-07-28
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code · dois agentes especialistas criados neste episódio · MCPs `acdg-skills` (domínios `ddd`, `architecture`, `design-ux-ui`) e Figma · skills `design:*` da Anthropic
**Relacionado:** EP-008 · ADR-0004
**Entregável:** o upstream inteiro — 18 cerimônias, dois ADRs, o PRD, a modelagem de domínio, os wireflows, e o repositório público

## Contexto

O EP-008 terminou com o enquadramento corrigido: o produto existe para agregar o
estudante ao ecossistema da universidade, e o item é o pretexto do encontro. Faltava
transformar isso em modelo, telas e critérios.

Este episódio cobre esse trecho. Ele produziu mais correções ao meu próprio trabalho do
que qualquer outro — e todas vieram de alguém **abrir o arquivo e conferir**, nunca de
alguém pensar mais.

## O prompt

O que mudou o método:

~~~
Aqui vamos começar a chamar especialistas, para isso: Vamos criar um Agente chamado: Especialista de dominio. O papel dele é saber tudo de como funciona -> DDD, Documento de Requisitos, Problema do Usuario a nivel de sistema e ter uma ideia de computação distribuida e banco de dados... para poder pensar e responder:
-> (modelagem de domínio — bounded contexts, agregados, eventos...etc, ele deve ser o maior seguidor do evans que existe)
~~~

E o que resolveu um impasse de três rodadas, escrito como observação numa resposta de
pergunta:

~~~
Aqui não precisa ser estádos binários, cria um estádo transitorio... pois isso demonstra quem tbm queria que pode ser que mude a situação, mas ai vira uma espera insegura (Como um Ricchi), no Majong.
~~~

> ✅ **Esta citação está no log — e não estaria uma semana atrás.** O EP-008 registrou que
> o hook `UserPromptSubmit` não observa respostas de `AskUserQuestion`, e que por isso a
> intervenção mais decisiva do projeto tinha se perdido. O hook novo, com matcher
> `PostToolUse`, capturou esta e as demais. **A lacuna foi fechada a tempo de registrar o
> episódio seguinte.**

## O que a IA fez

Dois agentes novos, ambos com memória de projeto e com uma regra em comum: **proibido
afirmar de memória**. O de domínio cita Evans e Vernon pelo MCP com página; o de UX cita
Krug, Lowdermilk, Levy, Greever e Tamosauskas — e o Gabriel estava certo ao suspeitar
que existia material de UX no `acdg-skills`: havia um domínio inteiro, `design-ux-ui`,
com cinco obras que ninguém tinha aberto.

Deles saíram a modelagem de domínio, as decisões de interação, os wireflows e o guia de
mensagens de erro. Depois, os artefatos foram montados no Figma e exportados como
snapshot versionado, e o repositório foi publicado.

## Onde quebrou

**Quatro erros meus, e três foram pegos por outra pessoa.**

**1. Eu criei uma contradição e não conferi.** Ao reescrever os critérios de aceite,
adicionei *"É possível registrar interesse em item reservado"* sem checar contra o modelo
de domínio, que dizia o oposto. Três documentos passaram a discordar. O especialista de
UX encontrou, cedeu a versão dele para a minha — **e o argumento que ele usou era melhor
que o meu**: quem vê "já tem alguém" e quer mesmo assim é exatamente quem se beneficia se
a reserva cair. A decisão certa foi tomada por acidente, e só ficou certa porque alguém
conferiu.

**2. Recomendei o oposto do certo sobre apagar interesse.** Quando o Gabriel perguntou se
desistir da reserva deveria apagar o interesse, recomendei que sim — pensando só no caso
de quem desiste. O especialista de UX corrigiu com o caso que eu não tinha considerado:
**quem desfaz pode ser quem publicou**, e apagar automaticamente o faria excluir alguém
da própria lista sem querer.

**3. Criei uma convenção implícita e depois dependi dela.** No Figma, nomeei as setas de
um wireflow como `→` e as dos seguintes como `seta`. Um script que separava telas de
setas pelo nome tratou as três primeiras como telas e as esticou. **O erro não foi de
API — foi de ter guardado informação estrutural num campo de exibição.**

**4. Duas armadilhas da API do Figma**, ambas custando um ciclo: `resize()` depois de
`textAutoResize` anula o modo, e os textos ficaram travados em 10 pixels de altura,
sobrepostos; e `counterAxisAlignItems` não aceita `STRETCH`. A segunda abortou o script
inteiro — mas as escritas são atômicas, então nada ficou pela metade.

**E um erro do harness que só apareceu porque ele disse:** montei quatro perguntas com
cenários de 25 linhas cada, dentro do campo `preview` do `AskUserQuestion`. Ele respondeu
*"Eu não consegui ler os exemplos, estava cortado nas opções"*. Eu tinha escrito o
material que ele pediu e entregado num lugar onde ele não cabia.

## Como eu conduzi

**Criei papéis em vez de pedir respostas.** Em vez de perguntar "modele o domínio", pedi
um agente que fosse *"o maior seguidor do Evans que existe"* — e depois um de UX. A
diferença é que o papel carrega obrigações: fonte citada, rótulo de confiança, e o que
não é dele decidir.

**Dei ao especialista de domínio uma lista fechada do que eu queria** — subdomínios
classificados, bounded contexts com fronteiras, context map com as ligações
classificadas, e **legenda obrigatória com referência**. Sem a legenda, o mapa seria um
diagrama que só quem já sabe DDD lê.

**Trouxe a analogia que destravou o ciclo.** A discussão sobre desmarcar um destino
estava presa em sim-ou-não. O Riichi do Mahjong — uma declaração pública e irreversível
que muda o comportamento dos outros jogadores e ainda assim pode não dar certo — deu o
estado transitório que faltava, e de quebra resolveu um problema que o war room anterior
tinha deixado em aberto: como avisar os outros interessados sem notificação. **Eles veem
o selo.**

**E propus o código de confirmação**, que é o que fez o sistema deixar de ser cego:

~~~
E se implementar um sistema de codigo aleatorio? Como se fosse chave valor? Foi reservado, na hora da transação, é gerado um codigo que a pessoa A entrega para a pessoa B, sendo essa a chave da transição do estádo
~~~

**Recusei duas propostas da IA por serem caras demais para o que resolvem.** O sistema de
advertência e banimento morreu quando ficou claro que banir uma identidade auto-declarada
é banir uma string. E o "adiar com os dois concordando" morreu porque exigia que a pessoa
com menos motivo do mundo voltasse ao app.

## O que ficou

**Toda correção deste episódio veio de conferência, não de reflexão.** A contradição que
criei, o argumento que eu tinha errado, a convenção implícita — nenhuma foi pega por
alguém pensando com mais cuidado. Foram pegas por alguém abrindo o arquivo e comparando.
É a mesma lição do EP-007, e ela reaparece porque o modo de falha não é falta de
inteligência: **é confiar na memória do que se escreveu.**

**Especialista com fonte obrigatória entrega diferente de especialista sem.** O de
domínio recusou inflar o modelo — entregou dois bounded contexts quando era fácil
entregar sete — e se recusou a propor um ADR novo pela imprecisão de um verbo, com a
justificativa de que *"rigor que não muda decisão é desperdício"*. Isso não é uma
qualidade do modelo; é uma qualidade do prompt que o definiu.

**O melhor argumento do episódio veio de fora da tecnologia.** O Riichi resolveu em uma
frase o que três rodadas de análise não tinham resolvido. Nenhum dos livros de DDD, UX ou
requisitos tinha esse padrão — e ele descreve exatamente o mecanismo: compromisso
público, irreversível, que muda o comportamento de quem está em volta e ainda assim pode
falhar.

**E o hook do episódio anterior pagou-se no episódio seguinte.** O EP-008 terminou
registrando que o diário perdia as respostas dadas por um caminho específico. As duas
citações mais importantes deste episódio entraram por esse caminho — e estão no log
porque a lacuna foi fechada antes, não depois.
