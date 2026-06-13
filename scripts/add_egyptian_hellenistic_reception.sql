-- scripts/add_egyptian_hellenistic_reception.sql
-- Systematic reception chains: Egyptian → Greco-Egyptian syncretic + Patristic
--
-- Two transmission horizons:
--   (a) Ptolemaic/Hellenistic (interpretatio graeca + deliberate syncretic creation):
--       Osiris→Serapis, Horus→Harpocrates, Anubis/Hermes→Hermanubis,
--       Amun/Zeus→Zeus-Ammon, Hathor→Aphrodite
--   (b) Patristic/Christian (demonization of Seth; Isis iconographic influence on Mary):
--       Seth→Devil, Isis→Mary Theotokos
--
-- ENT_EGY_THOTH → ENT_HER_TRISMEGISTUS already in DB from seed data; not repeated.
-- ENT_EGY_NUT/HORUS/RA → Thelemic already in DB from add_thelemic_layer.sql.
--
-- New source: SRC_PLUTARCH_ISIS_OSIRIS (Plutarch, c. 100-120 CE) — the primary
-- Greco-Roman source for Egyptian religion, Serapis creation, Seth as cosmic evil,
-- and the Isis mystery tradition.
--
-- Existing sources used: SRC_PINCH_EGYPTIAN_MYTH, SRC_WILKINSON_EGYPTIAN_GODS
-- Requires: upgrade_v1_1_temporal.sql

BEGIN;

-- ── 1. New source ───────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_PLUTARCH_ISIS_OSIRIS',
   'Plutarch, On Isis and Osiris (De Iside et Osiride, c. 100–120 CE)',
   NULL,
   'primary text',
   'The fullest surviving Greco-Roman account of Egyptian religion; documents the Osiris myth, Seth as cosmic evil, the creation of Serapis under Ptolemy I, interpretatio graeca of Egyptian deities (Thoth=Hermes, Amun=Zeus, Hathor=Aphrodite), and the Isis mystery tradition; essential source for Egyptian→Greco-Egyptian transmission')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Transmission chains ─────────────────────────────────────────────────

-- 2a. Ptolemaic syncretic creations (PER_GRK_HELLENISTIC, -323 to -31)

