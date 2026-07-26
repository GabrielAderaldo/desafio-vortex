# EP-003 — Documentei as permissões da ferramenta errada

**Data:** 2026-07-26
**Ferramenta:** Claude Opus 5 (1M context) via Claude Code
**Commits relacionados:** `fb68418`

## Contexto

Ao avaliar o task runner, perguntei como ele se integraria com "agentes do VS Code",
para saber se valia a pena testar isso no projeto. A IA pesquisou a documentação
oficial e escreveu uma seção inteira da RFC sobre o assunto.

## O prompt

~~~
Pronto, ultima coisa... porém quero que esse pesquise nas docs online possiveis? Qual é
a compartibilidade do Just com o vsCode Agentes, pois quero testar tbm ele nesse projeto
para ver como tá a ultima versão dele...
~~~

## O que a IA respondeu

Pesquisou a documentação da Microsoft, encontrou o mecanismo certo **para o produto
errado**, e escreveu na RFC:

```jsonc
{
  "chat.tools.terminal.autoApprove": {
    "/^just (up|down|ps|test)$/": true,
    "/^just /": false
  }
}
```

A análise em si era boa: identificou corretamente que agentes rodam **comandos de
terminal**, não task providers do editor, e que por isso a extensão do `just` para VS
Code era irrelevante — o que importava era a allowlist.

## Onde quebrou

Essas settings são do **agent mode nativo do VS Code e do GitHub Copilot**. Eu não uso
Copilot. Meu harness é o Claude Code, que tem sistema de permissões próprio.

A IA verificou o ambiente e viu que eu tinha `anthropic.claude-code` instalado e
**nenhuma extensão do Copilot** — chegou a escrever isso na resposta. Mesmo assim,
documentou o mecanismo do Copilot na RFC, porque foi o que a documentação da Microsoft
apresentava.

O erro não foi factual: as settings existem e funcionam. Foi de **aplicabilidade** —
documentação correta, produto errado.

## Como eu conduzi até a solução

Corrigi o enquadramento em vez do detalhe:

~~~
Respondendo, não tenho compilot e nem pretendo ter, o VSCode será SÓ uma interface de
interação e agreggador de hardness para nosso CLAUDE-CODE então pretendo SE possivel só
usar o Claude-code e no MAXIMO o kimi IA caso precise, porém a ideia real é respeitar O
MAXIMO possivel das boas praticas do claude e usar o que eles mais recomendam...
~~~

A IA então buscou a documentação oficial do Claude Code e substituiu a seção pelo
mecanismo real:

```json
{ "permissions": { "allow": ["Bash(just *)"], "deny": ["Bash(just deploy*)"] } }
```

E o argumento **ficou mais forte** com a correção: a avaliação é `deny` → `ask` →
`allow` com o primeiro match vencendo, e `deny` não admite exceções — é isso que torna
seguro ter uma allowlist de prefixo generosa.

## O que ficou

**Verificar o ambiente não é o mesmo que aplicar o que se verificou.** A IA constatou
corretamente que eu não tinha Copilot e ainda assim escreveu a configuração dele,
porque a pesquisa retornou a documentação da Microsoft e ela seguiu a fonte em vez do
contexto.

A lição de prompt: declarar o harness **antes** de pedir pesquisa de integração. "Como
o `just` se integra com agentes" e "como o `just` se integra com o Claude Code" levam a
fontes diferentes — e só a segunda pergunta tinha resposta útil para este projeto.

Também virou regra no `CLAUDE.md`: as settings `github.copilot.*` não se aplicam aqui,
e o aviso está registrado no `FONTE.md` da documentação offline do VS Code, já que a
maior parte dela assume Copilot.
