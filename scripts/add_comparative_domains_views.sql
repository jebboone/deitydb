-- scripts/add_comparative_domains_views.sql
-- Comparative-domain public views (v1.22.0).
--
-- DeityDB's "Cross-traditional" tradition is not a culture — it is the layer of
-- 118 abstraction / domain nodes (War, Healing, Sovereignty, Disease, Underworld,
-- Wisdom, ...) that deities across every tradition relate to via typed edges
-- (embodies / patron_of / causes_affliction / rules / dwells_in / reveals / ...).
-- These two views pivot on that layer so the database's core purpose — comparing
-- divine functions ACROSS traditions and kinds — is directly queryable.
--
-- NOTE: the existing v_public_* views are not (yet) defined in any committed
-- schema file; they live only in the running Postgres instance. These two are the
-- first public views with committed DDL. See CHANGELOG v1.22.0 follow-up note about
-- back-filling schema/views.sql with the other nine.

-- Detail pivot: every (domain, entity) pair, one row per typed edge.
CREATE OR REPLACE VIEW v_public_comparative_domains AS
SELECT o.canonical_name        AS domain,
       o.entity_type           AS domain_category,
       r.relationship_type,
       s.canonical_name        AS entity,
       s.tradition             AS entity_tradition,
       s.entity_type           AS entity_kind,
       r.confidence,
       r.source_id
FROM entity_relationships r
JOIN entities o ON o.entity_id = r.object_entity_id
JOIN entities s ON s.entity_id = r.subject_entity_id
WHERE o.tradition = 'Cross-traditional'
ORDER BY o.canonical_name, r.relationship_type, s.tradition, s.canonical_name;

-- Browsable index: per domain, how many entities and how many traditions reach it.
CREATE OR REPLACE VIEW v_public_domain_overview AS
SELECT o.canonical_name                          AS domain,
       o.entity_type                             AS domain_category,
       count(*)                                  AS entities,
       count(DISTINCT s.tradition)               AS traditions,
       count(DISTINCT r.relationship_type)       AS relationship_types,
       string_agg(DISTINCT r.relationship_type, ', ' ORDER BY r.relationship_type) AS relationship_kinds
FROM entity_relationships r
JOIN entities o ON o.entity_id = r.object_entity_id
JOIN entities s ON s.entity_id = r.subject_entity_id
WHERE o.tradition = 'Cross-traditional'
GROUP BY o.canonical_name, o.entity_type
ORDER BY traditions DESC, entities DESC;

-- Verify
SELECT count(*) AS detail_rows,
       (SELECT count(*) FROM v_public_domain_overview) AS domains
FROM v_public_comparative_domains;
