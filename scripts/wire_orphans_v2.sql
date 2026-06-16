-- wire_orphans_v2.sql — connectivity remediation batch 2 (v1.63.1)
-- Resolves more of the remaining orphans by wiring to EXISTING domain abstractions
-- (no off-ontology entities), plus one new, genuinely-canonical collective ("Royal
-- Saints") for the orphaned canonized monarchs. Saints stay venerated humans.
-- Idempotent: validates ids/types and skips duplicates; edge source = each subject's
-- own attesting source.
BEGIN;

-- New collective: Royal Saints (canonized kings / royal martyrs)
INSERT INTO entities (entity_id,canonical_name,tradition,entity_type,category,primary_domains,cult_scope,evidence_confidence,review_status,inclusion_basis,earth_association_score,chthonic_flag,serpent_flag,short_note)
VALUES ('ENT_SAINT_ROYAL_SAINTS','Royal Saints','Christian','Saint collective','Saint','kingship; sovereignty; national patronage','regional','B','candidate_verified_name','Standard hagiographic category of canonized monarchs and royal martyrs',0,false,false,'Collective of canonized kings and royal martyrs venerated as patrons of their realms.')
ON CONFLICT (entity_id) DO NOTHING;
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
VALUES ('ENT_SAINT_ROYAL_SAINTS','SRC_FARMER_SAINTS','scholarly attestation','Farmer, Oxford Dictionary of Saints')
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id,period_id,confidence,rationale,source_id,review_status)
VALUES ('ENT_SAINT_ROYAL_SAINTS','PER_MEDIEVAL_WEST','high','Royal saint cults flourished across the Western Middle Ages','SRC_FARMER_SAINTS','reviewed')
ON CONFLICT DO NOTHING;

CREATE TEMP TABLE _p2(subject text, rtype text, object text, confidence text, rationale text) ON COMMIT DROP;
INSERT INTO _p2 VALUES
-- non-saint hard cases → existing abstractions / relations
 ('ENT_HTT_HALKI','presides_over','ENT_AGRICULTURE','high','Hittite grain god'),
 ('ENT_LUW_MALIYA','presides_over','ENT_WATER','high','Luwian river goddess'),
 ('ENT_LUW_RUNTIYA','presides_over','ENT_ANIMALS','medium','Stag-god tutelary of wild animals'),
 ('ENT_EGY_TAYET','presides_over','ENT_CRAFT','medium','Goddess of weaving and linen'),
 ('ENT_MES_UGALLU','guardian_of','ENT_THRESHOLDS','medium','Apotropaic lion-demon warding doorways'),
 ('ENT_EGY_FOUR_RACES','protected_by','ENT_EGY_RA','medium','The four races of mankind shepherded by Ra in the Book of Gates'),
 ('ENT_ZOR_KERESASPA','slays','ENT_DRAGON','high','Avestan dragon-slayer hero who kills the horned serpent'),
-- saints → existing domain abstractions (venerated humans; patronage / apotropaic only)
 ('ENT_CHR_CECILIA','patron_of','ENT_MUSIC','high','Patron saint of music and musicians'),
 ('ENT_CHR_MARTIN','patron_of','ENT_MONASTICISM','high','Founder of Gaulish monasticism'),
 ('ENT_CHR_SEBASTIAN','opposes','ENT_DISEASE','medium','Invoked against plague'),
-- royal saints → the new Royal Saints collective
 ('ENT_SAINT_LOUIS','member_of','ENT_SAINT_ROYAL_SAINTS','high','Canonized king, Louis IX of France'),
 ('ENT_SAINT_OLAF','member_of','ENT_SAINT_ROYAL_SAINTS','high','Royal martyr, Olaf of Norway'),
 ('ENT_SAINT_WENCESLAUS','member_of','ENT_SAINT_ROYAL_SAINTS','high','Royal martyr, Wenceslaus of Bohemia'),
 ('ENT_SAINT_STEPHEN_HUNGARY','member_of','ENT_SAINT_ROYAL_SAINTS','high','Canonized king, Stephen I of Hungary'),
 ('ENT_SAINT_EDMUND_MARTYR','member_of','ENT_SAINT_ROYAL_SAINTS','high','Royal martyr, Edmund of East Anglia'),
 ('ENT_SAINT_CANUTE','member_of','ENT_SAINT_ROYAL_SAINTS','high','Royal martyr, Canute of Denmark'),
 ('ENT_SAINT_CASIMIR','member_of','ENT_SAINT_ROYAL_SAINTS','high','Royal saint, Casimir of Poland');

\echo '--- REJECTED (bad id/type or no source) — should be empty ---'
SELECT p.subject,p.rtype,p.object FROM _p2 p
WHERE NOT (EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.subject)
  AND EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.object)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=p.rtype)
  AND EXISTS(SELECT 1 FROM entity_sources es WHERE es.entity_id=p.subject));

INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status)
SELECT p.subject,p.rtype,p.object,p.confidence,p.rationale,
  (SELECT es.source_id FROM entity_sources es WHERE es.entity_id=p.subject ORDER BY es.source_id LIMIT 1),
  'reviewed'
FROM _p2 p
WHERE EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.subject)
  AND EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.object)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=p.rtype)
  AND EXISTS(SELECT 1 FROM entity_sources es WHERE es.entity_id=p.subject)
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

COMMIT;
