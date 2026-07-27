<CRIE UM TITULO MAIOR> LABORATÓRIO VORTEX (UNIFOR)
<SUB-TITULO> Edital de Desafio Técnico — Processo Seletivo para Estágio Full-Stack
<SUB-SUB-TITULO> Projeto: Marketplace de Economia Circular (Desapego Universitário) | Prazo: 15 dias

---
<P1>Olá, candidato(a)! Seja muito bem-vindo(a) à etapa prática do processo seletivo para o Laboratório de
Inovação Vortex. Nosso objetivo com este desafio não é avaliar se você decorou sintaxe de código ou
se consegue criar um sistema perfeito sem ajuda, mas sim medir a sua capacidade de aprender,
resolver problemas, arquitetar soluções e entregar um produto funcional.

<P2>Sabemos que você pode estar no início do seu curso (seja ADS, Ciência da Computação, Engenharia
ou afins). Por isso, estruturamos este desafio para ser desafiador, porém perfeitamente realizável por
quem tem proatividade e vontade de pesquisar. Além disso, o uso de ferramentas de Inteligência
Artificial Generativa (como ChatGPT, Claude, Copilot, etc.) é explicitamente permitido e bemvindo, desde que utilizado de forma consciente e documentado, conforme explicaremos adiante.

 (TOPICO 01)
> 1. O Desafio: Marketplace de Economia Circular do Campus

<P1> Você deverá desenvolver uma plataforma web/mobile focada no desapego e na economia circular
dentro do ambiente universitário. O objetivo do sistema é permitir que estudantes cadastrem itens para
doação ou venda (livros, xerox, calculadoras científicas, componentes eletrônicos, jalecos, móveis, etc.),
facilitando o acesso a materiais para quem está ingressando na universidade.

<P2> O projeto deve ser concebido como uma aplicação única integrando uma API RESTful (Backend) e uma
interface responsiva instalável (Frontend PWA).

AQUI TEM COMENTÁRIOS FEITOS PELO GABRIEL, VIA `CANETA` EM SIMA DO PDF -> """ Pelas frases abaixo, eu decidi criar UM unico repositorio a nivel de mono-repo, para isso vou ter que usar sim uma tecnologia que me ajude a facilitar isso para mim, e sinceramente pensei em várias tecnologias GRANDES que dão isso 'de graça', atualmente estou em duvida entre o Deno moderno do 2.9.xx que tem uma boa ferramenta de Workspaces e monorepos, link de referencia:(https://docs.deno.com/runtime/fundamentals/workspaces/) OU dart que o propio .pubspec é INCRIVEL para separar packages e binários entre outras coisas. Porém sinto que se eu fizer em typescript/javascript pode ser o mais 'correto' para a natureza desse processo seletivo e usar dart 100% pode ser algo muito `rebelde` e pode ser visto com não bons olhos... """
<p1.1> 1.1. Escopo de Funcionalidades e Telas

- Landing Page Pública (Web/Desktop): Uma página de apresentação do projeto que explique a
proposta de economia circular no campus, exiba estatísticas simuladas do sistema e contenha uma
vitrine pública listando os últimos itens anunciados com filtros básicos por categoria (ex: Livros,
Engenharia, Computação). Deve conter botões claros de chamada para ação (CTA) convidando o
usuário a anunciar ou buscar itens.

- Aplicação Mobile (PWA - Progressive Web App): Quando acessado por um dispositivo móvel (ou
simulador), o sistema deve oferecer a experiência de um aplicativo nativo. O usuário autenticado ou
identificado deve ser capaz de preencher um formulário para anunciar um item (título, descrição,
categoria, preço ou indicação de doação, e uma URL de imagem simulada) e visualizar seus próprios
anúncios cadastrados.

> 2. Requisitos Técnicos do Projeto

<p1> Para garantir a equidade na avaliação e permitir que tanto candidatos iniciantes quanto avançados
demonstrem seu valor, dividimos os requisitos em critérios obrigatórios (mínimos) e diferenciais (bônus)

