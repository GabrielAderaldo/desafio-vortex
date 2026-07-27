---
id: TCK-000N
titulo: <o que muda, em uma linha>
status: aberto          # aberto | w0 | w1 | w2 | w3 | verde | rejeitado | bloqueado
tamanho: M              # XS | S | M | L | XL
criado: AAAA-MM-DD
fechado: null
waves:
  W0: { outcome: null, rounds: 0, em: null }   # outcome: RED
  W1: { outcome: null, rounds: 0, em: null }   # outcome: GREEN
  W2: { outcome: null, rounds: 0, em: null }   # outcome: APROVADO | REJEITADO
  W3: { outcome: null, rounds: 0, em: null }   # outcome: VERDE
componentes: []         # [api, web, contratos, infra]
relacionados: []        # [ADR-000X, DD-000X, TCK-000X]
ai_log: []              # [EP-00N]
bloqueadores: []
---

# TCK-000N — <título>

## Contexto

Por que esta mudança existe. Duas ou três frases — quem ler daqui a um mês precisa
entender sem abrir outro documento.

## Escopo

O que entra. Seja específico: arquivos, módulos, comportamentos.

- …

## Fora de escopo

O que **não** entra, mesmo sendo tentador. Esta seção é o que protege contra
scope-creep — e é a primeira que o revisor de W2 consulta quando o diff cresce.

- …

## Critérios de aceite

Escritos como **exemplos concretos**, no formato Dado/Quando/Então. São eles que viram
os testes de W0 — se um critério não é testável, ele ainda não está pronto.

1. **Dado** <estado inicial> **quando** <ação> **então** <resultado observável>
2. …

## Definition of Done

- [ ] Testes de W0 derivam dos critérios de aceite acima
- [ ] `just check` verde
- [ ] Nada fora do escopo declarado entrou no diff
- [ ] Achados fora de escopo registrados, não corrigidos aqui

## Referências

ADRs, design docs ou tickets que sustentam esta mudança.

---

## W0 · RED

**Comando:**
```
<comando que roda os testes>
```

**Saída literal:**
```
<cole aqui a saída real — nunca escreva "os testes falharam" sem a prova>
```

**Testes escritos:** `caminho:linha` de cada um.

**Por que falham:** deve ser por a API não existir, não por erro de digitação.

## W1 · GREEN

**Comando e saída literal:**
```
<saída>
```

**O que foi implementado:** o mínimo. Se sobrou código não coberto por teste, ele não
deveria estar aqui.

## W2 · REVIEW

**Veredito:** APROVADO | REJEITADO · **Round:** 1

Auditoria read-only do diff. Cada achado com `arquivo:linha`.

| # | `arquivo:linha` | Achado | Severidade |
|---|-----------------|--------|------------|
| 1 | | | |

**Fora de escopo encontrado:** registrar aqui, **não corrigir neste ticket**.

## W3 · QUALITY

**Comando:**
```
just check
```

**Saída literal:**
```
<saída completa>
```
