-- Corrective: revert 2 apparatus/partial mis-anchors to pointer; clean 3 keepers.
BEGIN;
-- REVERT: Mikail anchored on a Rodwell footnote about the scholar J.D. Michaelis (not the angel).
-- REVERT: Jahannam grabbed a footnote (Talmud/Purgatory commentary) + mid-word start.
UPDATE entity_citations SET quote=NULL, evidence_grade='primary-uncited',
  work_title='Qur’an', translator=NULL, translation_year=NULL, source_url=NULL, verified_on=NULL,
  verify_method='Track-2 formalization of the entity''s existing source attestation (no verbatim quote — pointer + grade + flag)'
WHERE citation_id IN ('CIT_ISL_MIKAIL_SEC','CIT_ISLR_JAHANNAM_SEC');
-- CLEAN keepers (trim footnote tail / embedded marker / mid-word start — all still verbatim primary text):
UPDATE entity_citations SET quote='And who shall teach thee what the pit (El-Hawiya) is? A raging fire!'
  WHERE citation_id='CIT_ISLR_HAWIYAH_SEC' OR entity_id='ENT_ISLR_HAWIYAH';
UPDATE entity_citations SET quote='Until a way is opened for Gog and Magog, and they shall hasten from every high land, And this sure promise shall draw on.'
  WHERE entity_id='ENT_ISLR_GOG_MAGOG' OR entity_id='ENT_ISL_YAJUJ_MAJUJ' OR (verify_method ilike '%Rodwell%' AND quote ilike '%Gog and Magog%');
UPDATE entity_citations SET quote='For them, the gardens of Eden, under whose shades shall rivers flow: decked shall they be therein with bracelets of gold, and green robes of silk and rich brocade shall they wear,'
  WHERE verify_method ilike '%Rodwell%' AND quote ilike '%gardens of Eden%';
COMMIT;
