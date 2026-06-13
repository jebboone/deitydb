-- scripts/add_israelite_patriarchs_prophets.sql
-- Israelite foundational expansion: patriarchs and prophets
--
-- Fills the main gap in the Israelite tradition layer: while divine beings,
-- angels, chaos monsters, and the supernatural apparatus of the Hebrew Bible
-- are well-covered, the key human figures are absent.
--
-- Priority follows the "older first" rule:
--
--   Noah (Genesis 6-9): unlocks the highest-confidence cross-traditional
--   narrative transmission in the dataset — Utnapishtim→Noah. The chain was
--   written in add_mesopotamian_expansion.sql but deferred because ENT_ISR_NOAH
--   did not yet exist.
--
--   Adam (Genesis 1-5): first human figure; source for the Kabbalistic
--   Adam Kadmon (ENT_JM_ADAM_KADMON, already in DB) and the Sethian Gnostic
--   Adamas (ENT_SET_ADAMAS, already in DB) reception chains. The tselem elohim
--   formula (Genesis 1:26-27) is the theological seed for both.
--
--   Elijah (1 Kings 17-19, 2 Kings 1-2): 9th century BCE fiery prophet;
--   one of only two Hebrew Bible figures who do not die (alongside Enoch;
--   both become eschatological figures). Matthew 11:14 and 17:12 explicitly
--   identify John the Baptist (ENT_SAINT_JOHN_BAPTIST, already in DB) as the
--   returning Elijah foretold in Malachi 4:5 — the best-documented Hebrew Bible
--   prophet → New Testament reception chain.
--
--   Moses (Exodus-Deuteronomy): paradigm lawgiver and prophet; foundational
--   for Judaism, Christianity, and Islam. Islamic Musa not yet in DB, so
--   cross-traditional chain is noted and deferred.
--
-- Also: patch ENT_ISR_SOLOMON stub (no entity_type or evidence_confidence set).
--
-- New source: SRC_HEBREW_BIBLE (Masoretic Text / BHS-BHQ tradition; primary text)
-- Secondary sources already in DB: SRC_DDD_BIBLE, SRC_GEORGE_GILGAMESH,
--   SRC_SCHOLEM_KABBALAH, SRC_MEYER_GNOSTIC_BIBLE

BEGIN;

-- ── 1. New source ────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_HEBREW_BIBLE',
   'The Hebrew Bible / Tanakh (primary text; Masoretic Text tradition; reference editions: Biblia Hebraica Stuttgartensia / Biblia Hebraica Quinta; citations by book, chapter, and verse)',
   NULL,
   'primary text',
   'Primary text corpus for all entities attested in the Hebrew Bible: Torah (Genesis–Deuteronomy), Nevi''im (Joshua–Malachi), Ketuvim (Psalms, Proverbs, Job, Daniel, etc.); covers patriarchs (Adam, Noah, Abraham, Moses), prophets (Elijah, Isaiah, Ezekiel), kings (Solomon, David), and the full Israelite divine pantheon, demonology, and cosmology; the foundational primary source for all Israelite tradition entities and for chains into Jewish Mystical, Christian, and Islamic traditions')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Patch ENT_ISR_SOLOMON stub ───────────────────────────────────────────

UPDATE entities
SET
  entity_type         = 'King / Wisdom figure',
  evidence_confidence = 'A',
  short_note          = COALESCE(short_note,
    'Israelite king; son of David; builder of the First Temple in Jerusalem (1 Kings 5-8); paradigm of divine wisdom in the Hebrew Bible (1 Kings 3:5-12; wisdom greater than all others, 1 Kings 4:30-31); traditional author of Proverbs, Ecclesiastes, and Song of Songs; his reign (c. 970-930 BCE) is the peak of the United Monarchy; his foreign wives and their cults (1 Kings 11) lead to the prophetic critique of syncretism; later tradition attributes to him power over spirits and demons (Testament of Solomon, c. 1st-3rd c. CE; Islamic Sulayman who commands jinn per Quran 27:17-44) — making his name the seed of the entire Western Solomonic magic tradition')
WHERE entity_id = 'ENT_ISR_SOLOMON';

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES ('ENT_ISR_SOLOMON', 'SRC_HEBREW_BIBLE', 'primary_attestation',
  '1 Kings 3-11 (Solomonic narrative: wisdom, temple building, foreign wives, apostasy); Proverbs 1:1; 10:1 (attributed authorship); Ecclesiastes 1:1; Song of Songs 1:1 (traditional attributions)')
