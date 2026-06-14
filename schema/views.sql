-- schema/views.sql
-- Canonical definitions for every view in DeityDB, loaded by schema/bootstrap.sql.
-- Mirrors the live Postgres instance (the source of truth). Idempotent: all use
-- CREATE OR REPLACE and are ordered so dependencies precede dependents.
--
-- Backfilled in v1.22.0: previously this file held three early placeholder views
-- (relationship_distribution, unresolved_relationships, generic_associations) that
-- no longer exist in the database — superseded by v_public_relationship_overview and
-- the staging diagnostics below — while the eleven views actually in use lived only
-- in the running instance. They are now all defined here.

-- ============================================================================
-- Internal diagnostics (feed v_release_metrics)
-- ============================================================================

-- Entities sharing a canonical_name that have not been signed off in
-- entity_duplicate_review — the duplicate-name discipline backlog (target: 0).
CREATE OR REPLACE VIEW v_unreviewed_duplicate_entities AS
WITH dupes AS (
    SELECT canonical_name
    FROM entities
    GROUP BY canonical_name
    HAVING count(*) > 1
)
SELECT e.entity_id,
       e.canonical_name,
       e.greek_name,
       e.tradition,
       e.entity_type,
       e.category,
       e.primary_domains,
       e.tags,
       e.cult_scope,
       e.primary_period,
       e.evidence_confidence,
       e.review_status,
       e.inclusion_basis,
       e.earth_association_score,
       e.chthonic_flag,
       e.serpent_flag,
       e.short_note
FROM entities e
JOIN dupes d ON d.canonical_name = e.canonical_name
LEFT JOIN entity_duplicate_review r
       ON r.entity_id = e.entity_id AND r.canonical_name = e.canonical_name
WHERE r.entity_id IS NULL
ORDER BY e.canonical_name, e.tradition, e.entity_id;

-- Staged relationship rows that do not yet resolve to a known subject, object,
-- and relationship_type — the unresolved-reference backlog (target: 0).
CREATE OR REPLACE VIEW v_staging_relationship_unresolved AS
SELECT sr.subject_name,
       sr.relationship_type,
       sr.object_name,
       sr.source_id,
       s.entity_id AS subject_entity_id,
       o.entity_id AS object_entity_id,
       rt.relationship_type AS valid_relationship_type
FROM staging_relationships sr
LEFT JOIN entities s ON lower(sr.subject_name) = lower(s.canonical_name)
LEFT JOIN entities o ON lower(sr.object_name) = lower(o.canonical_name)
LEFT JOIN relationship_types rt ON sr.relationship_type = rt.relationship_type
WHERE s.entity_id IS NULL OR o.entity_id IS NULL OR rt.relationship_type IS NULL;

-- Headline release statistics.
CREATE OR REPLACE VIEW v_release_metrics AS
SELECT (SELECT count(*) FROM entities)                              AS entities,
       (SELECT count(*) FROM entity_relationships)                  AS relationships,
       (SELECT count(*) FROM sources)                               AS sources,
       (SELECT count(*) FROM entity_tradition_tags)                 AS tradition_tags,
       (SELECT count(*) FROM v_unreviewed_duplicate_entities)       AS unreviewed_duplicates,
       (SELECT count(*) FROM v_staging_relationship_unresolved)     AS unresolved_relationships;

-- ============================================================================
-- Public overview views
-- ============================================================================

CREATE OR REPLACE VIEW v_public_tradition_overview AS
SELECT tradition,
       count(*) AS entity_count
FROM entities
GROUP BY tradition
ORDER BY count(*) DESC;

CREATE OR REPLACE VIEW v_public_relationship_overview AS
SELECT relationship_type,
       count(*) AS relationship_count
FROM entity_relationships
GROUP BY relationship_type
ORDER BY count(*) DESC;

CREATE OR REPLACE VIEW v_public_relationship_triples AS
SELECT s.canonical_name AS subject,
       s.tradition       AS subject_tradition,
       r.relationship_type,
       o.canonical_name AS object,
       o.tradition       AS object_tradition,
       r.confidence,
       r.source_id
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
ORDER BY s.tradition, s.canonical_name, r.relationship_type, o.canonical_name;

-- ============================================================================
-- Public thematic roster views
-- ============================================================================

