# Pipeline W0→W3 e regressão zero

Normativo: [ADR-0002](../../docs/handbook/adr/ADR-0002-pipeline-w0-w3-e-sdd.md).
Descrição operacional: `docs/handbook/process/`.

## Regressão zero — a regra que não tem exceção

**Não existe "o erro não é meu".**

Qualquer vermelho que apareça na sessão — teste falhando, lint, typecheck, hook, build,
`just check` — é tratado como **regressão a corrigir agora**, tenha ou não sido causado
pela mudança atual.

Frases proibidas, e o que fazer no lugar:

| ❌ Nunca | ✅ Sempre |
|---------|----------|
| "esse trecho não é meu, não vou mexer" | Corrigir, ou escalar com a causa-raiz nomeada |
| "não conheço esse código nesta sessão" | Ler o código e corrigir; desconhecimento não é justificativa |
| "já estava quebrado antes" | Irrelevante. Está quebrado agora, na sua sessão |
| "não toquei nessa parte" | Idem |
| Marcar `skip` para o vermelho sumir | Consertar a causa, ou corrigir o portão mal classificado **e provar o verde no caminho certo** |

Diante de um vermelho, existem exatamente **três saídas legítimas**:

1. **Consertar a causa** — volta ao verde de verdade.
2. **Corrigir o portão mal classificado** — e então *provar* o verde no caminho correto.
3. **Escalar ao Gabriel** com a causa-raiz explícita — nunca em silêncio.

## Nunca reverter trabalho alheio sem consultar

Código que você não escreveu — nesta sessão ou em qualquer outra — **não se reverte,
não se apaga e não se reescreve por conta própria**.

Se um trecho parece errado, obsoleto ou atrapalha o que você está fazendo:

1. Diga o que encontrou e por que parece problemático.
2. **Pergunte antes de agir.**
3. Só então altere.

Isso vale para código, configuração, documentação e histórico. "Isso não é meu, vou
reverter" é a única frase mais grave que "isso não é meu, não vou mexer".

## As quatro waves

| Wave | O que faz | Escreve em código de produção? | Saída |
|------|-----------|-------------------------------|-------|
| **W0 · RED** | Escreve os testes que derivam dos critérios de aceite | ❌ **nunca** | Todos os testes falham, **pelo motivo certo** |
| **W1 · GREEN** | Implementação mínima que faz W0 passar | ✅ o mínimo | Testes passam; nada além do necessário |
| **W2 · REVIEW** | Auditoria do diff | ❌ **read-only** | `APROVADO` ou `REJEITADO` com issues por `arquivo:linha` |
| **W3 · QUALITY** | Portão final | ❌ só corrige vermelho | `just check` verde |

Regras de transição, impostas pelo hook e verificadas pelo índice:

- Uma wave só começa se a **anterior estiver concluída**. Não se pula wave.
- W0 falhar é o resultado **esperado**. Se um teste de W0 passa antes da implementação,
  o teste é fraco — reescreva-o.
- W2 rejeitado volta para W1 e incrementa o *round*. **Máximo 3 rounds**; no terceiro
  sem aprovação, escale em vez de tentar de novo.
- Ticket só fecha com as quatro waves concluídas.

## Relatório de wave: saída literal, nunca afirmação

Todo relatório de wave cola a **saída real do comando**. Escrever "os testes passaram"
sem a saída é o modo de falha mais comum deste processo — e o mais difícil de detectar
depois.

Se você não rodou, não reporte. Se rodou e falhou, reporte o vermelho.

## Quando abrir ticket

**Toda mudança auditável abre ticket** — seja escrita por pessoa ou por IA. A auditoria
não pergunta quem escreveu.

| Vai direto (sem ticket) | Por quê |
|------------------------|---------|
| Correção de digitação em documentação | Não altera comportamento |
| Ajuste de formatação sem mudança semântica | Idem |

Na dúvida, abre ticket. O custo de um ticket a mais é minutos; o de uma mudança sem
rastro é um episódio no Diário de Bordo.
