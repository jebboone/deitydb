-- expand_greek_relationships_v4b.sql
-- Connects the final 7 Greek zero-rel entities.
-- Goal: bring Greek zero-rel from 7 → 0.
--
-- Entities:
--   ENT_AMECHANIA (Helplessness), ENT_EPIPHRON (Prudence),
--   ENT_PRAXIS (Action), ENT_THRASOS (Boldness/Rashness)
--   ENT_EURYNOME_PRIMORDIAL, ENT_OPHION, ENT_THESIS
--
-- Sources: SRC_THEOI_DAIMONES, SRC_APOLLODORUS_LIBRARY, SRC_HESIOD_THEOGONY

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;
SELECT COUNT(*) AS greek_zero_rel_before FROM entities WHERE tradition='Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);


-- ── Minor abstractions ────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- AMECHANIA (Helplessness/Lack of resource): the opposite of Poros
  ('ENT_AMECHANIA','opposes','ENT_POROS',
    'medium','Amechania (Helplessness, lack of resource or means) is the direct antithesis of Poros (Resource/Plenty); she personifies the state of being without recourse, contrasting with Poros in the same ethical cluster as Penia.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_AMECHANIA','paired_with','ENT_PENIA',
    'medium','Amechania (Helplessness) and Penia (Poverty) are closely allied personifications; both represent deprivation in the Greek daimonic moral taxonomy and appear together in lists of misery-daimons.','SRC_THEOI_DAIMONES','approved'),
  -- EPIPHRON (Prudence/Thoughtfulness): companion of Sophrosyne
  ('ENT_EPIPHRON','paired_with','ENT_SOPHROSYNE',
    'medium','Epiphron (Prudence, careful-mindedness) is a companion personification to Sophrosyne (Self-Control); both belong to the cluster of rational-moral virtues in the Greek daimonic taxonomy.','SRC_THEOI_DAIMONES','approved'),
  -- PRAXIS (Action): paired with Techne as the deed that craft produces
  ('ENT_PRAXIS','paired_with','ENT_TECHNE',
    'medium','Praxis (Action/Deed) and Techne (Craft/Skill) are conceptually paired in Greek philosophical thought: techne provides the means, praxis is the enacted deed; Aristotle Nicomachean Ethics 6.4 discusses them as related but distinct.','SRC_THEOI_DAIMONES','approved'),
  -- THRASOS (Boldness/Rashness): a form of excess paired with Hybris
  ('ENT_THRASOS','paired_with','ENT_HYBRIS',
    'medium','Thrasos (Reckless Boldness/Audacity) and Hybris (Insolence) are allied personifications of dangerous excess; both transgress proper limits, with Thrasos specifically denoting the boldness that crosses into recklessness.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_THRASOS','opposes','ENT_AIDOS',
    'medium','Thrasos (Reckless Audacity) is the antithesis of Aidos (Reverence/Shame); where Aidos restrains through fear of censure, Thrasos disregards all such restraint.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Orphic/Pelasgian primordials ─────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- EURYNOME PRIMORDIAL and OPHION: Pelasgian creation pair
  -- Apollonius Rhodius Argonautica 1.503-511: they ruled heaven before Cronus and Rhea
  ('ENT_EURYNOME_PRIMORDIAL','paired_with','ENT_OPHION',
    'high','Apollonius Rhodius Argonautica 1.503-511 (Orpheus''s song): "how first Eurynome, daughter of Ocean, ruled over all the immortals together with Ophion, and how they held the peaks of Olympus, until Kronos overcame Ophion and thrust him into the waves of Ocean." They are the primordial Pelasgian co-rulers.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OPHION','paired_with','ENT_EURYNOME_PRIMORDIAL',
    'high','See ENT_EURYNOME_PRIMORDIAL paired_with ENT_OPHION; Apollonius Rhodius Argonautica 1.503-511.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_EURYNOME_PRIMORDIAL','rules','ENT_SOVEREIGNTY',
    'high','Apollonius Rhodius Argonautica 1.503-511: Eurynome and Ophion "held the peaks of Olympus" and ruled the immortals before being displaced by Cronus and Rhea; she is a primordial sovereign.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OPHION','opposes','ENT_CRONUS',
    'high','Apollonius Rhodius Argonautica 1.503-511: Cronus overcame Ophion in single combat and thrust him into the waves of Ocean, displacing the primordial Pelasgian rulers.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- THESIS (Orphic primordial of creation/law): paired with Phanes
  ('ENT_THESIS','paired_with','ENT_PHANES',
    'medium','In the Orphic cosmogony, Thesis (the principle of Creation/Ordinance) is one of the earliest entities, associated with the primordial emergence from which Phanes (the first-born) arises; she personifies the initial act of cosmic ordering. Theoi Daimones index.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;
SELECT COUNT(*) AS greek_zero_rel_after FROM entities WHERE tradition='Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
