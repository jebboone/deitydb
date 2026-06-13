-- Thelemic Reception Layer
-- Adds the four primary entities of Aleister Crowley's Thelema, as received
-- and radically transformed from Egyptian and earlier esoteric traditions.
--
-- Primary source: Aleister Crowley, Liber AL vel Legis (The Book of the Law)
--   Cairo, April 8-10 1904; first published The Equinox Vol. I No. 1 (1909).
--
-- All entities are labeled as 20th-century Thelemic reception; none are
-- presented as continuations of ancient Egyptian religion.

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. New period: 20th-century occultism
-- PER_19C_OCCULT ends at 1900; The Book of the Law is 1904.
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES (
    'PER_20C_OCCULT', 'Cross-traditional', '20th Century Occultism', 1900, 2000,
    'Aleister Crowley / Thelema (The Book of the Law, 1904), Hermetic Order successor bodies (A∴A∴, OTO), Wicca / Gerald Gardner (1951), Chaos Magick (1970s+), New Age Movement. Documented modern religious and esoteric developments distinct from 19th-century occultism.'
)
ON CONFLICT (period_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Source record
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, source_type, scope)
VALUES (
    'SRC_CROWLEY_BOOK_OF_LAW',
    'Aleister Crowley, Liber AL vel Legis (The Book of the Law) (Cairo, 1904; The Equinox Vol. I No. 1, London: Crowley, 1909)',
    'primary text',
    'Thelemic theology; the three chapters voiced by Nuit (I), Hadit (II), and Ra-Hoor-Khuit (III); Aiwass as the dictating intelligence; the Aeon of Horus; True Will doctrine'
)
ON CONFLICT (source_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. Entities
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entities (
    entity_id, canonical_name, tradition, entity_type, category,
    primary_domains, tags, inclusion_basis, short_note,
    evidence_confidence, review_status
)
VALUES

-- 3a. Nuit
(
    'ENT_THL_NUIT',
    'Nuit',
    'Thelemic',
    'deity',
    'Deity',
    'cosmos; infinity; stars; night; space; polarity',
    'thelema; nuit; crowley; 20th-century; modern reception; egyptian reception; book of the law; infinite space',
    'Crowley, Liber AL vel Legis I (1904/1909); Hanegraaff (ed.), Dictionary of Gnosis and Western Esotericism (2006)',
    'The goddess of infinite space and the infinite stars in Thelema, whose voice constitutes Chapter I of The Book of the Law (Cairo, 1904). Proclaims: "I am the infinite space and the infinite stars thereof" (Liber AL I:22). Her complementary principle is Hadit; together they represent the primordial duality of infinite extension and the point of consciousness. Formally derived from the Egyptian sky goddess Nut (ENT_EGY_NUT), but radically transformed: where Nut is a sky vault arching over the earth, Nuit is infinite space itself, the body of the universe in which every star is a point of Hadit. A documented 20th-century Thelemic reception of the Egyptian deity; not a survival of Egyptian religion.',
    'A',
    'reviewed'
),

-- 3b. Hadit
(
    'ENT_THL_HADIT',
    'Hadit',
    'Thelemic',
    'personified abstraction',
    'Personified Abstraction',
    'will; consciousness; energy; point; polarity; fire; self',
    'thelema; hadit; crowley; 20th-century; modern reception; book of the law; true will; point consciousness',
    'Crowley, Liber AL vel Legis II (1904/1909); Hanegraaff (ed.), Dictionary of Gnosis and Western Esotericism (2006)',
    'The complementary principle to Nuit in Thelema; his voice is Chapter II of The Book of the Law (1904). "I am the flame that burns in every heart of man, and in the core of every star" (Liber AL II:6). While Nuit is infinite space, Hadit is the infinitely small point of consciousness within it — the core of individual True Will. Scholars identify him as a reception of the Egyptian winged solar disc Behdety (Horus of Behdet), though the theological content is Crowley''s own synthesis drawing on Hermetic, Kabbalistic, and Egyptian sources. No direct ancient antecedent for this specific theological function; a 20th-century Thelemic creation.',
    'A',
    'reviewed'
),

-- 3c. Ra-Hoor-Khuit
(
    'ENT_THL_RA_HOOR_KHUIT',
    'Ra-Hoor-Khuit',
    'Thelemic',
    'deity',
    'Deity',
    'will; war; solar; aeon; victory; rulership',
    'thelema; ra-hoor-khuit; horus; crowley; 20th-century; modern reception; book of the law; aeon of horus; solar deity',
    'Crowley, Liber AL vel Legis III (1904/1909); Hanegraaff (ed.), Dictionary of Gnosis and Western Esotericism (2006)',
    'The "crowned and conquering child" and Lord of the Aeon of Horus in Thelema; his voice is Chapter III of The Book of the Law (1904). A composite of the Egyptian solar deity Ra and Horus (most directly Ra-Harakhty), recast as the lord of the current cosmic epoch: the Aeon of Horus, which Crowley declared began in 1904, replacing the Aeon of Osiris (Christianity). Together with his silent twin Hoor-paar-kraat (Thelemic reception of Harpocrates, ENT_SYN_HARPOCRATES), he forms the composite deity Heru-Ra-Ha. Egyptian source entities ENT_EGY_HORUS, ENT_EGY_RA, and ENT_EGY_RA_HORAKHTY exist in this database; all are documented reception sources for this Thelemic figure.',
    'A',
    'reviewed'
),

-- 3d. Aiwass
(
    'ENT_THL_AIWASS',
    'Aiwass',
    'Thelemic',
    'revealer',
    'Revealer Figure',
    'revelation; hidden knowledge; holy guardian angel; cosmic law; dictation',
    'thelema; aiwass; crowley; 20th-century; book of the law; holy guardian angel; revealer; no ancient antecedent',
    'Crowley, Liber AL vel Legis I:7 (1904/1909); Hanegraaff (ed.), Dictionary of Gnosis and Western Esotericism (2006)',
    'The intelligence who dictated The Book of the Law to Aleister Crowley in Cairo, April 8-10, 1904. Self-identified as "the minister of Hoor-paar-kraat" (Liber AL I:7). Crowley later came to identify Aiwass as his own Holy Guardian Angel — the higher self or personal genius of the magician, a concept inherited from the Book of Abramelin the Mage (via the Golden Dawn). Hutton (The Triumph of the Moon, 1999) notes the Golden Dawn''s Holy Guardian Angel concept is rooted in the Abramelin tradition; Blavatsky''s Mahatmas are a parallel hidden-master archetype that influenced Crowley''s milieu. No ancient antecedent; a documented 20th-century Thelemic revealer figure, structurally parallel to other revelation-transmitters (Jibril/Muhammad, Moroni/Smith) but with no claimed historical continuity.',
    'A',
    'reviewed'
)

ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. Entity sources
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
    ('ENT_THL_NUIT',          'SRC_CROWLEY_BOOK_OF_LAW', 'primary_attestation',
     'Nuit is the voice and subject of Chapter I of The Book of the Law. Primary text attestation.'),
    ('ENT_THL_NUIT',          'SRC_HANEGRAAFF_DGW',      'secondary_reference',
     'Dictionary of Gnosis and Western Esotericism (2006) contextualizes Thelema and Nuit within Western esoteric tradition.'),

    ('ENT_THL_HADIT',         'SRC_CROWLEY_BOOK_OF_LAW', 'primary_attestation',
     'Hadit is the voice and subject of Chapter II of The Book of the Law. Primary text attestation.'),
    ('ENT_THL_HADIT',         'SRC_HANEGRAAFF_DGW',      'secondary_reference',
     'Dictionary of Gnosis and Western Esotericism (2006) contextualizes Thelema within Western esoteric tradition.'),

    ('ENT_THL_RA_HOOR_KHUIT', 'SRC_CROWLEY_BOOK_OF_LAW', 'primary_attestation',
     'Ra-Hoor-Khuit is the voice and subject of Chapter III of The Book of the Law; also referenced in Chapters I and II.'),
    ('ENT_THL_RA_HOOR_KHUIT', 'SRC_HANEGRAAFF_DGW',      'secondary_reference',
     'Dictionary of Gnosis and Western Esotericism (2006) contextualizes Thelema and its Egyptian-reception entities.'),

    ('ENT_THL_AIWASS',        'SRC_CROWLEY_BOOK_OF_LAW', 'primary_attestation',
     'Aiwass identified as "the minister of Hoor-paar-kraat" and the dictating intelligence in Liber AL I:7.'),
    ('ENT_THL_AIWASS',        'SRC_HANEGRAAFF_DGW',      'secondary_reference',
     'Dictionary of Gnosis and Western Esotericism (2006) contextualizes Aiwass within the Holy Guardian Angel tradition.')

ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. Period assignments
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
VALUES
    ('ENT_THL_NUIT',          'PER_20C_OCCULT', 'high',
     'The Book of the Law received April 1904; Thelema is a distinctly 20th-century phenomenon.'),
    ('ENT_THL_HADIT',         'PER_20C_OCCULT', 'high',
     'The Book of the Law received April 1904.'),
    ('ENT_THL_RA_HOOR_KHUIT', 'PER_20C_OCCULT', 'high',
     'The Book of the Law received April 1904; Ra-Hoor-Khuit declared Lord of the new Aeon beginning 1904.'),
    ('ENT_THL_AIWASS',        'PER_20C_OCCULT', 'high',
     'Aiwass''s dictation of The Book of the Law, Cairo 1904, is the defining event.')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 6. Transmission chains
-- ─────────────────────────────────────────────────────────────────────────────

-- 6a. Egyptian Nut → Thelemic Nuit
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_EGY_NUT', 'received_as', 'ENT_THL_NUIT',
     'medium',
     'Egyptian sky goddess Nut received and radically transformed into the Thelemic goddess Nuit. Crowley retained the name and the association with the night sky but replaced the mythological vault with an infinite-space cosmic principle. Liber AL I:22: "I am the infinite space and the infinite stars thereof."',
     'reviewed', 'PER_20C_OCCULT'),
    ('ENT_THL_NUIT', 'reception_of', 'ENT_EGY_NUT',
     'medium',
     'Nuit is a Thelemic reception and radical transformation of the Egyptian sky goddess Nut.',
     'reviewed', 'PER_20C_OCCULT')
