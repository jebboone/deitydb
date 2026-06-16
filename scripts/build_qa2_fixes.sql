-- build_qa2_fixes.sql — corrections from the v1.65/v1.66 adversarial scholarly audit. v1.67.2
-- 4 removals (reified epithet, 2 voces magicae, 1 unverifiable name), homonym/relationship
-- retyping, an invented kinship, over-specified domains, and a planetary-angel anachronism.
BEGIN;

-- ========== A. REMOVALS ==========
-- Tepti/Temti = the Elamite word 'lord' / a theophoric element, NOT a deity.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ELAM_TEPTI' OR object_entity_id='ENT_ELAM_TEPTI';
DELETE FROM entity_periods WHERE entity_id='ENT_ELAM_TEPTI';
DELETE FROM entity_sources WHERE entity_id='ENT_ELAM_TEPTI';
DELETE FROM entity_duplicate_review WHERE entity_id='ENT_ELAM_TEPTI';
DELETE FROM entities WHERE entity_id='ENT_ELAM_TEPTI';
-- Ablanathanalba & Sesengenbarpharanges = voces magicae (magic words), not addressable entities.
DELETE FROM entity_relationships WHERE subject_entity_id IN ('ENT_PGM_ABLANATHANALBA','ENT_PGM_SESENGENBARPHARANGES') OR object_entity_id IN ('ENT_PGM_ABLANATHANALBA','ENT_PGM_SESENGENBARPHARANGES');
DELETE FROM entity_periods WHERE entity_id IN ('ENT_PGM_ABLANATHANALBA','ENT_PGM_SESENGENBARPHARANGES');
DELETE FROM entity_sources WHERE entity_id IN ('ENT_PGM_ABLANATHANALBA','ENT_PGM_SESENGENBARPHARANGES');
DELETE FROM entities WHERE entity_id IN ('ENT_PGM_ABLANATHANALBA','ENT_PGM_SESENGENBARPHARANGES');
-- Genon = not an attested Ars Notoria angel name (absent from Véronèse); likely garbled.
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_SOL_GENON' OR object_entity_id='ENT_SOL_GENON';
DELETE FROM entity_periods WHERE entity_id='ENT_SOL_GENON';
DELETE FROM entity_sources WHERE entity_id='ENT_SOL_GENON';
DELETE FROM entities WHERE entity_id='ENT_SOL_GENON';

-- ========== B. HOMONYM-AS-IDENTITY -> aligned_with (same name, distinct figure) ==========
UPDATE entity_relationships SET relationship_type='aligned_with', rationale='Shares the name Anael with the Testament-of-Solomon angel but is a distinct grimoire planetary-angel (homonym, not identity).'
 WHERE subject_entity_id='ENT_SOL_ANAEL' AND relationship_type='identified_with' AND object_entity_id='ENT_LAT_ANAEL';
UPDATE entity_relationships SET relationship_type='aligned_with', rationale='Shares the name Samael with the Gnostic/demiurgic Samael but is a distinct grimoire planetary-angel (homonym, not identity).'
 WHERE subject_entity_id='ENT_SOL_SAMAEL_MARS' AND relationship_type='identified_with' AND object_entity_id='ENT_GNO_SAMAEL';
-- Ninegal/Belet-ekallim is originally a distinct palace goddess; the Inanna equation is only literary.
UPDATE entity_relationships SET relationship_type='aligned_with', rationale='Belet-ekallim/Ninegal was originally a distinct palace goddess; equated with Inanna only in some literary contexts.'
 WHERE subject_entity_id='ENT_MES_NINEGAL' AND relationship_type='identified_with' AND object_entity_id='ENT_MES_INANNA_ISHTAR';
-- Narundi's Ishtar link is loose/functional, not a firm equation.
UPDATE entity_relationships SET relationship_type='aligned_with', rationale='Narundi is a martial/victory goddess functionally drawn into Ishtar''s orbit; in An=Anum she is sister of the Sebitti. Not a firm equation.'
 WHERE subject_entity_id='ENT_ELAM_NARUNDI' AND relationship_type='equated_with' AND object_entity_id='ENT_MES_INANNA_ISHTAR';

-- ========== C. RELATIONSHIP CORRECTIONS ==========
-- Ninkurra is daughter of Ninshar (with Enki) in the Enki-Ninhursag sequence, not directly 'child_of Enki'.
UPDATE entity_relationships SET object_entity_id='ENT_MES_NINSHAR', rationale='In the Enki and Ninhursag sequence Ninkurra is the daughter of Ninshar (Ninsar).'
 WHERE subject_entity_id='ENT_MES_NINKURRA' AND relationship_type='child_of' AND object_entity_id='ENT_MES_ENKI_EA';
