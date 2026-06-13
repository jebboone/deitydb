-- scripts/add_greek_patristic_demonization.sql
-- Systematic reception: Greek Olympians → Patristic Christian demonization
--
-- The patristic argument (Justin Martyr 1 Apol. 5, 9, 24; Augustine City of God
-- II–VIII) was that Greek gods ARE demons — not merely false, but actively evil
-- demonic powers who deceived humanity through pagan religion.
--
-- Three tiers of specificity:
--   (a) Named individual identification: Apollo → Apollyon (Revelation 9:11)
--   (b) Chief-deity identification: Zeus → Devil (king of gods = prince of demons)
--       Pan → Devil (iconographic origin of the Devil's form)
--   (c) General collective demonization: remaining Olympians → ENT_CHR_DEMONS
--
-- ENT_HECATE already handled in upgrade_v1_1_temporal.sql (ENT_REC_HECATE_PATRISTIC).
-- ENT_HERMES omitted here: his patristic reception is bifurcated (Justin Martyr 1
-- Apol. 21 uses Hermes as a Logos parallel, not a demon); the Hermetic chain
-- (ENT_HERMES → ENT_HER_TRISMEGISTUS) already in DB covers his primary reception.
-- ENT_APHRODITE: Canaanite→Greek reception already added; patristic demonization
-- follows the same general pattern as the other Olympians (→ ENT_CHR_DEMONS).
--
-- New sources: SRC_JUSTIN_MARTYR_APOLOGIES, SRC_AUGUSTINE_CITY_OF_GOD
-- Requires: upgrade_v1_1_temporal.sql (PER_PATRISTIC, received_as/reception_of types)

BEGIN;

-- ── 1. New primary Patristic sources ───────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_JUSTIN_MARTYR_APOLOGIES',
   'Justin Martyr, First and Second Apologies (c. 150–165 CE)',
   NULL,
   'primary text',
   'Earliest systematic Christian apologetic; 1 Apol. 5 argues Greek gods are demons under Satan; 1 Apol. 9, 24 names Zeus, Apollo, Artemis, Poseidon, Aphrodite, Ares, Hephaestus, Dionysus, Hermes as objects of demon-orchestrated worship; 1 Apol. 21–22 uses pagan gods as typological parallels to Christ (Hermes, Asclepius)'),
  ('SRC_AUGUSTINE_CITY_OF_GOD',
   'Augustine of Hippo, De Civitate Dei (413–426 CE)',
   NULL,
   'primary text',
   'The most systematic patristic demolition of Roman/Greek religion; Books II–VIII argue pagan gods are either morally evil demons or poetic fictions; Book VIII–X refutes Apuleius and argues daimones cannot mediate between humans and God; key source for theological demonization of the entire Greco-Roman pantheon')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Transmission chains ─────────────────────────────────────────────────
-- All chains PER_PATRISTIC (100–450 CE).
-- All pairs: received_as (Olympian→Christian) + reception_of (inverse).

-- 2a. Apollo → Apollyon: the most textually specific Olympian demonization
-- Revelation 9:11 names the angel of the abyss "Apollyon" (Ἀπολλύων, "Destroyer").
-- The name is a deliberate Greek wordplay on Apollo (Ἀπόλλων), transparent to any
-- Greek-speaking audience. Justin Martyr (1 Apol. 24) also explicitly names Apollo
-- as a demon. ENT_CHR_APOLLYON already exists in the DB as the Revelation entity.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_APOLLO', 'received_as', 'ENT_CHR_APOLLYON',
   'high',
   'Revelation 9:11 names the angel of the bottomless pit "Apollyon" (Ἀπολλύων, "Destroyer"), a transparent Greek wordplay on Apollo (Ἀπόλλων). The identification would have been unmistakable to Greek-speaking audiences: the great healing and oracular god becomes the angel of destruction and the abyss. Justin Martyr (1 Apol. 24) explicitly lists Apollo among the gods who are demons. The Apollo→Apollyon chain is the single most textually specific Olympian demonization in the New Testament.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_APOLLYON', 'reception_of', 'ENT_APOLLO',
   'high',
   'Apollyon as the Christian reception/demonization of Apollo; name is a deliberate Greek wordplay on Apollo visible throughout the Revelation text.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC')
