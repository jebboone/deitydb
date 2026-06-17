-- build_qa4_fixes.sql — corrections from the v1.67.4 audit of the Celtic inscriptional gods
-- and the Egyptian Duat/funerary cast. 1 removal (likely fabrication), interpretatio-verb
-- cleanup, a garbled name, and several mis-modeled relationships/over-claimed domains.
BEGIN;

-- ===================== EGYPTIAN DUAT =====================
-- AKHEKHI: 'guardian of gate 12 paired with Pai' not attested (gate 12 = Tjeser-baiu, Isis/Nephthys serpents);
-- likely conflated with the Set-creature Akhekh. Remove.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_AKHEKHI' OR object_entity_id='ENT_EGY_AKHEKHI';
DELETE FROM entity_periods WHERE entity_id='ENT_EGY_AKHEKHI';
DELETE FROM entity_sources WHERE entity_id='ENT_EGY_AKHEKHI';
DELETE FROM entities WHERE entity_id='ENT_EGY_AKHEKHI';

-- ANKHNETERU: truncated name; the 12th-hour tow-serpent is Ka-en-Ankh-Neteru.
UPDATE entities SET canonical_name='Ka-en-Ankh-Neteru (the World-Encircling Serpent)',
 short_note='The great serpent "Ka-en-Ankh-Neteru" ("Life of the Gods") through whose body the barque is towed in the Amduat''s twelfth hour, the sun entering aged and emerging reborn as Khepri. (Often shortened to Ankh-neteru.)'
 WHERE entity_id='ENT_EGY_ANKHNETERU';

-- AMMIT: belongs_to_realm pointed at a god; 'judges Maat' is wrong (she devours the unjustified; Maat is the standard).
UPDATE entity_relationships SET object_entity_id='ENT_EGY_DUAT', rationale='Ammit crouches in the Hall of the Two Truths within the Duat, awaiting the verdict.'
 WHERE subject_entity_id='ENT_EGY_AMMIT' AND relationship_type='belongs_to_realm' AND object_entity_id='ENT_EGY_OSIRIS';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_AMMIT' AND relationship_type='judges' AND object_entity_id='ENT_EGY_MAAT';

-- MEHET-WERET: she is an Eye of Ra / celestial cow who BEARS the sun, not an embodiment of Ra.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_MEHETWERET' AND relationship_type='embodies' AND object_entity_id='ENT_EGY_RA';
UPDATE entities SET short_note='The "Great Flood," celestial cow goddess of the primeval waters from which the sun arose; an Eye of Ra who bears the sun between her horns, and a creation goddess (Pyramid Texts; BD Spell 17). Not an embodiment of Ra himself.'
 WHERE entity_id='ENT_EGY_MEHETWERET';

-- KA-MAAT: spurious cross-link conflating the Amduat barque crew with the Litany's 75 Forms of Re.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_KAMAAT' AND relationship_type='member_of' AND object_entity_id='ENT_EGY_75_FORMS_RE';

-- SET-EM-MAAT-F: drop the BD-125 "Hall of Maat / Judgment Hall" gloss (genre bleed); downgrade.
UPDATE entities SET evidence_confidence='C',
 short_note='An upright guardian serpent set before the sixth gate of the night in the Book of Gates; the name must be known for the barque to pass.'
 WHERE entity_id='ENT_EGY_SETEMMAATF';

-- ===================== CELTIC (Gaulish / Romano-British) =====================
-- ESUS & TEUTATES: the Lucan-triad Roman equations are DISPUTED (Bern scholia transmit two
-- contradictory traditions swapping Mars/Mercury). Soften both equated_with -> aligned_with + flag.
UPDATE entity_relationships SET relationship_type='aligned_with', rationale='The Bern scholia on Lucan give contradictory interpretationes (Esus = Mars OR Mercury); the equation is disputed.'
 WHERE subject_entity_id='ENT_CEL_ESUS' AND relationship_type='equated_with' AND object_entity_id='ENT_ROM_MERCURY';
UPDATE entities SET short_note='Gaulish deity of uncertain function, one of Lucan''s three (with Taranis and Teutates); known for the tree-felling iconography with the bull Tarvos Trigaranus (Paris Pillar of the Boatmen). The Bern scholia equate him variously with Mars OR Mercury — the interpretatio is disputed. "Esus" may be a title ("Lord/Master").'
 WHERE entity_id='ENT_CEL_ESUS';
