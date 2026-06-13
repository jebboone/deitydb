-- scripts/add_hittite_expansion.sql
-- Hittite foundational expansion: Telipinu, Inaras, Hannahanna
--
-- Three entities central to the Hittite mythological corpus that were missing
-- from the initial 9-entity Hittite layer:
--
--   Telipinu: the "vanishing deity" — the most completely preserved Hittite myth.
--   Telipinu vanishes in anger; all fertility and life cease; the gods and Hannahanna
--   search for him; a bee finds him asleep and stings him awake; he is reconciled
--   and returns. Multiple versions survive (CTH 324-325). This is the Hittite
--   contribution to the dying/vanishing vegetation deity tradition that connects
--   Dumuzi/Tammuz (Mesopotamian), Baal''s descent to Mot (Ugaritic), and
--   Persephone''s abduction (Greek) in the Archaic reception.
--
--   Inaras: goddess who devised the trap by which Illuyanka the serpent was
--   defeated; set a great feast, invited Illuyanka, who ate and drank until too
--   large to return to his lair; Hupasiya (mortal helper) then bound him. Integral
--   to the Illuyanka myth already in DB (ENT_HTT_ILLUYANKA).
--
--   Hannahanna: the divine grandmother ("Grandmother Grandmother" by reduplication);
--   the wise elder goddess who sends the bee when all other divine searchers fail
--   in the Telipinu myth; an important figure in Hittite theology as the archetype
--   of the wise counselor goddess.
--
-- All sourced to SRC_HOFFNER_HITTITE_MYTHS (already in DB).

BEGIN;

-- ── 1. New entities ──────────────────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_HTT_TELIPINU',
   'Telipinu',
   'Hittite',
   'Vegetation/fertility deity',
   'A',
   'Hittite deity whose disappearance causes all fertility to fail; the "vanishing deity" myth (CTH 324-325) is the most completely preserved Hittite myth with multiple versions; Telipinu vanishes in anger (putting his boots on wrong feet in his haste), all crops wither and animals stop reproducing until the bee sent by Hannahanna finds him sleeping; he is ritually reconciled and life returns; the paradigm for the Hittite contribution to the seasonal disappearance-and-return mythology that parallels Persephone/Demeter and the Mesopotamian Dumuzi/Tammuz dying-deity pattern'),

  ('ENT_HTT_INARAS',
   'Inaras',
   'Hittite',
   'Protective goddess',
   'A',
   'Hittite goddess who devised the defeat of Illuyanka the chaos serpent; in the first version of the Illuyanka myth (CTH 321 §§1-8), Inaras prepares a great feast, invites Illuyanka and his children to eat and drink; they gorge until too large to fit back into their lair; the mortal Hupasiya (Inaras''s lover) then ties them with rope while Tarhunna kills them; Inaras represents the divine wisdom and strategy that supplements the storm deity''s raw power in defeating chaos'),

  ('ENT_HTT_HANNAHANNA',
   'Hannahanna',
   'Hittite',
   'Wise elder goddess',
   'A',
   'Hittite divine grandmother ("hanna" = grandmother, reduplicated for emphasis); the wise elder deity who sends the bee (symbol of her divine knowledge) when all other gods have failed to find Telipinu; her bee succeeds where eagles and other divine searchers failed; represents an archetype of the cunning wise counselor goddess parallel to the Mesopotamian "mother of wisdom" figures; attested in the Telipinu myth (CTH 324-325) and in other Hittite ritual texts')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 2. Source links ──────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_HTT_TELIPINU',   'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Telipinu myth (CTH 324-325); three versions; Hoffner (1998) pp. 14-20; the most complete Hittite myth'),
  ('ENT_HTT_INARAS',     'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Illuyanka myth first version (CTH 321 §§1-8); Hoffner (1998) pp. 10-12; Inaras devises the defeat of Illuyanka'),
  ('ENT_HTT_HANNAHANNA', 'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Telipinu myth (CTH 324): Hannahanna sends the bee; Hoffner (1998) pp. 14-20')
ON CONFLICT DO NOTHING;

-- ── 3. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_HTT_TELIPINU',   'PER_HTT_EMPIRE', 'high',
   'Telipinu myth (CTH 324-325) attested in Old Hittite and Empire period versions at Hattusa',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_INARAS',     'PER_HTT_EMPIRE', 'high',
   'Illuyanka myth (CTH 321) attested in Old Hittite period (two versions); Inaras appears in version 1',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_HANNAHANNA', 'PER_HTT_EMPIRE', 'high',
   'Hannahanna appears in the Telipinu myth and several other Hittite ritual and mythological texts from the Empire period',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 4. Reception chains ──────────────────────────────────────────────────────

