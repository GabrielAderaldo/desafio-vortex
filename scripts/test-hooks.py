#!/usr/bin/env python3
"""Testa os hooks do harness contra os casos que já quebraram.

Nasceu do EP-004: o `adr-guard` foi declarado testado três vezes, com oito casos
passando, e tinha um bypass alcançável com dois Edits normais. Os testes viviam em
mensagens de chat e morriam com elas — nada os re-executava.

Cada caso marcado como REGRESSÃO corresponde a um bug real já corrigido. Se um
deles voltar a falhar, o bug voltou.

Uso:
    python3 scripts/test-hooks.py           # roda tudo
    python3 scripts/test-hooks.py -v        # mostra cada caso
"""

from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
GUARD = RAIZ / ".claude/hooks/adr-guard.sh"
LOG_HOOK = RAIZ / ".claude/hooks/ai-log-prompt.sh"
STATUSLINE = RAIZ / ".claude/statusline.sh"

VERBOSE = "-v" in sys.argv
falhas: list[str] = []
total = 0


def resultado(nome: str, ok: bool, detalhe: str = "") -> None:
    global total
    total += 1
    if ok:
        if VERBOSE:
            print(f"  ✅ {nome}")
    else:
        falhas.append(f"{nome}{(' — ' + detalhe) if detalhe else ''}")
        print(f"  ❌ {nome}" + (f" — {detalhe}" if detalhe else ""))


def rodar(cmd: list[str], entrada: str, env: dict | None = None) -> tuple[int, str, str]:
    p = subprocess.run(cmd, input=entrada, capture_output=True, text=True,
                       env={**os.environ, **(env or {})})
    return p.returncode, p.stdout, p.stderr


def decisao(saida: str) -> str:
    """'deny', 'allow' (stdout vazio) ou 'JSON-INVÁLIDO'."""
    if not saida.strip():
        return "allow"
    try:
        return json.loads(saida)["hookSpecificOutput"]["permissionDecision"]
    except Exception:
        return "JSON-INVÁLIDO"


# ---------------------------------------------------------------- adr-guard ---

def adr_temp(base: Path, nome: str, status: str) -> Path:
    d = base / "docs/handbook/adr"
    d.mkdir(parents=True, exist_ok=True)
    p = d / nome
    p.write_text(
        f"---\nid: ADR-9001\ntitulo: Fixture\nstatus: {status}\n"
        f"substituido_por: null\n---\n\n# Corpo protegido\n",
        encoding="utf-8")
    return p


