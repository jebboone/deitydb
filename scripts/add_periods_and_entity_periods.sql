-- Item 1: Expand periods table and populate entity_periods
-- Adds 26 new period records spanning all major traditions + reception eras.
-- Bulk-assigns entities to periods by tradition (approximate; refine per entity later).

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- New period records
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES

-- Canaanite/Ugaritic
('PER_CAN_BRONZE_AGE',    'Canaanite/Ugaritic',       'Canaanite Bronze Age',            -1500, -1200,
 'Period of Ugaritic texts (KTU corpus); primary attestation for Baal cycle, El, Asherah, Mot, Yam.'),

-- Mesopotamian
('PER_MES_EARLY',         'Mesopotamian',              'Early Mesopotamian',              -3000, -2350,
 'Early Dynastic Sumer; Sumerian mythological texts, earliest temple literature.'),
('PER_MES_OLD_BAB',       'Mesopotamian',              'Old Babylonian',                  -2000, -1600,
 'Old Babylonian period; Gilgamesh Epic, Atrahasis, early Enuma Elish traditions.'),
('PER_MES_NEO_ASS',       'Mesopotamian',              'Neo-Assyrian and Neo-Babylonian',  -900,  -539,
 'Neo-Assyrian and Neo-Babylonian periods; canonical cuneiform library (Ashurbanipal); most extant Akkadian texts.'),

-- Israelite
('PER_ISR_IRON_AGE',      'Israelite',                 'Iron Age Israelite',              -1200,  -586,
 'Iron Age Israel and Judah; pre-exilic biblical material, early Yahwism, Canaanite religious milieu.'),
('PER_ISR_EXILIC',        'Israelite',                 'Exilic and Post-Exilic',           -586,  -400,
 'Babylonian exile and return; Deutero-Isaiah, Ezekiel; formative period for angelology and theodicy.'),
('PER_ISR_SECOND_TEMPLE', 'Israelite/Second Temple',   'Second Temple Period',             -400,    70,
 'Second Temple Judaism; Dead Sea Scrolls, 1 Enoch, Daniel; developed angelology and demonology.'),

-- Zoroastrian
('PER_ZOR_ACHAEMENID',    'Zoroastrian',               'Achaemenid Zoroastrian',           -550,  -330,
 'Achaemenid Persian period; Gathas as oldest Zoroastrian texts; major influence on Second Temple Judaism.'),
('PER_ZOR_SASANIAN',      'Zoroastrian',               'Sasanian Zoroastrian',              224,   651,
 'Sasanian Empire; Avesta codified, Bundahishn compiled; Zoroastrianism as state religion.'),

-- Roman
('PER_ROM_REPUBLIC',      'Roman',                     'Roman Republic',                   -509,   -27,
 'Roman Republic; early Roman religion, interpretatio graeca, Roman-Greek religious exchange.'),
('PER_ROM_IMPERIAL',      'Roman',                     'Roman Imperial',                    -27,   476,
 'Roman Imperial period; Roman mystery cults, Mithraism, Roman-Egyptian synthesis, late antique religion.'),

-- Hermetic / Greco-Egyptian
('PER_HER_HELLENISTIC',   'Hermetic/Greco-Egyptian',   'Hermetic Hellenistic Period',      -200,   400,
 'Hellenistic and early Imperial Egypt; composition of Corpus Hermeticum, Greek Magical Papyri; Hermes Trismegistus synthesis.'),

-- Gnostic / Late Antique
('PER_GNO_2ND_4TH',       'Gnostic/Late Antique',      'Gnostic and Neoplatonic (2nd–4th c.)', 100, 400,
 'Flourishing of Gnostic schools (Sethian, Valentinian, Ophite), Neoplatonism, Iamblichean theurgy; Nag Hammadi texts.'),

-- Manichaean
('PER_MAN_3RD_7TH',       'Manichaean',                'Manichaean Flourishing',            240,   700,
 'From Mani''s revelation (240 CE) through early medieval expansion; Manichaean Kephalaia, Psalm Book.'),

-- Norse / Germanic
('PER_NOR_VIKING',        'Germanic/Norse',             'Norse Viking Age',                  750,  1100,
 'Viking Age Scandinavia; primary composition/transmission of Eddic and skaldic material; Prose Edda compiled c. 1220.'),

-- Celtic
('PER_CEL_IRON_AGE',      'Celtic',                    'Celtic Iron Age',                  -800,   -50,
 'Iron Age Celtic cultures; Gaulish religion, Continental and Insular Celtic religious forms.'),
('PER_CEL_MEDIEVAL_IRISH','Celtic/Irish',               'Medieval Irish',                    400,  1200,
 'Medieval Irish literary tradition; Lebor Gabála Érenn, mythological cycle; Christian-influenced mythography.'),

