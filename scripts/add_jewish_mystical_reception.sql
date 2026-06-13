-- scripts/add_jewish_mystical_reception.sql
-- Systematic reception chains: Israelite/Gnostic/Mesopotamian → Jewish Mystical
--
-- Three transmission clusters:
--   (a) Enoch → Metatron: the defining transformation of early Jewish mysticism
--   (b) Sophia/Asherah → Shekhinah and Hokhmah: the feminine divine transmission
--       across three traditions (Canaanite → Israelite → Gnostic → Kabbalistic)
--   (c) Azazel/Satan → Samael: the adversarial divine being's Gnostic-Jewish reception
--       Lamashtu/Lilit → Lilith: the night-demon tradition
--
-- New entity: ENT_JM_LILITH (first as lilit in Isaiah 34:14; fully developed in
-- Alphabet of Ben Sira and Zohar as consort of Samael and queen of demons)
-- New source: SRC_ALPHABET_BEN_SIRA (primary source for Lilith as Adam's first wife)
--
-- Existing sources used: SRC_3_ENOCH, SRC_ZOHAR, SRC_SCHOLEM_KABBALAH,
-- SRC_DDD_BIBLE, SRC_BLACK_GREEN_MESO
-- Requires: upgrade_v1_1_temporal.sql; add_canaanite_israelite_reception.sql
-- (ENT_CAN_ASHERAH → ENT_ISR_SOPHIA chain must precede this one in the chain)

BEGIN;

-- ── 1. New source ───────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_ALPHABET_BEN_SIRA',
   'Alphabet of Ben Sira (Aleph-Bet de-Ben Sira, c. 9th–11th century CE)',
   NULL,
   'primary/reception text',
   'Medieval Jewish midrashic anthology; contains the definitive narrative of Lilith as Adam''s first wife who refused subjugation and fled Eden (23rd letter entry, Aleph section); primary source for the Lilith-as-first-wife tradition that became foundational to Kabbalistic demonology and later Western occultism')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New entity: ENT_JM_LILITH ───────────────────────────────────────────

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, evidence_confidence,
   primary_period, inclusion_basis, short_note)
VALUES
  ('ENT_JM_LILITH',
   'Lilith',
   'Jewish Mystical',
   'Demoness',
   'A',
   'PER_JM_MEDIEVAL',
   'Isaiah 34:14 (lilit, hapax legomenon); Babylonian Talmud (Eruvin 100b, Niddah 24b); Alphabet of Ben Sira; Zohar',
   'Female demon; first attested as "lilit" in Isaiah 34:14 (night creature of the desolation). The Babylonian Talmud (Eruvin 100b) describes a nocturnal spirit with wings who harms men sleeping alone. The Alphabet of Ben Sira (9th–11th c. CE) develops the narrative of Lilith as Adam''s first wife who refused to lie beneath him, spoke the ineffable name, and flew to the Red Sea to consort with demons. In Kabbalistic literature (Zohar, Zohar Chadash) Lilith becomes the consort of Samael, queen of the demonic realm, and the dark counterpart of the Shekhinah — embodying the "left side" of the divine feminine.')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_JM_LILITH', 'SRC_DDD_BIBLE', 'primary_attestation',
   'Isaiah 34:14 — "lilit" as night creature in the desolation of Edom; DDD_BIBLE s.v. "Lilith" surveys the biblical and post-biblical evidence'),
  ('ENT_JM_LILITH', 'SRC_ALPHABET_BEN_SIRA', 'primary_attestation',
   'The Lilith-as-Adam''s-first-wife narrative (23rd entry); primary source for the tradition that became standard in Kabbalistic demonology'),
  ('ENT_JM_LILITH', 'SRC_ZOHAR', 'secondary_reference',
   'Lilith as consort of Samael and queen of demons; the dark feminine counterpart of the Shekhinah; extensively discussed in Zohar and Zohar Chadash')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, source_id, review_status)
