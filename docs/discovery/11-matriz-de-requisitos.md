# Matriz de rastreabilidade dos requisitos

**Cerimônia 7b do upstream** — auditoria de cobertura
**Fonte:** `docs/vortex-propose-documentation/md/Edital-desafio-tecnico-fullstack-estagio.md`

> **Por que este documento existe.** O discovery organizou o produto em torno do
> problema, e nenhum artefato provava que **todo requisito obrigatório do edital estava
> coberto**. Enquadramento bom não substitui checklist: um requisito obrigatório
> esquecido custa no eixo 3, que avalia *"funcionamento correto das rotas REST e
> cumprimento das diretrizes de responsividade e PWA"*.
>
> **Regra:** nenhum item ❌ ou ⚠️ pode continuar assim até a entrega. Esta matriz é
> revisada a cada fatia concluída.

**Legenda:** ✅ coberto no escopo · ⚠️ parcial ou não detalhado · ❌ não coberto

---

## Seção 1.1 — Telas exigidas

### Landing Page Pública (Web/Desktop)

| # | Exigência literal | Onde | Estado |
|---|---|---|---|
| 1.1 | *"página de apresentação do projeto que explique a proposta de economia circular no campus"* | Fatia 1 · A1 | ✅ |
| 1.2 | *"exiba estatísticas simuladas do sistema"* | Fatia 1 · A1 | ✅ com a regra de honestidade da cerimônia 7 |
| 1.3 | *"vitrine pública listando os últimos itens anunciados"* | Fatia 1 · A2 | ✅ |
| 1.4 | *"filtros básicos por categoria (ex: Livros, Engenharia, Computação)"* | Fatia 1 · A2 | ✅ — categorias a fixar na cerimônia 10 |
| 1.5 | *"botões claros de chamada para ação (CTA) convidando o usuário a anunciar ou buscar itens"* | Fatia 1 · A1 | ✅ **dois** CTAs: anunciar **e** buscar |

### Aplicação Mobile (PWA)

| # | Exigência literal | Onde | Estado |
|---|---|---|---|
| 1.6 | *"deve oferecer a experiência de um aplicativo nativo"* | Fatia 1 | ✅ responsividade + PWA |
| 1.7 | *"O usuário autenticado ou identificado"* | Fatia 2 · sessão por matrícula | ✅ — atende pela via **autenticado**, que é bônus (linha 59) |
| 1.8 | *"formulário para anunciar um item (título, descrição, categoria, preço ou indicação de doação, e uma URL de imagem simulada)"* | Fatia 1 · A3 | ✅ **os 5 campos** |
| 1.9 | *"visualizar seus próprios anúncios cadastrados"* | Fatia 1 · A7 | ✅ |

> ⚠️ **Dependência de ordem que precisa ser vista.** O item 1.7 está na **fatia 2**, mas
> 1.8 e 1.9 estão na **fatia 1**. Publicar e ver os próprios anúncios pressupõe saber de
> quem eles são. **A fatia 1 precisa de uma noção mínima de identidade** — ainda que
> provisória — ou 1.9 não é implementável. Levar para a cerimônia 10.

---

## Seção 2.1 — Backend (obrigatórios)

