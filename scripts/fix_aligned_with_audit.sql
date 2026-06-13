-- aligned_with audit: replace all 51 aligned_with edges with typed relations
-- Result: 0 aligned_with; 47 typed replacements; 4 pure removals.
-- Removed: Apep→Seth, Meretseger→Amun, Min→Hapy, Valkyries→War
-- Reattributed objects: Yggdrasil→WORLD_TREE (was HER_COSMOS); Revelation→Kingdom (reversed)

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- Step 1: Delete all 51 aligned_with edges
-- ─────────────────────────────────────────────────────────────────────────────

DELETE FROM entity_relationships
WHERE relationship_id IN (
    -- Canaanite/Ugaritic
    513,  -- Astarte → Inanna/Ishtar
    501,  -- Lotan → Chaos
    -- Christian/Biblical
    1056, -- Chr Behemoth → Chaos
    1057, -- Chr Leviathan → Chaos
    -- Egyptian (296, 274, 284 = pure removes; 285, 256 = associated_with)
    296,  -- Apep → Seth            [REMOVE]
    274,  -- Meretseger → Amun      [REMOVE]
    284,  -- Min → Hapy             [REMOVE]
    285,  -- Osiris → Hapy
    256,  -- Sia → Thoth
    -- Norse
    862,  -- Jörmungandr → Water
    855,  -- Valkyries → War        [REMOVE]
    847,  -- Yggdrasil → HER_COSMOS [reattribute object → WORLD_TREE]
    -- Gnostic
    737,  -- Gnostic Anthropos → Hermetic Anthropos
    -- Greek
    157,  -- Ananke → Adrasteia
    97,   -- Demeter → Iacchus
    98,   -- Dionysus → Iacchus
    154,  -- Nyx → Phanes
    148,  -- Styx → Horkos
    -- Hermetic
    747,  -- HER_COSMOS → Cosmic Order
    754,  -- The One → Monad
    -- Islamic
    990,  -- Khidr → Immortality
    1010, -- Ya'juj Ma'juj → Chaos
    -- Israelite/Second Temple
    528,  -- ISR Behemoth → Chaos
    563,  -- ISR Behemoth → Earth
    529,  -- ISR Leviathan → Chaos
    569,  -- ISR Leviathan → Tiamat
    572,  -- ISR Leviathan → Water
    574,  -- ISR Uriel → Cosmic Order
    -- Jewish Mystical
    1035, -- Adam Kadmon → Gnostic Anthropos
    1036, -- Adam Kadmon → Valentinian Anthropos
    1034, -- Adam Kadmon → Hermetic Anthropos
    -- Late Antique Ritual
    751,  -- Decans → Fate
    743,  -- Planetary Rulers → Gnostic Archons
    753,  -- Theurgy → Magic
    -- Manichaean
    965,  -- Column of Glory → Light Particles
    972,  -- Light Mind → Gnostic Nous
    970,  -- Light Mind → Valentinian Nous
    971,  -- Light Mind → Hermetic Nous
    969,  -- Light Particles → Matter [reattribute: imprisoned_by]
    977,  -- Light Particles → Salvation
    973,  -- Mother of Life → Primal Man
    -- Mesopotamian
    467,  -- Inanna/Ishtar → Venus
    -- Ophite
    677,  -- Ophite Serpent → Forbidden Knowledge
    -- Sethian
    628,  -- Norea → Salvation
    618,  -- Youel → Barbelo
    -- Thomasine
    694,  -- Kingdom → Revelation [reattribute: reversed reveals edge]
    696,  -- Kingdom → Salvation
    -- Valentinian
    738,  -- Val Anthropos → Hermetic Anthropos
    650,  -- Bridal Chamber → Salvation
    660,  -- Horos → Stauros
    -- Zoroastrian
    899   -- Mithra → Light
);

-- ─────────────────────────────────────────────────────────────────────────────
-- Step 2: Insert typed replacements
-- ─────────────────────────────────────────────────────────────────────────────

