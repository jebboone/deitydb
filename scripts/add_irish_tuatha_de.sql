-- scripts/add_irish_tuatha_de.sql
-- Tuatha De / Fomorian figures from Cath Maige Tuired (Stokes, CELT, PD). Verbatim,
-- substring-gated. Ethne folded into existing Ethniu as alias.

BEGIN;

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope, primary_period, evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note, entity_class)
VALUES
('ENT_IRL_MIACH','Miach','Celtic/Irish','God of healing','Healer','healing; restoration','Celtic/Irish','medieval Irish (recorded)','A','candidate_verified_name','Cath Maige Tuired primary attestation',1,false,false,'Son of Dian Cecht who fully healed Nuadu severed hand joint-to-joint, and was slain by his jealous father (Cath Maige Tuired).','deity'),
('ENT_IRL_AIRMED','Airmed','Celtic/Irish','Goddess of healing','Healer','healing; herbs','Celtic/Irish','medieval Irish (recorded)','A','candidate_verified_name','Cath Maige Tuired primary attestation',1,false,false,'Healer-daughter of Dian Cecht who knew the properties of every herb, until her father scattered them (Cath Maige Tuired).','deity'),
('ENT_IRL_OCTRIALLACH','Octriallach','Celtic/Irish','Fomorian','Fomorians','Fomorian warrior','Celtic/Irish','medieval Irish (recorded)','A','candidate_verified_name','Cath Maige Tuired primary attestation',1,false,false,'Fomorian warrior, son of Indech the Fomorian king, in the Second Battle of Mag Tuired.','monster'),
('ENT_IRL_DELBAETH','Delbaeth','Celtic/Irish','Fomorian ancestor','Fomorians','ancestry; the Fomorians','Celtic/Irish','medieval Irish (recorded)','A','candidate_verified_name','Cath Maige Tuired primary attestation',1,false,false,'Ancestral figure, father of Elatha king of the Fomorians, in the Cath Maige Tuired.','deity')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_aliases
  (entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
SELECT (select entity_id from entities where canonical_name='Ethniu'),'Ethne','variant','en','SRC_CATH_MAIGE_TUIRED','high','candidate_verified_name','Spelling in Cath Maige Tuired (Stokes).' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases a join entities e on e.entity_id=a.entity_id where e.canonical_name='Ethniu' and a.alias_name='Ethne');

INSERT INTO entity_citations
  (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order)
VALUES
('CIT_IRL_MIACH_CMT','ENT_IRL_MIACH','SRC_CATH_MAIGE_TUIRED','Cath Maige Tuired (The Second Battle of Mag Tuired)','Cath Maige Tuired','That seemed evil to his son Miach. He went to the hand which had been struck off Dian-cecht , and he said ‘joint to joint of it and sinew to sinew,’ and be healed Nuada in thrice three days and','Whitley Stokes',1891,'https://celt.ucc.ie/published/T300010.html',NULL,'primary-verbatim',NULL,true,'Named in Cath Maige Tuired (Stokes/CELT); verify section.',DATE '2026-06-26','name + substring gate against Stokes CMT (CELT)',1),
('CIT_IRL_AIRMED_CMT','ENT_IRL_AIRMED','SRC_CATH_MAIGE_TUIRED','Cath Maige Tuired (The Second Battle of Mag Tuired)','Cath Maige Tuired','Then Airmed opened her mantle and separated those herbs according to their properties.','Whitley Stokes',1891,'https://celt.ucc.ie/published/T300010.html',NULL,'primary-verbatim',NULL,true,'Named in Cath Maige Tuired (Stokes/CELT); verify section.',DATE '2026-06-26','name + substring gate against Stokes CMT (CELT)',1),
('CIT_IRL_OCTRIALLACH_CMT','ENT_IRL_OCTRIALLACH','SRC_CATH_MAIGE_TUIRED','Cath Maige Tuired (The Second Battle of Mag Tuired)','Cath Maige Tuired','There was a warrior with the Fomorians, even Octriallach son of Indech son of Dé Domnann, son of the Fomorian king.','Whitley Stokes',1891,'https://celt.ucc.ie/published/T300010.html',NULL,'primary-verbatim',NULL,true,'Named in Cath Maige Tuired (Stokes/CELT); verify section.',DATE '2026-06-26','name + substring gate against Stokes CMT (CELT)',1),
('CIT_IRL_DELBAETH_CMT','ENT_IRL_DELBAETH','SRC_CATH_MAIGE_TUIRED','Cath Maige Tuired (The Second Battle of Mag Tuired)','Cath Maige Tuired','For his father, even Elatha son of Delbaeth, was king of the Fomorians.','Whitley Stokes',1891,'https://celt.ucc.ie/published/T300010.html',NULL,'primary-verbatim',NULL,true,'Named in Cath Maige Tuired (Stokes/CELT); verify section.',DATE '2026-06-26','name + substring gate against Stokes CMT (CELT)',1)
ON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote;

COMMIT;
