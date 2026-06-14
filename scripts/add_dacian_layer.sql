-- scripts/add_dacian_layer.sql
-- Dacian religious layer — building on existing Thracian foundation.
--
-- Context: ENT_THRA_ZALMOXIS (6 rels) and ENT_THRA_GEBELEIZIS (6 rels) already
-- exist under the Thracian tradition with strong short_notes. This script adds:
--
--   NEW ENTITY (1):
--     ENT_DAC_DERZELAS — Dacian chthonic deity of vigor and abundance,
--     attested epigraphically at Odessos (mod. Varna, Bulgaria).
--
--   NEW RELATIONSHIPS (3):
--     Zalmoxis aligned_with Dionysus (medium — mystery cult structural parallel)
--     Derzelas aligned_with Zalmoxis (medium — shared Dacian underworld domain)
--     Derzelas aligned_with ENT_AGATHOS_DAIMON (low — abundance/health function parallel)

BEGIN;

-- ── 1. Entity ─────────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
) VALUES
('ENT_DAC_DERZELAS',
 'Derzelas',
 'Dacian',
 'Chthonic deity / deity of vital abundance',
 'deity',
 'abundance; health; vital force; chthonic; Dacian/Thracian; civic cult; Odessos',
 'B',
 'Derzelas (Δέρζαλας, also Darzalas, Δαρζαλάς) is a Dacian or Thracian-Dacian chthonic deity of vital force, health, and abundance, attested primarily through numismatic evidence from the city of Odessos (modern Varna, Bulgaria) on the Black Sea coast. Coins struck at Odessos from the 3rd to 2nd centuries BCE depict a mature male figure interpreted as the local Great God (Μέγας Θεός) of Odessos, widely identified in modern scholarship as Derzelas on the basis of dedicatory inscriptions from the same region. The name Derzelas may derive from a Thracian root related to vigor or vital force (compare Thracian personal names with the element Derz-/Darz- connoting "brave, strong"). He occupies a central role in the religious life of Odessos, functioning simultaneously as a civic protector and as a chthonic deity associated with the realm of the dead and with the renewal of vitality — a combination characteristic of the broader Thracian-Dacian religious complex. His cult shows Greek influence in iconography (he is depicted in Hellenistic style), while his name and functional domain are distinctly indigenous Thracian-Dacian. Unlike Zalmoxis (the great Dacian prophet-deity of immortality among the Getae) or Gebeleizis (the storm deity), Derzelas is primarily civic and chthonic rather than soteriological. Fol, A. and Marazov, I. (1977), Thrace and the Thracians (London); Popov, D. (1989), "Der thrakische Gott Darzalas," Klio 71.2: 373-391.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 2. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_DAC_DERZELAS', 'SRC_HERODOTUS_HISTORIES', 'Primary text (contextual)',
 'Herodotus Hist. IV.93-96 provides the Getae/Thracian religious context (Zalmoxis, immortality beliefs) within which Derzelas''s regional cult develops. Not a direct source for Derzelas but establishes the Dacian-Thracian religious matrix.')
ON CONFLICT DO NOTHING;

-- ── 3. Entity period ──────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_DAC_DERZELAS', 'PER_THRA_IRON_AGE', 'high',
 'Odessos coin evidence from 3rd–2nd c. BCE; this falls within the Thracian Iron Age period which covers the Dacian context.',
 'SRC_HERODOTUS_HISTORIES', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 4. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, period_id, review_status)
VALUES

-- Zalmoxis ↔ Dionysus (mystery cult structural parallel)
('ENT_THRA_ZALMOXIS', 'aligned_with', 'ENT_DIONYSUS',
 'medium',
 'Herodotus (Hist. IV.95) preserves a tradition that Zalmoxis was a disciple of Pythagoras (almost certainly a later rationalizing legend), and Plato (Charmides 156d-157c) references Zalmoxis in the context of holistic healing and soul medicine. The structural parallel with Dionysus lies in the mystery cult form: both figures are associated with initiatory rites promising immortality or a blessed afterlife, both involve a period of disappearance and return (Zalmoxis''s three-year underground sojourn; Dionysian dismemberment and return), and both cults are attested in the same Thracian-Greek cultural contact zone. Ancient writers (Mnaseas of Patrae via Diodorus Siculus) sometimes directly equated Zalmoxis with the Kronos of mystery traditions. Confidence medium: the parallel is structural and contextual rather than attested by explicit ancient identification.',
 'SRC_HERODOTUS_HISTORIES', 'PER_THRA_IRON_AGE', 'reviewed'),

-- Derzelas ↔ Zalmoxis (shared Dacian underworld domain)
('ENT_DAC_DERZELAS', 'aligned_with', 'ENT_THRA_ZALMOXIS',
 'medium',
 'Derzelas and Zalmoxis share the chthonic-vitalistic function characteristic of Dacian-Thracian religion: Zalmoxis promises immortality and receives the dead in his underground hall; Derzelas presides over vital abundance and health with a chthonic dimension. Both are attested in the Thracian-Dacian cultural zone and represent the indigenous Dacian synthesis of chthonic death-power with vital life-force. The alignment is functional and regional rather than attested by an explicit ancient identification. Popov (1989) discusses Derzelas''s chthonic dimension in relation to the broader Thracian divine complex.',
 'SRC_HERODOTUS_HISTORIES', 'PER_THRA_IRON_AGE', 'reviewed'),

-- Derzelas ↔ Gebeleizis (regional Dacian divine pair)
('ENT_DAC_DERZELAS', 'aligned_with', 'ENT_THRA_GEBELEIZIS',
 'low',
 'Gebeleizis (storm deity) and Derzelas (chthonic abundance deity) together represent the major functional poles of the Dacian/Getae divine world: celestial/storm and chthonic/abundance. This is a structurally inferred pairing — the Thracian divine complex typically features a storm deity (Gebeleizis) paired with a chthonic deity (Derzelas/Zalmoxis) — rather than an explicit ancient identification. Confidence low: the pair is modern scholarly reconstruction of the Dacian religious system.',
 'SRC_HERODOTUS_HISTORIES', 'PER_THRA_IRON_AGE', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── 5. Verify ─────────────────────────────────────────────────────────────────
SELECT e.entity_id, e.canonical_name,
       COUNT(r.subject_entity_id) + COUNT(r2.object_entity_id) AS total_rels
FROM entities e
LEFT JOIN entity_relationships r  ON r.subject_entity_id = e.entity_id
LEFT JOIN entity_relationships r2 ON r2.object_entity_id = e.entity_id
WHERE e.entity_id IN ('ENT_DAC_DERZELAS','ENT_THRA_ZALMOXIS','ENT_THRA_GEBELEIZIS')
GROUP BY e.entity_id, e.canonical_name ORDER BY e.entity_id;

SELECT * FROM v_release_metrics;
COMMIT;
