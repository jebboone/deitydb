-- scripts/source_scattered_singles.sql
-- Sourcing rigor VI (v1.41.0): the scattered ref-only singles outside the big Greek and
-- Cross-traditional sets — small Christian sub-traditions, the Shi'a Imams, Greek hybrid
-- sub-traditions, and a few others. Additive primary attestation, each source-matched.

BEGIN;

-- New public-domain primary texts not yet registered
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_VITA_ELIGII','Audoin (Dado) of Rouen, Vita Eligii (Life of St Eligius), 7th c. CE','','primary text','Merovingian hagiography of the goldsmith-bishop Eligius'),
('SRC_VITA_DUNSTANI','Vita S. Dunstani by the author "B.", c. 1000 CE','','primary text','The earliest life of St Dunstan of Canterbury'),
('SRC_ACTA_ROCHI','Francesco Diedo, Vita Sancti Rochi (Acta of St Roch), 1478 CE','','primary text','Hagiography of the plague-saint Roch of Montpellier'),
('SRC_NAHJ_AL_BALAGHA','Nahj al-Balagha (Peak of Eloquence): sermons, letters and sayings of Ali ibn Abi Talib, comp. al-Sharif al-Radi, c. 1009 CE','','primary text','The foundational collection of the words of the first Shi''a Imam'),
('SRC_TABARI_HISTORY','al-Tabari, Tarikh al-Rusul wa''l-Muluk (History of the Prophets and Kings), c. 915 CE','','primary text','The major early Islamic chronicle; the caliphate of Ali and the martyrdom of Husayn at Karbala'),
('SRC_KULAYNI_KAFI','al-Kulayni, al-Kafi (Kitab al-Hujja), c. 940 CE','','primary text','The foundational Twelver Shi''a hadith collection; the Imamate, the Mahdi, and the Occultation')
ON CONFLICT (source_id) DO NOTHING;

-- helper: attach (entity by name within a tradition) → source with note
-- ── Christian/Biblical demonological & apocalyptic figures ───────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, src, 'Direct attestation', note FROM (VALUES
 ('Abaddon','SRC_NEW_TESTAMENT','Revelation 9:11 (Abaddon/Apollyon, the angel of the abyss).'),
 ('Apollyon','SRC_NEW_TESTAMENT','Revelation 9:11 (Apollyon, the Greek name of the destroyer).'),
 ('Behemoth','SRC_HEBREW_BIBLE','Job 40:15-24.'),
 ('Dragon of Revelation','SRC_NEW_TESTAMENT','Revelation 12-13; 20:2 (the great red dragon, identified with the Devil).'),
 ('Leviathan','SRC_HEBREW_BIBLE','Job 41; Isaiah 27:1.')
) AS t(name, src, note)
JOIN entities e ON e.tradition='Christian/Biblical' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;

-- ── Christian reception ──────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_AUGUSTINE_CITY_OF_GOD', 'Direct attestation', 'Augustine, City of God VII-X (the pagan gods reinterpreted as demons).'
FROM entities e WHERE e.tradition='Christian reception' AND e.canonical_name='Hecate (Patristic Reception)'
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, src, 'Direct attestation', note FROM (VALUES
 ('SRC_HEBREW_BIBLE','Isaiah 14:12 (Helel ben Shachar, rendered "Lucifer" in the Vulgate).'),
 ('SRC_NEW_TESTAMENT','Luke 10:18 ("I saw Satan fall like lightning"); Revelation 12 (the fall of the dragon).')
) AS t(src, note)
JOIN entities e ON e.tradition='Christian reception' AND e.canonical_name='Lucifer'
ON CONFLICT DO NOTHING;

-- ── Christian regional saints → their Vitae (completes Christian to 100%) ─────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, t.src, 'Direct attestation', t.note FROM (VALUES
 ('Eligius','SRC_VITA_ELIGII','Audoin of Rouen, Vita Eligii (7th c.).'),
 ('Dunstan','SRC_VITA_DUNSTANI','Vita S. Dunstani by "B." (c. 1000).'),
 ('Roch','SRC_ACTA_ROCHI','Diedo, Vita Sancti Rochi (1478).')
) AS t(name, src, note)
JOIN entities e ON e.tradition='Christian' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;

