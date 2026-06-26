-- scripts/add_bundahishn_creatures.sql
-- Zoroastrian tail (cont.): Bundahishn primordial creatures, from West's SBE5
-- translation (PDF provided by Jeb; same text as sacred-texts SBE05). Verbatim,
-- substring-gated. Canonical = standard Avestan form; West's spelling as alias.

BEGIN;

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope, primary_period, evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note, entity_class)
VALUES
('ENT_ZOR_GAOKERENA','Gaokerena','Zoroastrian','Cosmic plant','Mythical Plant','Gaokerena; Zoroastrian cosmology; Bundahishn','Zoroastrian','Sasanian/Pahlavi','A','candidate_verified_name','Bundahishn primary attestation',1,false,false,'The Gokard (Gaokerena), the white-Haoma tree of all germs in the cosmic sea, whose sap confers immortality at the renovation (Bundahishn).','spirit'),
('ENT_ZOR_GOPATSHAH','Gopatshah','Zoroastrian','Bull-man','Mythical Being','Gopatshah; Zoroastrian cosmology; Bundahishn','Zoroastrian','Sasanian/Pahlavi','A','candidate_verified_name','Bundahishn primary attestation',1,false,false,'Gopatshah, the ox-bodied man among the Zoroastrian immortals who keeps the seashore (Bundahishn).','spirit'),
('ENT_ZOR_GAVAEVODATA','Gavaevodata','Zoroastrian','Primeval ox','Mythical Being','Gavaevodata; Zoroastrian cosmology; Bundahishn','Zoroastrian','Sasanian/Pahlavi','A','candidate_verified_name','Bundahishn primary attestation',1,false,false,'Gavaevodata, the sole-created (primeval) ox slain at the origin, from whose body the plants and animals arose (Bundahishn).','spirit'),
('ENT_ZOR_HADHAYANS','Hadhayans','Zoroastrian','Mythical ox','Mythical Being','Hadhayans; Zoroastrian cosmology; Bundahishn','Zoroastrian','Sasanian/Pahlavi','A','candidate_verified_name','Bundahishn primary attestation',1,false,false,'The ox Hadhayosh (Sarsaok), which carried mankind between the regions and from whose fat the drink of immortality is prepared at the renovation (Bundahishn).','spirit'),
('ENT_ZOR_VIZARESHA','Vizaresha','Zoroastrian','Demon','Demon','Vizaresha; Zoroastrian cosmology; Bundahishn','Zoroastrian','Sasanian/Pahlavi','A','candidate_verified_name','Bundahishn primary attestation',1,false,false,'Vizaresha, the demon who seizes the souls of the departed and drags them terror-stricken to the gate of hell (Bundahishn).','demon')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_aliases
  (entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
SELECT 'ENT_ZOR_GAOKERENA','Gokard','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_GAOKERENA' AND alias_name='Gokard')
UNION ALL
SELECT 'ENT_ZOR_GAOKERENA','Gokard tree','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_GAOKERENA' AND alias_name='Gokard tree')
UNION ALL
SELECT 'ENT_ZOR_GAOKERENA','white Haoma','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_GAOKERENA' AND alias_name='white Haoma')
UNION ALL
SELECT 'ENT_ZOR_GOPATSHAH','Gopat-shah','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_GOPATSHAH' AND alias_name='Gopat-shah')
UNION ALL
SELECT 'ENT_ZOR_GAVAEVODATA','the primeval ox','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_GAVAEVODATA' AND alias_name='the primeval ox')
UNION ALL
SELECT 'ENT_ZOR_GAVAEVODATA','sole-created ox','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_GAVAEVODATA' AND alias_name='sole-created ox')
UNION ALL
SELECT 'ENT_ZOR_GAVAEVODATA','Gav','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_GAVAEVODATA' AND alias_name='Gav')
UNION ALL
SELECT 'ENT_ZOR_HADHAYANS','Hadhayosh','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_HADHAYANS' AND alias_name='Hadhayosh')
UNION ALL
SELECT 'ENT_ZOR_HADHAYANS','Sarsaok','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_HADHAYANS' AND alias_name='Sarsaok')
UNION ALL
SELECT 'ENT_ZOR_HADHAYANS','Srisok','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_HADHAYANS' AND alias_name='Srisok')
UNION ALL
SELECT 'ENT_ZOR_VIZARESHA','Vizaresh','variant','en','SRC_BUNDAHISHN','high','candidate_verified_name','West SBE5 spelling/epithet.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ZOR_VIZARESHA' AND alias_name='Vizaresh');

