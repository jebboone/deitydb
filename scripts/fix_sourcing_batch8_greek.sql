-- Sourcing batch 8: Greek and Greek/* sub-traditions
-- 83 Greek + 10 Greek/* = 93 entities total.
-- Base: SRC_THEOI_HOME (broadest scope). Specific sub-sources by category.
-- Greek/Orphic entities included. Primary Greek texts (Hesiod, Homeric Hymns,
-- Apollodorus, Pausanias) flagged as future source registry additions per docs/sources.md.

BEGIN;

-- SRC_THEOI_HOME as base for all unsourced Greek/* entities
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_HOME', 'index attestation',
       'Attested in Theoi Project index (Greek gods, spirits, heroes in classical literature).'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_HOME'
  )
ON CONFLICT DO NOTHING;

-- SRC_THEOI_DAIMONES for daimones, personifications, and spirit-class beings
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_DAIMONES', 'index attestation',
       'Attested in Theoi Daemones/personifications index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN (
    'Abstraction','Avenging Daimon','Child-Harming Spirit',
    'Daimon','Disease Daimon','Liminal Daimon','War Daimon'
  )
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_DAIMONES'
  )
ON CONFLICT DO NOTHING;

-- SRC_THEOI_UNDERWORLD for underworld, chthonic, and judgment entities
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_UNDERWORLD', 'index attestation',
       'Attested in Theoi Underworld Gods index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN (
    'Underworld Deity','Underworld Guardian','Underworld Judge',
    'Chthonic Deity','Liminal Deity'
  )
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_UNDERWORLD'
  )
ON CONFLICT DO NOTHING;

-- SRC_THEOI_SEA for sea beings and sea monsters
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_DAIMONES', 'index attestation',
       'Attested in Theoi Sea Gods index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN ('Sea Monster','Sea Deity')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_DAIMONES'
  )
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_SEA', 'index attestation',
       'Attested in Theoi Sea Gods index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN ('Sea Monster','Sea Deity')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_SEA'
  )
ON CONFLICT DO NOTHING;

-- SRC_THEOI_DEIFIED for deified mortals, heroes, seers
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_DEIFIED', 'index attestation',
       'Attested in Theoi Deified Mortals index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN (
    'Healing Figure','Oracle Figure','Music Figure',
    'Craft Deity','Underworld Judge'
  )
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_DEIFIED'
  )
ON CONFLICT DO NOTHING;

-- SRC_THEOI_RUSTIC for rustic, pastoral, and ecstatic ritual beings
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_RUSTIC', 'index attestation',
       'Attested in Theoi Rustic Gods index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN ('Rustic Deity','Rustic Spirit','Protective Being','Ecstatic Ritual Being')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_RUSTIC'
  )
ON CONFLICT DO NOTHING;

-- SRC_THEOI_AGRICULTURE for mystery-tradition figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_AGRICULTURE', 'index attestation',
       'Attested in Theoi Agrarian and Mystery Gods index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN ('Mystery Deity','Mystery Figure')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_AGRICULTURE'
  )
ON CONFLICT DO NOTHING;

-- SRC_THEOI_GODS for core divine categories (Muses, Charites, Horai, Fates, etc.)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_THEOI_GODS', 'index attestation',
       'Attested in Theoi Greek Gods category index.'
FROM entities e
WHERE e.tradition ILIKE 'greek%'
  AND e.category IN (
    'Inspiration Deity','Grace Deity','Seasonal Deity','Fate Deity',
    'Wind Spirit','Monster','Chthonic Deity','Household Deity',
    'Astral Power','War Deity','Love Deity','Cosmic Theology',
    'Cosmic Deity','Fertility Deity','Nymph','Sea Deity'
  )
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_THEOI_GODS'
  )
ON CONFLICT DO NOTHING;

-- Verify
SELECT e.tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE e.tradition ILIKE 'greek%'
GROUP BY e.tradition
ORDER BY still_unsourced DESC, e.tradition;

COMMIT;
