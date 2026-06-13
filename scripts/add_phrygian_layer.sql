-- scripts/add_phrygian_layer.sql
-- Adds the standalone Phrygian tradition layer:
-- 1 period, 2 sources, 2 new entities (the pre-Hellenic Phrygian originals),
-- entity_period/source links, and reception chains to the Greek-tradition
-- ENT_CYBELE, ENT_ATTIS, ENT_SABAZIOS already in the DB.
-- Note: ENT_CYBELE (tradition='Greek'), ENT_ATTIS (tradition='Greek'),
-- ENT_SABAZIOS (tradition='Greek') are preserved as-is; the new entities
-- ENT_PHRYG_MATAR and ENT_PHRYG_AGDISTIS capture the indigenous Phrygian layer.

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_ROLLER_CYBELE',
 'Roller, Lynn E. In Search of God the Mother: The Cult of Anatolian Cybele (University of California Press, 1999)',
 'secondary monograph',
 'The standard scholarly study of the Phrygian Matar Kubileya and her Hellenic reception as Cybele. Covers the rock-cut Phrygian shrines, the Midas City and Gordion evidence, the transmission to Greece through Phocaean traders, and the eventual Roman adoption as Magna Mater. Essential for distinguishing the Phrygian Matar tradition from its Greek and Roman syncretic descendants.'),
('SRC_PHRYGIAN_INSCRIPTIONS',
 'Corpus of Phrygian Inscriptions (various; primary)',
 'primary epigraphic',
 'The corpus of Phrygian-language inscriptions from sites across ancient Phrygia: Midas City (Yazılıkaya), Gordion, Boğazköy, and others. Key texts include the rock-cut dedications to Matar Kubileya. Old Phrygian inscriptions (8th–5th c. BCE); New Phrygian funerary curses (2nd–3rd c. CE). Edited: Claude Brixhe and Michel Lejeune, Corpus des inscriptions paléo-phrygiennes (1984); Brixhe, Corpus des inscriptions néo-phrygiennes (2019).')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_PHRYG_IRON_AGE',
 'Phrygian',
 'Phrygian Iron Age',
 -1200, -300,
 'The period of the Phrygian state, from the post-Hittite migrations through the Phrygian kingdom at its height (under Midas, c. 738–696 BCE) to the Macedonian conquest of Anatolia. Rock-cut Matar shrines at Midas City (Yazılıkaya) and Gordion date to the 8th–6th centuries BCE. Old Phrygian inscriptions in this period provide direct evidence for Matar Kubileya.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, short_note)
VALUES
('ENT_PHRYG_MATAR',
 'Matar Kubileya',
 'goddess',
 'Phrygian',
 'The pre-Hellenic Phrygian Mountain Mother; name means "Mother of the Mountain" (Phrygian matar = mother; Kubileya from Phrygian kybele/kybile, a title of the mountain goddess rather than a name). Attested in rock-cut shrine dedications at Midas City (Yazılıkaya, 8th c. BCE) and Gordion. Her iconographic form — a woman in a long robe framed in a doorway or niche cut from rock — is native Anatolian, predating Greek influence. The Greek and Roman Cybele is a Hellenized reception of this Phrygian Matar figure, transmitted through Phocaean trading contacts (7th–6th c. BCE). Roller (1999) pp. 67-118; Phrygian Inscriptions W-01 (Midas City).'),
