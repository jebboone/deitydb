-- =====================================================================
-- deepen_etruscan_semitic.sql  (v1.59.0 batch)
-- Etruscan 12 -> ~31; Canaanite/Ugaritic 14 -> ~23; Phoenician 4 -> ~12.
-- Etruscan: the Liver of Piacenza pantheon + the labelled mirror corpus.
-- Ugaritic: the Baal Cycle daughters, the dawn/dusk twins, healing/astral gods.
-- Phoenician: the distinct Phoenician/Punic cult gods (Philo + inscriptions);
--   deities already held under Canaanite (El, Astarte, Resheph...) NOT duplicated.
-- Cross-tradition homonyms (Adonis, Athtar) registered intentional_distinct.
-- Additive; ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_DEGRUMMOND_ETRUSCAN','Nancy Thomson de Grummond, Etruscan Myth, Sacred History and Legend (Univ. of Pennsylvania Museum, 2006)',NULL,'secondary scholarship','Etruscan religion'),
 ('SRC_LIVER_PIACENZA','The Liver of Piacenza (bronze model liver, c. 100 BCE) with the names of the Etruscan gods of the templum',NULL,'primary inscription/artifact','Etruscan divination'),
 ('SRC_SMITH_UGARITIC_BAAL','Mark S. Smith, The Ugaritic Baal Cycle (Brill, 1994-2009) / The Origins of Biblical Monotheism (OUP, 2001)',NULL,'secondary scholarship','Ugaritic religion'),
 ('SRC_KTU','Die keilalphabetischen Texte aus Ugarit (KTU), ed. Dietrich, Loretz & Sanmartín',NULL,'primary text','Ugaritic alphabetic corpus'),
 ('SRC_PHILO_BYBLOS','Philo of Byblos, Phoenician History (Sanchuniathon), via Eusebius, Praeparatio Evangelica 1.9-10',NULL,'primary text','Phoenician theogony'),
 ('SRC_KAI','Kanaanäische und Aramäische Inschriften (KAI), ed. Donner & Röllig',NULL,'primary inscription/artifact','Northwest Semitic epigraphy')
ON CONFLICT (source_id) DO NOTHING;

