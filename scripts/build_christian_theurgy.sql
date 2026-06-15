-- =====================================================================
-- build_christian_theurgy.sql  (v1.57.0)
-- Content build-out: the Pseudo-Dionysian / Christian-theurgic layer.
--
-- Bridges the Hermetic/Theurgic (Iamblichus/Proclus) bloc and the
-- Christian bloc via the Corpus Dionysiacum (c. 500 CE):
--   * the nine angelic orders organized into Dionysius's three celestial
--     triads (the existing ENT_CHR_* orders are wired in, not duplicated);
--   * the Ecclesiastical Hierarchy (clergy + initiate triads + the three
--     sacraments-as-theurgiai);
--   * the theology — the Thearchy, the Divine Names (cataphatic), the
--     Divine Darkness (apophatic), deification (theosis), procession/return.
--
-- Cross-tradition reception_of edges realise the user's own thesis (Theurgy
-- Study Group): the Dionysian hierarchy as Christian reception of the
-- Iamblichan Hypercosmic/Encosmic gods, and theosis as heir to theurgic
-- henosis (later systematised by Palamas' uncreated energies).
--
-- Sources: the Parker translation (The Works of Dionysius the Areopagite,
-- 1897, public domain) + Rorem's commentary + Shaw, Theurgy and the Soul.
-- Tradition tag: 'Christian/Theurgic'.  Id prefix: ENT_DIO_.
-- Additive; ON CONFLICT DO NOTHING throughout; verify block at the end.
-- =====================================================================

BEGIN;

-- ---------------------------------------------------------------------
-- (a) SOURCES  (3 remaining treatises of the corpus + 2 scholarly editions)
-- ---------------------------------------------------------------------
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
  ('SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES',
   'Pseudo-Dionysius the Areopagite, On the Divine Names (Peri theion onomaton), c. 500 CE (trans. J. Parker, The Works of Dionysius the Areopagite, 1897)',
   'https://archive.org/details/worksofdionysius00pseu', 'primary text', 'Pseudo-Dionysian corpus'),
  ('SRC_PSEUDO_DIONYSIUS_MYSTICAL_THEOLOGY',
   'Pseudo-Dionysius the Areopagite, The Mystical Theology (Peri mystikes theologias), c. 500 CE (trans. J. Parker, 1897)',
   'https://archive.org/details/worksofdionysius00pseu', 'primary text', 'Pseudo-Dionysian corpus'),
  ('SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY',
   'Pseudo-Dionysius the Areopagite, The Ecclesiastical Hierarchy (Peri tes ekklesiastikes hierarchias), c. 500 CE (trans. J. Parker, 1897)',
   'https://archive.org/details/worksofdionysius00pseu', 'primary text', 'Pseudo-Dionysian corpus'),
  ('SRC_ROREM_DIONYSIUS',
   'Paul Rorem, Pseudo-Dionysius: A Commentary on the Texts and an Introduction to Their Influence (Oxford Univ. Press, 1993)',
   NULL, 'secondary scholarship', 'Pseudo-Dionysian studies'),
  ('SRC_SHAW_THEURGY_SOUL',
   'Gregory Shaw, Theurgy and the Soul: The Neoplatonism of Iamblichus (Penn State Univ. Press, 1995)',
   'https://archive.org/details/theurgysoulneopl0000greg', 'secondary scholarship', 'Neoplatonic theurgy')
ON CONFLICT (source_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (b) ENTITIES  (20 new; tradition 'Christian/Theurgic')
-- ---------------------------------------------------------------------
INSERT INTO entities
  (entity_id, canonical_name, greek_name, tradition, entity_type, category,
   primary_domains, cult_scope, evidence_confidence, review_status,
   inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
-- --- Celestial Hierarchy (structural collectives) ---
 ('ENT_DIO_CELESTIAL_HIERARCHY','The Celestial Hierarchy','ἡ οὐρανία ἱεραρχία','Christian/Theurgic','Angelic hierarchy','Ninefold angelic order',
  'the nine angelic orders in three triads; mediation of divine light; anagogic ascent','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'Pseudo-Dionysius''s ordering of the angels into three triads, each purifying, illuminating, and perfecting the rank below; the heavenly archetype of all hierarchy.'),
 ('ENT_DIO_FIRST_TRIAD','First Celestial Triad (Seraphim, Cherubim, Thrones)','πρώτη διακόσμησις','Christian/Theurgic','Angelic triad','Highest celestial triad',
  'immediate encircling of God; deifying knowledge; perfection','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'Highest triad set immediately around the Thearchy, illuminated directly by God: burning love (Seraphim), fullness of knowledge (Cherubim), steadfast bearing of God (Thrones).'),
 ('ENT_DIO_SECOND_TRIAD','Second Celestial Triad (Dominions, Virtues, Powers)','μέση διακόσμησις','Christian/Theurgic','Angelic triad','Middle celestial triad',
  'lordship; divine power; cosmic order','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'Middle triad, illuminated by the first and ordering the cosmos: unfettered lordship (Dominions), virile power for deiform ascent (Virtues), ordered authority (Powers).'),
 ('ENT_DIO_THIRD_TRIAD','Third Celestial Triad (Principalities, Archangels, Angels)','τελευταία διακόσμησις','Christian/Theurgic','Angelic triad','Lowest celestial triad',
  'governance of nations; revelation; mediation to humanity','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'Lowest triad, nearest the world, mediating the divine light to humankind: princely order (Principalities), bearing of revelation (Archangels), direct messenger-service (Angels).'),
-- --- Ecclesiastical Hierarchy ---
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY','The Ecclesiastical Hierarchy','ἡ ἐκκλησιαστικὴ ἱεραρχία','Christian/Theurgic','Sacramental hierarchy','Earthly hierarchy',
  'the church as image of heaven; sacraments; clergy and initiate orders','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The earthly hierarchy that images the celestial one: three sacred rites and two triads of ministers and initiates by which the soul is purified, illuminated, and perfected toward God.'),
 ('ENT_DIO_HIERARCHS','Hierarchs (Bishops)','ἱεράρχαι','Christian/Theurgic','Clergy order','Perfecting clergy order',
  'consecration; perfection; summit of the sacred ministry','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The highest clerical order, the perfecting rank that consecrates the sacraments and completes initiation; the human analogue of the perfecting power in heaven.'),
 ('ENT_DIO_PRIESTS','Sacred Priests (Hiereis)','ἱερεῖς','Christian/Theurgic','Clergy order','Illuminating clergy order',
  'illumination; the sacred mysteries; teaching','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The middle clerical order, the illuminating rank that brings the initiated into the light of the mysteries under the hierarch.'),
 ('ENT_DIO_DEACONS','Deacons (Leitourgoi)','λειτουργοί','Christian/Theurgic','Clergy order','Purifying clergy order',
  'purification; cleansing of the uninitiated; sacred service','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The lowest clerical order, the purifying rank (the "liturgists") that cleanses and separates the unready before illumination.'),
 ('ENT_DIO_MONKS','Monks (Therapeutae)','θεραπευταί / μονάζοντες','Christian/Theurgic','Initiate order','Perfected lay order',
  'the undivided life; contemplative perfection; service of the One','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The highest order of the initiated, the "perfected" who pursue the single, undivided life of contemplation gathered toward the One.'),
 ('ENT_DIO_HOLY_PEOPLE','Holy People (Contemplative Laity)','ἱερὸς λαός','Christian/Theurgic','Initiate order','Illuminated lay order',
  'the contemplating faithful; reception of the mysteries','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The middle order of the initiated, the faithful laity admitted to the illumination of the sacred mysteries.'),
 ('ENT_DIO_PURIFIED_ORDERS','The Purified (Catechumens, Energumens, Penitents)','οἱ καθαιρόμενοι','Christian/Theurgic','Initiate order','Purified lay order',
  'those undergoing purification; catechumens; penitents; the possessed','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The lowest order, those still being purified — catechumens, penitents, and energumens — kept outside the synaxis until cleansed.'),
-- --- the sacraments as theurgiai ---
 ('ENT_DIO_SACRAMENT_ILLUMINATION','Illumination (Photismos / Baptism)','φωτισμός','Christian/Theurgic','Ritual category','Sacrament of initiation',
  'baptismal rebirth; enlightenment; entry into the hierarchy','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'Baptism understood as "illumination" (photismos), the divine birth that opens the initiate to every other sacred rite; the first of the Dionysian theurgies (theourgiai).'),
 ('ENT_DIO_SACRAMENT_SYNAXIS','Synaxis (the Eucharist)','σύναξις','Christian/Theurgic','Ritual category','Sacrament of communion',
  'gathering into unity; communion; the sacrament of sacraments','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The Eucharistic "gathering" (synaxis), called by Dionysius the sacrament of sacraments, uniting the divided initiate to the One; the centre of Christian theurgy.'),
 ('ENT_DIO_SACRAMENT_MYRON','Consecration of the Myron (Chrism)','μύρον','Christian/Theurgic','Ritual category','Sacrament of consecration',
  'consecration; the fragrant ointment; perfecting anointing','liturgical','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The consecration of the holy ointment (myron/chrism), a perfecting theurgy that sanctifies both altar and initiate.'),
-- --- the theology (apex + cataphatic/apophatic + dynamics) ---
 ('ENT_DIO_THEARCHY','The Thearchy (Godhead)','ἡ θεαρχία','Christian/Theurgic','Supreme principle','Superessential Godhead',
  'the triune source of all divinity; the superessential One; origin of every hierarchy','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'Dionysius''s term for the divine source — the superessential, triune Godhead (thearchia) beyond being, from which all hierarchy proceeds and to which it returns.'),
 ('ENT_DIO_DIVINE_NAMES','The Divine Names','τὰ θεῖα ὀνόματα','Christian/Theurgic','Theological category','Cataphatic theology',
  'the names predicated of God; Good, Being, Life, Wisdom, Light, Beauty, Love','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The cataphatic catalogue of names by which Scripture praises the Thearchy through its beneficent processions into creation — Good, Being, Life, Wisdom, Power, Beauty, Love, and the rest.'),
 ('ENT_DIO_THE_GOOD','The Good (Agathon)','τὸ ἀγαθόν','Christian/Theurgic','Divine name/principle','Chief divine name',
  'the supreme Good; source of all procession; the chief name of God','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The first and most fitting of the Divine Names: the Good (after Plato and Plotinus), prior even to Being — the overflowing source from which all things proceed and to which all return.'),
 ('ENT_DIO_DIVINE_DARKNESS','The Divine Darkness (Gnophos)','ὁ θεῖος γνόφος','Christian/Theurgic','Apophatic mystery','Negative theology',
  'the super-luminous darkness; unknowing; union beyond knowledge','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The apophatic summit of the Mystical Theology: the "ray of divine darkness" into which the soul ascends by unknowing, leaving all sense and intellect to be united to the unknowable God.'),
 ('ENT_DIO_THEOSIS','Deification (Theosis)','θέωσις','Christian/Theurgic','Mystical process/category','Goal of hierarchy',
  'assimilation to and union with God; the goal of every hierarchy; deification','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'Dionysius''s stated goal of all hierarchy — "assimilation to and union with God so far as is attainable" — the Christian-theurgic deification later systematised as the Orthodox doctrine of theosis.'),
 ('ENT_DIO_PROCESSION_RETURN','Procession and Return (Proodos and Epistrophe)','πρόοδος καὶ ἐπιστροφή','Christian/Theurgic','Cosmological process','Emanative dynamic',
  'the outflow of all from the Good and its return; the rhythm of hierarchy','pan-Christian','A','candidate_verified_name',
  'Pseudo-Dionysian corpus',0,false,false,
  'The Neoplatonic rhythm by which all things flow out from the Good (proodos) and are drawn back to it (epistrophe); the dynamic structuring every Dionysian hierarchy. Received from Proclus.')
ON CONFLICT (entity_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (c) ENTITY_SOURCES  (each entity -> its primary locus; controlled evidence_type)
-- ---------------------------------------------------------------------
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_DIO_CELESTIAL_HIERARCHY','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','direct attestation','Celestial Hierarchy 6-9 (the three triads).'),
 ('ENT_DIO_FIRST_TRIAD','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','direct attestation','Celestial Hierarchy 7.'),
 ('ENT_DIO_SECOND_TRIAD','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','direct attestation','Celestial Hierarchy 8.'),
 ('ENT_DIO_THIRD_TRIAD','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','direct attestation','Celestial Hierarchy 9.'),
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 1 (the church as image of the celestial hierarchy).'),
 ('ENT_DIO_HIERARCHS','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 5 (the orders of clergy).'),
 ('ENT_DIO_PRIESTS','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 5.'),
 ('ENT_DIO_DEACONS','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 5 (the leitourgoi/purifiers).'),
 ('ENT_DIO_MONKS','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 6 (the orders of the initiated).'),
 ('ENT_DIO_HOLY_PEOPLE','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 6.'),
 ('ENT_DIO_PURIFIED_ORDERS','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 6 (catechumens, energumens, penitents).'),
 ('ENT_DIO_SACRAMENT_ILLUMINATION','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 2 (the mystery of illumination / baptism).'),
 ('ENT_DIO_SACRAMENT_SYNAXIS','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 3 (the synaxis / Eucharist).'),
 ('ENT_DIO_SACRAMENT_MYRON','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 4 (the consecration of the myron).'),
 ('ENT_DIO_THEARCHY','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','direct attestation','Divine Names 1-2 (the superessential thearchy).'),
 ('ENT_DIO_DIVINE_NAMES','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','direct attestation','Divine Names (the treatise as a whole).'),
 ('ENT_DIO_THE_GOOD','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','direct attestation','Divine Names 4 (the Good as the chief name).'),
 ('ENT_DIO_DIVINE_DARKNESS','SRC_PSEUDO_DIONYSIUS_MYSTICAL_THEOLOGY','direct attestation','Mystical Theology 1 (the ray of divine darkness).'),
 ('ENT_DIO_THEOSIS','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','direct attestation','Ecclesiastical Hierarchy 1.3 (hierarchy''s goal: assimilation to and union with God).'),
 ('ENT_DIO_THEOSIS','SRC_SHAW_THEURGY_SOUL','scholarly attestation','On theurgic henosis as the antecedent of Christian theosis.'),
 ('ENT_DIO_PROCESSION_RETURN','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','direct attestation','Divine Names 4 (procession of the Good and the return of all to it).'),
 ('ENT_DIO_PROCESSION_RETURN','SRC_PROCLUS_ELEMENTS','scholarly attestation','Proclus, Elements of Theology props. 25-39 (mone/proodos/epistrophe).'),
 -- the corpus-level commentary attaches to the two hierarchy collectives
 ('ENT_DIO_CELESTIAL_HIERARCHY','SRC_ROREM_DIONYSIUS','scholarly attestation','Rorem, Commentary, on the Celestial Hierarchy.'),
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY','SRC_ROREM_DIONYSIUS','scholarly attestation','Rorem, Commentary, on the Ecclesiastical Hierarchy.')
ON CONFLICT (entity_id, source_id, evidence_type) DO NOTHING;

-- also ensure the lowest angelic order carries the Celestial Hierarchy source
-- (the other eight orders already cite it; ENT_CHR_ANGELS did not)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_CHR_ANGELS','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','direct attestation','Celestial Hierarchy 9 (Angels as the ninth and lowest order).')
ON CONFLICT (entity_id, source_id, evidence_type) DO NOTHING;

-- ---------------------------------------------------------------------
-- (d) ENTITY_PERIODS  (composed in Late Antiquity; received into Orthodoxy)
-- ---------------------------------------------------------------------
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_LATE_ANTIQUE', 'A',
       'Pseudo-Dionysian corpus composed c. 500 CE (Late Antiquity).',
       'SRC_ROREM_DIONYSIUS', 'reviewed'
FROM (VALUES
 ('ENT_DIO_CELESTIAL_HIERARCHY'),('ENT_DIO_FIRST_TRIAD'),('ENT_DIO_SECOND_TRIAD'),('ENT_DIO_THIRD_TRIAD'),
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY'),('ENT_DIO_HIERARCHS'),('ENT_DIO_PRIESTS'),('ENT_DIO_DEACONS'),
 ('ENT_DIO_MONKS'),('ENT_DIO_HOLY_PEOPLE'),('ENT_DIO_PURIFIED_ORDERS'),
 ('ENT_DIO_SACRAMENT_ILLUMINATION'),('ENT_DIO_SACRAMENT_SYNAXIS'),('ENT_DIO_SACRAMENT_MYRON'),
 ('ENT_DIO_THEARCHY'),('ENT_DIO_DIVINE_NAMES'),('ENT_DIO_THE_GOOD'),('ENT_DIO_DIVINE_DARKNESS'),
 ('ENT_DIO_THEOSIS'),('ENT_DIO_PROCESSION_RETURN')
) AS t(e)
ON CONFLICT (entity_id, period_id) DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_EAST_ORTHODOX', 'A',
       'Corpus Dionysiacum received as authoritative throughout Byzantine/Orthodox theology.',
       'SRC_ROREM_DIONYSIUS', 'reviewed'
FROM (VALUES
 ('ENT_DIO_CELESTIAL_HIERARCHY'),('ENT_DIO_FIRST_TRIAD'),('ENT_DIO_SECOND_TRIAD'),('ENT_DIO_THIRD_TRIAD'),
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY'),('ENT_DIO_HIERARCHS'),('ENT_DIO_PRIESTS'),('ENT_DIO_DEACONS'),
 ('ENT_DIO_MONKS'),('ENT_DIO_HOLY_PEOPLE'),('ENT_DIO_PURIFIED_ORDERS'),
 ('ENT_DIO_SACRAMENT_ILLUMINATION'),('ENT_DIO_SACRAMENT_SYNAXIS'),('ENT_DIO_SACRAMENT_MYRON'),
 ('ENT_DIO_THEARCHY'),('ENT_DIO_DIVINE_NAMES'),('ENT_DIO_THE_GOOD'),('ENT_DIO_DIVINE_DARKNESS'),
 ('ENT_DIO_THEOSIS'),('ENT_DIO_PROCESSION_RETURN')
) AS t(e)
ON CONFLICT (entity_id, period_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (e) ENTITY_RELATIONSHIPS  (wire the hierarchy as a graph)
-- ---------------------------------------------------------------------
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
VALUES
-- celestial: triads belong to the hierarchy
 ('ENT_DIO_FIRST_TRIAD','member_of','ENT_DIO_CELESTIAL_HIERARCHY','high','First of the three celestial triads.','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_DIO_SECOND_TRIAD','member_of','ENT_DIO_CELESTIAL_HIERARCHY','high','Middle celestial triad.','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_DIO_THIRD_TRIAD','member_of','ENT_DIO_CELESTIAL_HIERARCHY','high','Lowest celestial triad.','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
-- celestial: the nine existing orders into their triads
 ('ENT_CHR_SERAPHIM','member_of','ENT_DIO_FIRST_TRIAD','high','Seraphim head the first triad (CH 7).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_CHERUBIM','member_of','ENT_DIO_FIRST_TRIAD','high','Cherubim in the first triad (CH 7).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_THRONES','member_of','ENT_DIO_FIRST_TRIAD','high','Thrones in the first triad (CH 7).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_DOMINIONS','member_of','ENT_DIO_SECOND_TRIAD','high','Dominions head the second triad (CH 8).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_VIRTUES','member_of','ENT_DIO_SECOND_TRIAD','high','Virtues in the second triad (CH 8).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_POWERS','member_of','ENT_DIO_SECOND_TRIAD','high','Powers in the second triad (CH 8).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_PRINCIPALITIES','member_of','ENT_DIO_THIRD_TRIAD','high','Principalities head the third triad (CH 9).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_ARCHANGELS','member_of','ENT_DIO_THIRD_TRIAD','high','Archangels in the third triad (CH 9).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_CHR_ANGELS','member_of','ENT_DIO_THIRD_TRIAD','high','Angels are the ninth and lowest order (CH 9).','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
-- celestial: downward mediation of light
 ('ENT_DIO_FIRST_TRIAD','transmits','ENT_DIO_SECOND_TRIAD','high','The first triad transmits divine illumination to the second.','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_DIO_SECOND_TRIAD','transmits','ENT_DIO_THIRD_TRIAD','high','The second triad transmits illumination to the third.','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
-- celestial: emanation from the source
 ('ENT_DIO_CELESTIAL_HIERARCHY','emanates_from','ENT_DIO_THEARCHY','high','The whole hierarchy proceeds from the superessential Thearchy.','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
 ('ENT_DIO_FIRST_TRIAD','emanates_from','ENT_DIO_THEARCHY','high','The first triad is illuminated immediately by God.','SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY','reviewed'),
-- the cross-tradition reception bridge (the user's own thesis)
 ('ENT_DIO_CELESTIAL_HIERARCHY','reception_of','ENT_HER_HYPERCOSMIC_GODS','high','Christianisation of the Iamblichan/Proclan graded chain of mediating divine ranks.','SRC_SHAW_THEURGY_SOUL','reviewed'),
 ('ENT_DIO_CELESTIAL_HIERARCHY','reception_of','ENT_HER_ENCOSMIC_GODS','medium','The lower orders mirror the encosmic (cosmos-governing) gods of the Neoplatonic chain.','SRC_SHAW_THEURGY_SOUL','reviewed'),
 ('ENT_DIO_THEARCHY','reception_of','ENT_HER_THE_ONE','high','The superessential Godhead-beyond-being is the Christian reception of the Neoplatonic One.','SRC_ROREM_DIONYSIUS','reviewed'),
 ('ENT_DIO_DIVINE_DARKNESS','reception_of','ENT_HER_THE_ONE','high','Apophatic union by unknowing receives the Neoplatonic ineffability of the One.','SRC_ROREM_DIONYSIUS','reviewed'),
 ('ENT_DIO_PROCESSION_RETURN','reception_of','ENT_HER_THE_ONE','medium','Procession from and return to the One/Good, received from Proclus.','SRC_PROCLUS_ELEMENTS','reviewed'),
-- the Thearchy and the Christian godhead
 ('ENT_DIO_THEARCHY','identified_with','ENT_CHR_GOD_FATHER','high','The thearchy denotes the triune Godhead as superessential source; linked here to the Christian godhead.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
-- divine names: cataphatic theology
 ('ENT_DIO_THE_GOOD','member_of','ENT_DIO_DIVINE_NAMES','high','The Good is the first and chief of the Divine Names.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_DIVINE_NAMES','reveals','ENT_DIO_THEARCHY','high','The names manifest the otherwise unknowable Thearchy through its processions.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_DIVINE_NAMES','embodies','ENT_BEAUTY','high','Beauty is among the names predicated of God.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_DIVINE_NAMES','embodies','ENT_LIGHT','high','Light is among the Divine Names.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_DIVINE_NAMES','embodies','ENT_LIFE','high','Life is among the Divine Names.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_DIVINE_NAMES','embodies','ENT_LOVE','high','Love (eros/agape) is among the Divine Names.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_DIVINE_NAMES','embodies','ENT_WISDOM','high','Wisdom is among the Divine Names.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_DIVINE_NAMES','embodies','ENT_TRUTH','high','Truth is among the Divine Names.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_THE_GOOD','aligned_with','ENT_HER_THE_ONE','high','The Good (prior to being) corresponds to the Neoplatonic One/Good.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
-- apophatic
 ('ENT_DIO_DIVINE_DARKNESS','symbolizes','ENT_DIO_THEARCHY','high','The super-luminous darkness symbolises the unknowable Godhead.','SRC_PSEUDO_DIONYSIUS_MYSTICAL_THEOLOGY','reviewed'),
-- procession/return dynamics
 ('ENT_DIO_PROCESSION_RETURN','emanates_from','ENT_DIO_THE_GOOD','high','All things proceed (proodos) from the Good and return (epistrophe) to it.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_CELESTIAL_HIERARCHY','undergoes_process','ENT_DIO_PROCESSION_RETURN','high','The hierarchy is structured by procession and return.','SRC_PSEUDO_DIONYSIUS_DIVINE_NAMES','reviewed'),
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY','undergoes_process','ENT_DIO_PROCESSION_RETURN','high','The earthly hierarchy too enacts procession and return.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
-- ecclesiastical: orders belong to the hierarchy
 ('ENT_DIO_HIERARCHS','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','The hierarchs are the perfecting clergy order.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_PRIESTS','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','The priests are the illuminating clergy order.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_DEACONS','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','The deacons are the purifying clergy order.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_MONKS','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','Monks are the perfected order of the initiated.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_HOLY_PEOPLE','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','The holy people are the illuminated lay order.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_PURIFIED_ORDERS','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','The purified are the lowest, still-being-cleansed order.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
-- ecclesiastical: clergy descent and operations on the initiates
 ('ENT_DIO_HIERARCHS','transmits','ENT_DIO_PRIESTS','high','The hierarch transmits the sacred light to the priests.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_PRIESTS','transmits','ENT_DIO_DEACONS','high','The priests transmit to the deacons.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_HIERARCHS','presides_over','ENT_DIO_MONKS','high','The hierarch perfects the order of monks.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_PRIESTS','presides_over','ENT_DIO_HOLY_PEOPLE','high','The priests illuminate the holy people.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_DEACONS','presides_over','ENT_DIO_PURIFIED_ORDERS','high','The deacons purify the catechumens, energumens, and penitents.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
-- ecclesiastical mirrors celestial
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY','symbolizes','ENT_DIO_CELESTIAL_HIERARCHY','high','The church is the sensible image of the celestial hierarchy.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_CELESTIAL_HIERARCHY','transmits','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','Divine light passes from the heavenly to the earthly hierarchy.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY','emanates_from','ENT_DIO_THEARCHY','high','The ecclesiastical hierarchy also proceeds from the one Thearchy.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
-- sacraments
 ('ENT_DIO_SACRAMENT_ILLUMINATION','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','Illumination/baptism is the first sacred rite of the hierarchy.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_SACRAMENT_SYNAXIS','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','The synaxis is the central sacred rite.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_SACRAMENT_MYRON','member_of','ENT_DIO_ECCLESIASTICAL_HIERARCHY','high','The consecration of the myron is a perfecting rite.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_HIERARCHS','presides_over','ENT_DIO_SACRAMENT_SYNAXIS','high','The hierarch celebrates the synaxis.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_HIERARCHS','presides_over','ENT_DIO_SACRAMENT_MYRON','high','The hierarch consecrates the myron.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_SACRAMENT_ILLUMINATION','ritual_associated_with','ENT_DIO_PURIFIED_ORDERS','high','Baptismal illumination initiates those being purified into the hierarchy.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_SACRAMENT_ILLUMINATION','reception_of','ENT_BAPTISM','high','The Dionysian "illumination" is the theurgic reading of Christian baptism.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
-- theosis: the goal, and the bridge to Orthodox theosis
 ('ENT_DIO_THEOSIS','aligned_with','ENT_VAL_HENOSIS','high','Deification is the Christian analogue of theurgic/mystical henosis (union).','SRC_SHAW_THEURGY_SOUL','reviewed'),
 ('ENT_DIO_THEOSIS','aligned_with','ENT_ORTH_UNCREATED_LIGHT','high','Dionysian deification later systematised by Palamas as participation in the uncreated energies.','SRC_ROREM_DIONYSIUS','reviewed'),
 ('ENT_DIO_CELESTIAL_HIERARCHY','undergoes_process','ENT_DIO_THEOSIS','medium','The aim of every hierarchy is the deification of its members.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed'),
 ('ENT_DIO_ECCLESIASTICAL_HIERARCHY','undergoes_process','ENT_DIO_THEOSIS','high','The ecclesiastical hierarchy exists to lead the soul to deification.','SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (f) HOMONYMS: none introduced.  All new canonical_names are unique; the
--     nine angelic orders and the abstractions (Beauty/Light/Life/Love/
--     Wisdom/Truth) are REUSED, not duplicated.  Nothing to register.
-- ---------------------------------------------------------------------

COMMIT;

-- ---------------------------------------------------------------------
-- (g) VERIFY  (expect: 20 new entities, all sourced + period-linked,
--     0 unresolved / 0 dup-pairs / 0 unreviewed_duplicates)
-- ---------------------------------------------------------------------
\echo '== new Christian/Theurgic entities =='
SELECT count(*) AS dio_entities FROM entities WHERE entity_id LIKE 'ENT_DIO_%';
\echo '== any ENT_DIO_ entity missing a source? (expect 0) =='
SELECT count(*) AS unsourced_dio FROM entities e
 WHERE e.entity_id LIKE 'ENT_DIO_%'
   AND NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id = e.entity_id);
\echo '== any ENT_DIO_ entity missing a period link? (expect 0) =='
SELECT count(*) AS undated_dio FROM entities e
 WHERE e.entity_id LIKE 'ENT_DIO_%'
   AND NOT EXISTS (SELECT 1 FROM entity_periods p WHERE p.entity_id = e.entity_id);
\echo '== new relationships touching ENT_DIO_ =='
SELECT count(*) AS dio_relationships FROM entity_relationships
 WHERE subject_entity_id LIKE 'ENT_DIO_%' OR object_entity_id LIKE 'ENT_DIO_%';
\echo '== whole-DB integrity (expect 0 / 0 across the board) =='
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
\echo '== unsourced entities + dup source-pairs (expect 0 / 0) =='
SELECT (SELECT count(*) FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id)) AS unsourced_total,
       (SELECT count(*) FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY entity_id, source_id HAVING count(*)>1) d) AS dup_source_pairs;
