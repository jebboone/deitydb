-- Sourcing batch 10: Cross-traditional abstraction nodes (118 entities)
-- All tradition=Cross-traditional entities were unsourced — these are ontological
-- scaffolding nodes that span multiple traditions and require comparative sources.
-- Sources added:
--   SRC_ELIADE_ER         — Encyclopedia of Religion 2nd ed. (Jones 2005) — all 118
--   SRC_HESIOD_THEOGONY   — Hesiod, Theogony (West 1966) — 36 explicit personifications
--   SRC_AVESTA            — Avesta Gathas — ENT_GOOD_MIND (Vohu Manah, Yasna 28-34)

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- New source records
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES (
    'SRC_HESIOD_THEOGONY',
    'Hesiod, Theogony and Works and Days',
    NULL,
    'primary text corpus',
    'Greek primordial cosmogony and genealogy of the gods; explicit personifications of primordial forces, fate, strife, and abstract conditions. Standard edition: M.L. West, Hesiod: Theogony; Works and Days (Oxford World''s Classics, 1988).'
),
(
    'SRC_ELIADE_ER',
    'Encyclopedia of Religion, 2nd edition (ed. Lindsay Jones)',
    NULL,
    'reference work',
    'Cross-traditional comparative religion reference; theological concepts, cosmological categories, ritual practices, and religious abstractions across world traditions. 15 vols., Macmillan Reference, 2005.'
)
ON CONFLICT (source_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Eliade ER — secondary_reference for all 118 Cross-traditional entities
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_ELIADE_ER', 'secondary_reference',
       'Cross-traditional concept documented in Encyclopedia of Religion, 2nd ed. (Jones 2005).'
FROM entities e
WHERE e.tradition = 'Cross-traditional'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_ELIADE_ER'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Hesiod Theogony — primary_attestation for 36 explicit personifications
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
    ('ENT_BEAUTY',          'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Charites (Theogony 907–911); Aphrodite born from sea-foam (Theogony 188–200).'),
    ('ENT_CHILDBIRTH_DANGER','SRC_HESIOD_THEOGONY', 'primary_attestation', 'Eileithyia, goddess of birth-pangs (Theogony 922).'),
    ('ENT_CONFLICT',        'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Eris, personification of strife, daughter of Nyx (Theogony 225).'),
    ('ENT_DARKNESS',        'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Erebos, primordial darkness born from Chaos (Theogony 123).'),
    ('ENT_DEATH',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Thanatos, personification of death, twin of Hypnos (Theogony 211–212).'),
    ('ENT_DECEPTION',       'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Apate, personification of deceit, daughter of Nyx (Theogony 224).'),
    ('ENT_DESIRE',          'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Eros, primordial desire (Theogony 120); Himeros, longing (Theogony 64).'),
    ('ENT_DESTINY',         'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Ker and Moros, fate and doom, children of Nyx (Theogony 211).'),
    ('ENT_DISEASE',         'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Nosoi, diseases released into the world (Theogony 217; Works and Days 102).'),
    ('ENT_EARTH',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Gaia, primordial earth, born after Chaos (Theogony 117–118).'),
    ('ENT_FATE',            'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Moirai (Clotho, Lachesis, Atropos), daughters of Zeus and Themis (Theogony 217, 904–906).'),
    ('ENT_FEAR',            'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Phobos (Fear) and Deimos (Terror), sons of Ares (Theogony 934).'),
    ('ENT_FORCE',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Kratos (Strength) and Bia (Force), children of Styx (Theogony 385).'),
    ('ENT_FORTUNE',         'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Tyche, Oceanid, personification of fortune (Theogony 360).'),
    ('ENT_INSPIRATION',     'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Muses, daughters of Zeus and Mnemosyne, patrons of poetic inspiration (Theogony 1–115).'),
    ('ENT_JUSTICE',         'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Dike (Justice), daughter of Zeus and Themis (Theogony 901; Works and Days 256–261).'),
    ('ENT_LIGHT',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Aether, primordial bright sky, born from Erebos and Nyx (Theogony 124).'),
    ('ENT_LONGING',         'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Himeros (Longing) present at Aphrodite''s birth (Theogony 64); Pothos attested in tradition.'),
    ('ENT_LOVE',            'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Eros, one of the first primordial beings (Theogony 120).'),
    ('ENT_MEMORY',          'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Mnemosyne (Memory), Titaness, mother of the Muses (Theogony 54).'),
    ('ENT_MISERY',          'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Oizys (Misery) and Ponos (Toil), children of Nyx (Theogony 214).'),
    ('ENT_MOON',            'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Selene, Titaness of the moon (Theogony 371).'),
    ('ENT_OLD_AGE',         'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Geras (Old Age), son of Nyx (Theogony 225).'),
    ('ENT_POETRY',          'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Calliope and the Muses, presiding over poetry (Theogony 79).'),
    ('ENT_POVERTY',         'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Penia (Poverty), attested in the Hesiodic corpus (Works and Days 497–499).'),
    ('ENT_POWER',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Kratos (Power/Strength), child of Styx (Theogony 385).'),
    ('ENT_PROSPERITY',      'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Ploutos (Wealth/Prosperity), son of Demeter and Iasion (Theogony 969).'),
    ('ENT_STORM',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Anemoi (winds) born of Astraeus (Theogony 378); Typhon, storm monster (Theogony 820–880).'),
    ('ENT_STRATEGY',        'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Metis (Cunning Intelligence), first wife of Zeus (Theogony 886–900).'),
    ('ENT_SUN',             'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Helios, Titan of the sun (Theogony 371).'),
    ('ENT_TERROR',          'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Deimos (Terror), son of Ares, twin of Phobos (Theogony 934).'),
    ('ENT_UNDERWORLD',      'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Tartarus, primordial abyss and underworld realm (Theogony 119, 720–819).'),
    ('ENT_UNION',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Philotes (Union/Affection), daughter of Nyx (Theogony 224).'),
    ('ENT_WATER',           'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Okeanos, Titan of the world-ocean (Theogony 131); Pontos, primordial sea (Theogony 132).'),
    ('ENT_WEALTH',          'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Ploutos (Wealth), son of Demeter and Iasion (Theogony 969).'),
    ('ENT_WIND',            'SRC_HESIOD_THEOGONY', 'primary_attestation', 'Anemoi (Boreas, Zephyrus, Notus, Eurus), sons of Astraeus and Eos (Theogony 378).')
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- ENT_GOOD_MIND — Avesta primary attestation (Vohu Manah, Yasna 28–34)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES (
    'ENT_GOOD_MIND', 'SRC_AVESTA', 'primary_attestation',
    'Vohu Manah (Good Mind), one of the Amesha Spentas, named in the Gathas (Yasna 28–34).'
)
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Verify: all Cross-traditional entities now sourced
-- ─────────────────────────────────────────────────────────────────────────────

SELECT
    COUNT(*) FILTER (WHERE EXISTS (
        SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
    )) AS now_sourced,
    COUNT(*) FILTER (WHERE NOT EXISTS (
        SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
    )) AS still_unsourced,
    COUNT(*) AS total
FROM entities e
WHERE e.tradition = 'Cross-traditional';

-- Overall unsourced count across entire DB
SELECT COUNT(*) AS total_unsourced_db
FROM entities e
WHERE NOT EXISTS (
    SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
);

COMMIT;
