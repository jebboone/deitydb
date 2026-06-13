-- scripts/add_canaanite_expansion.sql
-- Canaanite/Ugaritic foundational expansion: Dagon and Resheph
--
-- Two significant gaps in the 12-entity Canaanite layer:
--
--   Dagon: father of Baal in several Ugaritic texts; grain/sky deity; the
--   most widely attested West Semitic deity across Ebla (c. 2400 BCE), Mari
--   (c. 1800 BCE), Ugarit (c. 1400-1200 BCE), and Philistine cities (Iron Age).
--   A 12-entity Canaanite list with El, Baal, Asherah, and Anat but no Dagon
--   is missing Baal's father.
--
--   Resheph: plague/war deity; attested at Ugarit (gatekeeper of El's court),
--   in Egyptian New Kingdom religion (adopted as a war deity under Ramesses II),
--   in Phoenician Cyprus inscriptions, and in the Hebrew Bible (Hab. 3:5,
--   where Resheph and Deber flank Yahweh in a theophany). His Apollo parallel
--   (both are plague deities who can send and withhold disease) is one of the
--   better-documented Levantine→Greek deity transmissions.
--
-- No new sources needed: SRC_CROSS_CANAANITE_MYTH, SRC_UGARIT_PARDON,
-- SRC_UGARIT_DDD, SRC_DDD_BIBLE all already in DB.
-- New source added: SRC_PARDEE_UGARITIC_TEXTS for primary-text coverage of Resheph.

BEGIN;

-- ── 1. New source ────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_WYATT_RELIGIOUS_TEXTS',
   'N. Wyatt, Religious Texts from Ugarit, 2nd ed. (Sheffield Academic Press, 2002)',
   NULL,
   'primary text translation',
   'Translation with commentary of the full corpus of Ugaritic religious texts including the Baal Cycle (KTU 1.1-6), Aqhat, Kirta, and ritual texts; primary source for Dagon as father of Baal (KTU 1.5 VI 24), Resheph as gatekeeper, and the full Ugaritic pantheon')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New entities ──────────────────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_CAN_DAGON',
   'Dagon',
   'Canaanite/Ugaritic',
   'Grain/sky deity',
   'A',
   'Major West Semitic deity; possibly the father of Baal in Ugaritic texts (KTU 1.5 VI: "Baal son of Dagon"); grain deity whose name may derive from Semitic dagan (grain) though also connected to daganu (cloud/rain); worshipped from Ebla (c. 2400 BCE) and Mari (c. 1800 BCE) through Ugarit and into Philistine-period Ashdod and Gaza (Judges 16:23; 1 Samuel 5); the most geographically widespread West Semitic deity before the Hellenistic period'),

  ('ENT_CAN_RESHEPH',
   'Resheph',
   'Canaanite/Ugaritic',
   'Plague/war deity',
   'A',
   'Canaanite deity of plague, pestilence, and war; name means "flame" or "lightning-bolt"; serves as gatekeeper at El''s court in Ugaritic texts; adopted by Egypt as a war deity under Ramesses II (depicted with shield and axe); attested in the Hebrew Bible as a personified pestilence flanking Yahweh in Habakkuk 3:5; worshipped in Phoenician Cyprus (bilingual inscriptions) and at Ebla; the primary Levantine transmission source for the Apollo plague-deity complex in Greek religion')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Source links ──────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_CAN_DAGON', 'SRC_WYATT_RELIGIOUS_TEXTS',  'primary_attestation',
   'KTU 1.5 VI 24: "Baal son of Dagon"; Wyatt (2002) pp. 141-142 on Dagon''s parentage role'),
  ('ENT_CAN_DAGON', 'SRC_CROSS_CANAANITE_MYTH',   'secondary_reference',
   'Cross (1973) pp. 26-28 on Dagon''s position in the Ugaritic and wider West Semitic pantheon'),
  ('ENT_CAN_DAGON', 'SRC_DDD_BIBLE',               'secondary_reference',
   'DDD entry "Dagon": Mari and Ebla attestations, Philistine cult, biblical references'),
  ('ENT_CAN_RESHEPH','SRC_WYATT_RELIGIOUS_TEXTS',  'primary_attestation',
   'Ugaritic texts: Resheph as gatekeeper at El''s court; Wyatt (2002) pp. 398-399'),
  ('ENT_CAN_RESHEPH','SRC_UGARIT_PARDON',          'primary_attestation',
   'Pardee (2002) ritual texts: Resheph in god-lists and offering texts from Ugarit'),
  ('ENT_CAN_RESHEPH','SRC_DDD_BIBLE',              'secondary_reference',
   'DDD entry "Resheph": Egyptian adoption (Ramesses II), Hebrew Bible Hab. 3:5, Cypriot inscriptions')
ON CONFLICT DO NOTHING;

