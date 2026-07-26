#!/usr/bin/env python3
"""Gera docs/handbook/adr/INDEX.md a partir do front-matter dos ADRs.

Sem dependências externas: o front-matter dos ADRs é controlado pelo template
(escalares e listas inline), então um parser mínimo basta e o script roda em
qualquer Python 3 — inclusive em CI limpa.

Uso:
    python3 scripts/adr-index.py           # escreve o INDEX.md
    python3 scripts/adr-index.py --check   # não escreve; sai 1 se desatualizado
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
DIR_ADR = RAIZ / "docs" / "handbook" / "adr"
SAIDA = DIR_ADR / "INDEX.md"

FECHADOS = {"aceito", "rejeitado", "descontinuado", "substituido"}

ROTULO = {
    "proposto": "🟡 Proposto",
    "aceito": "🟢 Aceito",
    "rejeitado": "🔴 Rejeitado",
    "descontinuado": "⚫ Descontinuado",
    "substituido": "🔵 Substituído",
}


def parse_front_matter(texto: str) -> dict:
    """Extrai o primeiro bloco --- ... --- como dicionário."""
    m = re.match(r"^---[ \t]*\n(.*?)\n---[ \t]*\n", texto, re.DOTALL)
    if not m:
        return {}

    dados: dict = {}
    for linha in m.group(1).splitlines():
        if not linha.strip() or linha.lstrip().startswith("#"):
            continue
        if ":" not in linha:
            continue
        chave, _, valor = linha.partition(":")
        chave = chave.strip()
        valor = re.sub(r"\s+#.*$", "", valor).strip().strip("\"'")

        if valor.startswith("[") and valor.endswith("]"):
            miolo = valor[1:-1].strip()
            dados[chave] = [
                v.strip().strip("\"'") for v in miolo.split(",") if v.strip()
            ] if miolo else []
        elif valor.lower() in {"null", "none", "~", ""}:
            dados[chave] = None
        else:
            dados[chave] = valor
    return dados


def carregar_adrs() -> list[dict]:
    adrs = []
    for caminho in sorted(DIR_ADR.glob("ADR-*.md")):
        fm = parse_front_matter(caminho.read_text(encoding="utf-8"))
        if not fm:
            print(f"aviso: {caminho.name} sem front-matter — ignorado", file=sys.stderr)
            continue
        fm["_arquivo"] = caminho.name
        fm.setdefault("id", caminho.stem.split("-")[0] + "-" + caminho.stem.split("-")[1])
        adrs.append(fm)
    return adrs


def verificar_consistencia(adrs: list[dict]) -> list[str]:
    """Detecta o que um índice manual esconderia."""
    problemas = []
    por_id = {}

    for a in adrs:
        ident = a.get("id", "?")
        if ident in por_id:
            problemas.append(
                f"ID duplicado `{ident}`: {por_id[ident]['_arquivo']} e {a['_arquivo']}"
            )
        por_id[ident] = a

    for a in adrs:
        ident, arq = a.get("id", "?"), a["_arquivo"]

        for alvo in a.get("substitui") or []:
            destino = por_id.get(alvo)
            if destino is None:
                problemas.append(f"{ident} declara `substitui: {alvo}`, que não existe")
            elif destino.get("substituido_por") != ident:
                problemas.append(
                    f"{ident} substitui {alvo}, mas {alvo} não tem "
                    f"`substituido_por: {ident}` (elo quebrado)"
                )
            elif destino.get("status") != "substituido":
                problemas.append(
                    f"{alvo} foi substituído por {ident}, mas seu status é "
                    f"`{destino.get('status')}` em vez de `substituido`"
                )

        por = a.get("substituido_por")
        if por:
            origem = por_id.get(por)
            if origem is None:
                problemas.append(f"{ident} aponta `substituido_por: {por}`, que não existe")
            elif ident not in (origem.get("substitui") or []):
                problemas.append(
                    f"{ident} diz ser substituído por {por}, mas {por} não o lista "
                    f"em `substitui` (elo quebrado)"
                )
        elif a.get("status") == "substituido":
            problemas.append(f"{ident} tem status `substituido` sem `substituido_por`")

        if a.get("status") not in ROTULO:
            problemas.append(f"{ident} tem status desconhecido: `{a.get('status')}`")

    return problemas


def montar(adrs: list[dict]) -> str:
    L: list[str] = []
    L.append("# Índice de ADRs")
    L.append("")
    L.append(
        "> **Arquivo gerado — não edite à mão.** Regenerar com "
        "`python3 scripts/adr-index.py`."
    )
    L.append("")

    if not adrs:
        L.append("Nenhum ADR registrado ainda. Use `_TEMPLATE.md` para criar o primeiro.")
        L.append("")
        return "\n".join(L)

    ativos = [a for a in adrs if a.get("status") == "aceito"]
    L.append(
        f"{len(adrs)} decisões registradas · **{len(ativos)} em vigor** · "
        f"{len(adrs) - len(ativos)} fora de vigor"
    )
    L.append("")

    # --- Em vigor ---
    L.append("## Em vigor")
    L.append("")
    if ativos:
        L.append("| ID | Decisão | Data | Componentes | Tags |")
        L.append("|----|---------|------|-------------|------|")
        for a in sorted(ativos, key=lambda x: str(x.get("id"))):
            comp = ", ".join(f"`{c}`" for c in (a.get("componentes") or [])) or "—"
            tags = ", ".join(f"`{t}`" for t in (a.get("tags") or [])) or "—"
            L.append(
                f"| [{a.get('id')}]({a['_arquivo']}) | {a.get('titulo', '—')} | "
                f"{a.get('data', '—')} | {comp} | {tags} |"
            )
    else:
        L.append("_Nenhuma decisão em vigor._")
    L.append("")

    # --- Histórico completo ---
    L.append("## Histórico completo")
    L.append("")
    arquivo_de = {str(a.get("id")): a["_arquivo"] for a in adrs}

    def link(ident: str) -> str:
        """Link para o arquivo do ADR; texto simples se o ID não existir."""
        alvo = arquivo_de.get(str(ident))
        return f"[{ident}]({alvo})" if alvo else f"`{ident}` ⚠️"

    L.append("| ID | Decisão | Status | Data | Substitui | Substituído por |")
    L.append("|----|---------|--------|------|-----------|-----------------|")
    for a in sorted(adrs, key=lambda x: str(x.get("id"))):
        status = a.get("status", "?")
        subs = ", ".join(link(s) for s in (a.get("substitui") or [])) or "—"
        por = link(a["substituido_por"]) if a.get("substituido_por") else "—"
        L.append(
            f"| [{a.get('id')}]({a['_arquivo']}) | {a.get('titulo', '—')} | "
            f"{ROTULO.get(status, status)} | {a.get('data', '—')} | {subs} | {por} |"
        )
    L.append("")

    # --- Grafo de supersessão ---
    elos = [
        (a.get("id"), alvo)
        for a in adrs
        for alvo in (a.get("substitui") or [])
    ]
    if elos:
        L.append("## Grafo de supersessão")
        L.append("")
        L.append("Como o projeto mudou de ideia, e em que ordem.")
        L.append("")
        L.append("```mermaid")
        L.append("flowchart RL")
        envolvidos = {i for par in elos for i in par}
        for a in sorted(adrs, key=lambda x: str(x.get("id"))):
            ident = a.get("id")
            if ident not in envolvidos:
                continue
            titulo = str(a.get("titulo", ""))[:40].replace('"', "'")
            L.append(f'  {str(ident).replace("-", "_")}["{ident}<br/>{titulo}"]')
        for novo, velho in elos:
            L.append(
                f'  {str(novo).replace("-", "_")} -->|substitui| '
                f'{str(velho).replace("-", "_")}'
            )
        L.append("```")
        L.append("")

    # --- Índices auxiliares ---
    for campo, titulo in (("componentes", "Por componente"), ("tags", "Por tag")):
        mapa: dict[str, list[str]] = {}
        for a in adrs:
            for v in a.get(campo) or []:
                mapa.setdefault(v, []).append(str(a.get("id")))
        if mapa:
            L.append(f"## {titulo}")
            L.append("")
            for chave in sorted(mapa):
                L.append(f"- **`{chave}`** — {', '.join(sorted(mapa[chave]))}")
            L.append("")

    problemas = verificar_consistencia(adrs)
    if problemas:
        L.append("## ⚠️ Inconsistências")
        L.append("")
        L.append("Corrija criando o ADR faltante ou ajustando os elos de supersessão.")
        L.append("")
        for p in problemas:
            L.append(f"- {p}")
        L.append("")

    return "\n".join(L)


def main() -> int:
    if not DIR_ADR.is_dir():
        print(f"erro: {DIR_ADR} não existe", file=sys.stderr)
        return 2

    adrs = carregar_adrs()
    conteudo = montar(adrs)

    if "--check" in sys.argv:
        atual = SAIDA.read_text(encoding="utf-8") if SAIDA.exists() else ""
        if atual != conteudo:
            print("INDEX.md desatualizado — rode: python3 scripts/adr-index.py",
                  file=sys.stderr)
            return 1
        print("INDEX.md atualizado.")
        return 0

    SAIDA.write_text(conteudo, encoding="utf-8")
    problemas = verificar_consistencia(adrs)
    print(f"{SAIDA.relative_to(RAIZ)} gerado — {len(adrs)} ADR(s).")
    if problemas:
        print(f"⚠️  {len(problemas)} inconsistência(s) registrada(s) no índice.",
              file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
