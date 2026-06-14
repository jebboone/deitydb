-- scripts/add_aten_amarna.sql
-- Adds Aten and Anhur, the two notable gaps in the Egyptian tradition layer.
-- Aten: the solar disk of Amarna, one of the most historically significant
-- Egyptian deities (c. 18th Dynasty, peak under Akhenaten c. 1353-1336 BCE).
-- Anhur/Onuris: hunting and war deity of Thinis/This, attested from the Old Kingdom.

BEGIN;

-- ── 1. Source for Amarna texts ────────────────────────────────────────────────
-- The Great Hymn to the Aten (c. 1347 BCE) is the primary literary text;
-- Murnane's anthology is the standard English critical edition of Amarna sources.
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_MURNANE_AMARNA',
 'William J. Murnane, Texts from the Amarna Period in Egypt (Scholars Press, Atlanta, 1995)',
 'primary text / scholarly edition',
 'Critical edition and translation of inscriptions from the Amarna Period (reign of Akhenaten, c. 1353-1336 BCE), including the Great Hymn to the Aten (EA 25), the Shorter Hymn to the Aten, boundary stelae proclamations, and administrative texts from Akhetaten (Tell el-Amarna). The Great Hymn is the primary theological statement on Aten as sole creator and sustainer of all life; it is cited in scholarly literature as one of the earliest surviving expressions of monotheistic or henotheistic theology. Primary source for all Aten theological claims.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_EGY_ATEN',
 'Aten',
 'Egyptian',
 'solar deity',
 'Solar Deity',
 'sun; light; creation; sustenance; monotheism',
 'A',
 'The solar disk, worshipped as the sole deity during the Amarna Period under Pharaoh Akhenaten (c. 1353-1336 BCE). Aten is the visible disk of the sun and the light emanating from it, conceptualised as the direct creative and sustaining force of all life; the Great Hymn to the Aten (c. 1347 BCE) articulates an almost monotheistic theology in which Aten creates the world daily at dawn and maintains all creatures by its warmth and light. Unlike earlier solar deities (Ra, Khepri, Harakhty), Aten was not portrayed in human or animal form but as the disk with rays ending in hands that extend the ankh (life) to the royal family only. Aten had been a minor solar aspect since at least the Middle Kingdom (attested in the "Story of Sinuhe," c. 1900 BCE) before Akhenaten elevated it to sole deity status. Wilkinson (2003) pp. 236-240; Murnane (1995) passim.'),
('ENT_EGY_ANHUR',
 'Anhur',
 'Egyptian',
 'god',
 'War Deity',
 'war; hunting; sky; solar',
 'A',
 'God of war and hunting, whose cult centre was Thinis (This) in Upper Egypt; later also worshipped at Sebennytos in the Delta. Name means "He Who Leads Back the Distant One," referring to the myth in which he fetches the Eye of Ra (or the lion-form of Tefnut) from Nubia. In the New Kingdom Anhur was increasingly identified with Shu (his name compounded as Anhur-Shu), and both shared the role of upholding the sky. He was patron of the Egyptian army and later identified by Greeks with Ares (Onuris). Primary sources: Pyramid Texts, New Kingdom Theban royal inscriptions. Wilkinson (2003) pp. 106-107; UCLA Egyptology.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_EGY_ATEN', 'SRC_MURNANE_AMARNA', 'Primary text',
 'Great Hymn to the Aten (EA 25) and Shorter Hymn to the Aten; boundary stelae of Akhetaten proclaiming Aten''s unique status. Murnane (1995) is the critical edition.'),
('ENT_EGY_ATEN', 'SRC_WILKINSON_EGYPTIAN_GODS', 'Secondary analysis',
 'Wilkinson, Complete Gods and Goddesses (2003) pp. 236-240: full treatment of Aten from minor solar aspect to Amarna-period sole deity.'),
('ENT_EGY_ATEN', 'SRC_UCLA_EGYPTOLOGY', 'Secondary analysis',
 'UCLA Encyclopedia of Egyptology: "Aten" entry covers the pre-Amarna attestations (Story of Sinuhe, Middle Kingdom solar hymns) and the Amarna theology.'),
('ENT_EGY_ANHUR', 'SRC_WILKINSON_EGYPTIAN_GODS', 'Secondary analysis',
 'Wilkinson, Complete Gods and Goddesses (2003) pp. 106-107: Anhur/Onuris cult, iconography (man in robe holding spear, four feathered crown), identification with Shu and later with Greek Ares.'),
