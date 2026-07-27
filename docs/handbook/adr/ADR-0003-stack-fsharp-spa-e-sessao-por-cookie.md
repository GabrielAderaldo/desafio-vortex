---
id: ADR-0003
titulo: Adotar F# no backend, SPA React no frontend e sessão por cookie HttpOnly
status: aceito
data: 2026-07-27
decisores: [Gabriel Aderaldo]
tags: [stack, fsharp, react, spa, seguranca, sessao, pwa]
componentes: [api, web]
substitui: []
substituido_por: null
relacionados: [ADR-0002, RFC-0001]
ai_log: []
---

# ADR-0003 — Adotar F# no backend, SPA React no frontend e sessão por cookie HttpOnly

## Contexto

O desafio pede uma aplicação única com API REST e frontend PWA instalável, em 15 dias.
Os requisitos que restringem a escolha, verificados no edital:

- *"Retorno e envio de dados **estritamente no formato JSON**"* (linha 56, obrigatório)
- PWA com `manifest.json` e Service Worker (obrigatório)
- Responsividade completa: landing rica no desktop, app fluido no mobile
- *"O usuário autenticado **ou identificado**"* — autenticação plena é bônus
- TypeScript no frontend é **bônus**
- Cache offline de dados já carregados é **bônus**

Três stacks foram propostas no mesmo dia, e a terceira é esta. A segunda — Dart com
Darto, SSR e HTMX — passou por um WAR ROOM com quatro papéis, que rodou probes reais
e produziu achados que informam esta decisão mesmo tendo sido descartada.

**O achado que reenquadrou tudo:** o edital tem quatro eixos de avaliação — Git/README,
domínio técnico e autoria no vídeo, requisitos obrigatórios, e uso de IA. **Nenhum
pontua escolha de stack.** A stack só pode custar tempo de vídeo ou perder ponto por
requisito não atendido. Isso libera a escolha para outros critérios.

Os critérios que efetivamente decidiram, declarados pelo autor:

1. **Validar tecnologias em projeto real com consequência** — F# é a tecnologia que se
   quer aprender, e o desafio é o veículo.
2. **Debugabilidade** — *"quero que quando der problema eu saiba o que quebrou e não
   passar 500 horas debugando um browser que nem erro mostra"*.
3. **Sessão segura sem token no cliente.**

## Decisão

| Camada | Escolha |
|--------|---------|
| **Backend** | **F#** sobre ASP.NET Core. O framework específico (Falco, Giraffe ou Minimal APIs) fica para a fatia vertical decidir — é reversível e não pertence a este ADR |
| **Frontend** | **SPA React + Vite + TanStack Router**, consumindo a API por `fetch` |
| **Sessão** | Cookie **`HttpOnly; Secure; SameSite=Strict`** emitido pelo backend |
| **CSRF** | `SameSite=Strict` como primeira linha; header HTTP customizado nas requisições de mudança de estado |
| **Renderização** | Client-side. **Sem SSR** |

## Fundamentação — a sessão

A decisão de sessão é a que sustenta as outras, e vem direto do OWASP Session
Management Cheat Sheet:

> ⚠️ **WARNING** — "Do not store authentication tokens, session IDs, JWTs, refresh
> tokens, or any credential in `localStorage` or `sessionStorage`. These APIs are
> accessible to any JavaScript executing in the origin, so **a single XSS
> vulnerability discloses every token**. Use **`HttpOnly; Secure; SameSite=Strict`
> cookies (preferred) or a Backend-for-Frontend (BFF) pattern**."

E o HTML5 Security Cheat Sheet reforça:

> "Do not store session identifiers in local storage as the data is always accessible
> by JavaScript. **Cookies can mitigate this risk using the `httpOnly` flag.**"

Para o CSRF que o cookie automático introduz, o Cross-Site Request Forgery Prevention
Cheat Sheet indica:

> "**`SameSite` Cookie Attribute** can be used for session cookies" · "Since requests
> with custom headers are automatically subject to the same-origin policy, it is more
> secure to insert the CSRF token in a custom HTTP request header via JavaScript than
> adding a CSRF token in the hidden field form parameter."

*(Trechos obtidos via MCP `security` — OWASP Cheat Sheet Series. Não citados de
memória.)*

**O ponto que decidiu contra o SSR:** `HttpOnly` é propriedade **do cookie**, não do
modo de renderização. Uma SPA obtém exatamente a mesma garantia — o JavaScript nunca
vê o token nos dois casos. O SSR foi considerado por causa dessa segurança, e ele não
a entrega.

