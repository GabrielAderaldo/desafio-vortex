# Offline Reference

Documentação das tecnologias usadas no projeto, baixada localmente — para consultar
sem depender de rede e sem gastar ida e volta à internet a cada dúvida de API.

## ⚠️ O conteúdo desta pasta NÃO vai para o Git

Só sobem este `README.md` e o `.gitkeep`. Tudo o mais aqui é ignorado, por três motivos:

1. **Licença alheia.** Documentação de terceiros tem licença própria; redistribuir
   dentro deste repositório não é nosso direito de decidir.
2. **Peso.** Um único mirror de documentação passa fácil de centenas de megabytes.
3. **Ruído.** Milhares de arquivos que ninguém escreveu poluem todo `git diff`,
   `git log --stat` e busca no repositório.

A regra está em `.gitignore`, na seção do handbook.

## Organização sugerida

```
offline-reference/
├── <tecnologia>/
│   ├── FONTE.md      # de onde veio, versão, data — recomendado
│   └── ...
```

O `FONTE.md` importa mais do que parece: documentação offline **envelhece em silêncio**.
Sem saber de qual versão ela é, você acaba lendo a API de uma major anterior e
depurando um erro que não existe. Registre versão e data.

## Como popular

Depende da tecnologia. Padrões que funcionam bem:

| Origem | Como obter |
|--------|------------|
| Site de docs estático | `wget --mirror --convert-links --page-requisites --no-parent -P <pasta> <url>` |
| Repositório com `docs/` | `git clone --depth 1 <repo>` e manter só a pasta de documentação |
| Pacote npm/PyPI | A documentação costuma vir junto em `node_modules/<pkg>/README.md` |
| Especificações (RFC, WHATWG, W3C) | Download direto do `.txt`/`.html` da fonte oficial |

O `wget` já está instalado nesta máquina.

## Nota sobre uso com IA

Documentação local é consultável por leitura de arquivo, sem chamada de rede. Na
prática isso significa respostas ancoradas na **versão exata** que o projeto usa, em
vez de na versão mais popular na internet — que é justamente a origem do erro clássico
de "API que não existe nesta versão".

Se um episódio do [Diário de Bordo](../../ai-log/) nascer disso, vale registrar: é
exatamente o tipo de ajuste de processo que a seção de reflexão crítica do README pede.
