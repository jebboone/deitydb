-- scripts/normalize_source_types.sql
-- Normalize sources.source_type from ~39 ad-hoc values to a controlled vocabulary of 6
-- (v1.31.2). Controlled terms:
--   primary text                 -- ancient/traditional primary sources, their corpora,
--                                   critical editions and scholarly translations/anthologies
--   primary inscription/artifact -- epigraphic and material-object primary sources
--   heresiological source        -- patristic heresiology (witnesses to others' beliefs)
--   secondary scholarship        -- modern scholarly monographs, studies, articles
--   reference work               -- encyclopedias, dictionaries, lexicons, gazetteers, indices
--   internal                     -- internal method/heuristic markers (non-bibliographic)

BEGIN;

-- → primary text (fold all the primary-* variants, translations, editions, anthologies)
UPDATE sources SET source_type='primary text'
WHERE source_type IN (
  'primary text corpus','primary literary','primary/reception text','primary text translation',
  'primary/reception corpus','primary historical','primary philosophical','primary scholarly',
  'primary text / chronicle','primary text compilation','primary text / critical translation',
  'primary text / scholarly edition','primary text / scholarly translation','primary/theological text',
  'primary/theurgical text','primary ritual corpus','critical edition','critical scholarly translation',
  'hagiographic primary/reception text','medieval Irish mythological text','secondary/source anthology'
);

-- → primary inscription/artifact
UPDATE sources SET source_type='primary inscription/artifact'
WHERE source_type IN ('primary epigraphic','primary artifact');

-- → heresiological source (Irenaeus AH was mistagged 'primary text'; join the others)
UPDATE sources SET source_type='heresiological source'
WHERE source_id='SRC_IRENAEUS_AH';

-- → secondary scholarship
UPDATE sources SET source_type='secondary scholarship'
WHERE source_type IN ('secondary scholarly','secondary source','secondary monograph','secondary/source study','monograph');

-- → reference work (incl. the Theoi indices, gazetteers, hagiographic references, category markers)
UPDATE sources SET source_type='reference work'
WHERE source_type IN (
  'secondary reference index','academic reference','gazetteer','hagiographic/reference work',
  'reference category','scholarly reference','primary text/place index'
);

-- → internal
UPDATE sources SET source_type='internal'
WHERE source_type IN ('internal_method');

-- ── Verify: exactly the 6 controlled values remain ───────────────────────────
SELECT source_type, count(*) FROM sources GROUP BY 1 ORDER BY 2 DESC;
SELECT count(DISTINCT source_type) AS distinct_source_types,
       count(*) FILTER (WHERE source_type IS NULL OR source_type='') AS missing_type
FROM sources;

COMMIT;