ON CONFLICT DO NOTHING;

-- 6b. Egyptian sources → Ra-Hoor-Khuit (three source entities)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    -- Horus is the most conceptually central source
    ('ENT_EGY_HORUS', 'received_as', 'ENT_THL_RA_HOOR_KHUIT',
     'medium',
     'Egyptian Horus received as the Thelemic Ra-Hoor-Khuit: the solar falcon god of kingship and cosmic order becomes the "crowned and conquering child" and Lord of the Aeon of Horus in Crowley''s system.',
     'reviewed', 'PER_20C_OCCULT'),
    -- Ra contributes the solar composite
    ('ENT_EGY_RA', 'received_as', 'ENT_THL_RA_HOOR_KHUIT',
     'medium',
     'Egyptian Ra received into the Thelemic composite Ra-Hoor-Khuit: the solar component of the name reflects Ra''s role as the supreme solar deity, merged with Horus into a single Thelemic aeon-lord.',
     'reviewed', 'PER_20C_OCCULT'),
    -- Ra-Horakhty is the most direct Egyptian composite precursor
    ('ENT_EGY_RA_HORAKHTY', 'received_as', 'ENT_THL_RA_HOOR_KHUIT',
     'medium',
     'Ra-Harakhty (Ra-as-Horus-of-the-horizon) is the Egyptian composite deity most directly received into Crowley''s Ra-Hoor-Khuit: both combine Ra and Horus into a single solar-falcon entity.',
     'reviewed', 'PER_20C_OCCULT'),
    -- Harpocrates → Hoor-paar-kraat (silent twin of Ra-Hoor-Khuit)
    ('ENT_SYN_HARPOCRATES', 'received_as', 'ENT_THL_RA_HOOR_KHUIT',
     'low',
     'The Greco-Egyptian Harpocrates (silent child Horus) received as Hoor-paar-kraat in Thelema: Harpocrates is the silent passive twin of Ra-Hoor-Khuit, together forming the composite deity Heru-Ra-Ha. Confidence is low because Harpocrates maps specifically to Hoor-paar-kraat rather than Ra-Hoor-Khuit; this edge reflects their co-constitution within the same composite.',
     'reviewed', 'PER_20C_OCCULT')
ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_THL_RA_HOOR_KHUIT', 'reception_of', 'ENT_EGY_HORUS',
     'medium', 'Ra-Hoor-Khuit is a Thelemic reception of Egyptian Horus.', 'reviewed', 'PER_20C_OCCULT'),
    ('ENT_THL_RA_HOOR_KHUIT', 'reception_of', 'ENT_EGY_RA',
     'medium', 'Ra-Hoor-Khuit is a Thelemic reception incorporating the Egyptian solar deity Ra.', 'reviewed', 'PER_20C_OCCULT'),
    ('ENT_THL_RA_HOOR_KHUIT', 'reception_of', 'ENT_EGY_RA_HORAKHTY',
     'medium', 'Ra-Hoor-Khuit is most directly a Thelemic reception of the Egyptian composite Ra-Harakhty.', 'reviewed', 'PER_20C_OCCULT')
