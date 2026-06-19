-- migrate:up
-- Baseline migration for DeityDB v2.0.0 — the start of dbmate-managed history.
--
-- The full v2.0.0 schema (all tables, constraints, views, and the historical
-- upgrade_v0_2 / upgrade_v0_3 / upgrade_v1_1 / upgrade_v2_0 scripts, which all
-- predate dbmate) is captured in the committed Postgres dump
--   backups/deitydb_pg_v2.0.0.sql.gz
-- and mirrored in schema/{tables,constraints,views}.sql. A fresh database is
-- bootstrapped from that dump (see docs/RESUME.md → "Bring up a new machine"),
-- so this baseline performs no DDL — it only records v2.0.0 as the point from
-- which every future schema change is a numbered, tracked dbmate migration.
SELECT 'deitydb baseline v2.0.0' AS baseline;

-- migrate:down
-- The baseline is irreversible: the v2.0.0 schema lives in the committed dump,
-- not in this file. To go below the baseline, rebuild from the dump.
SELECT 'deitydb baseline v2.0.0 is irreversible' AS baseline;
