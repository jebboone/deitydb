-- scripts/build_hermetic_theurgic.sql
-- Content normalization VIII (v1.50.0): Hermetic/Theurgic build-out. The DB had the
-- Corpus Hermeticum metaphysical core (the One, Nous, Logos, Cosmos, Anthropos, Hermes
-- Trismegistus, Agathos Daimon) but none of the Hermetic cosmic drama or the Chaldean/
-- Neoplatonic theurgic hierarchy. This fills in the Poimandres revelation, the descent of
-- fate, the spheres of ascent, and the Chaldean-theurgic orders (the Father, the cosmic
-- Hecate, the Iynges/Synocheis/Teletarchs, the henads, the personal daimon). Hermetic/
-- Theurgic 7 -> 24. Grounded in the user's theurgy library (Bull; Proclus' Hieratic Art).

BEGIN;

-- ── New sources (Corpus Hermeticum, Asclepius, Iamblichus, PGM already registered) ──
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_CHALDEAN_ORACLES','The Chaldean Oracles (ed. R. Majercik / E. des Places), c. 2nd c. CE','','primary text','The verse revelation underlying late-antique theurgy; the Father, Hecate, the connective orders'),
('SRC_PLOTINUS_ENNEADS','Plotinus, Enneads (ed. Porphyry), c. 270 CE','','primary text','The foundational Neoplatonic treatises; the One, Intellect and the World Soul'),
('SRC_PROCLUS_ELEMENTS','Proclus, The Elements of Theology (Stoicheiosis Theologike), c. 5th c. CE','','primary text','Proclus'' systematic metaphysics; the henads and the orders of being'),
('SRC_PROCLUS_HIERATIC_ART','Proclus, On the Hieratic Art According to the Greeks (De sacrificio et magia), c. 5th c. CE','','primary text','Proclus'' practical guide to theurgy: cosmic sympathy, symbola and synthemata, the animating of statues'),
('SRC_DISCOURSE_8_9','The Discourse on the Eighth and Ninth (NHC VI.6), c. 2nd-3rd c. CE','','primary text','The Hermetic initiatory ascent of Hermes and Tat into the Ogdoad and the Ennead'),
('SRC_BULL_HERMES','Christian H. Bull, The Tradition of Hermes Trismegistus (Brill, 2018)','','secondary scholarship','The standard study of the Hermetic milieu and the way of Hermes')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- the Hermetic cosmic drama
 ('ENT_HER_POIMANDRES','Poimandres','Hermetic/Theurgic','Revealer','Divine Mind','revelation; the Nous of the Sovereignty; gnosis','Hellenistic-Roman','A','candidate_verified_name','Hermetic revealer (CH I)',0,false,false,'The divine Mind ("Shepherd of Men") who reveals the cosmogony and the way of ascent to Hermes.'),
 ('ENT_HER_DEMIURGE','Demiurge','Hermetic/Theurgic','Demiurgic intellect','Craftsman god','the fashioning of the cosmos; the seven spheres','Hellenistic-Roman','A','candidate_verified_name','Hermetic/Platonic craftsman',0,false,false,'The second Mind, the good craftsman who fashions the cosmos and the seven Governors (CH I; Timaeus).'),
 ('ENT_HER_SEVEN_GOVERNORS','Seven Governors','Hermetic/Theurgic','Planetary ruler collective','Administrators','the planetary spheres; the administration of fate','Hellenistic-Roman','A','candidate_verified_name','Hermetic planetary rulers',0,false,false,'The seven planetary Administrators (Governors) made by the Demiurge, who rule the world through fate.'),
 ('ENT_HER_HEIMARMENE','Heimarmene','Hermetic/Theurgic','Personified fate','Cosmic fate','destiny; the binding of the soul to the spheres','Hellenistic-Roman','A','candidate_verified_name','Hermetic fate',0,false,false,'Fate (Heimarmene), the rule exercised over the lower cosmos through the seven Governors.'),
 ('ENT_HER_OGDOAD','Ogdoad','Hermetic/Theurgic','Celestial sphere','Sphere of ascent','the eighth sphere; the realm above fate; praise','Hellenistic-Roman','A','candidate_verified_name','Hermetic ascent-sphere',0,false,false,'The eighth sphere above the seven Governors, into which the ascending soul rises beyond fate.'),
 ('ENT_HER_ENNEAD','Ennead','Hermetic/Theurgic','Celestial sphere','Sphere of ascent','the ninth sphere; union with the divine Mind','Hellenistic-Roman','A','candidate_verified_name','Hermetic ascent-sphere',0,false,false,'The ninth sphere, the realm of God and the divine powers, the summit of the Hermetic ascent.'),
 -- the Chaldean-theurgic hierarchy
 ('ENT_HER_PATERNAL_INTELLECT','Paternal Intellect','Hermetic/Theurgic','Supreme principle','The Father','the first transcendent Fire; the source of all','Late antique','A','candidate_verified_name','Chaldean supreme principle',0,false,false,'The Father, the first transcendent Intellect (the "Paternal Abyss"/First Fire) of the Chaldean system.'),
 ('ENT_HER_HECATE_CHALDEAN','Hecate (Chaldean)','Hermetic/Theurgic','Cosmic soul','World-Soul / Power','the womb of souls; the mediating Power; Nature','Late antique','A','candidate_verified_name','Chaldean cosmic soul',0,false,false,'The cosmic Hecate of the Chaldean Oracles: the mediating Power between the Fathers and the source of souls.'),
 ('ENT_HER_IYNGES','Iynges','Hermetic/Theurgic','Connective power collective','Transmitting powers','the transmission of the Father''s will; theurgic attraction','Late antique','A','candidate_verified_name','Chaldean connective order',0,false,false,'The Iynges, the "thoughts of the Father" that transmit divine will and are drawn down in theurgy.'),
 ('ENT_HER_SYNOCHEIS','Synocheis','Hermetic/Theurgic','Maintaining power collective','Connectors','the holding-together of the cosmos','Late antique','B','candidate_verified_name','Chaldean maintaining order',0,false,false,'The Synocheis (Connectors), the order of powers that hold the cosmos together.'),
 ('ENT_HER_TELETARCHS','Teletarchs','Hermetic/Theurgic','Initiatory power collective','Rulers of initiation','the governance of the three worlds; initiation','Late antique','B','candidate_verified_name','Chaldean initiatory order',0,false,false,'The Teletarchs (Rulers of Initiation), who govern the empyrean, aetherial and material worlds.'),
 ('ENT_HER_HENADS','Henads','Hermetic/Theurgic','Divine units','The gods as henads','the first multiplicity; the unity of each god','Late antique','A','candidate_verified_name','Proclan henads',0,false,false,'The henads, the supreme unities below the One by which Proclus identifies the gods.'),
 ('ENT_HER_WORLD_SOUL','World Soul','Hermetic/Theurgic','Cosmic soul','Anima Mundi','the animation of the cosmos; the third hypostasis','Late antique','A','candidate_verified_name','Neoplatonic World Soul',0,false,false,'The World Soul, the third Plotinian hypostasis that animates and orders the whole cosmos.'),
 ('ENT_HER_PERSONAL_DAIMON','Personal Daimon','Hermetic/Theurgic','Guardian daimon','Allotted daimon','the guardian of the soul; the guide of ascent','Late antique','A','candidate_verified_name','Iamblichan personal daimon',0,false,false,'The oikeios daimon, each soul''s allotted guardian who governs its life and guides its ascent.'),
 ('ENT_HER_MATERIAL_DAIMONES','Material Daimones','Hermetic/Theurgic','Sublunar daimon collective','Material daimons','the sublunar realm; the binding to matter; the hindering of ascent','Late antique','B','candidate_verified_name','Theurgic sublunar daimons',0,true,false,'The material daimones of the sublunar realm, the "avenging" powers the theurgist must guard against.'),
 ('ENT_HER_ENCOSMIC_GODS','Encosmic Gods','Hermetic/Theurgic','Cosmic god collective','Visible gods','the heavenly bodies; the cosmos as the gods'' activity','Late antique','A','candidate_verified_name','Iamblichan encosmic gods',0,false,false,'The encosmic (visible) gods, the heavenly bodies in which the divine is present through sympathy.'),
 ('ENT_HER_HYPERCOSMIC_GODS','Hypercosmic Gods','Hermetic/Theurgic','Transcendent god collective','Liberated gods','the realm above the cosmos; the leader-gods','Late antique','A','candidate_verified_name','Iamblichan hypercosmic gods',0,false,false,'The hypercosmic (liberated) gods who transcend the cosmos and lead souls up out of it.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_HER_POIMANDRES','SRC_CORPUS_HERMETICUM','Direct attestation','Corpus Hermeticum I (the Poimandres): the divine Mind reveals the cosmogony to Hermes.'),
 ('ENT_HER_POIMANDRES','SRC_BULL_HERMES','Secondary analysis','Bull, The Tradition of Hermes Trismegistus: the Poimandres revelation and the way of Hermes.'),
 ('ENT_HER_DEMIURGE','SRC_CORPUS_HERMETICUM','Direct attestation','Corpus Hermeticum I.9: the Nous brings forth a second Nous, the craftsman (Demiurge), who makes the seven Governors.'),
 ('ENT_HER_SEVEN_GOVERNORS','SRC_CORPUS_HERMETICUM','Direct attestation','Corpus Hermeticum I.9, 14, 25: the seven Governors (Administrators) who encompass the world with fate.'),
 ('ENT_HER_HEIMARMENE','SRC_CORPUS_HERMETICUM','Direct attestation','Corpus Hermeticum I.9, 19; XII: Heimarmene (Fate), exercised through the seven Governors.'),
 ('ENT_HER_OGDOAD','SRC_DISCOURSE_8_9','Direct attestation','The Discourse on the Eighth and Ninth (NHC VI.6); cf. CH I.26: the Ogdoad, the eighth sphere of ascent.'),
 ('ENT_HER_ENNEAD','SRC_DISCOURSE_8_9','Direct attestation','The Discourse on the Eighth and Ninth (NHC VI.6): the Ennead, the ninth sphere of union with God.'),
 ('ENT_HER_PATERNAL_INTELLECT','SRC_CHALDEAN_ORACLES','Direct attestation','Chaldean Oracles fr. 3, 7, 37 (Majercik): the Father, the first transcendent Intellect and Fire.'),
 ('ENT_HER_HECATE_CHALDEAN','SRC_CHALDEAN_ORACLES','Direct attestation','Chaldean Oracles fr. 6, 32, 50-52, 96: Hecate, the mediating Power and the womb from which souls flow.'),
 ('ENT_HER_IYNGES','SRC_CHALDEAN_ORACLES','Direct attestation','Chaldean Oracles fr. 76-78, 87: the Iynges, the "thoughts of the Father" that transmit and attract.'),
 ('ENT_HER_SYNOCHEIS','SRC_CHALDEAN_ORACLES','Direct attestation','Chaldean Oracles fr. 32, 82 (with Proclus): the Synocheis, the Connectors that hold the cosmos together.'),
 ('ENT_HER_TELETARCHS','SRC_CHALDEAN_ORACLES','Direct attestation','Chaldean Oracles fr. 85, 86 (with Proclus, Damascius): the Teletarchs, rulers of the three worlds.'),
 ('ENT_HER_HENADS','SRC_PROCLUS_ELEMENTS','Direct attestation','Proclus, Elements of Theology, props. 113-165: the henads, the divine unities through which the gods are.'),
 ('ENT_HER_WORLD_SOUL','SRC_PLOTINUS_ENNEADS','Direct attestation','Plotinus, Enneads IV.3-4; V.1: the World Soul, the third hypostasis that animates the cosmos.'),
 ('ENT_HER_PERSONAL_DAIMON','SRC_IAMBLICHUS_DE_MYSTERIIS','Direct attestation','Iamblichus, De Mysteriis IX.1-9: the oikeios (personal) daimon allotted to each soul.'),
 ('ENT_HER_MATERIAL_DAIMONES','SRC_IAMBLICHUS_DE_MYSTERIIS','Direct attestation','Iamblichus, De Mysteriis II.5-7; III: the material/sublunar daimones and the avenging powers.'),
 ('ENT_HER_ENCOSMIC_GODS','SRC_PROCLUS_HIERATIC_ART','Direct attestation','Proclus, On the Hieratic Art: the divine is present in cosmic bodies through sympathy and synthemata.'),
 ('ENT_HER_ENCOSMIC_GODS','SRC_IAMBLICHUS_DE_MYSTERIIS','Direct attestation','Iamblichus, De Mysteriis I: the encosmic (visible) gods, the heavenly bodies.'),
 ('ENT_HER_HYPERCOSMIC_GODS','SRC_IAMBLICHUS_DE_MYSTERIIS','Direct attestation','Iamblichus, De Mysteriis: the hypercosmic (liberated) gods above the cosmos who lead souls up.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_HER_POIMANDRES','identified_with','ENT_HER_NOUS','high','Poimandres names himself "the Nous of the Sovereignty" (CH I.2).','SRC_CORPUS_HERMETICUM','reviewed'),
 ('ENT_HER_TRISMEGISTUS','taught_by','ENT_HER_POIMANDRES','high','Poimandres reveals the cosmogony and the way of ascent to Hermes (CH I).','SRC_CORPUS_HERMETICUM','reviewed'),
 ('ENT_HER_DEMIURGE','emanates_from','ENT_HER_NOUS','high','The Demiurge is the second Mind brought forth by the first Nous (CH I.9).','SRC_CORPUS_HERMETICUM','reviewed'),
 ('ENT_HER_DEMIURGE','creator_of','ENT_HER_SEVEN_GOVERNORS','high','The Demiurge fashions the seven Governors who encompass the cosmos (CH I.9).','SRC_CORPUS_HERMETICUM','reviewed'),
 ('ENT_HER_HEIMARMENE','embodies','ENT_FATE','high','Heimarmene is Fate personified.','SRC_CORPUS_HERMETICUM','reviewed'),
 ('ENT_HER_HEIMARMENE','mediated_by','ENT_HER_SEVEN_GOVERNORS','high','Fate is exercised over the lower world through the seven Governors (CH I.9).','SRC_CORPUS_HERMETICUM','reviewed'),
 ('ENT_HER_ENNEAD','aligned_with','ENT_HER_OGDOAD','high','The Ogdoad and the Ennead are the paired summits of the Hermetic ascent.','SRC_DISCOURSE_8_9','reviewed'),
 ('ENT_HER_HECATE_CHALDEAN','emanates_from','ENT_HER_PATERNAL_INTELLECT','high','The cosmic Hecate proceeds as the Power between the first Father and the second Intellect.','SRC_CHALDEAN_ORACLES','reviewed'),
 ('ENT_HER_HECATE_CHALDEAN','reception_of','ENT_HECATE','high','The Chaldean cosmic Hecate develops the Greek goddess Hecate into a metaphysical World-Soul.','SRC_CHALDEAN_ORACLES','reviewed'),
 ('ENT_HER_WORLD_SOUL','emanates_from','ENT_HER_HECATE_CHALDEAN','medium','In the Chaldean system souls flow from the cosmic Hecate, the source of the World Soul.','SRC_CHALDEAN_ORACLES','reviewed'),
 ('ENT_HER_IYNGES','emanates_from','ENT_HER_PATERNAL_INTELLECT','high','The Iynges are the thoughts of the Father (Chaldean Oracles fr. 77).','SRC_CHALDEAN_ORACLES','reviewed'),
 ('ENT_HER_SYNOCHEIS','aligned_with','ENT_HER_IYNGES','medium','The Synocheis stand with the Iynges among the Chaldean mediating orders.','SRC_CHALDEAN_ORACLES','reviewed'),
 ('ENT_HER_TELETARCHS','aligned_with','ENT_HER_SYNOCHEIS','medium','The Teletarchs complete the triad of Chaldean mediating orders with the Synocheis.','SRC_CHALDEAN_ORACLES','reviewed'),
 ('ENT_HER_HENADS','emanates_from','ENT_HER_THE_ONE','high','The henads are the first divine multiplicity proceeding from the One (Proclus, ET 113ff).','SRC_PROCLUS_ELEMENTS','reviewed'),
 ('ENT_HER_WORLD_SOUL','emanates_from','ENT_HER_NOUS','high','The World Soul proceeds from Intellect, the third from the second hypostasis (Plotinus).','SRC_PLOTINUS_ENNEADS','reviewed'),
 ('ENT_HER_PERSONAL_DAIMON','emanates_from','ENT_HER_ENCOSMIC_GODS','medium','The personal daimon is allotted to each soul from the cosmic order (De Myst. IX.6).','SRC_IAMBLICHUS_DE_MYSTERIIS','reviewed'),
 ('ENT_HER_MATERIAL_DAIMONES','ruled_by','ENT_HER_HECATE_CHALDEAN','medium','The material/sublunar daimones are ranged under Hecate in the Chaldean-theurgic schema.','SRC_CHALDEAN_ORACLES','reviewed'),
 ('ENT_HER_MATERIAL_DAIMONES','aligned_with','ENT_HER_HEIMARMENE','medium','The material daimones bind the soul to matter and fate.','SRC_IAMBLICHUS_DE_MYSTERIIS','reviewed'),
 ('ENT_HER_ENCOSMIC_GODS','aligned_with','ENT_HER_SEVEN_GOVERNORS','medium','The encosmic gods include the planetary powers, akin to the Hermetic Governors.','SRC_IAMBLICHUS_DE_MYSTERIIS','reviewed'),
 ('ENT_HER_ENCOSMIC_GODS','ruled_by','ENT_HER_HYPERCOSMIC_GODS','medium','The hypercosmic gods lead and transcend the encosmic gods (Iamblichus).','SRC_IAMBLICHUS_DE_MYSTERIIS','reviewed'),
 -- the Gnostic Demiurge as a polemical reception/inversion of the Platonic-Hermetic craftsman
 ('ENT_GNO_DEMIURGE','reception_of','ENT_HER_DEMIURGE','medium','The Gnostic Demiurge (Yaldabaoth) is a polemical inversion of the good Platonic-Hermetic craftsman.','SRC_BULL_HERMES','reviewed')