def testar_adr_guard(base: Path) -> None:
    print("adr-guard.sh")
    fechado = adr_temp(base, "ADR-9001-fechado.md", "aceito")
    aberto = adr_temp(base, "ADR-9002-aberto.md", "proposto")

    def edit(f, old, new):
        return json.dumps({"tool_name": "Edit", "tool_input": {
            "file_path": str(f), "old_string": old, "new_string": new}})

    def chamar(payload, env=None):
        return rodar([str(GUARD)], payload, env)

    # REGRESSÃO EP-004 nº1 — o bypass em dois passos.
    _, out, _ = chamar(edit(fechado, "status: aceito", "status: proposto"))
    resultado("REGRESSÃO: rebaixar aceito→proposto é negado",
              decisao(out) == "deny", f"obteve {decisao(out)}")

    for alvo in ("aceito", "rejeitado", "substituido"):
        _, out, _ = chamar(edit(fechado, "status: aceito", f"status: {alvo}"))
        esperado = "allow" if alvo == "substituido" else "deny"
        resultado(f"transição aceito→{alvo} = {esperado}",
                  decisao(out) == esperado, f"obteve {decisao(out)}")

    _, out, _ = chamar(edit(fechado, "status: aceito", "status: descontinuado"))
    resultado("transição aceito→descontinuado é permitida", decisao(out) == "allow")

    _, out, _ = chamar(edit(fechado, "substituido_por: null", "substituido_por: ADR-9010"))
    resultado("preencher substituido_por é permitido", decisao(out) == "allow")

    _, out, _ = chamar(edit(fechado, "Corpo protegido", "ADULTERADO"))
    resultado("editar o corpo de ADR fechado é negado", decisao(out) == "deny")

    # Misturar campo permitido com corpo, na mesma edição.
    _, out, _ = chamar(edit(fechado, "status: aceito", "status: substituido\nlinha extra"))
    resultado("status + corpo na mesma edição é negado", decisao(out) == "deny")

    for tool in ("Write", "MultiEdit"):
        payload = json.dumps({"tool_name": tool,
                              "tool_input": {"file_path": str(fechado), "content": "x"}})
        _, out, _ = chamar(payload)
        resultado(f"{tool} em ADR fechado é negado", decisao(out) == "deny")

    _, out, _ = chamar(edit(aberto, "Corpo protegido", "editado"))
    resultado("ADR proposto continua editável", decisao(out) == "allow")

    tpl = base / "docs/handbook/adr/_TEMPLATE.md"
    tpl.write_text("---\nstatus: aceito\n---\n", encoding="utf-8")
    _, out, _ = chamar(edit(tpl, "a", "b"))
    resultado("_TEMPLATE.md nunca é bloqueado", decisao(out) == "allow")

    fora = base / "README.md"
    fora.write_text("x", encoding="utf-8")
    _, out, _ = chamar(edit(fora, "x", "y"))
    resultado("arquivo fora de docs/handbook/adr é ignorado", decisao(out) == "allow")

    novo = base / "docs/handbook/adr/ADR-9099-inexistente.md"
    _, out, _ = chamar(json.dumps({"tool_name": "Write",
                                   "tool_input": {"file_path": str(novo), "content": "x"}}))
    resultado("criar ADR novo é permitido", decisao(out) == "allow")

    # REGRESSÃO EP-004 nº3 — aspas no nome quebravam o heredoc e geravam JSON
    # inválido, que o Claude Code descarta (fail-open).
    aspas = adr_temp(base, 'ADR-9003-com"aspas.md', "aceito")
    _, out, _ = chamar(json.dumps({"tool_name": "Write",
                                   "tool_input": {"file_path": str(aspas), "content": "x"}}))
    resultado("REGRESSÃO: nome com aspas produz JSON válido",
              decisao(out) == "deny", f"obteve {decisao(out)}")

    # REGRESSÃO EP-004 nº2 — sem jq o hook saía 0 (permitir). Deve sair 2 (bloquear).
    with tempfile.TemporaryDirectory() as bin_vazio:
        for prog in ("bash", "awk", "basename", "cat"):
            origem = shutil.which(prog)
            if origem:
                os.symlink(origem, Path(bin_vazio) / prog)
        code, _, _ = rodar(["/bin/bash", str(GUARD)],
                           json.dumps({"tool_name": "Write", "tool_input": {
                               "file_path": str(fechado)}}),
                           env={"PATH": bin_vazio})
        resultado("REGRESSÃO: sem jq no PATH sai 2 (falha fechada)",
                  code == 2, f"exit {code}")


# ------------------------------------------------------------ ai-log-prompt ---

def testar_ai_log(base: Path) -> None:
    print("ai-log-prompt.sh")
    proj = base / "proj-log"
    (proj / ".claude/hooks").mkdir(parents=True, exist_ok=True)
    hook = proj / ".claude/hooks/ai-log-prompt.sh"
    shutil.copy(LOG_HOOK, hook)
    hook.chmod(0o755)
    redactor = proj / ".claude/hooks/redact-secrets.pl"
    log = proj / ".ai-log/raw-prompts.md"

    def enviar(prompt: str) -> tuple[int, str]:
        code, out, _ = rodar(["/bin/bash", str(hook)],
                             json.dumps({"prompt": prompt, "cwd": str(proj),
                                         "session_id": "test1234"}),
                             env={"CLAUDE_PROJECT_DIR": str(proj)})
        return code, out

    def set_redactor(corpo: str) -> None:
        redactor.write_text(corpo, encoding="utf-8")
        redactor.chmod(0o755)

    set_redactor("#!/bin/sh\ncat\nexit 0\n")
    enviar("prompt normal de teste")
    conteudo = log.read_text(encoding="utf-8")
    resultado("prompt normal é gravado", "prompt normal de teste" in conteudo)
    resultado("entrada tem marcador parseável", "<!-- ai-log:entry -->" in conteudo)

    enviar("isto tem [NOLOG] dentro")
    conteudo = log.read_text(encoding="utf-8")
    resultado("[NOLOG] omite o conteúdo", "isto tem [NOLOG] dentro" not in conteudo)
    resultado("[NOLOG] registra o stub", "prompt omitido do log" in conteudo)

    # REGRESSÃO EP-004 nº5 — redactor falhando gravava fence VAZIO com timestamp
    # correto: a contagem de entradas batia e a perda passava despercebida.
    set_redactor("#!/bin/sh\nexit 3\n")
    antes = log.read_text(encoding="utf-8")
    _, out = enviar("prompt que se perderia em silêncio")
    depois = log.read_text(encoding="utf-8")
    novo = depois[len(antes):]
    resultado("REGRESSÃO: falha do redactor não grava fence vazio",
              "~~~\n\n~~~" not in novo and "~~~\n~~~" not in novo)
    resultado("REGRESSÃO: falha do redactor é registrada de forma visível",
              "PROMPT NÃO REGISTRADO" in novo)
    resultado("REGRESSÃO: falha do redactor avisa na UI", "systemMessage" in out)
    resultado("prompt não é gravado quando o redactor falha",
              "prompt que se perderia" not in novo)

    set_redactor("#!/bin/sh\ncat >/dev/null\nexit 0\n")
    antes = log.read_text(encoding="utf-8")
    enviar("redactor devolve vazio mas diz que deu certo")
    novo = log.read_text(encoding="utf-8")[len(antes):]
    resultado("saída vazia com exit 0 também é tratada como falha",
              "PROMPT NÃO REGISTRADO" in novo)

    set_redactor("#!/bin/sh\nsed 's/SEGREDO/[REDIGIDO]/'\nexit 9\n")
    antes = log.read_text(encoding="utf-8")
    enviar("chave SEGREDO exposta")
    novo = log.read_text(encoding="utf-8")[len(antes):]
    resultado("exit 9 grava o texto redigido", "[REDIGIDO]" in novo)
    resultado("exit 9 marca o aviso de credencial", "Credencial real detectada" in novo)


