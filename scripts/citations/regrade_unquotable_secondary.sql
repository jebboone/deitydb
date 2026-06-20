-- regrade_unquotable_secondary.sql  (v2.1.9)
-- Honest re-grade of primary-uncited entities whose source is structurally NOT
-- primary-quotable, so the public grade badges stop implying a verbatim primary
-- quote is "pending / an upgrade target." Run AFTER all build_*.sql + track2.
--
-- Scope (conservative): only sources that cannot yield a public-domain verbatim
-- quote. LEFT as primary-uncited: PD texts not yet mined (Homer/Hesiod/Edda/
-- Pausanias tails), OCR-but-PD (Avesta, Dee), and Ovid Fasti (PD primary text
-- lacking a clean English edition — a future PD edition could still upgrade it).

BEGIN;

-- (1) In-copyright modern editions/studies: primary attestation exists, but the
-- modern critical edition/translation is under copyright and can't be quoted.
UPDATE entity_citations SET
    evidence_grade='secondary',
    review_reason='Primary attestation documented in a modern, in-copyright edition/study; cited at locus, not reproducible as a public-domain verbatim quote.'
WHERE evidence_grade='primary-uncited'
  AND work_title ~* 'Faulkner.*Pyramid|Wyatt.*Ugarit|Foster.*Before the Muses|Sayings of the Desert Fathers|Sch.fer|Andrew R\. George|Hoffner.*Hittite|Alice A\. Bailey|Hayyim Vital.*Etz Hayyim';

-- (2) Inscriptional / non-textual corpora: no running text to quote.
UPDATE entity_citations SET
    evidence_grade='secondary',
    review_reason='Attested in an epigraphic/inscriptional corpus (no quotable running text); cited at locus.'
WHERE evidence_grade='primary-uncited'
  AND work_title ~* 'Inscriptionum Latinarum|Roman Inscriptions of Britain|Collingwood|Piacenza Liver|keilalphabetischen';

COMMIT;