ON CONFLICT DO NOTHING;

-- 6c. Mahatmas → Aiwass
-- The Theosophical hidden-master / Holy Guardian Angel lineage (Abramelin → Blavatsky → Crowley)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_REC_MAHATMAS', 'received_as', 'ENT_THL_AIWASS',
     'medium',
     'The Theosophical Mahatmas concept (hidden superhuman teachers transmitting cosmic wisdom to initiates) received into Crowley''s Aiwass: Hutton (Triumph of the Moon, 1999) traces the Holy Guardian Angel concept through the Abramelin tradition; Blavatsky''s Mahatmas and Mathers''s Secret Chiefs are the immediate occultist milieu from which Crowley developed the figure of Aiwass as personal cosmic dictator.',
     'reviewed', 'PER_20C_OCCULT'),
    ('ENT_THL_AIWASS', 'reception_of', 'ENT_REC_MAHATMAS',
     'medium',
     'Aiwass as Holy Guardian Angel is a Thelemic reception of the Theosophical hidden-master archetype.',
     'reviewed', 'PER_20C_OCCULT')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 7. Verify
-- ─────────────────────────────────────────────────────────────────────────────

SELECT
    e.entity_id,
    e.canonical_name,
    e.tradition,
    e.entity_type,
    e.evidence_confidence,
    COUNT(DISTINCT es.source_id) AS sources,
    COUNT(DISTINCT ep.period_id) AS periods