-- equated_with (cross-tradition interpretatio / theological equivalence) ------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_CAN_ASTARTE',        'equated_with', 'ENT_MES_INANNA_ISHTAR',  'medium', 'Astarte equated with Inanna/Ishtar through function and Levantine-Mesopotamian interpretatio.',            'reviewed'),
    ('ENT_GNO_ANTHROPOS',      'equated_with', 'ENT_HER_ANTHROPOS',      'medium', 'Gnostic Anthropos and Hermetic Anthropos are equated as primordial human archetypes in comparative tradition.','reviewed'),
    ('ENT_HER_THE_ONE',        'equated_with', 'ENT_GNO_MONAD',          'medium', 'Hermetic The One and Gnostic Monad equated as supreme unity/source across Hermetic and Gnostic contexts.', 'reviewed'),
    ('ENT_ISR_LEVIATHAN',      'equated_with', 'ENT_MES_TIAMAT',         'medium', 'Leviathan and Tiamat equated within the broader Near Eastern chaos-dragon/sea-combat tradition.',          'reviewed'),
    ('ENT_LAT_PLANETARY_RULERS','equated_with','ENT_GNO_ARCHONS',         'medium', 'Late Antique planetary rulers equated structurally with Gnostic archontic cosmic governance.',             'reviewed'),
    ('ENT_VAL_ANTHROPOS',      'equated_with', 'ENT_HER_ANTHROPOS',      'medium', 'Valentinian Anthropos equated with Hermetic Anthropos as primordial human archetype.',                     'reviewed'),
    ('ENT_JM_ADAM_KADMON',     'equated_with', 'ENT_GNO_ANTHROPOS',      'medium', 'Adam Kadmon equated structurally with the Gnostic primordial human (Anthropos) pattern.',                  'reviewed'),
    ('ENT_JM_ADAM_KADMON',     'equated_with', 'ENT_VAL_ANTHROPOS',      'medium', 'Adam Kadmon equated structurally with the Valentinian Anthropos.',                                          'reviewed'),
    ('ENT_JM_ADAM_KADMON',     'equated_with', 'ENT_HER_ANTHROPOS',      'medium', 'Adam Kadmon equated structurally with the Hermetic Anthropos.',                                             'reviewed'),
    ('ENT_MANICH_LIGHT_MIND',  'equated_with', 'ENT_GNO_NOUS',           'medium', 'Manichaean Light Mind equated with Gnostic Nous as divine intellect/mind principle.',                      'reviewed'),
    ('ENT_MANICH_LIGHT_MIND',  'equated_with', 'ENT_VAL_NOUS',           'medium', 'Manichaean Light Mind equated with Valentinian Nous as divine intellect/mind principle.',                  'reviewed'),
    ('ENT_MANICH_LIGHT_MIND',  'equated_with', 'ENT_HER_NOUS',           'medium', 'Manichaean Light Mind equated with Hermetic Nous as divine intellect/mind principle.',                     'reviewed')
ON CONFLICT DO NOTHING;

-- identified_with (textual/theological identification without implying fusion) -

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_ANANKE',    'identified_with', 'ENT_ADRASTEIA',   'medium', 'Ananke and Adrasteia identified as necessity/fate in Orphic cosmological texts.',                      'reviewed'),
    ('ENT_DIONYSUS',  'identified_with', 'ENT_IACCHUS',     'medium', 'Iacchus identified with Dionysus in some ancient sources linking Eleusinian and Dionysian mysteries.', 'reviewed'),
    ('ENT_VAL_HOROS', 'identified_with', 'ENT_VAL_STAUROS', 'medium', 'Horos and Stauros identified as the same Aeon (the Limit/Cross) in several Valentinian accounts.',    'reviewed')
ON CONFLICT DO NOTHING;

