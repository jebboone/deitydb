-- 19th-Century Occultism Reception Layer
-- Adds source records, entities, and transmission chains for the documented
-- modern occult reception tradition. All entities are explicitly labeled as
-- 19th-century modern reception; no ancient origins are claimed or implied.
--
-- Scholarly basis:
--   Hutton, Ronald. The Triumph of the Moon: A History of Modern Pagan Witchcraft.
--     Oxford: OUP, 1999. (read in full for this session)
--   Lévi, Éliphas. Dogme et rituel de la haute magie. Paris: Germer Baillière, 1854-1856.
--   Blavatsky, Helena P. The Secret Doctrine. London: Theosophical Publishing Co., 1888.
--   Hanegraaff, Wouter J. (ed.). Dictionary of Gnosis & Western Esotericism.
--     Leiden: Brill, 2006.

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. Source records
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, source_type, scope)
VALUES

    ('SRC_LEVI_DOGME_RITUEL',
     'Éliphas Lévi, Dogme et rituel de la haute magie (Paris: Germer Baillière, 1854-1856)',
     'primary text',
     '19th-century ritual magic; Baphomet as occult symbol; invoking pentagram; Astral Light; Kabbalistic and Hermetic synthesis; coined "occultism" as a term'),

    ('SRC_BLAVATSKY_SECRET_DOCTRINE',
     'Helena P. Blavatsky, The Secret Doctrine (London: Theosophical Publishing Company, 1888)',
     'primary text',
     'Theosophical cosmology; Mahatmas (Masters of Wisdom); root races; cosmic evolution; synthesis of Eastern and Western esoteric traditions'),

    ('SRC_HUTTON_TRIUMPH',
     'Ronald Hutton, The Triumph of the Moon: A History of Modern Pagan Witchcraft (Oxford: OUP, 1999)',
     'secondary scholarly',
     'Origins and history of modern pagan witchcraft in Britain; 19th-century Romantic Pan revival; Lévi''s role in British magical revival; Theosophical Society and Mahatmas; Hermetic Order of the Golden Dawn; Gerald Gardner and Wicca'),

    ('SRC_HANEGRAAFF_DGW',
     'Wouter J. Hanegraaff (ed.), Dictionary of Gnosis and Western Esotericism (Leiden: Brill, 2006)',
     'reference work',
     'Western esotericism from Late Antiquity to the present: Hermeticism, Kabbalah, Rosicrucianism, Theosophy, occultism, Baphomet, Lévi, Neopaganism, Satanism, Golden Dawn, New Age')

