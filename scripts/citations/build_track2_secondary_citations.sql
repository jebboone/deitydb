-- ============================================================================
-- DeityDB — Track 2: formalize every uncited entity's existing source attestation
-- into entity_citations as a graded, flagged POINTER (no verbatim quote).
-- ----------------------------------------------------------------------------
-- Run AFTER all verbatim (Track-1) citation builds. Idempotent: only fills
-- entities that have no citation yet. Each row records the real source the
-- entry rests on, graded by source_type and flagged needs_review, so no entity
-- is left as bare (uncited) AI-paraphrase prose.
--   primary-uncited  = a primary source is identified but not yet quoted verbatim
--   secondary        = attestation rests on secondary scholarship
--   reference        = attestation rests on a reference work
-- ============================================================================

ALTER TABLE entity_citations ALTER COLUMN quote DROP NOT NULL;
ALTER TABLE entity_citations ALTER COLUMN source_url DROP NOT NULL;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, original_text_url, evidence_grade, evidence_note, needs_review, review_reason,
  verified_on, verify_method, display_order)
SELECT DISTINCT ON (e.entity_id)
  left('CIT_'||replace(e.entity_id,'ENT_','')||'_SEC',60),
  e.entity_id, s.source_id, s.title,
  coalesce(substring(es.source_note from '([A-Z][[:alpha:]]+\.? [0-9][0-9.:,–-]*)'), 'per cited source'),
  NULL, NULL, NULL, s.url, NULL,
  CASE WHEN s.source_type IN ('primary text','primary inscription/artifact','heresiological source') THEN 'primary-uncited'
       WHEN s.source_type='secondary scholarship' THEN 'secondary'
       WHEN s.source_type='reference work' THEN 'reference'
       ELSE 'secondary' END,
  NULL, true,
  CASE WHEN s.source_type IN ('primary text','primary inscription/artifact','heresiological source')
       THEN 'Primary source identified but not yet quoted verbatim; the on-page summary is an editorial paraphrase pending verification against this text.'
       ELSE 'Attestation rests on secondary/reference scholarship; the on-page summary is an editorial paraphrase not yet verified against the cited work.' END,
  NULL, 'Track-2 formalization of the entity''s existing source attestation (no verbatim quote — pointer + grade + flag)', 2
FROM entities e
JOIN entity_sources es ON es.entity_id=e.entity_id
JOIN sources s ON s.source_id=es.source_id
WHERE NOT EXISTS (SELECT 1 FROM entity_citations c WHERE c.entity_id=e.entity_id)
ORDER BY e.entity_id,
  CASE s.source_type WHEN 'primary text' THEN 1 WHEN 'primary inscription/artifact' THEN 1
       WHEN 'heresiological source' THEN 2 WHEN 'secondary scholarship' THEN 3 WHEN 'reference work' THEN 4 ELSE 5 END,
  length(es.source_note) DESC
ON CONFLICT (citation_id) DO NOTHING;