ON CONFLICT DO NOTHING;

-- ── 3. New entities ──────────────────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_ISR_NOAH',
   'Noah',
   'Israelite',
   'Patriarch / Flood hero',
   'A',
   'Israelite flood patriarch; Genesis 6-9: receives divine command to build an ark, survives the universal flood, and receives the covenant marked by the rainbow (Genesis 9:12-17); son of Lamech (Genesis 5:28-29), tenth generation from Adam in the priestly genealogy; his three sons Shem, Ham, and Japheth are the ancestors of all post-flood humanity in the Israelite Table of Nations (Genesis 10); cited in Ezekiel 14:14, 20 as one of three paradigm righteous figures alongside Daniel and Job; in 1 Enoch 106-107 he is described as radiant at birth, suggesting early traditions of his semi-divine or chosen status; the Israelite reception of the Mesopotamian flood hero tradition (Utnapishtim/Atrahasis/Ziusudra), most likely mediated through contact with Babylonian literary traditions during the exile (586-538 BCE)'),

  ('ENT_ISR_ADAM',
   'Adam',
   'Israelite',
   'First human / Patriarch',
   'A',
   'First human being in the Israelite tradition; Genesis presents two creation accounts: P source (Genesis 1:26-27) creates adam ("humanity") collectively "in the image of God" (tselem elohim); J source (Genesis 2:7) has God forming the man from the dust of the ground (''adamah — the name puns on "ground-one" or "earthling"); placed in the garden of Eden; the transgression at the tree of knowledge results in mortality — the Israelite version of the widespread ancient Near Eastern theme of humans being denied immortality (cf. Mesopotamian Adapa, Gilgamesh''s failed quest); in the genealogy of Genesis 5 he lives 930 years; father of Cain, Abel, and Seth; the tselem elohim formula becomes the theological source for the Kabbalistic Adam Kadmon and the Sethian Gnostic Adamas; Pauline Christology develops the "second Adam" typology (Romans 5:12-19; 1 Corinthians 15:45-49)'),

  ('ENT_ISR_ELIJAH',
   'Elijah',
   'Israelite',
   'Prophet / Fiery prophet',
   'A',
   '9th century BCE Israelite prophet; active during the reigns of Ahab (c. 869-850 BCE) and Ahaziah (c. 850-849 BCE) of the northern kingdom; 1 Kings 17-19, 21; 2 Kings 1-2; his name means "My God is Yahweh" (''Eli + Yahu); major episodes: drought and ravens (1 Kings 17), the contest with the Baal prophets on Mount Carmel (1 Kings 18), the theophany in the still small voice on Horeb (1 Kings 19), and the fiery chariot ascent to heaven (2 Kings 2:11); one of only two Hebrew Bible figures who do not die (alongside Enoch, Genesis 5:24), which becomes the basis for his eschatological return; Malachi 4:5 (Hebrew 3:23) explicitly prophesies "I am sending you the prophet Elijah before the coming of the great and dreadful day of the LORD"; this prophecy drives the New Testament identification of John the Baptist as Elijah returned (Matthew 11:14, 17:10-12; Luke 1:17) and his appearance at the Transfiguration (Matthew 17:3); Islamic reception as the prophet Ilyas (Quran 37:123-132)'),

  ('ENT_ISR_MOSES',
   'Moses',
   'Israelite',
   'Prophet / Lawgiver',
   'A',
   'Paradigm Israelite prophet and lawgiver; Exodus 2 – Deuteronomy 34; leads the Exodus from Egypt; receives the Torah at Sinai (Exodus 19-20; 24:12-18; 34); mediates the covenant between Yahweh and Israel; the only figure in the Hebrew Bible described as knowing God "face to face" (Deuteronomy 34:10; cf. Exodus 33:11); his death on Mount Nebo before entering Canaan (Deuteronomy 34:1-8) and the detail that no one knows his burial place are early markers of his exceptional status; Numbers 12:6-8 establishes his prophetic superiority over all other prophets ("mouth to mouth I speak with him"); central to Judaism as Moshe Rabbenu (Moses our Teacher) and the paradigm lawgiver; appears with Elijah at the Transfiguration (Matthew 17:3); most frequently named prophet in the Quran (136 mentions as Musa), where he is the paradigm of prophetic confrontation with tyrant power (the Pharaoh/Fir''awn narrative); also central to Mandaean religion')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Source links ──────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  -- Noah
  ('ENT_ISR_NOAH', 'SRC_HEBREW_BIBLE',     'primary_attestation',
   'Genesis 5:28-29 (birth and name etymology); Genesis 6:9-9:29 (flood narrative, ark, covenant); Ezekiel 14:14, 20 (righteous exemplar); Isaiah 54:9 (Noahic covenant referenced)'),
  ('ENT_ISR_NOAH', 'SRC_GEORGE_GILGAMESH', 'secondary_reference',
   'George (2003) Tablet XI: the Utnapishtim flood narrative; structural and verbal parallels with Genesis 6-9 documented throughout; the flood story Noah receives is traceable to these Babylonian antecedents'),

  -- Adam
  ('ENT_ISR_ADAM', 'SRC_HEBREW_BIBLE', 'primary_attestation',
   'Genesis 1:26-27 (tselem elohim; P source); Genesis 2:7-3:24 (formation from ''adamah, garden of Eden, the fall; J source); Genesis 5:1-5 (genealogy, 930 years)'),
  ('ENT_ISR_ADAM', 'SRC_DDD_BIBLE',    'secondary_reference',
   'DDD entry "Adam": etymology, the two creation accounts, the image-of-God formula and its theological reception history'),

  -- Elijah
  ('ENT_ISR_ELIJAH', 'SRC_HEBREW_BIBLE', 'primary_attestation',
   '1 Kings 17-19 (drought, ravens, Zarephath widow, Mt. Carmel, Horeb theophany); 1 Kings 21 (Naboth''s vineyard); 2 Kings 1-2 (ascent in the fiery chariot without dying); Malachi 4:5 (eschatological return prophecy)'),

  -- Moses
  ('ENT_ISR_MOSES', 'SRC_HEBREW_BIBLE', 'primary_attestation',
   'Exodus 2:1-15 (birth and early life); Exodus 3-4 (burning bush, commission); Exodus 7-14 (plagues and exodus); Exodus 19-20, 24, 34 (Sinai covenant and Torah); Numbers 12:6-8 (prophetic uniqueness); Deuteronomy 34 (death on Nebo; no burial place known)'),
  ('ENT_ISR_MOSES', 'SRC_DDD_BIBLE',   'secondary_reference',
   'DDD entries on Moses: his face-to-face access to Yahweh, the divine council tradition, and his typological function in Second Temple Judaism')
