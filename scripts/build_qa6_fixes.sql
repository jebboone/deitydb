-- build_qa6_fixes.sql — whole-DB cross-tradition verb sweep. v1.67.6
-- Applies the v1.67.5 verb-discipline ruling consistently across the REVERSE/parallel edges
-- (functional Near-East<->Greek cosmic equations are aligned_with, not attested receptions),
-- deduplicates double-verb pairs, and propagates two earlier corrections (Lilith ancestor;
-- Sin=Hubal). Interpretatio blocks (Roman/Etruscan/Scythian/Norse), genuine reception chains
-- (Abrahamic, Welsh<-Irish<-Gaulish, Ishtar->Astarte->Aphrodite, Hurrian-Hittite succession,
-- the decans) are correct and left unchanged.
BEGIN;

-- ===== A. Functional Near-East <-> Greek parallels: reception_of -> aligned_with =====
-- (mirror of the v1.67.5 Mesopotamian-subject fixes, applied to the Greek/Levantine-subject reverse edges;
--  per Burkert/West these are typological or route through Hurrian-Hittite intermediaries, not direct receptions)
UPDATE entity_relationships SET relationship_type='aligned_with',
  rationale='Functional/typological cognate, not an attested reception (the cosmic-sovereignty/chaos parallels route through Hurrian-Hittite intermediaries or are modern comparisons; Burkert, West).'
WHERE relationship_type='reception_of' AND (subject_entity_id,object_entity_id) IN (
 ('ENT_OCEANUS','ENT_MES_APSU'),
 ('ENT_OURANOS','ENT_MES_ANU'),
 ('ENT_ZEUS','ENT_MES_ENLIL'),
 ('ENT_ZEUS','ENT_MES_MARDUK'),
 ('ENT_PROMETHEUS','ENT_MES_ENKI_EA'),
 ('ENT_DEMETER','ENT_MES_NINHURSAG'),
 ('ENT_DEMETER','ENT_HTT_TELIPINU'),
 ('ENT_PERSEPHONE','ENT_MES_ERESHKIGAL'),
 ('ENT_HERMES','ENT_MES_NABU'),
 ('ENT_SELENE','ENT_MES_NANNA_SIN'),
 ('ENT_TYPHON','ENT_MES_TIAMAT'),
 ('ENT_CAN_LOTAN','ENT_MES_TIAMAT'),
 ('ENT_ISR_LEVIATHAN','ENT_MES_TIAMAT'));

-- ===== B. Deduplicate double-verb pairs (keep the single most accurate verb) =====
-- Astarte<->Ishtar: keep reception_of (Semitic continuity); drop the redundant equated_with.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_CAN_ASTARTE' AND relationship_type='equated_with' AND object_entity_id='ENT_MES_INANNA_ISHTAR';
-- Leviathan<->Tiamat: now aligned_with (above); drop the redundant equated_with.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ISR_LEVIATHAN' AND relationship_type='equated_with' AND object_entity_id='ENT_MES_TIAMAT';
-- Leviathan<-Lotan: the genuine chain is reception_of (line kept); drop the redundant identified_with.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ISR_LEVIATHAN' AND relationship_type='identified_with' AND object_entity_id='ENT_CAN_LOTAN';
-- Dushara=Dionysus: keep equated_with (Nabataean interpretatio); drop the redundant received_as.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ARA_DUSHARA' AND relationship_type='received_as' AND object_entity_id='ENT_DIONYSUS';
-- Al-Lat=Athena: keep equated_with (Palmyrene interpretatio); drop the redundant received_as.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ARA_ALLAT' AND relationship_type='received_as' AND object_entity_id='ENT_ATHENA';
-- Al-Uzza=Aphrodite: keep equated_with; drop the redundant received_as.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ARA_AL_UZZA' AND relationship_type='received_as' AND object_entity_id='ENT_APHRODITE';

-- ===== C. Propagate two earlier corrections to their reverse edges =====
-- Lilith's ancestor is Lilitu, not Lamashtu (v1.67.5): re-point the reverse edge.
UPDATE entity_relationships SET object_entity_id='ENT_MES_LILITU',
  rationale='Lilith derives from the lilitu night-demon class (Lamashtu contributed only the child-harming motif).'
WHERE subject_entity_id='ENT_JM_LILITH' AND relationship_type='reception_of' AND object_entity_id='ENT_MES_LAMASHTU';
-- Sin = Hubal is a discredited speculation (v1.67.5 removed the forward edge): remove the reverse too.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ARA_HUBAL' AND relationship_type='reception_of' AND object_entity_id='ENT_MES_NANNA_SIN';

\echo '--- post-sweep: cross-tradition verb distribution ---'
SELECT r.relationship_type, count(*) FROM entity_relationships r
JOIN entities s ON s.entity_id=r.subject_entity_id JOIN entities o ON o.entity_id=r.object_entity_id
WHERE r.relationship_type IN ('reception_of','received_as','equated_with','identified_with','syncretized_with','aligned_with','cult_form_of')
  AND s.tradition<>o.tradition AND s.tradition NOT IN ('Cross-traditional','Abstraction') AND o.tradition NOT IN ('Cross-traditional','Abstraction')
GROUP BY 1 ORDER BY 2 DESC;

COMMIT;