ON CONFLICT DO NOTHING;

-- 2b. Zeus → Devil: king of gods received as prince of demons
-- Justin Martyr 1 Apol. 5 argues that Satan and his demons orchestrated
-- all pagan religion; as king of the Olympians, Zeus maps structurally to Satan
-- as prince of demons. Augustine City of God II.14, IV.30 treats Jupiter/Zeus as
-- the pre-eminent false deity whose worship corrupted Rome.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ZEUS', 'received_as', 'ENT_CHR_DEVIL',
   'medium',
   'Justin Martyr (1 Apol. 5) argues that Satan and the evil demons orchestrated all pagan worship; as sovereign of the Olympians, Zeus was structurally mapped to Satan as sovereign of the demonic realm. Augustine (City of God II.14) treats Jupiter/Zeus as the pre-eminent false deity whose example licensed all moral depravity in Roman religion. The structural correspondence — king of heaven / prince of demons — made Zeus the natural Olympian counterpart to the Christian Devil.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEVIL', 'reception_of', 'ENT_ZEUS',
   'medium',
   'The Christian Devil absorbs the structural position of Zeus as king of heaven; patristic theology explicitly mapped the chief Olympian to the prince of demonic powers.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC')
ON CONFLICT DO NOTHING;

-- 2c. Pan → Devil: iconographic origin of the Devil's physical form
-- Pan's image — goat horns, cloven hooves, goat haunches, lascivious nature —
-- is the primary visual source for the Christian Devil's iconographic form.
-- The association develops through patristic demonization of satyrs and Pan as
-- servants of the demonic, and solidifies in medieval iconography. Justin Martyr
-- (1 Apol. 25) includes the satyr-Pan class among demonic beings.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_PAN', 'received_as', 'ENT_CHR_DEVIL',
   'medium',
   'Pan''s iconographic form — goat horns, cloven hooves, hairy goat haunches, lustful nature — is the primary visual source for the Christian Devil''s physical appearance. Justin Martyr (1 Apol. 25) classifies satyrs and Pan-like beings among demonic figures. The "Pan is dead" story in Plutarch (On the Obsolescence of Oracles 17) was Christianized as the announcement of Satan''s overthrow at the crucifixion. The iconographic Devil is a composite primarily derived from Pan, a reception that registers across patristic writing, medieval art, and demonology.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEVIL', 'reception_of', 'ENT_PAN',
   'medium',
   'The Christian Devil''s iconographic form (horns, hooves, goat-haunches, lust) derives primarily from Pan; Pan''s patristic demonization produced the visual language of the Devil across medieval Christianity.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC')
ON CONFLICT DO NOTHING;