ON CONFLICT DO NOTHING;

-- ── 5. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ISR_NOAH', 'PER_ISR_IRON_AGE', 'medium',
   'The J source (c. 900-850 BCE) flood narrative reaches written form in the Iron Age; the earlier oral tradition is pre-Iron Age but not recoverable',
   'SRC_HEBREW_BIBLE', 'reviewed'),
  ('ENT_ISR_NOAH', 'PER_ISR_EXILIC',   'high',
   'The P source Genesis 6-9 is most likely exilic or early post-exilic (c. 550-450 BCE); direct Babylonian exile contact with Atrahasis and Gilgamesh flood traditions is the most widely accepted transmission mechanism',
   'SRC_HEBREW_BIBLE', 'reviewed'),

  ('ENT_ISR_ADAM', 'PER_ISR_IRON_AGE', 'high',
   'The J source creation narrative (Genesis 2-3) dates to c. 900-850 BCE; the P source (Genesis 1) to c. 550-450 BCE; Adam is foundational to both Iron Age Yahwistic and Exilic priestly traditions',
   'SRC_HEBREW_BIBLE', 'reviewed'),

  ('ENT_ISR_ELIJAH', 'PER_ISR_IRON_AGE', 'high',
   'Elijah is active during Ahab (c. 869-850 BCE) and Ahaziah (c. 850-849 BCE) in the northern kingdom; 1-2 Kings are among the oldest narrative prose traditions in the Hebrew Bible',
   'SRC_HEBREW_BIBLE', 'reviewed'),

  ('ENT_ISR_MOSES', 'PER_ISR_IRON_AGE', 'high',
   'The written Torah traditions (J/E sources c. 900-750 BCE; D source c. 620 BCE; P source c. 550-450 BCE) are Iron Age and Exilic compositions; Moses as a figure is set in the Late Bronze Age / Iron Age transition but exists textually in Iron Age sources',
   'SRC_HEBREW_BIBLE', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ──────────────────────────────────────────────────────

-- ── 6a. Utnapishtim → Noah ───────────────────────────────────────────────────
-- The deferred chain from add_mesopotamian_expansion.sql; ENT_ISR_NOAH now exists.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_UTNAPISHTIM', 'received_as', 'ENT_ISR_NOAH',
   'high',
   'The flood narrative in Genesis 6-9 is the most directly documented Mesopotamian→Israelite literary transmission in the dataset. The parallels between the Atrahasis Epic (c. 1700 BCE) and Gilgamesh Tablet XI on one side, and Genesis on the other, are structural and verbal: both have (1) a divine council decree to destroy humanity; (2) one righteous man warned by the sympathetic deity (Ea/Enki warns Utnapishtim; God warns Noah); (3) construction of a boat and loading of animals and family; (4) the flood; (5) the boat grounding on a mountain; (6) a sequence of birds released to test for dry land (the dove/raven sequence in Genesis 8:6-12 parallels Gilgamesh Tablet XI closely); (7) a sacrificial offering after the flood; (8) a divine oath not to repeat the destruction. Andrew George (OUP 2003) documents the parallels exhaustively in his critical apparatus. The mechanism of transmission is the Babylonian exile (586-538 BCE), when Israelite scribes had direct access to the Atrahasis and Gilgamesh traditions in Babylon.',
   'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_ISR_EXILIC'),
  ('ENT_ISR_NOAH', 'reception_of', 'ENT_MES_UTNAPISHTIM',
   'high',
   'Noah as the Israelite reception of the Mesopotamian flood hero tradition (Utnapishtim in Gilgamesh Tablet XI; Atrahasis in the Atrahasis Epic; Ziusudra in the Sumerian flood story); the Genesis narrative''s detailed structural and verbal parallels demonstrate direct literary transmission through Babylonian exile contact.',
   'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_ISR_EXILIC')
