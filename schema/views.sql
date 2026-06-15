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

-- ----------------------------------------------------------------------------
-- Cross-tradition links (v1.62.0): the comparative-religion core surfaced.
-- Every typed relationship that connects two DIFFERENT real traditions by a
-- comparative/genetic verb (transmission, syncretism, identification, cognate),
-- excluding the Cross-traditional abstraction layer (that is the domain views).
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_public_cross_tradition_links AS
SELECT s.canonical_name AS entity,
       s.tradition       AS tradition,
       r.relationship_type,
       o.canonical_name AS linked_entity,
       o.tradition       AS linked_tradition,
       r.confidence,
       r.rationale,
       r.source_id
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE s.tradition <> o.tradition
  AND s.tradition <> 'Cross-traditional'
  AND o.tradition <> 'Cross-traditional'
  AND r.relationship_type IN ('reception_of','received_as','syncretized_with',
        'identified_with','equated_with','aligned_with','cult_form_of','reveals')
ORDER BY s.tradition, s.canonical_name, r.relationship_type, o.tradition;

-- The tradition-to-tradition web: how many comparative links bridge each pair
-- of traditions (direction-normalised), and by which kinds of link.
CREATE OR REPLACE VIEW v_public_cross_tradition_matrix AS
SELECT least(s.tradition, o.tradition)    AS tradition_a,
       greatest(s.tradition, o.tradition) AS tradition_b,
       count(*)                            AS links,
       count(DISTINCT r.relationship_type) AS link_types,
       string_agg(DISTINCT r.relationship_type, ', ' ORDER BY r.relationship_type) AS link_kinds
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE s.tradition <> o.tradition
  AND s.tradition <> 'Cross-traditional'
  AND o.tradition <> 'Cross-traditional'
  AND r.relationship_type IN ('reception_of','received_as','syncretized_with',
        'identified_with','equated_with','aligned_with','cult_form_of','reveals')
GROUP BY least(s.tradition, o.tradition), greatest(s.tradition, o.tradition)
ORDER BY links DESC, tradition_a, tradition_b;

-- ============================================================================
-- Internal diagnostic & review views (back-filled v1.22.3 for total fidelity).
-- Review dashboards, taxonomy/correspondence summaries, the inverse-expanded
-- relationship view, and staging helpers. Schema-qualified; dependency-ordered
-- as emitted by pg_dump (dependencies precede dependents).
-- ============================================================================

CREATE OR REPLACE VIEW public.entity_relationships_expanded AS
 SELECT entity_relationships.relationship_id,
    entity_relationships.subject_entity_id,
    entity_relationships.relationship_type,
    entity_relationships.object_entity_id,
    entity_relationships.confidence,
    entity_relationships.rationale,
    entity_relationships.source_id,
    entity_relationships.review_status,
    false AS is_inverse
   FROM public.entity_relationships
UNION ALL
 SELECT er.relationship_id,
    er.object_entity_id AS subject_entity_id,
    rt.inverse_relationship_type AS relationship_type,
    er.subject_entity_id AS object_entity_id,
    er.confidence,
    er.rationale,
    er.source_id,
    er.review_status,
    true AS is_inverse
   FROM (public.entity_relationships er
     JOIN public.relationship_types rt ON ((rt.relationship_type = er.relationship_type)))
  WHERE ((rt.inverse_relationship_type IS NOT NULL) AND (rt.inverse_relationship_type <> er.relationship_type));

