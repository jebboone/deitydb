-- scripts/disambiguate_death_cluster.sql
-- Abstraction-layer disambiguation (v1.23.0): sharpen the
-- Dead (the deceased) / Death (the force) / Underworld (the realm) distinction.
--
-- Audit finding: the three nodes are legitimately distinct and well-used (Hades,
-- Hel, Mot model them correctly), but six edges blurred the force/people/place
-- boundary. Apparent "synonym" nodes elsewhere (Binah vs Hokhmah, the individual
-- Muses, Phobos/Deimos, the Celtic Otherworld) encode real theological distinctions
-- and are deliberately left intact — merging them would flatten the ontology.
--
-- Net effect: -4 relationships (4 deletes, 2 retypes). source_id preserved on retypes;
-- stale rationales on the two gap-filling retypes updated. 0 unsourced relationships
-- maintained.

BEGIN;

-- 1. Thanatos: DELETE 'embodies Dead' — exact duplicate of the correct
--    'embodies Death' (Thanatos personifies the force of death, not the deceased).
DELETE FROM entity_relationships
WHERE subject_entity_id='ENT_THANATOS' AND relationship_type='embodies' AND object_entity_id='ENT_DEAD';

-- 2. Sheol: DELETE redundant 'belongs_to_realm Death'. Sheol already correctly has
--    'belongs_to_realm Underworld'; the duplicate to the Death force mislabels a realm
--    as belonging to a force.
DELETE FROM entity_relationships
WHERE subject_entity_id='ENT_ISR_SHEOL' AND relationship_type='belongs_to_realm' AND object_entity_id='ENT_DEATH';

-- 3. Osiris: RETYPE 'patron_of Death' -> 'rules Underworld'. Osiris rules and judges
--    the Egyptian Duat but had no Underworld edge at all — this fills a real gap.
UPDATE entity_relationships
SET relationship_type='rules', object_entity_id='ENT_UNDERWORLD',
    rationale='Osiris is the ruler and judge of the Egyptian underworld (Duat); as lord of the dead he presides over the realm of the afterlife.'
WHERE subject_entity_id='ENT_EGY_OSIRIS' AND relationship_type='patron_of' AND object_entity_id='ENT_DEATH';

-- 4. Nergal: RETYPE 'patron_of Death' -> 'rules Underworld'. Mesopotamian sovereign of
--    the underworld (consort of Ereshkigal); previously had no Underworld edge.
UPDATE entity_relationships
SET relationship_type='rules', object_entity_id='ENT_UNDERWORLD',
    rationale='Nergal is the Mesopotamian sovereign of the underworld (consort of Ereshkigal), associated with death, plague, and the realm of the dead.'
WHERE subject_entity_id='ENT_MES_NERGAL' AND relationship_type='patron_of' AND object_entity_id='ENT_DEATH';

-- 5. Ereshkigal: DELETE redundant 'patron_of Death'. Already 'rules Dead' +
--    'dwells_in Underworld'; she is a realm-queen, not the personified force of death.
DELETE FROM entity_relationships
WHERE subject_entity_id='ENT_MES_ERESHKIGAL' AND relationship_type='patron_of' AND object_entity_id='ENT_DEATH';

-- 6. Anubis: DELETE redundant 'patron_of Death'. Already 'guides' + 'guardian_of Dead';
--    funerary/embalming patron of the deceased, not the personified force of death.
DELETE FROM entity_relationships
WHERE subject_entity_id='ENT_EGY_ANUBIS' AND relationship_type='patron_of' AND object_entity_id='ENT_DEATH';

-- ── Verify ───────────────────────────────────────────────────────────────────
-- Death-force node now holds only true personifications (no realm-rulers/funerary gods):
SELECT s.canonical_name AS deity, r.relationship_type
FROM entity_relationships r JOIN entities s ON s.entity_id=r.subject_entity_id
WHERE r.object_entity_id='ENT_DEATH' AND r.relationship_type IN ('patron_of','embodies')
ORDER BY r.relationship_type, s.canonical_name;

-- Osiris and Nergal now rule the Underworld:
SELECT s.canonical_name, r.relationship_type, o.canonical_name
FROM entity_relationships r
JOIN entities s ON s.entity_id=r.subject_entity_id
JOIN entities o ON o.entity_id=r.object_entity_id
WHERE r.object_entity_id='ENT_UNDERWORLD' AND r.relationship_type='rules'
ORDER BY s.canonical_name;

-- Invariants hold: 0 unsourced relationships, 0 unresolved.
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT * FROM v_release_metrics;

COMMIT;
