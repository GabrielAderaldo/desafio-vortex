# <Nome do Projeto>

> <Uma frase: o que a aplicação faz e para quem.>

Desafio técnico — **Laboratório Vortex**.

<Parágrafo curto ampliando a proposta: qual problema resolve, qual a decisão de
produto por trás e o que a torna diferente de um CRUD. Escreva para quem nunca viu
o projeto.>

## Sumário

- [Tecnologias](#tecnologias)
- [Pré-requisitos](#pré-requisitos)
- [Rodando localmente](#rodando-localmente)
- [Variáveis de ambiente](#variáveis-de-ambiente)
- [Estrutura do repositório](#estrutura-do-repositório)
- [Aplicação em produção](#aplicação-em-produção)
- [Diário de Bordo da IA](#-diário-de-bordo-da-ia)

---

## Tecnologias

### Backend

| Tecnologia | Versão | Por que foi escolhida |
|------------|--------|------------------------|
| _(ex: Node.js)_ | _(24.x)_ | |
| _(ex: NestJS)_ | | |
| _(ex: PostgreSQL)_ | | |
| _(ex: Prisma)_ | | |

### Frontend

| Tecnologia | Versão | Por que foi escolhida |
|------------|--------|------------------------|
| _(ex: React)_ | | |
| _(ex: Vite)_ | | |
| _(ex: Workbox / Service Worker)_ | | |
| _(ex: IndexedDB / Dexie)_ | | |

### Infraestrutura e ferramentas

| Ferramenta | Uso |
|------------|-----|
| _(ex: Docker Compose)_ | _(subir o banco localmente)_ |
| _(ex: GitHub Actions)_ | _(CI: lint, testes)_ |

> Preencher a coluna **"por que foi escolhida"** com uma linha honesta cada. É o que
> separa uma lista de dependências de uma decisão de arquitetura.

---

## Pré-requisitos

Antes de começar, garanta que tem instalado:

| Requisito | Versão mínima | Como verificar |
|-----------|---------------|----------------|
| Node.js | _(ex: 20.x)_ | `node -v` |
| _(gerenciador: pnpm / npm)_ | | `pnpm -v` |
| Docker + Docker Compose | | `docker -v` |
| _(banco, se não usar Docker)_ | | |

---

## Rodando localmente

### 1. Clonar o repositório

```bash
git clone <url-do-repositorio>
cd <nome-do-repositorio>
```

### 2. Backend

```bash
cd backend

# instalar dependências
<comando>

# subir o banco de dados
<comando>

# aplicar as migrations
<comando>

# popular com dados de exemplo (opcional)
<comando>

# iniciar em modo desenvolvimento
<comando>
```

O backend sobe em **http://localhost:PORTA**.
Documentação da API: **http://localhost:PORTA/ROTA**.

### 3. Frontend

Em outro terminal, com o backend rodando:

```bash
cd frontend

# instalar dependências
<comando>

# iniciar em modo desenvolvimento
<comando>
```

A aplicação abre em **http://localhost:PORTA**.

> **Sobre o PWA:** o Service Worker _(só registra em build de produção / também roda
> em dev — ajustar)_. Para testar o comportamento offline:
> ```bash
> <comando de build>
> <comando de preview>
> ```
> Depois, no DevTools → Application → Service Workers, marque **Offline**.

### 4. Testes

```bash
# backend
<comando>

# frontend
<comando>
```

---

## Variáveis de ambiente

Copie o arquivo de exemplo e preencha:

```bash
cp .env.example .env
```

| Variável | Obrigatória | Descrição | Exemplo |
|----------|-------------|-----------|---------|
| `DATABASE_URL` | sim | String de conexão do banco | `postgresql://user:pass@localhost:5432/db` |
| | | | |

> ⚠️ Nenhum valor real de credencial deve ser commitado. O `.env.example` contém
> apenas as chaves com valores fictícios.

---

## Estrutura do repositório

```
.
├── backend/           # <descrição>
├── frontend/          # <descrição>
├── docs/
│   └── ai-log/        # Diário de Bordo da IA — episódios completos
└── README.md
```

---

## Aplicação em produção

| Ambiente | URL | Hospedagem |
|----------|-----|------------|
| Frontend | _(preencher se houver deploy)_ | |
| API | _(preencher se houver deploy)_ | |

_(Deploy é opcional no desafio — remover esta seção se não houver.)_

---

## 🤖 Diário de Bordo da IA

Esta seção documenta como a IA generativa foi usada ao longo dos 15 dias de
desenvolvimento. O registro completo, episódio por episódio, está em
[`docs/ai-log/`](docs/ai-log/) — abaixo estão os casos mais representativos.

Cada episódio é rastreável no histórico do Git pelo trailer `AI-Log:`:

```bash
git log --grep="AI-Log" --oneline
```

### Ferramentas utilizadas

| Ferramenta | Onde foi usada | Por quê |
|------------|----------------|---------|
| _(ex: Claude Opus 5 via Claude Code)_ | _(ex: arquitetura do Service Worker, debug de migrations)_ | _(ex: melhor em raciocínio sobre estado assíncrono e leitura de codebase inteira)_ |
| _(ex: GitHub Copilot)_ | _(ex: boilerplate de DTOs e testes repetitivos)_ | _(ex: completar padrão já estabelecido, sem trocar de contexto)_ |
| _(ex: ChatGPT)_ | _(ex: segunda opinião sobre modelagem de dados)_ | _(ex: contraponto a uma decisão que eu já tinha tomado)_ |

### Estratégia de engenharia de prompts

O padrão que funcionou: **contexto denso antes da pergunta.** Colar o schema, o
stack trace e as constraints reais em vez de descrever o problema por cima.

#### 1. _(título — ex: Estruturação do Service Worker)_

**Situação:** _(o que estava travado)_

~~~
(prompt real, copiado de .ai-log/raw-prompts.md)
~~~

**Resultado:** _(o que veio, e o que eu aproveitei)_ · [episódio completo](docs/ai-log/)

#### 2. _(título — ex: Debug de constraint no PostgreSQL)_

**Situação:** _(...)_

~~~
(prompt real)
~~~

**Resultado:** _(...)_ · [episódio completo](docs/ai-log/)

#### 3. _(título)_

**Situação:** _(...)_

~~~
(prompt real)
~~~

**Resultado:** _(...)_ · [episódio completo](docs/ai-log/)

### Histórico de conversas

_(link público da conversa, se houver — ChatGPT e Claude.ai geram links de
compartilhamento. Transcripts exportados na íntegra ficam em
[`docs/ai-log/transcripts/`](docs/ai-log/transcripts/).)_

### Reflexão crítica

_(Um caso concreto e verificável em que a IA errou: API que não existe naquela
versão, race condition sugerida como solução, query que só quebra sob volume,
migration que roda em dev e falha em produção.)_

**O que a IA propôs:** _(...)_

**Como eu percebi o erro:** _(o sintoma que denunciou — teste falhando, log,
comportamento em produção, leitura da documentação oficial)_

**Como eu corrigi o rumo:** _(o contexto que faltava no prompt, ou a decisão de
descartar a sugestão e seguir por outro caminho)_

**O que isso mudou no meu uso da ferramenta:** _(...)_

_(Registro detalhado: [docs/ai-log/](docs/ai-log/))_

---

## Autor

**Gabriel Vieira Soriano Aderaldo**
[GitHub](https://github.com/GabrielAderaldo)
