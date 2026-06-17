# DeityDB — Resume / Cross-Machine Handoff

Snapshot for picking the project up on another machine. Last updated **2026-06-17, v1.92.0**.

## Current state
- **Scale:** 3,837 entities / 7,098 relationships / 458 sources / 135 traditions. Fully published & live at **deitydb-explorer.fly.dev** (v1.92.0).
- **Completeness program (Phases 1–7): COMPLETE and audited clean** — every integrity invariant 0, 97.3% primary/scholarly source coverage. Per-phase record in `CHANGELOG.md` (v1.85.0–v1.91.1); the gap register is `docs/COMPLETENESS_ROADMAP.md`.
- **Deeper graph/API features: DONE** (v1.92.0) — JSON API + `/path` finder + `/constellation` map + `/graph` filters.
- **Git:** all pushed to `github.com/jebboone/deitydb` (main).

## What travels, and what doesn't
- **In git (clones cleanly):** all schema, `scripts/` (build SQL + `gen_*.py` generators + the `_p1..p7_*` cohort JSON), `templates/`, `static/`, `plugins/`, `metadata.yaml`, `docs/`, and a portable Postgres dump at `backups/deitydb_pg_v1.92.0.sql.gz`.
- **NOT in git:** `deitydb.sqlite` (gitignored — rebuilt from Postgres), `CLAUDE.md` (gitignored project instructions), the Python **venv**, and **flyctl**. The **Postgres source-of-truth runs only in the local Docker container** — it travels via the committed dump, not git.

## Bring up a new machine
```bash
# 1. code
git clone https://github.com/jebboone/deitydb && cd deitydb

# 2. Postgres source-of-truth (restore from the committed dump)
docker run -d --name deitydb -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=deitydb -p 5432:5432 postgres:16
sleep 5
gunzip -c backups/deitydb_pg_v1.92.0.sql.gz | docker exec -i deitydb psql -U postgres -d deitydb
docker exec deitydb psql -U postgres -d deitydb -c "select count(*) from entities;"   # expect 3837

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

## Build pattern (how the cohorts were made)
Per cohort: JSON in `scripts/_<cohort>/{entities,relationships,sources,periods}.json` → `python scripts/gen_roster.py <cohort>` → emits `scripts/build_<cohort>.sql` (idempotent, self-validating, prints REJECTED edges) → `docker exec -i deitydb psql -U postgres -d deitydb -v ON_ERROR_STOP=1 < scripts/build_<cohort>.sql`. New traditions get a row in `scripts/gen_tradition_profile.py` (then regenerate+apply `build_tradition_profile.sql`). Integrity gate every batch: 0 rejected/orphan/unsourced/unperiodized/rationale-less/orphan-source/dup-name.

## Conventions / gotchas
- `entities.evidence_confidence` = **A/B/C/D**; `entity_relationships.confidence` = **high/medium/low** (don't cross them).
- relationship JSON keys: `{s=subject, t=relationship_type, o=object, c, ra}` — never transpose t/o.
- `reception_of` and `received_as` are stored as **inverse pairs** — path/chain traversal must follow ONE relation in ONE direction or it cycles.
- One `src` id per entity (don't pack several). Homonyms across traditions need both sides in `entity_duplicate_review`.
- Datasette pinned at 0.65.2 (1.0 broke canned-query routes). zsh does NOT word-split unquoted `$vars` in `for` loops — use literal lists.

## Open / optional next
- Phone **remote-access** setup (Tailscale + tmux + Termius, or VS Code `code tunnel`) — not built yet; write `docs/REMOTE_ACCESS.md` when wanted.
- Possible polish: per-entity images; a persistent header search.
