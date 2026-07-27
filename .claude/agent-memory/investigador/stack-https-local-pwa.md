---
name: stack-https-local-pwa
description: localhost já é secure context — Service Worker roda sem HTTPS em dev; Caddy tls internal funciona mas exige instalar a CA no keychain
metadata:
  type: project
---

# HTTPS local para PWA — o que é necessário mesmo

**Fato:** para desenvolver e gravar o vídeo, **`http://localhost` basta**. Não é
preciso Caddy, mkcert nem certificado nenhum.

**Why:** a spec de Secure Contexts trata `http://localhost` e `127.0.0.1` como
potentially trustworthy. MDN (`offline-reference/stack/mdn/service-worker-api.md`,
linha 23): *"browsers also treat `http://localhost` as a secure context, to
facilitate local development"*. Documentado — não consegui testar em browser real.

**How to apply:** só puxar o Caddy para a demo se o requisito for domínio nomeado
(`app.localhost`), HTTP/2-3 ou compressão. Caso contrário é fricção sem ganho.

## Caddy — verificado rodando (`caddy:2-alpine`, imagem já presente localmente)

Caddyfile mínimo que funcionou (`local_certs` + `tls internal` + `reverse_proxy`):
o log mostra `certificate obtained successfully ... "issuer":"local"` em ~7 ms;
`curl -sk https://localhost:8443/api/items` → HTTP/2 200, resposta do Darto intacta.
`alt-svc: h3=":443"` (HTTP/3 anunciado).

Custos reais que ninguém lembra:
- O **cert de folha vale 12 h** (`notBefore`/`notAfter` conferidos). O Caddy renova,
  mas só se o processo estiver vivo.
- A **root CA** fica em `/data/caddy/pki/authorities/local/root.crt` (válida 10 anos).
  Sem volume persistente, cada `docker run` gera uma CA nova e o browser volta a
  reclamar. Para o browser confiar, tem que instalar essa root no keychain do macOS.
- `caddy` e `mkcert` **não** estão instalados nesta máquina (só a imagem Docker).

## Segurança do Service Worker (OWASP HTML5 Cheat Sheet)

Além de HTTPS + escopo restrito + kill-switch, que já eram sabidos:
- *"Do not cache responses that contain sensitive data. Send `Cache-Control: no-store`"*
- *"A malicious or compromised Service Worker can intercept every request from its
  scope until it is unregistered or the cache TTL expires"*
- *"Validate that the scope is restricted (use the `scope` option or the
  `Service-Worker-Allowed` response header)"*
- *"Do not store session identifiers in local storage"* / *"A single XSS can be used
  to steal all the data in these objects"*

Consequência para um SW que cacheia **HTML autenticado**: o HTML renderizado no
servidor com dados do usuário fica em Cache Storage, legível por qualquer JS da
origem e **sobrevive ao logout**. Precisa de `caches.delete()` no logout e de
`no-store` nas rotas autenticadas. Ver [[stack-frontend-bytes]].
