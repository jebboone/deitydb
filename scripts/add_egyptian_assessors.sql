-- scripts/add_egyptian_assessors.sql
-- Proper-named Assessors of Maat (42 judges, Negative Confession, Book of the Dead 125),
-- Budge. Verbatim confession-line citations, substring-gated. Epithet-only assessors
-- (Devourer of the Shade, etc.) not added as named entities.

BEGIN;

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope, primary_period, evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note, entity_class)
VALUES
('ENT_EGY_FENTIU','Fentiu','Egyptian','Assessor of Maat','Judge of the Dead','assessor; judge of the dead; Hall of Maat; Khemennu','Egyptian','Egyptian (New Kingdom)','A','candidate_verified_name','Book of the Dead 125 primary attestation',2,false,false,'One of the forty-two Assessors of Maat who judge the dead in the Hall of Two Truths, addressed in the Negative Confession (Book of the Dead 125), coming forth from Khemennu.','spirit'),
('ENT_EGY_NEHAU','Nehau','Egyptian','Assessor of Maat','Judge of the Dead','assessor; judge of the dead; Hall of Maat; Re-stau','Egyptian','Egyptian (New Kingdom)','A','candidate_verified_name','Book of the Dead 125 primary attestation',2,false,false,'One of the forty-two Assessors of Maat who judge the dead in the Hall of Two Truths, addressed in the Negative Confession (Book of the Dead 125), coming forth from Re-stau.','spirit'),
('ENT_EGY_SEKHERIU','Sekheriu','Egyptian','Assessor of Maat','Judge of the Dead','assessor; judge of the dead; Hall of Maat; Utten','Egyptian','Egyptian (New Kingdom)','A','candidate_verified_name','Book of the Dead 125 primary attestation',2,false,false,'One of the forty-two Assessors of Maat who judge the dead in the Hall of Two Truths, addressed in the Negative Confession (Book of the Dead 125), coming forth from Utten.','spirit')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_citations
  (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order)
VALUES
('CIT_EGY_FENTIU_BOD','ENT_EGY_FENTIU','SRC_BUDGE','Budge, The Egyptian Book of the Dead','Book of the Dead 125 (Negative Confession)','Hail, Fentiu, who comest forth from Khemennu, I have not stolen.','E. A. Wallis Budge',1899,'https://www.sacred-texts.com/egy/ebod/',NULL,'primary-verbatim',NULL,true,'Named among the 42 Assessors in the Negative Confession (Budge); verify.',DATE '2026-06-26','name + substring gate against Budge Book of the Dead',1),
('CIT_EGY_NEHAU_BOD','ENT_EGY_NEHAU','SRC_BUDGE','Budge, The Egyptian Book of the Dead','Book of the Dead 125 (Negative Confession)','Hail, Nehau, who comest forth from Re-stau, I have not defrauded offerings.','E. A. Wallis Budge',1899,'https://www.sacred-texts.com/egy/ebod/',NULL,'primary-verbatim',NULL,true,'Named among the 42 Assessors in the Negative Confession (Budge); verify.',DATE '2026-06-26','name + substring gate against Budge Book of the Dead',1),
('CIT_EGY_SEKHERIU_BOD','ENT_EGY_SEKHERIU','SRC_BUDGE','Budge, The Egyptian Book of the Dead','Book of the Dead 125 (Negative Confession)','Hail, Sekheriu, who comest forth from Utten, I have not been an eavesdropper.','E. A. Wallis Budge',1899,'https://www.sacred-texts.com/egy/ebod/',NULL,'primary-verbatim',NULL,true,'Named among the 42 Assessors in the Negative Confession (Budge); verify.',DATE '2026-06-26','name + substring gate against Budge Book of the Dead',1)
ON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote;

COMMIT;
