-- Diagnostic: unresolved staging relationships and unreviewed duplicates
-- Run read-only; no data modifications here.
-- Generated to support investigation of v_release_metrics discrepancy.

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. Root cause: which relationship_types are present in staging but not valid?
-- ─────────────────────────────────────────────────────────────────────────────
SELECT DISTINCT sr.relationship_type,
       COUNT(*) AS staging_rows,
       (SELECT COUNT(*) FROM relationship_types rt
        WHERE rt.relationship_type = sr.relationship_type) AS in_valid_table
FROM staging_relationships sr
GROUP BY sr.relationship_type
ORDER BY in_valid_table, sr.relationship_type;

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. All 12 unresolved staging rows with entity resolution status
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    sr.subject_name,
    sr.relationship_type,
    sr.object_name,
    sr.source_id,
    s.entity_id  AS subject_entity_id,
    o.entity_id  AS object_entity_id,
    CASE
        WHEN s.entity_id IS NULL THEN 'MISSING SUBJECT'
        WHEN o.entity_id IS NULL THEN 'MISSING OBJECT'
        ELSE 'INVALID REL TYPE'
    END AS failure_reason
FROM staging_relationships sr
LEFT JOIN entities s ON lower(sr.subject_name) = lower(s.canonical_name)
LEFT JOIN entities o ON lower(sr.object_name) = lower(o.canonical_name)
LEFT JOIN relationship_types rt ON sr.relationship_type = rt.relationship_type
WHERE s.entity_id IS NULL OR o.entity_id IS NULL OR rt.relationship_type IS NULL
ORDER BY sr.subject_name, sr.object_name;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. Cross-reference: which staging rows already have a typed live counterpart?
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    sr.subject_name,
    sr.relationship_type  AS staging_type,
    sr.object_name,
    er.relationship_type  AS live_type,
    er.source_id          AS live_source,
    CASE WHEN er.subject_entity_id IS NOT NULL THEN 'HAS LIVE COUNTERPART'
         ELSE 'NO LIVE COUNTERPART — GAP'
    END AS status
FROM staging_relationships sr
LEFT JOIN entities s ON lower(sr.subject_name) = lower(s.canonical_name)
LEFT JOIN entities o ON lower(sr.object_name) = lower(o.canonical_name)
LEFT JOIN relationship_types rt ON sr.relationship_type = rt.relationship_type
LEFT JOIN entity_relationships er
       ON er.subject_entity_id = s.entity_id
      AND er.object_entity_id  = o.entity_id
WHERE (s.entity_id IS NULL OR o.entity_id IS NULL OR rt.relationship_type IS NULL)
ORDER BY status DESC, sr.subject_name, sr.object_name;

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. The 2 unreviewed duplicates: full entity profile
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    e.entity_id,
    e.canonical_name,
    e.entity_type,
    e.tradition,
    e.category,
    e.review_status,
    e.inclusion_basis,
    e.primary_domains,
    e.short_note
FROM v_unreviewed_duplicate_entities e
ORDER BY e.canonical_name, e.entity_id;

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. Existing relationships for the unreviewed duplicate entities
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    er.subject_entity_id,
    er.relationship_type,
    er.object_entity_id,
    er.source_id
FROM entity_relationships er
WHERE er.subject_entity_id IN ('ENT_CHR_SERAPHIM','ENT_JM_SERAPHIM')
   OR er.object_entity_id  IN ('ENT_CHR_SERAPHIM','ENT_JM_SERAPHIM')
ORDER BY er.subject_entity_id, er.relationship_type;

-- ─────────────────────────────────────────────────────────────────────────────
-- 6. Pattern from existing intentional_distinct reviews (for comparison)
-- ─────────────────────────────────────────────────────────────────────────────
SELECT canonical_name, entity_id, decision, duplicate_group_note
FROM entity_duplicate_review
WHERE decision = 'intentional_distinct'
ORDER BY canonical_name, entity_id
LIMIT 10;
