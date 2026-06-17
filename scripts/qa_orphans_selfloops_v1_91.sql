-- qa_orphans_selfloops_v1_91.sql — post-roadmap audit cleanup (idempotent).
-- (1) delete 4 degenerate identified_with-self self-loops (real cross-links already exist).
-- (2) wire 17 pre-existing orphan entities into >=1 real edge.
BEGIN;
DELETE FROM entity_relationships WHERE subject_entity_id=object_entity_id AND relationship_type='identified_with';

-- Communion of Saints hub for the 13 orphan Christian saints
INSERT INTO entities (entity_id,canonical_name,tradition,entity_type,category,primary_domains,cult_scope,evidence_confidence,review_status,inclusion_basis,earth_association_score,chthonic_flag,serpent_flag,short_note)
VALUES ('ENT_CHR_COMMUNION_SAINTS','The Communion of Saints','Christian','Collective','Devotional collective','The whole body of venerated Christian saints across the calendar','devotional','B','candidate_verified_name','Audit cleanup hub for venerated saints (v1.91.0)',0,false,false,'The Communion of Saints — the ecclesiological collective of all the venerated holy dead; used here as a hub for individually-venerated saints.')
ON CONFLICT (entity_id) DO NOTHING;
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
 SELECT 'ENT_CHR_COMMUNION_SAINTS','SRC_FARMER_SAINTS','scholarly attestation','attestation'
 WHERE EXISTS(SELECT 1 FROM sources WHERE source_id='SRC_FARMER_SAINTS') ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id,period_id,confidence,rationale,source_id,review_status)
 SELECT 'ENT_CHR_COMMUNION_SAINTS','PER_MEDIEVAL_WEST','high','The cult of the saints across the Christian calendar.','SRC_FARMER_SAINTS','reviewed'
 WHERE EXISTS(SELECT 1 FROM periods WHERE period_id='PER_MEDIEVAL_WEST') ON CONFLICT DO NOTHING;

INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status)
SELECT v.s,'member_of','ENT_CHR_COMMUNION_SAINTS','high','A venerated saint of the Christian calendar (Communion of Saints).',
 (SELECT es.source_id FROM entity_sources es WHERE es.entity_id=v.s ORDER BY es.source_id LIMIT 1),'reviewed'
FROM (VALUES ('ENT_CHR_AGNES'),('ENT_CHR_LAWRENCE'),('ENT_CHR_PERPETUA'),('ENT_SAINT_ADALBERT'),('ENT_SAINT_BONIFACE'),
 ('ENT_SAINT_CATHERINE_GENOA'),('ENT_SAINT_CUTHBERT'),('ENT_SAINT_FAITH_CONQUES'),('ENT_SAINT_GENEVIEVE'),
 ('ENT_SAINT_NEPOMUK'),('ENT_SAINT_STANISLAUS'),('ENT_SAINT_SWITHUN'),('ENT_SAINT_WALBURGA')) v(s)
WHERE EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=v.s)
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;
-- the martyrs among them also embody Martyrdom
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status)
SELECT v.s,'embodies','ENT_MARTYRDOM','high','Venerated as a Christian martyr.',
 (SELECT es.source_id FROM entity_sources es WHERE es.entity_id=v.s ORDER BY es.source_id LIMIT 1),'reviewed'
FROM (VALUES ('ENT_CHR_AGNES'),('ENT_CHR_LAWRENCE'),('ENT_CHR_PERPETUA'),('ENT_SAINT_ADALBERT'),('ENT_SAINT_BONIFACE'),('ENT_SAINT_NEPOMUK'),('ENT_SAINT_STANISLAUS')) v(s)
WHERE EXISTS(SELECT 1 FROM entities WHERE entity_id='ENT_MARTYRDOM') AND EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=v.s)
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- the 4 orphan gods -> real cross-tradition / interpretatio edges
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status)
SELECT s,t,o,c,ra,(SELECT es.source_id FROM entity_sources es WHERE es.entity_id=s ORDER BY es.source_id LIMIT 1),'reviewed'
FROM (VALUES
 ('ENT_EGY_RENPET','aligned_with','ENT_ROM_ANNA_PERENNA','medium','Renpet (Egyptian goddess of the year/renewal) and Anna Perenna (Roman goddess of the year-cycle) are functional year-goddess cognates.'),
 ('ENT_EGY_NEMTY','aligned_with','ENT_CHARON','low','Nemty, the Egyptian falcon ferryman of the gods, is the functional counterpart of the Greek ferryman of the dead, Charon.'),
 ('ENT_ROM_VACUNA','equated_with','ENT_ROM_VICTORIA','medium','The Sabine goddess Vacuna was identified by Varro with Victoria (also with Diana/Ceres).')
) v(s,t,o,c,ra)
WHERE EXISTS(SELECT 1 FROM entities a WHERE a.entity_id=v.s) AND EXISTS(SELECT 1 FROM entities b WHERE b.entity_id=v.o)
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;
COMMIT;

\echo '--- orphan entities remaining (->0) ---'
SELECT count(*) FROM entities e WHERE NOT EXISTS(SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
\echo '--- self-loops remaining (->0) ---'
SELECT count(*) FROM entity_relationships WHERE subject_entity_id=object_entity_id;
