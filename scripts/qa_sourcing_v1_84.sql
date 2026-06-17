-- qa_sourcing_v1_84.sql — sourcing/traceability QA pass after the v1.77–v1.84 build-out.
-- Idempotent. Two fixes surfaced by the audit:
--  (1) scholarly hagiographical Lives/encyclopedias mis-typed as bare 'reference work' (project rule:
--      a scholarly hagiographical dictionary = 'secondary scholarship', cf. Farmer's) — tanked the
--      Catholic cohorts' primary/scholarly coverage (Butler backs 58 of them).
--  (2) four newly-added sources left ORPHAN (added but never attached) — attach them to the figures
--      they actually document.
BEGIN;

-- (1) reclassify
UPDATE sources SET source_type='secondary scholarship'
 WHERE source_id IN ('SRC_BUTLER_SAINTS','SRC_BIBLIOTHECA_SANCTORUM') AND source_type='reference work';

-- (2) attach orphaned new sources -------------------------------------------------
-- Hildegard's Scivias -> Hildegard (she pre-existed, so the new cohort never attached it)
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
 SELECT 'ENT_SAINT_HILDEGARD','SRC_HILDEGARD_SCIVIAS','primary text attestation','Hildegard''s own visionary work'
 WHERE EXISTS(SELECT 1 FROM entities WHERE entity_id='ENT_SAINT_HILDEGARD')
   AND EXISTS(SELECT 1 FROM sources WHERE source_id='SRC_HILDEGARD_SCIVIAS')
 ON CONFLICT DO NOTHING;

-- Raymond of Capua's Life -> Catherine of Siena (pre-existed)
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
 SELECT 'ENT_SAINT_CATHERINE_SIENA','SRC_RAYMOND_CATHERINE','primary text attestation','Raymond of Capua''s Legenda Maior of Catherine'
 WHERE EXISTS(SELECT 1 FROM entities WHERE entity_id='ENT_SAINT_CATHERINE_SIENA')
   AND EXISTS(SELECT 1 FROM sources WHERE source_id='SRC_RAYMOND_CATHERINE')
 ON CONFLICT DO NOTHING;

-- Attar's Tadhkirat al-Awliya -> the classical Sufi saints it memorializes (added as a 2nd witness)
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
 SELECT entity_id,'SRC_ATTAR_TADHKIRAT','primary text attestation','memorialized in Attar''s Tadhkirat al-Awliya'
 FROM entities
 WHERE entity_id LIKE 'ENT\_SUF\_%' ESCAPE '\'
   AND (canonical_name ILIKE '%rabia%' OR canonical_name ILIKE '%hallaj%' OR canonical_name ILIKE '%junayd%'
        OR canonical_name ILIKE '%bistami%' OR canonical_name ILIKE '%dhul%nun%' OR canonical_name ILIKE '%qushayri%'
        OR canonical_name ILIKE '%attar%')
   AND EXISTS(SELECT 1 FROM sources WHERE source_id='SRC_ATTAR_TADHKIRAT')
 ON CONFLICT DO NOTHING;

-- Campbell, Digital Religion -> the digital-folklore beings it frames
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
 SELECT entity_id,'SRC_CAMPBELL_DIGITAL_RELIGION','scholarly attestation','contextualized in digital-religion scholarship'
 FROM entities
 WHERE tradition='Contemporary Folklore & Vernacular Religion'
   AND (canonical_name ILIKE '%slender%' OR canonical_name ILIKE '%tulpa%' OR canonical_name ILIKE '%witchtok%'
        OR canonical_name ILIKE '%online neopagan%' OR canonical_name ILIKE '%angel numbers%')
   AND EXISTS(SELECT 1 FROM sources WHERE source_id='SRC_CAMPBELL_DIGITAL_RELIGION')
 ON CONFLICT DO NOTHING;

COMMIT;

\echo '--- post-fix: Catholic cohort primary/scholarly coverage ---'
SELECT round(100.0*count(*) FILTER (WHERE EXISTS(SELECT 1 FROM entity_sources es JOIN sources s ON s.source_id=es.source_id WHERE es.entity_id=e.entity_id AND s.source_type IN ('primary text','secondary scholarship','primary inscription/artifact','heresiological source')))/count(*),1) AS pct
FROM entities e WHERE e.entity_id LIKE 'ENT\_EMC\_%' ESCAPE '\' OR e.entity_id LIKE 'ENT\_MOC\_%' ESCAPE '\';
\echo '--- post-fix: orphan sources remaining ---'
SELECT count(*) FROM sources s WHERE NOT EXISTS(SELECT 1 FROM entity_sources es WHERE es.source_id=s.source_id) AND NOT EXISTS(SELECT 1 FROM entity_relationships r WHERE r.source_id=s.source_id);
