-- =====================================================
-- DeityDB Sample Queries
-- =====================================================

-- Release metrics

SELECT * FROM v_release_metrics;

-- =====================================================
-- Tradition overview
-- =====================================================

SELECT *
FROM v_public_tradition_overview;

-- =====================================================
-- Relationship overview
-- =====================================================

SELECT *
FROM v_public_relationship_overview;

-- =====================================================
-- Revealer figures
-- =====================================================

SELECT
canonical_name,
tradition,
category
FROM v_public_revealer_figures
ORDER BY tradition, canonical_name;

-- =====================================================
-- Underworld entities
-- =====================================================

SELECT
canonical_name,
tradition,
category
FROM v_public_underworld_entities
ORDER BY tradition, canonical_name;

-- =====================================================
-- Angelic beings
-- =====================================================

SELECT
canonical_name,
tradition,
category
FROM v_public_angelic_beings
ORDER BY tradition, canonical_name;

-- =====================================================
-- Adversarial beings
-- =====================================================

SELECT
canonical_name,
tradition,
category
FROM v_public_adversarial_beings
ORDER BY tradition, canonical_name;

-- =====================================================
-- Serpent and dragon beings
-- =====================================================

SELECT
canonical_name,
tradition,
category
FROM v_public_serpent_dragon_beings
ORDER BY tradition, canonical_name;

-- =====================================================
-- Wisdom and knowledge figures
-- =====================================================

SELECT
canonical_name,
tradition,
category
FROM v_public_wisdom_knowledge_beings
ORDER BY tradition, canonical_name;

-- =====================================================
-- Teaching and revelation relationships
-- =====================================================

SELECT
subject,
subject_tradition,
relationship_type,
object,
object_tradition
FROM v_public_relationship_triples
WHERE relationship_type IN
(
'reveals',
'teaches',
'transmits'
)
ORDER BY subject_tradition, subject;

-- =====================================================
-- Protective entities
-- =====================================================

SELECT
s.canonical_name,
s.tradition,
r.relationship_type,
o.canonical_name
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE r.relationship_type = 'protects'
ORDER BY s.tradition, s.canonical_name;

-- =====================================================
-- All traditions currently represented
-- =====================================================

SELECT DISTINCT tradition
FROM entities
ORDER BY tradition;

-- =====================================================
-- Comparative domains: index of shared functions and their cross-tradition reach
-- =====================================================

SELECT domain, entities, traditions, relationship_kinds
FROM v_public_domain_overview
ORDER BY traditions DESC, entities DESC;

-- =====================================================
-- Compare a single domain across traditions
-- (the core comparative query: who fills 'Sovereignty' everywhere?)
-- =====================================================

SELECT entity, entity_tradition, entity_kind, relationship_type, confidence
FROM v_public_comparative_domains
WHERE domain = 'Sovereignty'
ORDER BY entity_tradition, entity;
