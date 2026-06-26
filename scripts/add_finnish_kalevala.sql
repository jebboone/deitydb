-- scripts/add_finnish_kalevala.sql
-- Finnish/Kalevala figures from the verse (Crawford #5186, PD). Verbatim, substring-gated;
-- glossary/preface excluded; Untamo dropped (homonym: dream-spirit vs Kullervo's enemy).

BEGIN;

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope, primary_period, evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note, entity_class)
VALUES
('ENT_FIN_AHTO','Ahto','Finnish/Kalevala','God','Sea Deity','sea; water; ruler of the waters','Finnish/Kalevala','Finnish oral (recorded 1849)','A','candidate_verified_name','Kalevala primary attestation',1,false,false,'King of the waters and the sea-folk in the Kalevala.','deity'),
('ENT_FIN_LOVIATAR','Loviatar','Finnish/Kalevala','Goddess','Disease Deity','disease; plague; the nine diseases','Finnish/Kalevala','Finnish oral (recorded 1849)','A','candidate_verified_name','Kalevala primary attestation',1,false,false,'Blind daughter of Tuoni, mother of the nine diseases/plagues, in the Kalevala (Rune 45).','deity'),
('ENT_FIN_OTSO','Otso','Finnish/Kalevala','Animal-spirit','Sacred Animal','the bear; forest; honey','Finnish/Kalevala','Finnish oral (recorded 1849)','A','candidate_verified_name','Kalevala primary attestation',1,false,false,'Otso, the sacred bear of the forest, the honey-paw, addressed with reverent epithets in the Kalevala.','spirit'),
('ENT_FIN_LEMPO','Lempo','Finnish/Kalevala','Demon','Evil Spirit','evil; mischief; injury','Finnish/Kalevala','Finnish oral (recorded 1849)','A','candidate_verified_name','Kalevala primary attestation',1,false,false,'Finnish evil spirit of mischief and harm in the Kalevala.','demon'),
('ENT_FIN_KALEVATAR','Kalevatar','Finnish/Kalevala','Goddess','Goddess','daughter of Kaleva; brewing','Finnish/Kalevala','Finnish oral (recorded 1849)','A','candidate_verified_name','Kalevala primary attestation',1,false,false,'Daughter of Kaleva, who in the Kalevala helps brew the first beer.','deity'),
('ENT_FIN_ANTEROVIPUNEN','Antero Vipunen','Finnish/Kalevala','Giant-sage','Giant','wisdom; lost words; the dead','Finnish/Kalevala','Finnish oral (recorded 1849)','A','candidate_verified_name','Kalevala primary attestation',1,false,false,'Antero Vipunen, the dead giant-sage from whom Vainamoinen wins lost magic words (Rune 17).','spirit')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_aliases
  (entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
SELECT 'ENT_FIN_LOVIATAR','Lowyatar','variant','en','SRC_KALEVALA','high','candidate_verified_name','Crawford spelling.' WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_FIN_LOVIATAR' AND alias_name='Lowyatar');

INSERT INTO entity_citations
  (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order)
VALUES
('CIT_AHTO_KAL','ENT_FIN_AHTO','SRC_KALEVALA','The Kalevala','Kalevala','Ahto, king of all the waters, Ancient king with beard of sea-grass, Raised his head above the billows, In a boat of water-lilies, Glided to the coast in s','John Martin Crawford',1888,'https://www.gutenberg.org/ebooks/5186',NULL,'primary-verbatim',NULL,true,'Named in the Kalevala (Crawford); verify rune.',DATE '2026-06-26','name + substring gate against Crawford Kalevala verse (#5186)',1),
('CIT_LOVIATAR_KAL','ENT_FIN_LOVIATAR','SRC_KALEVALA','The Kalevala','Kalevala','When the winds arose at evening, Heavy-laden grew Lowyatar, Through the east-wind’s impregnation, On the sand-plains, vast and barren.','John Martin Crawford',1888,'https://www.gutenberg.org/ebooks/5186',NULL,'primary-verbatim',NULL,true,'Named in the Kalevala (Crawford); verify rune.',DATE '2026-06-26','name + substring gate against Crawford Kalevala verse (#5186)',1),
('CIT_OTSO_KAL','ENT_FIN_OTSO','SRC_KALEVALA','The Kalevala','Kalevala','Thrice to Otso was it granted, In the circuit of the summer, To approach the land of cow-bells, Where the herdsmen’s voices echo; But to thee it was not granted, Ot','John Martin Crawford',1888,'https://www.gutenberg.org/ebooks/5186',NULL,'primary-verbatim',NULL,true,'Named in the Kalevala (Crawford); verify rune.',DATE '2026-06-26','name + substring gate against Crawford Kalevala verse (#5186)',1),
('CIT_LEMPO_KAL','ENT_FIN_LEMPO','SRC_KALEVALA','The Kalevala','Kalevala','To be roasted in the skillet, To be stewed in yonder kettle; Let fell Lempo fill thy tables! I have come with evil tidings, Come to tell the cruel story Of the flight and death of Aino, Sister dear of Youkahainen.','John Martin Crawford',1888,'https://www.gutenberg.org/ebooks/5186',NULL,'primary-verbatim',NULL,true,'Named in the Kalevala (Crawford); verify rune.',DATE '2026-06-26','name + substring gate against Crawford Kalevala verse (#5186)',1),
('CIT_KALEVATAR_KAL','ENT_FIN_KALEVATAR','SRC_KALEVALA','The Kalevala','Kalevala','That the beer may foam and sparkle, May ferment and be delightful?’ “Kalevatar, magic maiden, Grace and beauty in her fingers, Swiftly moving, lightly stepping, In her trimly-buckled sandals, Steps upon the birch-wood bottom, Tu','John Martin Crawford',1888,'https://www.gutenberg.org/ebooks/5186',NULL,'primary-verbatim',NULL,true,'Named in the Kalevala (Crawford); verify rune.',DATE '2026-06-26','name + substring gate against Crawford Kalevala verse (#5186)',1),
('CIT_ANTEROVIPUNEN_KAL','ENT_FIN_ANTEROVIPUNEN','SRC_KALEVALA','The Kalevala','Kalevala','Spake the hero, Wainamoinen: “O, thou Antero Wipunen, Open wide thy mouth and fauces, I have found the magic lost-words, I will leave thee now forever, Leave thee and thy wondrous singing, Will','John Martin Crawford',1888,'https://www.gutenberg.org/ebooks/5186',NULL,'primary-verbatim',NULL,true,'Named in the Kalevala (Crawford); verify rune.',DATE '2026-06-26','name + substring gate against Crawford Kalevala verse (#5186)',1)
ON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote;

COMMIT;
