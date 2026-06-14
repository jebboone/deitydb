-- expand_hittite_scythian_v1.sql
-- Clears all zero-rel Hittite, Hittite/Hurrian, and Scythian entities (7 total).
--
-- HITTITE (2):
--   Arinna: Sun Goddess of Arinna — queen of heaven, paired_with Tarhunna (Storm God),
--     equated_with Hepat, patron_of Sovereignty (Hoffner, Hittite Myths).
--   Hannahanna: grandmother goddess who guides Telipinu via bee; patron_of Protection
--     (Hoffner, Hittite Myths — Telipinu myth).
--
-- HITTITE/HURRIAN (1):
--   Alalu: primordial king of heaven in the Kumarbi Cycle (Song of Kumarbi);
--     rules Sovereignty before deposition; dwells_in Underworld after defeat
--     (Hoffner, Hittite Myths — Song of Kumarbi).
--
-- SCYTHIAN (4):
--   Herodotus Histories 4.59-62 equates each Scythian deity to a Greek counterpart:
--   Artimpasa = Aphrodite Urania (4.59)
--   Oetosyrus = Apollo (4.59)
--   Sword Ares (Akinakes cult) = Ares (4.62)
--   Thagimasadas = Poseidon (4.59)
--
-- Sources: SRC_HOFFNER_HITTITE_MYTHS, SRC_HERODOTUS_HISTORIES,
--          SRC_CUNLIFFE_SCYTHIANS

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: HITTITE ENTITIES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- ARINNA (Sun Goddess of Arinna): queen of heaven and earth; storm god's consort
  ('ENT_HTT_ARINNA','paired_with','ENT_HTT_TARHUNNA',
    'high','Hoffner, Hittite Myths: the Sun Goddess of Arinna and the Storm God Tarhunna are the royal divine couple of the Hittite pantheon; she is "Queen of Heaven and Earth" and "mistress of the Hittite lands."','SRC_HOFFNER_HITTITE_MYTHS','approved'),
  ('ENT_HTT_TARHUNNA','paired_with','ENT_HTT_ARINNA',
    'high','Hoffner, Hittite Myths: see Arinna paired_with Tarhunna.','SRC_HOFFNER_HITTITE_MYTHS','approved'),
  ('ENT_HTT_ARINNA','equated_with','ENT_HTT_HEPAT',
    'high','The Sun Goddess of Arinna and the Hurrian goddess Hepat (sun goddess of the Hurrians) were identified in the syncretic Hittite-Hurrian theology of the Late Bronze Age. Hoffner, Hittite Myths, p. 41.','SRC_HOFFNER_HITTITE_MYTHS','approved'),
  ('ENT_HTT_ARINNA','patron_of','ENT_SOVEREIGNTY',
    'high','The Sun Goddess of Arinna was the highest deity of the Hittite state cult, designated "Queen of Heaven and Earth, mistress of the kings and queens of the Hatti land"; her protection was invoked for royal legitimacy.','SRC_HOFFNER_HITTITE_MYTHS','approved'),

  -- HANNAHANNA: grandmother goddess; guides Telipinu in the disappearing-god myth
  ('ENT_HTT_HANNAHANNA','guides','ENT_HTT_TELIPINU',
    'high','Hoffner, Hittite Myths — Telipinu Myth: when Telipinu disappeared and the world grew barren, Hannahanna the grandmother goddess proposed sending a bee to search for him and anoint him when found, restoring fertility.','SRC_HOFFNER_HITTITE_MYTHS','approved'),
  ('ENT_HTT_HANNAHANNA','patron_of','ENT_PROTECTION',
    'high','Hannahanna ("grandmother") is the elder wisdom goddess of the Hittite pantheon; she acts as divine counsellor and protector, intervening to restore cosmic order.','SRC_HOFFNER_HITTITE_MYTHS','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: HITTITE/HURRIAN — ALALU (Song of Kumarbi)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- Alalu: first king of heaven in the nine-year succession chain
  ('ENT_HTT_ALALU','rules','ENT_SOVEREIGNTY',
    'high','Hoffner, Hittite Myths — Song of Kumarbi: "In former times Alalu was king in heaven. Alalu sat upon the throne and the mighty Anu... bowed down at his feet." Alalu was the primordial king of heaven for nine years.','SRC_HOFFNER_HITTITE_MYTHS','approved'),
  -- After Anu defeated him, Alalu "went down to the dark earth"
  ('ENT_HTT_ALALU','dwells_in','ENT_UNDERWORLD',
    'high','Hoffner, Hittite Myths — Song of Kumarbi: after being defeated by Anu in the ninth year, Alalu "went down to the dark earth (the underworld)" where he took refuge.','SRC_HOFFNER_HITTITE_MYTHS','approved'),
  -- Alalu opposes the divine order that Teshub eventually heads
  ('ENT_HTT_ALALU','opposes','ENT_HTT_TESHUB',
    'medium','Hoffner, Hittite Myths — Song of Kumarbi: the Kumarbi Cycle stages a succession war through the chain Alalu → Anu → Kumarbi → Teshub; Alalu''s displacement is the first act in the conflict that Teshub ultimately resolves as the ruling storm god.','SRC_HOFFNER_HITTITE_MYTHS','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: SCYTHIAN DEITIES — Herodotus 4.59-62 Greek equations
-- "The Scythians worship Hestia above all other gods, next Zeus and Earth...
--  then Aphrodite Urania, then Heracles, then Ares. All Scythians sacrifice
--  to these; the Royal Scythians also sacrifice to Poseidon.
--  In Scythian: Hestia = Tabiti; Zeus = Papaeus; Earth = Api;
--  Aphrodite = Artimpasa; Apollo = Oetosyrus;
--  Ares [= sword cult, no name given]; Poseidon = Thagimasadas."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- Artimpasa = Aphrodite Urania (Herodotus 4.59)
  ('ENT_SCYTH_ARTIMPASA','equated_with','ENT_APHRODITE',
    'high','Herodotus Histories 4.59: the Scythians call Aphrodite Urania (Heavenly Aphrodite) "Artimpasa"; she is one of the primary Scythian deities.','SRC_HERODOTUS_HISTORIES','approved'),
  ('ENT_SCYTH_ARTIMPASA','patron_of','ENT_LOVE',
    'high','As the Scythian equivalent of Aphrodite, Artimpasa is patron of love and celestial/heavenly aspects of beauty and desire; Cunliffe, The Scythians, p. 85.','SRC_CUNLIFFE_SCYTHIANS','approved'),

  -- Oetosyrus = Apollo (Herodotus 4.59)
  ('ENT_SCYTH_OETOSYRUS','equated_with','ENT_APOLLO',
    'high','Herodotus Histories 4.59: the Scythians identify their god Oetosyrus (also spelled Goitosyrus) with Apollo; he is a solar and arrow deity.','SRC_HERODOTUS_HISTORIES','approved'),
  ('ENT_SCYTH_OETOSYRUS','patron_of','ENT_PROTECTION',
    'medium','As a solar-warrior deity equated with Apollo, Oetosyrus was a protector and guide for Scythian warriors; Cunliffe, The Scythians, p. 85.','SRC_CUNLIFFE_SCYTHIANS','approved'),

  -- Sword Ares = Ares (Herodotus 4.62: the Akinakes / iron sword planted on a mound)
  ('ENT_SCYTH_SWORD_ARES','equated_with','ENT_ARES',
    'high','Herodotus Histories 4.62: each Scythian district maintained a mound of brushwood topped with an ancient iron sword (the akinakes) as the cult image of Ares; prisoners of war were sacrificed to it.','SRC_HERODOTUS_HISTORIES','approved'),
  ('ENT_SCYTH_SWORD_ARES','embodies','ENT_WAR',
    'high','The Scythian Sword Ares is the direct embodiment of war itself — a naked blade worshipped as the divine instrument of battle; Herodotus 4.62.','SRC_HERODOTUS_HISTORIES','approved'),

  -- Thagimasadas = Poseidon (Herodotus 4.59: Royal Scythians only)
  ('ENT_SCYTH_THAGIMASADAS','equated_with','ENT_POSEIDON',
    'high','Herodotus Histories 4.59: only the Royal Scythians worship Thagimasadas, whom they identify with Poseidon; he is not sacrificed to by common Scythians.','SRC_HERODOTUS_HISTORIES','approved'),
  ('ENT_SCYTH_THAGIMASADAS','patron_of','ENT_SOVEREIGNTY',
    'medium','Thagimasadas is exclusively a deity of the Royal Scythians, suggesting a connection to royal power and sovereignty; his equation with Poseidon aligns with sea-lord/ruler associations.','SRC_CUNLIFFE_SCYTHIANS','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;

SELECT tradition, COUNT(*) AS zero_rel
FROM entities
WHERE tradition IN ('Hittite','Hittite/Hurrian','Scythian')
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id)
GROUP BY tradition;

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
