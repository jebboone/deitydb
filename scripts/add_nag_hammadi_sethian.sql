-- scripts/add_nag_hammadi_sethian.sql
-- Nag Hammadi verify-and-add pass, batch 1: the three Platonizing Sethian
-- tractate-eponym revealers, surfaced as genuinely-missing by the 2026-06-25
-- coverage audit (verified absent in entities AND entity_aliases).
--
--   Zostrianos (NHC VIII,1), Allogenes (NHC XI,3), Marsanes (NHC X,1)
--
-- Citations are real verbatim excerpts, substring-gated against the Robinson
-- "Nag Hammadi Library in English" (1990) text hosted per-tractate at gnosis.org,
-- extracted via scripts/citations/cite_anchor.py (config 'nhc'), then trimmed to
-- complete sentences (still verbatim). Flagged needs_review for locus/edition
-- verification. No AI-written descriptions.

BEGIN;

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains,
   cult_scope, primary_period, evidence_confidence, review_status, inclusion_basis,
   earth_association_score, chthonic_flag, serpent_flag, short_note, entity_class)
VALUES
('ENT_SET_ZOSTRIANOS','Zostrianos','Sethian','Visionary/revealer figure','Revealer Figure','Zostrianos; visionary ascent; baptism; Sethian revelation','Sethian','2nd-3rd c. CE','A','candidate_verified_name','Nag Hammadi primary attestation (NHC VIII,1)',1,false,false,'Visionary ascender and revealer of the Sethian treatise Zostrianos (NHC VIII,1).','prophet'),
('ENT_SET_ALLOGENES','Allogenes','Sethian','Visionary/revealer figure','Revealer Figure','Allogenes; visionary ascent; the Unknowable One; Sethian revelation','Sethian','2nd-3rd c. CE','A','candidate_verified_name','Nag Hammadi primary attestation (NHC XI,3)',1,false,false,'Sethian visionary revealer ("the Foreigner") of the treatise Allogenes (NHC XI,3).','prophet'),
('ENT_SET_MARSANES','Marsanes','Sethian','Prophet/visionary figure','Revealer Figure','Marsanes; visionary ascent; the seals; Sethian revelation','Sethian','2nd-3rd c. CE','A','candidate_verified_name','Nag Hammadi primary attestation (NHC X,1)',1,false,false,'Sethian prophet-visionary of the treatise Marsanes (NHC X,1).','prophet')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_aliases
  (entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
SELECT 'ENT_SET_ALLOGENES','the Foreigner','epithet','en','SRC_NAG_HAMMADI_SCRIPTURES','high','candidate_verified_name','Allogenes = "one of another kind"; rendered "the Foreigner" in the tractate title.'
WHERE NOT EXISTS (
  SELECT 1 FROM entity_aliases WHERE entity_id='ENT_SET_ALLOGENES' AND alias_name='the Foreigner'
);

INSERT INTO entity_citations
  (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,
   source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,
   verified_on,verify_method,display_order)
VALUES
('CIT_SET_ZOSTRIANOS_NHC','ENT_SET_ZOSTRIANOS','SRC_NAG_HAMMADI_SCRIPTURES','The Nag Hammadi Library (Robinson, ed.)','NHC VIII,1','[ ] of the [ ] the words [ ] live forever, these I [ ] Zostrianos [ ] and [ ] and Iolaos, when I was in the world for these like me and [those] after me, [the] living elect. As God lives, [ ] the truth with truth and knowledge and eternal light.','J. M. Robinson et al.',1990,'http://gnosis.org/naghamm/zostr.html',NULL,'primary-verbatim',NULL,true,'In-copyright modern translation - brief excerpt for scholarly identification, located by name; verify against the published edition.',DATE '2026-06-25','name-anchored + substring gate against gnosis.org Robinson NHL text; trimmed to full sentences',1),
('CIT_SET_ALLOGENES_NHC','ENT_SET_ALLOGENES','SRC_NAG_HAMMADI_SCRIPTURES','The Nag Hammadi Library (Robinson, ed.)','NHC XI,3','She made a revelation to me and said: "No one is able to hear these things except the great powers alone, O Allogenes.','J. M. Robinson et al.',1990,'http://gnosis.org/naghamm/allogene.html',NULL,'primary-verbatim',NULL,true,'In-copyright modern translation - brief excerpt for scholarly identification, located by name; verify against the published edition.',DATE '2026-06-25','name-anchored + substring gate against gnosis.org Robinson NHL text; trimmed to full sentences',1),
('CIT_SET_MARSANES_NHC','ENT_SET_MARSANES','SRC_NAG_HAMMADI_SCRIPTURES','The Nag Hammadi Library (Robinson, ed.)','NHC X,1','Marsanes and a reward. They came to know; they found him with a pure heart, (and) they are not afflicted by him with evils. Those who have received you (pl.) will be given their choice reward for endurance, and he will ward off the evils from them. But let none of us be distressed and think in his heart that the great Father [ ]. For he looks upon the All and takes care of them all. And he has shown to them his [ ].','J. M. Robinson et al.',1990,'http://gnosis.org/naghamm/marsanes.html',NULL,'primary-verbatim',NULL,true,'In-copyright modern translation - brief excerpt for scholarly identification, located by name; verify against the published edition.',DATE '2026-06-25','name-anchored + substring gate against gnosis.org Robinson NHL text; trimmed to full sentences',1)
ON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote, locus=EXCLUDED.locus,
  source_url=EXCLUDED.source_url, verify_method=EXCLUDED.verify_method;

COMMIT;
