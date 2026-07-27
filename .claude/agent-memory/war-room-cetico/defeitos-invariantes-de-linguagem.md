---
name: defeitos-invariantes-de-linguagem
description: Modo de falha recorrente deste projeto — o defeito real é de especificação, e sobrevive a qualquer port
metadata:
  type: project
---

Todo defeito reproduzível encontrado no harness em 2026-07-26 é **invariante de linguagem**:
reescrever o arquivo em TS ou Python entrega o mesmo bug.

**Why:** o round inteiro discutiu "qual linguagem" e nenhum dos defeitos tem causa na
linguagem. Migrar daria sensação de conserto sem consertar nada.

**How to apply:** quando alguém propuser trocar a linguagem de um script deste repo, exigir
primeiro que o defeito seja escrito como caso de teste. Se o caso falha igual no destino,
a migração não é o conserto.

- **Bypass de imutabilidade do ADR em 2 passos.** `somente_campos_permitidos` libera
  qualquer Edit cujo old/new só toquem `status:`/`substituido_por:` — inclusive
  `status: aceito` → `status: proposto`. Depois disso o ADR está "aberto" e todo o corpo
  fica editável. Nenhuma condição exótica: um Edit normal. Reproduzido.
- **A mensagem de deny promete mais do que o hook entrega.** Diz "não pode ser editado nem
  apagado", mas o matcher é `Edit|Write|MultiEdit` — `Bash(rm ...)` não passa pelo hook, e
  `Bash(just *)` está no allow.
- **Formato do `.ai-log` não é parseável.** O delimitador de entrada é `### `, e prompts
  colados já contêm `### ` — 11 colisões no arquivo atual. O arquivo é gitignored e é a
  única fonte da seção do README que é entregável.
- **`exit 0` sempre** no `adr-guard.sh` transforma qualquer falha de parse em "permitido".

Ver [[objecoes-encerradas-com-evidencia]].