-- embodies (entity personifies / is an instance of an abstract concept) ------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_CAN_LOTAN',        'embodies', 'ENT_CHAOS',         'high',   'Lotan is a chaos-serpent figure embodying primordial chaos in the Ugaritic combat myth.',              'reviewed'),
    ('ENT_CHR_BEHEMOTH',     'embodies', 'ENT_CHAOS',         'medium', 'Behemoth embodies primordial/chaotic force in Christian biblical reception.',                          'reviewed'),
    ('ENT_CHR_LEVIATHAN',    'embodies', 'ENT_CHAOS',         'high',   'Leviathan embodies chaos as a sea monster in biblical and Christian reception.',                       'reviewed'),
    ('ENT_ISL_YAJUJ_MAJUJ',  'embodies', 'ENT_CHAOS',         'medium', 'Ya''juj and Ma''juj embody destructive chaotic force as eschatological destroyers.',                   'reviewed'),
    ('ENT_ISR_BEHEMOTH',     'embodies', 'ENT_CHAOS',         'medium', 'Behemoth embodies primordial chaotic force as eschatological beast in Israelite apocalyptic.',         'reviewed'),
    ('ENT_ISR_LEVIATHAN',    'embodies', 'ENT_CHAOS',         'high',   'Leviathan embodies chaos as sea monster in Israelite tradition.',                                      'reviewed'),
    ('ENT_STYX',             'embodies', 'ENT_HORKOS',        'medium', 'Styx embodies the divine oath; swearing by Styx is the binding oath of the gods.',                    'reviewed'),
    ('ENT_HER_COSMOS',       'embodies', 'ENT_COSMIC_ORDER',  'high',   'The Hermetic Cosmos is a living ordered manifestation; it embodies cosmic order.',                    'reviewed'),
    ('ENT_MES_INANNA_ISHTAR','embodies', 'ENT_VENUS',         'high',   'Inanna/Ishtar is identified with the planet Venus in Mesopotamian astral theology.',                  'reviewed'),
    ('ENT_ISL_KHIDR',        'embodies', 'ENT_IMMORTALITY',   'medium', 'Khidr embodies immortality, having drunk from the Water of Life in Islamic tradition.',               'reviewed'),
    ('ENT_THO_KINGDOM',      'embodies', 'ENT_SALVATION',     'medium', 'The Kingdom functions soteriologically in Thomasine tradition, embodying the goal of salvation.',      'reviewed'),
    ('ENT_ZOR_MITHRA',       'embodies', 'ENT_LIGHT',         'medium', 'Mithra embodies light and solar radiance as a deity of light in Iranian tradition.',                   'reviewed'),
    -- Reattribute: Yggdrasil embodies WORLD_TREE (was aligned_with HER_COSMOS)
    ('ENT_NOR_YGGDRASIL',    'embodies', 'ENT_WORLD_TREE',    'high',   'Yggdrasil is the Norse world tree, structuring the nine realms; it embodies the World Tree archetype.','reviewed')
ON CONFLICT DO NOTHING;

-- dwells_in -------------------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_NOR_JORMUNGANDR', 'dwells_in', 'ENT_WATER', 'medium', 'Jörmungandr encircles the world in the sea (Miðgarðsormr).',                    'reviewed'),
    ('ENT_ISR_BEHEMOTH',    'dwells_in', 'ENT_EARTH',  'medium', 'Behemoth is a land monster; its domain is the earth, paired with Leviathan at sea.','reviewed'),
    ('ENT_ISR_LEVIATHAN',   'dwells_in', 'ENT_WATER',  'high',   'Leviathan dwells in the sea as a chaos/sea monster.',                             'reviewed')
ON CONFLICT DO NOTHING;

-- paired_with (liturgical or cosmogonic pair) ---------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_DEMETER',            'paired_with', 'ENT_IACCHUS',           'medium', 'Demeter and Iacchus are liturgically paired in the Eleusinian mystery procession.',              'reviewed'),
    ('ENT_NYX',                'paired_with', 'ENT_PHANES',            'medium', 'Nyx and Phanes are a cosmogonic pair in Orphic tradition; Phanes transmits sovereignty to Nyx.', 'reviewed'),
    ('ENT_MANICH_MOTHER_LIFE', 'paired_with', 'ENT_MANICH_PRIMAL_MAN', 'high',   'Mother of Life and Primal Man are a paired evocation in the Manichaean cosmogonic sequence.',    'reviewed')
ON CONFLICT DO NOTHING;

-- presides_over ---------------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_ISR_URIEL',   'presides_over', 'ENT_COSMIC_ORDER', 'medium', 'Uriel presides over cosmic luminaries and mediates cosmic/apocalyptic order in Second Temple tradition.','reviewed'),
    ('ENT_LAT_DECANS',  'presides_over', 'ENT_FATE',         'medium', 'Decans preside over hours and astral time, mediating fate through their stellar influence.',              'reviewed')