-- Osiris → Serapis: the defining Ptolemaic syncretic act
-- Ptolemy I (305-283 BCE) introduced Serapis as a deliberate fusion of Osiris
-- (resurrection, afterlife) and the Apis bull with Greek deity attributes
-- (Zeus's majesty, Hades's underworld role, Asclepius's healing). The Greek
-- historian Plutarch (De Is. ch. 28) and Tacitus (Histories 4.83-84) document
-- the Ptolemaic creation. ENT_SYN_SERAPIS already exists in the DB.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_OSIRIS', 'received_as', 'ENT_SYN_SERAPIS',
   'high',
   'Serapis was deliberately created by Ptolemy I Soter (c. 286 BCE) as a syncretic fusion of Osiris and the Apis bull, supplemented with Greek attributes of Zeus, Hades, and Asclepius, to serve as a deity unifying Greek and Egyptian subjects of the new kingdom. Plutarch (De Is. ch. 28) documents the Ptolemaic invention; Tacitus (Histories 4.83) records the oracle that directed the creation. The Osirian element — resurrection, afterlife sovereignty, identification with the dead Pharaoh — is the primary Egyptian contribution to the Serapic complex. Highest-confidence Egyptian→syncretic chain in this dataset.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_SYN_SERAPIS', 'reception_of', 'ENT_EGY_OSIRIS',
   'high',
   'Serapis as the Ptolemaic Greco-Egyptian reception of Osiris; the resurrection and afterlife sovereignty of Osiris are the primary Egyptian contribution to the syncretic Serapic complex.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- Horus → Harpocrates: misread gesture, god of silence
-- Harpocrates (Harpokrates, "Horus the Child") is the Hellenistic reception
-- of the child Horus sitting on his mother Isis''s lap. Egyptian artistic
-- convention of the infant with finger to lips (indicating childhood) was
-- reinterpreted by Greeks as the gesture of silence, making Harpocrates
-- the Greco-Egyptian god of silence and secrets.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_HORUS', 'received_as', 'ENT_SYN_HARPOCRATES',
   'high',
   'Harpocrates (Greek Harpokrates, "Horus the Child") is the direct Hellenistic reception of the child Horus (Hor-pa-khered), depicted in Egyptian art as an infant with finger to lips — a conventional Egyptian gesture indicating childhood. Greek visitors reinterpreted this as a gesture of silence, making Harpocrates the Greco-Egyptian god of silence and keeper of divine secrets. The figure appears extensively in Ptolemaic and Roman-period material culture; Plutarch (De Is. ch. 19) discusses him. The Horus-child-on-Isis''s-lap iconography became the direct visual model for later representations of the Christ-child with the Virgin.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_SYN_HARPOCRATES', 'reception_of', 'ENT_EGY_HORUS',
   'high',
   'Harpocrates as Hellenistic reception of the child Horus; Egyptian finger-to-lips childhood gesture reinterpreted as the gesture of silence in Greek cultural context.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- Anubis + Hermes → Hermanubis: the dual-psychopomp fusion
-- Both Anubis and Hermes guide souls of the dead; their fusion as Hermanubis
-- was natural in the Ptolemaic religious synthesis. Hermanubis appears in
-- Greek magical papyri, dedicatory inscriptions, and Plutarch (De Is. ch. 61).
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_ANUBIS', 'received_as', 'ENT_SYN_HERMANUBIS',
   'high',
   'Hermanubis (Ἑρμάνουβις) fuses Anubis and Hermes in their shared role as psychopomps — guides of the dead to the underworld. Anubis''s Egyptian function (weighing souls, conducting the dead to Osiris''s judgment) and Hermes''s Greek function (psychopomp, conductor of souls to Hades) are functionally identical, making the fusion natural in Greco-Egyptian religious synthesis. Plutarch (De Is. ch. 61) mentions Hermanubis; the figure appears throughout Greco-Egyptian papyri and material culture.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_SYN_HERMANUBIS', 'reception_of', 'ENT_EGY_ANUBIS',
   'high',
   'Hermanubis as Greco-Egyptian reception of Anubis in his psychopomp function; fused with Hermes in the shared role of guide of souls.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC'),

  ('ENT_HERMES', 'received_as', 'ENT_SYN_HERMANUBIS',
   'high',
   'Hermes as the Greek psychopomp fused with Anubis in the Greco-Egyptian Hermanubis; the fusion is grounded in the identical function of conducting souls of the dead. Hermes Psychopomp + Anubis = Hermanubis, documented in Ptolemaic inscriptions, Greek magical papyri, and Plutarch.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_SYN_HERMANUBIS', 'reception_of', 'ENT_HERMES',
   'high',
   'Hermanubis as Greco-Egyptian reception of Hermes in his psychopomp function; fused with Anubis in the shared role of guide of souls of the dead.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- 2b. Archaic/Classical interpretatio graeca (PER_GRK_CLASSICAL, -480 to -323)

-- Amun + Zeus → Zeus-Ammon: the earliest documented interpretatio graeca
-- Herodotus (2.42, c. 450 BCE) explicitly identifies Zeus with Amun.
-- The Oracle of Zeus-Ammon at Siwa was famous throughout the Greek world
-- well before Alexander; Pindar composed a hymn to Ammon.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_AMUN', 'received_as', 'ENT_SYN_ZEUS_AMMON',
   'high',
   'Zeus-Ammon (Ζεὺς Ἄμμων) is one of the earliest and most documented cases of interpretatio graeca: Herodotus (2.42, c. 450 BCE) explicitly identifies Zeus with the Libyan-Egyptian Amun, noting that the Egyptians "call Zeus Amun." The Oracle of Ammon at Siwa was visited by Croesus, consulted by Cimon, and most famously by Alexander the Great in 331 BCE (who used the identification politically to claim divine parentage). Pindar composed a hymn to Ammon (fr. 36). Plutarch (De Is. ch. 9) also discusses the identification. The syncretic figure Zeus-Ammon was then depicted as Zeus with ram''s horns (Amun''s attribute).',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_CLASSICAL'),
  ('ENT_SYN_ZEUS_AMMON', 'reception_of', 'ENT_EGY_AMUN',
   'high',
   'Zeus-Ammon as the Greco-Egyptian reception of Egyptian Amun; identified with Zeus by Herodotus (2.42); the ram''s horns of the syncretic figure are Amun''s attribute.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_CLASSICAL'),

  ('ENT_ZEUS', 'received_as', 'ENT_SYN_ZEUS_AMMON',
   'high',
   'Zeus as the Greek partner in the Zeus-Ammon syncretism; Herodotus (2.42) makes the identification explicit. The Zeus-Ammon figure inherits Zeus''s supreme deity status and Olympian authority in the syncretic complex.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_CLASSICAL'),
  ('ENT_SYN_ZEUS_AMMON', 'reception_of', 'ENT_ZEUS',
   'high',
   'Zeus-Ammon as the Greco-Egyptian reception of Zeus; the Olympian high-god identified with Amun by Herodotus; Zeus''s divine sovereignty received into the syncretic figure.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_CLASSICAL')
ON CONFLICT DO NOTHING;

-- Hathor → Aphrodite: love/beauty goddess interpretatio graeca
-- Herodotus (2.41) explicitly equates Aphrodite with the Egyptian Hathor.
-- Both govern love, beauty, music, dance, and fertility; both are associated
-- with the cow (Hathor''s sacred animal; Aphrodite''s connection to Cyprus where
-- cattle sacrifice was practiced). The identification is one of the clearest
-- functional interpretatio graeca cases.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_HATHOR', 'received_as', 'ENT_APHRODITE',
   'medium',
   'Herodotus (2.41, c. 450 BCE) explicitly equates Aphrodite with Hathor, noting that "what the Greeks call Aphrodite Urania, the Egyptians call the same goddess Isis." The identification rests on shared domains (love, beauty, music, dance, fertility) and the sacred cow (Hathor''s primary animal; Aphrodite''s connection to Cyprus where cattle sacrifice was prominent). Plutarch (De Is. ch. 57) also discusses the identification. Note: this adds an Egyptian source for Aphrodite alongside the Canaanite Astarte chain already in the DB — both Hathor and Astarte contributed to the Aphrodite complex.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_CLASSICAL'),
  ('ENT_APHRODITE', 'reception_of', 'ENT_EGY_HATHOR',
   'medium',
   'Aphrodite as Greek reception of Egyptian Hathor via interpretatio graeca; Herodotus 2.41 equates them; shared domains of love, beauty, music, and the sacred cow. Second source of Aphrodite alongside Canaanite Astarte.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_CLASSICAL')