('ENT_EGY_ANHUR', 'SRC_FAULKNER_PYRAMID_TEXTS', 'Primary text',
 'Pyramid Texts (Utterances referencing Onuris/Anhur): attestation of the deity''s role as sky-upholder and hunter in the Old Kingdom textual tradition.'),
('ENT_EGY_ANHUR', 'SRC_UCLA_EGYPTOLOGY', 'Secondary analysis',
 'UCLA Encyclopedia of Egyptology: "Onuris" entry covers the Thinite origin, the myth of the Distant Goddess, and the Anhur-Shu theological conflation.')
ON CONFLICT DO NOTHING;

-- ── 4. Period assignments ─────────────────────────────────────────────────────
-- PER_EGY_AMARNA should already exist if the Egyptian period completion script ran;
-- use the existing late New Kingdom / Amarna period, or fall back to a general one.
-- Aten as a minor solar aspect is attested from the Middle Kingdom (~2055-1650 BCE);
-- its elevation to supreme deity belongs to the 18th Dynasty Amarna period.
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT 'ENT_EGY_ATEN', period_id, 'high',
       'Aten was elevated to sole deity during Akhenaten''s reign (18th Dynasty, c. 1353-1336 BCE); as minor solar aspect attested from the Middle Kingdom.',
       'SRC_MURNANE_AMARNA', 'reviewed'
FROM periods
WHERE period_id LIKE 'PER_EGY%' AND (period_name LIKE '%New Kingdom%' OR period_name LIKE '%Amarna%')
LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT 'ENT_EGY_ANHUR', period_id, 'high',
       'Anhur attested from the Pyramid Texts (Old Kingdom, c. 2375 BCE) through the Greco-Roman period when identified with Ares (Onuris).',
       'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'
FROM periods
WHERE period_id LIKE 'PER_EGY%' AND (period_name LIKE '%Old Kingdom%' OR period_name LIKE '%New Kingdom%')
LIMIT 1
ON CONFLICT DO NOTHING;

-- ── 5. Relationships ──────────────────────────────────────────────────────────
-- Aten as solar manifestation related to Ra/Horakhty
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_EGY_ATEN', 'cult_form_of', 'ENT_EGY_RA',
 'high',
 'Aten began as an aspect or visible disk of Ra before being elevated to independent supreme deity status. The full Amarna royal titulary reads "Ra-Horakhty who rejoices in the Horizon in his name Shu who is Aten," explicitly linking Aten to Ra-Horakhty. Murnane (1995); Wilkinson (2003) p. 236.',
 'SRC_MURNANE_AMARNA', 'reviewed'),
('ENT_EGY_ATEN', 'identified_with', 'ENT_EGY_RA_HORAKHTY',
 'high',
 'The early Amarna epithet explicitly merges Aten with Ra-Horakhty: "The living Aten who began life, Ra-Horakhty who rejoices in the horizon." This identification was gradually dropped as Aten was elevated to sole deity; Wilkinson (2003) p. 237.',
 'SRC_MURNANE_AMARNA', 'reviewed'),
('ENT_EGY_ATEN', 'opposes', 'ENT_EGY_AMUN',
 'high',
 'Akhenaten''s Amarna revolution was in part directed against the powerful Amun priesthood at Thebes; Aten as sole deity replaced Amun, and Akhenaten had Amun''s name excised from monuments. The theological opposition is historically documented. Wilkinson (2003) pp. 236-240.',
 'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
-- Anhur relationships
('ENT_EGY_ANHUR', 'identified_with', 'ENT_EGY_SHU',
 'high',
 'By the New Kingdom Anhur was theologically compounded with Shu (the air deity who upholds the sky), worshipped as Anhur-Shu at Sebennytos and Thinis. Both share the role of separating heaven from earth. Wilkinson (2003) pp. 106-107.',
 'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
('ENT_EGY_ANHUR', 'reception_of', 'ENT_EGY_RA',
 'medium',
 'The myth of Anhur as "He who leads back the Distant One" places him in the solar myth cycle: he retrieves the Eye of Ra or the lion-form of Tefnut from Nubia, connecting him to Ra''s mythology. UCLA Egyptology "Onuris" entry.',
 'SRC_UCLA_EGYPTOLOGY', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS total_egyptian FROM entities WHERE tradition = 'Egyptian';
SELECT e.canonical_name, COUNT(er.relationship_id) AS rels
FROM entities e
LEFT JOIN entity_relationships er ON (er.subject_entity_id=e.entity_id OR er.object_entity_id=e.entity_id)
WHERE e.entity_id IN ('ENT_EGY_ATEN','ENT_EGY_ANHUR')
GROUP BY e.entity_id, e.canonical_name;
SELECT * FROM v_release_metrics;

COMMIT;
