-- scripts/add_sufi_classical_systematizers.sql
-- Layer (v1.28.0): the later Sufi stratum — the systematizers and metaphysicians,
-- 11th-13th century CE, built oldest-first on top of the formative layer (v1.26.0).
--
-- al-Qushayri (d. 1074) -> al-Ghazali (d. 1111) -> Abd al-Qadir al-Jilani (d. 1166)
-- -> Suhrawardi (d. 1191) -> Ibn al-Arabi (d. 1240) -> Rumi (d. 1273). Adds their
-- signature doctrines (wahdat al-wujud, the Perfect Man, ishraq, sama) and wires the
-- Perfect Man into the cross-tradition Anthropos / Adam Kadmon motif.
--
-- New period PER_ISL_MEDIEVAL for Rumi (d. 1273, after the 1258 close of Classical Islam).

BEGIN;

-- ── Period ───────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes) VALUES
('PER_ISL_MEDIEVAL','Islamic','Medieval Islam',1258,1517,
 'Post-Abbasid era after the Mongol sack of Baghdad; flourishing of the Sufi orders (turuq) and Persian/Turkish mystical poetry, to the rise of the Ottoman and Safavid empires.')
ON CONFLICT (period_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_GHAZALI_IHYA','Abu Hamid al-Ghazali, Ihya Ulum al-Din ("The Revival of the Religious Sciences"), c. 1105 CE','','primary text','Synthesis of Sufi inner life with Sunni law and theology'),
('SRC_IBN_ARABI_FUSUS','Ibn al-Arabi, Fusus al-Hikam ("The Bezels of Wisdom"), c. 1229 CE','','primary text','Akbarian metaphysics: wahdat al-wujud and the Perfect Man'),
('SRC_RUMI_MASNAVI','Jalal al-Din Rumi, Masnavi-i Manavi, c. 1258-1273 CE','','primary text','Persian Sufi didactic poetry; love-mysticism and the path')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities: 6 figures (oldest first) + 4 doctrines ─────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
('ENT_SUF_QUSHAYRI','al-Qushayri','Sufi master/author','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Abu al-Qasim al-Qushayri (d. 1074), author of al-Risala al-Qushayriyya, the classic manual that organised the stations (maqamat) and states (ahwal) and defended Sufism as orthodox.'),
('ENT_SUF_GHAZALI','al-Ghazali','Sufi theologian','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Abu Hamid al-Ghazali (d. 1111), "Proof of Islam" (Hujjat al-Islam); his Ihya Ulum al-Din reconciled Sufi interior practice with Sunni law and theology, making Sufism respectable within the mainstream.'),
('ENT_SUF_JILANI','Abd al-Qadir al-Jilani','Sufi saint/order founder','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Abd al-Qadir al-Jilani (d. 1166), eponym of the Qadiriyya, the first great Sufi order (tariqa); venerated as Sultan al-Awliya, "sultan of the saints".'),
('ENT_SUF_SUHRAWARDI','Suhrawardi','Sufi philosopher','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Shihab al-Din Yahya al-Suhrawardi (d. 1191), "al-Maqtul" (the executed), Shaykh al-Ishraq; founder of Illuminationist (Ishraqi) philosophy, fusing Avicennan metaphysics with a symbolism of light drawn partly from ancient Persia.'),
('ENT_SUF_IBN_ARABI','Ibn al-Arabi','Sufi metaphysician','Islamic/Sufi','Holy figure','PER_ISL_CLASSICAL','A','reviewed',
 'Muhyi al-Din Ibn al-Arabi (d. 1240), al-Shaykh al-Akbar ("the greatest master"); his Fusus al-Hikam and Futuhat al-Makkiyya systematise wahdat al-wujud (the unity of being) and the doctrine of the Perfect Man (al-insan al-kamil).'),
('ENT_SUF_RUMI','Rumi','Sufi poet','Islamic/Sufi','Holy figure','PER_ISL_MEDIEVAL','A','reviewed',
 'Jalal al-Din Rumi (d. 1273), author of the Masnavi; the supreme Persian poet of love-mysticism, whose circle gave rise to the Mevlevi order of whirling dervishes and the practice of sama.'),
('ENT_SUF_WAHDAT_WUJUD','Wahdat al-Wujud','Mystical doctrine/category','Islamic/Sufi','Theological category','PER_ISL_CLASSICAL','A','reviewed',
 'The "unity of being": the Akbarian doctrine that there is only one true Being, of which all things are self-disclosures (tajalliyat). The central metaphysical teaching associated with Ibn al-Arabi.'),
('ENT_SUF_INSAN_KAMIL','Insan al-Kamil','Mystical archetype/category','Islamic/Sufi','Theological category','PER_ISL_CLASSICAL','A','reviewed',
 'The "Perfect (or Complete) Human": the microcosm who fully realises the divine names and serves as the isthmus between God and creation. The Islamic counterpart of the cosmic Anthropos and the Kabbalistic Adam Kadmon.'),
('ENT_SUF_ISHRAQ','Ishraq','Mystical doctrine/category','Islamic/Sufi','Mystical knowledge/category','PER_ISL_CLASSICAL','A','reviewed',
 'Illumination: Suhrawardi''s metaphysics in which reality is graded light emanating from the Light of Lights, and knowledge is direct illuminative presence rather than discursive proof.'),
('ENT_SUF_SAMA','Sama','Ritual/devotional category','Islamic/Sufi','Ritual category','PER_ISL_MEDIEVAL','A','reviewed',
 'Spiritual audition: listening to music and poetry (and, in the Mevlevi turning, sacred dance) as a means of inducing ecstasy and remembrance; a contested but widespread Sufi practice.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources ───────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_SUF_QUSHAYRI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on al-Qushayri and the Risala.'),
('ENT_SUF_GHAZALI','SRC_GHAZALI_IHYA','Direct attestation','Author of the Ihya Ulum al-Din.'),
('ENT_SUF_GHAZALI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on al-Ghazali and the mainstreaming of Sufism.'),
('ENT_SUF_JILANI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on al-Jilani and the Qadiriyya.'),
('ENT_SUF_SUHRAWARDI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on Suhrawardi and Illuminationism.'),
('ENT_SUF_IBN_ARABI','SRC_IBN_ARABI_FUSUS','Direct attestation','Author of the Fusus al-Hikam.'),
('ENT_SUF_IBN_ARABI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on Ibn al-Arabi and wahdat al-wujud.'),
('ENT_SUF_RUMI','SRC_RUMI_MASNAVI','Direct attestation','Author of the Masnavi.'),
('ENT_SUF_RUMI','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on Rumi and the Mevlevi.'),
('ENT_SUF_WAHDAT_WUJUD','SRC_IBN_ARABI_FUSUS','Direct attestation','Doctrine articulated in the Fusus.'),
('ENT_SUF_WAHDAT_WUJUD','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on wahdat al-wujud.'),
('ENT_SUF_INSAN_KAMIL','SRC_IBN_ARABI_FUSUS','Direct attestation','The Perfect Man in the Fusus.'),
('ENT_SUF_INSAN_KAMIL','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on al-insan al-kamil and its parallels.'),
('ENT_SUF_ISHRAQ','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on Suhrawardi''s Ishraqi doctrine.'),
('ENT_SUF_SAMA','SRC_RUMI_MASNAVI','Direct attestation','Sama in the Mevlevi tradition of Rumi.'),
('ENT_SUF_SAMA','SRC_SCHIMMEL_SUFISM','Secondary analysis','Schimmel on sama as practice and controversy.')
ON CONFLICT DO NOTHING;

-- ── Entity periods ───────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status) VALUES
('ENT_SUF_QUSHAYRI','PER_ISL_CLASSICAL','high','Died 1074 CE.','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_GHAZALI','PER_ISL_CLASSICAL','high','Died 1111 CE.','SRC_GHAZALI_IHYA','reviewed'),
('ENT_SUF_JILANI','PER_ISL_CLASSICAL','high','Died 1166 CE.','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_SUHRAWARDI','PER_ISL_CLASSICAL','high','Executed 1191 CE.','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_IBN_ARABI','PER_ISL_CLASSICAL','high','Died 1240 CE, within Classical Islam.','SRC_IBN_ARABI_FUSUS','reviewed'),
('ENT_SUF_RUMI','PER_ISL_MEDIEVAL','high','Died 1273 CE, after the 1258 fall of Baghdad.','SRC_RUMI_MASNAVI','reviewed'),
('ENT_SUF_WAHDAT_WUJUD','PER_ISL_CLASSICAL','high','Articulated by Ibn al-Arabi (d. 1240).','SRC_IBN_ARABI_FUSUS','reviewed'),
('ENT_SUF_INSAN_KAMIL','PER_ISL_CLASSICAL','high','Developed by Ibn al-Arabi (d. 1240).','SRC_IBN_ARABI_FUSUS','reviewed'),
('ENT_SUF_ISHRAQ','PER_ISL_CLASSICAL','high','Founded by Suhrawardi (d. 1191).','SRC_SCHIMMEL_SUFISM','reviewed'),
('ENT_SUF_SAMA','PER_ISL_MEDIEVAL','high','Crystallised in the Mevlevi practice (13th c. onward).','SRC_RUMI_MASNAVI','reviewed')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- figures and their doctrines/practices
('ENT_SUF_SUHRAWARDI','teaches','ENT_SUF_ISHRAQ','high','Suhrawardi founded the Illuminationist (Ishraqi) school.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_IBN_ARABI','teaches','ENT_SUF_WAHDAT_WUJUD','high','Ibn al-Arabi is the source of the doctrine of the unity of being.','SRC_IBN_ARABI_FUSUS','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_IBN_ARABI','teaches','ENT_SUF_INSAN_KAMIL','high','Ibn al-Arabi developed the doctrine of the Perfect Man.','SRC_IBN_ARABI_FUSUS','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_RUMI','associated_ritual','ENT_SUF_SAMA','high','Rumi''s circle gave rise to the Mevlevi sama (whirling).','SRC_RUMI_MASNAVI','PER_ISL_MEDIEVAL','reviewed'),
('ENT_SUF_RUMI','embodies','ENT_SUF_MAHABBA','high','Rumi is the paramount poet of mystical love.','SRC_RUMI_MASNAVI','PER_ISL_MEDIEVAL','reviewed'),
('ENT_SUF_GHAZALI','teaches','ENT_SUF_TARIQA','high','The Ihya maps the stations and disciplines of the path for the mainstream believer.','SRC_GHAZALI_IHYA','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_QUSHAYRI','teaches','ENT_SUF_TARIQA','high','The Risala codified the stations (maqamat) and states (ahwal) of the path.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_JILANI','teaches','ENT_SUF_TARIQA','high','Al-Jilani founded the Qadiriyya, the first enduring Sufi order.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
-- doctrine integration (comparative + existing Sufi nodes)
('ENT_SUF_WAHDAT_WUJUD','aligned_with','ENT_UNION','high','Wahdat al-wujud is the metaphysics underlying mystical union.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_INSAN_KAMIL','aligned_with','ENT_JM_ADAM_KADMON','medium','The Perfect Man parallels the Kabbalistic primordial Adam Kadmon as the macranthropos.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_INSAN_KAMIL','aligned_with','ENT_GNO_ANTHROPOS','medium','The Perfect Man parallels the Gnostic-Hermetic cosmic Anthropos / primal Man.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_ISHRAQ','aligned_with','ENT_LIGHT','high','Ishraqi metaphysics grades all reality as light from the Light of Lights.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_SAMA','aligned_with','ENT_SUF_DHIKR','high','Sama functions as an ecstatic mode of remembrance (dhikr).','SRC_SCHIMMEL_SUFISM','PER_ISL_MEDIEVAL','reviewed'),
-- silsila / reception from the formative masters
('ENT_SUF_GHAZALI','reception_of','ENT_SUF_JUNAYD','medium','Al-Ghazali draws the sober interior discipline he systematises from the Junaydi tradition.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_IBN_ARABI','reception_of','ENT_SUF_HALLAJ','medium','Ibn al-Arabi engages and reinterprets al-Hallaj''s ecstatic claims of union within his metaphysics.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed'),
-- sainthood (walaya)
('ENT_SUF_IBN_ARABI','embodies','ENT_WALAYA','medium','Ibn al-Arabi theorised the hierarchy and seal of sainthood (khatm al-awliya).','SRC_IBN_ARABI_FUSUS','PER_ISL_CLASSICAL','reviewed'),
('ENT_SUF_JILANI','embodies','ENT_WALAYA','medium','Al-Jilani, "sultan of the saints", is a paradigm of realised walaya.','SRC_SCHIMMEL_SUFISM','PER_ISL_CLASSICAL','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS sufi_entities FROM entities WHERE tradition='Islamic/Sufi';
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
-- the cross-tradition Perfect Man bridge:
SELECT s.canonical_name AS perfect_man, r.relationship_type, o.canonical_name AS parallels, o.tradition
FROM entity_relationships r JOIN entities s ON s.entity_id=r.subject_entity_id JOIN entities o ON o.entity_id=r.object_entity_id
WHERE s.entity_id='ENT_SUF_INSAN_KAMIL';
SELECT * FROM v_release_metrics;

COMMIT;