ON CONFLICT DO NOTHING;

-- 2c. Patristic/Christian reception (PER_PATRISTIC, 100-450 CE)

-- Seth → Devil: the demonized chaos-deity adopted into Christian iconography
-- Seth''s demonization occurred first within Egyptian tradition itself (from
-- Ramesside period onward, Seth-worship declined and Seth became the paradigmatic
-- evil deity). Plutarch (De Is.) explicitly equates Seth with Typhon and with the
-- principle of cosmic evil. In Late Antique Egypt, Seth was identified with the
-- Christian Devil; his distinctive zoomorphic head contributed to demonic iconography.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_SETH', 'received_as', 'ENT_CHR_DEVIL',
   'medium',
   'Seth''s reception as the Christian Devil operates through two parallel routes: (1) Plutarch (De Is. chs. 49-51) systematically equates Seth/Typhon with the principle of cosmic evil opposing Osiris/good — a dualism that Patristic authors absorbed into their cosmological framework. (2) In Late Antique Egypt, Seth was explicitly identified with Satan in Coptic Christian texts; his zoomorphic iconography (long-eared, fork-tailed, red-pelted "Seth animal") contributed to demonic iconographic vocabulary. The Seth→Devil chain is not as direct as Apollo→Apollyon, but the theological and iconographic influence is documented in Late Antique Egyptian Christianity.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_CHR_DEVIL', 'reception_of', 'ENT_EGY_SETH',
   'medium',
   'The Christian Devil absorbs Seth''s role as cosmic evil opposing divine good (via Plutarch''s interpretation) and Seth''s iconographic features in Late Antique Egyptian Christianity.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_PATRISTIC')
ON CONFLICT DO NOTHING;

-- Isis → Mary Theotokos: the most documented Egyptian→Christian iconographic transmission
-- The Isis lactans (nursing Horus/Harpocrates) → Virgo lactans (Mary nursing Jesus);
-- "Queen of Heaven" title; star-and-crescent crown; mourning at the death of the
-- divine son; miraculous conception. Scholarly consensus: direct iconographic influence
-- in Late Antique Egypt; theological continuity is debated. Medium confidence:
-- iconographic parallel is strong; causal direction is not always provable.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_ISIS', 'received_as', 'ENT_SAINT_MARY',
   'medium',
   'The Isis → Mary transmission is the most-discussed Egyptian→Christian iconographic reception. Core parallels: (1) Isis lactans (nursing the infant Horus/Harpocrates) is the direct visual antecedent of the Virgo lactans iconographic type, particularly in Egypt where Coptic Christians reused Isis-with-Horus statuary for Mary-with-Jesus. (2) Isis''s title "Queen of Heaven" (explicitly attested in inscriptions) was applied to Mary (Jeremiah 7:18 condemns Queen of Heaven worship; the title resurfaces as Mary''s Marian title). (3) The crown of stars and lunar crescent, the blue mantle, the mourning at the death of the divine son — all appear in Isis imagery before Mary''s. Plutarch (De Is. ch. 52-53) documents the Isis mystery tradition. The most influential scholarly treatment: R.E. Witt, Isis in the Graeco-Roman World (1971). Confidence medium: the iconographic parallels in Late Antique Egypt are strong and documented; the degree to which early Christians consciously drew on Isis tradition (vs. parallel development) is debated.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_PATRISTIC'),
  ('ENT_SAINT_MARY', 'reception_of', 'ENT_EGY_ISIS',
   'medium',
   'Mary Theotokos as the Christian reception — primarily iconographic — of the Isis tradition; nursing-mother imagery, Queen of Heaven title, star-crown, mourning at divine son''s death all transmitted from Isis to Mary in Late Antique Egyptian Christianity.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_PATRISTIC')
ON CONFLICT DO NOTHING;

-- ── 3. Verification ────────────────────────────────────────────────────────

SELECT 'egyptian_reception_chains' AS metric,
       COUNT(*) AS count
FROM entity_relationships
WHERE relationship_type IN ('received_as','reception_of')
AND (subject_entity_id LIKE 'ENT_EGY_%' OR object_entity_id LIKE 'ENT_EGY_%'
  OR subject_entity_id LIKE 'ENT_SYN_%' OR object_entity_id LIKE 'ENT_SYN_%');

SELECT * FROM v_release_metrics;

COMMIT;