-- ---- Etruscan ----
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_ETR_APLU','Aplu','Etruscan','God','Olympian-equivalent','sun; prophecy; healing','regional','A','candidate_verified_name','de Grummond 2006',1,false,false,'The Etruscan Apollo, god of light, prophecy and healing.'),
 ('ENT_ETR_ARTUMES','Artumes','Etruscan','Goddess','Olympian-equivalent','the wild; the hunt; the moon','regional','A','candidate_verified_name','Etruscan mirror corpus',3,false,false,'The Etruscan Artemis, counterpart of Aplu.'),
 ('ENT_ETR_TURMS','Turms','Etruscan','God','Olympian-equivalent','messages; boundaries; the conduct of souls','regional','A','candidate_verified_name','de Grummond 2006',1,true,false,'The Etruscan Hermes/Mercury, messenger and psychopomp (Turms Aitas, "Turms of Hades").'),
 ('ENT_ETR_SETHLANS','Sethlans','Etruscan','God','Olympian-equivalent','fire; the forge; smithcraft','regional','A','candidate_verified_name','de Grummond 2006',2,false,false,'The Etruscan Hephaestus/Vulcan, the smith-god of the forge.'),
 ('ENT_ETR_LARAN','Laran','Etruscan','God','War god','war','regional','A','candidate_verified_name','de Grummond 2006',1,false,false,'The Etruscan war-god, a helmeted youth with spear.'),
 ('ENT_ETR_MARIS','Maris','Etruscan','God','Birth/rite divinity','birth; immortality rites','regional','B','candidate_verified_name','Liver of Piacenza; Magliano plaque',0,false,false,'A divinity of birth and the rites of immortality (not simply "Mars"), with epithets Halna and Husrnana.'),
 ('ENT_ETR_SELVANS','Selvans','Etruscan','God','Boundary/woodland god','woodlands; boundaries','regional','A','candidate_verified_name','Liver of Piacenza; Cortona bronze',4,false,false,'God of woodlands and boundaries (Selvans Tularias, "of the boundaries"); counterpart of Silvanus.'),
 ('ENT_ETR_CEL','Cel','Etruscan','Goddess','Earth goddess','the earth; mother of the giants','regional','A','candidate_verified_name','Liver of Piacenza',5,true,false,'The Etruscan earth/mother goddess (Cel Ati, "Mother Earth"); mother of the giant Celsclan.'),
 ('ENT_ETR_CATHA','Catha','Etruscan','Deity','Light/celestial deity','light; the sun or moon (disputed)','regional','B','candidate_verified_name','Liver of Piacenza; Pyrgi',1,false,false,'A major celestial/light deity (solar-vs-lunar identity debated), prominent at Pyrgi.'),
 ('ENT_ETR_VANTH','Vanth','Etruscan','Chthonic deity','Underworld psychopomp','death; the conduct of the dead','regional','A','candidate_verified_name','de Grummond 2006',0,true,true,'A winged female underworld being who attends and guides the dying; torch, scroll and serpents.'),
 ('ENT_ETR_CULSU','Culsu','Etruscan','Chthonic deity','Underworld gate-demon','the gate of the underworld','regional','B','candidate_verified_name','de Grummond 2006',0,true,false,'A female underworld gate-demon with torch and shears (sarcophagus of Hasti Afunei).'),
 ('ENT_ETR_CULSANS','Culsans','Etruscan','God','Gate/threshold god','gates and thresholds','regional','B','candidate_verified_name','Cortona bronze',1,false,false,'A two-faced god of gates and thresholds (Janus-like), guardian of the city gate of Cortona.'),
 ('ENT_ETR_VETIS','Vetis','Etruscan','God','Chthonic god','the underworld','regional','B','candidate_verified_name','Liver of Piacenza',0,true,false,'A chthonic "night-Jupiter" (Veiovis-type) of the dark north-western region of the Liver.'),
 ('ENT_ETR_AITA','Aita','Etruscan','God','Underworld god','the underworld; the dead','regional','A','candidate_verified_name','Golini Tomb; Tomb of Orcus II',0,true,false,'The Etruscan Hades, lord of the underworld, shown in a wolf-skin cap (an aspect of Śuri).'),
 ('ENT_ETR_PHERSIPNAI','Phersipnai','Etruscan','Goddess','Underworld queen','the underworld','regional','A','candidate_verified_name','Tomb of Orcus II',0,true,false,'The Etruscan Persephone, underworld queen and consort of Aita.'),
 ('ENT_ETR_CILENS','Cilens','Etruscan','Deity','Liver-pantheon deity','night / fate (function open)','regional','B','candidate_verified_name','Liver of Piacenza',0,true,false,'A deity of the Liver pantheon, probably of night or fate (the name is secure, the function debated).'),
 ('ENT_ETR_THALNA','Thalna','Etruscan','Goddess','Birth goddess','childbirth; prophecy','regional','B','candidate_verified_name','Etruscan mirror corpus',0,false,false,'A goddess of childbirth and prophecy, frequent in mirror birth-scenes.'),
 ('ENT_ETR_THANR','Thanr','Etruscan','Goddess','Birth goddess','childbirth','regional','B','candidate_verified_name','Etruscan mirror corpus',0,false,false,'A birth/midwife goddess present at the divine birth-scenes on mirrors.'),
 ('ENT_ETR_MANTUS','Mantus','Etruscan','God','Underworld god','the underworld','regional','B','candidate_verified_name','de Grummond 2006; Servius',0,true,false,'A chthonic underworld god (an aspect of Śuri), known from a Pontecagnano dedication and Servius.')
ON CONFLICT (entity_id) DO NOTHING;

