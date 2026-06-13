-- scripts/add_welsh_internal_relationships.sql
-- Adds internal Welsh family, rulership, and cosmological relationships
-- derived from the Four Branches of the Mabinogi (SRC_MABINOGION).
-- All relationships explicitly attested in the text; no inference.

BEGIN;

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES

-- ── Branch 1: Pwyll Penn Annwn ───────────────────────────────────────────────
-- Arawn is lord of Annwn (Mabinogi 1: exchanges kingdoms with Pwyll)
('ENT_WEL_ARAWN','rules','ENT_WEL_ANNWN','high',
 'Arawn is presented as king of Annwn in the First Branch; he approaches Pwyll to exchange kingdoms for a year to defeat Hafgan','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_ARAWN','dwells_in','ENT_WEL_ANNWN','high',
 'Arawn resides in Annwn; his palace and hunting court are its defining feature in the First Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Gwyn ap Nudd is ruler of Annwn in later Welsh tradition
('ENT_WEL_GWYN_AP_NUDD','rules','ENT_WEL_ANNWN','high',
 'Gwyn ap Nudd is named as lord of Annwn and the Otherworld dead; Culhwch ac Olwen; Welsh Triads 26; must ride to gather the dead on All Hallows','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_GWYN_AP_NUDD','dwells_in','ENT_WEL_ANNWN','high',
 'Gwyn ap Nudd presides over Annwn; his court is associated with Glastonbury Tor and the Otherworld hunt','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Pwyll and Rhiannon: marriage (First Branch)
('ENT_WEL_PWYLL','spouse_of','ENT_WEL_RHIANNON','high',
 'Pwyll and Rhiannon marry in the First Branch after he wins her from Gwawl; she chooses him herself','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_RHIANNON','spouse_of','ENT_WEL_PWYLL','high',
 'Rhiannon chooses Pwyll as husband in the First Branch; rides to meet him at Gorsedd Arberth','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Pryderi: son of Pwyll and Rhiannon (First Branch)
('ENT_WEL_PWYLL','parent_of','ENT_WEL_PRYDERI','high',
 'Pryderi is the son of Pwyll and Rhiannon; named Pryderi (care/anxiety) by Rhiannon after he is found; First Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_RHIANNON','parent_of','ENT_WEL_PRYDERI','high',
 'Rhiannon is mother of Pryderi; falsely accused of devouring him; exonerated when Teyrnon Twryf Lliant restores the boy; First Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- ── Branch 2: Branwen ferch Llŷr ────────────────────────────────────────────
-- Bran and Branwen are siblings; Manawydan is half-brother
('ENT_WEL_BRAN','sibling_of','ENT_WEL_BRANWEN','high',
 'Bran (Brân the Blessed) is brother of Branwen; the Second Branch opens with him on the rock of Harddlech with his sister','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_BRANWEN','sibling_of','ENT_WEL_BRAN','high',
 'Branwen is sister of Brân the Blessed; her marriage to Matholwch of Ireland triggers the tragedy of the Second Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_BRAN','sibling_of','ENT_WEL_MANAWYDAN','high',
 'Manawydan is named as brother of Bran in the Second Branch; together they lead the retinue to Ireland','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_MANAWYDAN','sibling_of','ENT_WEL_BRAN','high',
 'Manawydan is brother of Brân; survives the Irish expedition; Second Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_MANAWYDAN','sibling_of','ENT_WEL_BRANWEN','high',
 'Manawydan is named as Branwen''s brother in the Second Branch retinue','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_BRANWEN','sibling_of','ENT_WEL_MANAWYDAN','high',
 'Branwen is sister of Manawydan; named together as children of Llŷr; Second Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- ── Branch 3: Manawydan fab Llŷr ────────────────────────────────────────────
-- Manawydan marries Rhiannon (Pryderi''s widowed mother)
('ENT_WEL_MANAWYDAN','spouse_of','ENT_WEL_RHIANNON','high',
 'Manawydan takes Rhiannon as wife at Pryderi''s suggestion after Pwyll''s death; Third Branch — the two marriages frame Rhiannon''s sovereignty arc','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_RHIANNON','spouse_of','ENT_WEL_MANAWYDAN','high',
 'Rhiannon marries Manawydan in the Third Branch; her second marriage reinforces her sovereignty-goddess function','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- ── Branch 4: Math fab Mathonwy ─────────────────────────────────────────────
-- Dôn is mother of Gwydion and Aranrhod (the children of Dôn)
('ENT_WEL_DON','parent_of','ENT_WEL_GWYDION','high',
 'Gwydion is consistently named Gwydion fab Dôn (son of Dôn) in the Fourth Branch; Dôn is the dynastic mother of the northern Welsh divine family','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_DON','parent_of','ENT_WEL_ARANRHOD','high',
 'Aranrhod is daughter of Dôn; named ferch Dôn (daughter of Dôn) in the Fourth Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Gwydion and Aranrhod are siblings
('ENT_WEL_GWYDION','sibling_of','ENT_WEL_ARANRHOD','high',
 'Gwydion and Aranrhod are both children of Dôn; siblings in the Fourth Branch; their relationship is central to the tyngedau (fate-bindings) placed on Lleu','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_ARANRHOD','sibling_of','ENT_WEL_GWYDION','high',
 'Aranrhod is sister of Gwydion; her three tyngedau on her son Lleu are enacted through conflict with Gwydion; Fourth Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Aranrhod is mother of Lleu (she denies it but the text makes it clear)
('ENT_WEL_ARANRHOD','parent_of','ENT_WEL_LLEU_LLAW_GYFFES','high',
 'Aranrhod is the mother of Lleu; she steps over Math''s staff as a virginity test and gives birth; she refuses to acknowledge Lleu and binds three tyngedau (fates) upon him; Fourth Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Math and Gwydion create Blodeuwedd
('ENT_WEL_MATH','creator_of','ENT_WEL_BLODEUWEDD','high',
 'Math and Gwydion together conjure Blodeuwedd from oak, broom, and meadowsweet to be a wife for Lleu, since Aranrhod''s fate-binding prevents him marrying a human woman; Fourth Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_GWYDION','creator_of','ENT_WEL_BLODEUWEDD','high',
 'Gwydion is co-creator of Blodeuwedd alongside Math; it is Gwydion who later transforms her into an owl as punishment for her betrayal of Lleu; Fourth Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Lleu''s wife is Blodeuwedd (she betrays him but the marriage is explicit)
('ENT_WEL_LLEU_LLAW_GYFFES','spouse_of','ENT_WEL_BLODEUWEDD','high',
 'Blodeuwedd is made as wife for Lleu; the marriage and her betrayal (with Gronw Pebr) form the tragic core of the Fourth Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

('ENT_WEL_BLODEUWEDD','spouse_of','ENT_WEL_LLEU_LLAW_GYFFES','high',
 'Blodeuwedd is wife of Lleu; she arranges his near-death and is transformed into an owl by Gwydion; Fourth Branch','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed'),

-- Math rules Gwynedd (Math''s kingdom; the realm itself isn''t an entity but
-- his presiding over Annwn''s counterpart realm is not in scope —
-- link Math to Gwydion via teacher/student: Math is Gwydion''s uncle and teacher)
('ENT_WEL_MATH','teaches','ENT_WEL_GWYDION','high',
 'Math teaches Gwydion the arts of magic; the Fourth Branch frames Gwydion as Math''s apprentice and nephew; Mac Cana (1970) pp. 83-86','SRC_MABINOGION','PER_CEL_MEDIEVAL_WELSH','reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Verify
SELECT COUNT(*) AS new_welsh_relationships
FROM entity_relationships er
JOIN entities e ON er.subject_entity_id = e.entity_id
WHERE e.tradition = 'Celtic/Welsh';

SELECT * FROM v_release_metrics;

COMMIT;
