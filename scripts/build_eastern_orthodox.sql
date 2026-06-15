-- scripts/build_eastern_orthodox.sql
-- Content deepening (v1.54.0): Eastern Orthodox Christianity. The Christian set was
-- Western-leaning (Latin saints, the Golden Legend). This builds out the Byzantine and
-- Slavic Orthodox dimension under a distinct tradition tag (Christian/Orthodox): the
-- great-martyrs and unmercenary healers, the Three Holy Hierarchs and the hesychast
-- mystics, the monastic wonderworkers, the Slavic saints, and the distinctively Orthodox
-- Marian veneration (the Pokrov) and the Uncreated Light of Palamite theology. Each to a
-- primary source (the Synaxarion, Palamas' Triads, the Philokalia); period-linked; wired.

BEGIN;

-- ── A period for the Eastern Orthodox span, and its primary sources ───────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes) VALUES
('PER_EAST_ORTHODOX','Christian/Orthodox','Byzantine and Slavic Orthodox',330,1900,
 'Eastern Orthodox Christianity from the founding of Constantinople (330 CE) through the Byzantine and Slavic Orthodox traditions to the great Russian wonderworkers of the modern period.')
ON CONFLICT (period_id) DO NOTHING;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_SYNAXARION','The Synaxarion (the Lives of the Saints of the Orthodox Church)','','primary text','The Orthodox liturgical compilation of the lives of the saints, arranged by feast'),
('SRC_PALAMAS_TRIADS','Gregory Palamas, Triads in Defence of the Holy Hesychasts, c. 1338-1341','','primary text','The defence of hesychasm and the doctrine of the uncreated divine energies/light'),
('SRC_PHILOKALIA','The Philokalia (anthology of the hesychast Fathers), comp. 1782','','primary text','The collection of Orthodox ascetic and mystical texts on inner prayer and theosis')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- great-martyrs and unmercenary healers
 ('ENT_ORTH_DEMETRIOS','Demetrios of Thessaloniki','Christian/Orthodox','Saint','Great-martyr / warrior-saint','protection in war; the city of Thessaloniki; myrrh-streaming','Orthodox','A','candidate_verified_name','Great-martyr with major cultus',0,false,false,'The myrrh-streaming great-martyr and warrior-saint, protector of Thessaloniki.'),
 ('ENT_ORTH_THEODORE','Theodore the Soldier','Christian/Orthodox','Saint','Great-martyr / warrior-saint','protection of soldiers; deliverance','Orthodox','A','candidate_verified_name','Great-martyr with major cultus',0,false,false,'Theodore the Recruit/General, one of the great warrior-martyrs of the East.'),
 ('ENT_ORTH_PANTELEIMON','Panteleimon','Christian/Orthodox','Saint','Unmercenary healer','healing; medicine; the unmercenary cure','Orthodox','A','candidate_verified_name','Great-martyr and healer',0,false,false,'The Great-martyr and Healer Panteleimon, chief of the Holy Unmercenaries (Anargyroi).'),
 ('ENT_ORTH_PARASKEVI','Paraskevi','Christian/Orthodox','Saint','Great-martyr / healer','healing of the eyes; Friday','Orthodox','B','candidate_verified_name','Great-martyr with major cultus',0,false,false,'The great-martyr Paraskevi (Petka), healer of the eyes, much venerated in the Balkans.'),
 ('ENT_ORTH_MENAS','Menas','Christian/Orthodox','Saint','Wonderworker-martyr','wonderworking; the recovery of lost things; the Egyptian shrine','Orthodox','B','candidate_verified_name','Wonderworking martyr',0,false,false,'The wonderworking Egyptian martyr Menas, whose Abu Mena shrine drew vast pilgrimage.'),
 ('ENT_ORTH_MARY_EGYPT','Mary of Egypt','Christian/Orthodox','Saint','Penitent ascetic','repentance; the desert; Great Lent','Orthodox','A','candidate_verified_name','Great penitent with major cultus',1,false,false,'The great penitent of the desert, model of repentance, commemorated on the fifth Sunday of Lent.'),
 -- the Three Holy Hierarchs and the great theologian-saints
 ('ENT_ORTH_BASIL','Basil the Great','Christian/Orthodox','Saint','Hierarch / Church Father','liturgy; monasticism; charity; the Cappadocian theology','Orthodox','A','candidate_verified_name','One of the Three Holy Hierarchs',0,false,false,'Basil the Great of Caesarea, one of the Three Holy Hierarchs and the Cappadocian Fathers.'),
 ('ENT_ORTH_GREGORY_THEOLOGIAN','Gregory the Theologian','Christian/Orthodox','Saint','Hierarch / Church Father','Trinitarian theology; sacred oratory','Orthodox','A','candidate_verified_name','One of the Three Holy Hierarchs',0,false,false,'Gregory of Nazianzus, "the Theologian," one of the Three Holy Hierarchs and the Cappadocian Fathers.'),
 ('ENT_ORTH_CHRYSOSTOM','John Chrysostom','Christian/Orthodox','Saint','Hierarch / Church Father','preaching; the Divine Liturgy; almsgiving','Orthodox','A','candidate_verified_name','One of the Three Holy Hierarchs',0,false,false,'John Chrysostom ("Golden-mouthed"), archbishop of Constantinople, one of the Three Holy Hierarchs.'),
 ('ENT_ORTH_ATHANASIUS','Athanasius of Alexandria','Christian/Orthodox','Saint','Hierarch / Church Father','the defence of Nicene orthodoxy; monasticism','Orthodox','A','candidate_verified_name','Great hierarch',0,false,false,'Athanasius the Great of Alexandria, champion of Nicene orthodoxy and biographer of Antony.'),
 ('ENT_ORTH_PALAMAS','Gregory Palamas','Christian/Orthodox','Saint','Hierarch / mystic','hesychasm; the uncreated energies; theosis','Orthodox','A','candidate_verified_name','Hierarch and hesychast theologian',0,false,false,'Gregory Palamas of Thessaloniki, defender of hesychasm and the doctrine of the uncreated divine energies.'),
 ('ENT_ORTH_SYMEON','Symeon the New Theologian','Christian/Orthodox','Saint','Mystic','the vision of the divine light; inner prayer','Orthodox','A','candidate_verified_name','Great mystic',0,false,false,'Symeon the New Theologian, the great Byzantine mystic of the vision of the divine light.'),
 -- monastic ascetics and wonderworkers
 ('ENT_ORTH_SIMEON_STYLITES','Simeon Stylites','Christian/Orthodox','Saint','Pillar-ascetic','extreme asceticism; the pillar; intercession','Orthodox','A','candidate_verified_name','Founder of the pillar-ascetics',0,false,false,'Simeon the Stylite, who lived decades atop a pillar near Antioch, founder of the stylite ascetics.'),
 ('ENT_ORTH_CLIMACUS','John Climacus','Christian/Orthodox','Saint','Monastic teacher','ascetic ascent; the Ladder of Divine Ascent','Orthodox','A','candidate_verified_name','Sinai abbot, author of the Ladder',0,false,false,'John of the Ladder, abbot of Sinai, author of the Ladder of Divine Ascent.'),
 ('ENT_ORTH_CYRIL_METHODIUS','Cyril and Methodius','Christian/Orthodox','Saint','Equal-to-the-Apostles','the Slavic mission; the Glagolitic script','Orthodox','A','candidate_verified_name','Apostles to the Slavs',0,false,false,'Cyril and Methodius, the Equal-to-the-Apostles brothers who evangelised the Slavs and devised their script.'),
 ('ENT_ORTH_SERGIUS','Sergius of Radonezh','Christian/Orthodox','Saint','Monastic wonderworker','Russian monasticism; the Trinity Lavra; intercession for Russia','Orthodox','A','candidate_verified_name','Great Russian wonderworker',1,false,false,'Sergius of Radonezh, the great wonderworker of Russia and founder of the Trinity Lavra.'),
 ('ENT_ORTH_SERAPHIM','Seraphim of Sarov','Christian/Orthodox','Saint','Monastic wonderworker','acquisition of the Holy Spirit; healing; joy','Orthodox','A','candidate_verified_name','Great Russian wonderworker',0,false,false,'Seraphim of Sarov, the most beloved Russian wonderworker, radiant with the light of the Holy Spirit.'),
 ('ENT_ORTH_VLADIMIR','Vladimir','Christian/Orthodox','Saint','Equal-to-the-Apostles','the baptism of Rus''; the conversion of the Slavs','Orthodox','A','candidate_verified_name','Equal-to-the-Apostles ruler',0,false,false,'Grand Prince Vladimir of Kiev, Equal-to-the-Apostles, who baptised the Rus'' in 988.'),
 -- Marian veneration and the Uncreated Light
 ('ENT_ORTH_POKROV','Protection of the Theotokos','Christian/Orthodox','Marian veneration','Theotokos cult-form','the protecting veil of the Mother of God; intercession','Orthodox','A','candidate_verified_name','Major Orthodox Marian feast',0,false,false,'The Pokrov: the Protection of the Mother of God, who spreads her veil over the faithful.'),
 ('ENT_ORTH_UNCREATED_LIGHT','Uncreated Light','Christian/Orthodox','Divine manifestation','Divine energies','the Taboric light; the uncreated energies of God; theosis','Orthodox','A','candidate_verified_name','Palamite divine manifestation',0,false,false,'The Uncreated Light, the divine energies of God seen at the Transfiguration and in hesychast prayer.'),
 -- collective
 ('ENT_ORTH_THREE_HIERARCHS','Three Holy Hierarchs','Christian/Orthodox','Holy collective','The Ecumenical Teachers','theology; preaching; the unity of the Fathers','Orthodox','A','candidate_verified_name','Joint feast of the great hierarchs',0,false,false,'The Three Holy Hierarchs and Ecumenical Teachers: Basil the Great, Gregory the Theologian and John Chrysostom.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_ORTH_DEMETRIOS','SRC_SYNAXARION','direct attestation','The Synaxarion (26 October): the great-martyr Demetrios the Myrrh-streamer of Thessaloniki.'),
 ('ENT_ORTH_THEODORE','SRC_SYNAXARION','direct attestation','The Synaxarion: the great-martyrs Theodore the Recruit (Tyron) and Theodore the General (Stratelates).'),
 ('ENT_ORTH_PANTELEIMON','SRC_SYNAXARION','direct attestation','The Synaxarion (27 July): the Great-martyr and Healer Panteleimon, chief of the Unmercenaries.'),
 ('ENT_ORTH_PARASKEVI','SRC_SYNAXARION','direct attestation','The Synaxarion: the great-martyr Paraskevi, healer of the eyes.'),
 ('ENT_ORTH_MENAS','SRC_SYNAXARION','direct attestation','The Synaxarion (11 November): the wonderworking martyr Menas of Egypt.'),
 ('ENT_ORTH_MARY_EGYPT','SRC_SYNAXARION','direct attestation','The Synaxarion (Life by Sophronius, read in Great Lent): Mary of Egypt, the great penitent.'),
 ('ENT_ORTH_BASIL','SRC_SYNAXARION','direct attestation','The Synaxarion (1 January): Basil the Great of Caesarea.'),
 ('ENT_ORTH_GREGORY_THEOLOGIAN','SRC_SYNAXARION','direct attestation','The Synaxarion (25 January): Gregory the Theologian of Nazianzus.'),
 ('ENT_ORTH_CHRYSOSTOM','SRC_SYNAXARION','direct attestation','The Synaxarion (13 November): John Chrysostom, archbishop of Constantinople.'),
 ('ENT_ORTH_ATHANASIUS','SRC_SYNAXARION','direct attestation','The Synaxarion (18 January): Athanasius the Great of Alexandria.'),
 ('ENT_ORTH_ATHANASIUS','SRC_ATHANASIUS_LIFE_ANTONY','direct attestation','Athanasius is the author of the Life of Antony, the founding text of monastic hagiography.'),
 ('ENT_ORTH_PALAMAS','SRC_PALAMAS_TRIADS','direct attestation','Gregory Palamas, Triads: his defence of hesychasm and the uncreated energies (2nd Sunday of Lent).'),
 ('ENT_ORTH_SYMEON','SRC_PHILOKALIA','direct attestation','The Philokalia / Symeon''s Hymns of Divine Love: the vision of the divine light.'),
 ('ENT_ORTH_SIMEON_STYLITES','SRC_SYNAXARION','direct attestation','The Synaxarion (1 September): Simeon the Stylite of the pillar near Antioch.'),
 ('ENT_ORTH_CLIMACUS','SRC_SYNAXARION','direct attestation','The Synaxarion (30 March / 4th Sunday of Lent): John Climacus and the Ladder of Divine Ascent.'),
 ('ENT_ORTH_CYRIL_METHODIUS','SRC_SYNAXARION','direct attestation','The Synaxarion (11 May): Cyril and Methodius, Equal-to-the-Apostles, teachers of the Slavs.'),
 ('ENT_ORTH_SERGIUS','SRC_SYNAXARION','direct attestation','The Synaxarion (25 September): Sergius of Radonezh, wonderworker of all Russia.'),
 ('ENT_ORTH_SERAPHIM','SRC_SYNAXARION','direct attestation','The Synaxarion (2 January / 19 July): Seraphim of Sarov, wonderworker.'),
 ('ENT_ORTH_VLADIMIR','SRC_SYNAXARION','direct attestation','The Synaxarion (15 July): Grand Prince Vladimir, Equal-to-the-Apostles, baptiser of the Rus''.'),
 ('ENT_ORTH_POKROV','SRC_SYNAXARION','direct attestation','The Synaxarion (1 October): the Protection of the Theotokos (Pokrov), the vision of St Andrew the Fool.'),
 ('ENT_ORTH_UNCREATED_LIGHT','SRC_PALAMAS_TRIADS','direct attestation','Gregory Palamas, Triads: the uncreated light/energies of God, distinct from the divine essence.'),
 ('ENT_ORTH_THREE_HIERARCHS','SRC_SYNAXARION','direct attestation','The Synaxarion (30 January): the joint feast of the Three Holy Hierarchs and Ecumenical Teachers.')