-- ---- Ugaritic / Canaanite ----
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_CAN_KOTHARAT','Kotharat','Canaanite/Ugaritic','Goddess collective','Birth goddesses','conception; childbirth; marriage','regional','A','candidate_verified_name','KTU 1.24',0,false,false,'The seven divine midwives ("the skilful ones," fem. of Kothar) who preside over conception, birth and marriage.'),
 ('ENT_CAN_NIKKAL','Nikkal','Canaanite/Ugaritic','Goddess','Orchard goddess','orchards; fruit; the moon-marriage','regional','A','candidate_verified_name','KTU 1.24',3,false,false,'Goddess of orchards and fruit (from Sumerian Ningal), bride of the moon-god Yarikh.'),
 ('ENT_CAN_PIDRAY','Pidray','Canaanite/Ugaritic','Goddess','Daughter of Baal','light; mist','regional','A','candidate_verified_name','Baal Cycle, KTU 1.3-1.4',1,false,false,'"Daughter of light/mist," eldest of the three daughters of Baal.'),
 ('ENT_CAN_TALLAY','Tallay','Canaanite/Ugaritic','Goddess','Daughter of Baal','dew; light rain','regional','A','candidate_verified_name','Baal Cycle, KTU 1.3-1.4',2,false,false,'"Dewy one," a daughter of Baal personifying dew.'),
 ('ENT_CAN_ARSAY','Arsay','Canaanite/Ugaritic','Goddess','Daughter of Baal','the earth; the underworld','regional','A','candidate_verified_name','Baal Cycle, KTU 1.3; KTU 1.118',4,true,false,'"Earthy one," the chthonic third daughter of Baal.'),
 ('ENT_CAN_SHAHAR','Shahar','Canaanite/Ugaritic','God','Astral twin','the dawn','regional','A','candidate_verified_name','KTU 1.23',0,false,false,'God of the dawn, one of the twin "gracious gods" born to El.'),
 ('ENT_CAN_SHALIM','Shalim','Canaanite/Ugaritic','God','Astral twin','the dusk; completion','regional','A','candidate_verified_name','KTU 1.23',0,false,false,'God of the dusk, twin of Shahar; his name underlies that of Jerusalem (Uru-Shalim).'),
 ('ENT_CAN_HORON','Horon','Canaanite/Ugaritic','God','God of magic','magic; exorcism; healing; snakebite','regional','B','candidate_verified_name','KTU 1.100, 1.107',0,true,true,'A god of magic, exorcism and protection against snakebite (the serpent-charm myth).'),
 ('ENT_CAN_ATHTAR','Athtar','Canaanite/Ugaritic','God','Astral god','the morning star (Venus); irrigation','regional','A','candidate_verified_name','Baal Cycle, KTU 1.6',1,false,false,'The astral god (Venus) enthroned to replace the dead Baal, but too small for the throne. (Cf. the South Arabian Athtar.)')
ON CONFLICT (entity_id) DO NOTHING;

-- ---- Phoenician / Punic ----
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_PHO_BAAL_SHAMEM','Baal-Shamem','Phoenician','God','Sky god','the heavens; supreme lordship','regional','A','candidate_verified_name','KAI 4; Philo of Byblos',0,false,false,'"Lord of Heaven," the supreme sky-god of the Phoenician cities, head of the Byblos pantheon; Greek Zeus.'),
 ('ENT_PHO_BAALAT_GEBAL','Baalat Gebal','Phoenician','Goddess','Tutelary goddess','the city of Byblos; royal and maritime patronage','regional','A','candidate_verified_name','KAI 4; KAI 10',1,false,false,'"Lady of Byblos," tutelary goddess and royal patroness of the city (the Yehimilk and Yehawmilk inscriptions).'),
 ('ENT_PHO_ADONIS','Adonis','Phoenician','God','Dying-and-rising god','vegetation; death and renewal','regional','A','candidate_verified_name','Lucian, De Dea Syria 6-9',3,false,false,'The dying-and-rising vegetation god of Byblos, consort of Astarte, mourned at the Adonia (from Phoenician adon, "lord").'),
 ('ENT_PHO_SHADRAPA','Shadrapa','Phoenician','God','Healing god','healing; protection from venom','regional','B','candidate_verified_name','Amrit stele; Leptis Magna bilingual',0,true,true,'"Shed has healed," a healing god depicted as a youth with serpent and scorpion; in Punic Africa equated with Liber/Dionysus.'),
 ('ENT_PHO_BAAL_SAPHON','Baal-Saphon','Phoenician','God','Storm/maritime god','storms; Mount Saphon; seafarers','regional','B','candidate_verified_name','Esarhaddon-Tyre treaty; KAI',2,false,false,'The storm- and sea-god of Mount Ṣapōn, protector of seafarers (a Phoenician cult-form of Baal).'),
 ('ENT_PHO_SID','Sid','Phoenician','God','Hunt/war god','hunting; war; the sea','regional','B','candidate_verified_name','Antas temple (Sardinia)',2,false,false,'A Punic hunt and war god, eponym of Sardinia (Sid Addir, later Sardus Pater) at the temple of Antas.'),
 ('ENT_PHO_PUMAY','Pumay','Phoenician','God','Tutelary god','personal/tutelary protection','regional','C','candidate_verified_name','theophoric onomastics (Cyprus/Tyre)',0,false,false,'A deity known mainly from theophoric names (behind Pygmalion / Pumayyaton of Kition); function uncertain.'),
 ('ENT_PHO_SAKON','Sakon','Phoenician','God','Tutelary god','protection (function disputed)','regional','C','candidate_verified_name','theophoric names; Piraeus altar',0,false,false,'An obscure deity ("administrator"?), tentatively equated with Hermes; behind the name Sanchuniathon.')
