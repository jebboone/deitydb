-- scripts/add_thracian_layer.sql
-- Adds five Thracian entities: updates ENT_SABAZIOS, ENT_BENDIS, ENT_COTYS from
-- tradition='Greek' to tradition='Thracian' with proper sourcing, and introduces
-- two new entities: ENT_THRA_ZALMOXIS and ENT_THRA_GEBELEIZIS.
--
-- Primary sources:
--   Sabazios:    Herodotus 5.7; Aristophanes Wasps 422 BCE; Demosthenes On the Crown 330 BCE
--   Bendis:      Herodotus 5.7; Plato Republic 327a (opening Bendideia scene)
--   Cotys:       Aeschylus Edoni fr. 57; Eupolis fr. 85; Theopompus FGrHist 115 F 64
--   Zalmoxis:    Herodotus 4.94-96; Plato Charmides 156d-157c
--   Gebeleizis:  Herodotus 4.94

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_ARCHIBALD_ODRYSIAN',
 'Zosia H. Archibald, The Odrysian Kingdom of Thrace: Orpheus Unmasked (Clarendon Press, Oxford, 1998)',
 'secondary scholarly',
 'Standard scholarly monograph on the Odrysian kingdom and Thracian religion across the Iron Age and Hellenistic periods. Covers the principal Thracian deities — Sabazios, Bendis, Cotys, Zalmoxis, and the Thracian Horseman — their attestation in Greek literary sources and Thracian epigraphy, and the reception of Thracian cults in Athens and the broader Greek world. Chapter 8 ("Religion") is the key reference for the Bendideia in Athens (official state reception by 429 BCE decree), the Cotytian rites, and the Sabazios tradition. Archibald situates Thracian religion within its socio-political context as a peripheral culture in intense contact with the Greek world. pp. 299-306 address Zalmoxis and Gebeleizis in the Getae tradition. Primary citation for all Thracian entities in this layer.'),
