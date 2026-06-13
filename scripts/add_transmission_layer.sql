-- Items 4+5: Hermes Trismegistus + key reception entities + transmission chains
-- Adds the first walkable diachronic chains to the graph using received_as + period_id.

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- Item 4: Hermes Trismegistus
-- The single most important missing transmission node.
-- Synthesizes Greek Hermes + Egyptian Thoth in the Hellenistic period;
-- becomes the named author of the Corpus Hermeticum;
-- received into Renaissance Hermeticism (Ficino, 1463).
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entities (
    entity_id, canonical_name, tradition, entity_type, category,
    primary_domains, tags, inclusion_basis, short_note,
    evidence_confidence, review_status
)
VALUES (
    'ENT_HER_TRISMEGISTUS',
    'Hermes Trismegistus',
    'Hermetic/Greco-Egyptian',
    'revealer',
    'Revealer Figure',
    'wisdom; revelation; alchemy; magic; cosmic mediation; theurgy',
    'hermetic; greco-egyptian; revelation; wisdom; alchemy; trismegistus',
    'Corpus Hermeticum (primary texts); Fowden, The Egyptian Hermes (1986)',
    'Greco-Egyptian syncretic revealer figure combining Greek Hermes and Egyptian Thoth. Named author of the Corpus Hermeticum. Central to Hermetic tradition from the Hellenistic period through the Renaissance.',
    'A',
    'reviewed'
)
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
    ('ENT_HER_TRISMEGISTUS', 'SRC_CORPUS_HERMETICUM', 'primary_attestation',
     'Named author/revealer in the Corpus Hermeticum; the Hermetica are framed as his revelations.'),
    ('ENT_HER_TRISMEGISTUS', 'SRC_ASCLEPIUS_HERMETICA', 'primary_attestation',
     'Present as teacher and revealer in the Asclepius.')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
VALUES
    ('ENT_HER_TRISMEGISTUS', 'PER_HER_HELLENISTIC', 'high',
     'Corpus Hermeticum composed in Hellenistic–Imperial Egypt; figure synthesized from Greek Hermes and Egyptian Thoth in this period.'),
    ('ENT_HER_TRISMEGISTUS', 'PER_RENAISSANCE', 'high',
     'Received into Renaissance Hermeticism when Ficino translated the Corpus Hermeticum (1463) for Cosimo de'' Medici.')
ON CONFLICT DO NOTHING;

-- Syncretism and transmission edges
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_HER_TRISMEGISTUS', 'syncretized_with', 'ENT_HERMES',
     'high', 'Hermes Trismegistus is the Hellenistic synthesis of Greek Hermes.', 'reviewed'),
    ('ENT_HER_TRISMEGISTUS', 'syncretized_with', 'ENT_EGY_THOTH',
     'high', 'Hermes Trismegistus is the Hellenistic synthesis of Egyptian Thoth.', 'reviewed'),
    ('ENT_HER_TRISMEGISTUS', 'reveals', 'ENT_WISDOM',
     'high', 'The Hermetic texts are framed as Hermes Trismegistus revealing divine wisdom.', 'reviewed'),
    ('ENT_HER_TRISMEGISTUS', 'teaches', 'ENT_HIDDEN_KNOWLEDGE',
     'high', 'The Corpus Hermeticum presents Hermes Trismegistus as teacher of hidden cosmic knowledge.', 'reviewed'),
    ('ENT_HER_TRISMEGISTUS', 'patron_of', 'ENT_MAGIC',
     'medium', 'Hermes Trismegistus is associated with magical arts in the Hermetic tradition.', 'reviewed')
ON CONFLICT DO NOTHING;

