-- scripts/add_phrygian_expansion.sql
-- Completes the Phrygian tradition layer:
--   1. Upgrades ENT_ATTIS from a bare Greek-classified stub to a full Phrygian
--      entity with proper short_note, sources, period, and relationships.
--   2. Adds ENT_LUW_KUBABA (Luwian tradition), the city goddess of Carchemish
--      whose name "Kubaba" is the etymological source of "Kubileya" → "Cybele,"
--      completing the Kubaba → Matar Kubileya → Cybele reception chain.
--
-- The reception chain after this script:
--   ENT_LUW_KUBABA (Luwian, c. 900 BCE)
--     → ENT_PHRYG_MATAR reception_of ENT_LUW_KUBABA (Phrygian)
--       → ENT_CYBELE reception_of ENT_PHRYG_MATAR (Greek; already in DB)

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_VERMASEREN_CYBELE_ATTIS',
 'M.J. Vermaseren, Cybele and Attis: The Myth and the Cult, trans. A.M.H. Lemmers (Thames and Hudson, London, 1977)',
 'secondary scholarly',
 'The standard monograph on the Attis myth cycle and the mysteries of Cybele and Attis in the Greco-Roman world. Vermaseren surveys all the mythological variants of Attis — the Pessinuntine version (Pausanias 7.17.9-12; Arnobius, Adversus Nationes 5.5-7), the Lydian version (Diodorus 3.58-59), and the Phrygian-Sabaziast traditions — alongside the Roman cult as instituted in 204 BCE (importation of the Magna Mater stone from Pessinus) and the later development of the taurobolium and criobolium rites. Covers the annual festival cycle: the March 15-27 festival series (Canna Intrat, Arbor Intrat, Sanguem/Day of Blood, Hilaria) that enacts Attis''s death and resurrection; the role of the Galli (castrated priests) in the cult; Catullus Poem 63 as the most vivid Latin literary treatment; Ovid Fasti 4.179-246 on the pine tree and Attis myth. Cited for ENT_PHRYG_ATTIS.'),
