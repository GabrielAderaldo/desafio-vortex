# RFC-0002 — `AGENTS.md` para múltiplas ferramentas de IA

- **Status:** Adiado
- **Autor:** Gabriel Vieira Soriano Aderaldo
- **Data:** 2026-07-26
- **Discussão:** —
- **Resultado:** —

> **Placeholder deliberado.** Registrado para não se perder, não para ser decidido
> agora. As seções de explicação técnica, desvantagens e precedentes ficam vazias de
> propósito: preenchê-las antes de haver necessidade seria inventar conteúdo.

## Resumo

Adotar um `AGENTS.md` na raiz — o formato que várias ferramentas de IA leem — para
que instruções de projeto valham além do Claude Code.

## Motivação

Hoje as instruções vivem em `CLAUDE.md` e `.claude/rules/`. Isso cobre o Claude Code
e, por compatibilidade declarada, o VS Code. Não cobre outras ferramentas.

## O que já está verificado

| Fato | Como se sabe |
|------|--------------|
| O VS Code lê `AGENTS.md` na raiz e em subpastas (experimental) | Documentado — `chat.useAgentsMdFile` |
| O VS Code **já lê** `CLAUDE.md` e `.claude/rules/` com `paths` | Documentado, e confirmado por teste em 2026-07-26 |
| O Kimi está instalado nesta máquina | Verificado — `~/.kimi-code/bin/kimi`, 253 MB, no PATH do zsh e do fish |
| **Se o Kimi lê `AGENTS.md`** | ❌ **não verificado** — é a pergunta que decide esta RFC |

## Por que está adiado

Enquanto o Claude Code for o único harness em uso, `AGENTS.md` não entrega nada: o
VS Code já lê o `CLAUDE.md` diretamente, e não há terceira ferramenta consumindo
instruções neste projeto.

O custo de adotar cedo é concreto: mais um arquivo na raiz e **duas fontes de verdade
que divergem em silêncio**. Um `AGENTS.md` desatualizado é pior que nenhum, porque
uma ferramenta passa a operar sob regra antiga sem ninguém perceber.

## Gatilho para reabrir

Qualquer um destes reabre a discussão:

1. **O Kimi passar a ser usado de fato neste projeto** — e se confirmar que lê
   `AGENTS.md`. A verificação é barata: criar um `AGENTS.md` com uma instrução
   inequívoca e perguntar algo que só ela responde, como foi feito para testar a
   extensão do VS Code.
2. Entrar uma terceira ferramenta de IA no fluxo.
3. O suporte a `CLAUDE.md` do VS Code ser descontinuado.

## Alternativas e justificativa

- **Não fazer nada** (posição atual): zero custo, e o VS Code já está coberto.
- **`AGENTS.md` como arquivo fino** que apenas aponta para o `CLAUDE.md` em vez de
  duplicar conteúdo — evita divergência, mas depende de a ferramenta seguir o
  ponteiro, o que não foi verificado em nenhuma.
- **Migrar tudo para `AGENTS.md`** e deixar o `CLAUDE.md` como ponteiro — inverteria
  a fonte de verdade para um formato menos específico, perdendo o que é próprio do
  Claude Code.

## Questões em aberto

- O Kimi lê `AGENTS.md`? E `CLAUDE.md`?
- Se lê os dois, qual tem precedência?
- Um `AGENTS.md` que só contém `Ver @CLAUDE.md` funciona, ou as ferramentas esperam
  conteúdo literal?