ON CONFLICT DO NOTHING;

-- imprisoned_by ---------------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_MANICH_LIGHT_PARTICLES', 'imprisoned_by', 'ENT_MANICH_MATTER', 'high',
     'Manichaean light particles are trapped within matter; liberation is the goal of the salvation drama.', 'reviewed')
ON CONFLICT DO NOTHING;

-- undergoes_process -----------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_MANICH_LIGHT_PARTICLES', 'undergoes_process', 'ENT_SALVATION', 'high',   'Salvation in Manichaeism is the liberation and ascent of trapped light particles.',              'reviewed'),
    ('ENT_SET_NOREA',              'undergoes_process', 'ENT_SALVATION', 'medium', 'Norea undergoes salvation in Sethian tradition, resisting archontic powers and being revealed.', 'reviewed')
ON CONFLICT DO NOTHING;

-- transmits -------------------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_MANICH_COLUMN_GLORY', 'transmits', 'ENT_MANICH_LIGHT_PARTICLES', 'high',
     'The Column of Glory transmits liberated light particles upward to the realm of light in Manichaean cosmology.', 'reviewed')
ON CONFLICT DO NOTHING;

-- reveals ---------------------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_OPH_SERPENT', 'reveals', 'ENT_FORBIDDEN_KNOWLEDGE', 'medium',
     'The Ophite serpent actively reveals forbidden/hidden knowledge in Eden reinterpretation traditions.', 'reviewed'),
    -- Reattribute (reversed): Revelation reveals Kingdom (was Kingdom aligned_with Revelation)
    ('ENT_REVELATION',  'reveals', 'ENT_THO_KINGDOM',          'medium',
     'In Thomasine tradition the Kingdom is disclosed through recognition and revelation.', 'reviewed')
ON CONFLICT DO NOTHING;

-- emanates_from ---------------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_SET_YOUEL', 'emanates_from', 'ENT_SET_BARBELO', 'medium',
     'Youel emanates from or is closely associated with Barbelo traditions in Sethian texts.', 'reviewed')
ON CONFLICT DO NOTHING;

-- symbolizes ------------------------------------------------------------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_VAL_BRIDAL_CHAMBER', 'symbolizes', 'ENT_SALVATION', 'medium',
     'The Valentinian bridal chamber sacrament symbolizes union and restoration; it is the ritual enactment of salvation.', 'reviewed')
ON CONFLICT DO NOTHING;

-- Restore associated_with to relationship_types (documented in ontology.md as
-- a valid minimal-use type; was removed when the 235→5 cleanup emptied it out)
INSERT INTO relationship_types (relationship_type, description)
VALUES (
    'associated_with',
    'Reserved for genuinely ambiguous, contextual, or unresolved associations where no typed relation applies. Kept minimal (policy: under 10 records).'
)
ON CONFLICT DO NOTHING;

-- associated_with (genuinely ambiguous; below <10 policy limit) ---------------

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, review_status)
VALUES
    ('ENT_EGY_OSIRIS', 'associated_with', 'ENT_EGY_HAPY_NILE', 'medium',
     'Osiris and Hapy are associated through shared symbolism of Nile inundation, fertility, and renewal in Egyptian theology.', 'reviewed'),
    ('ENT_EGY_SIA',    'associated_with', 'ENT_EGY_THOTH',     'medium',
     'Sia (divine perception) and Thoth (divine knowledge) share the domain of divine cognition and appear together in cosmological texts.', 'reviewed'),
    ('ENT_THEURGY',    'associated_with', 'ENT_MAGIC',          'medium',
     'Theurgy and magic overlap in late antique ritual practice but require conceptual distinction; theurgy is theologically distinct.', 'reviewed')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Verify: aligned_with should be 0; associated_with should be 3
-- ─────────────────────────────────────────────────────────────────────────────

SELECT relationship_type, COUNT(*) AS count
FROM entity_relationships
WHERE relationship_type IN ('aligned_with','associated_with','equated_with','identified_with',
                             'embodies','dwells_in','paired_with','presides_over',
                             'imprisoned_by','undergoes_process','transmits','reveals',
                             'emanates_from','symbolizes')
GROUP BY relationship_type
ORDER BY relationship_type;

COMMIT;
