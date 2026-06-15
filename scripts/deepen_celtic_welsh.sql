-- =====================================================================
-- deepen_celtic_welsh.sql  (v1.59.0 batch)
-- Celtic/Welsh 15 -> ~33. The figures of the Four Branches of the
-- Mabinogi, Culhwch ac Olwen, the Triads, and the Taliesin material.
-- Human kings / standalone epithets excluded; "divine" framing of the
-- legendary figures noted, not overstated. Additive; ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_MABINOGION','The Mabinogion, trans. Sioned Davies (Oxford World''s Classics, 2007)',NULL,'primary text','medieval Welsh prose tales'),
 ('SRC_TRIADS_BROMWICH','Rachel Bromwich, Trioedd Ynys Prydein: The Triads of the Island of Britain (Univ. of Wales Press, 4th ed. 2014)',NULL,'secondary scholarship','Welsh triadic tradition')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_WEL_LLYR','Llŷr','Celtic/Welsh','Ancestor deity','House of Llŷr','the sea; ancestry','mythological','A','candidate_verified_name','Mabinogi, Second Branch',2,false,false,'Sea-associated ancestor; husband of Penarddun, father of Brân, Branwen and Manawydan; Welsh cognate of Irish Lir.'),
 ('ENT_WEL_PENARDDUN','Penarddun','Celtic/Welsh','Goddess','House of Llŷr','ancestral motherhood','mythological','B','candidate_verified_name','Mabinogi, Second Branch',1,false,false,'Wife of Llŷr; mother of Brân, Branwen and Manawydan, and (by Euroswydd) of Nisien and Efnysien.'),
 ('ENT_WEL_BELI_MAWR','Beli Mawr','Celtic/Welsh','Ancestor deity','Ancestral line','primordial ancestry; kingship','mythological','A','candidate_verified_name','Lludd and Llefelys; Triads',1,false,false,'Primordial ancestor-figure, father of Lludd, Llefelys, Caswallawn and (per Triad) Arianrhod.'),
 ('ENT_WEL_MABON','Mabon ap Modron','Celtic/Welsh','God','Divine youth','youth; hunting; liberation','mythological','A','candidate_verified_name','Culhwch ac Olwen; Triads',1,false,false,'The "Great Son, son of the Great Mother," a divine youth (from British Maponos) freed in Culhwch; one of the Three Exalted Prisoners.'),
 ('ENT_WEL_MODRON','Modron','Celtic/Welsh','Mother goddess','Divine mother','motherhood; the land','mythological','A','candidate_verified_name','Culhwch ac Olwen; Triad 70',2,false,false,'The "Great Mother" (from Gaulish Matrona), mother of Mabon; daughter of Avallach.'),
 ('ENT_WEL_GOFANNON','Gofannon','Celtic/Welsh','Craft god','Children of Dôn','smithing; metalwork','mythological','A','candidate_verified_name','Mabinogi, Fourth Branch; Culhwch',2,false,false,'Divine smith, son of Dôn, Welsh counterpart of Irish Goibniu; slayer of his nephew Dylan.'),
 ('ENT_WEL_AMAETHON','Amaethon','Celtic/Welsh','God','Children of Dôn','agriculture; ploughing','mythological','B','candidate_verified_name','Culhwch ac Olwen',3,false,false,'The "Great Ploughman," god of agriculture, son of Dôn.'),
 ('ENT_WEL_GILFAETHWY','Gilfaethwy','Celtic/Welsh','God','Children of Dôn','(brother of Gwydion)','mythological','B','candidate_verified_name','Mabinogi, Fourth Branch',0,false,false,'Son of Dôn, brother of Gwydion; his rape of Goewin sets the Fourth Branch in motion.'),
 ('ENT_WEL_DYLAN','Dylan ail Don','Celtic/Welsh','Sea god','Children of Dôn','the sea; the waves','mythological','A','candidate_verified_name','Mabinogi, Fourth Branch',2,false,false,'"Dylan Second-Wave," a sea-figure, son of Arianrhod and brother-figure of Lleu; slain by Gofannon.'),
 ('ENT_WEL_TEYRNON','Teyrnon','Celtic/Welsh','Divine lord','Dyfed','lordship; fosterage','mythological','B','candidate_verified_name','Mabinogi, First Branch',1,false,false,'Lord of Gwent Is-Coed and foster-father of Pryderi; his name (from Tigernonos, "Divine Lord") pairs with Rhiannon (Rigantona).'),
 ('ENT_WEL_HAFGAN','Hafgan','Celtic/Welsh','Otherworld king','Annwn','kingship of the Otherworld','mythological','B','candidate_verified_name','Mabinogi, First Branch',1,true,false,'A king of Annwn, rival of Arawn, slain by Pwyll in Arawn''s shape.'),
 ('ENT_WEL_LLUDD','Lludd Llaw Eraint','Celtic/Welsh','God-king','House of Beli','kingship; sovereignty','mythological','A','candidate_verified_name','Lludd and Llefelys; Culhwch',1,false,false,'King of Britain "of the Silver Hand," son of Beli Mawr, father of Creiddylad; earlier Brittonic Nodens, cognate of Irish Nuada. Distinct from his son Gwyn ap Nudd.'),
 ('ENT_WEL_CREIDDYLAD','Creiddylad','Celtic/Welsh','Goddess','House of Lludd','sovereignty; spring/summer','mythological','A','candidate_verified_name','Culhwch ac Olwen',2,false,false,'Daughter of Lludd, fought over each May Day by Gwyn ap Nudd and Gwythyr (a seasonal-combat myth); Latinised as Cordelia.'),
 ('ENT_WEL_EFNYSIEN','Efnysien','Celtic/Welsh','Antagonist figure','House of Llŷr','strife; destruction','mythological','A','candidate_verified_name','Mabinogi, Second Branch',0,false,false,'Son of Euroswydd and Penarddun, half-brother of Brân; the strife-maker who provokes the Irish war and destroys the Cauldron of Rebirth at the cost of his life.'),
 ('ENT_WEL_NISIEN','Nisien','Celtic/Welsh','Peacemaker figure','House of Llŷr','peace; concord','mythological','B','candidate_verified_name','Mabinogi, Second Branch',0,false,false,'The peacemaker twin of Efnysien, who could make foes friends.'),
 ('ENT_WEL_EUROSWYDD','Euroswydd','Celtic/Welsh','Ancestor figure','House of Llŷr','(father of the twins)','mythological','B','candidate_verified_name','Mabinogi, Second Branch; Triads',0,false,false,'Father of Nisien and Efnysien by Penarddun; in the Triads, the captor of Llŷr.'),
 ('ENT_WEL_LLWYD','Llwyd ap Cil Coed','Celtic/Welsh','Enchanter','Dyfed','enchantment; vengeance','mythological','B','candidate_verified_name','Mabinogi, Third Branch',0,false,false,'The enchanter who lays the wasteland-spell on Dyfed and imprisons Pryderi and Rhiannon, avenging his friend Gwawl.'),
 ('ENT_WEL_CERIDWEN','Ceridwen','Celtic/Welsh','Enchantress','Cauldron of Awen','the cauldron; inspiration (awen); transformation','mythological','A','candidate_verified_name','Hanes Taliesin',2,false,false,'The keeper of the Cauldron of Awen whose brew and pursuit reborn Gwion as Taliesin; a powerful enchantress (the "goddess of inspiration" framing is largely modern).'),
 ('ENT_WEL_MORFRAN','Morfran','Celtic/Welsh','Divine/heroic figure','Children of Ceridwen','darkness; ugliness; battle','mythological','B','candidate_verified_name','Hanes Taliesin; Culhwch',0,false,false,'"Great Crow" (also Afagddu, "Utter Darkness"), monstrous son of Ceridwen and Tegid Foel; a survivor of Camlan.'),
 ('ENT_WEL_OLWEN','Olwen','Celtic/Welsh','Goddess','Giants','fertility; the sovereignty-bride','mythological','A','candidate_verified_name','Culhwch ac Olwen',3,false,false,'"White-track," daughter of the giant Ysbaddaden; white trefoils spring up where she walks (a fertility/sovereignty motif).'),
 ('ENT_WEL_YSBADDADEN','Ysbaddaden','Celtic/Welsh','Giant','Giants','the impossible tasks','mythological','A','candidate_verified_name','Culhwch ac Olwen',0,false,false,'The Chief Giant, father of Olwen, who sets Culhwch the great series of impossible tasks (anoethau).'),
 ('ENT_WEL_GWYTHYR','Gwythyr','Celtic/Welsh','God','Seasonal combatants','summer; the upper world','mythological','B','candidate_verified_name','Culhwch ac Olwen; Triads',1,false,false,'Gwythyr fab Greidawl, betrothed of Creiddylad and perpetual seasonal opponent of Gwyn ap Nudd.'),
 ('ENT_WEL_TEGID_FOEL','Tegid Foel','Celtic/Welsh','Tutelary figure','Llyn Tegid','the lake of Bala','mythological','B','candidate_verified_name','Hanes Taliesin',2,false,false,'Husband of Ceridwen and tutelary figure of Llyn Tegid (Bala Lake).'),
 ('ENT_WEL_CREIRWY','Creirwy','Celtic/Welsh','Goddess/maiden','Children of Ceridwen','beauty','mythological','C','candidate_verified_name','Hanes Taliesin; Triads',0,false,false,'Daughter of Ceridwen and Tegid Foel, named among the Three Most Beautiful Maidens of the Triads.')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_MABINOGION','direct attestation','Named in the Mabinogion (the Four Branches / Culhwch / Hanes Taliesin).'
