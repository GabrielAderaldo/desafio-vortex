---
name: stack-persistencia-dart
description: dartonic_core funciona em SQLite e Postgres, mas o MESMO schema não roda nos dois; dartonic (0.0.15) está discontinued
metadata:
  type: project
---

# Persistência em Dart — medido em 2026-07-27

## O pacote `dartonic` está morto; o vivo é `dartonic_core`

`curl -s https://pub.dev/api/packages/dartonic/score` retorna tags
**`is:discontinued`** e **`is:unlisted`** (v0.0.15). Foi quebrado no monorepo
`dartonic_core` + drivers. Nunca recomendar `dartonic` pelo nome curto.

| Pacote | v | pub points | likes | dl/30d |
|---|---|---|---|---|
| dartonic_core | 1.0.1 | 150/160 | 2 | 135 |
| dartonic_postgres | 1.0.0 | 150/160 | 0 | 104 |
| dartonic_sqlite | 1.0.0 | **130/160** | 0 | 104 |
| dartonic (morto) | 0.0.15 | 140/160 | 18 | 167 |

Maduros de verdade, para comparação: `drift` 2.34.2, `sqlite3` 3.5.0,
`postgres` 3.5.12. `dartonic_sqlite` prende `sqlite3: ^2.7.5` — **uma major atrás**
(resolve 2.9.4 com aviso do pub).

## O mesmo schema NÃO roda nos dois bancos (verificado)

- `integer('id').primaryKey(autoIncrement: true)` → SQLite OK; no Postgres o DDL
  sai `id integer NOT NULL` **sem** `nextval`, e o INSERT explode em runtime com
  `23502 null value in column "id"`. Falha **tardia**.
- `serial('id').primaryKey()` → Postgres OK (`nextval('users_id_seq')`); no SQLite
  `connectSqlite` rejeita na conexão: `Column "users.id" uses SQL type "SERIAL"
  which is not supported by sqlite`. Falha **cedo** (melhor).

Consequência: escolher **um** banco, ou manter dois schemas. Não existe coluna
portátil de auto-incremento nessa versão.

## Outros fatos

- `postgres` 3.5.12 é **pure Dart** — nenhum `dart:ffi` em `lib/` (`grep -rl 'dart:ffi'`
  vazio). Compila em `FROM scratch` sem problema.
- `connectPostgres` **mantém o isolate vivo**: um script sem `db.close()`/`exit(0)`
  nunca termina. (Descobri travando um teste por 5 min.)
- Conectar+criar tabelas: SQLite `:memory:` 25 ms; Postgres em container ~100–150 ms.
- Constraint `unique` é aplicada nos dois (`UniqueViolationError`).

Ver [[stack-docker-dart]] para a armadilha do `libsqlite3.so`.