VALUES
  ('ENT_JM_LILITH', 'PER_ISR_SECOND_TEMPLE', 'medium', 'SRC_DDD_BIBLE', 'reviewed'),
  ('ENT_JM_LILITH', 'PER_JM_MEDIEVAL', 'high', 'SRC_ZOHAR', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 3. Transmission chains ─────────────────────────────────────────────────

-- 3a. Enoch → Metatron: the defining transformation of Hekhalot mysticism
-- 3 Enoch (Sefer Hekhalot) chapters 3–15 narrate the transformation of
-- Enoch the patriarch into the angel Metatron, "Prince of the Divine Presence,"
-- "Youth" (Na'ar), and "Lesser YHWH" — the highest of all angels, enthroned
-- in heaven. ENT_JM_METATRON already has identified_with → ENT_ENOCH (symmetric);
-- adding received_as for diachronic precision (the Hebrew patriarch was received
-- into Jewish mysticism as a transformed angelic being of a different order).

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ENOCH', 'received_as', 'ENT_JM_METATRON',
   'high',
   '3 Enoch (Sefer Hekhalot) chapters 3–15 narrate the transformation of Enoch the antediluvian patriarch into the angel Metatron, who is enthroned in heaven, given a robe of glory and a crown, and named "the Youth" (Na''ar), "Prince of the Divine Presence," and "Lesser YHWH." Rabbi Ishmael asks: "Who are you?" and Metatron replies: "I am Enoch son of Jared." The transformation is complete — the human patriarch has been received into Jewish mysticism as the highest of all angelic beings. This is the central transmission of the Second Temple Enoch tradition into Hekhalot and Kabbalistic mysticism.',
   'SRC_3_ENOCH', 'reviewed', 'PER_LATE_ANTIQUE'),
  ('ENT_JM_METATRON', 'reception_of', 'ENT_ENOCH',
   'high',
   'Metatron as the Jewish mystical reception of the Enoch patriarch; 3 Enoch explicitly identifies Metatron as the transformed Enoch; the human visionary becomes the supreme angelic mediator.',
   'SRC_3_ENOCH', 'reviewed', 'PER_LATE_ANTIQUE')
ON CONFLICT DO NOTHING;

-- 3b. Sophia traditions → Kabbalistic Shekhinah and Hokhmah
-- Three distinct source traditions all feed the Kabbalistic divine feminine:
-- (i) Israelite Sophia/Wisdom; (ii) Gnostic Sophia as fallen/exiled aeon;
-- (iii) Asherah as suppressed goddess-beside-God (low confidence).
-- The Zohar makes the Shekhinah the tenth sefirah and Hokhmah the second.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES

  -- Sophia/Wisdom → Shekhinah: divine feminine dwelling with humanity
  ('ENT_ISR_SOPHIA', 'received_as', 'ENT_JM_SHEKHINAH',
   'medium',
   'The Kabbalistic Shekhinah (divine indwelling/feminine presence, tenth sefirah in the Zohar) is the reception and elaboration of the Sophia/Wisdom tradition: Proverbs 8:30–31 presents Wisdom as beside God "like a master workman" and "delighting before him"; Sirach 24 has Wisdom dwell in Israel. The Zohar develops this into the Shekhinah as God''s feminine presence that dwells with Israel in exile, weeps for Jerusalem, and is reunited with the masculine divine at the end of time. Scholem (Kabbalah, 1974) explicitly traces this from Sophia through Philo into Kabbalistic theology.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL'),
  ('ENT_JM_SHEKHINAH', 'reception_of', 'ENT_ISR_SOPHIA',
   'medium',
   'Shekhinah as Kabbalistic reception and development of the Sophia/Wisdom tradition; feminine divine presence dwelling with humanity received from the personified Wisdom of Proverbs and Sirach.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL'),

  -- Sophia/Wisdom → Hokhmah: the sefirah of Wisdom
  ('ENT_ISR_SOPHIA', 'received_as', 'ENT_JM_HOKHMAH',
   'medium',
   'The Kabbalistic sefirah Hokhmah (Wisdom, second sefirah in the Tree of Life) is the direct reception of the Hebrew Sophia/Wisdom hypostasis into the Kabbalistic emanation system. Both are feminine personifications of divine wisdom that stand at the highest level of the accessible divine realm; both are described as the first emanation through which creation proceeds (Proverbs 8:22: "The LORD created me at the beginning of his work"). Scholem documents the continuity; the Zohar''s treatment of Hokhmah explicitly echoes the Wisdom of Proverbs.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL'),
  ('ENT_JM_HOKHMAH', 'reception_of', 'ENT_ISR_SOPHIA',
   'medium',
   'Hokhmah (Kabbalistic sefirah of Wisdom) as the reception of the Sophia/Wisdom hypostasis; the Hebrew personified Wisdom received into the Kabbalistic emanation system as the second sefirah.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL'),

  -- Gnostic Sophia → Shekhinah: the exiled/fallen feminine divine
  -- The Gnostic Sophia falls or descends from the Pleroma; the Kabbalistic
  -- Shekhinah goes into exile with Israel and yearns for reunion.
  -- Scholem noted this structural parallel; scholars including Idel debate
  -- whether it represents direct influence or parallel development.
  ('ENT_GNO_SOPHIA', 'received_as', 'ENT_JM_SHEKHINAH',
   'medium',
   'The Gnostic Sophia (exiled aeon who falls from the Pleroma and must be redeemed) is structurally parallel to — and may have directly influenced — the Kabbalistic Shekhinah (divine presence that goes into exile with Israel and yearns for reunion with the masculine divine at the end of time). Both are feminine divine beings in a state of exile/fall who must be restored. Scholem (Origins of the Kabbalah) discusses the Gnostic Sophia''s contribution to Kabbalistic conceptions of the Shekhinah; Idel notes the structural parallel while debating the direction of influence. Medium confidence: the parallel is documented; direct influence vs. parallel development remains debated.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL'),
  ('ENT_JM_SHEKHINAH', 'reception_of', 'ENT_GNO_SOPHIA',
   'medium',
   'Shekhinah as possible reception of the Gnostic Sophia''s exiled-feminine-divine structure; exile/fall and longing for restoration are shared narrative elements.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL'),

  -- Asherah → Shekhinah: the suppressed goddess-beside-God (low, contested)
  ('ENT_CAN_ASHERAH', 'received_as', 'ENT_JM_SHEKHINAH',
   'low',
   'The most speculative chain in the feminine divine transmission: Raphael Patai (The Hebrew Goddess, 1967) argues that the suppressed Asherah (goddess-beside-El) resurfaces in the Kabbalistic Shekhinah, maintaining the goddess-beside-God structural position across two millennia of monotheistic sublimation. Scholem is more cautious. The chain Asherah → Sophia → Shekhinah (established via the prior Canaanite→Israelite reception script) is the full proposed transmission. Low confidence: the hypothesis is influential but unverifiable from primary texts alone.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL'),
  ('ENT_JM_SHEKHINAH', 'reception_of', 'ENT_CAN_ASHERAH',
   'low',
   'Shekhinah as the endpoint of the suppressed goddess-beside-God transmission: Asherah → Sophia → Shekhinah. Patai''s hypothesis; contested; low confidence.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_JM_MEDIEVAL')

ON CONFLICT DO NOTHING;

-- 3c. Adversarial divine beings → Samael
-- ENT_GNO_SAMAEL (tradition: Sethian/Ophite/Jewish) is the appropriate target:
-- Samael in Jewish tradition is the adversarial angel of death and the "other side"
-- (sitra achra) in Kabbalah. Two source traditions feed him:
-- (i) Azazel, the expelled wilderness demon
-- (ii) Satan, the accuser/adversary

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES

  ('ENT_ISR_AZAZEL', 'received_as', 'ENT_GNO_SAMAEL',
   'medium',
   'Samael in Jewish tradition draws substantially from the Azazel archetype: an angelic being who was expelled or degraded from the divine realm and associated with the wilderness/demonic sphere. The Zohar identifies Samael with the serpent of Eden; pseudepigraphical literature (2 Enoch, the Apocalypse of Abraham) conflates Azazel and Samael as names for the same adversarial angel. DDD_BIBLE s.v. "Samael" documents the convergence. The expelled-angel dimension of Samael comes primarily from the Azazel tradition.',
   'SRC_DDD_BIBLE', 'reviewed', 'PER_LATE_ANTIQUE'),
  ('ENT_GNO_SAMAEL', 'reception_of', 'ENT_ISR_AZAZEL',
   'medium',
   'Samael''s expelled-angel dimension draws from the Azazel tradition; Jewish pseudepigrapha and Zohar conflate Azazel and Samael as the same adversarial angelic being.',
   'SRC_DDD_BIBLE', 'reviewed', 'PER_LATE_ANTIQUE'),

  ('ENT_ISR_SATAN', 'received_as', 'ENT_GNO_SAMAEL',
   'medium',
   'Samael in Kabbalistic theology (Zohar) is the chief of the "other side" (sitra achra), the adversarial force opposing the divine — the direct reception of the Satan tradition. The Zohar explicitly identifies Samael as the great serpent/Satan figure: "Samael is the great dragon of the sea" (Zohar III.282a). The name Samael (Hebrew: "venom of God" or "blind God" in Gnostic contexts) appears in Jewish literature from the 2nd century BCE onward as an adversarial angel drawing on the Satan archetype. In the Apocalypse of Moses and the Life of Adam and Eve, Samael is identified as the devil who tempted Eve.',
   'SRC_ZOHAR', 'reviewed', 'PER_LATE_ANTIQUE'),
  ('ENT_GNO_SAMAEL', 'reception_of', 'ENT_ISR_SATAN',
   'medium',
   'Samael as reception of the Satan/accuser tradition in Jewish-Gnostic theology; Zohar identifies Samael as the serpent/adversary and chief of the sitra achra.',
   'SRC_ZOHAR', 'reviewed', 'PER_LATE_ANTIQUE')

ON CONFLICT DO NOTHING;

-- 3d. Lamashtu → Lilith: Mesopotamian night-demon tradition
-- The name Lilith derives from Hebrew lilit (lyl, "night"), not directly from
-- Akkadian Lamashtu, but the functional parallel is strong: both are female
-- demons who attack newborns, harm pregnant women, and haunt desolate places.
-- Akkadian "Lilitu" (fem. of Lilu, nocturnal spirit class) is the more direct
-- name cognate. ENT_MES_LAMASHTU is the closest existing Mesopotamian entity
-- for this functional transmission. Low confidence: the name connection is
-- to the Lilitu class, not Lamashtu specifically; functional parallel is the
-- primary evidence.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_LAMASHTU', 'received_as', 'ENT_JM_LILITH',
   'low',
   'Lilith''s functional profile as a female demon who harms newborns, attacks pregnant women, and haunts desolate wilderness (Isaiah 34:14) parallels the Mesopotamian Lamashtu. The more precise name cognate is to the Akkadian Lilitu (female member of the Lilu nocturnal spirit class), but ENT_MES_LAMASHTU represents the closest entity in the DB for the child-harming female demon tradition that feeds the Lilith figure. The transmission path: Mesopotamian nocturnal female demon tradition → Israelite lilit (Isaiah 34:14) → fully developed Kabbalistic Lilith. Black and Green (1992) document Lamashtu; DDD_BIBLE s.v. "Lilith" reviews the Mesopotamian connections. Low confidence given the name disambiguation (Lamashtu ≠ Lilitu) and the contested nature of the Mesopotamian origin thesis.',
   'SRC_BLACK_GREEN_MESO', 'reviewed', 'PER_ISR_SECOND_TEMPLE'),
  ('ENT_JM_LILITH', 'reception_of', 'ENT_MES_LAMASHTU',
   'low',
   'Lilith as possible reception of the Mesopotamian nocturnal female demon tradition; functional parallel (child-harming demoness, wilderness haunter) stronger than name cognacy. Low confidence.',
   'SRC_BLACK_GREEN_MESO', 'reviewed', 'PER_ISR_SECOND_TEMPLE')
ON CONFLICT DO NOTHING;

-- ── 4. Verification ────────────────────────────────────────────────────────

SELECT 'jm_reception_chains' AS metric,
       COUNT(*) AS count
FROM entity_relationships
WHERE relationship_type IN ('received_as','reception_of')
AND (subject_entity_id LIKE 'ENT_JM_%' OR object_entity_id LIKE 'ENT_JM_%'
  OR subject_entity_id = 'ENT_GNO_SAMAEL' OR object_entity_id = 'ENT_GNO_SAMAEL');

SELECT * FROM v_release_metrics;

COMMIT;
