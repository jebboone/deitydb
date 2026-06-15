-- scripts/source_christian_israelite.sql
-- Sourcing rigor V (v1.40.0): bring the Christian and Israelite/Second Temple entities
-- up to primary attestation. All were sourced only to reference works (DDD, Butler's
-- Lives, the Catholic Encyclopedia); this adds the actual primary texts, additively.
-- The entities are ref-only, so no dedupe risk.

BEGIN;

-- Two foundational hagiographic primary texts not yet in the registry
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_ATHANASIUS_LIFE_ANTONY','Athanasius of Alexandria, Life of Antony (Vita Antonii), c. 360 CE','','primary text','The founding hagiography of Christian monasticism; the desert ascetic Antony'),
('SRC_GREGORY_DIALOGUES','Gregory the Great, Dialogues, Book II (Life of St Benedict), c. 593 CE','','primary text','The earliest life of Benedict of Nursia and his miracles')
ON CONFLICT (source_id) DO NOTHING;

-- ── Israelite / Second Temple → Hebrew Bible (+ Tobit, Jubilees) ─────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_HEBREW_BIBLE', 'Direct attestation', t.note
FROM (VALUES
 ('Yahweh','The God of Israel; the divine name YHWH revealed at Exodus 3:13-15 and throughout the Hebrew Bible.'),
 ('Satan','Job 1-2; Zechariah 3:1-2; 1 Chronicles 21:1 (ha-satan, the accuser).'),
 ('Behemoth','Job 40:15-24.'),
 ('Leviathan','Job 41; Psalm 74:14; Psalm 104:26; Isaiah 27:1.'),
 ('Sheol','Genesis 37:35; Numbers 16:30-33; Psalm 16:10; Isaiah 14:9-11.'),
 ('Ruach','Genesis 1:2 (the ruach of God over the waters); the spirit/wind of YHWH.'),
 ('Bene Elohim','Genesis 6:1-4; Job 1:6; 2:1; 38:7 (the sons of God / divine council).'),
 ('Scapegoat','Leviticus 16:8-22 (the goat for Azazel on the Day of Atonement).'),
 ('Sophia/Wisdom','Proverbs 8:22-31; Job 28 (personified Wisdom, Chokhmah, present at creation).'),
 ('Angel of Death','Exodus 12:23 (the Destroyer); 2 Samuel 24:15-16; 2 Kings 19:35 (the destroying angel).'),
 ('Belial','Deuteronomy 13:13; 1 Samuel 2:12; Psalm 18:4 (the worthlessness/wickedness of Belial).')
) AS t(name, note)
JOIN entities e ON e.tradition='Israelite/Second Temple' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;
-- Tobit (literary figure) → the Book of Tobit; Belial also developed in Jubilees
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_TOBIT', 'Direct attestation', 'The Book of Tobit (the protagonist of the deuterocanonical book).'
FROM entities WHERE tradition='Israelite/Second Temple' AND canonical_name='Tobit'
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_JUBILEES', 'Direct attestation', 'Jubilees (Belial/Mastema as chief of the spirits of darkness in Second Temple demonology).'
FROM entities WHERE tradition='Israelite/Second Temple' AND canonical_name='Belial'
ON CONFLICT DO NOTHING;

-- ── Christian: New Testament figures, demonology, sacraments → New Testament ──
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_NEW_TESTAMENT', 'Direct attestation', t.note
FROM (VALUES
 ('John the Baptist','Matthew 3; Mark 1:1-11; Luke 1, 3; John 1:6-34.'),
 ('Joseph','Matthew 1-2; Luke 1-2 (the husband of Mary).'),
 ('Mary Magdalene','Luke 8:1-3; Matthew 27-28; John 20:1-18 (first witness of the resurrection).'),
 ('Mary Theotokos','Luke 1-2; Matthew 1-2; John 2:1-11; 19:25-27.'),
 ('Paul','Acts 9, 13-28; the Pauline Epistles.'),
 ('Peter','Matthew 16:13-19; the Gospels and Acts; 1-2 Peter.'),
 ('Devil','Matthew 4:1-11; John 8:44; Revelation 12; 20:2 (Satan, the Devil).'),
 ('Demons','The Gospel exorcisms, e.g. Mark 5:1-20; Matthew 8:28-34.'),
 ('Antichrist','1 John 2:18, 22; 4:3; 2 John 7; 2 Thessalonians 2:1-12 (the man of lawlessness); Revelation 13.'),
 ('Baptism','Matthew 3:13-17; 28:19; Romans 6:3-4; Acts 2:38.'),
 ('Mission','Matthew 28:18-20 (the Great Commission); the Acts of the Apostles.')
) AS t(name, note)
JOIN entities e ON e.tradition='Christian' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;

-- ── Christian saints → the foundational vitae / the Golden Legend ────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_ATHANASIUS_LIFE_ANTONY', 'Direct attestation', 'Athanasius, Life of Antony (c. 360), the foundational account of Antony and of eremitic monasticism.'
FROM entities WHERE tradition='Christian' AND canonical_name IN ('Anthony the Great','Monasticism')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_GREGORY_DIALOGUES', 'Direct attestation', 'Gregory the Great, Dialogues Book II (c. 593), the Life of St Benedict.'
FROM entities WHERE tradition='Christian' AND canonical_name='Benedict of Nursia'
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_GOLDEN_LEGEND', 'Direct attestation', 'Jacobus de Voragine, Golden Legend (Legenda Aurea, c. 1260): the life and passion of '||e.canonical_name||'.'
FROM entities e WHERE e.tradition='Christian'
  AND e.canonical_name IN ('Blaise','Catherine of Alexandria','Cosmas and Damian','Francis of Assisi','George','Lucy','Nicholas')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT tradition,
  count(*) AS entities, round(100.0*count(*) FILTER (WHERE hp)/count(*),0) AS pct_w_primary,
  count(*) FILTER (WHERE NOT hp AND NOT hs) AS ref_only
FROM (SELECT e.entity_id, e.tradition,
  bool_or(s.source_type IN ('primary text','primary inscription/artifact','heresiological source')) hp,
  bool_or(s.source_type='secondary scholarship') hs
  FROM entities e JOIN entity_sources es ON es.entity_id=e.entity_id JOIN sources s ON s.source_id=es.source_id
  WHERE e.tradition IN ('Christian','Israelite/Second Temple') GROUP BY e.entity_id, e.tradition) g
GROUP BY tradition ORDER BY tradition;
SELECT count(*) AS dup_pairs FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d;
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT * FROM v_release_metrics;

COMMIT;