-- Nebethetepet is the personified creative hand / female complement of Atum, not a spouse.
UPDATE entity_relationships SET relationship_type='paired_with', rationale='Nebethetepet personifies the creative hand / female complement of Atum, not a spouse in the ordinary sense.'
 WHERE subject_entity_id='ENT_EGY_NEBETHETEPET' AND relationship_type='spouse_of' AND object_entity_id='ENT_EGY_ATUM';
-- Af Bri is a rain-angel, not a protection-angel.
UPDATE entity_relationships SET relationship_type='presides_over', object_entity_id='ENT_WATER', rationale='Af Bri (Job 37:11) is the angel of rain in the Geshem liturgy.'
 WHERE subject_entity_id='ENT_JM_AF_BRI' AND relationship_type='presides_over' AND object_entity_id='ENT_PROTECTION';

-- ========== D. SPURIOUS / OVER-SPECIFIED EDGE DELETIONS ==========
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_BAT' AND relationship_type='protected_by' AND object_entity_id='ENT_EGY_HORUS';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_SED' AND relationship_type='patron_of' AND object_entity_id='ENT_EGY_HORUS';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MES_NIRAH' AND relationship_type='child_of' AND object_entity_id='ENT_MES_ISHTARAN';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_IABET' AND relationship_type='presides_over' AND object_entity_id='ENT_SUN';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_EGY_AHA' AND relationship_type='opposes' AND object_entity_id='ENT_EGY_APEP';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_JM_PESAKIR' AND relationship_type='presides_over' AND object_entity_id='ENT_MAGIC';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_JM_BOEL' AND relationship_type='presides_over' AND object_entity_id='ENT_REVELATION';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_JM_SEFER_RAZIEL_TEACHING' AND relationship_type='presides_over' AND object_entity_id='ENT_HEALING';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_SOL_BEATIFIC_VISION_OP' AND relationship_type='presides_over' AND object_entity_id='ENT_PROTECTION';

-- ========== E. CONFIDENCE CALIBRATION: Picatrix-spirit -> Olympian alignments high->medium ==========
UPDATE entity_relationships SET confidence='medium'
 WHERE relationship_type='aligned_with' AND confidence='high'
 AND (subject_entity_id,object_entity_id) IN (
  ('ENT_AST_JUPITER_SPIRIT','ENT_ZEUS'),('ENT_AST_MARS_SPIRIT','ENT_ARES'),('ENT_AST_SUN_SPIRIT','ENT_HELIOS'),
  ('ENT_AST_VENUS_SPIRIT','ENT_APHRODITE'),('ENT_AST_MERCURY_SPIRIT','ENT_HERMES'),('ENT_AST_MOON_SPIRIT','ENT_SELENE'));

-- ========== F. SOLOMONIC PLANETARY-ANGEL ANACHRONISM: re-source the standardized set to Agrippa; downgrade ==========
INSERT INTO sources (source_id, source_type, title, scope) VALUES
 ('SRC_AGRIPPA_OCCULTA','primary text','Heinrich Cornelius Agrippa, De occulta philosophia libri tres (1533) — incl. the Scale of Seven (Bk II.10)','Solomonic Magic')
ON CONFLICT (source_id) DO NOTHING;
-- add Agrippa as the source of the *standardized* attributions (keeping Liber Razielis where it genuinely attests precursors)
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
SELECT v.eid,'SRC_AGRIPPA_OCCULTA','direct attestation','Standardized planetary-angel attribution: Agrippa, De occulta philosophia II.10 (Scale of Seven), 1533'
FROM (VALUES ('ENT_SOL_PLANETARY_ANGELS'),('ENT_SOL_SACHIEL'),('ENT_SOL_ANAEL'),('ENT_SOL_SAMAEL_MARS')) AS v(eid)
ON CONFLICT DO NOTHING;
UPDATE entities SET evidence_confidence='C' WHERE entity_id IN ('ENT_SOL_PLANETARY_ANGELS','ENT_SOL_SACHIEL','ENT_SOL_ANAEL','ENT_SOL_SAMAEL_MARS');
UPDATE entities SET short_note='The seven angels governing the planetary spheres. The 13c Liber Razielis tradition attests only part of this (Cassiel of Saturn; a Sachiel-precursor, Satquiel); the clean, fixed seven-fold set (Cassiel/Sachiel/Samael/Michael/Anael/Raphael/Gabriel) is the 16c standardization of Agrippa''s Scale of Seven (De occulta philosophia II.10, 1533) and the Heptameron.' WHERE entity_id='ENT_SOL_PLANETARY_ANGELS';
UPDATE entities SET short_note='Angel of Jupiter in the standardized planetary-angel scheme; the 13c Liber Razielis tradition has the precursor form Satquiel/Saquiel, while the spelling "Sachiel" and the fixed Jupiter attribution are Heptameron/Agrippa-era (16c).' WHERE entity_id='ENT_SOL_SACHIEL';
UPDATE entities SET short_note='Angel of Venus in the standardized planetary-angel scheme; the Venus attribution is firmly the Agrippa/Heptameron (16c) Scale of Seven (the older corpus varies, sometimes placing Anael over the Sun). Shares its name with the Testament-of-Solomon Anael (a distinct homonym).' WHERE entity_id='ENT_SOL_ANAEL';
UPDATE entities SET short_note='Angel of Mars in the standardized planetary-angel scheme (Agrippa''s Scale of Seven, 1533); functionally distinct from the Gnostic/demiurgic Samael, with which it shares only the name.' WHERE entity_id='ENT_SOL_SAMAEL_MARS';

