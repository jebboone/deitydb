-- scripts/add_pre_islamic_arabian_layer.sql
-- Pre-Islamic Arabian tradition: the immediate substrate of Islamic monotheism
--
-- The Quran (53:19-20) names three goddesses by name — Al-Lat, Al-Uzza, and Manat —
-- as the specific deities Islam was directly displacing in the Hijaz. These are not
-- peripheral figures: they were central to the religious life of Mecca and the
-- surrounding region (the "Daughters of Allah" in pre-Islamic Arabian religion).
-- Without this layer, the Islamic reception layer (add_islamic_reception.sql)
-- sits on an invisible substrate.
--
-- The Nabataean kingdom (Petra, 4th c. BCE - 106 CE) preserved and transmitted
-- many of these Arabian deities into the Hellenistic and Roman worlds, making
-- them relevant for the Greek→Roman→Arabian direction as well.
--
-- Entities:
--   Al-Lat: central north Arabian goddess; Quran 53:19; Herodotus 3.8 "Alilat"
--   Al-Uzza: Venus goddess; Quran 53:19; Nabataean inscriptions
--   Manat: goddess of fate/death; Quran 53:20; attested at al-Mushallal
--   Hubal: lunar/chief deity of the Kaaba; Mecca; pre-Islamic supremacy
--   Dushara: "Lord of the Mountain"; chief Nabataean deity; identified with Dionysus
--
-- New period: PER_ARA_PRE_ISLAMIC (-600 to 622 CE)
-- New sources: SRC_HEALEY_NABATAEAN_RELIGION
-- (SRC_HERODOTUS_HISTORIES and SRC_QURAN already in DB from previous scripts)

BEGIN;

-- ── 1. New period ────────────────────────────────────────────────────────────

INSERT INTO periods (period_id, period_name, tradition, start_year, end_year)
VALUES ('PER_ARA_PRE_ISLAMIC', 'Pre-Islamic Arabia (Jahiliyyah)', 'Pre-Islamic Arabian', -600, 622)
ON CONFLICT (period_id) DO NOTHING;

-- ── 2. New source ────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_HEALEY_NABATAEAN_RELIGION',
   'John F. Healey, The Religion of the Nabataeans: A Conspectus (Leiden: Brill, 2001)',
   NULL,
   'secondary scholarly',
   'Comprehensive scholarly treatment of Nabataean religion, including Dushara, Al-Lat, Al-Uzza, and Manat; documents the Nabataean inscriptional evidence, Greek identifications (Dushara=Dionysus), and the role of the Nabataean kingdom in transmitting pre-Islamic Arabian religion into the Hellenistic and Roman worlds; essential source for the Pre-Islamic Arabian→Greek/Roman reception chains')
ON CONFLICT (source_id) DO NOTHING;

