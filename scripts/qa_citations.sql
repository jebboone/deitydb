-- qa_citations.sql — mechanical citation-quality lint over entity_citations (v2.1.58 audit).
-- Read-only: every check SELECTs offending rows; nothing is modified. Run any time:
--   podman exec -i deitydb psql -U postgres -d deitydb -v ON_ERROR_STOP=1 < scripts/qa_citations.sql
-- Checks:
--   (A) quote contains HTML/URL markers (scraper grabbed page chrome, not source text)
--   (B) quote carries footnote/apparatus signatures (glossary "See:", " s.v. ", bracketed
--       cross-refs, OCR footnote-digit runs, running-head ALLCAPS after a digit run)
--   (C) work_title vs locus contradiction (Iliad titled but Odyssey locus, and vice-versa)
--   (D) sources.title names a translator ("trans. X") that the row's own translator field contradicts
--   (E) homonym suspects: quote names neither the entity's canonical_name nor any alias/name
-- Lint output is a WORKLIST, not a verdict — (B) and (E) are heuristic and include false
-- positives (variant spellings, epithet-only quotes); verify before editing anything.

\echo '=== (A) HTML/URL markers in quote ==='
SELECT count(*) AS check_a_count
FROM entity_citations
WHERE quote IS NOT NULL
  AND (quote LIKE '%<%' OR quote ILIKE '%href=%' OR quote ILIKE '%media-subnav%'
       OR quote ILIKE '%http%' OR quote LIKE '%/details/%');

SELECT c.citation_id, e.canonical_name, left(c.quote,70) AS quote_head, c.needs_review
FROM entity_citations c JOIN entities e ON e.entity_id=c.entity_id
WHERE c.quote IS NOT NULL
  AND (c.quote LIKE '%<%' OR c.quote ILIKE '%href=%' OR c.quote ILIKE '%media-subnav%'
       OR c.quote ILIKE '%http%' OR c.quote LIKE '%/details/%')
ORDER BY c.citation_id;

\echo '=== (B) footnote/apparatus signatures in quote ==='
SELECT count(*) AS check_b_count
FROM entity_citations
WHERE quote IS NOT NULL
  AND (quote ~ '^\s*See '            -- leading "See " (footnote/cross-ref opener)
       OR quote LIKE '% s.v. %'      -- lexicon "sub verbo"
       OR quote ~ 'See: '            -- glossary cross-reference
       OR quote ~* '\[(cf\.|see |q\.v\.)' -- bracketed editorial cross-refs
       OR quote ~ '[0-9]+ [A-Z]{3,}' -- digit run then ALLCAPS: OCR running head (e.g. "39 THE LIBRARY")
       OR quote ~ '\y[a-z]+[0-9]+\y' -- word with glued trailing digits: OCR footnote superscripts
      );

SELECT c.citation_id, e.canonical_name, left(c.quote,70) AS quote_head, c.needs_review
FROM entity_citations c JOIN entities e ON e.entity_id=c.entity_id
WHERE c.quote IS NOT NULL
  AND (c.quote ~ '^\s*See ' OR c.quote LIKE '% s.v. %' OR c.quote ~ 'See: '
       OR c.quote ~* '\[(cf\.|see |q\.v\.)'
       OR c.quote ~ '[0-9]+ [A-Z]{3,}'
       OR c.quote ~ '\y[a-z]+[0-9]+\y')
ORDER BY c.citation_id;

\echo '=== (C) work_title vs locus contradiction (Iliad/Odyssey) ==='
SELECT count(*) AS check_c_count
FROM entity_citations
WHERE (work_title ILIKE '%iliad%' AND work_title NOT ILIKE '%odyssey%' AND locus ILIKE '%odyssey%')
   OR (work_title ILIKE '%odyssey%' AND work_title NOT ILIKE '%iliad%' AND locus ILIKE '%iliad%');

SELECT c.citation_id, e.canonical_name, c.work_title, c.locus, c.needs_review
FROM entity_citations c JOIN entities e ON e.entity_id=c.entity_id
WHERE (c.work_title ILIKE '%iliad%' AND c.work_title NOT ILIKE '%odyssey%' AND c.locus ILIKE '%odyssey%')
   OR (c.work_title ILIKE '%odyssey%' AND c.work_title NOT ILIKE '%iliad%' AND c.locus ILIKE '%iliad%')
ORDER BY c.citation_id;

\echo '=== (D) sources.title translator vs citation translator mismatch ==='
SELECT count(*) AS check_d_count
FROM entity_citations c JOIN sources s ON s.source_id=c.source_id
WHERE c.translator IS NOT NULL
  AND s.title ~* 'trans\.'
  AND position(lower(regexp_replace(c.translator,'^.*[[:space:]]','')) IN lower(s.title)) = 0;

SELECT s.source_id, s.title AS source_title, c.translator, count(*) AS citations
FROM entity_citations c JOIN sources s ON s.source_id=c.source_id
WHERE c.translator IS NOT NULL
  AND s.title ~* 'trans\.'
  AND position(lower(regexp_replace(c.translator,'^.*[[:space:]]','')) IN lower(s.title)) = 0
GROUP BY 1,2,3 ORDER BY 1,4 DESC;

\echo '=== (E) homonym suspects: quote contains neither canonical_name nor any alias/name ==='
SELECT count(*) AS check_e_count
FROM entity_citations c JOIN entities e ON e.entity_id=c.entity_id
WHERE c.quote IS NOT NULL
  AND c.quote NOT ILIKE '%'||e.canonical_name||'%'
  AND NOT EXISTS (SELECT 1 FROM entity_aliases a
                  WHERE a.entity_id=e.entity_id AND c.quote ILIKE '%'||a.alias_name||'%')
  AND NOT EXISTS (SELECT 1 FROM names n
                  WHERE n.entity_id=e.entity_id AND c.quote ILIKE '%'||n.name||'%');

SELECT c.citation_id, e.canonical_name, left(c.quote,70) AS quote_head, c.needs_review
FROM entity_citations c JOIN entities e ON e.entity_id=c.entity_id
WHERE c.quote IS NOT NULL
  AND c.quote NOT ILIKE '%'||e.canonical_name||'%'
  AND NOT EXISTS (SELECT 1 FROM entity_aliases a
                  WHERE a.entity_id=e.entity_id AND c.quote ILIKE '%'||a.alias_name||'%')
  AND NOT EXISTS (SELECT 1 FROM names n
                  WHERE n.entity_id=e.entity_id AND c.quote ILIKE '%'||n.name||'%')
ORDER BY c.citation_id
LIMIT 100;

\echo '--- summary flags: needs_review totals ---'
SELECT needs_review, count(*) FROM entity_citations GROUP BY 1 ORDER BY 1;
