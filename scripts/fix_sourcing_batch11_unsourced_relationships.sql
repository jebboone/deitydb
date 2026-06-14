-- scripts/fix_sourcing_batch11_unsourced_relationships.sql
-- Backfill source_id for the 99 relationships that lacked one at v1.20.0
-- (audit_quality_snapshot.sql block 5). Brings the DB to 0 unsourced relationships,
-- satisfying CLAUDE.md rule 2 (every relationship traces to a source record).
--
-- Sourcing principle:
--   * reception_of / embodies / rules / etc. → the SUBJECT's attesting source
--     (the tradition making the claim).
--   * received_as → the OBJECT's source (the receiving/later tradition that
--     documents the reception).
-- Every source_id below is already linked to one endpoint of its edge, so no
-- new sources are introduced; this only fills the empty FK.

BEGIN;

-- ── SRC_TESTAMENT_SOLOMON (20): Solomonic demonology — afflictions, binding, decans ──
UPDATE entity_relationships r SET source_id = 'SRC_TESTAMENT_SOLOMON'
FROM (VALUES
  ('ENT_LAT_ABEZETHIBOU','causes_affliction','ENT_HUMANS'),
  ('ENT_LAT_ENVY_DEMON','causes_affliction','ENT_HUMANS'),
  ('ENT_LAT_KUNOPEGOS','causes_affliction','ENT_HUMANS'),
  ('ENT_LAT_LIX_TETRAX','causes_affliction','ENT_HUMANS'),
  ('ENT_LAT_OBYZOUTH','causes_affliction','ENT_HUMANS'),
  ('ENT_LAT_ONOSKELIS','causes_affliction','ENT_HUMANS'),
  ('ENT_LAT_ORNIAS','causes_affliction','ENT_HUMANS'),
  ('ENT_LAT_TEPHRAS','causes_affliction','ENT_HUMANS'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_OBYZOUTH'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_ENVY_DEMON'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_TEPHRAS'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_KUNOPEGOS'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_LIX_TETRAX'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_ABEZETHIBOU'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_ONOSKELIS'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_BEELZEBOUL'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_ASMODEUS'),
  ('ENT_ISR_SOLOMON','rules','ENT_LAT_ORNIAS'),
  ('ENT_LAT_BEELZEBOUL','rules','ENT_CHR_DEMONS'),
  ('ENT_LAT_DECANS','presides_over','ENT_FATE')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_CROWLEY_BOOK_OF_LAW (11): Thelemic receptions (Liber AL vel Legis) ──
UPDATE entity_relationships r SET source_id = 'SRC_CROWLEY_BOOK_OF_LAW'
FROM (VALUES
  ('ENT_EGY_HORUS','received_as','ENT_THL_RA_HOOR_KHUIT'),
  ('ENT_EGY_NUT','received_as','ENT_THL_NUIT'),
  ('ENT_EGY_RA','received_as','ENT_THL_RA_HOOR_KHUIT'),
  ('ENT_EGY_RA_HORAKHTY','received_as','ENT_THL_RA_HOOR_KHUIT'),
  ('ENT_REC_MAHATMAS','received_as','ENT_THL_AIWASS'),
  ('ENT_SYN_HARPOCRATES','received_as','ENT_THL_RA_HOOR_KHUIT'),
  ('ENT_THL_AIWASS','reception_of','ENT_REC_MAHATMAS'),
  ('ENT_THL_NUIT','reception_of','ENT_EGY_NUT'),
  ('ENT_THL_RA_HOOR_KHUIT','reception_of','ENT_EGY_HORUS'),
  ('ENT_THL_RA_HOOR_KHUIT','reception_of','ENT_EGY_RA_HORAKHTY'),
  ('ENT_THL_RA_HOOR_KHUIT','reception_of','ENT_EGY_RA')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_CORPUS_HERMETICUM (11): Hermes/Thoth → Trismegistus, Hermetic cosmology ──
UPDATE entity_relationships r SET source_id = 'SRC_CORPUS_HERMETICUM'
FROM (VALUES
  ('ENT_HER_COSMOS','embodies','ENT_COSMIC_ORDER'),
  ('ENT_HER_THE_ONE','equated_with','ENT_GNO_MONAD'),
  ('ENT_AGATHOS_DAIMON','received_as','ENT_LAT_AGATHOS_DAIMON_HERMETIC'),
  ('ENT_EGY_THOTH','received_as','ENT_HER_TRISMEGISTUS'),
  ('ENT_HERMES','received_as','ENT_HER_TRISMEGISTUS'),
  ('ENT_HER_TRISMEGISTUS','reception_of','ENT_HERMES'),
  ('ENT_HER_TRISMEGISTUS','reception_of','ENT_EGY_THOTH'),
  ('ENT_HER_TRISMEGISTUS','reveals','ENT_WISDOM'),
  ('ENT_HER_TRISMEGISTUS','syncretized_with','ENT_EGY_THOTH'),
  ('ENT_HER_TRISMEGISTUS','syncretized_with','ENT_HERMES'),
  ('ENT_HER_TRISMEGISTUS','teaches','ENT_HIDDEN_KNOWLEDGE')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_NHC (5): Nag Hammadi — Sethian/Valentinian/Thomasine/Ophite ──
UPDATE entity_relationships r SET source_id = 'SRC_NHC'
FROM (VALUES
  ('ENT_SET_YOUEL','emanates_from','ENT_SET_BARBELO'),
  ('ENT_THO_KINGDOM','embodies','ENT_SALVATION'),
  ('ENT_OPH_SERPENT','reveals','ENT_FORBIDDEN_KNOWLEDGE'),
  ('ENT_VAL_BRIDAL_CHAMBER','symbolizes','ENT_SALVATION'),
  ('ENT_SET_NOREA','undergoes_process','ENT_SALVATION')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_LAYTON_GNOSTIC (3): Gnostic Anthropos equations, Horos/Stauros ──
UPDATE entity_relationships r SET source_id = 'SRC_LAYTON_GNOSTIC'
FROM (VALUES
  ('ENT_GNO_ANTHROPOS','equated_with','ENT_HER_ANTHROPOS'),
  ('ENT_VAL_ANTHROPOS','equated_with','ENT_HER_ANTHROPOS'),
  ('ENT_VAL_HOROS','identified_with','ENT_VAL_STAUROS')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_DDD_BIBLE (5): Behemoth/Leviathan chaos monsters (Hebrew Bible) ──
UPDATE entity_relationships r SET source_id = 'SRC_DDD_BIBLE'
FROM (VALUES
  ('ENT_ISR_BEHEMOTH','dwells_in','ENT_EARTH'),
  ('ENT_ISR_LEVIATHAN','dwells_in','ENT_WATER'),
  ('ENT_ISR_BEHEMOTH','embodies','ENT_CHAOS'),
  ('ENT_ISR_LEVIATHAN','embodies','ENT_CHAOS'),
  ('ENT_ISR_LEVIATHAN','equated_with','ENT_MES_TIAMAT')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_DDD_CHRISTIAN (4): Christian chaos monsters / Satan→Devil ──
UPDATE entity_relationships r SET source_id = 'SRC_DDD_CHRISTIAN'
FROM (VALUES
  ('ENT_CHR_BEHEMOTH','embodies','ENT_CHAOS'),
  ('ENT_CHR_LEVIATHAN','embodies','ENT_CHAOS'),
  ('ENT_ISR_SATAN','received_as','ENT_CHR_DEVIL'),
  ('ENT_CHR_DEVIL','reception_of','ENT_ISR_SATAN')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_CHRISTIAN_DEMONOLOGY_GENERAL (6): Devil/Lucifer, patristic Hecate ──
UPDATE entity_relationships r SET source_id = 'SRC_CHRISTIAN_DEMONOLOGY_GENERAL'
FROM (VALUES
  ('ENT_REC_HECATE_PATRISTIC','opposes','ENT_CHR_DEVIL'),
  ('ENT_CHR_DEVIL','received_as','ENT_CHR_LUCIFER'),
  ('ENT_HECATE','received_as','ENT_REC_HECATE_PATRISTIC'),
  ('ENT_LAT_DAIMONES','received_as','ENT_CHR_DEVIL'),
  ('ENT_CHR_LUCIFER','reception_of','ENT_CHR_DEVIL'),
  ('ENT_REC_HECATE_PATRISTIC','reception_of','ENT_HECATE')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_LEVI_DOGME_RITUEL (4): Baphomet (Éliphas Lévi) ──
UPDATE entity_relationships r SET source_id = 'SRC_LEVI_DOGME_RITUEL'
FROM (VALUES
  ('ENT_CHR_LUCIFER','received_as','ENT_REC_BAPHOMET_LEVI'),
  ('ENT_HER_TRISMEGISTUS','received_as','ENT_REC_BAPHOMET_LEVI'),
  ('ENT_REC_BAPHOMET_LEVI','reception_of','ENT_CHR_LUCIFER'),
  ('ENT_REC_BAPHOMET_LEVI','reception_of','ENT_HER_TRISMEGISTUS')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_BLAVATSKY_SECRET_DOCTRINE (2): Theosophical Mahatmas ──
UPDATE entity_relationships r SET source_id = 'SRC_BLAVATSKY_SECRET_DOCTRINE'
FROM (VALUES
  ('ENT_HER_TRISMEGISTUS','received_as','ENT_REC_MAHATMAS'),
  ('ENT_REC_MAHATMAS','reception_of','ENT_HER_TRISMEGISTUS')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_HUTTON_TRIUMPH (2): Romantic/modern-pagan Pan ──
UPDATE entity_relationships r SET source_id = 'SRC_HUTTON_TRIUMPH'
FROM (VALUES
  ('ENT_PAN','received_as','ENT_REC_PAN_ROMANTIC'),
  ('ENT_REC_PAN_ROMANTIC','reception_of','ENT_PAN')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_MANICHAEAN_KEPHALAIA (4): Manichaean cosmological process ──
UPDATE entity_relationships r SET source_id = 'SRC_MANICHAEAN_KEPHALAIA'
FROM (VALUES
  ('ENT_MANICH_LIGHT_PARTICLES','imprisoned_by','ENT_MANICH_MATTER'),
  ('ENT_MANICH_MOTHER_LIFE','paired_with','ENT_MANICH_PRIMAL_MAN'),
  ('ENT_MANICH_COLUMN_GLORY','transmits','ENT_MANICH_LIGHT_PARTICLES'),
  ('ENT_MANICH_LIGHT_PARTICLES','undergoes_process','ENT_SALVATION')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_LIEU_MANICHAEISM (3): Manichaean Light-Mind = Nous equations ──
UPDATE entity_relationships r SET source_id = 'SRC_LIEU_MANICHAEISM'
FROM (VALUES
  ('ENT_MANICH_LIGHT_MIND','equated_with','ENT_GNO_NOUS'),
  ('ENT_MANICH_LIGHT_MIND','equated_with','ENT_HER_NOUS'),
  ('ENT_MANICH_LIGHT_MIND','equated_with','ENT_VAL_NOUS')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_SCHOLEM_KABBALAH (3): Adam Kadmon = primordial Anthropos ──
UPDATE entity_relationships r SET source_id = 'SRC_SCHOLEM_KABBALAH'
FROM (VALUES
  ('ENT_JM_ADAM_KADMON','equated_with','ENT_HER_ANTHROPOS'),
  ('ENT_JM_ADAM_KADMON','equated_with','ENT_VAL_ANTHROPOS'),
  ('ENT_JM_ADAM_KADMON','equated_with','ENT_GNO_ANTHROPOS')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── SRC_THEOI_GODS (2): Greek theogonic identifications ──
UPDATE entity_relationships r SET source_id = 'SRC_THEOI_GODS'
FROM (VALUES
  ('ENT_ANANKE','identified_with','ENT_ADRASTEIA'),
  ('ENT_NYX','paired_with','ENT_PHANES')
) AS t(s,rt,o)
WHERE r.subject_entity_id=t.s AND r.relationship_type=t.rt AND r.object_entity_id=t.o
  AND (r.source_id IS NULL OR r.source_id='');

-- ── Single-edge assignments ──────────────────────────────────────────────────
UPDATE entity_relationships SET source_id='SRC_HESIOD_THEOGONY'
  WHERE subject_entity_id='ENT_STYX' AND relationship_type='embodies' AND object_entity_id='ENT_HORKOS' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_BLACK_GREEN_MESO'
  WHERE subject_entity_id='ENT_MES_INANNA_ISHTAR' AND relationship_type='embodies' AND object_entity_id='ENT_VENUS' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_AVESTA'
  WHERE subject_entity_id='ENT_ZOR_MITHRA' AND relationship_type='embodies' AND object_entity_id='ENT_LIGHT' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_ISLAM_EI2'
  WHERE subject_entity_id='ENT_ISL_KHIDR' AND relationship_type='embodies' AND object_entity_id='ENT_IMMORTALITY' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_QURAN'
  WHERE subject_entity_id='ENT_ISL_YAJUJ_MAJUJ' AND relationship_type='embodies' AND object_entity_id='ENT_CHAOS' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_DAY_GODS_CONFLICT'
  WHERE subject_entity_id='ENT_CAN_LOTAN' AND relationship_type='embodies' AND object_entity_id='ENT_CHAOS' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_CROSS_CANAANITE_MYTH'
  WHERE subject_entity_id='ENT_CAN_ASTARTE' AND relationship_type='equated_with' AND object_entity_id='ENT_MES_INANNA_ISHTAR' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_IAMBLICHUS_DE_MYSTERIIS'
  WHERE subject_entity_id='ENT_LAT_PLANETARY_RULERS' AND relationship_type='equated_with' AND object_entity_id='ENT_GNO_ARCHONS' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_PROSE_EDDA'
  WHERE subject_entity_id='ENT_NOR_JORMUNGANDR' AND relationship_type='dwells_in' AND object_entity_id='ENT_WATER' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_1_ENOCH'
  WHERE subject_entity_id='ENT_ISR_URIEL' AND relationship_type='presides_over' AND object_entity_id='ENT_COSMIC_ORDER' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_PAUSANIAS_DESCRIPTION'
  WHERE subject_entity_id='ENT_DIONYSUS' AND relationship_type='identified_with' AND object_entity_id='ENT_IACCHUS' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_HOMERIC_HYMNS'
  WHERE subject_entity_id='ENT_DEMETER' AND relationship_type='paired_with' AND object_entity_id='ENT_IACCHUS' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_ASCLEPIUS_HERMETICA'
  WHERE subject_entity_id='ENT_HER_TRISMEGISTUS' AND relationship_type='patron_of' AND object_entity_id='ENT_MAGIC' AND (source_id IS NULL OR source_id='');
UPDATE entity_relationships SET source_id='SRC_ELIADE_ER'
  WHERE subject_entity_id='ENT_REVELATION' AND relationship_type='reveals' AND object_entity_id='ENT_THO_KINGDOM' AND (source_id IS NULL OR source_id='');

-- ── Verify: should be 0 remaining, and no dangling source FKs introduced ──────
SELECT count(*) AS remaining_unsourced_rels
FROM entity_relationships WHERE source_id IS NULL OR source_id='';

SELECT count(*) AS dangling_source_fks
FROM entity_relationships r
WHERE r.source_id IS NOT NULL AND r.source_id<>''
  AND NOT EXISTS (SELECT 1 FROM sources s WHERE s.source_id=r.source_id);

SELECT * FROM v_release_metrics;

COMMIT;
