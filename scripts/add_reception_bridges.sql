-- scripts/add_reception_bridges.sql
-- Track B reception-chain bridges: link genuinely orphaned / under-connected
-- figures into the reception lineage so they surface in the chain view.
--
-- Scope (verified against existing edges before authoring — items that were
-- already bridged, e.g. Aphrodite<-Astarte and Horus->Thelema via Harpocrates,
-- are intentionally NOT touched):
--
--   #3 Typhon between Seth and the Christian Devil (combat-myth adversary).
--   #4 The Wiccan Triple Goddess (previously 0 reception links) -> classical
--      sources (Hecate, Diana) and -> online neopagan devotion (WitchTok).
--   #5 New intermediate entity Isis Lactans between Isis and Mary Theotokos.
--   #6 The astral-magic 36 decans/faces (Wujuh) -> the Egyptian decanal system.
--
-- Rationales are deliberately citation-only (source pointer, no descriptive
-- prose), per project policy.

BEGIN;

-- ── 1. New sources ───────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
  ('SRC_FORSYTH_OLD_ENEMY',
   'Neil Forsyth, The Old Enemy: Satan and the Combat Myth (Princeton University Press, 1987)',
   NULL, 'secondary source',
   'The combat myth (chaoskampf) from Near Eastern and Greek antecedents (Tiamat, Yam, Typhon/Python) into Jewish and Christian conceptions of Satan as dragon-adversary'),
  ('SRC_HUTTON_TRIUMPH',
   'Ronald Hutton, The Triumph of the Moon: A History of Modern Pagan Witchcraft (Oxford University Press, 1999)',
   NULL, 'secondary source',
   'Origins and development of modern Pagan witchcraft (Wicca), including the modern construction of the Triple Goddess from classical and literary sources'),
  ('SRC_GRAVES_WHITE_GODDESS',
   'Robert Graves, The White Goddess: A Historical Grammar of Poetic Myth (Faber & Faber, 1948)',
   NULL, 'secondary source',
   'The Maiden-Mother-Crone Triple Moon Goddess formulation later adopted by Wicca'),
  ('SRC_TRAN_ISIS_LACTANS',
   'V. Tran Tam Tinh, Isis lactans: Corpus des monuments greco-romains d''Isis allaitant Harpocrate (Leiden: Brill, 1973)',
   NULL, 'secondary source',
   'Corpus of Greco-Roman Isis lactans (nursing) iconography and its relation to later Maria lactans imagery'),
  ('SRC_HIGGINS_DIVINE_MOTHERS',
   'Sabrina Higgins, "Divine Mothers: The Influence of Isis on the Virgin Mary in Egyptian Lactans-Iconography," Journal of the Canadian Society for Coptic Studies 3-4 (2012): 71-90',
   NULL, 'secondary source',
   'Iconographic relationship between Isis lactans and Maria lactans; reviews the scholarly debate on Isis-to-Mary influence'),
  ('SRC_PINGREE_PICATRIX',
   'David Pingree (ed.), Picatrix: The Latin Version of the Ghayat al-Hakim (London: Warburg Institute, 1986)',
   NULL, 'primary text',
   'Medieval Arabic-Latin astral magic handbook describing the 36 decans/faces (wujuh) of the zodiac and their images')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New entity (#5 intermediate) ──────────────────────────────────────────

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category,
   evidence_confidence, review_status, inclusion_basis, short_note)
VALUES
  ('ENT_ISIS_LACTANS', 'Isis Lactans', 'Greco-Roman Egypt',
   'Iconographic form', 'Syncretic Deity',
   'A', 'candidate_verified_name',
   'Iconographic intermediate between Isis and Maria lactans imagery.',
   'Nursing-mother (lactans) iconographic form of Isis suckling Harpocrates.')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ISIS_LACTANS', 'PER_EGY_ROMAN', 'high',
   'Tran Tam Tinh, Isis lactans.', 'SRC_TRAN_ISIS_LACTANS', 'reviewed')
ON CONFLICT (entity_id, period_id) DO NOTHING;

-- ── 3. Reception links ───────────────────────────────────────────────────────

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  -- #3 Seth -> Typhon -> Devil
  ('ENT_TYPHON', 'reception_of', 'ENT_EGY_SETH',
   'high', 'Greek interpretatio of Set as Typhon; Plutarch, De Iside et Osiride.',
   'SRC_PLUTARCH_ISIS_OSIRIS', 'reviewed', 'PER_GRK_HELLENISTIC'),
  ('ENT_CHR_DEVIL', 'reception_of', 'ENT_TYPHON',
   'medium', 'Combat-myth (chaoskampf) dragon-adversary underlying the Christian dragon-Satan (Rev. 12); Forsyth, The Old Enemy.',
   'SRC_FORSYTH_OLD_ENEMY', 'reviewed', 'PER_LATE_ANTIQUE'),

  -- #4 Triple Goddess <- classical sources; WitchTok <- Triple Goddess
  ('ENT_WIC_TRIPLE_GODDESS', 'reception_of', 'ENT_HECATE',
   'high', 'Classical triple-form goddess underlying the Wiccan Maiden-Mother-Crone; Hutton, The Triumph of the Moon.',
   'SRC_HUTTON_TRIUMPH', 'reviewed', 'PER_WICCA'),
  ('ENT_WIC_TRIPLE_GODDESS', 'reception_of', 'ENT_ROM_DIANA',
   'medium', 'Moon-goddess of the Graves "White Goddess" construction adopted by Wicca; Graves, The White Goddess.',
   'SRC_GRAVES_WHITE_GODDESS', 'reviewed', 'PER_WICCA'),
  ('ENT_VF_WITCHTOK', 'reception_of', 'ENT_WIC_TRIPLE_GODDESS',
   'medium', 'Wiccan Triple Goddess received in online neopagan devotion; Burton, Strange Rites.',
   'SRC_BURTON_STRANGE_RITES', 'reviewed', 'PER_DIGITAL_FOLKLORE'),

  -- #5 Isis -> Isis Lactans -> Mary Theotokos
  ('ENT_ISIS_LACTANS', 'reception_of', 'ENT_EGY_ISIS',
   'high', 'Nursing-mother (lactans) iconographic form of Isis suckling Harpocrates; Tran Tam Tinh, Isis lactans.',
   'SRC_TRAN_ISIS_LACTANS', 'reviewed', 'PER_EGY_ROMAN'),
  ('ENT_SAINT_MARY', 'reception_of', 'ENT_ISIS_LACTANS',
   'medium', 'Maria lactans iconography paralleling Isis lactans (scholarly debate on direct influence); Higgins, Divine Mothers.',
   'SRC_HIGGINS_DIVINE_MOTHERS', 'reviewed', 'PER_LATE_ANTIQUE'),

  -- #6 Astral-magic decans (Wujuh) -> Egyptian decanal system
  ('ENT_AST_DECANS', 'reception_of', 'ENT_EGY_DECANS',
   'medium', 'Astral-magic 36 faces (wujuh) derive from the Egyptian decanal system; Picatrix (Ghayat al-Hakim), ed. Pingree.',
   'SRC_PINGREE_PICATRIX', 'reviewed', 'PER_ISL_CLASSICAL')
ON CONFLICT DO NOTHING;

COMMIT;