## Consequências

### Positivas

- **A linha 56 deixa de ser tensão.** A API devolve JSON porque é a única coisa que
  ela faz. Não há segunda superfície nem explicação a dar no vídeo.
- **TypeScript pleno no frontend**, não restrito ao Service Worker — o bônus é atendido
  sem ressalva.
- **Existe "manipulação de estado do frontend"** para os 2 minutos de explicação
  técnica. O edital oferece isso *ou* a lógica do Service Worker; agora há as duas.
- **Cache offline vira o caso canônico:** shell estática + respostas JSON. Sem HTML
  autenticado no Cache Storage, sem particionar cache por usuário.
- **Debugabilidade:** sem hidratação, sem server functions, sem geração de rotas em
  build. O `fetch` aparece no Network; o erro tem stack trace de um lado só.
- **Ecossistema com rede de segurança.** F# tem duas décadas e o .NET por trás — ao
  contrário da alternativa avaliada, cujo pacote principal tem 21 likes e um único autor.

### Negativas

- **`.NET` SDK não está instalado** (~1 GB). Com 8 GB de RAM, rodar SDK e Docker
  simultaneamente exige atenção.
- **Duas linguagens e dois ecossistemas** — F# e TypeScript. Mais contexto para
  carregar, e mais superfície para o vídeo cobrir.
- **HTML vazio no primeiro paint.** Sem SSR não há SEO nem conteúdo antes do JS. O
  edital pede *"Landing Page rica"* mas **não menciona SEO nem tempo de carregamento**
  em lugar nenhum — verificado por busca.
- **CSRF passa a exigir tratamento explícito**, porque o cookie viaja automaticamente.
  É trabalho conhecido, não risco aberto.
- **F# funcional custa segundos de contextualização no vídeo** — a banca provavelmente
  não o conhece. O React do outro lado compensa: é território familiar.

### Neutras

- A escolha do framework F# fica em aberto e é reversível.
- O prazo real não está determinado. O repositório tem menos de 8 horas de vida; o
  edital diz 15 dias sem data-base explícita. **Isso é risco de planejamento, não de
  arquitetura**, mas precisa ser resolvido antes do fatiamento.

## Alternativas consideradas

| Alternativa | Por que não |
|-------------|-------------|
| **Dart + Darto + SSR + HTMX** | Viável — três papéis do war room confirmaram com probes reais. Descartada por acumular: cache offline de HTML personalizado (o técnico chamou de "quebra cara"), snapshot do DOM no `localStorage` pelo HTMX, duas superfícies para cumprir a linha 56, `dartonic` descontinuado no pub.dev, e nenhum estado de frontend para mostrar no vídeo |
| **TanStack Start** | Proposto e descartado pelo próprio autor: faz mágica demais. Roteamento gerado em build, `createServerFn` que disfarça chamada de rede como função local, SSR com hidratação — cujo erro é notoriamente opaco. Contradiz o critério de debugabilidade |
| **Astro** | Mesmo motivo, declarado: *"vai abstrair tudo de mim e parecer LowCode"* |
| **SSR por segurança** | O ganho estrutural do SSR seria não expor a API. **O edital exige expor** (linha 49-56), então esse benefício desaparece — restaria a API pública *mais* as rotas HTML. Ver seção de fundamentação |
| **JWT em `localStorage`** | Contrariado explicitamente pelo OWASP: um único XSS vaza todos os tokens |
| **Sem autenticação** | Possível — o edital aceita "identificado" e um id anônimo bastaria. Descartado porque validar sessão segura é um dos objetivos de aprendizado declarados |

## Implicações para o código

- **Passa a valer:** a API F# devolve exclusivamente JSON; o React consome com
  `credentials: 'include'`; o cookie de sessão nasce `HttpOnly; Secure;
  SameSite=Strict`; requisições de mudança de estado levam header customizado.
- **Deixa de valer:** qualquer token, id de sessão ou credencial em `localStorage` ou
  `sessionStorage`. Se aparecer um `localStorage.setItem` com algo de autenticação, é
  bug de segurança, não escolha.
- **Service Worker:** cacheia shell estática e respostas JSON. **Nunca** resposta que
  contenha dado autenticado sem `Cache-Control: no-store`, e o escopo precisa ser
  declarado explicitamente — um `sw.js` servido de um subdiretório controla apenas
  aquele subdiretório.
- **Onde isso aparece:** `apps/api` (F#), `apps/web` (React), e o `compose.yaml`.