('ENT_PHRYG_AGDISTIS',
 'Agdistis',
 'god',
 'Phrygian',
 'The primordial hermaphroditic deity of the Phrygian myth cycle; described by Pausanias (7.17.10-12) and Arnobius (Adversus Nationes 5.5-7) as the original form of Cybele/Attis. Agdistis was born from the earth when Zeus''s seed fell on the rock of Agdos near Pessinus; the gods, fearing the hermaphroditic being, castrated it, from whose severed genitals sprang the almond tree — and from the almond tree, Attis. Agdistis then fell in love with Attis, which led to his self-castration. The myth is uniquely Phrygian/Pessinian; it does not appear in the Olympian Greek tradition. The "Pessinuntine myth" as reconstructed from Pausanias and Arnobius is the fullest account of the indigenous Phrygian theological origin of the Cybele-Attis complex. Roller (1999) pp. 139-149.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
-- Matar Kubileya
('ENT_PHRYG_MATAR','SRC_PHRYGIAN_INSCRIPTIONS','Direct attestation',
 'Matar Kubileya attested in Old Phrygian inscriptions at Midas City (W-01: "ates akenanogavos mater kubeile"), Gordion, and other Phrygian sites. These are the primary epigraphic attestations of the goddess in her indigenous Phrygian form, predating Greek contact.'),
('ENT_PHRYG_MATAR','SRC_ROLLER_CYBELE','Secondary analysis',
 'Roller (1999) pp. 67-118: definitive analysis of the Matar Kubileya evidence from Phrygian rock-cut shrines; Midas City, Gordion, and the Phrygian heartland inscriptions. Distinguishes the indigenous Phrygian Matar from the Hellenized Cybele.'),
-- Agdistis
('ENT_PHRYG_AGDISTIS','SRC_ROLLER_CYBELE','Secondary analysis',
 'Roller (1999) pp. 139-149: the "Pessinuntine myth" of Agdistis; Pausanias 7.17.10-12 and Arnobius Adversus Nationes 5.5-7 as the two main textual witnesses; the hermaphroditic theology as specifically Phrygian.'),
-- Existing Phrygian-adjacent entities: add Roller and inscriptions
('ENT_CYBELE','SRC_ROLLER_CYBELE','Secondary analysis',
 'Roller (1999) is the standard scholarly treatment of Cybele as a Hellenized reception of the Phrygian Matar Kubileya; traces the transmission route through Phocaean traders, the Ephesian and Lydian intermediaries, and the eventual Roman Magna Mater adoption in 204 BCE.'),
('ENT_ATTIS','SRC_ROLLER_CYBELE','Secondary analysis',
 'Roller (1999) pp. 141-160: Attis in the context of the Phrygian Pessinuntine myth; the castration narrative as a Phrygian theological statement about the relationship of the mortal consort to the divine mother.'),
('ENT_SABAZIOS','SRC_ROLLER_CYBELE','Secondary analysis',
 'Roller (1999) pp. 170-175: Sabazios as a Phrygian/Thracian deity; his relationship to the Phrygian religious complex and the Anatolian divine matrix.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_PHRYG_MATAR','PER_PHRYG_IRON_AGE','high',
 'Rock-cut Matar shrines at Midas City date to 8th–6th c. BCE; Old Phrygian inscriptions name Matar Kubileya in this period','SRC_PHRYGIAN_INSCRIPTIONS','reviewed'),
('ENT_PHRYG_AGDISTIS','PER_PHRYG_IRON_AGE','medium',
 'Agdistis myth belongs to Pessinuntine Phrygian tradition; likely pre-Hellenic origin though textual attestations (Pausanias, Arnobius) are late','SRC_ROLLER_CYBELE','reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ───────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Greek Cybele is a reception of Phrygian Matar
('ENT_CYBELE','reception_of','ENT_PHRYG_MATAR','high',
 'Greek/Roman Cybele is a Hellenized reception of the Phrygian Matar Kubileya; the transmission route was through Phocaean Greek traders contacting Phrygian cult centers in the 7th–6th c. BCE. Key moments: the introduction of Cybele to Smyrna and Ephesus (6th c. BCE), then to Athens (5th c. BCE), then to Rome (204 BCE as Magna Mater/Mater Deum). Roller (1999) pp. 119-165.',
 'SRC_ROLLER_CYBELE',NULL,'reviewed'),

-- Agdistis is the primordial form from which Cybele and Attis spring
('ENT_CYBELE','emanates_from','ENT_PHRYG_AGDISTIS','medium',
 'In the Pessinuntine myth (Pausanias 7.17; Arnobius 5.5-7), Cybele/Matar emerges from the story of Agdistis; Agdistis represents the undifferentiated hermaphroditic divine before gender separation. Confidence medium because this relationship is expressed mythologically, not via a direct Cybele-from-Agdistis chain; the logic is: Agdistis castrated → almond tree → Attis, and Agdistis then merges with or becomes identified as Cybele in the later myth.',
 'SRC_ROLLER_CYBELE',NULL,'reviewed'),

('ENT_ATTIS','emanates_from','ENT_PHRYG_AGDISTIS','high',
 'In the Pessinuntine myth, Attis is born from the almond tree that springs from Agdistis''s severed genitals; Agdistis is thus Attis''s mythological origin. Pausanias 7.17.10-12; Arnobius Adversus Nationes 5.5-7; Roller (1999) pp. 141-143.',
 'SRC_ROLLER_CYBELE',NULL,'reviewed'),

-- Sabazios as Phrygian deity
('ENT_SABAZIOS','member_of','ENT_PHRYG_MATAR','low',
 'Sabazios is sometimes grouped with the Phrygian/Anatolian religious complex; his name and worship origin are Phrygian/Thracian but his theology differs from the Matar cult. Confidence low: the relationship is scholarly inference, not textual statement.',
 'SRC_ROLLER_CYBELE',NULL,'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS phrygian_entities FROM entities WHERE tradition = 'Phrygian';
SELECT * FROM v_release_metrics;

COMMIT;
