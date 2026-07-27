---
name: round-stack-nao-verificado
description: Lacunas do round da stack que ninguém testou — e o modo de falha compartilhado (julgar pacote por likes)
metadata:
  type: project
---

Saída mais importante do round de 2026-07-27. O que **ninguém** verificou.

**Why:** três papéis convergiram em "a stack se sustenta" e a convergência virou força da
conclusão. Parte era a mesma premissa passando adiante.

**How to apply:** antes de aceitar um veredito de stack, checar estes itens.

## Não verificado, em ordem de impacto na decisão

1. **Quando começou o prazo de 15 dias.** Primeiro commit 2026-07-26 17:55; repo com menos
   de 8h de vida. Ninguém sabe a data-limite. Todo argumento de orçamento é chute.
2. **Edital, linha 56: "Retorno e envio de dados estritamente no formato JSON"** — requisito
   **mínimo obrigatório**. SSR + HTMX devolve `text/html`. Ninguém leu essa linha.
3. **Seção 6 do edital (critérios de avaliação) não pontua escolha de stack.** Os 4 eixos são
   Git/README, autoria no vídeo, requisitos obrigatórios, uso de IA. Stack só perde ponto ou
   custa tempo de vídeo.
4. **Escopo do Service Worker.** O darto serve estáticos via `app.mount('/public',
   serveStatic('public'))`. `sw.js` sob `/public/` só controla `/public/` — precisa de rota
   explícita ou `Service-Worker-Allowed`.
5. **PaaS gratuito preserva SQLite em arquivo entre restarts?** Disco efêmero apaga o banco.
6. **Instalar o PWA no celular real exige HTTPS.** `localhost` como secure context só resolve
   a demo no desktop.

## Modo de falha compartilhado deste round

**Todos julgaram o `darto` por métricas de popularidade (21 likes, 1960 dl/30d) e nenhum
abriu o pacote.** O core traz `jwt`, `session`, `cookie`, `csrf`, `validator`, `etag`,
`compress`, `cache`, `rate_limit`, `body_limit`, `cors`, `basic/bearer/api_key_auth`,
`require_roles`, `health`, `proxy`, `logger`, `request_id`, `stream` — e `parseBody()` com
`x-www-form-urlencoded` + `multipart` (`MimeMultipartTransformer`, `UploadedFile`).
Minha própria objeção ("HTMX posta form urlencoded e o darto talvez não parseie") morreu ao
abrir `lib/src/core/request.dart`.

Baixar o pacote e ler `lib/` custa ~30s: `curl pub.dev/api/archives/<pkg>-<v>.tar.gz`.

## Objeções minhas que já morreram — não reabrir

- **DNS/TLS quebram em `FROM scratch`.** Não: a imagem tem `libnss_dns.so.2`,
  `libresolv.so.2`, `/etc/nsswitch.conf` com `hosts: files dns` e o bundle de CA.
- **Doc de terceiros commitada polui o repo e viola licença.** Não: `.gitignore` exclui
  `docs/handbook/offline-reference/*` (2 arquivos rastreados) e o `FONTE.md` credita as
  licenças. `.git` = 1,1 MB.

Ver [[round-stack-o-que-caiu]].
