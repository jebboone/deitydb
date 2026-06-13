-- Psychopomp audit Tier 1 fix
-- Adds "psychopomp" to primary_domains for five confirmed soul-escort figures
-- and adds guides ENT_DEAD relationships where missing.
-- ENT_NOR_VALKYRIES already has guides ENT_DEAD; the others receive it here.

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- primary_domains updates
-- ─────────────────────────────────────────────────────────────────────────────

UPDATE entities SET primary_domains = primary_domains || '; psychopomp'
WHERE entity_id = 'ENT_NOR_VALKYRIES';

UPDATE entities SET primary_domains = primary_domains || '; psychopomp'
WHERE entity_id = 'ENT_THANATOS';

UPDATE entities SET primary_domains = primary_domains || '; psychopomp'
WHERE entity_id = 'ENT_ROM_MERCURY';

UPDATE entities SET primary_domains = primary_domains || '; psychopomp'
WHERE entity_id = 'ENT_ISR_ANGEL_OF_DEATH';

UPDATE entities SET primary_domains = primary_domains || '; psychopomp'
WHERE entity_id = 'ENT_ZOR_SRAOSHA';

-- ─────────────────────────────────────────────────────────────────────────────
-- guides ENT_DEAD relationships (skip Valkyries — already present)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
    ('ENT_THANATOS', 'guides', 'ENT_DEAD',
     'high',
     'Thanatos is the Greek personification of death who escorts souls at the moment of dying.',
     'SRC_THEOI_DAIMONES', 'reviewed'),

    ('ENT_ROM_MERCURY', 'guides', 'ENT_DEAD',
     'high',
     'Mercury serves as psychopomp in Roman religion, conducting souls to the underworld as Roman counterpart to Hermes.',
     'SRC_BEARD_ROMAN_RELIGIONS', 'reviewed'),

    ('ENT_ISR_ANGEL_OF_DEATH', 'guides', 'ENT_DEAD',
     'high',
     'The Angel of Death escorts souls at death in Israelite and Second Temple tradition.',
     'SRC_DDD_BIBLE', 'reviewed'),

    ('ENT_ZOR_SRAOSHA', 'guides', 'ENT_DEAD',
     'high',
     'Sraosha accompanies the soul of the righteous to the Chinvat Bridge for judgment (Hadhokht Nask, Avesta).',
     'SRC_AVESTA', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Verify
-- ─────────────────────────────────────────────────────────────────────────────

SELECT e.entity_id, e.canonical_name, e.primary_domains,
       EXISTS (
           SELECT 1 FROM entity_relationships er
           WHERE er.subject_entity_id = e.entity_id
             AND er.relationship_type = 'guides'
             AND er.object_entity_id = 'ENT_DEAD'
       ) AS has_guides_dead
FROM entities e
WHERE e.entity_id IN (
    'ENT_NOR_VALKYRIES', 'ENT_THANATOS', 'ENT_ROM_MERCURY',
    'ENT_ISR_ANGEL_OF_DEATH', 'ENT_ZOR_SRAOSHA'
)
ORDER BY e.tradition, e.canonical_name;

COMMIT;
