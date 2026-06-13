-- scripts/add_islamic_reception.sql
-- Systematic reception chains: Israelite/Second Temple + Christian → Islamic
-- Plus: Zoroastrian Mithra → Roman Mithras (missed from add_zoroastrian_reception.sql)
--
-- Islam received the entire angelological and demonological tradition of Second
-- Temple Judaism and early Christianity, recast through Quranic revelation.
-- Key chains: Gabriel/Michael become Jibril/Mikail; Satan becomes Iblis; the
-- Watcher tradition becomes Harut and Marut; Enoch + Hermes Trismegistus both
-- converge on the Islamic prophet Idris.
--
-- New entity: ENT_ISL_IDRIS (Quranic prophet; identified with Enoch in Islamic
-- commentary and with Hermes Trismegistus in Islamic-Hermetic tradition)
-- New source: SRC_VAN_BLADEL_ARABIC_HERMES (Van Bladel 2009, the scholarly
-- reference for Idris = Hermes in the Islamic philosophical tradition)
--
-- Existing sources used: SRC_QURAN, SRC_HADITH_GENERAL, SRC_ISLAM_EI2,
-- SRC_AVESTA, SRC_BOYCE_ZOROASTRIANS
-- Requires: upgrade_v1_1_temporal.sql

BEGIN;

-- ── 1. New source ───────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_VAN_BLADEL_ARABIC_HERMES',
   'Kevin van Bladel, The Arabic Hermes: From Pagan Sage to Prophet of Science (Oxford University Press, 2009)',
   NULL,
   'secondary scholarly',
   'Definitive scholarly study of how Hermes Trismegistus entered Islamic intellectual tradition as the prophet Idris; traces the Idris=Hermes identification through Jabir ibn Hayyan, al-Kindi, and Sabian literature; documents the convergence of Enoch, Hermes, and Idris across Jewish, Christian, and Islamic tradition')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New entity: ENT_ISL_IDRIS ───────────────────────────────────────────
-- Quranic prophet (19:56-57, 21:85); Islamic commentary universally identifies
-- him with Enoch; Islamic-Hermetic tradition identifies him with Hermes Trismegistus.
-- Idris is the nodal figure where three transmission lines converge.

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, evidence_confidence,
   primary_period, inclusion_basis, short_note)
VALUES
  ('ENT_ISL_IDRIS',
   'Idris',
   'Islamic',
   'Prophet/revealer',
   'A',
   'PER_ISL_EARLY',
   'Primary Quranic attestation: 19:56-57 ("We raised him to a high station"), 21:85; Islamic commentary identifies him with Enoch; Islamic-Hermetic tradition identifies him with Hermes Trismegistus',
   'Quranic prophet mentioned in 19:56-57 and 21:85; Islamic exegetical tradition (Ibn Abbas, Ibn Ishaq) universally identifies Idris with the biblical Enoch (antediluvian patriarch, "walked with God", taken to heaven alive). In Islamic-Hermetic philosophical tradition (9th–12th c. CE), Idris is further identified with Hermes Trismegistus as the primordial prophet of wisdom, writing, and the sciences. He is thus the Islamic nodal figure where the Enoch tradition, the Hermetic tradition, and Quranic prophetology converge.')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ISL_IDRIS', 'SRC_QURAN', 'primary_attestation',
   'Quran 19:56-57 ("Mention in the Book, Idris. Indeed, he was a man of truth and a prophet. And We raised him to a high station."); 21:85 (listed among the prophets of steadfast patience)'),
  ('ENT_ISL_IDRIS', 'SRC_ISLAM_EI2', 'secondary_reference',
   'EI2 s.v. "Idris" — reviews the Enoch identification and the Hermes Trismegistus association in Islamic tradition')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, source_id, review_status)
