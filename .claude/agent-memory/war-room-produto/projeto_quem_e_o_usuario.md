---
name: projeto-quem-e-o-usuario
description: Os afetados deste repo e o estado real da base de evidência do discovery — n=3 externos, não 4, porque P04 é o autor e respondeu contaminado
metadata:
  type: project
---

Os três afetados por decisões neste repositório:

1. **Gabriel** — único dev, sob prazo. Ver [[usuario-gabriel-perfil]].
2. **A banca avaliadora** — usuário documentado desde 2026-07-27: o edital está em
   `docs/vortex-propose-documentation/md/Edital-desafio-tecnico-fullstack-estagio.md`
   (versão Typst irmã em `../typst/edital.typ`). Os 4 eixos de nota, a estrutura
   cronometrada do vídeo de 6 min e a lista de requisitos mínimos/bônus são **texto
   verificável**. Citar o arquivo, não o palpite.
3. **Agentes de IA** que operam no repo — leem `CLAUDE.md` como lei.

## O estudante deixou de ser fictício — mas a amostra é menor do que os documentos dizem

Desde 2026-07-27 existe discovery real em `docs/discovery/`. **Antes de usar qualquer
marca 🟢 de lá, aplique estas três correções** (verificadas no WAR ROOM de 2026-07-27 e
aceitas pelo papel cético):

- **P04 é o autor, e respondeu contaminado — o defeito é de ORDEM, não de ausência.**
  As respostas dele **existem e são auditáveis**: `.ai-log/raw-prompts.md:740-758`,
  verbatim. Mas em `:731`, às 23:19, ele pediu a análise das respostas de P01–P03 ("me
  use como uma das entrevistas") e às 23:28 respondeu as 10 perguntas. Nove minutos, com
  o material dos outros na tela. Logo a frase "P01 e P04 convergiram **sem contato**" é
  falsa **por relógio**, e com ela caem os 🟢 de **B01**, **B10** e a base do
  **enquadramento D**.
  ⚠️ `docs/discovery/` é untracked e `.ai-log/` é gitignorado — se commitar assim, no
  repo publicado P04 fica mesmo sem fonte. Colar o bruto no arquivo de respostas.
- **Citação seletiva na direção do enquadramento — CORRIGIDO em `02` em 2026-07-28,
  ainda pendente em `03`.** O `02-sintese-questionario.md` foi consertado por inteiro:
  Achado 1 traz a frase completa com nota de correção, o enquadramento **A voltou a
  "EM ABERTO"** e o **D** passou a "sustentado por dois relatos, não por convergência
  independente". **Falta em `03-problem-statement.md`:** linha ~51 ainda cita a metade
  truncada, e ~91 ainda diz que "otimizamos o lado da oferta com evidência real" (a
  oferta é 1 externo). Verificar antes de reportar como pendente — pode já ter mudado.
  O defeito original, para referência: `.ai-log/raw-prompts.md:743`, frase inteira:
  *"**Já sim, e já passei mais de uma vez**, porém tem algumas pequenas iniciativas que
  existem no campus que eu decidi NÃO usar..."*. A **primeira metade não existe em
  documento nenhum** (`grep "já passei mais de uma vez" docs/` → vazio); a segunda está
  em `02-sintese-questionario.md:34` e `03-problem-statement.md:51`. A metade publicada
  sustenta o enquadramento D; a omitida é relato de **fricção repetida**, que o
  `02:38-40` afirma estar refutado. **O enquadramento A ("fricção de anunciar"), marcado
  como refutado em `02:190`, volta a ficar em aberto.**
  Regra de peso que saiu disso: fala do respondente contaminado vale **mais** quando
  corta contra a tese do autor (ex. `:741`, sobre não acompanhar destino) e **menos**
  quando corre a favor (`:743` truncada).
- **A única evidência externa da "barreira de confiança" é sobre material do ENSINO
  MÉDIO.** A frase de P01 (`01-questionario-proto-personas_respostas.md:22`) é sobre
  apostilas do ensino médio; o `03-problem-statement.md:50` a cita sem esse contexto.
- **O lado da oferta é n=1 externo.** P01 jogou tudo fora e P03 não guardou nada —
  nenhum dos dois tem o que desapegar. Sobram P02 e o autor. Portanto a afirmação de
  `03-problem-statement.md:90-92` ("otimizamos a oferta com evidência real") **não se
  sustenta**: os dois lados são finos, e um deles se acreditava forte.

**Nenhum 🟢 do worksheet sobrevive intacto** — inclusive B08, cujo enunciado omite um
concorrente que duas pessoas nomearam: **comprar novo / comprar da faculdade**
(`respostas:17` e `:86`). Esse é o concorrente do lado da **demanda**.

O que sobrevive como achado externo sólido: **o eixo doação/venda é decidido pelo valor
do item, não pelo perfil da pessoa** (P02 e P03, cursos diferentes, sem contato). Se
alguma proto-persona for ancorada em dado real, ancore nessa.

**Why:** o formato WAR ROOM existe para impedir solução elegante para problema que
ninguém tem. O risco mudou de lugar duas vezes — era inventar o avaliador, virou inventar
o estudante, e agora é **tratar o discovery como mais robusto do que é**, porque ele tem
cara de documento pronto.

**How to apply:** ao ver 🟢 em `docs/discovery/`, cheque se P04 sustenta a nota; se
sustentar, é 🟡. Ao propor nova rodada de pesquisa, **não use a rede pessoal do autor** —
reproduz o buraco (ex-alunos de computação). Ver [[produto-hipoteses-abertas]] para o
canal proposto e os experimentos.