CREATE OR REPLACE VIEW public.v_associated_with_conversion_candidates AS
 SELECT r.relationship_id,
    s.canonical_name AS subject,
    s.tradition AS subject_tradition,
    o.canonical_name AS object,
    o.tradition AS object_tradition,
    o.category AS object_category,
    r.source_id,
    r.confidence,
    r.review_status,
    r.rationale,
        CASE
            WHEN (o.canonical_name = ANY (ARRAY['Baptism'::text, 'Prayer'::text, 'Purification'::text, 'Theurgy'::text, 'Bridal Chamber'::text, 'Scapegoat'::text, 'Possession'::text])) THEN 'associated_ritual'::text
            WHEN (o.canonical_name = 'Protection'::text) THEN 'protects/guardian_of'::text
            WHEN (o.canonical_name = ANY (ARRAY['Wisdom'::text, 'Hidden Knowledge'::text, 'Knowledge'::text, 'Revelation'::text, 'Torah'::text, 'Prophecy'::text, 'Understanding'::text])) THEN 'teaches/reveals/transmits/possesses'::text
            WHEN (o.canonical_name = ANY (ARRAY['Underworld'::text, 'Pleroma'::text, 'World of Light'::text, 'Otherworld'::text, 'Planetary Spheres'::text])) THEN 'dwells_in/presides_over'::text
            WHEN (o.canonical_name = ANY (ARRAY['Truth'::text, 'Evil'::text, 'Pride'::text, 'Temptation'::text, 'Justice'::text, 'Good Mind'::text, 'Wholeness'::text, 'Immortality'::text])) THEN 'embodies'::text
            ELSE 'review_manually'::text
        END AS suggested_action
   FROM ((public.entity_relationships r
     JOIN public.entities s ON ((s.entity_id = r.subject_entity_id)))
     JOIN public.entities o ON ((o.entity_id = r.object_entity_id)))
  WHERE (r.relationship_type = 'associated_with'::text);

CREATE OR REPLACE VIEW public.v_category_distribution AS
 SELECT category,
    count(*) AS entity_count
   FROM public.entities
  GROUP BY category
  ORDER BY (count(*)) DESC;

CREATE OR REPLACE VIEW public.v_entity_correspondences AS
 SELECT e.entity_id,
    e.canonical_name,
    e.greek_name,
    e.tradition,
    e.entity_type,
    e.category,
    e.primary_domains,
    max(
        CASE
            WHEN ((s.system = 'classical_element'::text) AND (s.score_name = 'earth'::text)) THEN s.score
            ELSE NULL::integer
        END) AS earth,
    max(
        CASE
            WHEN ((s.system = 'classical_element'::text) AND (s.score_name = 'air'::text)) THEN s.score
            ELSE NULL::integer
        END) AS air,
    max(
        CASE
            WHEN ((s.system = 'classical_element'::text) AND (s.score_name = 'fire'::text)) THEN s.score
            ELSE NULL::integer
        END) AS fire,
    max(
        CASE
            WHEN ((s.system = 'classical_element'::text) AND (s.score_name = 'water'::text)) THEN s.score
            ELSE NULL::integer
        END) AS water,
    max(
        CASE
            WHEN ((s.system = 'classical_planet'::text) AND (s.score_name = 'moon'::text)) THEN s.score
            ELSE NULL::integer
        END) AS moon,
    max(
        CASE
            WHEN ((s.system = 'classical_planet'::text) AND (s.score_name = 'mercury'::text)) THEN s.score
            ELSE NULL::integer
        END) AS mercury,
    max(
        CASE
            WHEN ((s.system = 'classical_planet'::text) AND (s.score_name = 'venus'::text)) THEN s.score
            ELSE NULL::integer
        END) AS venus,
    max(
        CASE
            WHEN ((s.system = 'classical_planet'::text) AND (s.score_name = 'sun'::text)) THEN s.score
            ELSE NULL::integer
        END) AS sun,
    max(
        CASE
            WHEN ((s.system = 'classical_planet'::text) AND (s.score_name = 'mars'::text)) THEN s.score
            ELSE NULL::integer
        END) AS mars,
    max(
        CASE
            WHEN ((s.system = 'classical_planet'::text) AND (s.score_name = 'jupiter'::text)) THEN s.score
            ELSE NULL::integer
        END) AS jupiter,
    max(
        CASE
            WHEN ((s.system = 'classical_planet'::text) AND (s.score_name = 'saturn'::text)) THEN s.score
            ELSE NULL::integer
        END) AS saturn
   FROM (public.entities e
     LEFT JOIN public.entity_scores s ON ((e.entity_id = s.entity_id)))
  GROUP BY e.entity_id, e.canonical_name, e.greek_name, e.tradition, e.entity_type, e.category, e.primary_domains;