('SRC_PLATO_REPUBLIC',
 'Plato, Republic (c. 375 BCE)',
 'primary literary',
 'Plato''s central dialogue on justice, the ideal state, and the nature of the soul. The opening sentence (Republic 327a) explicitly situates the dialogue at the Piraeus festival of Bendis: "I had gone down yesterday to the Piraeus with Glaucon son of Ariston to pray to the goddess, and also because I wanted to see how they would conduct the festival, since this was its first celebration." The goddess is identified as Bendis, confirming that the Thracian deity''s Athenian cult was of recent, official establishment. The Piraeus Bendideia is thus attested in one of the most widely-read texts of classical antiquity. Also relevant for Thracian soul-doctrine: Plato Charmides 156d-157c cites a Thracian physician of Zalmoxis who teaches that the soul must be treated before the body — presenting Zalmoxis as a revealer of holistic soul-medicine.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_THRA_IRON_AGE',
 'Thracian',
 'Thracian Iron Age and Classical Period',
 -700, 150,
 'Period of documented Thracian religious and cultural activity, from the emergence of the Odrysian kingdom and earliest Greek attestations of Thracian deities (c. 700 BCE) through the Roman absorption of Thrace (Claudius established the province in 46 CE) and into the early Imperial period when Thracian mystery cults — Sabazios, Bendis, Cotys — continued spreading through the Roman Empire. Primary Greek attestations cluster in the 5th–4th c. BCE: Herodotus on Zalmoxis and Gebeleizis (c. 430 BCE), Aristophanes and Demosthenes on Sabazios in Athens, Plato on Bendis (Republic 327a, c. 375 BCE). Archibald (1998) is the standard secondary reference for the Odrysian kingdom and Thracian religion.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Update existing entities: reclassify from Greek → Thracian ─────────────
UPDATE entities
SET tradition         = 'Thracian',
    entity_type       = 'Thracian sky-thunder god',
    category          = 'Mystery Deity',
    primary_domains   = 'sky; thunder; mystery cult; serpent; ecstasy; protection; initiation',
    evidence_confidence = 'A',
    short_note        = 'Thracian (and Phrygian) sky-thunder deity received into Greek and Roman mystery religion. Attested in Athens from the 5th c. BCE: Aristophanes mocks the Sabazian cult in Wasps (422 BCE) and Birds (414 BCE); Demosthenes'' On the Crown (330 BCE) alludes to Sabazian initiatory rites. Herodotus 5.7 identifies the three Thracian gods as Ares, Dionysus, and Artemis — scholarship identifies the Dionysian/ecstatic position with Sabazios. In the Roman period he appears as Zeus Sabazios (syncretism with the sky-father) in votive tablets from Rome and Anatolia. The cult''s characteristic emblem is the manus Sabaziana — an open hand showing the serpent, pine cone, and other divine attributes. Archibald (1998) ch. 8; Burkert (1985) pp. 179-181.'
WHERE entity_id = 'ENT_SABAZIOS';

UPDATE entities
SET tradition         = 'Thracian',
    entity_type       = 'Thracian goddess',
    category          = 'Moon Deity',
    primary_domains   = 'moon; hunt; fire; night; mystery cult',
    evidence_confidence = 'A',
    short_note        = 'Thracian hunting and moon goddess; the most thoroughly documented Thracian deity in Athens. Her Athenian cult was officially established by state decree by 429 BCE, making the Bendideia festival the first formally recognised foreign cult in Athens. Plato opens the Republic (327a) at the Bendideia in the Piraeus. Herodotus 5.7 lists Artemis as one of the three Thracian gods — scholarship identifies Artemis with Bendis in this context. The equation Bendis ↔ Artemis is explicit in Athenian votive inscriptions; she is also equated with Hecate in some traditions. Iconography: twin torches and hunting dress. Archibald (1998) ch. 8.'
WHERE entity_id = 'ENT_BENDIS';

UPDATE entities
SET tradition         = 'Thracian',
    entity_type       = 'Thracian goddess',
    category          = 'Mystery Deity',
    primary_domains   = 'ecstatic rites; mystery cult; orgy; night; initiation',
    evidence_confidence = 'B',
    short_note        = 'Thracian goddess of orgiastic mystery rites; her cult (the Cotytia) spread to Athens, Corinth, and Macedon. Attested in Attic comedy (Eupolis fr. 85 Kassel-Austin), Aeschylus'' lost Edoni (fr. 57, depicting Thracian ecstatic rites), and Theopompus of Chios (FGrHist 115 F 64). In Greek interpretation Cotys is equated with Rhea/Cybele as the Thracian form of the Great Mother. The Cotytia were notable for ritual transgression and licence. Confidence B: well attested but known mainly through Greek literary criticism of foreign cult practice. Archibald (1998) ch. 8; Burkert (1985) p. 177.'
WHERE entity_id = 'ENT_COTYS';

-- ── 4. New entities ───────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_THRA_ZALMOXIS',
 'Zalmoxis',
 'Thracian',
 'deity / deified revealer figure',
 'Mystery Figure',
 'immortality; afterlife; mystery initiation; soul doctrine; the Getae',
 'A',
 'Deity (or deified human) of the Getae, a Thracian people north of the Danube; also spelled Zamolxis, Salmoxis. Primary source: Herodotus 4.94-96 (c. 430 BCE). Herodotus reports that the Getae "claim immortality" — they believe they do not die but go to Zalmoxis. Every four years they send a messenger to the deity by throwing a man onto spears to communicate their needs. Herodotus also records the Greek rationalist tradition: Zalmoxis was a Thracian who had been a slave of Pythagoras, learned Greek customs, built a hall to entertain notables, then disappeared underground for three years before re-emerging, convincing people he had visited the realm of the dead. Herodotus is sceptical of this story and notes it may predate Pythagoras. Plato (Charmides 156d-157c) cites a Thracian physician of Zalmoxis who teaches that soul must be healed before body — presenting Zalmoxis as a teacher of holistic soul-doctrine. Eliade (1970) treats him as a shaman-king type; Burkert notes structural parallels with Orphic mystery traditions. Archibald (1998) pp. 299-301.'),
