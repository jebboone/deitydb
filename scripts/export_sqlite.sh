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
  v_release_metrics
)

for view in "${VIEWS[@]}"; do
  echo "  $view"
  db-to-sqlite "$PG_URL" "$OUTPUT" --table "$view" --progress
done

echo ""
echo "==> Verifying..."
sqlite3 "$OUTPUT" "SELECT COUNT(*) || ' entities'      FROM entities;"
sqlite3 "$OUTPUT" "SELECT COUNT(*) || ' relationships' FROM entity_relationships;"
sqlite3 "$OUTPUT" "SELECT COUNT(*) || ' sources'       FROM sources;"
sqlite3 "$OUTPUT" "SELECT COUNT(*) || ' entity_periods' FROM entity_periods;"
echo ""
echo "Tables in $OUTPUT:"
sqlite3 "$OUTPUT" ".tables"
echo ""
echo "Export complete: $OUTPUT"
echo "Test locally with:  datasette serve $OUTPUT --metadata metadata.yaml"