FROM entities e
LEFT JOIN entity_sources es ON e.entity_id = es.entity_id
LEFT JOIN entity_periods ep ON e.entity_id = ep.entity_id
WHERE e.entity_id IN (
    'ENT_THL_NUIT','ENT_THL_HADIT','ENT_THL_RA_HOOR_KHUIT','ENT_THL_AIWASS'
)
GROUP BY e.entity_id, e.canonical_name, e.tradition, e.entity_type, e.evidence_confidence
ORDER BY e.entity_id;

-- Walk the full Thelemic transmission chain
SELECT
    e1.canonical_name AS from_entity,
    e1.tradition      AS from_tradition,
    er.relationship_type,
    p.period_name     AS period,
    er.confidence,
    e2.canonical_name AS to_entity,
    e2.tradition      AS to_tradition
FROM entity_relationships er
JOIN entities e1 ON er.subject_entity_id = e1.entity_id
JOIN entities e2 ON er.object_entity_id  = e2.entity_id
LEFT JOIN periods p ON er.period_id = p.period_id
WHERE er.subject_entity_id IN (
        'ENT_THL_NUIT','ENT_THL_HADIT','ENT_THL_RA_HOOR_KHUIT','ENT_THL_AIWASS',
        'ENT_EGY_NUT','ENT_EGY_HORUS','ENT_EGY_RA','ENT_EGY_RA_HORAKHTY',
        'ENT_SYN_HARPOCRATES','ENT_REC_MAHATMAS'
      )
  AND er.object_entity_id IN (
        'ENT_THL_NUIT','ENT_THL_HADIT','ENT_THL_RA_HOOR_KHUIT','ENT_THL_AIWASS',
        'ENT_EGY_NUT','ENT_EGY_HORUS','ENT_EGY_RA','ENT_EGY_RA_HORAKHTY',
        'ENT_SYN_HARPOCRATES','ENT_REC_MAHATMAS'
      )
ORDER BY er.period_id, e1.canonical_name, er.relationship_type;

SELECT * FROM v_release_metrics;

COMMIT;