ON CONFLICT DO NOTHING;

-- ── Periods (all to the Eastern Orthodox span) ───────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_EAST_ORTHODOX', 'A', 'Byzantine/Slavic Orthodox saint or doctrine.', 'reviewed'
FROM entities WHERE tradition='Christian/Orthodox'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=entities.entity_id)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 -- the Three Holy Hierarchs
 ('ENT_ORTH_BASIL','member_of','ENT_ORTH_THREE_HIERARCHS','high','Basil the Great is one of the Three Holy Hierarchs.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_GREGORY_THEOLOGIAN','member_of','ENT_ORTH_THREE_HIERARCHS','high','Gregory the Theologian is one of the Three Holy Hierarchs.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_CHRYSOSTOM','member_of','ENT_ORTH_THREE_HIERARCHS','high','John Chrysostom is one of the Three Holy Hierarchs.','SRC_SYNAXARION','reviewed'),
 -- the Uncreated Light and Palamism
 ('ENT_ORTH_UNCREATED_LIGHT','emanates_from','ENT_CHR_GOD_FATHER','high','The uncreated light is the divine energies that proceed from God (Palamas).','SRC_PALAMAS_TRIADS','reviewed'),
 ('ENT_ORTH_UNCREATED_LIGHT','aligned_with','ENT_JESUS_CHRIST','high','The uncreated light shone from Christ at the Transfiguration on Tabor.','SRC_PALAMAS_TRIADS','reviewed'),
 ('ENT_ORTH_PALAMAS','aligned_with','ENT_ORTH_UNCREATED_LIGHT','high','Gregory Palamas is the defender of the doctrine of the uncreated light.','SRC_PALAMAS_TRIADS','reviewed'),
 ('ENT_ORTH_PALAMAS','aligned_with','ENT_ORTH_SYMEON','medium','Palamas continues the hesychast mystical lineage of Symeon the New Theologian.','SRC_PHILOKALIA','reviewed'),
 -- the Protection of the Theotokos
 ('ENT_ORTH_POKROV','cult_form_of','ENT_SAINT_MARY','high','The Pokrov is a veneration-form of the Mother of God as protectress.','SRC_SYNAXARION','reviewed'),
 -- cross-links to existing saints
 ('ENT_ORTH_ATHANASIUS','aligned_with','ENT_SAINT_ANTHONY_ABBOT','high','Athanasius wrote the Life of Antony, founding text of monastic hagiography.','SRC_ATHANASIUS_LIFE_ANTONY','reviewed'),
 ('ENT_ORTH_PANTELEIMON','aligned_with','ENT_SAINT_COSMAS_DAMIAN','high','Panteleimon stands with Cosmas and Damian among the Holy Unmercenary healers.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_DEMETRIOS','aligned_with','ENT_SAINT_GEORGE','medium','Demetrios and George are the two foremost warrior great-martyrs of the East.','SRC_SYNAXARION','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Christian/Orthodox' AS k, count(*) v FROM entities WHERE tradition='Christian/Orthodox'
UNION ALL SELECT 'Christian-family total', count(*) FROM entities WHERE tradition LIKE 'Christian%';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS undated FROM entities e WHERE e.tradition='Christian/Orthodox' AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