ON CONFLICT DO NOTHING;

-- ── 6b. Elijah → John the Baptist ───────────────────────────────────────────
-- Matthew 11:14 is unambiguous; Luke 1:17 confirms; both cite Malachi 4:5.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ISR_ELIJAH', 'received_as', 'ENT_SAINT_JOHN_BAPTIST',
   'high',
   'The identification of John the Baptist with the returning Elijah foretold in Malachi 4:5 is explicit and foundational in the New Testament. Matthew 11:14: "And if you are willing to accept it, he [John] is the Elijah who was to come." Matthew 17:10-12: the disciples ask about the scribal teaching that Elijah must come first; Jesus responds that "Elijah has already come, and they did not recognize him, but have done to him everything they wished." Luke 1:17 describes John as coming "in the spirit and power of Elijah, to turn the hearts of the fathers to the children." The identification is grounded in: (1) Malachi''s explicit eschatological prophecy; (2) John''s desert asceticism and camel-hair garment matching Elijah''s description in 2 Kings 1:8; (3) his function as the forerunner who "prepares the way." At the Transfiguration (Matthew 17:3; Mark 9:4; Luke 9:30), Elijah appears alongside Moses as a representative of the prophetic tradition, with John-as-Elijah already having fulfilled the preparatory role. This is the best-documented Hebrew Bible prophet → New Testament reception chain in the dataset.',
   'SRC_HEBREW_BIBLE', 'reviewed', 'PER_ISR_SECOND_TEMPLE'),
  ('ENT_SAINT_JOHN_BAPTIST', 'reception_of', 'ENT_ISR_ELIJAH',
   'high',
   'John the Baptist as the New Testament reception of the returning Elijah figure prophesied in Malachi 4:5; explicitly identified as such in Matthew 11:14, 17:10-12 and Luke 1:17.',
   'SRC_HEBREW_BIBLE', 'reviewed', 'PER_ISR_SECOND_TEMPLE')
ON CONFLICT DO NOTHING;

