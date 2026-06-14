-- scripts/add_sufi_formative_layer.sql
-- New layer (v1.26.0): formative Sufism, 8th-10th century CE.
--
-- Chronology / bottom-up rationale: early Sufism (Hasan al-Basri d. 728 through
-- al-Hallaj d. 922) predates Kabbalah proper (12th-13th c.) by ~300-400 years, so it
-- is built first. The great systematizers — al-Ghazali (d. 1111), Ibn al-Arabi (d. 1240),
-- Rumi (d. 1273) — belong to a later stratum and are deliberately deferred.
--
-- Adds 6 historical mystics (oldest first), 6 core doctrines, and 2 sources; wires the
-- layer into the existing Sufi sainthood node (Walaya) and the comparative abstraction
-- nodes (Love, Hidden Knowledge, Union). Existing Sufi cosmological offices (Qutb, Abdal,
-- Rijal al-Ghayb) keep their ENT_ISL_ ids; new Sufi-specific entities use ENT_SUF_.

BEGIN;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_SCHIMMEL_SUFISM','Annemarie Schimmel, Mystical Dimensions of Islam (University of North Carolina Press, 1975)','','monograph','Sufism: history, doctrine, the formative masters, orders, and poetics'),
('SRC_HUJWIRI_KASHF','Ali ibn Uthman al-Hujwiri, Kashf al-Mahjub ("The Unveiling of the Hidden"), c. 1075 CE (trans. R. A. Nicholson)','','primary text','Earliest Persian Sufi treatise; biographies and doctrines of the early masters')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities: 6 formative mystics (oldest first) ─────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
('ENT_SUF_HASAN_BASRI','Hasan al-Basri','Sufi ascetic/saint','Islamic/Sufi','Holy figure','PER_ISL_EARLY','A','reviewed',
 'Basran preacher and ascetic (d. 728), foundational figure of Islamic zuhd (asceticism); emphasised self-examination (muhasaba), fear of God (khawf), and constant remembrance. Most later Sufi silsilas (chains of transmission) are traced back through him.'),
('ENT_SUF_RABIA','Rabia al-Adawiyya','Sufi saint','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Basran woman mystic (d. 801) who gave doctrinal form to disinterested divine love (mahabba): loving God for the sake of God alone, neither from fear of Hell nor hope of Paradise. The first great voice of love-mysticism in Islam.'),
('ENT_SUF_DHUL_NUN','Dhul-Nun al-Misri','Sufi saint','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Egyptian mystic (d. 859) credited as the first to articulate the doctrine of marifa (experiential gnosis of God) and to map the mystical states (ahwal). A bridge between Egyptian Hellenistic wisdom and early Sufism.'),
('ENT_SUF_BISTAMI','Abu Yazid al-Bistami','Sufi saint','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Persian mystic (d. 874), foremost exponent of "intoxicated" (sukr) Sufism and of fana (annihilation of the self). Famed for ecstatic utterances (shatahat) such as "Subhani!" ("Glory be to Me!").'),
('ENT_SUF_JUNAYD','al-Junayd al-Baghdadi','Sufi saint','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Master of the Baghdad school (d. 910), called Sayyid al-Taifa ("lord of the order"); founder of "sober" (sahw) Sufism. Taught that fana is completed by baqa (subsistence in God) and a return to lucid life in the world.'),
('ENT_SUF_HALLAJ','al-Hallaj','Sufi martyr','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Husayn ibn Mansur al-Hallaj (d. 922), Persian mystic executed in Baghdad; his ecstatic cry "Ana al-Haqq" ("I am the Truth/the Real") became the paradigmatic utterance of mystical union and the archetype of the martyr of divine love.'),

-- ── Entities: 6 core doctrines / categories ──────────────────────────────────
('ENT_SUF_FANA','Fana','Mystical process/category','Islamic/Sufi','Mystical process','PER_ISL_CLASSICAL','A','reviewed',
 'The annihilation of the ego-self in God, the pivotal goal of the mystical path; expressed ecstatically by al-Bistami and given sober doctrinal shape by al-Junayd.'),
('ENT_SUF_BAQA','Baqa','Mystical process/category','Islamic/Sufi','Mystical process','PER_ISL_CLASSICAL','A','reviewed',
 'Abiding or subsistence in God that follows fana; in al-Junayd''s teaching the annihilated self is restored, now subsisting through God rather than through itself.'),