ON CONFLICT (entity_id) DO NOTHING;

-- sources
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_DEGRUMMOND_ETRUSCAN','scholarly attestation','de Grummond, Etruscan Myth, Sacred History and Legend.'
FROM entities WHERE tradition='Etruscan' AND entity_id LIKE 'ENT_ETR_%' AND review_status='candidate_verified_name'
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_LIVER_PIACENZA','inscriptional attestation','Named on the Liver of Piacenza.'
FROM entities WHERE entity_id IN ('ENT_ETR_MARIS','ENT_ETR_SELVANS','ENT_ETR_CEL','ENT_ETR_CATHA','ENT_ETR_VETIS','ENT_ETR_CILENS')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_KTU','direct attestation','Attested in the Ugaritic alphabetic corpus (KTU).'
FROM entities WHERE entity_id IN ('ENT_CAN_KOTHARAT','ENT_CAN_NIKKAL','ENT_CAN_PIDRAY','ENT_CAN_TALLAY','ENT_CAN_ARSAY','ENT_CAN_SHAHAR','ENT_CAN_SHALIM','ENT_CAN_HORON','ENT_CAN_ATHTAR')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_SMITH_UGARITIC_BAAL','scholarly attestation','Smith, The Ugaritic Baal Cycle / Origins of Biblical Monotheism.'
FROM entities WHERE entity_id IN ('ENT_CAN_KOTHARAT','ENT_CAN_NIKKAL','ENT_CAN_PIDRAY','ENT_CAN_TALLAY','ENT_CAN_ARSAY','ENT_CAN_SHAHAR','ENT_CAN_SHALIM','ENT_CAN_HORON','ENT_CAN_ATHTAR')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_PHILO_BYBLOS','direct attestation','Attested in Philo of Byblos / the Phoenician cult record.'
FROM entities WHERE entity_id IN ('ENT_PHO_BAAL_SHAMEM','ENT_PHO_ADONIS')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_KAI','inscriptional attestation','Attested in Phoenician/Punic inscriptions (KAI).'
FROM entities WHERE entity_id IN ('ENT_PHO_BAAL_SHAMEM','ENT_PHO_BAALAT_GEBAL','ENT_PHO_SHADRAPA','ENT_PHO_BAAL_SAPHON','ENT_PHO_SID','ENT_PHO_PUMAY','ENT_PHO_SAKON')
ON CONFLICT DO NOTHING;

-- periods
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_ETR_CLASSICAL','A','Classical Etruscan deity (Liver of Piacenza / mirror corpus).','SRC_DEGRUMMOND_ETRUSCAN','reviewed'
FROM entities WHERE tradition='Etruscan' AND entity_id LIKE 'ENT_ETR_%' AND review_status='candidate_verified_name'
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_CAN_BRONZE_AGE','A','Late Bronze Age Ugaritic deity.','SRC_KTU','reviewed'
FROM entities WHERE entity_id IN ('ENT_CAN_KOTHARAT','ENT_CAN_NIKKAL','ENT_CAN_PIDRAY','ENT_CAN_TALLAY','ENT_CAN_ARSAY','ENT_CAN_SHAHAR','ENT_CAN_SHALIM','ENT_CAN_HORON','ENT_CAN_ATHTAR')
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_PHO_IRON_AGE','A','Iron Age Phoenician/Punic deity.','SRC_KAI','reviewed'
FROM entities WHERE tradition='Phoenician' AND entity_id LIKE 'ENT_PHO_%'
ON CONFLICT DO NOTHING;

