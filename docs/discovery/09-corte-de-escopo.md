# Corte e priorização de features

**Cerimônia 7 do upstream**
**Entrada:** `08-hipoteses.md` · `05-priorizacao-de-suposicoes.md` · edital
**Por que importa:** escopo é o item **#2** do ranking de risco — *"o único mecanismo
que protege o eixo 3"* (requisitos obrigatórios funcionando).

---

## 1. A decisão travada: cobertura × lastro

A cerimônia 6 deixou aberto: **H1 precisa saber para quem o item foi, mas H4 manda o
contato acontecer fora do sistema.** Quem combina pelo TORPEDO nunca clica em nada.

### O reenquadramento que desfaz o impasse

Reler a dor original, com atenção ao objeto da dúvida:

> *"fiquei INSEGURO se **realmente foi útil** ou eu estava só 'espalhando lixo'"*

A dúvida é sobre **utilidade**, não sobre **identidade**. Quem entregou não precisa
saber *quem* é a pessoa — precisa saber que **alguém real pegou e precisava**.

Isso muda o requisito: o mínimo que responde à dor é **"serviu a alguém"**, não
**"foi para fulano"**.

E leva à segunda observação: **o registro de destino serve ao próprio anunciante, não a
uma auditoria.** Ele já sabe para quem entregou — combinou pelo TORPEDO. O sistema não
está verificando a verdade dele; está dando ao gesto um lugar onde fechar. **Lastro
perfeito não é requisito.** Isso derruba metade do dilema.

### A decisão: o interesse é o gate do contato

> **Para ver como falar com quem anunciou, é preciso estar identificado e clicar
> "Tenho interesse".**

Não é fricção artificial acrescentada depois — **é como se obtém o contato**. O clique
passa a estar no caminho crítico de quem realmente quer o item, em vez de ser uma etapa
extra que ninguém tem motivo para cumprir.

| O que isso resolve | Como |
|---|---|
| **Cobertura** | Quem pega o item quase sempre passou pelo gate — era o único jeito de obter o contato |
| **Lastro** | O interesse é ato do interessado, autenticado. O anunciante escolhe entre interessados reais, não digita um nome livre |
| **Privacidade** | O nome **não fica exposto na web aberta**. A vitrine é pública (obrigatório); o contato é revelado só a quem se identificou |
| **Bônus do edital** | Autenticação é diferencial explícito (linha 59). O gate paga esse bônus em vez de custar |
| **A tela vazia** | Deixa de nascer vazia: há interessados para marcar |

### O que a decisão **não** resolve — declarado

- Quem clica e nunca leva o item. O anunciante marca outro, ou não marca.
- Nada impede marcar quem não levou. **Aceito:** o registro é para o próprio anunciante
  fechar o gesto, não para provar nada a terceiros.
- Quem vê o anúncio, encontra a pessoa por fora sem usar o sistema e combina. Existe,
  e é minoria — o caminho pelo gate é mais curto que descobrir a pessoa sozinho.

---

## 2. O escopo

### Entra — obrigatório pelo edital

| Feature | Origem |
|---|---|
| Landing pública: proposta, estatísticas, vitrine dos últimos itens, CTA | seção 1.1 |
| Filtro por categoria | seção 1.1 |
| Formulário de anúncio: título, descrição, categoria, preço **ou** doação, URL de imagem | seção 1.1 |
| "Meus anúncios" | seção 1.1 |
| API REST JSON: criar, listar, filtrar, deletar | linha 52 e 56 |
| PWA instalável: `manifest.json` + Service Worker | seção 2.2 |
| Responsividade desktop ↔ mobile | seção 2.2 |

### Entra — o enquadramento D

| Feature | Hipótese | Justificativa |
|---|---|---|
| "Tenho interesse" como gate de contato | H4 | Decisão acima. Paga o bônus de autenticação |
| Marcar entregue, escolhendo entre os interessados | H1 | **O núcleo.** Sem isto, não há enquadramento D |
| Estado do item: disponível / entregue | H1, H3 | Consequência do anterior; alimenta o sinal de vida |
| Atividade recente na vitrine | H3 | Ataca *"parece mais lixo na rua"* |
| Escolher o que aparece no contato (nome, e-mail, handle) | H5 | Um campo. Evidência direta de dois respondentes |