-- received_as chains (with period_id)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_HERMES', 'received_as', 'ENT_HER_TRISMEGISTUS',
     'high',
     'Greek Hermes received as Hermes Trismegistus in the Hellenistic Greco-Egyptian synthesis; his attributes (psychopomp, messenger, patron of wisdom) were merged with Egyptian Thoth.',
     'reviewed', 'PER_HER_HELLENISTIC'),
    ('ENT_EGY_THOTH', 'received_as', 'ENT_HER_TRISMEGISTUS',
     'high',
     'Egyptian Thoth received as Hermes Trismegistus in Hellenistic interpretatio; Thoth''s roles as scribe, wisdom deity, and master of magic were absorbed into the Hermetic figure.',
     'reviewed', 'PER_HER_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Item 5a: Hecate — Patristic demonization reception entity
-- Hecate was recast as a demon, queen of night-spirits, and servant of Satan
-- in patristic and early medieval Christian literature.
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entities (
    entity_id, canonical_name, tradition, entity_type, category,
    primary_domains, tags, inclusion_basis, short_note,
    evidence_confidence, review_status
)
VALUES (
    'ENT_REC_HECATE_PATRISTIC',
    'Hecate (Patristic Reception)',
    'Christian reception',
    'demon',
    'Demonized Figure',
    'demons; magic; night; sorcery; spirits',
    'demonized; hecate; patristic; christian reception; night',
    'SRC_CHRISTIAN_DEMONOLOGY_GENERAL; patristic sources (Origen, Lactantius)',
    'Greek goddess Hecate recast as a demon, queen of night-wandering spirits, or servant of Satan in patristic and early medieval Christian literature. Represents the demonization of the liminal, chthonic goddess.',
    'B',
    'reviewed'
)
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES (
    'ENT_REC_HECATE_PATRISTIC', 'SRC_CHRISTIAN_DEMONOLOGY_GENERAL', 'secondary_reference',
    'Hecate identified as a demon or demonic queen in patristic demonological literature.'
)
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
VALUES
    ('ENT_REC_HECATE_PATRISTIC', 'PER_PATRISTIC', 'medium',
     'Patristic authors begin recasting Hecate as demonic in 2nd–5th c. CE.'),
    ('ENT_REC_HECATE_PATRISTIC', 'PER_MEDIEVAL_WEST', 'medium',
     'Demonization continues and deepens in medieval Western Christian demonology.')
ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_REC_HECATE_PATRISTIC', 'opposes', 'ENT_CHR_DEVIL',
     'medium', 'Hecate in Christian reception is subordinated to or identified with the demonic realm under Satan.', 'reviewed')
ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_HECATE', 'received_as', 'ENT_REC_HECATE_PATRISTIC',
     'medium',
     'Greek Hecate received as a demon or demonic queen in patristic Christian literature; her liminal, chthonic, and magical attributes were recast as demonic in a Christian cosmological frame.',
     'reviewed', 'PER_PATRISTIC')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Item 5b: Transmission chains using existing entities
-- Wire up the most important received_as edges between entities already in the graph.
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES

    -- Satan (Second Temple adversarial being) → Devil (Christian)
    -- The most important single transmission chain in Western religion
    ('ENT_ISR_SATAN', 'received_as', 'ENT_CHR_DEVIL',
     'high',
     'Second Temple Satan (adversarial accuser/tester figure) received as the Devil (cosmic adversary of God and humanity) in patristic Christian theology. Key sources: Justin Martyr, Origen, Tertullian.',
     'reviewed', 'PER_PATRISTIC'),

    -- Greek Daimones collective → Christian demons (patristic identification)
    -- Justin Martyr and Origen explicitly identified Greek daimones with Christian demons
    ('ENT_LAT_DAIMONES', 'received_as', 'ENT_CHR_DEVIL',
     'medium',
     'The Greek philosophical category of daimones received as the Christian category of demons in patristic apologetics; Justin Martyr and Origen identified the pagan daimones with fallen angels/demons.',
     'reviewed', 'PER_PATRISTIC'),

    -- Devil → Lucifer (medieval reception crystallizes the identification)
    ('ENT_CHR_DEVIL', 'received_as', 'ENT_CHR_LUCIFER',
     'high',
     'The Christian Devil received as Lucifer in medieval Western theology, synthesizing Isaiah 14:12 (''Helel ben Shachar'') with the figure of the fallen angel. Crystallized by Jerome''s Vulgate (Lucifer) and subsequent exegesis.',
     'reviewed', 'PER_MEDIEVAL_WEST'),

    -- Agathos Daimon (Greek) → Hermetic Agathos Daimon
    ('ENT_AGATHOS_DAIMON', 'received_as', 'ENT_LAT_AGATHOS_DAIMON_HERMETIC',
     'medium',
     'Greek household Agathos Daimon received into the Hermetic tradition as a revealer figure and cosmic spirit; appears in Corpus Hermeticum as an interlocutor.',
     'reviewed', 'PER_HER_HELLENISTIC')

