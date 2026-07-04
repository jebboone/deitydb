-- ============================================================================
-- DeityDB — Norea / Sethian feminine buildout  (v2.1.61)
-- scripts/build_norea_sethian_buildout_v2_1_61.sql
-- ----------------------------------------------------------------------------
-- Fills out the Norea sub-graph, which previously held only three edges
-- (opposes→Archons, undergoes_process→Salvation, Eleleth guides→Norea) and a
-- locus-less citation. All loci are from the Hypostasis of the Archons (NHC
-- II,4), trans. Roger A. Bullard and Bentley Layton (Robinson, NHL, 3rd ed.),
-- cross-checked against the DF2 research dossier. These are locus-precise
-- POINTER citations (quote left NULL) — no text is quoted from memory; verbatim
-- excerpts remain pending human verification. Everything new lands
-- review_status='needs_review' / needs_review=true.
--
-- Idempotent: safe to re-run (ON CONFLICT DO NOTHING / guarded UPDATEs).
-- Encoding policy: primary-text loci only; no synthesis edges (the Norea↔Zoe
-- "fiery-breath" kinship is an interpretive reading and is intentionally NOT
-- encoded here).
-- ============================================================================

BEGIN;

-- 1. New entity: the Virginal Spirit ----------------------------------------
--    Named in Hyp. Arch. as Norea's abode in the Incorruptibility; distinct
--    from the existing "Virgin of the Light" (ENT_PS_VIRGIN_LIGHT, Pistis
--    Sophia) and from the spiritual "Eve/Zoe" (ENT_OPH_EVE_ZOE).
INSERT INTO entities
 (entity_id, canonical_name, greek_name, tradition, entity_type, category,
  primary_domains, tags, cult_scope, primary_period, evidence_confidence,
  review_status, inclusion_basis, earth_association_score, chthonic_flag,
  serpent_flag, short_note, entity_class)
VALUES
 ('ENT_SET_VIRGINAL_SPIRIT', 'Virginal Spirit', '', 'Sethian',
  'Aeon/personification', 'Aeon',
  'incorruptibility; virginal spirit; heavenly dwelling; feminine root', '',
  'Sethian', '', 'B', 'needs_review',
  'Sethian entity named in the Hypostasis of the Archons (NHC II,4) as Norea''s abode',
  0, false, false,
  'Exalted feminine dwelling in the realm of Incorruptibility; named in the Hypostasis of the Archons (NHC II,4) as the abode of Norea, and appearing in Sethian texts (e.g. the Apocryphon of John) as the Virgin Spirit.',
  'aeon')
ON CONFLICT (entity_id) DO NOTHING;

-- 2. Citation for the new entity (locus-precise pointer) ---------------------
INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator,
  translation_year, source_url, evidence_grade, evidence_note, verified_on,
  verify_method, display_order, needs_review, review_reason)
VALUES
 ('CIT_SET_VIRGINAL_SPIRIT_HYPARCH', 'ENT_SET_VIRGINAL_SPIRIT',
  'SRC_HYPOSTASIS_ARCHONS',
  'Hypostasis of the Archons (The Reality of the Rulers), NHC II,4',
  '93,18–32; 96,17–33 (Norea is told her abode is in the Incorruptibility where the Virginal Spirit dwells)',
  NULL, 'Roger A. Bullard and Bentley Layton', NULL, NULL,
  'primary-uncited',
  'Pointer citation — locus cross-checked against the DF2 dossier; verbatim excerpt pending.',
  NULL, 'locus from Bullard & Layton translation (Robinson, NHL 3rd ed.)',
  1, true, 'newly added entity — verbatim quote pending')
ON CONFLICT (citation_id) DO NOTHING;

-- 3. New Norea relationships (primary-text loci) -----------------------------
INSERT INTO entity_relationships
 (subject_entity_id, relationship_type, object_entity_id, confidence, rationale,
  source_id, review_status, period_id)