INSERT INTO entity_citations
  (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order)
VALUES
('CIT_GAOKERENA_BUN','ENT_ZOR_GAOKERENA','SRC_BUNDAHISHN','Bundahishn (Greater Bundahishn)','Bundahishn','And near to that tree of all germs the Gokard tree was produced, for keeping away deformed (dushpad) decrepitude; and the full perfection of the world arose therefrom. CHAPTER 10. On the conflict waged with the primeval ox. 1.','E. W. West (Sacred Books of the East 5)',1880,'https://www.sacred-texts.com/zor/sbe05/index.htm',NULL,'primary-verbatim',NULL,true,'Located by name in the Bundahishn (West SBE5); verify the chapter.section.',DATE '2026-06-26','name + substring gate against West Bundahishn (SBE5)',1),
('CIT_GOPATSHAH_BUN','ENT_ZOR_GOPATSHAH','SRC_BUNDAHISHN','Bundahishn (Greater Bundahishn)','Bundahishn','ngdez; Aghrerad son of Pashang is in the land of Saukavastan, and they call him Gopatshah; Parshadga Hvembya is in the plain of Peshyansai, and he is Hvembya for this reason, because they brought him up in a hvemb (“jar”) for fear of Khashm (“Wrath”); \[Asam-i Yamahusht is in the place which they call the River Naivtak','E. W. West (Sacred Books of the East 5)',1880,'https://www.sacred-texts.com/zor/sbe05/index.htm',NULL,'primary-verbatim',NULL,true,'Located by name in the Bundahishn (West SBE5); verify the chapter.section.',DATE '2026-06-26','name + substring gate against West Bundahishn (SBE5)',1),
('CIT_GAVAEVODATA_BUN','ENT_ZOR_GAVAEVODATA','SRC_BUNDAHISHN','Bundahishn (Greater Bundahishn)','Bundahishn','This also is said, that when the primeval ox passed away it fell to the right hand, and Gayomard afterwards, when he passed away, to the left hand.','E. W. West (Sacred Books of the East 5)',1880,'https://www.sacred-texts.com/zor/sbe05/index.htm',NULL,'primary-verbatim',NULL,true,'Located by name in the Bundahishn (West SBE5); verify the chapter.section.',DATE '2026-06-26','name + substring gate against West Bundahishn (SBE5)',1),
('CIT_HADHAYANS_BUN','ENT_ZOR_HADHAYANS','SRC_BUNDAHISHN','Bundahishn (Greater Bundahishn)','Bundahishn','Of the ox Hadhayosh, which they call Sarsaok, it says, that in the original creation men passed from region to region upon it, and in the renovation of the universe they prepare Hush (the beverage producing immortality) from it. 14.','E. W. West (Sacred Books of the East 5)',1880,'https://www.sacred-texts.com/zor/sbe05/index.htm',NULL,'primary-verbatim',NULL,true,'Located by name in the Bundahishn (West SBE5); verify the chapter.section.',DATE '2026-06-26','name + substring gate against West Bundahishn (SBE5)',1),
('CIT_VIZARESHA_BUN','ENT_ZOR_VIZARESHA','SRC_BUNDAHISHN','Bundahishn (Greater Bundahishn)','Bundahishn','The demon Vizaresh is he who struggles with the souls of men which have departed, those days and nights when they remain in the world; he carries them on, terror-stricken, and sits at the gate of hell. 19.','E. W. West (Sacred Books of the East 5)',1880,'https://www.sacred-texts.com/zor/sbe05/index.htm',NULL,'primary-verbatim',NULL,true,'Located by name in the Bundahishn (West SBE5); verify the chapter.section.',DATE '2026-06-26','name + substring gate against West Bundahishn (SBE5)',1)
ON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote;

COMMIT;