-- ── 4. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_CAN_DAGON', 'PER_MES_OLD_BAB',   'high',
   'Dagan attested at Ebla (c. 2400 BCE) and Mari (c. 1800 BCE) as a major West Semitic deity; predates Ugaritic attestation',
   'SRC_DDD_BIBLE', 'reviewed'),
  ('ENT_CAN_DAGON', 'PER_CAN_BRONZE_AGE','high',
   'Dagon attested in the Ugaritic Baal Cycle texts (c. 1400-1200 BCE) as father of Baal',
   'SRC_WYATT_RELIGIOUS_TEXTS', 'reviewed'),
  ('ENT_CAN_DAGON', 'PER_ISR_IRON_AGE',  'high',
   'Philistine Dagon attested at Ashdod and Gaza: Judges 16:23, 1 Samuel 5; Iron Age continuity',
   'SRC_DDD_BIBLE', 'reviewed'),
  ('ENT_CAN_RESHEPH','PER_CAN_BRONZE_AGE','high',
   'Resheph attested in the Ugaritic god-lists and ritual texts (c. 1400-1200 BCE)',
   'SRC_WYATT_RELIGIOUS_TEXTS', 'reviewed'),
  ('ENT_CAN_RESHEPH','PER_EGY_NEW_KINGDOM','high',
   'Resheph adopted as an Egyptian war deity under Ramesses II (c. 1279-1213 BCE); depicted on temple walls at Karnak and elsewhere',
   'SRC_DDD_BIBLE', 'reviewed'),
  ('ENT_CAN_RESHEPH','PER_ISR_IRON_AGE',  'medium',
   'Resheph as personified pestilence in Hebrew Bible: Habakkuk 3:5 (7th c. BCE); Deuteronomy 32:24',
   'SRC_DDD_BIBLE', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 5. Reception chains ──────────────────────────────────────────────────────

-- Dagon as parent of Baal
-- The Baal Cycle (KTU 1.5 VI) explicitly calls Baal "son of Dagon."
-- This reading is not universal — some texts call Baal "son of El" — but the
-- Dagon parentage is the direct Ugaritic textual claim.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_CAN_DAGON', 'parent_of', 'ENT_CAN_BAAL',
   'medium',
   'KTU 1.5 VI 24 (Baal Cycle, Ugarit) calls Baal "son of Dagon" (bn dgn). This parentage is attested in several Ugaritic texts alongside the alternative tradition that makes El Baal''s father; Cross (1973) and Wyatt (2002) treat the Dagon-paternity as authentic, noting that Dagon''s older Levantine authority made him a plausible divine father for the younger storm deity. The identification of Dagon as the "father" of the storm god parallels the Mesopotamian pattern where older grain/sky deities are the fathers of more active storm deities.',
   'SRC_WYATT_RELIGIOUS_TEXTS', 'reviewed', 'PER_CAN_BRONZE_AGE'),
  ('ENT_CAN_BAAL', 'child_of', 'ENT_CAN_DAGON',
   'medium',
   'Baal as "son of Dagon" per KTU 1.5 VI 24; alternate tradition also makes El his father. Medium confidence reflects the textual ambiguity.',
   'SRC_WYATT_RELIGIOUS_TEXTS', 'reviewed', 'PER_CAN_BRONZE_AGE')
ON CONFLICT DO NOTHING;

-- Resheph → Apollo: plague deity transmission
-- Both Resheph and Apollo are deities who send and withhold plague;
-- both are associated with the bow and arrow as the weapon of pestilence;
-- Burkert (1992) and West (1997) both note this as a well-grounded parallel.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_CAN_RESHEPH', 'received_as', 'ENT_APOLLO',
   'medium',
   'The Resheph→Apollo transmission is one of the better-documented Levantine→Greek deity parallels. Both share: (1) plague as primary domain — Resheph personifies pestilence (Hab. 3:5 has him flanking Yahweh alongside Deber/Plague); Apollo''s arrows bring plague in the Iliad (1.43-52); (2) the bow as the weapon of disease; (3) a dual role sending AND ending plague (Apollo Apotropaios, the "averter," parallels Resheph''s role as the deity who could be propitiated to stop pestilence); (4) a Cypriot connection — Resheph was worshipped at Kition on Cyprus (bilingual Phoenician-Greek inscriptions call him "Apollo") and Cyprus was a major transmission node for Levantine→Greek religious contact. West (1997) treats the Resheph-Apollo parallel as one of the most solidly attested Levantine→Archaic Greek deity connections.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_APOLLO', 'reception_of', 'ENT_CAN_RESHEPH',
   'medium',
   'Apollo as the Greek reception of the Levantine Resheph plague-deity complex; Cypriot bilingual inscriptions explicitly equate the two; bow-and-arrow plague, dual send/avert function, and Cypriot cult are the transmission vectors.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- ── 6. Verification ──────────────────────────────────────────────────────────

SELECT 'canaanite_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'Canaanite/Ugaritic';

SELECT * FROM v_release_metrics;

COMMIT;