### Fica de fora — com o motivo

| Feature | Por que não |
|---|---|
| **Busca textual** | O edital nunca pede — só *"filtros básicos por categoria"*. Escopo que nós adicionaríamos |
| **Editar o conteúdo do anúncio** | A enumeração do edital omite o *update*. Marcar entrega já usa `PATCH`; editar título e descrição não paga nada |
| **Notificações** | Uso episódico (U02). Notificar quem usa duas vezes por ano é incômodo, não engajamento |
| **Avaliação, nota, reputação** | Fora do escopo desde o problem statement. E não responde *"bom cuidado"*, que é a objeção real |
| **Chat ou comentários** | Decisão do autor: o contato sai pelo TORPEDO |
| **Upload de imagem** | O edital pede *"URL de imagem simulada"*. Corta storage, multipart, resize, validação de MIME |
| **Confirmação bilateral de recebimento** | Exigiria o recebedor voltar ao sistema — o segundo uso que **B12.3** diz que talvez não aconteça. Apostar o mecanismo central nele seria construir sobre a suposição mais frágil |

---

## 3. A ressalva das estatísticas simuladas

O edital autoriza estatísticas simuladas na landing, e elas coincidem com o que H3 pede
(sinal de vida). **Mas número inventado apresentado como real é mentira de produto.**

**Regra adotada:** dados de semente existem e são visíveis, e a interface **nunca**
apresenta como atividade real algo que não é. Na prática: o seed popula a vitrine (para
não nascer vazia, o cenário identificado como pior que não ter a tela), e os contadores
refletem **o que está no banco** — inclusive o que veio do seed, que é conteúdo real do
sistema, apenas não gerado por usuários externos.

O que **não** fazer: um contador fixo escrito no HTML dizendo "1.247 itens já
encontraram destino". Isso mentiria para a banca e para qualquer usuário, e o edital
autoriza simular dados — não simular resultados.

---

## 4. O teste dos 2 minutos

O bloco 1:00–3:00 do vídeo exige: landing no desktop, navegação mobile, criar anúncio,
listar, e **instalar na tela inicial**. É constraint de design (`03-problem-statement`).

Ordem que cobre o exigido e mostra o diferencial:

| Trecho | O que aparece |
|---|---|
| Landing no desktop | Proposta, vitrine com itens, filtro por categoria |
| Troca para mobile | Responsividade — mesma aplicação |
| Instalar na tela inicial | **Requisito obrigatório sendo cumprido na tela** |
| Criar anúncio | Formulário curto: título, categoria, doação/preço, URL |
| Ver na vitrine | O item aparece |
| Interesse → marcar entregue | **O diferencial**, e o único trecho que não é CRUD |
| "Meus anúncios" com destino registrado | O gesto fechado |

**Consequência para o desenho, e é o motivo de fazer este exercício agora:** o formulário
de anúncio precisa caber em poucos campos e uma tela. Se exigir rolagem, seleção
múltipla ou etapas, o trecho do diferencial fica sem tempo — e é justamente o que
distingue a entrega de um CRUD.

**Não cronometrei.** Estimar durações aqui seria chute; o teste real é gravar.

---

## 5. O que a cerimônia 7 deixa aberto

| Item | Onde resolve |
|---|---|
| Quais categorias existem, e se são fixas | Cerimônia 10 (critérios de aceite) |
| Se "doação" e "preço" são um campo ou dois | Cerimônia 10 — P02 e P03 convergiram que o critério é o **valor do item**, não o perfil |
| Como a sessão por matrícula é estabelecida na prática | Design Doc, depois do PRD |
| O que o Service Worker cacheia | ADR-0003 já restringe: shell + JSON, nunca resposta autenticada sem `no-store` |
| Se a tela de destinos mostra nome ou "alguém do curso X" | Depende de H5 — a pessoa escolheu o que expor |