-- Islamic
('PER_ISL_EARLY',         'Islamic',                   'Early Islam',                       610,   750,
 'Quranic revelation (610–632 CE) and early Hadith transmission; formative Islamic theology and angelology.'),
('PER_ISL_CLASSICAL',     'Islamic',                   'Classical Islam',                   750,  1258,
 'Abbasid Golden Age; systematization of Islamic theology, tafsir, Sufi traditions, Shi''a cosmology.'),

-- Jewish Mystical
('PER_JM_MEDIEVAL',       'Jewish Mystical',            'Jewish Mystical Medieval',          700,  1400,
 'Hekhalot and Merkabah literature codified; early Kabbalah; culminating in Zohar (c. 1280–1300 CE).'),

-- Christian (patristic and medieval)
('PER_PATRISTIC',         'Christian',                 'Patristic Period',                  100,   450,
 'Early Church Fathers; demonization of pagan deities, systematization of angelology and Christology.'),
('PER_MEDIEVAL_WEST',     'Christian',                 'Medieval Western',                  450,  1400,
 'Medieval Western Christianity; Pseudo-Dionysius angelology, scholastic demonology, hagiography, Crusades.'),

-- Cross-traditional reception eras (the key transmission layers)
('PER_LATE_ANTIQUE',      'Cross-traditional',         'Late Antiquity',                    200,   600,
 'Late antique synthesis era; Greek, Roman, Jewish, Christian, Gnostic, and Hermetic traditions in dialogue. Primary period of demonization and syncretism.'),
('PER_RENAISSANCE',       'Cross-traditional',         'Renaissance',                      1400,  1600,
 'Renaissance Hermeticism; Ficino''s Hermetic translations (1463), Pico della Mirandola, Agrippa; recovery of Neoplatonic and Hermetic texts.'),
('PER_EARLY_MODERN',      'Cross-traditional',         'Early Modern',                     1600,  1800,
 'Early Modern occultism; grimoire tradition, Rosicrucianism, Freemasonry, systematic Kabbalah reception in European esotericism.'),
('PER_19C_OCCULT',        'Cross-traditional',         '19th Century Occultism',           1800,  1900,
 'Éliphas Lévi, Theosophy (Blavatsky), Hermetic Order of the Golden Dawn; synthesis of Kabbalah, Hermeticism, and comparative religion.')