CREATE OR REPLACE VIEW public.v_entity_epithet_relationships AS
 SELECT e.entity_id,
    e.canonical_name,
    ep.epithet_id,
    ep.epithet_name,
    ep.translation,
    ee.confidence,
    ee.source_id,
    ee.notes
   FROM ((public.entity_epithets ee
     JOIN public.entities e ON ((e.entity_id = ee.entity_id)))
     JOIN public.epithets ep ON ((ep.epithet_id = ee.epithet_id)));

CREATE OR REPLACE VIEW public.v_entity_epithet_summary AS
 SELECT e.entity_id,
    e.canonical_name,
    e.tradition,
    e.entity_type,
    e.category,
    COALESCE(string_agg(DISTINCT ep.epithet_name, '; '::text ORDER BY ep.epithet_name), ''::text) AS epithets,
    COALESCE(string_agg(DISTINCT ep.translation, '; '::text ORDER BY ep.translation), ''::text) AS translations
   FROM ((public.entities e
     LEFT JOIN public.entity_epithets ee ON ((e.entity_id = ee.entity_id)))
     LEFT JOIN public.epithets ep ON ((ee.epithet_id = ep.epithet_id)))
  GROUP BY e.entity_id, e.canonical_name, e.tradition, e.entity_type, e.category;

CREATE OR REPLACE VIEW public.v_entity_relationships_full AS
 SELECT entity_relationships.subject_entity_id,
    entity_relationships.relationship_type,
    entity_relationships.object_entity_id
   FROM public.entity_relationships
UNION ALL
 SELECT er.object_entity_id AS subject_entity_id,
    rt.inverse_relationship_type AS relationship_type,
    er.subject_entity_id AS object_entity_id
   FROM (public.entity_relationships er
     JOIN public.relationship_types rt ON ((er.relationship_type = rt.relationship_type)))
  WHERE (rt.inverse_relationship_type IS NOT NULL);

CREATE OR REPLACE VIEW public.v_entity_taxonomy_summary AS
 SELECT e.entity_id,
    e.canonical_name,
    e.entity_type,
    e.category,
    e.primary_domains,
    COALESCE(string_agg(DISTINCT ea.animal, '; '::text), ''::text) AS animals,
    COALESCE(string_agg(DISTINCT ep.plant, '; '::text), ''::text) AS plants,
    COALESCE(string_agg(DISTINCT em.metal, '; '::text), ''::text) AS metals,
    COALESCE(string_agg(DISTINCT ef.function_name, '; '::text), ''::text) AS functions,
    COALESCE(string_agg(DISTINCT er.region, '; '::text), ''::text) AS regions
   FROM (((((public.entities e
     LEFT JOIN public.entity_animals ea ON ((e.entity_id = ea.entity_id)))
     LEFT JOIN public.entity_plants ep ON ((e.entity_id = ep.entity_id)))
     LEFT JOIN public.entity_metals em ON ((e.entity_id = em.entity_id)))
     LEFT JOIN public.entity_functions ef ON ((e.entity_id = ef.entity_id)))
     LEFT JOIN public.entity_regions er ON ((e.entity_id = er.entity_id)))
  GROUP BY e.entity_id, e.canonical_name, e.entity_type, e.category, e.primary_domains;

CREATE OR REPLACE VIEW public.v_entity_traditions AS
 SELECT e.entity_id,
    e.canonical_name,
    e.tradition AS primary_tradition,
    string_agg(t.tradition_tag, '; '::text ORDER BY t.tradition_tag) AS tradition_tags
   FROM (public.entities e
     LEFT JOIN public.entity_tradition_tags t ON ((e.entity_id = t.entity_id)))
  GROUP BY e.entity_id, e.canonical_name, e.tradition;

