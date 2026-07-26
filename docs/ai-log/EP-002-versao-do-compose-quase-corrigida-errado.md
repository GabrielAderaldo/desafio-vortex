# EP-002 — A IA quase me "corrigiu" com informação desatualizada

**Data:** 2026-07-26
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code
**Commits relacionados:** `fb68418`

## Contexto

Ao definir que o projeto usaria Docker obrigatoriamente, informei as versões que
pretendia usar. A IA discordou internamente da premissa — e quase escreveu a correção.

## O prompt

~~~
Quero que você aproveite e veja a compatibilidade dele com containers ok? Por que tenha
em MENTE vamos OBRIGATORIAMENTE usar docker e docker-compose todos vão ser os mais
atualis LTS ou seja as versões 5.X.X ok? Isso vai ser importante para a tomada de decisões
~~~

## O que a IA respondeu

Ela abriu a resposta assim, declarando o que ia fazer:

> "Vou testar — mas antes preciso confirmar as versões, porque tem uma premissa aí que
> quero verificar antes de virar decisão."

O plano era me corrigir: dizer que o Docker Compose está na linha **2.x**, não 5.x, e
que eu provavelmente estava confundindo com a versão do Engine. Essa era a informação
que ela tinha internalizada.

Antes de escrever a correção, rodou:

```bash
docker compose version
curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name
```

## Onde quebrou

**A IA estava errada. Eu estava certo.**

```
Docker Engine: 29.4.0 (client 29.4.0)
Docker Compose version v5.1.2
docker/compose mais recente: v5.3.1 (2026-07-07)
```

O Compose está na linha 5.x. O conhecimento da IA sobre isso estava desatualizado, e
ela o teria apresentado com a confiança de quem corrige um engano do interlocutor.

Ela admitiu explicitamente: *"Eu estava errado e você certo — Compose está mesmo na
linha 5.x. Bom que verifiquei antes de 'corrigir'."*

## Como eu conduzi até a solução

Não precisei conduzir nada — o hábito de verificar antes de afirmar cobriu o erro
sozinho. O que **eu** fiz de certo foi fixar a versão no prompt (`5.X.X`) em vez de
dizer "a versão mais recente". Um número concreto é falseável: obriga a checagem e
transforma uma divergência silenciosa em teste.

Se eu tivesse escrito apenas "use a versão mais atual", a IA teria assumido 2.x, e a
RFC inteira sobre compatibilidade com containers teria sido escrita contra uma versão
que não existe mais.

## O que ficou

**O conhecimento de uma IA sobre números de versão tem prazo de validade, e ela não
sente esse prazo passar.** O erro não seria uma alucinação óbvia — seria uma afirmação
plausível, específica e entregue com convicção, sobre uma ferramenta que a maioria dos
tutoriais ainda descreve na 2.x.

Duas consequências práticas para o resto do projeto:

1. Toda versão de dependência entra no prompt como **número explícito**, nunca como
   "a mais recente".
2. Foi essa constatação que justificou baixar documentação para
   `docs/handbook/offline-reference/` com o `FONTE.md` registrando commit e data — ler
   a doc da versão que o projeto usa, e não a versão mais popular da internet.