VALUES
 ('ENT_SET_NOREA', 'child_of', 'ENT_ISR_EVE', 'high',
  'Norea is born of Eve, presented by the Sethian text as her virgin daughter, undefiled by the rulers — Hyp. Arch. 91,34–92,4 (trans. Bullard & Layton). Object is the biblical Eve (ENT_ISR_EVE), reworked here; kept distinct from the spiritual Eve/Zoe (ENT_OPH_EVE_ZOE). Pointer cite — needs review. [v2.1.61]',
  'SRC_HYPOSTASIS_ARCHONS', 'needs_review', 'PER_GNO_2ND_4TH'),
 ('ENT_SET_NOREA', 'dwells_in', 'ENT_SET_VIRGINAL_SPIRIT', 'high',
  'Eleleth tells Norea her root and abode are in the Incorruptibility where the Virginal Spirit dwells — Hyp. Arch. 93,18–32; 96,17–33 (trans. Bullard & Layton). Pointer cite — needs review. [v2.1.61]',
  'SRC_HYPOSTASIS_ARCHONS', 'needs_review', 'PER_GNO_2ND_4TH'),
 ('ENT_SET_NOREA', 'rescued_by', 'ENT_SET_ELELETH', 'high',
  'At the limit of her embodied resistance Norea cries out for rescue and the great angel Eleleth descends to deliver and instruct her — Hyp. Arch. 92,32–93,2 ff. (trans. Bullard & Layton). Complements the existing Eleleth guides→Norea edge; encodes the cry-and-rescue that the deliverance turns on. Pointer cite — needs review. [v2.1.61]',
  'SRC_HYPOSTASIS_ARCHONS', 'needs_review', 'PER_GNO_2ND_4TH'),
 ('ENT_SET_ELELETH', 'rescues', 'ENT_SET_NOREA', 'high',
  'Mirror of Norea rescued_by→Eleleth: the great angel Eleleth answers Norea''s cry, delivers her from the rulers, and reveals her origin — Hyp. Arch. 93,2–32 (trans. Bullard & Layton). Pointer cite — needs review. [v2.1.61]',
  'SRC_HYPOSTASIS_ARCHONS', 'needs_review', 'PER_GNO_2ND_4TH')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- 4. Enrich the existing opposes edge's rationale (claim unchanged) ----------
--    Documents the specific acts of resistance; confidence and review_status
--    left as-is so the human-reviewed edge is not silently downgraded.
UPDATE entity_relationships
   SET rationale = 'Norea actively resists the archons: she refuses to render them service "like your mother Eve", burns the rulers'' ark, and renames them "rulers of darkness" before crying out for rescue — Hyp. Arch. 92,4–93,2 (trans. Bullard & Layton). [rationale enriched v2.1.61]'
 WHERE subject_entity_id = 'ENT_SET_NOREA'
   AND relationship_type = 'opposes'
   AND object_entity_id  = 'ENT_GNO_ARCHONS'
   AND rationale IS DISTINCT FROM 'Norea actively resists the archons: she refuses to render them service "like your mother Eve", burns the rulers'' ark, and renames them "rulers of darkness" before crying out for rescue — Hyp. Arch. 92,4–93,2 (trans. Bullard & Layton). [rationale enriched v2.1.61]';

-- 5. Fill Norea's own citation: real loci + named translator -----------------
UPDATE entity_citations
   SET locus      = '91,30–92,4 (born of Eve; named an "assistance"/boetheia for the generations); 92,18–93,2 (resists the rulers and cries out for rescue); 93,18–32; 96,17–33 (told her abode is in the Incorruptibility where the Virginal Spirit dwells)',
       translator = 'Roger A. Bullard and Bentley Layton',
       evidence_note = 'Pointer citation — loci cross-checked against the DF2 dossier; verbatim excerpt pending.',
       verify_method = 'loci from Bullard & Layton translation (Robinson, NHL 3rd ed.)',
       needs_review  = true,
       review_reason = 'loci filled v2.1.61; verbatim quote pending'
 WHERE citation_id = 'CIT_SET_NOREA_SEC';

COMMIT;
