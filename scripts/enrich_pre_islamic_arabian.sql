-- scripts/enrich_pre_islamic_arabian.sql
-- Enriches the four principal Pre-Islamic Arabian / Nabataean deities
-- (Dushara, Al-Uzza, Manat, Al-Lat) that already exist in the DB as
-- adequately-noted entities but lack category, primary_domains, and
-- two relationships that are missing:
--
--   • ENT_ARA_ALLAT received_as ENT_APHRODITE — Herodotus 3.8 (c. 430 BCE)
--     explicitly calls the Arabian goddess "Alilat" and identifies her with
--     Aphrodite Urania; this is absent from the current graph even though
--     SRC_HERODOTUS_HISTORIES is already linked to Al-Lat.
--
--   • ENT_ARA_DUSHARA aligned_with ENT_ZEUS — Greek and Roman authors
--     identified Dushara with both Dionysus (his existing relationship) and
--     Zeus / Jupiter (as the supreme sky deity of the Arabs); the Zeus
--     equation is absent from the current graph.
--
-- No new entities, sources, or periods are required — all supporting
-- evidence is already in the DB (SRC_HEALEY_NABATAEAN_RELIGION,
-- SRC_HERODOTUS_HISTORIES, SRC_QURAN; PER_ARA_PRE_ISLAMIC).

BEGIN;

-- ── 1. Add category and primary_domains to all four entities ──────────────────
UPDATE entities SET
  entity_type     = 'chief deity of the Nabataeans / sky and mountain god',
  category        = 'High Deity',
  primary_domains = 'divine supremacy; mountain; sky; sun; royal patronage; fertility; Nabataean kingdom; aniconic baetyl cult'
WHERE entity_id = 'ENT_ARA_DUSHARA';

UPDATE entities SET
  entity_type     = 'Venus / morning star goddess',
  category        = 'Love Deity',
  primary_domains = 'Venus (morning star); love; war; protection; strength; fertility; Nabataean queenship'
WHERE entity_id = 'ENT_ARA_AL_UZZA';

UPDATE entities SET
  entity_type     = 'goddess of fate and death',
  category        = 'Underworld Deity',
  primary_domains = 'fate; destiny; death; moon; time; inevitable end; tribal oaths'
WHERE entity_id = 'ENT_ARA_MANAT';

UPDATE entities SET
  entity_type     = 'sun and fertility goddess',
  category        = 'High Deity',
  primary_domains = 'sun; fertility; motherhood; war; protection; north Arabia; Herodotus Alilat'
WHERE entity_id = 'ENT_ARA_ALLAT';

-- ── 2. Add missing relationships ──────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Al-Lat received as Aphrodite (Herodotus 3.8 — explicit primary text equation)
('ENT_ARA_ALLAT', 'received_as', 'ENT_APHRODITE',
 'high',
 'Herodotus (Histories 3.8, c. 430 BCE) is the earliest and most explicit ancient equation of an Arabian goddess with a Greek one: he names the two Arabian deities as "Orotalt" (= Dushara/Allah) and "Alilat" (= Al-Lat), and explicitly states "Alilat is the same as Aphrodite." He specifies Aphrodite Ourania (Heavenly Aphrodite), the celestial aspect of Aphrodite associated with the morning star / Venus — the precise identification that connects Al-Lat to the Venus goddess tradition spanning Inanna/Ishtar (Mesopotamian), Astarte (Canaanite/Phoenician), and Aphrodite (Greek). Herodotus''s account predates the Nabataean kingdom proper (which emerges as a distinct polity c. 4th c. BCE) and documents the pre-Nabataean north Arabian goddess tradition. The existing Athena equation (ENT_ARA_ALLAT received_as ENT_ATHENA) reflects the later Palmyrene period identification; the Aphrodite equation via Herodotus is the earlier and more widespread ancient testimony. SRC_HERODOTUS_HISTORIES 3.8.',
 'SRC_HERODOTUS_HISTORIES', 'PER_ARA_PRE_ISLAMIC', 'reviewed'),

('ENT_APHRODITE', 'reception_of', 'ENT_ARA_ALLAT',
 'high',
 'In Herodotus''s interpretatio graeca (Histories 3.8), the Greek understanding of Aphrodite Ourania (Heavenly Aphrodite) was identified with the north Arabian goddess Alilat/Al-Lat — one of the earliest documented Greek-Arabian divine equations. This reflects the ancient perception that Aphrodite Ourania and the Arabian great goddess shared the celestial Venus/morning-star domain. The relationship is consistent with the broader Semitic great goddess complex (Astarte, Inanna/Ishtar, Al-Uzza, Al-Lat) all sharing the Venus star identification. SRC_HERODOTUS_HISTORIES 3.8.',
 'SRC_HERODOTUS_HISTORIES', 'PER_ARA_PRE_ISLAMIC', 'reviewed'),

-- Dushara aligned with Zeus (alongside his existing received_as Dionysus)
('ENT_ARA_DUSHARA', 'aligned_with', 'ENT_ZEUS',
 'medium',
 'Dushara was identified by Greek and Roman authors with both Dionysus (his primary Greek equation, reflected in the existing received_as relationship) and Zeus/Jupiter as the supreme deity of the Arabs. Epiphanius of Salamis (Panarion 51.22, c. 375 CE) refers to the cult of "Dusares" as the "lord of all" in terms parallel to Zeus. Nabataean bilingual inscriptions from the Hauran and from Puteoli (Italy, where a Nabataean merchant community established a Dushara temple) sometimes render his epithet in terms that parallel Zeus''s sovereignty function. The dual Dionysus/Zeus identification reflects Dushara''s complex divine profile — he was both a vegetation/wine deity (Dionysus aspect) and a sky/supreme deity (Zeus aspect), consistent with a chief deity who combines cosmic sovereignty with chthonic fertility power. Confidence medium: the Zeus alignment is secondary to the Dionysus equation in most ancient sources, and reflects interpretive variation rather than a single explicit primary-text equation. Healey (2001) pp. 95-100.',
 'SRC_HEALEY_NABATAEAN_RELIGION', 'PER_ARA_PRE_ISLAMIC', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT entity_id, canonical_name, category, primary_domains
FROM entities
WHERE entity_id IN ('ENT_ARA_DUSHARA','ENT_ARA_AL_UZZA','ENT_ARA_MANAT','ENT_ARA_ALLAT')
ORDER BY entity_id;

SELECT s.canonical_name, r.relationship_type, o.canonical_name, r.confidence
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE r.subject_entity_id IN ('ENT_ARA_DUSHARA','ENT_ARA_AL_UZZA','ENT_ARA_MANAT','ENT_ARA_ALLAT')
   OR r.object_entity_id  IN ('ENT_ARA_DUSHARA','ENT_ARA_AL_UZZA','ENT_ARA_MANAT','ENT_ARA_ALLAT')
ORDER BY s.canonical_name, r.relationship_type;

SELECT * FROM v_release_metrics;

COMMIT;