-- 2d. General Olympian demonization → ENT_CHR_DEMONS collective
-- Justin Martyr (1 Apol. 5, 9, 24) and Augustine (City of God II–VIII) provide
-- systematic condemnation: these gods ARE demons who deceived humanity through
-- cult worship. ENT_CHR_DEMONS (Christian demon collective) is the appropriate
-- target for this general reception — the Olympians were absorbed into the
-- undifferentiated demonic class without individuated Christian identities.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES

  -- Hera: Justin Martyr 1 Apol. 9 cites Hera's worship as demon-orchestrated;
  -- Augustine City of God VI.7 discusses Juno/Hera at length as a false deity.
  ('ENT_HERA', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 9, 25) cites Hera''s worship as prompted by demons; Augustine (City of God VI.7) treats Juno/Hera as exemplary of pagan theological confusion. Received into Christian cosmology as a demon or demon-inspired false deity.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_HERA',
   'medium',
   'Hera received into the Christian demonic class; patristic authors treated Hera/Juno worship as demonic deception.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Poseidon: Justin Martyr 1 Apol. 24 names Poseidon among the demonic gods.
  ('ENT_POSEIDON', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 24) names Poseidon among the gods who are worshipped at demonic instigation. Augustine (City of God IV.23) discusses Neptune/Poseidon as a false deity whose cult corrupted Roman moral life.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_POSEIDON',
   'medium',
   'Poseidon received into the Christian demonic class; explicitly named in Justin Martyr as a demon-worshipped deity.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Athena: Justin Martyr 1 Apol. 25 names Athena; Tertullian and Origen also
  -- cite her. Augustine City of God XVIII.9 discusses Minerva/Athena.
  ('ENT_ATHENA', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 25) names Athena among the demon-promoted false deities. Tertullian and Origen both address Athena/Minerva as belonging to the demonic pantheon. Augustine (City of God XVIII.9) discusses Minerva''s mythological traditions as morally scandalous and false.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_ATHENA',
   'medium',
   'Athena received into the Christian demonic class; named by Justin Martyr and discussed by Tertullian, Origen, and Augustine as a demon-promoted false deity.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Ares: Justin Martyr 1 Apol. 25 names Ares explicitly.
  -- The god of war was a natural target: Augustine City of God IV.23 on Mars/Ares.
  ('ENT_ARES', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 25) explicitly names Ares/Mars among the demon-worshipped gods. The god of war and violence was a ready symbol of demonic destructiveness; Augustine (City of God IV.23) treats Mars/Ares as a false god whose cult promoted violence.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_ARES',
   'medium',
   'Ares received into the Christian demonic class; explicitly named by Justin Martyr among demon-worshipped gods.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Hephaestus: Justin Martyr 1 Apol. 25 names Hephaestus/Vulcan.
  ('ENT_HEPHAESTUS', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 25) names Hephaestus/Vulcan among the demon-worshipped false deities. Augustine (City of God IV.23) includes Vulcan in the list of demonstrably false Roman gods.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_HEPHAESTUS',
   'medium',
   'Hephaestus received into the Christian demonic class; named by Justin Martyr among demon-promoted gods.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Artemis: Justin Martyr 1 Apol. 24–25; Acts 19:23-41 (Ephesian Diana riot)
  -- contextualizes her as the pre-eminent pagan rival to Christian proclamation.
  ('ENT_ARTEMIS', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 24–25) names Artemis/Diana among demon-worshipped deities. Acts 19:23–41 depicts Artemis of Ephesus as the principal pagan opposition to Paul''s mission — the Ephesian riot frames Artemis as the leading demonic rival to the gospel in Asia Minor. Augustine (City of God II.4) cites the licentiousness of Diana''s cult rites.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_ARTEMIS',
   'medium',
   'Artemis received into the Christian demonic class; Acts 19 frames her Ephesian cult as the pre-eminent pagan demonic opposition; Justin Martyr names her explicitly.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Aphrodite: Justin Martyr 1 Apol. 24–25; Augustine City of God II.4, IV.10
  -- on the licentiousness of Venus/Aphrodite cult as morally corrupting.
  ('ENT_APHRODITE', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 24–25) names Aphrodite/Venus among demon-worshipped deities. Augustine (City of God II.4, IV.10) extensively criticizes the moral licentiousness of Venus''s theatrical and cultic representations as evidence of demonic corruption of Roman religion. Aphrodite''s sexual associations made her a target for patristic condemnation of pagan immorality.',
   'SRC_AUGUSTINE_CITY_OF_GOD', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_APHRODITE',
   'medium',
   'Aphrodite received into the Christian demonic class; her sexual cult was a primary patristic example of demonic moral corruption.',
   'SRC_AUGUSTINE_CITY_OF_GOD', 'reviewed', 'PER_PATRISTIC'),

  -- Demeter: the Eleusinian Mysteries were frequently cited by patristic authors
  -- as demonic deception of the highest order — mystery religion as Satan's
  -- counterfeit of Christian sacraments (Justin Martyr 1 Apol. 66; Clement of
  -- Alexandria Protrepticus II).
  ('ENT_DEMETER', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Demeter''s Eleusinian Mysteries were a primary patristic target: Justin Martyr (1 Apol. 66) presents the mysteries as demonic counterfeits of Christian sacraments; Clement of Alexandria (Protrepticus II) extensively mocks the Eleusinian rites as demonic obscenities. Augustine (City of God VI.9) discusses Ceres/Demeter''s cult as morally degraded. The Mysteries'' secrecy made them especially suspect as demonic deception.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_DEMETER',
   'medium',
   'Demeter received into the Christian demonic class; her Eleusinian Mysteries were the pre-eminent patristic example of demonic sacramental counterfeit.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Dionysus: Justin Martyr 1 Apol. 25, 54 — explicitly names Dionysus;
  -- also invokes the dying-rising god parallel to argue demons invented the
  -- Dionysus myth to preemptively discredit the resurrection.
  ('ENT_DIONYSUS', 'received_as', 'ENT_CHR_DEMONS',
   'medium',
   'Justin Martyr (1 Apol. 25, 54) explicitly names Dionysus as a demon-promoted deity and argues that the myth of the dying-and-rising Dionysus was a demonic anticipatory counterfeit of the resurrection — Satan foreknew the resurrection and seeded Dionysus mythology to make it seem derivative. Augustine (City of God VII.21) treats Bacchus/Dionysus''s cult as morally ruinous. The Dionysus–Christ typology (dying-rising, wine, thyrsos–cross) was a primary concern of patristic apologists.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_DIONYSUS',
   'medium',
   'Dionysus received into the Christian demonic class; Justin Martyr explicitly names him and argues his myth is a demonic anticipatory counterfeit of the resurrection.',
   'SRC_JUSTIN_MARTYR_APOLOGIES', 'reviewed', 'PER_PATRISTIC'),

  -- Hestia: less individually named in patristic sources; included in general
  -- condemnation of the Olympian pantheon. Low confidence: Hestia/Vesta had
  -- declined in individual prominence by the Patristic period.
  ('ENT_HESTIA', 'received_as', 'ENT_CHR_DEMONS',
   'low',
   'Hestia/Vesta included in the general patristic condemnation of the Olympian pantheon (Augustine City of God IV.23 lists Vesta among the false Roman gods). Less individually named than the major Olympians; by the Patristic period Vesta''s cult had contracted significantly. Low confidence: general inclusion in the condemned pantheon rather than specific patristic identification.',
   'SRC_AUGUSTINE_CITY_OF_GOD', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEMONS', 'reception_of', 'ENT_HESTIA',
   'low',
   'Hestia/Vesta included in the general patristic demonization of the Olympian pantheon; less individually named than other Olympians.',
   'SRC_AUGUSTINE_CITY_OF_GOD', 'reviewed', 'PER_PATRISTIC')

ON CONFLICT DO NOTHING;

-- ── 3. Verification ────────────────────────────────────────────────────────

SELECT 'greek_patristic_chains' AS metric,
       COUNT(*) AS count
FROM entity_relationships
WHERE relationship_type IN ('received_as','reception_of')
AND (
  subject_entity_id IN ('ENT_APOLLO','ENT_ZEUS','ENT_PAN','ENT_HERA',
    'ENT_POSEIDON','ENT_ATHENA','ENT_ARES','ENT_HEPHAESTUS','ENT_ARTEMIS',
    'ENT_APHRODITE','ENT_DEMETER','ENT_DIONYSUS','ENT_HESTIA')
  OR object_entity_id IN ('ENT_APOLLO','ENT_ZEUS','ENT_PAN','ENT_HERA',
    'ENT_POSEIDON','ENT_ATHENA','ENT_ARES','ENT_HEPHAESTUS','ENT_ARTEMIS',
    'ENT_APHRODITE','ENT_DEMETER','ENT_DIONYSUS','ENT_HESTIA')
);

SELECT * FROM v_release_metrics;

COMMIT;
