-- Sourcing batch 6: Islamic traditions
-- Covers Islamic, Islamic/Sufi, Islamic/Shi'a, Shi'a Islam/Islamic,
-- Islamic/Sufi/Shi'a variants
-- ~28 entities; ENT_ISL_AZRAIL and ENT_ISL_MALAK_AL_MAWT already sourced

BEGIN;

-- EI2 as base secondary_reference for all Islamic-tradition entities
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_ISLAM_EI2', 'secondary_reference',
       'Attested in Encyclopaedia of Islam (EI2).'
FROM entities e
WHERE e.tradition IN (
    'Islamic','Islamic/Sufi','Islamic/Shi''a',
    'Shi''a Islam/Islamic','Islamic/Sufi/Shi''a','Islamic/Shi''a'
)
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_ISLAM_EI2'
  )
ON CONFLICT DO NOTHING;

-- Quran as primary_attestation for directly Quranic figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_QURAN', 'primary_attestation',
       'Named or described in the Qur''an.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_ISL_IBLIS','ENT_ISL_JIBRIL','ENT_ISL_MIKAIL',
    'ENT_ISL_ISRAFIL','ENT_ISL_JINN','ENT_ISL_SHAYATIN',
    'ENT_ISL_YAJUJ_MAJUJ','ENT_ISL_HARUT','ENT_ISL_MARUT',
    'ENT_ISL_ALLAH','ENT_ISL_KHIDR'
)
ON CONFLICT DO NOTHING;

-- Hadith as primary_attestation for Hadith-tradition figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_HADITH_GENERAL', 'primary_attestation',
       'Named or described in Hadith literature.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_ISL_MUNKAR','ENT_ISL_NAKIR','ENT_ISL_KIRAMAN_KATIBIN',
    'ENT_ISL_QARIN','ENT_ISL_DAJJAL','ENT_ISL_IFRIT',
    'ENT_ISL_MARID','ENT_ISL_ABDAL','ENT_ISL_QUTB',
    'ENT_ISL_RIJAL_GHAYB'
)
ON CONFLICT DO NOTHING;

-- Verify
SELECT e.tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE e.tradition IN (
    'Islamic','Islamic/Sufi','Islamic/Shi''a',
    'Shi''a Islam/Islamic','Islamic/Sufi/Shi''a'
)
GROUP BY e.tradition ORDER BY e.tradition;

COMMIT;