-- Telipinu → Demeter: the vanishing deity whose absence causes vegetation death
-- The Telipinu myth and the Demeter/Persephone myth share the narrative pattern:
-- (1) a deity connected to fertility/vegetation vanishes or descends;
-- (2) all vegetation and animal life fails during the absence;
-- (3) the gods search; (4) the deity is found and returned; (5) life resumes.
-- West (1997) treats the Telipinu pattern as a probable transmission source for
-- the Greek seasonal mythology.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_TELIPINU', 'received_as', 'ENT_DEMETER',
   'low',
   'The Telipinu vanishing-deity myth and the Demeter/Kore myth share the same narrative logic: (1) a deity associated with vegetation and fertility withdraws or disappears; (2) all crops, animals, and fertility fail during the absence; (3) the divine community searches and eventually recovers the missing deity; (4) fertility and life return with the deity''s restoration. West (1997) identifies the Telipinu myth as the Hittite version of this pan-Near Eastern pattern, and treats it as a probable intermediate between the Mesopotamian Dumuzi/Tammuz dying-deity narrative and the Greek Demeter/Persephone myth. The transmission route would be through Anatolian-Greek contact in the Archaic period. Confidence low because the Telipinu myth has the deity vanishing in anger (not dying or being abducted), which is structurally slightly different from Persephone''s abduction by Hades; the convergence is in the effect (vegetation fails) rather than the mechanism.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_DEMETER', 'reception_of', 'ENT_HTT_TELIPINU',
   'low',
   'Demeter as the Greek reception of the vanishing-deity pattern documented in the Hittite Telipinu myth; the narrative logic of divine withdrawal causing universal infertility is shared.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- Dumuzi/Tammuz → Telipinu: the older Mesopotamian dying/vanishing vegetation
-- deity tradition as one probable source for the Hittite myth
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_DUMUZI_TAMMUZ', 'received_as', 'ENT_HTT_TELIPINU',
   'low',
   'The Hittite Telipinu vanishing-deity myth belongs to the same pan-Near Eastern mythological family as the Mesopotamian Dumuzi/Tammuz dying-and-rising narrative. Both involve: (1) the withdrawal of a male vegetation deity; (2) the cessation of agricultural fertility; (3) eventual restoration through divine intervention. The Telipinu myth was probably influenced by Mesopotamian dying-deity traditions transmitted through Hurrian intermediaries (the Hurrian religious culture that contributed the Kumarbi cycle to Hittite religion also had access to Mesopotamian mythological traditions). Confidence low: the Telipinu myth differs in mechanism (disappearance rather than death and underworld descent) and no direct Mesopotamian textual source for the Telipinu narrative has been identified.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_HTT_EMPIRE'),
  ('ENT_HTT_TELIPINU', 'reception_of', 'ENT_MES_DUMUZI_TAMMUZ',
   'low',
   'The Hittite Telipinu vanishing-deity pattern as a possible reception of the older Mesopotamian Dumuzi/Tammuz dying-vegetation-deity tradition; structural parallel rather than documented transmission.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_HTT_EMPIRE')
ON CONFLICT DO NOTHING;

-- Inaras → participates in Illuyanka defeat (relationship to existing chain)
-- The Illuyanka→Python chain already in DB; Inaras is the agent whose
-- cunning made the defeat possible. No new reception chain needed; her
-- relationship to the Illuyanka myth is captured in her short_note.
-- Add a functional relationship: Inaras guides/aids Tarhunna against Illuyanka.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_INARAS', 'guides', 'ENT_HTT_TARHUNNA',
   'high',
   'In the first version of the Illuyanka myth (CTH 321 §§1-8), Inaras devises and executes the strategy that allows Tarhunna (the storm god) to defeat Illuyanka: she prepares the feast that lures the serpent into vulnerability and recruits the mortal Hupasiya to bind him. Tarhunna''s victory over Illuyanka is explicitly enabled by Inaras''s cunning rather than the storm god''s direct power alone.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_HTT_EMPIRE')
ON CONFLICT DO NOTHING;

-- ── 5. Verification ──────────────────────────────────────────────────────────

SELECT 'hittite_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition IN ('Hittite','Hittite/Hurrian');

SELECT * FROM v_release_metrics;

COMMIT;
