-- scripts/add_germanic_ancestors.sql
-- Tuisto & Mannus, the primeval Germanic ancestors (Tacitus, Germania 2). Verbatim.

BEGIN;

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope, primary_period, evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note, entity_class)
VALUES
('ENT_GMC_TUISTO','Tuisto','Continental Germanic','Primeval god','Primordial Being','Tuisto; Germanic origins; ancestor','Continental Germanic','1st c. CE (attested)','A','candidate_verified_name','Tacitus Germania primary attestation (ch. 2)',1,false,false,'Earth-born primeval god, father of Mannus and founder of the Germanic peoples (Tacitus, Germania 2).','deity'),
('ENT_GMC_MANNUS','Mannus','Continental Germanic','Ancestral god','Primordial Being','Mannus; Germanic origins; ancestor','Continental Germanic','1st c. CE (attested)','A','candidate_verified_name','Tacitus Germania primary attestation (ch. 2)',1,false,false,'Son of Tuisto and the eponymous ancestor of the Germanic nation, whose three sons gave their names to its peoples (Tacitus, Germania 2).','deity')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_citations
  (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order)
VALUES
('CIT_GMC_TUISTO_GERM','ENT_GMC_TUISTO','SRC_TACITUS_GERMANIA','Tacitus, Germania','Germania 2','they celebrate Tuisto, a God sprung from the earth, and Mannus his son, as the fathers and founders of the nation.','Thomas Gordon',1728,'https://www.gutenberg.org/ebooks/2995',NULL,'primary-verbatim',NULL,true,'Named in Tacitus Germania ch. 2; verify translation.',DATE '2026-06-26','name + substring gate against Tacitus Germania (Gutenberg #2995)',1),
('CIT_GMC_MANNUS_GERM','ENT_GMC_MANNUS','SRC_TACITUS_GERMANIA','Tacitus, Germania','Germania 2','they celebrate Tuisto, a God sprung from the earth, and Mannus his son, as the fathers and founders of the nation.','Thomas Gordon',1728,'https://www.gutenberg.org/ebooks/2995',NULL,'primary-verbatim',NULL,true,'Named in Tacitus Germania ch. 2; verify translation.',DATE '2026-06-26','name + substring gate against Tacitus Germania (Gutenberg #2995)',1)
ON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote;

COMMIT;
