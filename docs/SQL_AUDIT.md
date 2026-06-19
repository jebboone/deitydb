# DeityDB — SQL & Database Practices Audit

**Date:** 2026-06-19 · **Scope:** runtime query layer (`plugins/deitydb_api.py`), the
`gen_*.py` cohort generators, the `.sql` script corpus, and schema/migration management.

## Verdict

The part that matters most for safety — the **public, internet-facing query layer — is in
good shape**: every query is parameterised and read-only. The real gap is **process, not
query craft**: there was no migration ledger for schema changes, and the generators built
SQL with a hand-rolled quoter that mishandled a few edge cases.

A common worry worth dispelling up front: **`JOIN`s and `ON CONFLICT` "merges" are not
problems here.** A `JOIN` is the correct, idiomatic way to combine related tables, and
`ON CONFLICT DO NOTHING` is the standard idempotent-upsert pattern. They are best practice,
not shortcuts to replace with a "tool."

## What's already done well

- **Parameterised runtime queries.** `deitydb_api.py` uses `?` placeholders with values
  passed separately, everywhere — including dynamically-assembled `WHERE` clauses and the
  BFS path-finder's `IN (...)` lists. A targeted search for request data formatted directly
  into SQL found **zero** instances. No SQL-injection exposure.
- **Read-only surface.** The live API runs over Datasette in read-only mode.
- **A real tool where it counts.** PostgreSQL → SQLite export uses `db-to-sqlite`, not a
  hand-rolled dumper.
- **Disciplined generated SQL.** `build_*.sql` scripts wrap work in transactions, stage rows
  in temp tables, validate with `EXISTS`, print REJECTED rows, and are idempotent via
  `ON CONFLICT`. Better hygiene than typical hand-written SQL.
- **Correct decision to skip an ORM.** For a read-only Datasette app with bulk-SQL loading,
  an ORM (SQLAlchemy/Django) would add ceremony with no benefit.

## Findings

### F1 — No schema-migration ledger · severity: medium · **status: FIXED**

250 `.sql` scripts in `scripts/` plus 4 root `upgrade_v*.sql` were applied by hand
(`psql < file`) with no record of what ran, in what order, or how to roll back.

**Fix applied:** adopted **dbmate** (single Go binary; the lightweight popular choice that
fits this plain-SQL + Docker-Postgres flow). A v2.0.0 **baseline** migration marks the
committed dump as the start of tracked history; every schema change from here is a numbered,
recorded, reversible migration. See [the migration workflow](#migration-workflow) below.
The historical `upgrade_v*.sql` files are retained as pre-dbmate history (already folded into
the dump). The idempotent data-loading `build_*.sql` scripts are **not** migrations and stay
as-is.

### F2 — Generators hand-escaped SQL literals · severity: low · **status: FIXED (all 17 generators)**

All 17 `gen_*.py` generators copy-pasted:
```python
def q(x): return "'" + str(x).replace("'","''") + "'"
```
The single-quote doubling is correct for Postgres (`standard_conforming_strings=on`), and the
input is **trusted local JSON**, so there was no injection risk. But it had three latent bugs:
`None` became the literal string `'None'` (not `NULL`); the `%d` int fields crashed opaquely
on a bad/empty year; open-ended periods had no `NULL` path.

**Fix applied:** extracted `scripts/sqlgen.py` (`sql_str` / `sql_int` / `sql_bool`) with
correct `None`→`NULL` and validated ints, and wired it into **all 17 generators**
(`from sqlgen import sql_str as q[, sql_int]`; the 7 that emit period years now use `sql_int`).
Verified by regenerating every cohort and confirming **byte-identical output** against the
committed `build_*.sql` — existing builds are unaffected.

### F3 — Two API endpoints filter in Python, not SQL · severity: low (perf) · **status: open**

`api_graph` loads all ~7,098 relationships then filters in Python every request, and
`api_neighbors` filters `tradition` in Python after fetching. Fine at current scale; push the
filter into a `WHERE` clause (and add a supporting index) if the graph grows materially.

## Migration workflow

dbmate config lives in `.env` (gitignored; template in `.env.example`). Migrations live in
`db/migrations/`.

**One-time baseline** (run once against the existing Docker Postgres, after restoring the
dump per `docs/RESUME.md`). The baseline does no DDL, so this just records v2.0.0 as applied:
```bash
dbmate up          # creates schema_migrations, records the v2.0.0 baseline
dbmate status      # should show the baseline applied, 0 pending
```

**Every future schema change:**
```bash
dbmate new add_entity_image_url      # creates db/migrations/<timestamp>_add_entity_image_url.sql
# edit the file: fill in the -- migrate:up and -- migrate:down sections
dbmate up                            # apply pending migrations
dbmate rollback                      # undo the last one if needed
```
Then continue the normal publish cycle (export → build image → deploy) in `docs/RESUME.md`.

> Note: dbmate connects via `DATABASE_URL` and runs each migration in a transaction, so omit
> explicit `BEGIN;`/`COMMIT;` in migration bodies (unlike the old `upgrade_v*.sql` scripts).

## GitHub-issue-ready backlog

`gh` isn't installed locally, so these are captured here; paste into Issues when convenient.

- **[done] Adopt dbmate for schema migrations (F1).** Baseline at v2.0.0; document workflow.
- **[done] Robust SQL-literal helpers in all 17 generators (F2).** `scripts/sqlgen.py`;
  byte-identical output verified across every cohort.
- **[perf] Push `tradition`/graph filtering into SQL (F3).** Add `WHERE` clauses (+ index)
  in `api_graph`/`api_neighbors` if the dataset grows.
