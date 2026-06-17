-- build_qa5_fixes.sql — corrections from the v1.67.5 audit of the Mesopotamian deepening
-- (v1.52/v1.60). No fabrications found. Fixes: cross-tradition verb discipline (received_as ->
-- aligned_with for functional parallels), 2 inverted creator edges, a mis-rooted Lilith link,
-- a discredited Sin=Hubal link, and several relationship/parentage corrections.
-- NB: the Seven Sages king-advisor pairings were checked against Lenzi's Uruk List and are CORRECT
-- (one audit agent's "fix" was itself mistaken) — left unchanged.
BEGIN;

-- ===== A. CROSS-TRADITION: received_as -> aligned_with (functional/typological parallels, not attested receptions) =====
UPDATE entity_relationships SET relationship_type='aligned_with', rationale='Functional/typological cognate (no attested diffusion of the Mesopotamian deity into the later cult); per Burkert/West the real transmission, where any, runs through Hurrian-Hittite intermediaries.'
WHERE relationship_type='received_as' AND (subject_entity_id,object_entity_id) IN (
 ('ENT_MES_ANU','ENT_OURANOS'),
 ('ENT_MES_APSU','ENT_OCEANUS'),
 ('ENT_MES_ENLIL','ENT_ZEUS'),
 ('ENT_MES_MARDUK','ENT_ZEUS'),
 ('ENT_MES_ENKI_EA','ENT_PROMETHEUS'),
 ('ENT_MES_NINHURSAG','ENT_DEMETER'),
 ('ENT_MES_ERESHKIGAL','ENT_PERSEPHONE'),
 ('ENT_MES_NABU','ENT_HERMES'),
 ('ENT_MES_NANNA_SIN','ENT_SELENE'),
 ('ENT_MES_DUMUZI_TAMMUZ','ENT_PHO_MELQART'),
 ('ENT_MES_DUMUZI_TAMMUZ','ENT_HTT_TELIPINU'),
 ('ENT_MES_TIAMAT','ENT_CAN_LOTAN'),
 ('ENT_MES_TIAMAT','ENT_ISR_LEVIATHAN'),
 ('ENT_MES_TIAMAT','ENT_TYPHON'));
-- (Kept as genuine receptions: Ishtar->Astarte, Ishtar->Aphrodite, Dumuzi->Adonis, Apkallu->Watchers;
--  kept identified_with: Ishtar=Shaushka.)

-- Sin = Hubal: a discredited (Winckler/Morey-era) speculation with no attestation. Remove.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MES_NANNA_SIN' AND relationship_type='received_as' AND object_entity_id='ENT_ARA_HUBAL';

-- Lilith's ancestor is the lilitu night-demon, NOT Lamashtu. Re-point the reception.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MES_LAMASHTU' AND relationship_type='received_as' AND object_entity_id='ENT_JM_LILITH';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_MES_LILITU','received_as','ENT_JM_LILITH','high','Lilith descends etymologically and demonologically from the Mesopotamian lilitu/lili night-demon class (Lamashtu contributed only the child-harming motif).','SRC_BLACK_GREEN_MESO','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ===== B. INVERTED creator edges (both were CREATED BY Ea, per their own notes) =====
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MES_KULLA' AND relationship_type='creator_of' AND object_entity_id='ENT_MES_ENKI_EA';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MES_SALTU' AND relationship_type='creator_of' AND object_entity_id='ENT_MES_ENKI_EA';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_MES_ENKI_EA','creator_of','ENT_MES_KULLA','high','Ea forms the brick-god Kulla from clay for building rites.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_ENKI_EA','creator_of','ENT_MES_SALTU','high','Ea creates Saltu ("Strife") from the dirt of his fingernails to humble Ishtar in the Agushaya Hymn.','SRC_FOSTER_MUSES','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ===== C. INTRA-MESOPOTAMIAN relationship corrections =====
-- Humut-tabal "dwells_in Ereshkigal" — Ereshkigal is a deity, not a place.
UPDATE entity_relationships SET object_entity_id='ENT_UNDERWORLD', rationale='The ferryman dwells in the underworld (in Ereshkigal''s service).'
 WHERE subject_entity_id='ENT_MES_HUMUTTABAL' AND relationship_type='dwells_in' AND object_entity_id='ENT_MES_ERESHKIGAL';
-- Pabilsag: remove wrong parentage of Ninazu (his parents are Enlil & Ninlil / Ereshkigal) and the redundant Gula consort (= Ninisina).
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MES_PABILSAG' AND relationship_type='parent_of' AND object_entity_id='ENT_MES_NINAZU';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MES_PABILSAG' AND relationship_type='consort_of' AND object_entity_id='ENT_MES_GULA';
-- Damu's primary parent is Ninisina (Gula only via syncretism).
UPDATE entity_relationships SET object_entity_id='ENT_MES_NINISINA', rationale='Damu is the son of Ninisina of Isin (Gula is her syncretic counterpart).'
 WHERE subject_entity_id='ENT_MES_DAMU' AND relationship_type='child_of' AND object_entity_id='ENT_MES_GULA';
-- Etana was an orphan: add his divine patron Shamash (who directs him to the eagle in the Etana epic).
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_MES_UTU_SHAMASH','patron_of','ENT_MES_ETANA','medium','In the Etana epic Shamash answers the king''s prayer and directs him to the eagle that bears him toward heaven.','SRC_FOSTER_MUSES','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ===== D. CONFIDENCE / NOTE corrections =====
UPDATE entities SET evidence_confidence='B',
 short_note='Husband of Ereshkigal (named in "Inanna''s Descent"); his name means "great bull of An." Often equated by modern scholars with the Bull of Heaven slain in the Gilgamesh epic, though that identification is not certain.'
 WHERE entity_id='ENT_MES_GUGALANNA';
UPDATE entities SET short_note='The great healing goddess ("the great physician"); originally distinct from but syncretized with Ninisina, Nintinugga and Bau; her emblem animal is the dog.'
 WHERE entity_id='ENT_MES_GULA';
UPDATE entities SET short_note='The ferryman of the underworld ("Bring-hither-quickly"), a servant in Ereshkigal''s court (Underworld Vision of an Assyrian Prince).'
 WHERE entity_id='ENT_MES_HUMUTTABAL';
UPDATE entities SET short_note='The healing and vegetation god of Isin, son of Ninisina (= Gula by syncretism); a dying god mourned in laments of the Dumuzi type.'
 WHERE entity_id='ENT_MES_DAMU';

\echo '--- post-fix: cohort orphans (must be 0) + Sin->Hubal gone ---'
WITH n AS (SELECT entity_id FROM entities WHERE tradition='Mesopotamian' AND inclusion_basis !~ 'Archaic Sumerian')
SELECT (SELECT count(*) FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=n.entity_id OR r.object_entity_id=n.entity_id)) AS orphans;

COMMIT;