# --------------------------------------------------------------- statusline ---

def testar_statusline() -> None:
    print("statusline.sh")

    # REGRESSÃO EP-004 nº4 — o /bin/bash do macOS é 3.2, e `${arr[*]}` com array
    # vazio sob `set -u` é erro nele. O repo dependia do bash 5.x do brew.
    for shell, rotulo in (("/bin/bash", "bash 3.2 (de fábrica)"),
                          (shutil.which("bash") or "/bin/bash", "bash do PATH")):
        code, out, err = rodar([shell, str(STATUSLINE)], "{}")
        resultado(f"REGRESSÃO: JSON vazio não quebra em {rotulo}",
                  code == 0 and not err.strip(), err.strip()[:60])

        payload = json.dumps({"model": {"display_name": "M"},
                              "context": {"used_tokens": 340000, "total_tokens": 1000000}})
        code, out, err = rodar([shell, str(STATUSLINE)], payload)
        resultado(f"renderiza contexto em {rotulo}", "34%" in out and code == 0)

    # REGRESSÃO EP-004 nº4b — `$(( ))` expande variáveis; campo não-numérico
    # abortava o script e era vetor de execução de comando sem `set -u`.
    for valor in ('"abc"', '"a[$(touch /tmp/HOOK_PWNED)]"', '"-5"'):
        payload = '{"context":{"used_tokens":%s,"total_tokens":"100"}}' % valor
        code, _, err = rodar(["/bin/bash", str(STATUSLINE)], payload)
        resultado(f"REGRESSÃO: campo não-numérico ({valor[:14]}) não quebra",
                  code == 0 and not err.strip(), err.strip()[:60])
    resultado("REGRESSÃO: sem execução de comando via aritmética",
              not Path("/tmp/HOOK_PWNED").exists())
    Path("/tmp/HOOK_PWNED").unlink(missing_ok=True)

    code, _, err = rodar(["/bin/bash", str(STATUSLINE)], '{"context":{"used_tokens":5,"total_tokens":0}}')
    resultado("divisão por zero não quebra", code == 0 and not err.strip())

    code, _, err = rodar(["/bin/bash", str(STATUSLINE)], "isto não é json")
    resultado("entrada malformada não quebra", code == 0)


def main() -> int:
    for f in (GUARD, LOG_HOOK, STATUSLINE):
        if not f.is_file():
            print(f"erro: {f} não encontrado", file=sys.stderr)
            return 2

    with tempfile.TemporaryDirectory() as tmp:
        base = Path(tmp)
        testar_adr_guard(base)
        testar_ai_log(base)
        testar_statusline()

    print()
    if falhas:
        print(f"❌ {len(falhas)} de {total} casos falharam:")
        for f in falhas:
            print(f"   · {f}")
        return 1
    print(f"✅ {total} casos passaram")
    return 0


if __name__ == "__main__":
    sys.exit(main())
