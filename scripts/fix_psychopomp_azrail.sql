-- Psychopomp audit: Islamic Angel of Death entities
-- Adds psychopomp classification, guides ENT_DEAD relationships,
-- entity_sources entries, and promotes Azrail review_status.
--
-- ENT_ISL_MALAK_AL_MAWT — Quranic Angel of Death (Quran 32:11)
-- ENT_ISL_AZRAIL        — Hadith-tradition name; identified_with Malak al-Mawt

BEGIN;

-- primary_domains
UPDATE entities SET primary_domains = primary_domains || '; psychopomp'
WHERE entity_id = 'ENT_ISL_MALAK_AL_MAWT';

UPDATE entities SET primary_domains = primary_domains || '; psychopomp'
WHERE entity_id = 'ENT_ISL_AZRAIL';

-- review_status: Azrail was needs_review; promote alongside classification
UPDATE entities SET review_status = 'candidate_verified_name'
WHERE entity_id = 'ENT_ISL_AZRAIL';

-- guides ENT_DEAD
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
    ('ENT_ISL_MALAK_AL_MAWT', 'guides', 'ENT_DEAD',
     'high',
     'Malak al-Mawt (Angel of Death) takes souls at the moment of death (Quran 32:11).',
     'SRC_QURAN', 'reviewed'),
    ('ENT_ISL_AZRAIL', 'guides', 'ENT_DEAD',
     'high',
     'Azrail is the named Angel of Death in Hadith tradition who receives and escorts souls at death.',
     'SRC_HADITH_GENERAL', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- entity_sources (both were unsourced)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
    ('ENT_ISL_MALAK_AL_MAWT', 'SRC_QURAN', 'primary_attestation',
     'Quran 32:11: "Say: the Angel of Death, who is set over you, will cause you to die."'),
    ('ENT_ISL_MALAK_AL_MAWT', 'SRC_ISLAM_EI2', 'secondary_reference',
     'EI2 article on Malak al-Mawt.'),
    ('ENT_ISL_AZRAIL', 'SRC_HADITH_GENERAL', 'primary_attestation',
     'Name Azrail/Izra''il appears in Hadith literature as the Angel of Death.'),
    ('ENT_ISL_AZRAIL', 'SRC_ISLAM_EI2', 'secondary_reference',
     'EI2 article on Izra''il.')
ON CONFLICT DO NOTHING;

-- Verify
SELECT e.entity_id, e.canonical_name, e.primary_domains, e.review_status,
       EXISTS (
           SELECT 1 FROM entity_relationships er
           WHERE er.subject_entity_id = e.entity_id
             AND er.relationship_type = 'guides'
             AND er.object_entity_id = 'ENT_DEAD'
       ) AS has_guides_dead,
       (SELECT COUNT(*) FROM entity_sources es WHERE es.entity_id = e.entity_id) AS source_count
FROM entities e
WHERE e.entity_id IN ('ENT_ISL_MALAK_AL_MAWT', 'ENT_ISL_AZRAIL')
ORDER BY e.entity_id;

COMMIT;