('ENT_SUF_MARIFA','Marifa','Mystical knowledge/category','Islamic/Sufi','Knowledge category','PER_ISL_CLASSICAL','A','reviewed',
 'Experiential, intuitive gnosis of God, distinct from discursive learning (ilm); systematised by Dhul-Nun al-Misri as the heart''s direct knowing.'),
('ENT_SUF_MAHABBA','Mahabba','Mystical love/category','Islamic/Sufi','Mystical love','PER_ISL_CLASSICAL','A','reviewed',
 'Selfless mystical love of God, the animating principle of the Sufi path; given its first doctrinal voice by Rabia al-Adawiyya.'),
('ENT_SUF_DHIKR','Dhikr','Ritual/devotional category','Islamic/Sufi','Ritual category','PER_ISL_CLASSICAL','A','reviewed',
 'The remembrance and invocation of God (often through the divine names), the central Sufi spiritual practice for polishing the heart and realising the divine presence.'),
('ENT_SUF_TARIQA','Tariqa','Mystical path/category','Islamic/Sufi','Mystical path','PER_ISL_CLASSICAL','A','reviewed',
 'The Sufi "path" of stations (maqamat) and states (ahwal) leading from the law (sharia) toward mystical realisation (haqiqa); later also the name for the institutional orders.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources ───────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_SUF_HASAN_BASRI','SRC_HUJWIRI_KASHF','Direct attestation','Biography among the early masters in the Kashf al-Mahjub.'),
('ENT_SUF_HASAN_BASRI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Treated as the fountainhead of Islamic asceticism and the silsila chains.'),
('ENT_SUF_RABIA','SRC_HUJWIRI_KASHF','Direct attestation','Sayings and life of Rabia among the early saints.'),
('ENT_SUF_RABIA','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on Rabia as the originator of disinterested love-mysticism.'),
('ENT_SUF_DHUL_NUN','SRC_HUJWIRI_KASHF','Direct attestation','Life and sayings of Dhul-Nun al-Misri.'),
('ENT_SUF_DHUL_NUN','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on Dhul-Nun and the doctrine of marifa.'),
('ENT_SUF_BISTAMI','SRC_HUJWIRI_KASHF','Direct attestation','Life and shatahat of Abu Yazid al-Bistami.'),
('ENT_SUF_BISTAMI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on intoxicated Sufism and fana.'),
('ENT_SUF_JUNAYD','SRC_HUJWIRI_KASHF','Direct attestation','Life and teaching of al-Junayd among the masters.'),
('ENT_SUF_JUNAYD','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on the sober Baghdad school and fana/baqa.'),
('ENT_SUF_HALLAJ','SRC_HUJWIRI_KASHF','Direct attestation','Account of al-Hallaj and the "Ana al-Haqq".'),
('ENT_SUF_HALLAJ','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on Hallaj as martyr of mystical love and union.'),
('ENT_SUF_FANA','SRC_SCHIMMEL_SUFISM','Secondary analysis','Doctrine of fana.'),
('ENT_SUF_BAQA','SRC_SCHIMMEL_SUFISM','Secondary analysis','Doctrine of baqa and its relation to fana.'),
('ENT_SUF_MARIFA','SRC_SCHIMMEL_SUFISM','Secondary analysis','Doctrine of marifa (gnosis).'),
('ENT_SUF_MAHABBA','SRC_SCHIMMEL_SUFISM','Secondary analysis','Doctrine of mahabba (mystical love).'),
('ENT_SUF_DHIKR','SRC_SCHIMMEL_SUFISM','Secondary analysis','The practice of dhikr.'),
('ENT_SUF_TARIQA','SRC_SCHIMMEL_SUFISM','Secondary analysis','The path (tariqa): stations, states, and the later orders.')
ON CONFLICT DO NOTHING;

