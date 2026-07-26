# RB-<nome-do-procedimento>

- **Serviço:** <qual componente>
- **Severidade típica:** SEV-1 (queda total) | SEV-2 (degradação) | SEV-3 (incômodo)
- **Última validação:** AAAA-MM-DD — <quem executou de verdade>
- **Relacionado:** <DD-000X, ADR-000X>

> Formato inspirado nos [runbooks do GitLab SRE](https://gitlab.com/gitlab-com/runbooks)
> e no [PagerDuty Incident Response](https://response.pagerduty.com/).
>
> **Um runbook é escrito para ser executado por alguém cansado, às 3 da manhã, que não
> escreveu este sistema.** Sem ironia, sem "obviamente", sem passo implícito. Se um
> comando precisa de contexto para ser digitado, o contexto vai antes do comando.

## Sintoma

Como isso aparece. O que o alerta diz, o que o usuário relata, o que o log mostra.
Alguém deve conseguir bater o olho e confirmar **em 30 segundos** que chegou no
runbook certo.

## Impacto

Quem é afetado e quão grave é. Isso define se acorda alguém ou espera o horário
comercial.

- **Usuário final:** <o que ele não consegue fazer>
- **Dados:** <há risco de perda ou corrupção? esta linha decide a urgência>

## Diagnóstico

Confirme a causa **antes de agir**. Cada passo é uma verificação com resultado esperado.

1. <verificação>
   ```bash
   <comando>
   ```
   **Esperado:** <o que indica normalidade>
   **Se diferente:** <o que isso significa e para onde ir>

2. <...>

## Resolução

Passos numerados, na ordem exata. Um comando por passo.

1. <ação>
   ```bash
   <comando>
   ```
   **Confirmar que funcionou:** <como verificar antes de seguir para o próximo>

> ⚠️ **Passos destrutivos** (drop, truncate, delete, force push) levam aviso explícito
> e a condição obrigatória antes de rodar — backup verificado, janela combinada, etc.

## Rollback

Como desfazer, se a resolução piorar. Se **não houver** rollback possível, escreva
exatamente isto:

> **Sem rollback.** A partir do passo N a mudança é irreversível.

Descobrir isso no meio da execução é o pior momento possível.

## Escalonamento

Quando parar de tentar e chamar ajuda — critério objetivo, não sensação.

| Condição | Ação |
|----------|------|
| <ex: passo 3 falha duas vezes> | <acionar quem, por qual canal> |
| <ex: há suspeita de perda de dado> | <parar tudo e escalar imediatamente> |

## Prevenção

O que faria este runbook nunca mais ser necessário. Link para a issue, se existir.
Runbook executado com frequência é sintoma de dívida técnica, não de boa operação.
