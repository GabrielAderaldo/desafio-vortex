# RFC-000N — <título>

- **Status:** Rascunho | Em discussão | Aceito | Rejeitado | Adiado
- **Autor:** <nome>
- **Data:** AAAA-MM-DD
- **Discussão:** <link da issue/PR, se houver>
- **Resultado:** <ADR-000X — preencher quando a RFC fechar>

> Formato inspirado no [rust-lang/rfcs](https://github.com/rust-lang/rfcs). Uma RFC
> existe para **provocar objeção antes de você escrever código**. Se ninguém pode
> discordar do que está aqui, você não precisava de uma RFC — precisava de um ADR.

## Resumo

Um parágrafo. O que se propõe, sem justificativa. Se um colega ler só isto, ele
deve saber do que se trata.

## Motivação

Por que estamos fazendo isso? Que problema resolve? Qual é o custo de **não** fazer?

Seja concreto: "a tela de listagem trava com 500 itens" vale mais do que "melhorar
performance".

## Explicação didática

Explique a proposta como se explicaria para alguém que vai **usar** o resultado —
outro desenvolvedor entrando no projeto, ou o usuário final.

- Introduza conceitos novos com nome próprio.
- Mostre exemplos de uso, com código ou com fluxo de tela.
- Explique como isso muda o que já existe hoje.

Esta seção deve ser compreensível sem conhecimento profundo da implementação.

## Explicação técnica

Aqui vem o rigor. Detalhe suficiente para alguém implementar sem perguntar:

- Interação com as partes já existentes do sistema.
- Contratos de dados, assinaturas, formato de payload.
- Casos de borda — o que acontece com entrada inválida, concorrência, falha de rede.
- O que acontece na migração do estado atual para o proposto.

## Desvantagens

**Por que NÃO fazer isso?** Toda proposta tem custo: complexidade nova, dependência
nova, superfície de bug maior, curva de aprendizado.

Uma RFC sem esta seção preenchida não está pronta para discussão.

## Alternativas e justificativa

- Que outros desenhos foram considerados, e por que este ganhou?
- Qual é o impacto de simplesmente **não fazer nada**?
- Existe uma versão menor e mais barata disso que resolva 80% do problema?

## Precedentes

Outros projetos, linguagens ou produtos resolveram isso? Como? O que deu certo e o
que deu errado para eles? Link para o que você leu.

Precedente não é obrigação de seguir — é evidência de que o problema já foi pensado.

## Questões em aberto

O que esta RFC **deliberadamente não resolve** e deve ser decidido durante a
implementação ou numa RFC futura. Ser explícito aqui evita que a lacuna passe por
descuido.

## Possibilidades futuras

O que este desenho destrava, mas está fora de escopo agora. Ajuda a avaliar se a
proposta é um beco sem saída ou uma fundação.