ON CONFLICT DO NOTHING;

-- reception_of (inverse) edges for the new chains
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_HER_TRISMEGISTUS', 'reception_of', 'ENT_HERMES',
     'high', 'Hermes Trismegistus is the Hermetic reception of Greek Hermes.', 'reviewed', 'PER_HER_HELLENISTIC'),
    ('ENT_HER_TRISMEGISTUS', 'reception_of', 'ENT_EGY_THOTH',
     'high', 'Hermes Trismegistus is the Hermetic reception of Egyptian Thoth.', 'reviewed', 'PER_HER_HELLENISTIC'),
    ('ENT_CHR_DEVIL', 'reception_of', 'ENT_ISR_SATAN',
     'high', 'The Christian Devil is the patristic reception of the Second Temple Satan figure.', 'reviewed', 'PER_PATRISTIC'),
    ('ENT_CHR_LUCIFER', 'reception_of', 'ENT_CHR_DEVIL',
     'high', 'Lucifer is the medieval Western reception of the Christian Devil.', 'reviewed', 'PER_MEDIEVAL_WEST'),
    ('ENT_REC_HECATE_PATRISTIC', 'reception_of', 'ENT_HECATE',
     'medium', 'The patristic demonized Hecate is the Christian reception of Greek Hecate.', 'reviewed', 'PER_PATRISTIC')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Demonstrate the graph: walk a chain
-- ─────────────────────────────────────────────────────────────────────────────

-- Chain 1: Thoth → Hermes Trismegistus
SELECT
    'Chain: Thoth → Hermes Trismegistus' AS chain,
    e1.canonical_name AS from_entity,
    e1.tradition AS from_tradition,
    er.relationship_type,
    p.period_name AS reception_period,
    e2.canonical_name AS to_entity,
    e2.tradition AS to_tradition
FROM entity_relationships er
JOIN entities e1 ON er.subject_entity_id = e1.entity_id
JOIN entities e2 ON er.object_entity_id = e2.entity_id
LEFT JOIN periods p ON er.period_id = p.period_id
WHERE er.relationship_type IN ('received_as','reception_of','syncretized_with')
  AND (e1.entity_id = 'ENT_EGY_THOTH' OR e2.entity_id = 'ENT_HER_TRISMEGISTUS')
ORDER BY er.relationship_type, e1.canonical_name;

-- Chain 2: Satan → Devil → Lucifer
SELECT
    'Chain: Satan → Devil → Lucifer' AS chain,
    e1.canonical_name AS from_entity,
    e1.tradition AS from_tradition,
    er.relationship_type,
    p.period_name AS reception_period,
    e2.canonical_name AS to_entity,
    e2.tradition AS to_tradition
FROM entity_relationships er
JOIN entities e1 ON er.subject_entity_id = e1.entity_id
JOIN entities e2 ON er.object_entity_id = e2.entity_id
LEFT JOIN periods p ON er.period_id = p.period_id
WHERE er.relationship_type = 'received_as'
  AND e1.entity_id IN ('ENT_ISR_SATAN','ENT_CHR_DEVIL','ENT_LAT_DAIMONES')
ORDER BY p.start_year;

COMMIT;