VALUES
  ('ENT_ISL_IDRIS', 'PER_ISL_EARLY', 'high', 'SRC_QURAN', 'reviewed'),
  ('ENT_ISL_IDRIS', 'PER_ISL_CLASSICAL', 'medium', 'SRC_VAN_BLADEL_ARABIC_HERMES', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 3. Transmission chains ─────────────────────────────────────────────────

-- 3a. Archangels: Gabriel → Jibril, Michael → Mikail
-- Both named in Quran 2:97-98; the identification is certain — same angel,
-- same role, same name (cognate). These are not receptions in the same sense
-- as the demonization chains: Islam holds Jibril and Mikail ARE the biblical
-- angels. From a comparative-religion standpoint, the Hebrew figures were
-- transmitted directly into Islamic cosmology.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ISR_GABRIEL', 'received_as', 'ENT_ISL_JIBRIL',
   'high',
   'Gabriel (Hebrew Gavriel, "man of God") is received in Islam as Jibril, the angel who revealed the Quran to Muhammad (Quran 2:97-98: "Say, Whoever is an enemy to Gabriel — it is he who has brought the Quran down upon your heart by permission of Allah"). Same angel, same role (divine revelation), same name (cognate). The most direct angelological transmission from Israelite/Second Temple Judaism into Islam.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_JIBRIL', 'reception_of', 'ENT_ISR_GABRIEL',
   'high',
   'Jibril as Islamic reception of the Israelite/Second Temple angel Gabriel; same role (divine messenger and revealer), same name (cognate), explicitly named in Quran 2:97-98.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY'),

  ('ENT_ISR_MICHAEL', 'received_as', 'ENT_ISL_MIKAIL',
   'high',
   'Michael (Hebrew Mikha''el, "who is like God?") is received in Islam as Mikail, named alongside Jibril in Quran 2:98: "Whoever is an enemy to Allah and His angels and His messengers and Gabriel and Michael — then indeed, Allah is an enemy to the disbelievers." Same archangel, directly named in the Quran.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_MIKAIL', 'reception_of', 'ENT_ISR_MICHAEL',
   'high',
   'Mikail as Islamic reception of the archangel Michael; same name (cognate), directly named in Quran 2:98.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY')
ON CONFLICT DO NOTHING;

-- 3b. Satan → Iblis: the Islamic adversary
-- Two distinct source traditions feed Iblis: the Hebrew/Christian Satan
-- (accuser/adversary in the divine court, who tempts humanity) and the
-- Azazel tradition (angel expelled for refusing to bow). Both chains are added.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ISR_SATAN', 'received_as', 'ENT_ISL_IBLIS',
   'high',
   'The Islamic Iblis (Quran 2:34, 7:11-18, 18:50, 38:71-85) is the direct reception of the Hebrew/Christian Satan: he is the cosmic adversary who refuses God''s command, is expelled from the divine realm, and dedicates himself to leading humanity astray until the Day of Judgment. The Arabic name Shaytan (used interchangeably with Iblis: "And We said to the angels, ''Bow to Adam,'' and they bowed, except for Iblis. He was of the jinn and departed from the command of his Lord" — 18:50) derives from the same Semitic root as Hebrew satan (adversary). The functional role, cosmic narrative, and linguistic trace are all continuous.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_IBLIS', 'reception_of', 'ENT_ISR_SATAN',
   'high',
   'Iblis as Islamic reception of the Hebrew/Christian Satan; same function (cosmic adversary, tempter of humanity), name Shaytan cognate with Hebrew satan, same narrative structure (expelled from divine presence for pride/disobedience).',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY'),

  ('ENT_ISR_AZAZEL', 'received_as', 'ENT_ISL_IBLIS',
   'medium',
   'Islamic tafsir tradition identifies Iblis''s pre-fall name as "Azazil" — directly cognate with the Hebrew Azazel (Leviticus 16:8-10, the scapegoat demon of the wilderness). The identification appears in major commentators including al-Tabari and Ibn Kathir, who record that Iblis was called Azazil before he refused to bow to Adam. The Azazel→Iblis chain transmits the wilderness demon / expelled divine being tradition rather than the Satanic accuser tradition; both converge in the Quranic Iblis figure.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_IBLIS', 'reception_of', 'ENT_ISR_AZAZEL',
   'medium',
   'Iblis''s pre-fall name Azazil (recorded in Tabari, Ibn Kathir) is cognate with Hebrew Azazel; the expelled wilderness demon tradition converges with the Satanic adversary tradition in the Quranic Iblis.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY')
ON CONFLICT DO NOTHING;

