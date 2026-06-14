-- expand_misc_zero_rel_v1.sql
-- Clears the 4 remaining non-Greek zero-rel entities:
--   ENT_GENEROSITY, ENT_POVERTY (Cross-traditional),
--   ENT_ROM_QUIRINUS (Roman), ENT_VAL_ENNOIA (Valentinian).
--
-- ENT_GENEROSITY / ENT_POVERTY:
--   Oppositional pair (virtue vs renunciation);
--   ENT_POVERTY opposes ENT_WEALTH;
--   ENT_SAINT_FRANCIS patron_of ENT_POVERTY (Franciscan vow);
--   ENT_SAINT_NICHOLAS patron_of ENT_GENEROSITY (gifts to the poor).
--
-- ENT_ROM_QUIRINUS:
--   Archaic Roman civic deity; identified with deified Romulus (Livy 1.16);
--   patron_of Sovereignty; paired_with Mars (Archaic Capitoline triad partner).
--   Source: SRC_LIVY_AUC, SRC_OVID_FASTI (Fasti 2.475-512).
--
-- ENT_VAL_ENNOIA:
--   Valentinian Aeon; co-eternal companion of Bythos (Forefather) before any
--   emanation (Irenaeus Adv. Haer. 1.1.1); paired_with Sige (Silence, her
--   near-equivalent); emanates_from Bythos in variants that treat her as first
--   emission.  Source: SRC_NHC, SRC_LAYTON_GNOSTIC.

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;


-- ── Cross-traditional virtue abstractions ─────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Generosity and Poverty as a virtue-renunciation pair
  ('ENT_GENEROSITY','paired_with','ENT_POVERTY',
    'medium','Generosity and Poverty are complementary cross-traditional abstractions: generosity presupposes the giver''s willingness to share; voluntary poverty (as in mendicant and Sufi traditions) is the rejection of surplus in favour of giving.','SRC_BUTLER_SAINTS','approved'),
  ('ENT_POVERTY','paired_with','ENT_GENEROSITY',
    'medium','See ENT_GENEROSITY paired_with ENT_POVERTY.','SRC_BUTLER_SAINTS','approved'),
  -- Poverty opposes Wealth as its direct antithesis
  ('ENT_POVERTY','opposes','ENT_WEALTH',
    'high','Poverty as a cross-traditional abstraction stands in direct opposition to Wealth/Abundance as an economic-spiritual category across Greek (Penia vs Poros), Christian (Matthew 6:24; Luke 16:13), and Islamic (Zuhd / asceticism) traditions.','SRC_BUTLER_SAINTS','approved'),
  -- Francis of Assisi patron_of Poverty (his vow of absolute poverty is definitional)
  ('ENT_SAINT_FRANCIS','patron_of','ENT_POVERTY',
    'high','Francis of Assisi took a vow of absolute poverty as the foundation of the Franciscan order; he is described as married to "Lady Poverty" in the Franciscan tradition (Thomas of Celano, Vita Prima).','SRC_BUTLER_SAINTS','approved'),
  -- Nicholas patron_of Generosity (anonymous gifts to the poor; dowry legend)
  ('ENT_SAINT_NICHOLAS','patron_of','ENT_GENEROSITY',
    'high','Nicholas of Myra is the patron saint of generosity: the core hagiographic legend (Butler''s Lives, Butler 6 Dec) describes him secretly tossing bags of gold through a window to provide dowries for a poor man''s daughters.','SRC_BUTLER_SAINTS','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Roman: Quirinus ───────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Quirinus patron_of Sovereignty (as deified Romulus, he protects the Roman people)
  ('ENT_ROM_QUIRINUS','patron_of','ENT_SOVEREIGNTY',
    'high','Quirinus is the deified form of Romulus, the legendary founder of Rome; as such he embodies the civic-religious sovereignty of the Roman people (Quirites), whose identity derives from his name. Livy Ab Urbe Condita 1.16.3.','SRC_LIVY_AUC','approved'),
  -- Quirinus paired_with Mars (Archaic triad: Jupiter, Mars, Quirinus)
  ('ENT_ROM_QUIRINUS','paired_with','ENT_ROM_MARS',
    'high','In the Archaic Roman triad (Iuppiter, Mars, Quirinus), Quirinus and Mars represent complementary aspects of the armed Roman citizen: Mars covers war and the soldier, Quirinus the civic identity of the Quirites at peace. Dumézil, La Religion romaine archaïque; SRC_LIVY_AUC.','SRC_LIVY_AUC','approved'),
  ('ENT_ROM_MARS','paired_with','ENT_ROM_QUIRINUS',
    'high','See ENT_ROM_QUIRINUS paired_with ENT_ROM_MARS.','SRC_LIVY_AUC','approved'),
  -- Quirinus received_as deified Romulus (Ovid Fasti 2.475-512)
  ('ENT_ROM_QUIRINUS','reception_of','ENT_ROM_MARS',
    'medium','Ovid Fasti 2.475-512 and Livy 1.16: Romulus was identified with Quirinus after his deification; some Roman scholars also identified Quirinus with Mars as the two patron war-gods of the city, though this is contested.','SRC_OVID_FASTI','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Valentinian: Ennoia ───────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Ennoia companion of Bythos before emanation (Irenaeus 1.1.1)
  ('ENT_VAL_ENNOIA','paired_with','ENT_VAL_BYTHOS',
    'high','Irenaeus Adversus Haereses 1.1.1 (Valentinian system): before any emanation Bythos (the Forefather) existed with Ennoia (Thought) as his co-eternal consort; together they are the silent, pre-emanative dyad of the Pleroma.','SRC_LAYTON_GNOSTIC','approved'),
  -- Ennoia paired_with / near-equivalent to Sige (Silence)
  ('ENT_VAL_ENNOIA','paired_with','ENT_VAL_SIGE',
    'high','Ennoia (Thought) and Sige (Silence) are closely related and sometimes interchangeable in different Valentinian accounts; Layton, The Gnostic Scriptures, p. 277: in some systems Ennoia names the same first female principle called Sige in others.','SRC_LAYTON_GNOSTIC','approved'),
  -- Ennoia emanates_from Bythos in variants that treat her as a derived aeon
  ('ENT_VAL_ENNOIA','emanates_from','ENT_VAL_BYTHOS',
    'medium','In Valentinian variants that treat Ennoia as the first emission of Bythos rather than his co-eternal companion, she is the primordial Thought emitted by the Forefather before the full Pleroma unfolds. Cf. Nag Hammadi tractates; SRC_NHC.','SRC_NHC','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;

SELECT tradition, COUNT(*) AS zero_rel
FROM entities
WHERE tradition IN ('Cross-traditional','Roman','Valentinian')
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id)
GROUP BY tradition;

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