ON CONFLICT (period_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Bulk entity_periods assignments by tradition
-- confidence = 'medium' throughout; these are approximate tradition-period
-- anchors. Per-entity refinement should happen as sources are reviewed.
-- ─────────────────────────────────────────────────────────────────────────────

-- Canaanite/Ugaritic
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_CAN_BRONZE_AGE', 'medium',
       'Canaanite/Ugaritic entities primarily attested in Bronze Age Ugaritic texts (KTU corpus).'
FROM entities WHERE tradition IN ('Canaanite/Ugaritic')
ON CONFLICT DO NOTHING;

-- Mesopotamian (Neo-Assyrian/Babylonian is where most extant cuneiform sources derive)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_MES_NEO_ASS', 'medium',
       'Mesopotamian entities primarily attested in Neo-Assyrian/Babylonian canonical cuneiform library.'
FROM entities WHERE tradition IN ('Mesopotamian')
ON CONFLICT DO NOTHING;

-- Israelite / Second Temple
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_ISR_SECOND_TEMPLE', 'medium',
       'Attested primarily in Second Temple period texts (Hebrew Bible, Pseudepigrapha, Dead Sea Scrolls).'
FROM entities WHERE tradition IN ('Israelite/Second Temple')
ON CONFLICT DO NOTHING;

-- Zoroastrian
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_ZOR_SASANIAN', 'medium',
       'Most Zoroastrian texts codified in Sasanian period; Avesta compiled c. 3rd–7th c. CE.'
FROM entities WHERE tradition IN ('Zoroastrian')
ON CONFLICT DO NOTHING;

-- Roman
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_ROM_IMPERIAL', 'medium',
       'Roman entities primarily attested in Imperial period sources (Ovid, Apuleius, etc.).'
FROM entities WHERE tradition IN ('Roman','Roman/Persian reception')
ON CONFLICT DO NOTHING;

-- Hermetic
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_HER_HELLENISTIC', 'medium',
       'Hermetic entities attested in Corpus Hermeticum and related Hellenistic-Imperial texts.'
FROM entities WHERE tradition IN ('Hermetic/Theurgic','Hermetic/Greco-Egyptian')
ON CONFLICT DO NOTHING;

-- Gnostic cluster (Sethian, Valentinian, Ophite, etc.)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_GNO_2ND_4TH', 'medium',
       'Gnostic entities attested in 2nd–4th c. CE texts (Nag Hammadi Library, heresiological sources).'
FROM entities WHERE tradition IN (
    'Gnostic','Gnostic/Platonic','Sethian','Valentinian',
    'Ophite/Archontic','Sethian/Ophite','Sethian/Ophite/Jewish',
    'Ophite/Sethian','Thomasine/Christian-Gnostic','Christian/Gnostic'
)
ON CONFLICT DO NOTHING;

-- Manichaean
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_MAN_3RD_7TH', 'medium',
       'Manichaean entities attested in Kephalaia, Psalm Book, and other Manichaean primary texts (3rd–7th c. CE).'
FROM entities WHERE tradition IN ('Manichaean')
ON CONFLICT DO NOTHING;

-- Mandaean (contemporary with Manichaean; Ginza Rba compiled ~3rd–7th c. CE)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_LATE_ANTIQUE', 'medium',
       'Mandaean entities attested in Ginza Rba and Mandaean Book of John, compiled in Late Antique period.'
FROM entities WHERE tradition IN ('Mandaean')
ON CONFLICT DO NOTHING;

-- Norse / Germanic
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_NOR_VIKING', 'medium',
       'Norse entities attested in Eddic poetry and Prose Edda (Viking Age; written down c. 1200–1225 CE).'
FROM entities WHERE tradition IN ('Germanic/Norse')
ON CONFLICT DO NOTHING;

-- Celtic / Irish
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_CEL_MEDIEVAL_IRISH', 'medium',
       'Irish mythological figures attested in medieval Irish texts (Lebor Gabála Érenn, mythological cycle).'
FROM entities WHERE tradition IN ('Celtic/Irish')
ON CONFLICT DO NOTHING;

-- Celtic / Gaulish
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_CEL_IRON_AGE', 'medium',
       'Gaulish entities attested through Iron Age inscriptions, Roman-era accounts, and iconographic evidence.'
FROM entities WHERE tradition IN ('Celtic/Gaulish','Celtic/Gaulish/Roman')
ON CONFLICT DO NOTHING;

-- Islamic
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_ISL_EARLY', 'medium',
       'Islamic entities attested in Qur''an and early Hadith (Early Islamic period, 7th–8th c. CE).'
FROM entities WHERE tradition IN ('Islamic','Islamic/Shi''a','Islamic/Sufi','Islamic/Sufi/Shi''a','Shi''a Islam/Islamic')
ON CONFLICT DO NOTHING;

-- Jewish Mystical
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_JM_MEDIEVAL', 'medium',
       'Jewish mystical entities attested in Hekhalot literature and Kabbalistic texts (7th–14th c. CE).'
FROM entities WHERE tradition IN ('Jewish Mystical','Jewish')
ON CONFLICT DO NOTHING;

-- Christian (Patristic-era entities: Biblical, early church)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_PATRISTIC', 'medium',
       'Christian entities attested in patristic literature and early Christian texts (1st–5th c. CE).'
FROM entities WHERE tradition IN ('Christian','Christian/Biblical')
ON CONFLICT DO NOTHING;

-- Christian reception (medieval)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_MEDIEVAL_WEST', 'medium',
       'Christian reception entities primarily attested in medieval Western literature and demonology.'
FROM entities WHERE tradition IN ('Christian reception')
ON CONFLICT DO NOTHING;

-- Late Antique Ritual (theurgy, GMP, Iamblichean traditions)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_LATE_ANTIQUE', 'medium',
       'Late Antique Ritual entities attested in theurgic texts, Greek Magical Papyri, and Iamblichus (2nd–6th c. CE).'
FROM entities WHERE tradition IN ('Late Antique Ritual')
ON CONFLICT DO NOTHING;

-- Greco-Egyptian syncretic
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
SELECT entity_id, 'PER_HER_HELLENISTIC', 'medium',
       'Greco-Egyptian syncretic entities attested in Ptolemaic and Roman Egyptian religious contexts.'
FROM entities WHERE tradition IN ('Greco-Egyptian','Greco-Egyptian/Libyan','Greek/Roman/Egyptian')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Verify
-- ─────────────────────────────────────────────────────────────────────────────

SELECT
    (SELECT COUNT(*) FROM periods) AS total_periods,
    (SELECT COUNT(*) FROM entity_periods) AS entity_period_assignments,
    (SELECT COUNT(DISTINCT entity_id) FROM entity_periods) AS entities_with_period,
    (SELECT COUNT(*) FROM entities WHERE NOT EXISTS (
        SELECT 1 FROM entity_periods ep WHERE ep.entity_id = entities.entity_id
    )) AS entities_still_unperioded;

COMMIT;