-- 3c. Watcher tradition → Harut and Marut
-- Quran 2:102: Two angels in Babylon who taught forbidden magic to humanity.
-- Scholars (Geiger 1833, Sidersky 1933, Millar Burrows) connect Harut and Marut
-- to the Watcher myth of 1 Enoch 6-11: divine beings who descend, teach forbidden
-- knowledge, and whose activity is associated with human sin. The Babylonian
-- location is shared with the Apkallu→Watchers chain (see add_canaanite_israelite_reception.sql).

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ISR_WATCHERS', 'received_as', 'ENT_ISL_HARUT',
   'medium',
   'Quran 2:102 describes Harut and Marut as two angels in Babylon who taught magic to humans, warning them it was a trial. Scholars including Geiger (1833) and Sidersky (1933) connect Harut and Marut to the Watcher tradition of 1 Enoch 6-11: divine beings who descend, transmit forbidden knowledge (sorcery, weaponry, cosmetics) to humanity, and whose activity constitutes a cosmic sin. The Babylonian setting of Quran 2:102 parallels the Apkallu tradition. Confidence medium: the Quran does not explicitly call them fallen angels, and the connection to the Watchers is scholarly reconstruction.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_HARUT', 'reception_of', 'ENT_ISR_WATCHERS',
   'medium',
   'Harut as Islamic reception of the Watcher tradition; angel in Babylon who teaches forbidden magic parallels 1 Enoch''s Watchers who descend to teach forbidden arts.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY'),

  ('ENT_ISR_WATCHERS', 'received_as', 'ENT_ISL_MARUT',
   'medium',
   'Marut (paired with Harut in Quran 2:102) as the second angel in the Babylonian forbidden-knowledge tradition; same Watcher-parallel rationale as Harut. The pair corresponds to the collective of descending Watchers rather than any individual Watcher.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_MARUT', 'reception_of', 'ENT_ISR_WATCHERS',
   'medium',
   'Marut as Islamic reception of the Watcher tradition; Quran 2:102 pair Harut-Marut mirrors the descending divine beings who teach forbidden knowledge in 1 Enoch.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY')
ON CONFLICT DO NOTHING;

-- 3d. Antichrist → Dajjal: Islamic eschatological reception of Christian apocalyptic

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_CHR_ANTICHRIST', 'received_as', 'ENT_ISL_DAJJAL',
   'medium',
   'The Dajjal (al-Masih al-Dajjal, "the Deceiving Messiah") is the Islamic false messiah who appears before the Last Day, and is the direct Islamic reception of the Christian Antichrist tradition. Jewish and Christian apocalyptic texts (including the Book of Revelation, Syriac Christian apocalypses, and rabbinic traditions about Armilus) circulated in 7th-century Arabia; hadith traditions about the Dajjal show clear structural and narrative parallels including: one-eyed deceiver, claims divine status, defeated by Jesus (Isa) at the Second Coming. The Dajjal concept entered Islam through these Jewish-Christian apocalyptic contact traditions.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_DAJJAL', 'reception_of', 'ENT_CHR_ANTICHRIST',
   'medium',
   'Dajjal as Islamic reception of the Christian Antichrist tradition; same eschatological function (false messiah, deceiver, defeated at the end of history), transmitted through Jewish-Christian apocalyptic traditions circulating in 7th-century Arabia.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY')
ON CONFLICT DO NOTHING;

-- 3e. Angel of Death → Azrail
-- The Islamic angel Azrail (Izra'il) is the reception of the Jewish Angel of Death
-- tradition. The name Azrael appears in Jewish post-Talmudic literature before
-- its Islamic elaboration; the Islamic Azrail becomes the named Angel of Death.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ISR_ANGEL_OF_DEATH', 'received_as', 'ENT_ISL_AZRAIL',
   'medium',
   'The Islamic angel Azrail (Izra''il, the Angel of Death) is the named reception of the Israelite/Jewish Angel of Death tradition. The name Azrael appears in post-Talmudic Jewish literature; the Quran refers to "the angel of death appointed over you" (32:11) without naming him; the name Azrail becomes standard in Islamic theological and hadith tradition. The functional role (taking souls at death) is continuous from the Israelite Angel of Death through Talmudic tradition to the Islamic Azrail.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_AZRAIL', 'reception_of', 'ENT_ISR_ANGEL_OF_DEATH',
   'medium',
   'Azrail as Islamic reception of the Israelite/Jewish Angel of Death; name cognate with Jewish Azrael; same function (receiving human souls at death); Quran 32:11 attests the role, hadith traditions supply the name.',
   'SRC_HADITH_GENERAL', 'reviewed', 'PER_ISL_EARLY')
ON CONFLICT DO NOTHING;

-- 3f. Enoch → Idris: the universal Enoch identification in Islamic exegesis

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ENOCH', 'received_as', 'ENT_ISL_IDRIS',
   'high',
   'Islamic exegetical tradition universally identifies the Quranic prophet Idris (19:56-57, 21:85) with the biblical Enoch. Ibn Abbas, Ibn Ishaq, al-Tabari, and virtually all classical commentators make this identification: both are antediluvian patriarchs taken alive to heaven ("We raised him to a high station" = Enoch "walked with God, and he was not, for God took him" — Genesis 5:24). The raising alive, the antediluvian timeframe, the status as a prophet/patriarch, and the association with wisdom and writing are all shared. Highest confidence of any chain in this script.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY'),
  ('ENT_ISL_IDRIS', 'reception_of', 'ENT_ENOCH',
   'high',
   'Idris as Islamic reception of the biblical Enoch; universally identified in Islamic commentary; both antediluvian patriarchs taken to heaven alive, both associated with wisdom and writing.',
   'SRC_QURAN', 'reviewed', 'PER_ISL_EARLY')
