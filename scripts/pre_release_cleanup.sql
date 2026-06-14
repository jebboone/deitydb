-- scripts/pre_release_cleanup.sql
-- Pre-v1.2.0 cleanup:
-- 1. Remove speculative Tinia→Voltumna rules relationship (not directly attested)
-- 2. Type the 3 remaining associated_with edges → paired_with
-- 3. Add ENT_ISL_MUSA and ENT_ISL_ILYAS with Quran sources and reception chains

BEGIN;

-- ── 1. Remove Tinia → Voltumna rules (speculative; Voltumna was an independent deity) ──
DELETE FROM entity_relationships
WHERE subject_entity_id = 'ENT_ETR_TINIA'
  AND relationship_type = 'rules'
  AND object_entity_id = 'ENT_ETR_VOLTUMNA';

-- ── 2. Retype the 3 remaining associated_with edges ────────────────────────────

-- Osiris ↔ Hapy: paired deities of fertility and Nile inundation
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_EGY_OSIRIS','paired_with','ENT_EGY_HAPY_NILE','medium',
 'Osiris and Hapy are paired in Egyptian theology as complementary deities of Nile fertility: Hapy embodies the inundation itself; Osiris embodies the agricultural renewal it enables. They appear together in funerary and agricultural contexts without being identified. Faulkner, Pyramid Texts Utterance 442.',
 'SRC_FAULKNER_PYRAMID_TEXTS','reviewed'),
('ENT_EGY_HAPY_NILE','paired_with','ENT_EGY_OSIRIS','medium',
 'Hapy and Osiris are paired as complementary Nile-fertility deities; Hapy is the flood, Osiris the renewal. Faulkner, Pyramid Texts Utterance 442.',
 'SRC_FAULKNER_PYRAMID_TEXTS','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

DELETE FROM entity_relationships
WHERE subject_entity_id = 'ENT_EGY_OSIRIS'
  AND relationship_type = 'associated_with'
  AND object_entity_id = 'ENT_EGY_HAPY_NILE';

-- Sia ↔ Thoth: paired cognitive deities
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_EGY_SIA','paired_with','ENT_EGY_THOTH','medium',
 'Sia (divine perception/understanding) and Thoth (divine knowledge/writing) are paired in New Kingdom cosmological texts as complementary aspects of divine cognition; both travel on the solar barque. Papyrus Bremner-Rhind; Book of the Dead ch. 17.',
 'SRC_FAULKNER_PYRAMID_TEXTS','reviewed'),
('ENT_EGY_THOTH','paired_with','ENT_EGY_SIA','medium',
 'Thoth and Sia are paired cognitive deities on the solar barque; Thoth provides knowledge/recording, Sia provides perception/understanding. Book of the Dead ch. 17.',
 'SRC_FAULKNER_PYRAMID_TEXTS','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

DELETE FROM entity_relationships
WHERE subject_entity_id = 'ENT_EGY_SIA'
  AND relationship_type = 'associated_with'
  AND object_entity_id = 'ENT_EGY_THOTH';

-- Theurgy ↔ Magic: distinct but related ritual categories
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_THEURGY','paired_with','ENT_MAGIC','medium',
 'Theurgy and magic are paired as overlapping late-antique ritual categories that the tradition itself labored to distinguish: theurgy (theurgía) claimed divine sanction and soul-ascent; magic (goeteia/mageia) was the pejorative other. Iamblichus De Mysteriis I.1-2 is the key text defending the distinction. They share techniques while differing in theological framing.',
 'SRC_BURKERT_GREEK_RELIGION','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

DELETE FROM entity_relationships
WHERE subject_entity_id = 'ENT_THEURGY'
  AND relationship_type = 'associated_with'
  AND object_entity_id = 'ENT_MAGIC';

-- ── 3. Moses → Musa / Elijah → Ilyas ──────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, short_note)
VALUES
('ENT_ISL_MUSA',
 'Musa (Moses)',
 'prophet',
 'Islamic',
 'Quranic prophet; the most frequently mentioned prophet in the Quran (136 times across 36 suras). Receives the Torah (Tawrat) from God; leads the Israelites from Egypt; speaks directly with God at the burning bush (Quran 20:9-48; 28:29-35). The Islamic Musa is the Quranic reception of the Hebrew Bible Moses (ENT_ISR_MOSES), substantially paralleling the Exodus narrative while incorporating Quranic theological reframing. One of the five Ulu al-Azm (Prophets of Firm Resolve).'),