-- ========== G. NOTE CORRECTIONS (no relationship change) ==========
UPDATE entities SET short_note='Goddess Ninegal / Belet-ekallim ("Lady of the Palace"), originally a distinct palace goddess and guardian of the royal dynasty; oldest attestation the ED Fara god list. Equated with Inanna only in some later literary contexts.' WHERE entity_id='ENT_MES_NINEGAL';
UPDATE entities SET short_note='Divine artisan/sculptor of the Enki-Ninhursag birth sequence, daughter of Ninshar and mother of Uttu in the Dilmun myth tradition. (A craftsman deity Ninkurra in An=Anum may be a distinct, possibly male, figure.)' WHERE entity_id='ENT_MES_NINKURRA';
UPDATE entities SET short_note='Serpent god and messenger (sukkal) of Ishtaran of Der, depicted as a snake; attested from the 3rd millennium onward. (His earlier "son of Ishtaran" modeling was incorrect — he is Ishtaran''s minister, not son.)' WHERE entity_id='ENT_MES_NIRAH';
UPDATE entities SET short_note='Heliopolitan goddess ("Mistress of the Offering/Contentment") personifying the creative hand / female complement of Atum, associated with Iusaaset and Hathor from the Old Kingdom onward.' WHERE entity_id='ENT_EGY_NEBETHETEPET';
UPDATE entities SET short_note='Af Bri, the angel of rain — the name (af-bri) is from Job 37:11, but the angelic personification originates with the 6th-7th c. payyetan Eleazar Kalir and the liturgical Prayer for Rain (Tefillat Geshem); later carried in the medieval magical-angelological tradition.' WHERE entity_id='ENT_JM_AF_BRI';
UPDATE entities SET short_note='Boel (Bual) rules the seventh encampment of the first firmament of Sefer ha-Razim, whose angels (42 per Rebiger-Schaefer; 44 in some editions) govern dreams and dream-divination (she''elat halom).' WHERE entity_id='ENT_JM_BOEL';
UPDATE entities SET short_note='Pesakir (Psbr) heads the sixth encampment of the first firmament in Sefer ha-Razim; its angels are charged with crossing the earth at great speed (swift messengers).' WHERE entity_id='ENT_JM_PESAKIR';
UPDATE entities SET short_note='Personification of the east wind, one of the cardinal-wind deities, ram-/scarab-form; attested chiefly in Late Period/Greco-Roman temple and coffin texts (later than most of this stratum), loosely linked to Anhur.' WHERE entity_id='ENT_EGY_HENKHISESUI';
UPDATE entities SET short_note='Victory goddess worshipped at Susa c. 2100 BCE (statue dedicated by Puzur-Inshushinak); in the Mesopotamian An=Anum list reckoned a sister of the Sebitti, the "divine seven of Elam".' WHERE entity_id='ENT_ELAM_NARUNDI';

\echo '--- post-fix: orphan / unsourced / unperiodized in the audited cohorts (must be 0) ---'
WITH n AS (SELECT entity_id FROM entities WHERE inclusion_basis ~ 'Archaic Sumerian|Predynastic|Elamite deity \(Susa|Jewish magical corpus|Solomonic magic tradition|Picatrix|Greek Magical Papyri')
SELECT
 (SELECT count(*) FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=n.entity_id OR r.object_entity_id=n.entity_id)) orphans,
 (SELECT count(*) FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_sources s WHERE s.entity_id=n.entity_id)) unsourced,
 (SELECT count(*) FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_periods p WHERE p.entity_id=n.entity_id)) unperiodized;

COMMIT;