<p2.1> 2.1. Backend (API RESTful)
- Requisitos Mínimos (Obrigatórios):
Criação de uma API REST estruturada em qualquer linguagem ou framework de sua preferência
(Node.js/TypeScript, Python/FastAPI, Java/Spring Boot, C#/.NET, PHP, etc.).
Implementação dos endpoints básicos (CRUD) para gerenciamento de anúncios (criar, listar, filtrar
e deletar).
Persistência de dados funcional. Pode ser utilizado um banco de dados em arquivo (como SQLite)
ou em memória (estruturas de dados ou instâncias voláteis), desde que o sistema funcione
perfeitamente durante os testes.
Retorno e envio de dados estritamente no formato JSON.

- Requisitos Bônus (Diferenciais):
Autenticação básica de usuários (ex: JWT) ou separação por IDs de usuário.
Tratamento robusto de erros e validação de campos obrigatórios nas requisições.
Uso de banco de dados relacional ou não-relacional real em container ou nuvem (ex:
PostgreSQL, MongoDB). """ Basicamente está dizendo: (USE DOCKER E DOCKER COMPOSE), Até por que usar Kubernets para isso seria usar um tank Scorpion (halo references) para matar uma minhoca """

<p2.2> 2.2. Frontend & PWA
- Requisitos Mínimos (Obrigatórios):
 - Desenvolvimento da interface utilizando tecnologias web modernas (React, Vue.js, Angular ou
HTML5/CSS3/JavaScript puro bem estruturados).
 - Configuração de PWA: OBRIGATÓRIA a inclusão de um manifesto de aplicativo web válido (manifest.json) e um Service Worker básico que permita que a aplicação seja "instalada" na
tela inicial de um dispositivo mobile.
 - Responsividade Completa: A interface deve se adaptar perfeitamente de uma Landing Page rica
no desktop para uma experiência fluida de aplicativo no mobile. """ Aqui sinceramente é usar o desing de GRID 12 | 6 | 4, ou seja o famoso formato suiço de layout, mas vou pensar melhor nisso ainda né? """

- Requisitos Bônus (Diferenciais):
 - Estratégias de cache no Service Worker para funcionamento ou visualização offline de dados já
carregados
 - Utilização de TypeScript no Frontend. """ Isso que está fazendo eu inclinar para não ir para o DART total...  """
 - Interface polida com componentes visuais modernos, feedback visual de carregamento e
transições suaves """ Vou com toda a certeza usar alguma diretriz já criada de algum Design System pronto, como o do Notion, Material Design, ou o da Apple, mas seria bom pensar ainda... """

```![NOTE] (anotação do documento mesmo) 
Nota sobre Deploy: Realizar o deploy real da API (em serviços gratuitos como Render, Railway
ou Fly.io) e do Frontend (Vercel, Netlify ou GitHub Pages) e disponibilizar os links funcionais é
considerado um fortíssimo diferencial bônus e demonstra excelente desenvoltura técnica.
``` 
> 3. O Fator Inteligência Artificial e o "Diário de Bordo"

No mercado atual e no Laboratório Vortex, encaramos a IA Generativa como uma ferramenta
indispensável de produtividade. Não queremos proibir seu uso, pois sabemos que ela acelera o
aprendizado. Queremos avaliar como você a utiliza para resolver problemas complexos.
Para validar o uso correto e ético, é obrigatório que você mantenha e publique um Diário de Bordo da
IA. No arquivo README.md principal do seu repositório Git, você deverá criar uma seção dedicada a
documentar essa parceria, respondendo aos seguintes tópicos:
Ferramentas Utilizadas: Liste quais IAs você utilizou ao longo dos 15 dias (ex: ChatGPT, Claude,
GitHub Copilot, v0, Lovable, etc.).
Estratégia de Engenharia de Prompts: Forneça exemplos reais (copie e cole) de pelo menos 2 ou
3 prompts complexos que você escreveu para destravar o desenvolvimento (ex: como pediu para
estruturar o Service Worker do PWA ou como pediu ajuda para debugar um erro específico de banco
de dados).
Compartilhamento de Histórico (Opcional, mas recomendado): Se utilizou ferramentas que
permitem gerar links públicos de conversas (como ChatGPT ou Claude), inclua o link de pelo menos
um chat longo de desenvolvimento no qual você debateu arquitetura ou resolução de bugs com a IA.
Reflexão Crítica: Descreva brevemente um momento em que a IA gerou um código errado,
incompleto ou uma "alucinação", e explique como você identificou o erro e guiou a ferramenta para a
solução correta.

```![WARNING] (anotação do documento mesmo) 
Aviso Importante: Se a banca avaliadora identificar que o código foi 100% gerado por IA sem que
o candidato demonstre compreender a lógica implementada, ou caso o Diário de Bordo seja
omitido, a solução será severamente penalizada.
``` 
> 4. Regras de Entrega e Repositório Git

Toda a sua solução deve ser disponibilizada em um repositório público no GitHub ou GitLab até o
prazo final estabelecido pela organização do processo seletivo.
O repositório deve conter um arquivo README.md na raiz, escrito de forma clara e profissional para o
leitor, contendo obrigatoriamente:
Título do projeto e uma descrição resumida da proposta.
Instruções passo a passo de como rodar o Backend e o Frontend localmente (pré-requisitos,
comandos de instalação de dependências e comandos de execução).
Relação de tecnologias, frameworks e bibliotecas principais adotadas.
O Diário de Bordo da IA preenchido conforme as diretrizes da Seção 3.
Links para a aplicação rodando em produção (caso tenha feito o deploy opcional).

> 5. Processo de Avaliação: O Vídeo Prático

A avaliação técnica não considerará apenas a leitura fria do código. O principal critério de triagem e
validação da autoria do projeto será a entrega de um vídeo com duração máxima e estrita de 6
minutos. Você deve hospedar este vídeo em uma plataforma acessível (YouTube como não-listado,
Google Drive com permissão pública de visualização, Loom ou Vimeo) e incluir o link no formulário de
submissão do processo seletivo.
O tempo do vídeo deve ser rigorosamente dividido e planejado de acordo com a seguinte estrutura
cronometrada:
Tempo Alocado Conteúdo Exigido O que a Banca vai Avaliar
Minuto 0:00 a 1:00
(1 minuto)
Pitch e Visão Geral
Apresentação pessoal e
contextualização rápida da sua
proposta de marketplace para o
campus.
Capacidade de síntese, comunicação
clara e entendimento do problema de
negócio proposto.
Minuto 1:00 a 3:00
(2 minutos)
Demonstração Prática (Demo)
Gravação da tela mostrando a
Landing Page no desktop e, em
seguida, simulando a navegação
mobile (ou direto no celular)
testando as funcionalidades do
PWA (criar anúncio, listar e instalar
na tela inicial).
Funcionalidade real do sistema, interface
do usuário (UI/UX), responsividade e
validação do funcionamento como PWA.
Minuto 3:00 a 5:00
(2 minutos)
Explicação Técnica do Código
Abertura do VS Code. Você deve
guiar a banca pela arquitetura das
pastas, mostrar as principais rotas
do backend e a lógica do Service
Worker ou manipulação de estado
do frontend.
Domínio técnico, organização de código,
clareza na explicação lógica e
comprovação de autoria do
desenvolvimento.
Minuto 5:00 a 6:00
(1 minuto)
Uso Prático da Inteligência
Artificial
Explicação de como a IA foi
integrada na sua rotina de
desenvolvimento. Mostre no
README ou no navegador os
prompts ou discussões marcantes
e como você refinou os retornos da
IA.
Maturidade no uso de ferramentas de IA
generativa, senso crítico para corrigir
erros da IA e capacidade de curadoria

> 6.  Resumo dos Critérios de Avaliação

A nota final do seu desafio técnico será composta pela média ponderada dos seguintes eixos:
Qualidade e Completude da Entrega (Git & README): Organização do código, clareza das
instruções de execução e preenchimento correto do Diário de Bordo da IA.
Domínio Técnico e Autoria (Vídeo - Trecho de Código): Capacidade de explicar o próprio código
com propriedade, demonstrando que de fato compreende a lógica de programação subjacente à
solução gerada.
Atendimento aos Requisitos Obrigatórios: Funcionamento correto das rotas REST no backend e
cumprimento das diretrizes de responsividade e PWA no frontend.
Uso Inteligente e Curadoria de IA: Avaliação se o candidato usou a IA como um catalisador de
conhecimento ou apenas como um gerador automatizado cego, punindo cópias sem critério e
valorizando o uso analítico.
Desejamos muito sucesso no desenvolvimento da sua solução. Use os 15 dias para explorar
novas tecnologias, errar rápido, corrigir com apoio da IA e construir algo do qual você se
orgulhe! Nos vemos na banca de avaliação.