('SRC_TARACHA_ANATOLIA',
 'Piotr Taracha, Religions of Second Millennium Anatolia (Dresdner Beiträge zur Hethitologie 27; Harrassowitz Verlag, Wiesbaden, 2009)',
 'secondary scholarly',
 'Comprehensive study of Anatolian religious traditions from the Bronze Age through the Iron Age transition, covering Hittite, Luwian, Hurrian, and Palaean religious systems alongside their interrelations. The chapter on Luwian religion surveys the major Luwian deities of the Neo-Hittite Iron Age states (c. 1200-700 BCE): Tarhunza (storm deity), Sharruma, Kubaba, Kamrusepa, and others as attested in Luwian hieroglyphic inscriptions from Carchemish, Malatya, Karkamish, Zincirli, and Karatepe. For Kubaba specifically, Taracha discusses her role as the city goddess of Carchemish — the principal Neo-Hittite state and the city where her cult was most prominent — her divine attributes (enthroned with pomegranate and mirror, associated with the lion), her connection with divine sovereignty and queenship, and the transmission of her name into Phrygian as "Kubileya" (thus completing the etymological chain Kubaba → Kubileya → Cybele). Cited for ENT_LUW_KUBABA.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_LUW_NEO_HITTITE',
 'Luwian',
 'Neo-Hittite / Luwian Iron Age',
 -1200, -700,
 'The period of the Neo-Hittite and Luwian Iron Age states of Anatolia and northern Syria following the Bronze Age collapse (c. 1200 BCE). After the destruction of the Hittite Empire (c. 1185 BCE), a series of successor states emerged in southeastern Anatolia and northern Syria — principally Carchemish (on the Euphrates, modern Jarabulus, Turkey/Syria border), Malatya (Melid), Gurgum, Kummuh, Sam''al/Zinjirli, Karatepe, and Hamath — that preserved Luwian language and culture while absorbing Neo-Assyrian and Aramean influences. Their inscriptions are written in Luwian hieroglyphic script, and their religious traditions represent a continuation of Hittite imperial religion adapted to Iron Age conditions. Kubaba of Carchemish is the deity most characteristic of the Luwian Iron Age: she rose to prominence as the leading deity of Carchemish (the most important Neo-Hittite state after the empire''s collapse) and her name was transmitted into Phrygian as "Kubileya" (the epithet component of "Matar Kubileya"), eventually becoming the Greek "Cybele." The period ends with the Assyrian conquest of Carchemish in 717 BCE (Sargon II) and the subsequent absorption of the Neo-Hittite states into the Assyrian provincial system. Taracha (2009) is the comprehensive secondary reference.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Upgrade ENT_ATTIS ──────────────────────────────────────────────────────
-- Reclassify from Greek seed stub to full Phrygian entity
UPDATE entities SET
  tradition      = 'Phrygian',
  entity_type    = 'vegetation deity / dying-and-rising consort',
  category       = 'Nature Deity',
  primary_domains = 'vegetation; death and return; self-castration; pine tree; spring mourning; mystery cult; resurrection',
  short_note     = 'Attis is the Phrygian vegetation deity whose myth of self-castration, death, and resurrection formed the theological core of the Cybele mystery cult as it spread through the Hellenistic world and Rome. His myth survives in several variant versions: in the Pessinuntine version (Pausanias 7.17.9-12; Arnobius, Adversus Nationes 5.5-7), Attis emanates from the almond tree that grew from the blood of the castrated Agdistis, is loved by Agdistis, and in a fit of divine madness self-castrates under a pine tree and dies; Agdistis, in grief, persuades Zeus to grant Attis a form of resurrection — his hair continues to grow and his little finger moves. The pine tree under which he died became sacred to him. Catullus Poem 63 (the most vivid Latin literary treatment) dramatizes the ecstatic self-castration of an Attis-follower who becomes a Gallus (castrated priest of Cybele). The annual Roman festival cycle commemorating Attis (March 15-27) enacted his myth: the Day of the Arriving Reed (Canna Intrat), the Day of the Arriving Tree (Arbor Intrat — a pine tree carried in procession), the Day of Blood (Sanguem, March 24 — the Galli''s ritual self-cutting), and the Day of Joy (Hilaria, March 25 — celebrating the resurrection). The importation of the Cybele-Attis cult to Rome in 204 BCE (the Magna Mater stone from Pessinus) brought Attis to the Roman world; Claudius formalized the full festival cycle. Attis represents the dying-and-rising deity archetype in Phrygian religion, paralleled structurally by Dionysus and Osiris in the Greek and Egyptian traditions. Vermaseren (1977) is the standard monograph; Roller (1999) pp. 139-165.'
WHERE entity_id = 'ENT_ATTIS';

-- ── 4. Add ENT_LUW_KUBABA ────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_LUW_KUBABA',
 'Kubaba',
 'Luwian',
 'city goddess / enthroned queen',
 'High Deity',
 'city sovereignty; divine queenship; nature; lion; pomegranate; fertility',
 'A',
 'Kubaba (also Kuba, Kubaba, Luwian hieroglyphic KUBABA) is the city goddess of Carchemish, the principal Neo-Hittite/Luwian state of the Iron Age (c. 1000-717 BCE, when the city fell to Sargon II of Assyria). She is attested extensively in Luwian hieroglyphic inscriptions from Carchemish and is the most distinctive deity of the Luwian Iron Age tradition. Her standard iconographic program shows her enthroned on a throne flanked by lions (or standing on a lion), holding a pomegranate in one hand and a mirror or bird in the other — attributes of divine sovereignty, fertility, and feminine divine power. Her divine domain encompasses city tutelary protection, queenship and sovereignty, and the natural realm (the pomegranate and bird associations). In the Neo-Hittite political tradition, Kubaba and the storm deity Tarhunza are the two principal deities of Carchemish; she also appears at other Luwian sites (Malatya, Karkamish/Tell Bashar) and in the Luwian hieroglyphic inscriptions of Zincirli (Sam''al). Her most consequential legacy is etymological and theological: the Phrygian epithet "Kubileya" in the divine name "Matar Kubileya" (Mother Kubileya = the Phrygian Mother Goddess) directly borrows the name Kubaba, demonstrating the transmission of the Luwian city goddess tradition into the Phrygian highlands — the etymological foundation of the reception chain that ultimately produces the Greek "Kybele" (Cybele) and the Roman "Magna Mater." The chain Kubaba → Kubileya → Cybele is one of the most etymologically secure deity reception chains in the ancient world. A separate "Kubaba of Kish" appears in the Sumerian King List (c. 2500 BCE) as a female innkeeper who became king, but whether this is the same deity or a coincident name is debated; the Luwian Kubaba''s cult is documented independently. Taracha (2009) pp. 186-198.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 5. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_ATTIS', 'SRC_VERMASEREN_CYBELE_ATTIS', 'Secondary scholarly (primary literary texts analysed)',
 'Vermaseren (1977): complete analysis of the Attis myth variants — Pessinuntine (Pausanias/Arnobius), Lydian (Diodorus), Roman cult development; festival cycle (Canna Intrat, Arbor Intrat, Sanguem, Hilaria); Galli priests; Catullus Poem 63; the Claudian formalization of the Roman cult; dying-and-rising structure.'),
('ENT_ATTIS', 'SRC_ROLLER_CYBELE', 'Secondary scholarly',
 'Roller (1999): Attis in relation to the Phrygian cult of Matar Kubileya; the Pessinuntine connection; the development of the Attis narrative in Hellenistic and Roman reception of the Phrygian tradition. Pp. 139-165.'),
