#!/usr/bin/env python3
"""Converte o TXT extraído do PDF de Lean UX em Markdown navegável.

Texto extraído de PDF vem com marca d'água em toda página, números de página
soltos, hifenização de fim de linha e indentação de coluna. Isso atrapalha tanto
a leitura quanto o `grep` — "develop-\\nment" nunca casa com "development".

Uso:
    python3 scripts/split-lean-ux.py <arquivo.txt> [destino]
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

# (linha de início no arquivo original, slug, título)
#
# As linhas são as do marcador "C hap t er N" que o PDF imprime na abertura de cada
# capítulo — não a do título. Usar a linha do título deixava o parágrafo final do
# capítulo anterior vazar para o arquivo seguinte.
CAPITULOS = [
    (1,    "00-front-matter",                  "Front matter — elogios, sumário, prefácio"),
    (603,  "01-why-lean-ux",                   "1. Why Lean UX?"),
    (677,  "02-principles",                    "2. Principles"),
    (1110, "03-vision-framing-outcomes",       "3. Vision, Framing, and Outcomes"),
    (1678, "04-collaborative-design",          "4. Collaborative Design"),
    (2439, "05-mvps-and-experiments",          "5. MVPs and Experiments"),
    (3087, "06-feedback-and-research",         "6. Feedback and Research"),
    (3790, "07-integrating-lean-ux-and-agile", "7. Integrating Lean UX and Agile"),
    (4251, "08-making-organizational-shifts",  "8. Making Organizational Shifts"),
    (4941, "09-index",                         "Índice remissivo do livro"),
]

SECAO = {
    "01-why-lean-ux": "I — Introduction and Principles",
    "02-principles": "I — Introduction and Principles",
    "03-vision-framing-outcomes": "II — Process",
    "04-collaborative-design": "II — Process",
    "05-mvps-and-experiments": "II — Process",
    "06-feedback-and-research": "II — Process",
    "07-integrating-lean-ux-and-agile": "III — Making It Work",
    "08-making-organizational-shifts": "III — Making It Work",
}

RUIDO = re.compile(r"^\s*(www\.it-ebooks\.info|\d+\s*)$")

# O PDF imprime o marcador de abertura com espaços entre as letras ("C hap t er 2").
# Já viramos o título em H1, então a linha é redundante.
MARCADOR_CAPITULO = re.compile(r"^\s*C\s*h\s*a\s*p\s*t\s*e\s*r\s+\d+\s*$", re.I)


def limpar(linhas: list[str]) -> str:
    """Remove ruído de extração e refaz parágrafos."""
    saida: list[str] = []
    for linha in linhas:
        if RUIDO.match(linha) or MARCADOR_CAPITULO.match(linha):
            continue
        # Cabeçalho/rodapé: número de página colado ao título corrente.
        if re.match(r"^\s*\d+\s+(Chapter|Section|Contents|Index|Lean UX)\b", linha):
            continue
        if re.match(r"^\s*(Chapter|Section)\s+\w+\s+\d+\s*$", linha):
            continue
        saida.append(linha.rstrip())

    texto = "\n".join(saida)

    # Hifenização de fim de linha: "develop-\nment" -> "development".
    texto = re.sub(r"(\w)-\n\s*(\w)", r"\1\2", texto)
    # Indentação de coluna do PDF, preservando linhas em branco.
    texto = re.sub(r"\n[ \t]+", "\n", texto)
    # Colapsa 3+ linhas em branco em 2.
    texto = re.sub(r"\n{3,}", "\n\n", texto)
    return texto.strip()


def main() -> int:
    if len(sys.argv) < 2:
        print(__doc__, file=sys.stderr)
        return 2

    origem = Path(sys.argv[1]).expanduser()
    if not origem.is_file():
        print(f"erro: não encontrei {origem}", file=sys.stderr)
        return 2

    destino = Path(sys.argv[2]).expanduser() if len(sys.argv) > 2 else Path(
        "docs/handbook/offline-reference/lean-ux"
    )
    destino.mkdir(parents=True, exist_ok=True)

    # `splitlines()` também quebra em form feed (\f), vertical tab e U+2028. Este PDF
    # tem 151 form feeds — um por página —, o que dava 5.377 linhas contra as 5.227 do
    # grep/awk de onde vêm os marcadores acima. Dividir só em \n mantém a numeração
    # alinhada com a das ferramentas de linha de comando.
    linhas = origem.read_text(encoding="utf-8", errors="replace").split("\n")

    gerados = []
    for i, (inicio, slug, titulo) in enumerate(CAPITULOS):
        fim = CAPITULOS[i + 1][0] - 1 if i + 1 < len(CAPITULOS) else len(linhas)
        corpo = limpar(linhas[inicio - 1 : fim])

        cabecalho = [f"# {titulo}", ""]
        if slug in SECAO:
            cabecalho += [f"> **Seção {SECAO[slug]}** · Lean UX, Gothelf & Seiden", ""]
        cabecalho += ["---", ""]

        arquivo = destino / f"{slug}.md"
        arquivo.write_text("\n".join(cabecalho) + corpo + "\n", encoding="utf-8")
        gerados.append((slug, titulo, len(corpo.split()), arquivo))

    for slug, titulo, palavras, arq in gerados:
        print(f"  {arq.name:<40} {palavras:>6} palavras")
    print(f"✅ {len(gerados)} arquivos em {destino}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
