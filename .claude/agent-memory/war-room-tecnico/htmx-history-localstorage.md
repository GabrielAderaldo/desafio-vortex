---
name: htmx-history-localstorage
description: HTMX faz snapshot do DOM no localStorage a cada hx-push-url; Cache-Control não protege isso — mitigar com hx-history="false" em telas com dados do usuário
metadata:
  type: project
---

O HTMX, ao usar `hx-push-url`, **tira um snapshot do DOM e guarda no
localStorage** antes de cada request. A doc offline
(`docs/handbook/offline-reference/stack/htmx/docs.md`, seção "Disabling History
Snapshots") diz explicitamente que `hx-history="false"` serve "to prevent
sensitive data entering the localStorage cache, which can be important for
shared-use / public computers".

**Why:** o edital exige que "o usuário autenticado ou identificado" veja "os
seus próprios anúncios". Num app SSR+HTMX o HTML da tela "meus anúncios" é
personalizado, e vai parar no localStorage por padrão. O `Cache-Control:
no-store` que o OWASP HTML5 Cheat Sheet exige para dados sensíveis **não
protege o localStorage** — são mecanismos independentes. Um mitiga o Cache API /
cache HTTP; o outro é escrita explícita do htmx.

**How to apply:** em qualquer tela que renderize dados vinculados ao usuário
identificado, marcar `hx-history="false"`. Vale citar isso no vídeo de 2 min de
explicação técnica — é o tipo de detalhe que comprova autoria.

Duas restrições relacionadas, da mesma seção da doc:
- Toda URL empurrada na history **precisa** responder a página inteira num GET
  direto (usuário pode colar a URL, e o htmx pede a página cheia em cache miss).
  Ou seja, cada rota navegável tem duas representações: partial e full page.
- Setar `htmx.config.historyRestoreAsHxRequest = false`, senão o header
  `HX-Request` vem no restore e o servidor devolve partial onde deveria devolver
  a página inteira.

Ver [[stack-darto-verificada]].