-- ── 6c. Adam → Adam Kadmon ───────────────────────────────────────────────────
-- The tselem elohim formula (Genesis 1:26-27) is the direct theological seed
-- for the Kabbalistic primordial divine human.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ISR_ADAM', 'received_as', 'ENT_JM_ADAM_KADMON',
   'medium',
   'The Kabbalistic Adam Kadmon ("primordial Adam") is a cosmological elaboration of the biblical Adam''s creation "in the image of God" (tselem elohim; Genesis 1:26-27). In Lurianic Kabbalah (Isaac Luria, 16th century Safed), Adam Kadmon is the first configuration of divine light that emerges after the tzimtzum (divine contraction) and the shevirat ha-kelim (breaking of the vessels) — a vast primordial being whose bodily structure maps onto the ten sefirot. The concept takes the tselem elohim formula with cosmological literalism: if the earthly Adam was made in God''s image, then the divine "image" itself must be an Adam-form. The biblical Adam is thus the earthly reflection of the cosmic primordial human. Scholem (1974) traces the Adam Kadmon concept through Neoplatonic, Gnostic, and Kabbalistic strata.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_ISR_SECOND_TEMPLE'),
  ('ENT_JM_ADAM_KADMON', 'reception_of', 'ENT_ISR_ADAM',
   'medium',
   'Adam Kadmon as the Kabbalistic cosmological projection of the biblical Adam''s tselem elohim status (Genesis 1:26-27); the primordial divine human of Lurianic Kabbalah as an elaboration of the Israelite creation theology.',
   'SRC_SCHOLEM_KABBALAH', 'reviewed', 'PER_ISR_SECOND_TEMPLE')
ON CONFLICT DO NOTHING;

-- ── 6d. Adam → Sethian Adamas ────────────────────────────────────────────────
-- The Apocryphon of John (Nag Hammadi II,1) retells Genesis 1-6 through a
-- Sethian Gnostic lens; Adamas is the heavenly prototype whose earthly copy
-- the Demiurge creates.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ISR_ADAM', 'received_as', 'ENT_SET_ADAMAS',
   'medium',
   'The Sethian Gnostic Adamas / Geradamas is the Gnostic critical reception of the biblical Adam. In Sethian cosmology (as in the Apocryphon of John, Nag Hammadi II,1 and parallel texts), a perfect luminous "Adam" (Adamas) exists in the Pleroma; the earthly Adam of Genesis 2-3 is a degraded copy manufactured by the Demiurge and the archons, who use the divine image as their template ("let us make man in our image" in Genesis 1:26 is reinterpreted as the archons''s imitative act). The name Adamas preserves the Hebrew ''adam directly. This is a subversive or critical reception rather than a simple transmission: the Gnostic texts systematically invert the value judgments of Genesis (the creator is malevolent; the serpent is a liberator; the transgression was salvific rather than a fall), while the narrative structure remains dependent on Genesis 1-6.',
   'SRC_MEYER_GNOSTIC_BIBLE', 'reviewed', 'PER_ISR_SECOND_TEMPLE'),
  ('ENT_SET_ADAMAS', 'reception_of', 'ENT_ISR_ADAM',
   'medium',
   'Sethian Gnostic Adamas as the critical Gnostic reception of the biblical Adam; the heavenly Adam prototype whose earthly copy the Demiurge creates in the Apocryphon of John''s retelling of Genesis 1-6.',
   'SRC_MEYER_GNOSTIC_BIBLE', 'reviewed', 'PER_ISR_SECOND_TEMPLE')
ON CONFLICT DO NOTHING;

-- ── 7. Deferred chains (noted here for tracking) ─────────────────────────────
-- ENT_ISR_MOSES → received_as → ENT_ISL_MUSA: Moses as Musa in the Quran (136
--   mentions; paradigm prophet-lawgiver); deferred — ENT_ISL_MUSA not yet in DB.
-- ENT_ISR_ELIJAH → received_as → ENT_ISL_ILYAS: Elijah as Ilyas in Quran 37:123-132;
--   deferred — ENT_ISL_ILYAS not yet in DB.
-- ENT_ISR_ADAM → received_as → (Pauline "second Adam" typology, 1 Corinthians 15:45):
--   deferred — no ENT_CHR_JESUS entity yet; Christological reception layer is future work.

-- ── 8. Verification ──────────────────────────────────────────────────────────

SELECT 'israelite_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'Israelite' OR entity_id LIKE 'ENT_ISR_%';

SELECT 'utnapishtim_noah_chain' AS metric,
  CASE WHEN EXISTS (
    SELECT 1 FROM entity_relationships
    WHERE subject_entity_id = 'ENT_MES_UTNAPISHTIM'
      AND object_entity_id   = 'ENT_ISR_NOAH'
  ) THEN 'linked' ELSE 'missing' END AS status;

SELECT 'elijah_john_baptist_chain' AS metric,
  CASE WHEN EXISTS (
    SELECT 1 FROM entity_relationships
    WHERE subject_entity_id = 'ENT_ISR_ELIJAH'
      AND object_entity_id   = 'ENT_SAINT_JOHN_BAPTIST'
  ) THEN 'linked' ELSE 'missing' END AS status;

SELECT * FROM v_release_metrics;

COMMIT;