ON CONFLICT (source_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Entities
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entities (
    entity_id, canonical_name, tradition, entity_type, category,
    primary_domains, tags, inclusion_basis, short_note,
    evidence_confidence, review_status
)
VALUES

-- 2a. Baphomet (Lévi)
-- Invented by Éliphas Lévi in Dogme et rituel (1854-1856) as a Hermetic-Kabbalistic
-- symbol of universal polarity; not an ancient deity. Became the dominant visual icon
-- of modern Western occultism.
(
    'ENT_REC_BAPHOMET_LEVI',
    'Baphomet (Lévi)',
    '19th-century occultism',
    'personified abstraction',
    'Personified Abstraction',
    'magic; occult synthesis; polarity; wisdom; modern reception',
    'baphomet; lévi; occultism; 19th-century; modern reception; hermetic; kabbalistic; personified abstraction',
    'Lévi, Dogme et rituel de la haute magie (1854-1856); Hanegraaff (ed.), Dictionary of Gnosis and Western Esotericism (2006)',
    'Androgynous, goat-headed figure invented by Éliphas Lévi in Dogme et rituel de la haute magie (1854-1856) as a symbol of the occult absolute: the synthesis of all opposites (male/female, good/evil, matter/spirit). Lévi drew on the Templar trial accusations of 1307-1314 (in which the Knights Templar were charged with worshipping "Baphomet") but wholly transformed the figure — his Baphomet is a Hermetic and Kabbalistic symbol of universal polarity, not a continuation of any medieval cult. Hutton (1999) and Hanegraaff (2006) confirm no ancient deity "Baphomet" existed; the name and figure are Lévi''s 19th-century creation. Later adapted by the Church of Satan (LaVey, 1966) and by various Wiccan and ceremonial-magic traditions.',
    'A',
    'reviewed'
),

-- 2b. Mahatmas (Theosophical Masters of Wisdom)
-- Blavatsky's claimed semi-divine hidden teachers; Hutton documents how Mathers
-- modelled the Golden Dawn's "Secret Chiefs" directly on them.
(
    'ENT_REC_MAHATMAS',
    'Mahatmas (Theosophical Masters of Wisdom)',
    'Theosophical',
    'revealer',
    'Revealer Figure',
    'cosmic wisdom; hidden knowledge; spiritual guidance; occult synthesis',
    'theosophy; mahatmas; masters of wisdom; blavatsky; 19th-century; modern reception; hidden teachers; revealer',
    'Blavatsky, The Secret Doctrine (1888); Hutton, The Triumph of the Moon (1999)',
    'Claimed semi-divine superhuman teachers in Theosophy (Theosophical Society founded 1875 by Helena Blavatsky and Henry Olcott), said to guide the Society from Tibet. In The Secret Doctrine (1888) they are cosmic adepts who have transcended ordinary human evolution and transmit occult wisdom to initiates. Hutton (The Triumph of the Moon, 1999) notes Mathers explicitly modelled the Golden Dawn''s "Secret Chiefs" on the Mahatmas. Functions as a documented modern-reception parallel to traditional revealer-figure hierarchies (compare Hermes Trismegistus, Gnostic aeons). No independent ancient attestation; documented modern occult invention.',
    'A',
    'reviewed'
),

-- 2c. Pan (Romantic-Victorian Reception)
-- Hutton documents this as a historically specific and traceable phenomenon:
-- Greek Pan received as immanent nature-spirit and symbol of pagan counter-culture
-- in 19th-century British Romanticism; became the template for Wicca's Horned God.
(
    'ENT_REC_PAN_ROMANTIC',
    'Pan (Romantic-Victorian Reception)',
    'Modern reception',
    'deity',
    'Deity',
    'nature; wild; paganism; counter-culture; freedom; modern reception',
    'pan; romantic; victorian; modern reception; paganism; 19th-century; nature deity; horned god precursor',
    'Hutton, The Triumph of the Moon (1999); Hanegraaff (ed.), Dictionary of Gnosis and Western Esotericism (2006)',
    'The Greek god Pan received in 19th-century British Romantic and Victorian literature as the immanent spirit of wild nature and pre-Christian freedom. Hutton (The Triumph of the Moon, 1999, chs. 3-4) documents this as a traceable historical phenomenon: Shelley consecrated a mountain altar to Pan (1821), Byron, Keats, Swinburne, Edward Carpenter, and Kenneth Grahame all deployed Pan as the symbol of paganism''s cultural return. This Victorian Pan — a cosmic nature-spirit rather than the specific Greek pastoral deity — became the primary mythological template for the Horned God in Gerald Gardner''s Wicca (1950s). Not a survival of ancient cult; documented modern literary-religious reception.',
    'B',
    'reviewed'
)

ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. Entity sources
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES

    ('ENT_REC_BAPHOMET_LEVI', 'SRC_LEVI_DOGME_RITUEL', 'primary_attestation',
     'Baphomet first depicted and described in Dogme et rituel de la haute magie (1854-1856), ch. "Le Grand Symbole". Lévi''s own invention; no prior attestation of the figure as an occult deity.'),
    ('ENT_REC_BAPHOMET_LEVI', 'SRC_HANEGRAAFF_DGW', 'secondary_reference',
     'Dictionary of Gnosis and Western Esotericism (2006) has a dedicated Baphomet entry confirming Lévi''s authorship and the absence of a genuine medieval precursor.'),

    ('ENT_REC_MAHATMAS', 'SRC_BLAVATSKY_SECRET_DOCTRINE', 'primary_attestation',
     'The Mahatmas / Masters of Wisdom are central to The Secret Doctrine (1888); Blavatsky presents them as the hidden adepts transmitting cosmic truth through Theosophy.'),
    ('ENT_REC_MAHATMAS', 'SRC_HUTTON_TRIUMPH', 'secondary_reference',
     'Hutton (1999) documents the Mahatmas as Blavatsky''s claimed semi-divine teachers and notes that Mathers explicitly modelled the Golden Dawn''s Secret Chiefs on them.'),

    ('ENT_REC_PAN_ROMANTIC', 'SRC_HUTTON_TRIUMPH', 'primary_attestation',
     'Hutton (1999) provides the primary scholarly account of the Victorian Pan revival, documenting specific authors and dates: Shelley (1821), Keats, Byron, Swinburne, Carpenter, Grahame. This is the authoritative source for this reception entity.'),
    ('ENT_REC_PAN_ROMANTIC', 'SRC_HANEGRAAFF_DGW', 'secondary_reference',
     'Dictionary of Gnosis and Western Esotericism (2006) contextualizes Neopaganism and its 19th-century roots.')

ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. Period assignments
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale)
VALUES
    ('ENT_REC_BAPHOMET_LEVI',   'PER_19C_OCCULT', 'high',
     'Baphomet figure created by Lévi in 1854-1856; paradigmatic 19th-century occultism entity.'),
    ('ENT_REC_MAHATMAS',        'PER_19C_OCCULT', 'high',
     'Theosophical Society founded 1875; Secret Doctrine 1888; Mahatmas are central to this period.'),
    ('ENT_REC_PAN_ROMANTIC',    'PER_19C_OCCULT', 'high',
     'Victorian Pan revival documented 1815-1900 (Shelley to Grahame); 19th-century phenomenon.')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. Transmission chains (received_as with period_id)
-- ─────────────────────────────────────────────────────────────────────────────