UPDATE entity_relationships SET relationship_type='aligned_with', rationale='The Bern scholia give contradictory interpretationes (Teutates = Mercury OR Mars); the equation is disputed.'
 WHERE subject_entity_id='ENT_CEL_TEUTATES' AND relationship_type='equated_with' AND object_entity_id='ENT_ROM_MARS';
UPDATE entities SET short_note='Gaulish tribal/protective god ("Toutatis" = "god of the tribe/people"); one of Lucan''s three. The Bern scholia equate him variously with Mercury OR Mars — the interpretatio is disputed.'
 WHERE entity_id='ENT_CEL_TEUTATES';

-- TARANIS: Taranis = Jupiter is an ANCIENT interpretatio (Lucan; CIL Iupiter Taranucus) -> equated_with, not the modern aligned_with.
UPDATE entity_relationships SET relationship_type='equated_with', rationale='Taranis is equated with Jupiter in the ancient sources (Lucan; dedications to Iupiter Taranucus/Taranis).'
 WHERE subject_entity_id='ENT_CEL_TARANIS' AND relationship_type='aligned_with' AND object_entity_id='ENT_ROM_JUPITER';

-- BELENUS: 'embodies Sun' rests on a now-doubted "bright->solar" etymology; he is a HEALING god (Apollo).
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_CEL_BELENUS' AND relationship_type='embodies' AND object_entity_id='ENT_SUN';
UPDATE entities SET short_note='A widely-worshipped healing god of Gaul, N. Italy and Noricum, equated with Apollo (~51 inscriptions). The traditional "shining/solar" reading of the name is now doubted (Delamarre: *bʰel- = "white/pale", not "shining"); his attested character is healing (Apollo-the-healer), with a possible henbane (belenuntia) connection rather than a sun-cult.'
 WHERE entity_id='ENT_CEL_BELENUS';

-- NODENS: epigraphically Mars Nodons but functionally a healing/hunting/SEA god close to Silvanus/Neptune.
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_BRI_NODENS','syncretized_with','ENT_ITA_SILVANUS','medium','At Lydney the cult''s hunting/woodland character ties Nodens to Silvanus alongside the epigraphic Mars Nodons.','SRC_GREEN_CELTIC_GODS','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;
UPDATE entities SET short_note='A Romano-British healing, hunting and sea god (the Lydney Park temple, with its dogs and marine imagery); epigraphically "Mars Nodons" but functionally close to Silvanus and Neptune. Ancestor of Irish Nuada and Welsh Nudd/Lludd.'
 WHERE entity_id='ENT_BRI_NODENS';

-- Note-level caveats (single-source / inferred / hapax attestations)
UPDATE entities SET short_note='A battle-crow goddess of the Allobroges, linguistic cognate of Irish Badb; known from a single damaged (and contested) inscription, CIL XII 2571 (Mieussy) — a hapax, not a securely attested cult.'
 WHERE entity_id='ENT_CEL_CATHUBODUA';
UPDATE entities SET short_note='Pan-Celtic many-skilled deity, attested chiefly as a theophoric/place-name element (Lugoves dedications; Lugdunum). Conventionally identified with the "Mercury" Caesar names as the chief Gaulish god — but Caesar names no Celtic gods, so this equation is a scholarly reconstruction. Cognate with Irish Lugh and Welsh Lleu.'
 WHERE entity_id='ENT_CEL_LUGUS';
UPDATE entities SET short_note='Divine youth ("the Great/Divine Son"), equated with Apollo in Romano-British dedications (Corbridge, Hexham, Ribchester); cognate with Welsh Mabon ap Modron. A youth/hunting deity; the "music" association is inferred from the Apollo equation rather than directly attested.'
 WHERE entity_id='ENT_CEL_MAPONOS';

\echo '--- post-fix orphan check (Celtic+EgyDuat cohorts, must be 0) ---'
WITH n AS (SELECT entity_id FROM entities WHERE tradition IN ('Celtic/Gaulish','Celtic/British','Celtic/Gaulish/Roman') OR (tradition='Egyptian' AND inclusion_basis ~ 'Amduat|Book of Gates|Litany of Re|netherworld|funerary|Coffin Texts|sacred geography|astronomical|star-clock|BD 17' AND inclusion_basis !~ 'Spell 125'))
SELECT count(*) AS orphans FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=n.entity_id OR r.object_entity_id=n.entity_id);

COMMIT;
