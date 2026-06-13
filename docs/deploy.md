# Deploying DeityDB (Datasette on Fly.io)

The public explorer is a read-only [Datasette](https://datasette.io/) instance
served from a SQLite export of the PostgreSQL database.

## Prerequisites

```bash
pip install datasette db-to-sqlite
brew install flyctl          # or: curl -L https://fly.io/install.sh | sh
fly auth login
```

## Step 1 — Export PostgreSQL → SQLite

With your local Docker container running:

```bash
bash scripts/export_sqlite.sh
```

This exports all base tables and materialises the `v_public_*` views as SQLite
tables (the views use PostgreSQL-specific syntax and cannot be recreated
directly in SQLite). Output: `deitydb.sqlite` in the repo root.

To use a different PostgreSQL connection:

```bash
DEITYDB_URL="postgresql://user:pass@host:5432/deitydb" bash scripts/export_sqlite.sh
```

## Step 2 — Test locally

```bash
datasette serve deitydb.sqlite --metadata metadata.yaml
```

Open http://localhost:8001 and verify the canned queries work before deploying.

## Step 3 — First deploy

```bash
fly launch --name deitydb-explorer --region iad --no-deploy
fly deploy
```

`fly launch` reads `fly.toml` and creates the app on Fly.io. `fly deploy`
builds the Docker image (which copies `deitydb.sqlite` and `metadata.yaml`
into the container) and deploys it.

Your app will be live at `https://deitydb-explorer.fly.dev`.

> **App name**: `deitydb-explorer` is a placeholder. Choose any name
> available on Fly.io and update the `app` field in `fly.toml`.

## Subsequent releases

After committing new SQL scripts and applying them to the database:

```bash
bash scripts/export_sqlite.sh   # regenerate the SQLite file
fly deploy                       # rebuild and deploy the new image
```

The deploy takes about 60–90 seconds. Fly.io performs a rolling update with
zero downtime.

## Cost

The `fly.toml` uses scale-to-zero (`min_machines_running = 0`,
`auto_stop_machines = "stop"`). The machine stops when there is no traffic
and cold-starts (~2 seconds) on the next request. For a low-traffic
open-source project this effectively costs nothing beyond the free tier.

If you prefer an always-on instance (no cold-start latency), set
`min_machines_running = 1` in `fly.toml`. A shared-CPU 256 MB machine
costs approximately $1.94/month.

## Updating metadata only

If you change `metadata.yaml` without changing the database:

```bash
fly deploy   # rebuilds and deploys — the SQLite file is baked into the image
```

The image rebuild is fast because `deitydb.sqlite` is already cached in the
Docker layer unless it changed.

## Files involved

| File | Purpose |
|---|---|
| `scripts/export_sqlite.sh` | Exports PostgreSQL → `deitydb.sqlite` |
| `deitydb.sqlite` | Generated SQLite file (gitignored) |
| `metadata.yaml` | Datasette configuration — titles, canned queries, table descriptions |
| `Dockerfile` | Datasette container definition |
| `fly.toml` | Fly.io app configuration |