CREATE OR REPLACE VIEW v_public_underworld_entities AS
SELECT entity_id,
       canonical_name,
       tradition,
       category,
       earth_association_score,
       chthonic_flag,
       primary_domains,
       short_note
FROM entities
WHERE chthonic_flag = true
   OR category ILIKE '%underworld%'
   OR primary_domains ILIKE '%underworld%'
   OR primary_domains ILIKE '%death%'
ORDER BY tradition, canonical_name;

CREATE OR REPLACE VIEW v_public_adversarial_beings AS
SELECT entity_id,
       canonical_name,
       tradition,
       category,
       primary_domains,
       short_note
FROM entities
WHERE category ILIKE '%adversarial%'
   OR primary_domains ILIKE '%evil%'
   OR primary_domains ILIKE '%chaos%'
   OR primary_domains ILIKE '%demon%'
ORDER BY tradition, canonical_name;

CREATE OR REPLACE VIEW v_public_angelic_beings AS
SELECT entity_id,
       canonical_name,
       tradition,
       category,
       primary_domains,
       short_note
FROM entities
WHERE category ILIKE '%angel%'
   OR entity_type ILIKE '%angel%'
ORDER BY tradition, canonical_name;

CREATE OR REPLACE VIEW v_public_revealer_figures AS
SELECT entity_id,
       canonical_name,
       tradition,
       category,
       primary_domains,
       short_note
FROM entities e
WHERE category ILIKE '%revealer%'
   OR entity_id IN (
        SELECT subject_entity_id
        FROM entity_relationships
        WHERE relationship_type = ANY (ARRAY['reveals','teaches','transmits','guides'])
   )
ORDER BY tradition, canonical_name;

CREATE OR REPLACE VIEW v_public_serpent_dragon_beings AS
SELECT entity_id,
       canonical_name,
       tradition,
       category,
       serpent_flag,
       primary_domains,
       short_note
FROM entities
WHERE serpent_flag = true
   OR primary_domains ILIKE '%serpent%'
   OR primary_domains ILIKE '%dragon%'
ORDER BY tradition, canonical_name;

CREATE OR REPLACE VIEW v_public_wisdom_knowledge_beings AS
SELECT DISTINCT e.entity_id,
       e.canonical_name,
       e.tradition,
       e.category,
       e.primary_domains,
       e.short_note
FROM entities e
LEFT JOIN entity_relationships r ON r.subject_entity_id = e.entity_id
LEFT JOIN entities o ON o.entity_id = r.object_entity_id
WHERE e.primary_domains ILIKE '%wisdom%'
   OR e.primary_domains ILIKE '%knowledge%'
   OR o.canonical_name = ANY (ARRAY['Wisdom','Knowledge','Hidden Knowledge','Torah','Prophecy','Understanding'])
ORDER BY e.tradition, e.canonical_name;

-- ============================================================================
-- Comparative-domain views (added v1.22.0; see scripts/add_comparative_domains_views.sql).
-- Pivot on the "Cross-traditional" abstraction layer to compare divine functions
-- across traditions and kinds.
-- ============================================================================

CREATE OR REPLACE VIEW v_public_comparative_domains AS
SELECT o.canonical_name AS domain,
       o.entity_type     AS domain_category,
       r.relationship_type,
       s.canonical_name AS entity,
       s.tradition       AS entity_tradition,
       s.entity_type     AS entity_kind,
       r.confidence,
       r.source_id
FROM entity_relationships r
JOIN entities o ON o.entity_id = r.object_entity_id
JOIN entities s ON s.entity_id = r.subject_entity_id
WHERE o.tradition = 'Cross-traditional'
ORDER BY o.canonical_name, r.relationship_type, s.tradition, s.canonical_name;

CREATE OR REPLACE VIEW v_public_domain_overview AS
SELECT o.canonical_name                    AS domain,
       o.entity_type                       AS domain_category,
       count(*)                            AS entities,
       count(DISTINCT s.tradition)         AS traditions,
       count(DISTINCT r.relationship_type) AS relationship_types,
       string_agg(DISTINCT r.relationship_type, ', ' ORDER BY r.relationship_type) AS relationship_kinds
FROM entity_relationships r
JOIN entities o ON o.entity_id = r.object_entity_id
JOIN entities s ON s.entity_id = r.subject_entity_id
WHERE o.tradition = 'Cross-traditional'
GROUP BY o.canonical_name, o.entity_type
ORDER BY traditions DESC, entities DESC;