-- ── Entity periods ───────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status) VALUES
('ENT_SUF_HASAN_BASRI','PER_ISL_EARLY','high','Died 728 CE, within the Early Islamic period.','SRC_HUJWIRI_KASHF','reviewed'),
('ENT_SUF_RABIA','PER_ISL_CLASSICAL','high','Died 801 CE.','SRC_HUJWIRI_KASHF','reviewed'),
('ENT_SUF_DHUL_NUN','PER_ISL_CLASSICAL','high','Died 859 CE.','SRC_HUJWIRI_KASHF','reviewed'),
('ENT_SUF_BISTAMI','PER_ISL_CLASSICAL','high','Died 874 CE.','SRC_HUJWIRI_KASHF','reviewed'),
('ENT_SUF_JUNAYD','PER_ISL_CLASSICAL','high','Died 910 CE.','SRC_HUJWIRI_KASHF','reviewed'),
('ENT_SUF_HALLAJ','PER_ISL_CLASSICAL','high','Executed 922 CE.','SRC_HUJWIRI_KASHF','reviewed'),
('ENT_SUF_FANA','PER_ISL_CLASSICAL','high','Doctrine formalised in classical Sufism (9th-10th c.).','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_BAQA','PER_ISL_CLASSICAL','high','Doctrine formalised by al-Junayd (d. 910).','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_MARIFA','PER_ISL_CLASSICAL','high','Articulated by Dhul-Nun (d. 859).','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_MAHABBA','PER_ISL_CLASSICAL','high','Articulated by Rabia (d. 801).','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_DHIKR','PER_ISL_CLASSICAL','high','Core practice of the formative period.','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_TARIQA','PER_ISL_CLASSICAL','high','Path-concept of classical Sufism; orders crystallise later.','SRC_SCHIMMEL_SUFISM','reviewed')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- figures embody/teach their signature doctrines
('ENT_SUF_RABIA','embodies','ENT_SUF_MAHABBA','high','Rabia is the originating exponent of disinterested divine love.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_DHUL_NUN','teaches','ENT_SUF_MARIFA','high','Dhul-Nun first systematised the doctrine of experiential gnosis.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_BISTAMI','embodies','ENT_SUF_FANA','high','Bistami''s ecstatic utterances are the paradigm of intoxicated fana.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_JUNAYD','teaches','ENT_SUF_FANA','high','Junayd gave fana its sober doctrinal formulation.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_JUNAYD','teaches','ENT_SUF_BAQA','high','Junayd taught that fana is completed by baqa, subsistence in God.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_HALLAJ','embodies','ENT_SUF_FANA','high','Hallaj''s "Ana al-Haqq" is the extreme expression of annihilating union.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_HALLAJ','embodies','ENT_SUF_MAHABBA','medium','Hallaj is remembered as the martyr of divine love.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_HASAN_BASRI','teaches','ENT_SUF_DHIKR','medium','Hasan al-Basri''s asceticism centred on remembrance and self-watchfulness.','SRC_HUJWIRI_KASHF','PER_ISL_EARLY','reviewed'),
-- silsila / transmission
('ENT_SUF_JUNAYD','teaches','ENT_SUF_HALLAJ','high','Hallaj was a disciple of Junayd before breaking with the sober school.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_JUNAYD','reception_of','ENT_SUF_HASAN_BASRI','medium','The Baghdad school''s sobriety descends from the Basran ascetic tradition Hasan founded.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
-- doctrine structure
('ENT_SUF_FANA','paired_with','ENT_SUF_BAQA','high','Fana and baqa are the complementary pair: annihilation then subsistence.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_BAQA','paired_with','ENT_SUF_FANA','high','Baqa is the subsistence that follows the annihilation of fana.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_FANA','member_of','ENT_SUF_TARIQA','high','Fana is a culminating station of the path.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_BAQA','member_of','ENT_SUF_TARIQA','high','Baqa is the path''s consummation.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_MARIFA','member_of','ENT_SUF_TARIQA','high','Marifa is the knowing attained on the path.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_DHIKR','member_of','ENT_SUF_TARIQA','high','Dhikr is the core practice of the path.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
-- comparative-layer integration
('ENT_SUF_MAHABBA','aligned_with','ENT_LOVE','high','Mahabba is the Sufi form of divine love.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_MARIFA','aligned_with','ENT_HIDDEN_KNOWLEDGE','high','Marifa is esoteric, experiential knowledge of God.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_FANA','aligned_with','ENT_UNION','medium','Fana is the annihilation through which mystical union is realised.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
-- sainthood (walaya) integration with the existing Sufi cosmological layer
('ENT_SUF_JUNAYD','embodies','ENT_WALAYA','medium','Junayd, "lord of the order", is a paradigm of realised sainthood (walaya).','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_BISTAMI','embodies','ENT_WALAYA','medium','Bistami is among the archetypal awliya (friends of God).','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS sufi_entities FROM entities WHERE tradition='Islamic/Sufi';
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT * FROM v_release_metrics;

COMMIT;