| # | Exigência literal | Onde | Estado |
|---|---|---|---|
| 2.1 | *"API REST estruturada em qualquer linguagem ou framework"* | Fatia 0 · ADR-0003 (F#) | ✅ |
| 2.2 | *"endpoints básicos (CRUD) (…) criar, listar, filtrar e deletar"* | Fatia 1 | ✅ — `PATCH` de entrega vem na fatia 2 |
| 2.3 | *"Persistência de dados funcional"* | Fatia 0 | ✅ **acrescentado por esta auditoria** — não estava listado no corte de escopo |
| 2.4 | *"Retorno e envio de dados estritamente no formato JSON"* | Fatia 0 · ADR-0003 | ✅ |

---

## Seção 2.2 — Frontend e PWA (obrigatórios)

| # | Exigência literal | Onde | Estado |
|---|---|---|---|
| 2.5 | *"interface utilizando tecnologias web modernas (React…)"* | ADR-0003 | ✅ |
| 2.6 | *"OBRIGATÓRIA a inclusão de um manifesto de aplicativo web válido (manifest.json)"* | Fatia 1 | ✅ — **"válido"** é critério de aceite, não só presença |
| 2.7 | *"um Service Worker básico que permita que a aplicação seja 'instalada' na tela inicial"* | Fatia 1 | ✅ |
| 2.8 | *"adaptar perfeitamente de uma Landing Page rica no desktop para uma experiência fluida de aplicativo no mobile"* | Fatia 1 | ✅ |

---

## Seção 3 — Diário de Bordo (obrigatório, **no README**)

| # | Exigência literal | Estado |
|---|---|---|
| 3.1 | *"Ferramentas Utilizadas: Liste quais IAs você utilizou"* | ❌ **placeholder no README** |
| 3.2 | *"pelo menos 2 ou 3 prompts complexos"*, copiados e colados | ❌ **placeholder no README** — matéria-prima existe em `docs/ai-log/` (EP-001 a EP-007) |
| 3.3 | Compartilhamento de histórico | opcional |
| 3.4 | *"um momento em que a IA gerou um código errado, incompleto ou uma 'alucinação'"* | ❌ **placeholder no README** — EP-006 e EP-007 são o material |

> 🔴 **O maior gap aberto.** A seção 3 diz: *"caso o Diário de Bordo seja omitido, a
> solução será **severamente penalizada**"* (linhas 108-109). Os episódios existem e são
> bons, mas **estão em `docs/ai-log/`, não no README** — e o edital exige *"No arquivo
> README.md principal do seu repositório"*. Um avaliador que leia só o README encontra
> placeholders.
>
> Note o alvo de 3.4: *"a IA gerou um **código** errado"*. O EP-007 (citação truncada) é
> defensável como "incompleto", mas **código governa a frase** — some ao caso de código
> do EP-006, não substitua.

---

## Seção 4 — Entrega e repositório

| # | Exigência literal | Estado |
|---|---|---|
| 4.1 | *"repositório **público** no GitHub ou GitLab"* | ❌ **`git remote -v` vazio** — o repositório é só local |
| 4.2 | *"Título do projeto e uma descrição resumida da proposta"* | ❌ README: `# <Nome do Projeto>` |
| 4.3 | *"Instruções passo a passo de como rodar o Backend e o Frontend localmente (pré-requisitos, comandos de instalação de dependências e comandos de execução)"* | ❌ README: `<comando>` |
| 4.4 | *"Relação de tecnologias, frameworks e bibliotecas principais adotadas"* | ❌ README: tabelas com `_(ex: …)_` |
| 4.5 | Diário de Bordo | ❌ ver seção 3 |
| 4.6 | Links de produção | opcional |

**33 placeholders no README.** É o documento que o eixo 1 avalia inteiro.

---

## Seção 5 — Vídeo

| # | Exigência literal | Estado |
|---|---|---|
| 5.1 | *"duração máxima e estrita de 6 minutos"* | ❌ não rastreado em nenhum artefato |
| 5.2 | Hospedado em plataforma acessível, link no formulário | ❌ não rastreado |
| 5.3 | 0:00–1:00 — pitch e visão geral | ⚠️ insumo pronto (problem statement, Achado 7) |
| 5.4 | 1:00–3:00 — demo: landing desktop, mobile, criar anúncio, listar, **instalar** | ⚠️ roteiro esboçado na cerimônia 7 |
| 5.5 | 3:00–5:00 — código: arquitetura de pastas, rotas do backend, **Service Worker ou manipulação de estado** | ❌ não roteirizado |
| 5.6 | 5:00–6:00 — uso de IA, mostrando prompts no README ou navegador | ⚠️ material existe; depende do README |

> **O vídeo não era rastreado por nenhum documento do upstream.** É metade do peso da
> avaliação (eixos 2 e parte do 1) e não tinha dono. Registrado aqui.

---

## Resumo dos gaps

| Gap | Natureza |
|---|---|
| **README com 33 placeholders** | Texto. Bloqueia 4.2, 4.3, 4.4 e toda a seção 3 |
| **Repositório sem remote** | Configuração. Bloqueia 4.1 |
| **Vídeo sem roteiro** | Planejamento. Bloqueia 5.5, e o resto depende do produto pronto |
| **Persistência não listada** | ✅ **corrigido nesta auditoria** — agora rastreado na fatia 0 |
| **Identidade mínima na fatia 1** | Dependência de ordem — 1.9 pressupõe 1.7 |

**Nada de software está faltando.** Os três gaps abertos são **entrega**, não produto —
e dois deles (README e repositório) não dependem de nenhuma linha de código, o que
significa que podem ser fechados antes da fatia 0 começar.
