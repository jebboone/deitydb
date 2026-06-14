-- scripts/audit_quality_snapshot.sql
-- Read-only quality snapshot for DeityDB. Run anytime to gauge structural health.
-- Usage: docker exec deitydb psql -U postgres -d deitydb -f /dev/stdin < scripts/audit_quality_snapshot.sql
--   (or paste individual blocks)
--
-- Snapshot at v1.20.0 (2026-06-14): 1,251 entities / 2,143 rels / 145 sources;
-- 0 orphans, 0 unsourced entities, 0 unresolved refs, 0 associated_with edges.
-- One outstanding gap: 99 relationships with no source_id (see block 5).

-- 1. Release metrics
SELECT * FROM v_release_metrics;

-- 2. Relationship-type distribution (typed relations should dominate;
--    associated_with should be 0 — treated as a code smell)
SELECT relationship_type, count(*)
FROM entity_relationships
GROUP BY 1 ORDER BY 2 DESC;

-- 3. Orphan entities (no relationship in either direction) — target: 0
SELECT count(*) AS zero_rel_entities
FROM entities e
WHERE NOT EXISTS (
  SELECT 1 FROM entity_relationships r
  WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id
);

-- 4. Entities with no linked source record — target: 0
SELECT count(*) AS unsourced_entities
FROM entities e
WHERE NOT EXISTS (
  SELECT 1 FROM entity_sources s WHERE s.entity_id = e.entity_id
);

-- 5. Relationships lacking a source_id (OUTSTANDING GAP: 99 at v1.20.0)
SELECT count(*) AS unsourced_rels
FROM entity_relationships
WHERE source_id IS NULL OR source_id = '';

-- 5a. ...broken down by relationship_type
SELECT relationship_type, count(*)
FROM entity_relationships
WHERE source_id IS NULL OR source_id = ''
GROUP BY 1 ORDER BY 2 DESC;

-- 5b. ...broken down by subject tradition
SELECT e.tradition, count(*)
FROM entity_relationships r
JOIN entities e ON e.entity_id = r.subject_entity_id
WHERE r.source_id IS NULL OR r.source_id = ''
GROUP BY 1 ORDER BY 2 DESC;

-- 6. Tradition coverage (entity counts)
SELECT tradition, count(*)
FROM entities
GROUP BY 1 ORDER BY 2 DESC;
