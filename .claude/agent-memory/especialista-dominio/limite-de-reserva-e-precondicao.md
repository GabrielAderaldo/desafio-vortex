---
name: limite-de-reserva-e-precondicao
description: O limite de uma reserva ativa por pessoa é pré-condição com consistência eventual, não invariante de agregado — o critério de Vernon que decidiu, e as três alternativas descartadas
metadata:
  type: project
---

**"Uma pessoa tem no máximo uma reserva ativa como recebedora" (`P1`) NÃO é invariante de
nenhum agregado.** É pré-condição do comando `reservar`, com consistência **eventual**.
Modelado em `docs/discovery/17-modelagem-de-dominio.md` §5.6.

**Why:** Vernon, *IDDD*, **p. 464**, citando Evans: *"ask whether it's the job of the user
executing the use case to make the data consistent (…) If it is another user's job, or the
job of the system, allow it to be eventually consistent."* Quem executa o caso de uso é o
**anunciante**; o estado é de **outra pessoa**, e ele nem pode vê-lo sem vazamento. Somado
ao teste da p. 450 (*"a business rule that must always be consistent"*): a violação **não
corrompe nada** — duas reservas simultâneas não perdem item, não vazam contato, ambas se
desfazem. É dispositivo de **incentivo**, não regra de correção.

**Os três lugares onde ela não pode morar, e por quê:**

1. **Em `Pessoa` (BC-2)** — faria BC-2 depender de `Anúncio` e **fecharia a porta do Unifor
   Online**. É a razão mais forte, e é de arquitetura, não de pureza.
2. **Num agregado `Reserva` próprio** — quebraria `I4` (`12:232`), a única invariante que
   fecha a fronteira do `Anúncio`.
3. **Num agregado com chave de pessoa** (`Compromisso`) — funciona, mas reservar passaria a
   modificar dois agregados por transação (Vernon, p. 391) para comprar uma garantia que o
   domínio não pede.

**How to apply:** ao alimentar a W0, `P1` entra numa linha separada da tabela de
invariantes, rotulada pré-condição. Um teste escrito como invariante de agregado afirmaria
uma garantia que o modelo não dá — e é exatamente esse tipo de teste que a
[[contradicoes-abertas-do-modelo]] classifica como fraco. Precedente já existente no
modelo: `I12` ("não se publica sem `ContatoPúblico`") tem a mesma forma.

**Consequência não intencional, registrada:** `P1` invalida a justificativa do risco aceito
em `16-modelo-de-dados-por-perfil.md:171` (*"criar várias identidades — não há o que ganhar
(…) nem limite por pessoa"*). Agora **há**. Ver C12.
