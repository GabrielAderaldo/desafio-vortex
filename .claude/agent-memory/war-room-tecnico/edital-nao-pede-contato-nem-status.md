---
name: edital-nao-pede-contato-nem-status
description: O edital não menciona contato/chat entre usuários nem status/atualização de anúncio — canal de contato e loop de confirmação são escopo 100% auto-imposto
metadata:
  type: project
---

Grep no edital (`docs/vortex-propose-documentation/md/Edital-desafio-tecnico-fullstack-estagio.md`,
2026-07-27) — **verificado**:

- `contato|contatar|negocia|comprador|vendedor|combinar|entrega` → **nenhuma ocorrência**
  sobre contato entre usuários (só "entrega" no sentido de entregar o desafio).
- `status|confirma|reserv|vendido|doado|entregue|atualizar|editar|update` → **zero ocorrências**.
- Campos obrigatórios do anúncio (linha 38-39): título, descrição, categoria, preço/doação,
  URL de imagem simulada. **Cinco. Contato não está entre eles.**
- Endpoints obrigatórios (linha 51-52): criar, listar, filtrar, deletar. **Sem update.**
- Vitrine é **pública** (linha 30-31); estatísticas e URL de imagem podem ser **simuladas**
  (linhas 31 e 39) — itens não são explicitamente autorizados a ser simulados, mas nada proíbe seed.

**Why:** duas suposições caras do discovery (B12.3 loop de confirmação, B12.4 canal TORPEDO)
não estão no caminho crítico da nota. O edital pontua em 4 eixos e nenhum deles cobre isso
— mesmo padrão do [[EP-006]]: otimizar variável não pontuada.

**How to apply:** ao dimensionar escopo, tratar canal de contato e status/confirmação como
**aditivos e negociáveis**, não como requisito. Consequência direta: **gatear o contato atrás
de sessão não viola nenhum requisito obrigatório** — o edital exige vitrine pública de *itens*,
nunca de *contato*. Ver [[matricula-publica-e-irreversivel]].

## Dois corolários que já foram contados errado uma vez

**A demo de 2 min tem CINCO batidas obrigatórias, não três** (linhas 147-156): landing no
desktop · transição para mobile · criar anúncio · listar · instalar. **Responsividade é eixo
pontuado**, então a transição não é enfeite; e o filtro por categoria (obrigatório, seção 1.1)
só cabe na landing. Quem cita "criar, listar e instalar" está omitindo duas.

**Endpoint adicional não é penalizado.** Seção 6 avalia *"funcionamento correto das rotas
REST"* — nada no edital pune rota a mais. O risco de acrescentar o verbo `update` (que a
enumeração omite) é **prazo, não conformidade**. Os dois se mitigam de formas opostas: confundir
os dois empurra para cortar escopo por medo da banca, que é o motivo errado.

## Verificação de identidade paga zero (verificado, 2026-07-28)

`grep -iE "verifica|institucional|matr[íi]cula|e-?mail|dom[íi]nio"` no edital → só bate em
*"Domínio técnico"*. E o bônus de auth (linha 59) é *"Autenticação básica de usuários (ex: JWT)
**ou separação por IDs de usuário**"* — a coisa mais barata satisfaz o bônus inteiro.

Logo: confirmar e-mail institucional, checar matrícula contra a universidade, ou qualquer
verificação real **não paga nenhum dos quatro eixos**. É custo de produto contra objetivo de nota.

**How to apply:** se uma feature de confiança exigir verificação, ela vale pelo produto, não
pela nota — e a decisão precisa ser tomada sabendo disso. Corolário que o war room fixou como
restrição de implementação: **o teto do que o pitch/vídeo pode afirmar é literalmente a string
renderizada na tela.** Se o código faz regex de domínio, a UI diz "informou o e-mail
institucional" — nunca "verificado", nunca selo com check. O ícone mente tão bem quanto a palavra.

## O eixo 2 tem orçamento de 1-2 decisões, não de N

*"Capacidade de explicar o próprio código com propriedade"* mede **compreensão demonstrada,
não sofisticação**, dentro de um bloco de 2 min com teto rígido. A segunda decisão explicada
paga pouco; a terceira é superfície para gaguejar. **Retorno marginal de complexidade no eixo 2
é zero ou negativo** — argumento para construir menos, não mais.