('ENT_LUW_KUBABA', 'SRC_TARACHA_ANATOLIA', 'Primary epigraphic (Luwian hieroglyphic) / secondary scholarly',
 'Taracha (2009) pp. 186-198: Kubaba at Carchemish in Luwian hieroglyphic inscriptions; iconographic program (enthroned, lion, pomegranate, mirror); role as principal city goddess of the leading Neo-Hittite state; distribution across Luwian Iron Age sites; the Kubaba → Kubileya etymological transmission to the Phrygian tradition.')
ON CONFLICT DO NOTHING;

-- ── 6. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_ATTIS',      'PER_PHRYG_IRON_AGE', 'high',
 'Attis is the central figure of Phrygian mystery religion; his cult at Pessinus is attested from the Iron Age Phrygian period through the Roman imperial period. The Pessinuntine myth (the fullest account of the indigenous tradition) places him in the core Iron Age Phrygian religious world.',
 'SRC_ROLLER_CYBELE', 'reviewed'),
('ENT_LUW_KUBABA', 'PER_LUW_NEO_HITTITE', 'high',
 'Kubaba is attested in Luwian hieroglyphic inscriptions from Carchemish and related Neo-Hittite sites throughout the Iron Age period (c. 1000-717 BCE). The Carchemish inscriptions provide the primary documentation.',
 'SRC_TARACHA_ANATOLIA', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 7. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Complete the Kubaba → Matar Kubileya reception chain
('ENT_PHRYG_MATAR', 'reception_of', 'ENT_LUW_KUBABA',
 'high',
 'The Phrygian "Matar Kubileya" (Mother Kubileya) directly incorporates the name Kubaba of Carchemish in her epithet "Kubileya" — the phonological shift Kubaba → Kubileya is a regular Phrygian adaptation of the Luwian theonym. This is one of the most etymologically secure deity receptions in Anatolian religious history. The transmission route is geographic: the Luwian/Neo-Hittite states of SE Anatolia (principally Carchemish) bordered and influenced the Phrygian highlands, and the adoption of Kubaba''s name and enthroned-queen-with-lion iconography into the Phrygian Matar tradition is consistent with the archaeological and linguistic evidence. Combined with the already-existing ENT_CYBELE reception_of ENT_PHRYG_MATAR, this relationship completes the chain: Kubaba → Matar Kubileya → Cybele. Roller (1999) pp. 67-79; Taracha (2009) p. 194.',
 'SRC_ROLLER_CYBELE', 'PER_PHRYG_IRON_AGE', 'reviewed'),
-- Attis paired with Matar
('ENT_ATTIS', 'paired_with', 'ENT_PHRYG_MATAR',
 'high',
 'Attis is the consort and beloved of Matar Kubileya in the Phrygian tradition — their pairing is the theological foundation of the Cybele-Attis mystery cult. In the Pessinuntine myth Attis is the beautiful youth whom Cybele/Matar loves; his self-castration and death is the wound at the cult''s emotional center, and the annual mourning and resurrection rites re-enact the divine pair''s tragedy and renewal. Roller (1999) pp. 139-165; Vermaseren (1977) pp. 90-110.',
 'SRC_VERMASEREN_CYBELE_ATTIS', 'PER_PHRYG_IRON_AGE', 'reviewed'),
-- Attis aligned with Dionysus (dying-and-rising parallel)
('ENT_ATTIS', 'aligned_with', 'ENT_DIONYSUS',
 'medium',
 'Attis and Dionysus are structurally parallel as dying-and-rising vegetation deities whose mystery cults share key elements: ecstatic mourning rites, dismemberment/castration as the divine wound, a resurrection narrative that grounds the initiates'' hope for personal renewal, and a passionate divine attendant group (Galli ~ Maenads). Firmicus Maternus (De Errore Profanarum Religionum 3.1, 4th c. CE) explicitly pairs the two cults in his polemic against mystery religions, reflecting their ancient perceived parallelism. Confidence medium: no ancient text explicitly equates them, but the parallel structure is widely recognized in ancient commentary and modern scholarship. Vermaseren (1977) p. 185.',
 'SRC_VERMASEREN_CYBELE_ATTIS', 'PER_PHRYG_IRON_AGE', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
-- Confirm Attis is now Phrygian
SELECT entity_id, canonical_name, tradition, category FROM entities
WHERE entity_id IN ('ENT_ATTIS','ENT_LUW_KUBABA');

-- Confirm reception chain is complete
SELECT s.canonical_name, s.tradition, r.relationship_type, o.canonical_name, o.tradition
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE r.relationship_type = 'reception_of'
  AND (r.subject_entity_id IN ('ENT_PHRYG_MATAR','ENT_CYBELE')
       OR r.object_entity_id IN ('ENT_LUW_KUBABA','ENT_PHRYG_MATAR'));

SELECT * FROM v_release_metrics;

COMMIT;