-- 5a. Greek Pan → Romantic Pan (the core reception chain for this entity)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_PAN', 'received_as', 'ENT_REC_PAN_ROMANTIC',
     'high',
     'Greek Pan received in 19th-century British Romanticism as the immanent spirit of wild nature and pre-Christian freedom. Hutton (Triumph of the Moon, 1999) documents this specifically: Shelley, Keats, Byron, Swinburne, Carpenter, Grahame. The Greek pastoral deity is transformed into a universal nature-spirit and symbol of pagan counter-culture.',
     'reviewed', 'PER_19C_OCCULT')
ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_REC_PAN_ROMANTIC', 'reception_of', 'ENT_PAN',
     'high',
     'The Romantic-Victorian Pan is a documented literary-religious reception of the Greek god Pan.',
     'reviewed', 'PER_19C_OCCULT')
ON CONFLICT DO NOTHING;

-- 5b. Hermes Trismegistus and Lucifer → Lévi's Baphomet synthesis
-- Lévi synthesized multiple traditions; these are medium-confidence analytic edges
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_HER_TRISMEGISTUS', 'received_as', 'ENT_REC_BAPHOMET_LEVI',
     'medium',
     'Hermetic tradition (Hermes Trismegistus as embodiment of occult synthesis) received into Lévi''s Baphomet: Lévi''s Dogme et rituel explicitly draws on Hermetic sources as one strand of his synthesis of the occult absolute.',
     'reviewed', 'PER_19C_OCCULT'),
    ('ENT_CHR_LUCIFER', 'received_as', 'ENT_REC_BAPHOMET_LEVI',
     'medium',
     'Fallen-angel / Luciferian imagery incorporated into Lévi''s Baphomet synthesis: the figure combines the androgyny of Gnostic aeons, Kabbalistic polarity, and the ambiguous Luciferian archetype of enlightenment-through-transgression.',
     'reviewed', 'PER_19C_OCCULT')
ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_REC_BAPHOMET_LEVI', 'reception_of', 'ENT_HER_TRISMEGISTUS',
     'medium',
     'Lévi''s Baphomet is partly a reception of the Hermetic tradition of occult synthesis personified in Hermes Trismegistus.',
     'reviewed', 'PER_19C_OCCULT'),
    ('ENT_REC_BAPHOMET_LEVI', 'reception_of', 'ENT_CHR_LUCIFER',
     'medium',
     'Lévi''s Baphomet incorporates fallen-angel and Luciferian imagery from the Christian demonological tradition.',
     'reviewed', 'PER_19C_OCCULT')
ON CONFLICT DO NOTHING;

-- 5c. Hermes Trismegistus → Theosophical Mahatmas
-- The Theosophical hidden-master concept draws on the Hermetic tradition of
-- hidden wisdom-transmitters; this is a structural parallel, not direct descent.
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_HER_TRISMEGISTUS', 'received_as', 'ENT_REC_MAHATMAS',
     'low',
     'The Theosophical Mahatmas structurally parallel the Hermetic revealer-figure archetype (hidden cosmic teacher transmitting wisdom to initiates). Hutton (1999) notes this lineage; confidence is low because Blavatsky drew more directly on Hindu/Buddhist terminology than on Hermetic texts.',
     'reviewed', 'PER_19C_OCCULT')
ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status, period_id)
VALUES
    ('ENT_REC_MAHATMAS', 'reception_of', 'ENT_HER_TRISMEGISTUS',
     'low',
     'The Mahatmas concept partially draws on the Hermetic tradition of hidden wisdom-transmitters, though Blavatsky''s immediate framing is Hindu/Buddhist.',
     'reviewed', 'PER_19C_OCCULT')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 6. Verify
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
WHERE e.entity_id IN ('ENT_REC_BAPHOMET_LEVI','ENT_REC_MAHATMAS','ENT_REC_PAN_ROMANTIC')
GROUP BY e.entity_id, e.canonical_name, e.tradition, e.entity_type, e.evidence_confidence
ORDER BY e.entity_id;

-- Walk the new transmission chains
SELECT
    e1.canonical_name AS from_entity,
    e1.tradition AS from_tradition,
    er.relationship_type,
    p.period_name AS reception_period,
    er.confidence,
    e2.canonical_name AS to_entity,
    e2.tradition AS to_tradition
FROM entity_relationships er
JOIN entities e1 ON er.subject_entity_id = e1.entity_id
JOIN entities e2 ON er.object_entity_id = e2.entity_id
LEFT JOIN periods p ON er.period_id = p.period_id
WHERE er.object_entity_id IN ('ENT_REC_BAPHOMET_LEVI','ENT_REC_MAHATMAS','ENT_REC_PAN_ROMANTIC')
   OR er.subject_entity_id IN ('ENT_REC_BAPHOMET_LEVI','ENT_REC_MAHATMAS','ENT_REC_PAN_ROMANTIC')
ORDER BY er.relationship_type, e1.canonical_name;

-- Release metrics
SELECT * FROM v_release_metrics;

COMMIT;