-- ── 3. New Pre-Islamic Arabian entities ────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_ARA_ALLAT',
   'Al-Lat',
   'Pre-Islamic Arabian',
   'Goddess',
   'A',
   'Major north Arabian and Nabataean goddess; one of the three "Daughters of Allah" named in Quran 53:19; worshipped from the Sinai to Palmyra and throughout north Arabia; Herodotus 3.8 (c. 450 BCE) calls her "Alilat" and identifies her with Aphrodite Urania; her great sanctuary was at Ta''if; associated with the sun and fertility; depicted with a lion at Palmyra and Petra; an early and widespread figure in the Arabian religious landscape'),

  ('ENT_ARA_AL_UZZA',
   'Al-Uzza',
   'Pre-Islamic Arabian',
   'Goddess',
   'A',
   'North Arabian and Nabataean goddess; one of the three "Daughters of Allah" named in Quran 53:19-20; "the most mighty" or "the strong one"; associated with the planet Venus (morning star) and with Aphrodite in Greek contexts; her principal sanctuary was at Nakhla between Mecca and Ta''if; also worshipped at Petra; closely related to the Canaanite/Phoenician Astarte and Mesopotamian Ishtar Venus-goddess tradition; she was the most important of the three "Daughters" in the Hijaz'),

  ('ENT_ARA_MANAT',
   'Manat',
   'Pre-Islamic Arabian',
   'Goddess of fate',
   'A',
   'North Arabian goddess of fate and death; one of the three "Daughters of Allah" named in Quran 53:20; "the one who apportions"; her sanctuary was at al-Mushallal near Qudayd on the Red Sea coast; associated with the moon and with the inevitable destiny of death; identified with Nemesis or Tyche in Greek contexts; particularly venerated by the tribes of Aws and Khazraj (the Medinan tribes); the oldest of the three "Daughters" in some traditions'),

  ('ENT_ARA_HUBAL',
   'Hubal',
   'Pre-Islamic Arabian',
   'Chief deity / Moon god',
   'A',
   'Chief deity of the Kaaba sanctuary at Mecca before Islam; his idol (a human figure in red carnelian or gold, with a golden right hand) stood inside the Kaaba; divination by arrows was performed before him; described in Ibn al-Kalbi''s Kitab al-Asnam (Book of Idols) as the supreme deity of the Quraysh tribe and of Mecca; associated by some scholars with the moon deity tradition transmitted from Mesopotamian Nanna/Sin via Levantine cultures; the deity Muhammad''s grandfather Abd al-Muttalib pledged his son in a vow before'),

  ('ENT_ARA_DUSHARA',
   'Dushara',
   'Pre-Islamic Arabian',
   'Chief deity of the Nabataeans',
   'A',
   'Chief deity of the Nabataean kingdom (Petra; 4th c. BCE - 106 CE); "Lord of the Mountain" (Dhu al-Shara = "he of the Shara mountains"); his aniconic form was a black stone (baetyl); identified with Dionysus by Greek and Roman authors, and with Zeus by others; his cult was carried throughout the Nabataean diaspora to the Hauran, Egypt, and Rome; Healey (2001) documents him as the paradigm Nabataean deity whose Dionysus identification shaped Greek understanding of Arabian religion')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Source links ──────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ARA_ALLAT',   'SRC_QURAN',                    'primary_attestation',
   'Quran 53:19: "Have you then considered Al-Lat and Al-Uzza?" — direct Quranic naming'),
  ('ENT_ARA_ALLAT',   'SRC_HERODOTUS_HISTORIES',      'primary_attestation',
   'Herodotus 3.8: "Alilat" named as the Arabic name for Aphrodite Urania'),
  ('ENT_ARA_ALLAT',   'SRC_HEALEY_NABATAEAN_RELIGION','secondary_reference',
   'Healey (2001) documents Al-Lat''s Nabataean inscriptional evidence and Greek identifications'),
  ('ENT_ARA_AL_UZZA', 'SRC_QURAN',                    'primary_attestation',
   'Quran 53:19-20: Al-Uzza named alongside Al-Lat and Manat as the "Daughters of Allah"'),
  ('ENT_ARA_AL_UZZA', 'SRC_HEALEY_NABATAEAN_RELIGION','secondary_reference',
   'Healey (2001) on Al-Uzza''s Nabataean cult and Venus/Aphrodite identification'),
  ('ENT_ARA_MANAT',   'SRC_QURAN',                    'primary_attestation',
   'Quran 53:20: "And Manat, the third, the other?" — direct Quranic naming'),
  ('ENT_ARA_MANAT',   'SRC_HEALEY_NABATAEAN_RELIGION','secondary_reference',
   'Healey (2001) on Manat''s sanctuary at al-Mushallal and fate/death goddess function'),
  ('ENT_ARA_HUBAL',   'SRC_ELIADE_ER',                'secondary_reference',
   'Encyclopedia of Religion entries on pre-Islamic Arabian religion and Hubal''s role at Mecca'),
  ('ENT_ARA_DUSHARA', 'SRC_HEALEY_NABATAEAN_RELIGION','primary_attestation',
   'Healey (2001) — Dushara is the central subject of the monograph; extensive inscriptional evidence')
ON CONFLICT DO NOTHING;

