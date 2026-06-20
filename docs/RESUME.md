# DeityDB — Resume / Cross-Machine Handoff

Snapshot for picking the project up on another machine. Last updated **2026-06-20, v2.1.9**.

## ⟶ Pick up here (next action)
**Citation remediation (the v2.1.x epoch) is the active work** — replacing AI-paraphrase
`short_note` prose with source-traceable citations in `entity_citations`. Current state
(measured 2026-06-20): **0 entities fully uncited**; **1,496 carry real verbatim
quotes**; the remaining surface is **937 `primary-uncited`** entities (primary text known,
verbatim quote pending — the Track-1 upgrade targets), plus 1,129 `secondary` / 103 `reference`
pointers. **Next:** continue the public-domain extraction pipeline (`scripts/citations/`) to
upgrade `primary-uncited` → `primary-verbatim`. Most large clusters are picked-over — progress
now means per-corpus re-sourcing (complete/clean text) + spelling aliases (the testsol / Augustine
/ Mabinogion / Edda method), not just re-running.

**Deploy status unconfirmed** — verify the live version at deitydb-explorer.fly.dev before
assuming the citation epoch is deployed (it was v1.92.0 pre-citation). Ship via
`flyctl deploy -a deitydb-explorer` after the publish cycle.

### Known issues
- `scripts/citations/build_etzhayim_citations.sql` — **empty `VALUES` list** (0 rows), never
  applies; the corpus extracted nothing. Make it a no-op/remove, or re-source.
- *(Fixed in v2.1.7)* `build_testsol_citations.sql` (was JSTOR OCR garbage) re-sourced from
  Conybeare; `prose_edda`/`poetic_edda` translator misattributions corrected (Anderson 1880 /
  Thorpe 1866). A config-attribution audit verified the other Gutenberg sources.

## Current state
- **Scale:** 3,837 entities / 7,098 relationships / 458 sources / 135 traditions. Code & DB at **v2.1.9** on `main`.
- **Citation remediation (v2.1.0–2.1.9): primary-quotable extraction COMPLETE** — `entity_citations` table + `v_public_entity_citations` view; every entity graded, 0 fully uncited. **1,496 verbatim quotes** substring-gated against public-domain texts; 937 `primary-uncited` remain (genuinely PD-quotable tails + Ovid Fasti); 1,301 `secondary` (incl. 172 re-graded from primary-uncited where the source is unquotable — in-copyright editions / inscriptions). Source attributions audited end-to-end (3 fixed: Anderson/Thorpe/Shilleto). Pipeline: `scripts/citations/README.md`. Triage/plan: `docs/REMEDIATION_TRIAGE.md`.
- **Completeness program (Phases 1–7): COMPLETE and audited clean** — every integrity invariant 0, 97.3% primary/scholarly source coverage. Per-phase record in `CHANGELOG.md` (v1.85.0–v1.91.1); the gap register is `docs/COMPLETENESS_ROADMAP.md`.
- **Deeper graph/API features: DONE** (v1.92.0) — JSON API + `/path` finder + `/constellation` map + `/graph` filters.
- **Schema epoch — controlled `entity_class`: DONE** (v2.0.0) — 19-value controlled vocabulary over free-text `entity_type`; 57 blank types filled; 0 unmapped types. Migration `upgrade_v2_0_entity_class.sql`; map source in `scripts/_classmap/`.
- **Git:** all pushed to `github.com/jebboone/deitydb` (main).

## What travels, and what doesn't
- **In git (clones cleanly):** all schema, `scripts/` (build SQL + `gen_*.py` generators + the `_p1..p7_*` cohort JSON + `scripts/citations/`), `templates/`, `static/`, `plugins/`, `metadata.yaml`, `docs/`, and portable Postgres dumps in `backups/` — **`deitydb_pg_v2.1.9.sql.gz` is current (includes the citation layer)**; `deitydb_pg_v2.0.0.sql.gz` is the pre-citation baseline kept for reference.
- **NOT in git:** `deitydb.sqlite` (gitignored — rebuilt from Postgres), `CLAUDE.md` (gitignored project instructions), the Python **venv**, and **flyctl**. The **Postgres source-of-truth runs only in the local Docker container** — it travels via the committed dump, not git.

