#!/usr/bin/env python3
"""Gera docs/pipeline/INDEX.md e audita as invariantes da pipeline W0→W3.

Substitui a máquina de estado com CLI dedicada por leitura do front-matter dos
tickets — o mesmo mecanismo já usado pelos ADRs. O estado vive num único lugar (o
arquivo do ticket), e as invariantes são verificadas aqui em vez de impostas por
comandos que ninguém lembra a sintaxe.

Uso:
    python3 scripts/pipeline-index.py           # gera o índice
    python3 scripts/pipeline-index.py --check   # não escreve; sai 1 se houver problema
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
DIR = RAIZ / "docs" / "pipeline"
SAIDA = DIR / "INDEX.md"

WAVES = ["W0", "W1", "W2", "W3"]
MAX_ROUNDS = 3

# status → (rótulo, wave que deveria estar em andamento)
ROTULO = {
    "aberto": "⚪ Aberto",
    "w0": "🔴 W0 · RED",
    "w1": "🟢 W1 · GREEN",
    "w2": "🔍 W2 · REVIEW",
    "w3": "🟡 W3 · QUALITY",
    "verde": "✅ Fechado verde",
    "rejeitado": "🔴 Fechado rejeitado",
    "bloqueado": "🚧 Bloqueado",
}
FECHADOS = {"verde", "rejeitado"}
OUTCOME_ESPERADO = {
    "W0": {"RED"},
    "W1": {"GREEN"},
    "W2": {"APROVADO", "REJEITADO"},
    "W3": {"VERDE", "ALL-GREEN"},
}


def parse_front_matter(texto: str) -> dict:
    """Parser mínimo: escalares, listas inline e o bloco aninhado `waves`."""
    m = re.match(r"^---[ \t]*\n(.*?)\n---[ \t]*\n", texto, re.DOTALL)
    if not m:
        return {}

    dados: dict = {}
    dentro_waves = False
    for linha in m.group(1).splitlines():
        if not linha.strip() or linha.lstrip().startswith("#"):
            continue

        if re.match(r"^\s+W[0-3]\s*:", linha) and dentro_waves:
            chave, _, valor = linha.partition(":")
            wave = chave.strip()
            campos = {}
            for par in re.findall(r"(\w+)\s*:\s*([^,}]+)", valor):
                k, v = par[0], par[1].strip().strip("\"'")
                campos[k] = None if v.lower() in {"null", "none", "~"} else v
            dados.setdefault("waves", {})[wave] = campos
            continue

        if not linha.startswith((" ", "\t")):
            dentro_waves = False

        if ":" not in linha:
            continue
        chave, _, valor = linha.partition(":")
        chave = chave.strip()
        valor = re.sub(r"\s+#.*$", "", valor).strip().strip("\"'")

        if chave == "waves" and not valor:
            dentro_waves = True
            dados.setdefault("waves", {})
            continue
        if valor.startswith("[") and valor.endswith("]"):
            miolo = valor[1:-1].strip()
            dados[chave] = [v.strip().strip("\"'") for v in miolo.split(",") if v.strip()] if miolo else []
        elif valor.lower() in {"null", "none", "~", ""}:
            dados[chave] = None
        else:
            dados[chave] = valor
    return dados


def carregar() -> list[dict]:
    tickets = []
    for caminho in sorted(DIR.glob("TCK-*.md")):
        fm = parse_front_matter(caminho.read_text(encoding="utf-8"))
        if not fm:
            print(f"aviso: {caminho.name} sem front-matter — ignorado", file=sys.stderr)
            continue
        fm["_arquivo"] = caminho.name
        tickets.append(fm)
    return tickets


def auditar(tickets: list[dict]) -> list[str]:
    """As invariantes que a CLI de estado impunha, verificadas por leitura."""
    problemas = []
    vistos = set()

    for t in tickets:
        ident = t.get("id", "?")
        arq = t["_arquivo"]
        status = (t.get("status") or "").lower()
        waves = t.get("waves") or {}

        if ident in vistos:
            problemas.append(f"{arq}: id `{ident}` duplicado")
        vistos.add(ident)

        if status not in ROTULO:
            problemas.append(f"{ident}: status desconhecido `{status}`")
            continue

        concluidas = [w for w in WAVES if (waves.get(w) or {}).get("outcome")]

        # Invariante 1 — não se pula wave: a sequência concluída não pode ter buraco.
        for i, w in enumerate(WAVES):
            tem = w in concluidas
            anterior_falta = i > 0 and WAVES[i - 1] not in concluidas
            if tem and anterior_falta:
                problemas.append(
                    f"{ident}: {w} concluída com {WAVES[i-1]} pendente — wave pulada")

        # Invariante 2 — outcome coerente com a wave.
        for w in WAVES:
            out = (waves.get(w) or {}).get("outcome")
            if out and out.upper() not in OUTCOME_ESPERADO[w]:
                esperado = " ou ".join(sorted(OUTCOME_ESPERADO[w]))
                problemas.append(f"{ident}: {w} com outcome `{out}` (esperado: {esperado})")

        # Invariante 3 — máximo de rounds.
        for w in WAVES:
            try:
                r = int((waves.get(w) or {}).get("rounds") or 0)
            except ValueError:
                problemas.append(f"{ident}: {w} com rounds não numérico")
                continue
            if r > MAX_ROUNDS:
                problemas.append(
                    f"{ident}: {w} com {r} rounds (máximo {MAX_ROUNDS}) — deveria ter escalado")

        # Invariante 4 — fechar exige as quatro waves.
        if status in FECHADOS and len(concluidas) < 4:
            faltam = [w for w in WAVES if w not in concluidas]
            problemas.append(
                f"{ident}: status `{status}` com waves pendentes: {', '.join(faltam)}")

        # Invariante 5 — fechado precisa de data de fechamento, e vice-versa.
        if status in FECHADOS and not t.get("fechado"):
            problemas.append(f"{ident}: fechado sem campo `fechado` preenchido")
        if t.get("fechado") and status not in FECHADOS:
            problemas.append(f"{ident}: tem `fechado` mas status é `{status}`")

        # Invariante 6 — W2 rejeitado não pode estar em status verde.
        # `.get(k, "")` não protege: a chave existe com valor None, então o default
        # não é usado. Daí o `or ""`.
        w2_out = ((waves.get("W2") or {}).get("outcome") or "").upper()
        if w2_out == "REJEITADO" and status == "verde":
            problemas.append(f"{ident}: W2 REJEITADO mas o ticket está `verde`")

    return problemas


def montar(tickets: list[dict], problemas: list[str]) -> str:
    L = ["# Índice da pipeline", "",
         "> **Arquivo gerado — não edite à mão.** Regenerar com `just pipeline-index`.", ""]

    if not tickets:
        L += ["Nenhum ticket ainda. Copie `_TEMPLATE.md` para criar o primeiro.", ""]
        return "\n".join(L)

    abertos = [t for t in tickets if (t.get("status") or "").lower() not in FECHADOS]
    verdes = [t for t in tickets if (t.get("status") or "").lower() == "verde"]

    L.append(f"{len(tickets)} tickets · **{len(abertos)} em andamento** · "
             f"{len(verdes)} fechados verdes")
    L.append("")

    def tabela(itens, titulo):
        L.append(f"## {titulo}")
        L.append("")
        if not itens:
            L.append("_Nenhum._")
            L.append("")
            return
        L.append("| ID | Ticket | Estado | W0 | W1 | W2 | W3 | Componentes |")
        L.append("|----|--------|--------|----|----|----|----|-------------|")
        for t in sorted(itens, key=lambda x: str(x.get("id"))):
            w = t.get("waves") or {}
            cel = []
            for k in WAVES:
                out = (w.get(k) or {}).get("outcome")
                rounds = (w.get(k) or {}).get("rounds") or "0"
                if not out:
                    cel.append("—")
                elif str(rounds) not in ("0", "1"):
                    cel.append(f"{out} ({rounds}×)")
                else:
                    cel.append(out)
            comp = ", ".join(f"`{c}`" for c in (t.get("componentes") or [])) or "—"
            L.append(f"| [{t.get('id')}]({t['_arquivo']}) | {t.get('titulo','—')} | "
                     f"{ROTULO.get((t.get('status') or '').lower(), t.get('status'))} | "
                     f"{' | '.join(cel)} | {comp} |")
        L.append("")

    tabela(abertos, "Em andamento")
    tabela([t for t in tickets if (t.get("status") or "").lower() in FECHADOS], "Fechados")

    if problemas:
        L += ["## ⚠️ Invariantes violadas", "",
              "A pipeline recusa estes estados. Corrija antes de seguir.", ""]
        L += [f"- {p}" for p in problemas] + [""]

    return "\n".join(L)


def main() -> int:
    if not DIR.is_dir():
        print(f"erro: {DIR} não existe", file=sys.stderr)
        return 2

    tickets = carregar()
    problemas = auditar(tickets)
    conteudo = montar(tickets, problemas)

    if "--check" in sys.argv:
        atual = SAIDA.read_text(encoding="utf-8") if SAIDA.exists() else ""
        if atual != conteudo:
            print("INDEX.md da pipeline desatualizado — rode: just pipeline-index",
                  file=sys.stderr)
            return 1
        if problemas:
            print(f"❌ {len(problemas)} invariante(s) violada(s):", file=sys.stderr)
            for p in problemas:
                print(f"   · {p}", file=sys.stderr)
            return 1
        print("pipeline: índice atualizado, invariantes ok.")
        return 0

    SAIDA.write_text(conteudo, encoding="utf-8")
    print(f"{SAIDA.relative_to(RAIZ)} gerado — {len(tickets)} ticket(s).")
    if problemas:
        print(f"⚠️  {len(problemas)} invariante(s) violada(s) — ver o índice.", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