CREATE OR REPLACE VIEW public.v_possible_duplicate_entities AS
 SELECT lower(canonical_name) AS normalized_name,
    count(*) AS duplicate_count,
    string_agg(entity_id, '; '::text ORDER BY entity_id) AS entity_ids,
    string_agg((((((canonical_name || ' ['::text) || tradition) || ' / '::text) || category) || ']'::text), '; '::text ORDER BY entity_id) AS records
   FROM public.entities
  GROUP BY (lower(canonical_name))
 HAVING (count(*) > 1)
  ORDER BY (count(*)) DESC, (lower(canonical_name));

CREATE OR REPLACE VIEW public.v_relationships_needing_review AS
 SELECT s.canonical_name AS subject,
    s.tradition AS subject_tradition,
    r.relationship_type,
    o.canonical_name AS object,
    o.tradition AS object_tradition,
    r.confidence,
    r.source_id,
    r.rationale
   FROM ((public.entity_relationships r
     JOIN public.entities s ON ((s.entity_id = r.subject_entity_id)))
     JOIN public.entities o ON ((o.entity_id = r.object_entity_id)))
  WHERE (r.review_status = 'needs_review'::text)
  ORDER BY r.confidence, r.source_id, s.canonical_name, r.relationship_type, o.canonical_name;

CREATE OR REPLACE VIEW public.v_priority_relationship_review AS
 SELECT subject,
    subject_tradition,
    relationship_type,
    object,
    object_tradition,
    confidence,
    source_id,
    rationale
   FROM public.v_relationships_needing_review
  WHERE ((confidence = 'low'::text) OR (confidence = 'high'::text) OR (source_id = ANY (ARRAY['SRC_THEOI_GODS'::text, 'SRC_WILKINSON_EGYPTIAN_GODS'::text, 'SRC_DDD_BIBLE'::text, 'SRC_LAYTON_GNOSTIC'::text, 'SRC_NHC'::text])))
  ORDER BY confidence, source_id, subject, relationship_type, object;

CREATE OR REPLACE VIEW public.v_review_by_tradition AS
 SELECT subject_tradition,
    confidence,
    count(*) AS count
   FROM public.v_relationships_needing_review
  GROUP BY subject_tradition, confidence
  ORDER BY (count(*)) DESC;

CREATE OR REPLACE VIEW public.v_review_dashboard AS
 SELECT 'entities_by_confidence'::text AS section,
    entities.evidence_confidence AS key_1,
    entities.review_status AS key_2,
    count(*) AS count
   FROM public.entities
  GROUP BY entities.evidence_confidence, entities.review_status
UNION ALL
 SELECT 'relationships_by_confidence'::text AS section,
    entity_relationships.confidence AS key_1,
    entity_relationships.review_status AS key_2,
    count(*) AS count
   FROM public.entity_relationships
  GROUP BY entity_relationships.confidence, entity_relationships.review_status;

CREATE OR REPLACE VIEW public.v_staging_entity_duplicates AS
 SELECT se.canonical_name,
    se.tradition,
    e.entity_id AS existing_entity_id,
    e.canonical_name AS existing_name,
    e.tradition AS existing_tradition
   FROM (public.staging_entities se
     JOIN public.entities e ON ((lower(se.canonical_name) = lower(e.canonical_name))));

CREATE OR REPLACE VIEW public.v_staging_relationships_resolved AS
 SELECT s.entity_id AS subject_entity_id,
    sr.relationship_type,
    o.entity_id AS object_entity_id,
    COALESCE(sr.confidence, 'medium'::text) AS confidence,
    sr.rationale,
    sr.source_id,
    COALESCE(sr.review_status, 'needs_review'::text) AS review_status
   FROM (((public.staging_relationships sr
     JOIN public.entities s ON ((lower(sr.subject_name) = lower(s.canonical_name))))
     JOIN public.entities o ON ((lower(sr.object_name) = lower(o.canonical_name))))
     JOIN public.relationship_types rt ON ((sr.relationship_type = rt.relationship_type)));