-- ── Shi'a Imams and concepts ─────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, t.src, 'Direct attestation', t.note FROM (VALUES
 ('Ali ibn Abi Talib','SRC_NAHJ_AL_BALAGHA','Nahj al-Balagha (his sermons, letters and sayings).'),
 ('Ali ibn Abi Talib','SRC_TABARI_HISTORY','al-Tabari, History (the caliphate of Ali).'),
 ('Ali ibn Abi Talib','SRC_QURAN','Quran 5:55 (the wilaya verse, in the Shi''a reading).'),
 ('Husayn ibn Ali','SRC_TABARI_HISTORY','al-Tabari, History (the martyrdom at Karbala, 61 AH/680 CE).'),
 ('Husayn ibn Ali','SRC_QURAN','Quran 33:33 (the verse of purification, on the Ahl al-Bayt).'),
 ('Muhammad al-Mahdi','SRC_KULAYNI_KAFI','al-Kulayni, al-Kafi (Kitab al-Hujja, the birth and occultation of the Twelfth Imam).'),
 ('Occultation','SRC_KULAYNI_KAFI','al-Kulayni, al-Kafi (the Greater and Lesser Occultation traditions).')
) AS t(name, src, note)
JOIN entities e ON e.tradition='Islamic/Shi''a' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_QURAN', 'Direct attestation', 'Quran 5:55 (the wilaya verse, foundation of the doctrine of walaya).'
FROM entities e WHERE e.tradition='Islamic/Sufi/Shi''a' AND e.canonical_name='Walaya'
ON CONFLICT DO NOTHING;

-- ── Jewish, Pre-Islamic Arabian ──────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_HEBREW_BIBLE', 'Direct attestation', 'The Torah: the Pentateuch (Genesis-Deuteronomy).'
FROM entities e WHERE e.tradition='Jewish' AND e.canonical_name='Torah'
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_HOYLAND_ARABIA', 'Secondary analysis', 'Hoyland, Arabia and the Arabs (Hubal, the chief idol of the Meccan Kaaba).'
FROM entities e WHERE e.tradition='Pre-Islamic Arabian' AND e.canonical_name='Hubal'
ON CONFLICT DO NOTHING;

-- ── Greek hybrid sub-traditions → Greek primary texts ────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, t.src, 'Direct attestation', t.note FROM (VALUES
 ('Adrasteia','SRC_APOLLODORUS_LIBRARY','Apollodorus, Library 1.1.6-7 (Adrasteia nurses the infant Zeus).'),
 ('Protogonos','SRC_ORPHIC_HYMNS','Orphic Hymn 6 (To Protogonos/Phanes, the firstborn).'),
 ('Marsyas','SRC_APOLLODORUS_LIBRARY','Apollodorus, Library 1.4.2 (Marsyas and his contest with Apollo).'),
 ('Dactyls','SRC_PAUSANIAS_DESCRIPTION','Pausanias 5.7.6-9 (the Idaean Dactyls and the founding of the Olympic Games).'),
 ('Telesphorus','SRC_PAUSANIAS_DESCRIPTION','Pausanias 2.11.7 (Telesphorus, the healing daimon associated with Asclepius).'),
 ('Sibyl','SRC_PAUSANIAS_DESCRIPTION','Pausanias 10.12 (the Sibyls and their oracles).'),
 ('Trivia','SRC_VIRGIL_AENEID','Virgil, Aeneid 6.13, 7.516 (Trivia, the Roman Hecate of the crossroads).'),
 ('Aion','SRC_GREEK_MAGICAL_PAPYRI','The Greek Magical Papyri (Aion invoked as the eternal cosmic power).'),
 ('Corybantes','SRC_ORPHIC_HYMNS','Orphic Hymns 38-39 (To the Kouretes / To the Korybas).')
) AS t(name, src, note)
JOIN entities e ON e.tradition LIKE 'Greek/%' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT round(100.0*count(*) FILTER (WHERE ok)/count(*),1) AS pct_rigorous_overall,
       count(*) FILTER (WHERE NOT ok) AS ref_only_total
FROM (SELECT e.entity_id,
  bool_or(s.source_type IN ('primary text','primary inscription/artifact','heresiological source','secondary scholarship')) ok
  FROM entities e LEFT JOIN entity_sources es ON es.entity_id=e.entity_id LEFT JOIN sources s ON s.source_id=es.source_id
  GROUP BY e.entity_id) g;
SELECT count(*) AS dup_pairs FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d;
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT * FROM v_release_metrics;

COMMIT;