-- ── 5. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ARA_ALLAT',   'PER_ARA_PRE_ISLAMIC', 'high',
   'Al-Lat attested from c. 5th c. BCE (Herodotus 3.8) through the Islamic conquest (622 CE)',
   'SRC_HERODOTUS_HISTORIES', 'reviewed'),
  ('ENT_ARA_AL_UZZA', 'PER_ARA_PRE_ISLAMIC', 'high',
   'Al-Uzza''s Nabataean inscriptions date from the 1st c. BCE; worship continued to the Islamic conquest',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed'),
  ('ENT_ARA_MANAT',   'PER_ARA_PRE_ISLAMIC', 'high',
   'Manat attested in pre-Islamic Arabian tradition through the Quranic condemnation (622 CE)',
   'SRC_QURAN', 'reviewed'),
  ('ENT_ARA_HUBAL',   'PER_ARA_PRE_ISLAMIC', 'high',
   'Hubal as the chief Meccan deity in the period immediately before Islam; Ibn al-Kalbi is the primary source',
   'SRC_ELIADE_ER', 'reviewed'),
  ('ENT_ARA_DUSHARA', 'PER_ARA_PRE_ISLAMIC', 'high',
   'Dushara attested from the Nabataean kingdom (4th c. BCE) through the Roman period (106 CE)',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed'),
  ('ENT_ARA_DUSHARA', 'PER_GRK_HELLENISTIC', 'medium',
   'Dushara-Dionysus identification documented in the Hellenistic period via Nabataean-Greek contact',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ──────────────────────────────────────────────────────

-- 6a. Semitic love/Venus tradition → Al-Uzza
-- Al-Uzza is the most recent link in the long chain: Inanna→Ishtar→Astarte→Al-Uzza
-- The Venus/morning star / love and war goddess tradition that runs from Mesopotamia
-- through Canaan reaches the Arabian peninsula as Al-Uzza.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_CAN_ASTARTE', 'received_as', 'ENT_ARA_AL_UZZA',
   'medium',
   'Al-Uzza is the north Arabian continuation of the Semitic love/Venus goddess tradition that runs from Mesopotamian Inanna/Ishtar through Canaanite Astarte. The common elements are: (1) association with the planet Venus as the morning/evening star; (2) love and war function (Al-Uzza is invoked for protection in battle as well as for love); (3) association with sacred trees (Al-Uzza''s sanctuary at Nakhla included sacred trees). The Nabataean Al-Uzza is sometimes depicted with the Aphrodite iconography that derives from Astarte. The transmission is most plausible through Phoenician-Arabian contact and the common Semitic religious substrate. Confidence medium: functional and iconographic parallels are strong; direct textual documentation of the Astarte→Al-Uzza transmission is limited.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_ARA_PRE_ISLAMIC'),
  ('ENT_ARA_AL_UZZA', 'reception_of', 'ENT_CAN_ASTARTE',
   'medium',
   'Al-Uzza as the north Arabian reception of the Semitic love/Venus goddess tradition flowing from Canaanite Astarte; Venus identification and war/love duality are the shared functional core.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_ARA_PRE_ISLAMIC')
ON CONFLICT DO NOTHING;

-- 6b. Al-Lat → Athena: Herodotus 3.8 makes this explicit
-- Herodotus identifies the goddess the Arabs call "Alilat" with Aphrodite Urania,
-- but the Nabataean Al-Lat is more consistently identified with Athena in later
-- Greek and Roman sources, and at Palmyra she is explicitly depicted as Athena.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ARA_ALLAT', 'received_as', 'ENT_ATHENA',
   'medium',
   'Al-Lat''s identification with Athena is documented in multiple sources. At Palmyra, Al-Lat is explicitly depicted in full Athena iconography (helmet, aegis, spear) and inscriptions call her "Allat who is Athena." At Petra, she is identified with Athena in bilingual Greek-Nabataean inscriptions. The warrior/wisdom function of Al-Lat (she was invoked for protection in battle and at sacred sites) aligns with Athena''s attributes more closely than with Aphrodite. Note: Herodotus 3.8 equates "Alilat" with Aphrodite Urania, but later Nabataean and Palmyrene evidence consistently equates her with Athena — the two identifications probably reflect different aspects of Al-Lat''s character emphasized in different regional contexts. Confidence medium: the Athena identification is well-documented for the Hellenistic-Roman period; earlier periods less clear.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_ATHENA', 'reception_of', 'ENT_ARA_ALLAT',
   'medium',
   'Athena as the Greek identification for the north Arabian Al-Lat; Palmyrene inscriptions explicitly equate the two; warrior-wisdom function is the primary basis.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- 6c. Al-Uzza → Aphrodite: the identification documented by Herodotus
-- Herodotus 3.8 equates "Alilat" (typically identified as Al-Lat) with Aphrodite;
-- but the Venus/morning star goddess Al-Uzza is the more consistent Aphrodite parallel.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ARA_AL_UZZA', 'received_as', 'ENT_APHRODITE',
   'medium',
   'Al-Uzza''s identification with Aphrodite (and Venus in Roman contexts) is grounded in the shared Venus/morning star association. Al-Uzza''s name ("the most mighty/strong one") corresponds to an aspect of the Semitic Venus goddess; her Nabataean cult included incense and devotion typical of the Aphrodite complex. In Nabataean bilingual inscriptions she sometimes appears alongside the Aphrodite identification. The Venus planet (Al-Uzza) → Aphrodite link is part of the long Semitic love goddess chain (Ishtar→Astarte→Al-Uzza) that feeds into the Aphrodite complex from multiple directions.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_APHRODITE', 'reception_of', 'ENT_ARA_AL_UZZA',
   'medium',
   'Aphrodite as the Greek identification for Al-Uzza via the Venus/morning star tradition; one of several Arabian→Greek connections through Nabataean-Hellenistic contact.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- 6d. Manat → Nemesis: goddess of fate/death
-- Manat presides over fate, apportioned destiny, and death. Nemesis is the Greek
-- goddess of retribution, apportionment, and inevitable fate/death.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ARA_MANAT', 'received_as', 'ENT_NEMESIS',
   'low',
   'Manat (from Arabic mana, "to apportion" or "fate") presides over the apportionment of destiny and death; she is associated with the moon and with the inevitable fate that awaits all human beings. Nemesis (Greek goddess of retribution and the apportionment of fortune/fate) shares the function of inevitable, apportioned fate. The Nabataean Manat was identified with Greek fate/retribution deities in the Hellenistic period; at Madain Salih (Hegra) inscriptions attest her alongside Dushara. Confidence low: the functional parallel is reasonable but no explicit ancient identification of Manat with Nemesis (as opposed to Tyche or another fate deity) is documented in surviving texts.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_NEMESIS', 'reception_of', 'ENT_ARA_MANAT',
   'low',
   'Nemesis as a possible Greek identification for the Arabian fate-goddess Manat; both preside over inevitable destiny and death.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- 6e. Dushara → Dionysus: the wine deity and "lord of the mountain" identification
-- Greek authors explicitly equate Dushara with Dionysus; both are associated with
-- wine, the vine, and ecstatic vegetation cult. The Nabataeans were also associated
-- with viticulture in Hellenistic sources.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ARA_DUSHARA', 'received_as', 'ENT_DIONYSUS',
   'medium',
   'Greek and Roman authors explicitly identify the Nabataean chief deity Dushara with Dionysus. Epiphanius of Salamis (c. 375 CE, Panarion 51.22) describes a Nabataean rite in which Dushara''s birth is celebrated on January 6th (a date shared with Dionysus''s epiphany feast), and explicitly calls him the Arabic Dionysus. The Nabataean association with wine and the vine (the Negev Nabataeans cultivated vines in an arid environment through elaborate water-harvesting) supports the Dionysus identification. Dushara''s aniconic form (a black stone baetyl) and mountain associations parallel Dionysus''s pre-anthropomorphic cult forms and his mountain associations (Cithaeron, Nysa). Healey (2001) treats the Dushara-Dionysus identification as the best-documented Nabataean→Greek deity transmission.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_DIONYSUS', 'reception_of', 'ENT_ARA_DUSHARA',
   'medium',
   'Dionysus as the Greek identification for the Nabataean Dushara; Epiphanius (Panarion 51.22) makes the identification explicit; wine-vine association and mountain cult are the functional basis.',
   'SRC_HEALEY_NABATAEAN_RELIGION', 'reviewed', 'PER_GRK_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- 6f. Mesopotamian moon deity → Hubal: lunar/chief deity transmission to Arabia
-- Hubal shows lunar deity characteristics (crescent associations, divination function)
-- that parallel the Mesopotamian Nanna/Sin tradition transmitted through the Levant.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_NANNA_SIN', 'received_as', 'ENT_ARA_HUBAL',
   'low',
   'Hubal''s origins and nature are disputed in modern scholarship; some scholars (including Jawad Ali, al-Mufassal) argue for a Mesopotamian or Syrian origin for the deity, noting that his cult statue''s right hand was made of gold (replacing a damaged arm), reminiscent of Mesopotamian cult statue practices. The lunar/divination associations of Hubal (crescent imagery, arrow divination paralleling divine consultation) echo the Mesopotamian Nanna/Sin tradition, which was widespread in the Levant and Arabia through Harran (the major Nanna/Sin cult center in northern Syria). Confidence low: the proposed Mesopotamian origin of Hubal is one scholarly hypothesis, not a consensus; alternative interpretations see him as a native Hijazi deity. The transmission pathway (Harran→Levant→Hijaz) is plausible but not textually documented.',
   'SRC_ELIADE_ER', 'reviewed', 'PER_ARA_PRE_ISLAMIC'),
  ('ENT_ARA_HUBAL', 'reception_of', 'ENT_MES_NANNA_SIN',
   'low',
   'Hubal as a possible Arabian reception of the Mesopotamian lunar deity tradition transmitted through the Levant (Harran); lunar/divination associations are the functional parallel. Scholarly consensus is contested.',
   'SRC_ELIADE_ER', 'reviewed', 'PER_ARA_PRE_ISLAMIC')
ON CONFLICT DO NOTHING;

-- ── 7. Verification ──────────────────────────────────────────────────────────

SELECT 'arabian_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'Pre-Islamic Arabian';

SELECT 'arabian_chains' AS metric, COUNT(*) AS count
FROM entity_relationships
WHERE subject_entity_id LIKE 'ENT_ARA_%'
   OR object_entity_id LIKE 'ENT_ARA_%';

SELECT * FROM v_release_metrics;

COMMIT;