ON CONFLICT DO NOTHING;

-- ── Duplicate-name discipline: Demiurge, Heimarmene, Hecate, Ogdoad now span traditions ─
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Demiurge','ENT_HER_DEMIURGE','Reviewed duplicate canonical name; the good Hermetic/Platonic craftsman, distinct from the Gnostic Demiurge.','intentional_distinct'),
 ('Demiurge','ENT_GNO_DEMIURGE','Reviewed duplicate canonical name; the Gnostic Demiurge (Yaldabaoth), distinct from the Hermetic/Platonic craftsman.','intentional_distinct'),
 ('Heimarmene','ENT_HER_HEIMARMENE','Reviewed duplicate canonical name; the Hermetic Fate of the seven Governors, distinct from the Sethian Heimarmene.','intentional_distinct'),
 ('Heimarmene','ENT_SET_HEIMARMENE','Reviewed duplicate canonical name; the Sethian Heimarmene, distinct from the Hermetic Fate.','intentional_distinct'),
 ('Hecate','ENT_HER_HECATE_CHALDEAN','Reviewed duplicate canonical name; the Chaldean cosmic Hecate (World-Soul), distinct from the Greek goddess.','intentional_distinct'),
 ('Hecate','ENT_HECATE','Reviewed duplicate canonical name; the Greek goddess Hecate, distinct from the Chaldean cosmic Hecate.','intentional_distinct'),
 ('Ogdoad','ENT_HER_OGDOAD','Reviewed duplicate canonical name; the Hermetic eighth sphere of ascent, distinct from the Egyptian and Ophite Ogdoads.','intentional_distinct'),
 ('Ogdoad','ENT_EGY_OGDOAD','Reviewed duplicate canonical name; the Hermopolitan Ogdoad, distinct from the Hermetic and Ophite Ogdoads.','intentional_distinct'),
 ('Ogdoad','ENT_OPH_OGDOAD','Reviewed duplicate canonical name; the Ophite Ogdoad, distinct from the Egyptian and Hermetic Ogdoads.','intentional_distinct')
ON CONFLICT (canonical_name, entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Hermetic/Theurgic entities' AS label, count(*) FROM entities WHERE tradition='Hermetic/Theurgic';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