('ENT_ISL_ILYAS',
 'Ilyas (Elijah)',
 'prophet',
 'Islamic',
 'Quranic prophet; identified with the Hebrew Bible Elijah (ENT_ISR_ELIJAH). Named in Quran 6:85 (in the list of prophets) and 37:123-132 (the sura Al-Saffat account of Ilyas reproving Baal worship). The Quranic account closely parallels 1 Kings 18 (the confrontation with Baal). Some Islamic traditions identify Ilyas with al-Khidr (the immortal green man), though this is disputed.')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_ISL_MUSA','SRC_QURAN','Direct attestation',
 'The most frequently mentioned prophet in the Quran: 136 mentions across 36 suras. Key passages: 2:51-61 (the Israelites in the wilderness); 7:103-162 (extended Moses narrative); 20:9-98 (Sura Ta-Ha: burning bush, Pharaoh, golden calf); 28:3-43 (Sura Al-Qasas: birth, exile, commissioning, exodus). The Quran treats Musa as a paradigmatic prophet whose community failed — a counter-example structuring the Islamic self-understanding of the umma.'),
('ENT_ISL_MUSA','SRC_ISLAM_EI2','Secondary analysis',
 'Encyclopedia of Islam s.v. "Musa": survey of Quranic and hadith material; post-Quranic Islamic tradition elaborations including the Night Journey (Musa''s role in fixing the five daily prayers).'),
('ENT_ISL_ILYAS','SRC_QURAN','Direct attestation',
 'Quran 6:85 (listed among the prophets); 37:123-132 (Sura Al-Saffat: Ilyas reproaches his people for worshipping Baal; parallel to 1 Kings 18; Ilyas is "one of the sent ones"). The Quranic account is brief; the identification with Elijah is made explicit by the Baal-worship context.'),
('ENT_ISL_ILYAS','SRC_ISLAM_EI2','Secondary analysis',
 'Encyclopedia of Islam s.v. "Ilyas": the Quranic Ilyas identified with Hebrew Elijah; the disputed identification with al-Khidr in some Islamic traditions.')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_ISL_MUSA','PER_ISL_EARLY','high',
 'Musa is a foundational Quranic prophet; his narrative is central to the earliest Meccan and Medinan suras','SRC_QURAN','reviewed'),
('ENT_ISL_ILYAS','PER_ISL_EARLY','high',
 'Ilyas named in Quran 6:85 and 37:123-132; foundational Quranic prophet list','SRC_QURAN','reviewed')
ON CONFLICT DO NOTHING;

-- Reception chains
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
('ENT_ISL_MUSA','reception_of','ENT_ISR_MOSES','high',
 'The Quranic Musa is an explicit reception of the Hebrew Moses: the burning bush, the staff, the parting of the sea, the tablets — all appear in the Quran (7:103-162; 20:9-98; 28:29-43) with Islamic theological reframing. Musa is the most frequently mentioned prophet in the Quran (136 times); he functions as the paradigmatic prophet whose community failed, structuring Islamic self-understanding. The reception is direct and textually explicit, not mediated through Greek or other traditions.',
 'SRC_QURAN','PER_ISL_EARLY','reviewed'),
('ENT_ISL_ILYAS','reception_of','ENT_ISR_ELIJAH','high',
 'The Quranic Ilyas is an explicit reception of the Hebrew Elijah: the confrontation with Baal-worshippers (Quran 37:123-132) maps directly onto 1 Kings 18. The name Ilyas is a direct Arabic adaptation of the Hebrew Eliyyahu. The Quranic account is briefer than the Hebrew Bible narrative but the identification is unambiguous.',
 'SRC_QURAN','PER_ISL_EARLY','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS remaining_associated_with
FROM entity_relationships WHERE relationship_type = 'associated_with';

SELECT entity_id, canonical_name FROM entities
WHERE entity_id IN ('ENT_ISL_MUSA','ENT_ISL_ILYAS');

SELECT * FROM v_release_metrics;

COMMIT;