## Bring up a new machine
```bash
# 1. code
git clone https://github.com/jebboone/deitydb && cd deitydb

# 2. Postgres source-of-truth (restore from the current committed dump).
#    On Bazzite use `podman` (rootless, no sudo); it's drop-in for `docker` here.
podman run -d --name deitydb -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=deitydb -p 5432:5432 docker.io/library/postgres:16
sleep 5
gunzip -c backups/deitydb_pg_v2.1.9.sql.gz | podman exec -i deitydb psql -U postgres -d deitydb
podman exec deitydb psql -U postgres -d deitydb -c "select count(*) from entities;"          # expect 3837
podman exec deitydb psql -U postgres -d deitydb -c "select count(*) from entity_citations;"  # expect ~3871
# To rebuild the citation layer FROM SCRATCH on the v2.0.0 baseline instead (rarely needed):
#   apply scripts/build_pilot_citations.sql, then scripts/citations/build_*_citations.sql
#   (build_track2_secondary_citations.sql LAST). NOTE: etzhayim + testsol builds are broken (see Known issues).

# 3. tooling venv (export + serve)
python3 -m venv .venv && .venv/bin/pip install "datasette==0.65.2" db-to-sqlite sqlite-utils psycopg2-binary
#    psycopg2-binary is REQUIRED — db-to-sqlite's PG export dies with ModuleNotFoundError: psycopg2 without it.

# 4. deploy auth (jebboone2@gmail.com)
#    install flyctl, then: flyctl auth login     # app = deitydb-explorer
```

## Publish cycle (after any DB change)
```bash
PATH=".venv/bin:$PATH" bash scripts/export_sqlite.sh deitydb.sqlite   # PG -> sqlite (gitignored)
docker build -t deitydb .                                            # bakes sqlite+templates+plugins
docker rm -f deitydb-dev; docker run -d --name deitydb-dev -p 8080:8080 deitydb   # local preview :8080
flyctl deploy -a deitydb-explorer                                    # live (~1-2 min; "metrics token" warning is benign)
```
Frontend/plugin-only changes skip the export step. Bump `VERSION` + add a `CHANGELOG.md` entry for releases.

## Schema migrations (dbmate)
Schema changes are tracked with **dbmate** (config in `.env` / `.env.example`; migrations in `db/migrations/`). The v2.0.0 schema is the **baseline** (= the committed dump), so on a fresh machine, after restoring the dump, run `dbmate up` once to record the baseline. New schema changes: `dbmate new <name>` → edit the `-- migrate:up`/`-- migrate:down` sections → `dbmate up` (`dbmate rollback` undoes the last). dbmate wraps each migration in a transaction, so don't add `BEGIN;`/`COMMIT;` in the body. Data loads stay as idempotent `scripts/build_*.sql` (NOT migrations). Generators share SQL-literal helpers in `scripts/sqlgen.py`. Full rationale: `docs/SQL_AUDIT.md`.

## Build pattern (how the cohorts were made)
Per cohort: JSON in `scripts/_<cohort>/{entities,relationships,sources,periods}.json` → `python scripts/gen_roster.py <cohort>` → emits `scripts/build_<cohort>.sql` (idempotent, self-validating, prints REJECTED edges) → `docker exec -i deitydb psql -U postgres -d deitydb -v ON_ERROR_STOP=1 < scripts/build_<cohort>.sql`. New traditions get a row in `scripts/gen_tradition_profile.py` (then regenerate+apply `build_tradition_profile.sql`). Integrity gate every batch: 0 rejected/orphan/unsourced/unperiodized/rationale-less/orphan-source/dup-name.

## Conventions / gotchas
- `entities.entity_class` = controlled 19-value kind (FK → `entity_class` table); `entity_type` = free-text descriptor. New `entity_type`s MUST get a row in `entity_type_class_map` (regenerate via `scripts/_classmap/`), else the v2.0 gate fails (0 unmapped types). Backfill entity_class from the map after a build.
- `entities.evidence_confidence` = **A/B/C/D**; `entity_relationships.confidence` = **high/medium/low** (don't cross them).
- relationship JSON keys: `{s=subject, t=relationship_type, o=object, c, ra}` — never transpose t/o.
- `reception_of` and `received_as` are stored as **inverse pairs** — path/chain traversal must follow ONE relation in ONE direction or it cycles.
- One `src` id per entity (don't pack several). Homonyms across traditions need both sides in `entity_duplicate_review`.
- Datasette pinned at 0.65.2 (1.0 broke canned-query routes). zsh does NOT word-split unquoted `$vars` in `for` loops — use literal lists.

## Open / optional next
- Phone **remote-access** setup (Tailscale + tmux + Termius, or VS Code `code tunnel`) — not built yet; write `docs/REMOTE_ACCESS.md` when wanted.
- Possible polish: per-entity images; a persistent header search.