('ENT_THRA_GEBELEIZIS',
 'Gebeleizis',
 'Thracian',
 'Thracian sky deity',
 'Thunder Deity',
 'sky; thunder; lightning; storm; the Getae',
 'B',
 'Sky and thunder deity of the Getae; attested once, in Herodotus 4.94 (c. 430 BCE): "When it thunders and lightnings, these Thracians [the Getae] shoot their arrows up into the sky, threatening the god [Gebeleizis], since they believe no god exists but their own." Herodotus immediately thereafter recounts the Zalmoxis tradition (4.95-96) without clearly distinguishing the two divine names. Scholars debate whether Gebeleizis and Zalmoxis are the same deity in different aspects — sky/storm (Gebeleizis) vs. afterlife/mystery (Zalmoxis) — or two distinct figures. Coman (1938) and Eliade (1970) treat them as aspects of a single Getae deity; Archibald (1998) p. 300 is more cautious. The single attestation limits certainty; confidence is B.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 5. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
-- Sabazios
('ENT_SABAZIOS', 'SRC_ARCHIBALD_ODRYSIAN', 'Secondary scholarly',
 'Archibald (1998) ch. 8: Sabazios as Thracian sky-thunder deity; his reception into Athenian religion in the 5th c. BCE; cult spread through Greece and Rome; the manus Sabaziana iconography.'),
('ENT_SABAZIOS', 'SRC_HERODOTUS_HISTORIES', 'Primary literary',
 'Herodotus 5.7: the three Thracian gods described as Ares, Dionysus, and Artemis. Scholarship identifies the Dionysian/ecstatic figure in this triad with Sabazios. Not named directly, but key for Thracian divine typology.'),
('ENT_SABAZIOS', 'SRC_BURKERT_GREEK_RELIGION', 'Secondary scholarly',
 'Burkert (1985) pp. 179-181: Sabazios in the context of Greek mystery religion; Aristophanes and Demosthenes attestations; the Athenian cult and Roman-period Zeus Sabazios.'),
-- Bendis
('ENT_BENDIS', 'SRC_ARCHIBALD_ODRYSIAN', 'Secondary scholarly',
 'Archibald (1998) ch. 8: Bendis in Athens; the official state decree establishing the Bendideia by 429 BCE; Piraeus cult location; Thracian iconography (twin torches, hunting gear).'),
('ENT_BENDIS', 'SRC_PLATO_REPUBLIC', 'Primary literary',
 'Republic 327a: Plato opens the dialogue at the Piraeus Bendideia festival, explicitly naming Bendis as "the goddess." Confirms the official Athenian state festival and its recent establishment. The most widely cited literary attestation of the Bendis cult.'),
('ENT_BENDIS', 'SRC_HERODOTUS_HISTORIES', 'Primary literary',
 'Herodotus 5.7: the three Thracian gods include Artemis — scholarship identifies this with Bendis in the Athenian reception context. Herodotus writing c. 430 BCE, contemporary with the Bendideia decree.'),
-- Cotys
('ENT_COTYS', 'SRC_ARCHIBALD_ODRYSIAN', 'Secondary scholarly',
 'Archibald (1998) ch. 8: the Cotytia in Athens, Corinth, and Macedon; spread of the cult; Greek literary attestations from Attic comedy and Aeschylus Edoni.'),
('ENT_COTYS', 'SRC_BURKERT_GREEK_RELIGION', 'Secondary scholarly',
 'Burkert (1985) p. 177: Cotys and the Cotytia as Thracian mystery rites; the equation with Rhea/Cybele; Aeschylus Edoni fr. 57 and the ecstatic ritual context.'),
-- Zalmoxis
('ENT_THRA_ZALMOXIS', 'SRC_HERODOTUS_HISTORIES', 'Primary literary',
 'Herodotus 4.94-96: the longest ancient account of Zalmoxis — the Getae belief in immortality, the four-year messenger ritual, and the Greek rationalist alternative of Zalmoxis as former slave of Pythagoras. Primary and most detailed attestation; Herodotus himself is sceptical of the Greek version.'),
('ENT_THRA_ZALMOXIS', 'SRC_ARCHIBALD_ODRYSIAN', 'Secondary scholarly',
 'Archibald (1998) pp. 299-301: Zalmoxis in the context of Getae religion; the problem of Gebeleizis; comparison with Orphic and Pythagorean mystery traditions; shaman-king interpretations.'),
('ENT_THRA_ZALMOXIS', 'SRC_ELIADE_ER', 'Secondary scholarly',
 'Encyclopedia of Religion, "Zalmoxis" entry: the shaman-king interpretation (Eliade 1970); comparison with Orpheus; Zalmoxis as paradigmatic mystery-initiation figure of Eastern Europe.'),
-- Gebeleizis
('ENT_THRA_GEBELEIZIS', 'SRC_HERODOTUS_HISTORIES', 'Primary literary',
 'Herodotus 4.94: sole ancient attestation — the Getae shoot arrows at the sky to threaten Gebeleizis during thunderstorms, believing no god exists but their own. Immediately precedes the Zalmoxis account.'),
('ENT_THRA_GEBELEIZIS', 'SRC_ARCHIBALD_ODRYSIAN', 'Secondary scholarly',
 'Archibald (1998) p. 300: Gebeleizis as Getae sky deity; the scholarly debate over identity with or distinction from Zalmoxis; limited evidence counsels caution.')
ON CONFLICT DO NOTHING;

-- ── 6. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_SABAZIOS',        'PER_THRA_IRON_AGE', 'high',
 'Sabazios attested in Athens from the 5th c. BCE (Aristophanes Wasps 422 BCE; Demosthenes 330 BCE); Thracian Iron Age origin; cult persisted through the Roman Imperial period as Zeus Sabazios.',
 'SRC_ARCHIBALD_ODRYSIAN', 'reviewed'),