FROM entities WHERE tradition='Celtic/Welsh' AND review_status='candidate_verified_name'
  AND entity_id IN ('ENT_WEL_LLYR','ENT_WEL_PENARDDUN','ENT_WEL_GOFANNON','ENT_WEL_AMAETHON','ENT_WEL_GILFAETHWY','ENT_WEL_DYLAN','ENT_WEL_TEYRNON','ENT_WEL_HAFGAN','ENT_WEL_LLUDD','ENT_WEL_CREIDDYLAD','ENT_WEL_EFNYSIEN','ENT_WEL_NISIEN','ENT_WEL_EUROSWYDD','ENT_WEL_LLWYD','ENT_WEL_CERIDWEN','ENT_WEL_MORFRAN','ENT_WEL_OLWEN','ENT_WEL_YSBADDADEN','ENT_WEL_GWYTHYR','ENT_WEL_TEGID_FOEL','ENT_WEL_CREIRWY','ENT_WEL_MABON','ENT_WEL_MODRON')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_TRIADS_BROMWICH','scholarly attestation','Attested in the Welsh Triads (Trioedd Ynys Prydein).'
FROM entities WHERE entity_id IN ('ENT_WEL_BELI_MAWR','ENT_WEL_MABON','ENT_WEL_MODRON','ENT_WEL_EUROSWYDD','ENT_WEL_CREIRWY')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_CEL_MEDIEVAL_WELSH','A','Attested in the medieval Welsh literary corpus.','SRC_MABINOGION','reviewed'
FROM entities WHERE tradition='Celtic/Welsh' AND review_status='candidate_verified_name' AND entity_id LIKE 'ENT_WEL_%'
  AND entity_id NOT IN ('ENT_WEL_ANNWN','ENT_WEL_ARANRHOD','ENT_WEL_ARAWN','ENT_WEL_BLODEUWEDD','ENT_WEL_BRAN','ENT_WEL_BRANWEN','ENT_WEL_DON','ENT_WEL_GWYDION','ENT_WEL_GWYN_AP_NUDD','ENT_WEL_LLEU_LLAW_GYFFES','ENT_WEL_MANAWYDAN','ENT_WEL_MATH','ENT_WEL_PRYDERI','ENT_WEL_PWYLL','ENT_WEL_RHIANNON')
ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_WEL_LLYR','consort_of','ENT_WEL_PENARDDUN','high','Llŷr and Penarddun, parents of the House of Llŷr.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_BRAN','child_of','ENT_WEL_LLYR','high','Brân the Blessed, son of Llŷr.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_BRANWEN','child_of','ENT_WEL_LLYR','high','Branwen, daughter of Llŷr.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_MANAWYDAN','child_of','ENT_WEL_LLYR','high','Manawydan, son of Llŷr.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_EFNYSIEN','child_of','ENT_WEL_PENARDDUN','high','Son of Penarddun by Euroswydd.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_NISIEN','child_of','ENT_WEL_PENARDDUN','high','Son of Penarddun by Euroswydd.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_EFNYSIEN','child_of','ENT_WEL_EUROSWYDD','high','Son of Euroswydd.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_NISIEN','sibling_of','ENT_WEL_EFNYSIEN','high','The peacemaker and strife-maker twins.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_LLUDD','child_of','ENT_WEL_BELI_MAWR','high','Lludd, son of Beli Mawr.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_CREIDDYLAD','child_of','ENT_WEL_LLUDD','high','Daughter of Lludd.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_MABON','child_of','ENT_WEL_MODRON','high','Mabon, son of Modron.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_GOFANNON','child_of','ENT_WEL_DON','high','Gofannon, child of Dôn.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_AMAETHON','child_of','ENT_WEL_DON','high','Amaethon, child of Dôn.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_GILFAETHWY','child_of','ENT_WEL_DON','high','Gilfaethwy, child of Dôn.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_GILFAETHWY','sibling_of','ENT_WEL_GWYDION','high','Brother of Gwydion.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_DYLAN','child_of','ENT_WEL_ARANRHOD','high','Dylan, son of Arianrhod.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_GOFANNON','slays','ENT_WEL_DYLAN','high','Gofannon slays his nephew Dylan.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_GOFANNON','identified_with','ENT_CEL_GOIBNIU','high','Welsh smith-god cognate of Irish Goibniu.','SRC_TRIADS_BROMWICH','reviewed'),
 ('ENT_WEL_MABON','reception_of','ENT_CEL_MAPONOS','high','Mabon ap Modron descends from the Brythonic god Maponos.','SRC_TRIADS_BROMWICH','reviewed'),
 ('ENT_WEL_TEYRNON','consort_of','ENT_WEL_RHIANNON','low','By name (Tigernonos/Rigantona) the divine pair behind Teyrnon and Rhiannon.','SRC_TRIADS_BROMWICH','reviewed'),
 ('ENT_WEL_HAFGAN','opposes','ENT_WEL_ARAWN','high','Rival king of Annwn to Arawn.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_HAFGAN','dwells_in','ENT_WEL_ANNWN','high','A king of Annwn.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_CERIDWEN','parent_of','ENT_WEL_MORFRAN','high','Mother of Morfran/Afagddu.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_CERIDWEN','consort_of','ENT_WEL_TEGID_FOEL','high','Wife of Tegid Foel of Llyn Tegid.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_CREIRWY','child_of','ENT_WEL_CERIDWEN','high','Daughter of Ceridwen and Tegid Foel.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_OLWEN','child_of','ENT_WEL_YSBADDADEN','high','Daughter of the giant Ysbaddaden.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_GWYTHYR','opposes','ENT_WEL_GWYN_AP_NUDD','high','Perpetual seasonal combat over Creiddylad.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_GWYN_AP_NUDD','child_of','ENT_WEL_LLUDD','medium','Gwyn ap Nudd, son of Nudd/Lludd of the Silver Hand.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_LLUDD','reception_of','ENT_CEL_NUADA','medium','Lludd/Nudd Llaw Eraint and Irish Nuada both descend from Brittonic Nodens.','SRC_TRIADS_BROMWICH','reviewed')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Celtic/Welsh count (expect ~38) =='
SELECT count(*) FROM entities WHERE tradition='Celtic/Welsh';
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
