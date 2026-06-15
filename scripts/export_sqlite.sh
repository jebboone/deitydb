#!/usr/bin/env bash
# scripts/export_sqlite.sh
# Export DeityDB from PostgreSQL to a SQLite file for Datasette deployment.
#
# Requirements:
#   pip install db-to-sqlite
#
# Usage:
#   bash scripts/export_sqlite.sh [output_path]
#
# Environment variables:
#   DEITYDB_URL  PostgreSQL connection string (default: local Docker setup)
#
# Default output is deitydb.sqlite in the repo root.

set -euo pipefail

OUTPUT="${1:-deitydb.sqlite}"
PG_URL="${DEITYDB_URL:-postgresql://postgres:postgres@localhost:5432/deitydb}"

echo "DeityDB SQLite export"
echo "  source : $PG_URL"
echo "  output : $OUTPUT"
echo ""

rm -f "$OUTPUT"

echo "==> Exporting base tables..."
db-to-sqlite "$PG_URL" "$OUTPUT" --all --progress

# The v_public_* views use PostgreSQL-specific ILIKE (~~*) syntax and cannot
# be recreated as SQLite views. Export them as materialised tables instead.
echo ""
echo "==> Materialising public views..."
VIEWS=(
  v_public_tradition_overview
  v_public_relationship_overview
  v_public_relationship_triples
  v_public_underworld_entities
  v_public_adversarial_beings
  v_public_angelic_beings
  v_public_revealer_figures
  v_public_serpent_dragon_beings
  v_public_wisdom_knowledge_beings
  v_public_domain_overview
  v_public_comparative_domains
  v_public_cross_tradition_links
  v_public_cross_tradition_matrix
  v_release_metrics
)

for view in "${VIEWS[@]}"; do
  echo "  $view"
  db-to-sqlite "$PG_URL" "$OUTPUT" --table "$view" --progress
done

echo ""
echo "==> Verifying..."
python3 - <<PYEOF
import sqlite3, sys
con = sqlite3.connect("$OUTPUT")
cur = con.cursor()
counts = [
    ("entities",         "SELECT COUNT(*) FROM entities"),
    ("relationships",    "SELECT COUNT(*) FROM entity_relationships"),
    ("sources",          "SELECT COUNT(*) FROM sources"),
    ("entity_periods",   "SELECT COUNT(*) FROM entity_periods"),
]
for label, sql in counts:
    n = cur.execute(sql).fetchone()[0]
    print(f"  {label:<20} {n}")

views = [r[0] for r in cur.execute(
    "SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'v_public%' ORDER BY name"
).fetchall()]
print(f"\n  Materialised views: {len(views)}")
for v in views:
    print(f"    {v}")
PYEOF
echo ""
echo "Export complete: $OUTPUT"
echo "Test locally with:  datasette serve $OUTPUT --metadata metadata.yaml  # requires datasette==0.65.2"
echo "Or via Docker:      docker build -t deitydb . && docker run -p 8001:8080 deitydb"
