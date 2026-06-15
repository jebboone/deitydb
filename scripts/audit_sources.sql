-- scripts/audit_sources.sql
-- Re-runnable source-integrity audit for DeityDB.
-- Snapshot at v1.31.1: 159 sources; 0 unsourced entities, 0 unsourced relationships,
-- 0 dangling source FKs. 4 legacy orphan sources remain (unused reference gazetteers /
-- an internal heuristic marker). Outstanding hygiene item: source_type has ~39 near-
-- duplicate values and would benefit from normalisation to a controlled vocabulary.

-- 1. Totals
SELECT (SELECT count(*) FROM sources)                                                        AS sources,
       (SELECT count(*) FROM entity_sources)                                                 AS entity_source_links,
       (SELECT count(DISTINCT source_id) FROM entity_relationships
          WHERE source_id IS NOT NULL AND source_id<>'')                                     AS sources_used_in_rels;

-- 2. Coverage gaps (target: 0 / 0)
SELECT
  (SELECT count(*) FROM entities e
     WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id))         AS unsourced_entities,
  (SELECT count(*) FROM entity_relationships WHERE source_id IS NULL OR source_id='')         AS unsourced_rels;

-- 3. Dangling source FKs across all three referencing tables (target: 0)
SELECT 'entity_sources' AS tbl, count(*) AS dangling FROM entity_sources es
  WHERE NOT EXISTS (SELECT 1 FROM sources s WHERE s.source_id=es.source_id)
UNION ALL
SELECT 'entity_relationships', count(*) FROM entity_relationships r
  WHERE r.source_id IS NOT NULL AND r.source_id<>'' AND NOT EXISTS (SELECT 1 FROM sources s WHERE s.source_id=r.source_id)
UNION ALL
SELECT 'entity_periods', count(*) FROM entity_periods p
  WHERE p.source_id IS NOT NULL AND p.source_id<>'' AND NOT EXISTS (SELECT 1 FROM sources s WHERE s.source_id=p.source_id);

-- 4. Orphan sources (defined but referenced by no entity, relationship, or period)
SELECT s.source_id, s.title
FROM sources s
WHERE NOT EXISTS (SELECT 1 FROM entity_sources es      WHERE es.source_id=s.source_id)
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.source_id =s.source_id)
  AND NOT EXISTS (SELECT 1 FROM entity_periods p       WHERE p.source_id =s.source_id)
ORDER BY s.source_id;

-- 5. Sources missing metadata
SELECT source_id, (source_type IS NULL OR source_type='') AS no_type,
                  (scope IS NULL OR scope='') AS no_scope
FROM sources
WHERE source_type IS NULL OR source_type='' OR scope IS NULL OR scope=''
ORDER BY source_id;

-- 6. source_type distribution (hygiene: should converge to a small controlled vocabulary)
SELECT COALESCE(NULLIF(source_type,''),'(none)') AS source_type, count(*)
FROM sources GROUP BY 1 ORDER BY 2 DESC;

-- 7. Most-used sources by entity attestation
SELECT s.source_id, count(es.entity_id) AS entities
FROM sources s JOIN entity_sources es ON es.source_id=s.source_id
GROUP BY 1 ORDER BY 2 DESC LIMIT 15;