('ENT_BENDIS',          'PER_THRA_IRON_AGE', 'high',
 'Official Athenian state cult by 429 BCE decree; Plato Republic 327a (c. 375 BCE) opens at the Bendideia. Thracian Iron Age origin; Athenian Classical-period reception.',
 'SRC_PLATO_REPUBLIC', 'reviewed'),
('ENT_COTYS',           'PER_THRA_IRON_AGE', 'high',
 'Cotytia attested in Attic comedy of the late 5th c. BCE (Eupolis fr. 85) and Aeschylus Edoni (possibly 470s BCE). Spread to Corinth and Macedon by the 4th c. BCE.',
 'SRC_ARCHIBALD_ODRYSIAN', 'reviewed'),
('ENT_THRA_ZALMOXIS',   'PER_THRA_IRON_AGE', 'high',
 'Herodotus 4.94-96 (c. 430 BCE) is the primary attestation; Plato Charmides 156d (c. 380 BCE) a secondary one. Reflects Getae Iron Age religious practice of northern Thrace and the lower Danube.',
 'SRC_HERODOTUS_HISTORIES', 'reviewed'),
('ENT_THRA_GEBELEIZIS', 'PER_THRA_IRON_AGE', 'high',
 'Herodotus 4.94 (c. 430 BCE): sole attestation, in the context of Getae religion alongside the Zalmoxis tradition.',
 'SRC_HERODOTUS_HISTORIES', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 7. Remove stale seed relationship ─────────────────────────────────────────
-- ENT_SABAZIOS member_of ENT_PHRYG_MATAR was a low-confidence seed association;
-- Sabazios is not a member of Matar Kubileya's cult — they are parallel Anatolian
-- sky/mystery deities, not hierarchically related.
DELETE FROM entity_relationships
WHERE subject_entity_id = 'ENT_SABAZIOS'
  AND relationship_type  = 'member_of'
  AND object_entity_id   = 'ENT_PHRYG_MATAR';

-- ── 8. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Sabazios ↔ Zeus / Dionysus (Greek and Roman syncretism)
('ENT_SABAZIOS', 'syncretized_with', 'ENT_ZEUS',
 'high',
 'Roman-period votive tablets from Rome and Anatolia explicitly name Zeus Sabazios, merging the Thracian sky-thunder deity with the Greek sky-father. The equation reflects shared sky-father and thunder functions. Burkert (1985) pp. 179-181; Archibald (1998) ch. 8.',
 'SRC_BURKERT_GREEK_RELIGION', 'PER_THRA_IRON_AGE', 'reviewed'),
('ENT_SABAZIOS', 'syncretized_with', 'ENT_DIONYSUS',
 'high',
 'Herodotus 5.7 names Dionysus as one of the three Thracian gods; scholarship consistently identifies the Thracian ecstatic mystery deity in this position as Sabazios. Aristophanes mocks the Sabazian cult alongside Dionysian rites (Wasps 9-10; Birds 874). The identification is ancient and widespread. Archibald (1998) ch. 8.',
 'SRC_HERODOTUS_HISTORIES', 'PER_THRA_IRON_AGE', 'reviewed'),
-- Bendis additional equation with Hecate
('ENT_BENDIS', 'equated_with', 'ENT_HECATE',
 'medium',
 'Thracian Bendis is equated with Hecate in some ancient sources alongside the primary Artemis equation; both are nocturnal lunar hunting deities. Archibald (1998) ch. 8 notes the Hecate equation in Athenian votive material. Confidence medium: Artemis equation is primary, Hecate secondary.',
 'SRC_ARCHIBALD_ODRYSIAN', 'PER_THRA_IRON_AGE', 'reviewed'),
-- Zalmoxis
('ENT_THRA_ZALMOXIS', 'patron_of', 'ENT_DEAD',
 'high',
 'The core of the Zalmoxis cult as reported by Herodotus 4.94-95: the Getae believe they do not die but go to Zalmoxis, who is their deity of immortality and afterlife. The four-year messenger ritual (throwing a man onto spears to communicate with Zalmoxis) confirms his role as the sovereign of the dead and the revealer of immortality. Herodotus 4.94-96.',
 'SRC_HERODOTUS_HISTORIES', 'PER_THRA_IRON_AGE', 'reviewed'),
('ENT_THRA_ZALMOXIS', 'aligned_with', 'ENT_ORPHEUS',
 'medium',
 'Zalmoxis and Orpheus share structural parallels as Thracian-connected mystery figures associated with afterlife, soul-doctrine, and initiatory revelation. Both traditions promise immortality through initiation and involve divine instruction about the nature of the soul. Burkert, Ancient Mystery Cults (1987) pp. 11-12 and Eliade note the Thracian mystery parallel. This alignment is scholarly and structural, not an ancient explicit equation.',
 'SRC_ARCHIBALD_ODRYSIAN', 'PER_THRA_IRON_AGE', 'reviewed'),
-- Gebeleizis
('ENT_THRA_GEBELEIZIS', 'patron_of', 'ENT_STORM',
 'high',
 'Herodotus 4.94: the Getae shoot arrows at the sky to threaten Gebeleizis during thunderstorms, identifying him as the sky/storm deity. The act of threatening the deity with arrows during storms is the clearest possible attestation of his function as lord of storm and thunder.',
 'SRC_HERODOTUS_HISTORIES', 'PER_THRA_IRON_AGE', 'reviewed'),
('ENT_THRA_GEBELEIZIS', 'aligned_with', 'ENT_ZEUS',
 'medium',
 'Gebeleizis is a sky-thunder deity of the Getae, functionally parallel to Zeus as the Greek sky-father and thunderer. The interpretatio Graeca structure (Herodotus reporting Thracian gods via Greek divine categories) supports this alignment. Confidence medium: structural parallel is clear; no surviving ancient explicit equation.',
 'SRC_HERODOTUS_HISTORIES', 'PER_THRA_IRON_AGE', 'reviewed'),
('ENT_THRA_GEBELEIZIS', 'aligned_with', 'ENT_THRA_ZALMOXIS',
 'low',
 'In Herodotus 4.94-96 the transition from the Gebeleizis passage to the Zalmoxis account is abrupt, leading some scholars (Coman 1938; Eliade 1970) to interpret the two names as aspects of the same Getae deity — sky/storm aspect (Gebeleizis) vs. mystery/afterlife aspect (Zalmoxis). Archibald (1998) p. 300 treats them as potentially distinct. Low confidence given the single attestation of Gebeleizis and unclear ancient relationship.',
 'SRC_ARCHIBALD_ODRYSIAN', 'PER_THRA_IRON_AGE', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities
WHERE tradition = 'Thracian'
GROUP BY tradition;

SELECT e.canonical_name, e.tradition, COUNT(er.relationship_id) AS rels
FROM entities e
LEFT JOIN entity_relationships er
  ON (er.subject_entity_id = e.entity_id OR er.object_entity_id = e.entity_id)
WHERE e.entity_id IN ('ENT_SABAZIOS','ENT_BENDIS','ENT_COTYS','ENT_THRA_ZALMOXIS','ENT_THRA_GEBELEIZIS')
GROUP BY e.entity_id, e.canonical_name, e.tradition
ORDER BY e.canonical_name;

SELECT * FROM v_release_metrics;

COMMIT;
