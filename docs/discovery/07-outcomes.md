# Outcomes

**Cerimônia 5 do upstream** · Lean UX cap. 2 (princípio) e cap. 3 (método)
**Entrada:** `03-problem-statement.md` · `05-priorizacao-de-suposicoes.md`

---

## A distinção, na fonte

> *"Features and services are **outputs**. The business goals they are meant to achieve
> are **outcomes**. Lean UX measures progress in terms of explicitly defined business
> outcomes."* — cap. 2

E o motivo pelo qual isso importa:

> *"When we attempt to predict which features will achieve specific outcomes, we are
> mostly engaging in speculation. (…) **we don't know in any meaningful way whether a
> feature is effective until it's in the market.**"* — cap. 2

---

## ⚠️ O problema deste ciclo, declarado antes dos outcomes

**Este produto não vai ao mercado.** É um desafio técnico avaliado por banca, sem
usuários reais, sem lançamento no campus, sem período de operação.

Pela frase acima, isso significa que **os outcomes de produto declarados aqui são, por
construção, não verificáveis neste ciclo.** Escrever "aumentar em 30% as doações
concluídas" seria inventar um número que ninguém vai medir — exatamente o que o cap. 2
classifica como **waste**: *"anything that doesn't contribute to that is considered
waste and should be removed from the team's process."*

Por isso este documento separa **três níveis** e não os confunde:

| Nível | O que é | Verificável neste ciclo? |
|---|---|---|
| **1 — Outcomes do produto** | O que mudaria no campus se isto existisse de verdade | ❌ Não. Requer operação real |
| **2 — Sinais observáveis** | O que dá para verificar com as pessoas que já entrevistamos | ✅ Sim, qualitativamente |
| **3 — A função-objetivo** | A nota do edital, declarada na cerimônia 3 | ✅ Sim, mas **não é outcome de produto** |

Confundir o nível 3 com o nível 1 é o erro que este documento existe para evitar. A nota
é o critério pelo qual **priorizamos**; ela não é o que o produto tenta causar no mundo.

---

## Nível 1 — Outcomes do produto

Derivados do problem statement: *o gesto de desapegar fica sem resposta*.

### Outcome primário

> **Quem entrega material descobre que ele serviu a alguém.**

Não é "mais anúncios criados" — isso é output. É o fechamento do gesto, que hoje não
acontece: *"fiquei INSEGURO se realmente foi útil ou eu estava só 'espalhando lixo'"*.

### Decomposto em comportamentos menores

O cap. 3 manda quebrar: *"Consider how you can break down these high-level outcomes
into smaller parts. What behaviors will predict greater usage?"*

| # | Comportamento | Por que prediz o outcome primário |
|---|---|---|
| 1 | Alguém publica um item | Sem oferta não há nada. É o mínimo, e o mais fácil de confundir com sucesso |
| 2 | Alguém do outro lado demonstra interesse | Primeiro sinal de que existe demanda — hoje **não temos evidência de que exista** (B12.1) |
| 3 | O item é marcado como entregue, com destino registrado | O mecanismo que responde ao gesto |
| 4 | **Quem entregou volta e publica de novo** | **O outcome que prediz todos os outros** |

**O comportamento nº 4 é o que importa.** O problem statement diz que a dúvida
*"é o que impede a próxima vez"* — logo, a próxima vez acontecer é a evidência de que a
dúvida foi resolvida. É também o mais difícil: exige um segundo uso, e é exatamente a
suposição **B12.3**, marcada 🔴⚠ com contra-evidência.

### Outcome secundário

> **O sistema parece vivo o bastante para ser encontrado por quem precisa.**

Contra o defeito literal da geladeira: *"mal cuidada e super apagada (…) parece mais
lixo na rua"* e *"se não for alguém que ativamente quis olhar para ela"*.

Comportamento que o prediz: alguém chega à vitrine **sem ter ido procurá-la
deliberadamente**.

---

## Nível 2 — O que dá para observar neste ciclo

O livro insiste que sinal qualitativo conta:

> *"there's been a lot of backlash in the design world against measurement-driven
> design (…) which is why I think it's so important to include **qualitative feedback**
> in your success criteria. (…) When you look for success metrics, remember that
> **it's not all numbers.**"* — cap. 3

**O benchmark existe e é qualitativo** (de `03-problem-statement.md`): há hoje um canal
de fricção quase nula — a geladeira — que foi usado e deixou o usuário sem resposta.

### O sinal de sucesso perseguível

> **Uma pessoa que já deixou material na geladeira olha para esta tela e consegue
> apontar o que ela responde que a geladeira não respondeu — indicando algo concreto na
> interface, não a intenção do sistema.**

É verificável com os quatro respondentes do discovery. **Não** é estatística, **não**
prova que o produto funciona, e **não** substitui o nível 1 — é o teto do que este ciclo
alcança, e reconhecê-lo é mais útil que fingir o contrário.

### Um sinal negativo, igualmente informativo

Se a pessoa olhar a tela e disser *"é a mesma coisa"* ou não conseguir apontar nada
concreto, **B02 perdeu força** — e isso vale ser descoberto antes do vídeo, não depois.

---

## Anti-outcomes — o que explicitamente não perseguimos

Declarados porque são os defaults de qualquer produto, e aqui seriam **erro**:

| Anti-outcome | Por que é errado aqui |
|---|---|
| **Engajamento recorrente** — visitas diárias, tempo na página, notificações | U02: o uso é **episódico**, disparado por evento (faxina, mudança, formatura). Perseguir uso diário contraria o próprio modelo do produto |
| **Volume de anúncios publicados** | É **output**, não outcome. A geladeira também aceita volume — e falha mesmo assim |
| **Número de instalações do PWA** | O edital exige **demonstrar** a instalação, não que alguém adote (`05-priorizacao`: dano zero na nota). Perseguir instalação seria otimizar uma métrica que ninguém cobra |
| **Transações concluídas / valor movimentado** | Nenhum dos quatro respondentes se descreveu como vendedor. Um marketplace que mede GMV mediria a coisa errada para esta população |

---

## O que este documento assume, e ninguém testou

| Suposição | Estado |
|---|---|
| Fechar o gesto (saber que serviu) faz a pessoa voltar | 🔴⚠ **B12.3** — um relato contra, três silêncios |
| Existe alguém do outro lado para o item chegar | 🔴⚠ **B12.1** — nenhum ingressante na amostra |
| "Parecer vivo" é alcançável por design de interface | 🔴 Não testado. A geladeira falha por abandono **físico**; uma tela pode falhar por outros motivos |
| O sinal do nível 2 prediz alguma coisa sobre o nível 1 | 🔴 **Não.** Alguém achar a tela convincente não prediz que voltaria a usá-la — é a mesma armadilha da intenção declarada que o instrumento recusou |

A última linha é a mais importante do documento. **O nível 2 é o que conseguimos
observar, não uma aproximação do nível 1.** Tratá-lo como proxy seria repetir, na
medição, o erro que o discovery evitou nas perguntas.