-- relationships
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 -- Etruscan interpretatio + underworld
 ('ENT_ETR_APLU','syncretized_with','ENT_APOLLO','high','The Etruscan Apollo.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_ARTUMES','syncretized_with','ENT_ARTEMIS','high','The Etruscan Artemis.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_TURMS','syncretized_with','ENT_HERMES','high','The Etruscan Hermes.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_SETHLANS','syncretized_with','ENT_HEPHAESTUS','high','The Etruscan Hephaestus.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_AITA','syncretized_with','ENT_HADES','high','The Etruscan Hades.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_PHERSIPNAI','syncretized_with','ENT_PERSEPHONE','high','The Etruscan Persephone.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_PHERSIPNAI','consort_of','ENT_ETR_AITA','high','Queen of the Etruscan underworld beside Aita.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_SELVANS','syncretized_with','ENT_ITA_SILVANUS','medium','Counterpart of the Italic Silvanus.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_APLU','member_of','ENT_ETR_TINIA','low','Of the Etruscan pantheon headed by Tinia.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_VANTH','associated_with','ENT_ETR_AITA','medium','Underworld psychopomp in the realm of Aita.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 -- Ugaritic family
 ('ENT_CAN_PIDRAY','child_of','ENT_CAN_BAAL','high','Daughter of Baal.','SRC_KTU','reviewed'),
 ('ENT_CAN_TALLAY','child_of','ENT_CAN_BAAL','high','Daughter of Baal.','SRC_KTU','reviewed'),
 ('ENT_CAN_ARSAY','child_of','ENT_CAN_BAAL','high','Daughter of Baal.','SRC_KTU','reviewed'),
 ('ENT_CAN_NIKKAL','consort_of','ENT_CAN_YARIKH','high','Bride of the moon-god Yarikh.','SRC_KTU','reviewed'),
 ('ENT_CAN_SHAHAR','sibling_of','ENT_CAN_SHALIM','high','The twin dawn and dusk gods.','SRC_KTU','reviewed'),
 ('ENT_CAN_SHAHAR','child_of','ENT_CAN_EL','high','One of the gracious gods born to El.','SRC_KTU','reviewed'),
 ('ENT_CAN_SHALIM','child_of','ENT_CAN_EL','high','One of the gracious gods born to El.','SRC_KTU','reviewed'),
 ('ENT_CAN_ATHTAR','opposes','ENT_CAN_BAAL','medium','Enthroned to replace the dead Baal but proves too small.','SRC_SMITH_UGARITIC_BAAL','reviewed'),
 -- Phoenician reception of Canaanite + Greek homonym
 ('ENT_PHO_ADONIS','consort_of','ENT_CAN_ASTARTE','high','Adonis of Byblos, consort of Astarte.','SRC_PHILO_BYBLOS','reviewed'),
 ('ENT_PHO_ADONIS','reception_of','ENT_ADONIS','high','The Greek Adonis derives from the Phoenician adon ("lord") of the Byblos cult.','SRC_PHILO_BYBLOS','reviewed'),
 ('ENT_CAN_ATHTAR','aligned_with','ENT_SAB_ATHTAR','medium','The Ugaritic and South Arabian Athtar are reflexes of the common Semitic Venus-god.','SRC_SMITH_UGARITIC_BAAL','reviewed'),
 ('ENT_PHO_BAAL_SAPHON','cult_form_of','ENT_CAN_BAAL','high','A Phoenician cult-form of Baal Hadad of Mount Saphon.','SRC_KAI','reviewed'),
 ('ENT_PHO_BAAL_SHAMEM','syncretized_with','ENT_ROM_JUPITER','low','"Lord of Heaven," equated with Zeus/Jupiter.','SRC_PHILO_BYBLOS','reviewed')
ON CONFLICT DO NOTHING;

-- homonym register (cross-tradition same-name, intentional)
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Adonis','ENT_PHO_ADONIS','Phoenician Adonis of Byblos vs the already-held Greek Adonis (ENT_ADONIS); the Greek is a reception of the Phoenician — wired reception_of.','intentional_distinct'),
 ('Athtar','ENT_CAN_ATHTAR','Ugaritic Athtar vs the already-held South Arabian Athtar (ENT_SAB_ATHTAR); cognate reflexes of the common Semitic Venus-god, kept distinct.','intentional_distinct')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Etruscan / Ugaritic / Phoenician counts =='
SELECT tradition, count(*) FROM entities WHERE tradition IN ('Etruscan','Canaanite/Ugaritic','Phoenician') GROUP BY tradition ORDER BY tradition;
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