ON CONFLICT DO NOTHING;

-- 3g. Hermes Trismegistus → Idris: the Islamic-Hermetic identification
-- Islamic philosophers from the 9th century onward identified Idris with Hermes
-- Trismegistus, making Idris the prophet of philosophy, alchemy, and the sciences.
-- Van Bladel 2009 is the definitive scholarly source.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HER_TRISMEGISTUS', 'received_as', 'ENT_ISL_IDRIS',
   'medium',
   'Islamic philosophers from the 9th century onward identified Hermes Trismegistus with the Quranic prophet Idris, creating "Hermes-Idris" as the Islamic primordial sage of wisdom, alchemy, and the natural sciences. Jabir ibn Hayyan, al-Kindi, and the Sabian astronomical tradition of Harran all contributed to this identification. The pseudo-Magriti text Ghayat al-Hakim and later writers on Islamic occult philosophy elaborate Idris-Hermes as the originator of every science. Van Bladel 2009 traces this in detail. Confidence medium: the identification is certain in the philosophical tradition, but represents an interpretation layered onto the Quranic Idris, not a direct Quranic claim.',
   'SRC_VAN_BLADEL_ARABIC_HERMES', 'reviewed', 'PER_ISL_CLASSICAL'),
  ('ENT_ISL_IDRIS', 'reception_of', 'ENT_HER_TRISMEGISTUS',
   'medium',
   'Idris as Islamic reception of Hermes Trismegistus in Islamic-Hermetic philosophical tradition; identified by 9th-12th century Islamic thinkers as the primordial prophet of wisdom, alchemy, and the sciences.',
   'SRC_VAN_BLADEL_ARABIC_HERMES', 'reviewed', 'PER_ISL_CLASSICAL')
ON CONFLICT DO NOTHING;

-- ── 4. Mithra → Mithras (addendum from Zoroastrian script) ────────────────
-- ENT_SYN_MITHRAS (Roman/Persian reception mystery cult deity) exists in the DB
-- but was not linked to ENT_ZOR_MITHRA in add_zoroastrian_reception.sql.
-- Adding here. Scholarly debate on degree of continuity: Cumont's older position
-- (direct inheritance) vs. Ulansey/Merkelbach (largely independent Roman creation).
-- Medium confidence reflects the ongoing scholarly dispute.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ZOR_MITHRA', 'received_as', 'ENT_SYN_MITHRAS',
   'medium',
   'The Roman mystery cult deity Mithras is the reception of the Iranian/Zoroastrian Mithra (Avestan: Miθra, "covenant/contract"). Both are solar-associated figures of light, truth, and the cosmic struggle against darkness. The Roman cult (1st–4th c. CE) shares iconographic elements (Mithra/Mithras slaying a bull; solar associations; military popularity) and the name is directly cognate. Scholarly debate persists on the degree of continuity: Cumont argued direct inheritance from Iranian religion; Ulansey (1989) and Merkelbach (1984) argued for substantial Roman innovation. Medium confidence: the name and some attributes are continuous; the degree of doctrinal transmission is disputed.',
   'SRC_BOYCE_ZOROASTRIANS', 'reviewed', 'PER_LATE_ANTIQUE'),
  ('ENT_SYN_MITHRAS', 'reception_of', 'ENT_ZOR_MITHRA',
   'medium',
   'Mithras as Roman reception of Zoroastrian/Iranian Mithra; name cognate; solar and covenantal attributes shared; degree of doctrinal continuity debated (Cumont vs. Ulansey).',
   'SRC_BOYCE_ZOROASTRIANS', 'reviewed', 'PER_LATE_ANTIQUE')
ON CONFLICT DO NOTHING;

-- ── 5. Verification ────────────────────────────────────────────────────────

SELECT 'islamic_reception_chains' AS metric,
       COUNT(*) AS count
FROM entity_relationships
WHERE relationship_type IN ('received_as','reception_of')
AND (subject_entity_id LIKE 'ENT_ISL_%' OR object_entity_id LIKE 'ENT_ISL_%');

SELECT 'mithra_mithras_chain' AS metric,
       COUNT(*) AS count
FROM entity_relationships
WHERE (subject_entity_id = 'ENT_ZOR_MITHRA' OR object_entity_id = 'ENT_ZOR_MITHRA')
AND relationship_type IN ('received_as','reception_of');

SELECT * FROM v_release_metrics;

COMMIT;
