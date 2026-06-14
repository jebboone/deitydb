-- scripts/audit_category_fill.sql
-- Fills `category` and `primary_domains` for 90 entities across 20 traditions
-- that lack these fields, making them visible to category-filtered views
-- (v_public_angelic_beings, v_public_adversarial_beings, etc.) and the
-- browse-by-category query.
--
-- Assignments derive from each entity's existing entity_type, short_note,
-- and source citations already in the DB. No new entities, relationships,
-- sources, or periods are added.

BEGIN;

-- ── Canaanite / Ugaritic ──────────────────────────────────────────────────────
UPDATE entities SET category = 'Fertility Deity',
  primary_domains = 'grain; agriculture; fertility; rain; underworld; Philistine cult'
WHERE entity_id = 'ENT_CAN_DAGON';

UPDATE entities SET category = 'War Deity',
  primary_domains = 'plague; war; death; destruction; lightning; warrior god'
WHERE entity_id = 'ENT_CAN_RESHEPH';

-- ── Celtic / Gaulish ─────────────────────────────────────────────────────────
UPDATE entities SET category = 'High Deity',
  primary_domains = 'craftsmanship; trade; eloquence; solar; war; ravens; pan-Celtic sovereignty'
WHERE entity_id = 'ENT_CEL_LUGUS';

UPDATE entities SET category = 'Healing Deity',
  primary_domains = 'divine youth; healing waters; music; hunting; solar; Apollo-equivalent'
WHERE entity_id = 'ENT_CEL_MAPONOS';

UPDATE entities SET category = 'Divine Collective',
  primary_domains = 'divine motherhood; fertility; protection; abundance; triple goddess form'
WHERE entity_id = 'ENT_CEL_MATRES';

UPDATE entities SET category = 'Fertility Deity',
  primary_domains = 'abundance; fertility; prosperity; sovereignty; consort of Lugus'
WHERE entity_id = 'ENT_CEL_ROSMERTA';

-- ── Celtic / Welsh ────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Cosmological Realm'
WHERE entity_id = 'ENT_WEL_ANNWN';

UPDATE entities SET category = 'Nature Deity'
WHERE entity_id = 'ENT_WEL_ARANRHOD';

UPDATE entities SET category = 'Underworld Deity'
WHERE entity_id = 'ENT_WEL_ARAWN';

UPDATE entities SET category = 'Nature Deity'
WHERE entity_id = 'ENT_WEL_BLODEUWEDD';

UPDATE entities SET category = 'Hero'
WHERE entity_id = 'ENT_WEL_BRAN';

UPDATE entities SET category = 'Hero'
WHERE entity_id = 'ENT_WEL_BRANWEN';

UPDATE entities SET category = 'High Deity'
WHERE entity_id = 'ENT_WEL_DON';

UPDATE entities SET category = 'Trickster Figure'
WHERE entity_id = 'ENT_WEL_GWYDION';

UPDATE entities SET category = 'Underworld Deity'
WHERE entity_id = 'ENT_WEL_GWYN_AP_NUDD';

UPDATE entities SET category = 'Hero'
WHERE entity_id = 'ENT_WEL_LLEU_LLAW_GYFFES';

UPDATE entities SET category = 'Hero'
WHERE entity_id = 'ENT_WEL_MANAWYDAN';

UPDATE entities SET category = 'High Deity'
WHERE entity_id = 'ENT_WEL_MATH';

UPDATE entities SET category = 'Hero'
WHERE entity_id = 'ENT_WEL_PRYDERI';

UPDATE entities SET category = 'Hero'
WHERE entity_id = 'ENT_WEL_PWYLL';

UPDATE entities SET category = 'High Deity'
WHERE entity_id = 'ENT_WEL_RHIANNON';

-- ── Egyptian ──────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'moon; lunar cycle; time; fertility; nocturnal light'
WHERE entity_id = 'ENT_EGY_IAH';

UPDATE entities SET category = 'Fertility Deity',
  primary_domains = 'childbirth; birth brick; fate at birth; destiny; protection of newborns'
WHERE entity_id = 'ENT_EGY_MESKHENET';

UPDATE entities SET category = 'War Deity',
  primary_domains = 'hunting; war; lioness; protection; night; cave sanctuary at Speos Artemidos'
WHERE entity_id = 'ENT_EGY_PAKHET';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'early Theban sovereignty; divine protection; predecessor to Mut'
WHERE entity_id = 'ENT_EGY_WOSRET';

-- ── Etruscan ──────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Underworld Deity',
  primary_domains = 'death escort; underworld; hammers; punishment; chthonic daimon'
WHERE entity_id = 'ENT_ETR_CHARUN';

UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'vegetation; wine; ecstasy; underworld; Dionysus-equivalent'
WHERE entity_id = 'ENT_ETR_FUFLUNS';

UPDATE entities SET category = 'Spirit Collective',
  primary_domains = 'feminine spirits; fate; beauty; death attendants; winged figures'
WHERE entity_id = 'ENT_ETR_LASA';

UPDATE entities SET category = 'Wisdom Deity',
  primary_domains = 'wisdom; war; crafts; prophecy; Minerva-equivalent; divine counsel'
WHERE entity_id = 'ENT_ETR_MENRVA';

UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'water; sea; wells; Neptune-equivalent; maritime'
WHERE entity_id = 'ENT_ETR_NETHUNS';

UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'dawn; light; Aurora-equivalent; new day; solar horizon'
WHERE entity_id = 'ENT_ETR_THESAN';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'sky; lightning; divine authority; Jupiter-equivalent; chief Etruscan deity; Capitoline Triad'
WHERE entity_id = 'ENT_ETR_TINIA';

UPDATE entities SET category = 'Adversarial Being',
  primary_domains = 'underworld terror; punishment; chaos; serpent hair; demonic attendant'
WHERE entity_id = 'ENT_ETR_TUCHULCHA';

UPDATE entities SET category = 'Love Deity',
  primary_domains = 'love; beauty; desire; Aphrodite-equivalent; divine sexuality'
WHERE entity_id = 'ENT_ETR_TURAN';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'divine queenship; Juno-equivalent; Capitoline Triad; Etruscan state religion; sky'
WHERE entity_id = 'ENT_ETR_UNI';

UPDATE entities SET category = 'Sun Deity',
  primary_domains = 'sun; solar chariot; light; Sol-equivalent; Helios-equivalent'
WHERE entity_id = 'ENT_ETR_USIL';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'supreme Etruscan deity; chief of gods; pan-Etruscan authority; Fanum Voltumnae'
WHERE entity_id = 'ENT_ETR_VOLTUMNA';

-- ── Greek ─────────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Titan',
  primary_domains = 'time; harvest; sovereignty; the Golden Age; father of the Olympians'
WHERE entity_id = 'ENT_KRONOS';

UPDATE entities SET category = 'Primordial Deity',
  primary_domains = 'sky; heaven; primordial cosmos; father of the Titans'
WHERE entity_id = 'ENT_OURANOS';

UPDATE entities SET category = 'Adversarial Being',
  primary_domains = 'chaos; storm; serpent; typhoon; adversary of Zeus; monster father'
WHERE entity_id = 'ENT_TYPHON';

-- ── Hittite ───────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'High Deity',
  primary_domains = 'divine wisdom; elder goddess; counsel; search; Telipinu myth; grandmother of gods'
WHERE entity_id = 'ENT_HTT_HANNAHANNA';

UPDATE entities SET category = 'Adversarial Being',
  primary_domains = 'chaos serpent; storm opponent; primordial dragon; Illuyanka myth'
WHERE entity_id = 'ENT_HTT_ILLUYANKA';

UPDATE entities SET category = 'War Deity',
  primary_domains = 'protection; hunting; divine aid; trickery; Illuyanka myth; sovereignty'
WHERE entity_id = 'ENT_HTT_INARAS';

UPDATE entities SET category = 'Sun Deity',
  primary_domains = 'sun; cosmic order; divine queenship; oaths; Hittite state religion; Arinna'
WHERE entity_id = 'ENT_HTT_ARINNA';

UPDATE entities SET category = 'Thunder Deity',
  primary_domains = 'storm; thunder; rain; divine kingship; Illuyanka myth; chief Hittite deity'
WHERE entity_id = 'ENT_HTT_TARHUNNA';

UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'vegetation; agriculture; disappearing god; spring return; fertility; Telipinu myth'
WHERE entity_id = 'ENT_HTT_TELIPINU';

-- ── Hittite / Hurrian ─────────────────────────────────────────────────────────
UPDATE entities SET category = 'Primordial Deity',
  primary_domains = 'primordial kingship; first divine king; Hurrian theogony; dethroned'
WHERE entity_id = 'ENT_HTT_ALALU';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'divine queenship; Queen of Heaven; sun; consort of Teshub; Hepat-Teshub pair'
WHERE entity_id = 'ENT_HTT_HEPAT';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'succession; grain; divine kingship; father of Teshub; Hurrian theogony; Kumarbi cycle'
WHERE entity_id = 'ENT_HTT_KUMARBI';

UPDATE entities SET category = 'Love Deity',
  primary_domains = 'love; war; sexuality; divine power; Ishtar-equivalent; Hurrian great goddess'
WHERE entity_id = 'ENT_HTT_SHAUSHKA';

UPDATE entities SET category = 'Thunder Deity',
  primary_domains = 'storm; thunder; rain; divine kingship; bull iconography; Hurrian chief deity'
WHERE entity_id = 'ENT_HTT_TESHUB';

UPDATE entities SET category = 'Adversarial Being',
  primary_domains = 'chaos monster; stone giant; adversary of Teshub; Ullikummi Song'
WHERE entity_id = 'ENT_HTT_ULLIKUMMI';

-- ── Islamic ───────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Revealer Figure',
  primary_domains = 'prophecy; divine wisdom; heavenly ascent; Enoch-equivalent; Hermetic sciences'
WHERE entity_id = 'ENT_ISL_IDRIS';

UPDATE entities SET category = 'Revealer Figure',
  primary_domains = 'prophecy; fire; divine confrontation; Elijah-equivalent; eschatology'
WHERE entity_id = 'ENT_ISL_ILYAS';

UPDATE entities SET category = 'Revealer Figure',
  primary_domains = 'prophecy; Torah; exodus; divine speech; lawgiver; Israelite equivalent'
WHERE entity_id = 'ENT_ISL_MUSA';

-- ── Israelite ─────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Hero',
  primary_domains = 'first human; paradise; fall; divine image; primordial father; Eden'
WHERE entity_id = 'ENT_ISR_ADAM';

UPDATE entities SET category = 'Revealer Figure',
  primary_domains = 'prophecy; fire; Baal confrontation; chariot ascent; eschatology; return'
WHERE entity_id = 'ENT_ISR_ELIJAH';

UPDATE entities SET category = 'Revealer Figure',
  primary_domains = 'prophecy; lawgiver; Torah; Sinai; Exodus; divine face; burning bush'
WHERE entity_id = 'ENT_ISR_MOSES';

UPDATE entities SET category = 'Hero',
  primary_domains = 'flood; ark; covenant; patriarch; divine righteousness; new world'
WHERE entity_id = 'ENT_ISR_NOAH';

-- ── Jewish Mystical ───────────────────────────────────────────────────────────
UPDATE entities SET category = 'Adversarial Being',
  primary_domains = 'demoness; night; infant death; Adam''s first wife; sexual danger; Sheol'
WHERE entity_id = 'ENT_JM_LILITH';

-- ── Mesopotamian ─────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Adversarial Being',
  primary_domains = 'chaos; storm bird; stolen Tablets of Destiny; thunder; monster'
WHERE entity_id = 'ENT_MES_ANZU';

UPDATE entities SET category = 'Hero',
  primary_domains = 'wild man; friendship; nature; civilisation; Gilgamesh companion; death'
WHERE entity_id = 'ENT_MES_ENKIDU';

UPDATE entities SET category = 'Hero',
  primary_domains = 'heroic quest; death; immortality; friendship; flood; semi-divine kingship'
WHERE entity_id = 'ENT_MES_GILGAMESH';

UPDATE entities SET category = 'Primordial Deity',
  primary_domains = 'primordial sea; first creator; mother of gods; Sumerian cosmogony'
WHERE entity_id = 'ENT_MES_NAMMU';

UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'moon; divine consort of Nanna/Sin; mother of Utu/Shamash; Ur; night'
WHERE entity_id = 'ENT_MES_NINGAL';

UPDATE entities SET category = 'Fertility Deity',
  primary_domains = 'motherhood; grain; divine consort of Enlil; divine wind; earth; Nippur'
WHERE entity_id = 'ENT_MES_NINLIL';

UPDATE entities SET category = 'Fertility Deity',
  primary_domains = 'divine mother; wild cow; mother of Gilgamesh; dream interpretation; Uruk'
WHERE entity_id = 'ENT_MES_NINSUN';

UPDATE entities SET category = 'Hero',
  primary_domains = 'flood survivor; immortality; secret of eternal life; Dilmun; Gilgamesh quest'
WHERE entity_id = 'ENT_MES_UTNAPISHTIM';

-- ── Mycenaean ─────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'High Deity',
  primary_domains = 'feminine divine sovereignty; sky; Mycenaean great goddess; Linear B tablets'
WHERE entity_id = 'ENT_MYC_DIWIA';

UPDATE entities SET category = 'War Deity',
  primary_domains = 'war; battle; Ares-precursor; Mycenaean martial cult; Linear B'
WHERE entity_id = 'ENT_MYC_ENYALIOS';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'divine mistress; sovereignty; Mycenaean great goddess; Linear B; multiple sanctuaries'
WHERE entity_id = 'ENT_MYC_POTNIA';

-- ── Phoenician ────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'High Deity',
  primary_domains = 'sky; chief deity; Carthage; fertility; Baal-title; Saturn-identified'
WHERE entity_id = 'ENT_PHO_BAAL_HAMMON';

UPDATE entities SET category = 'Healing Deity',
  primary_domains = 'healing; serpent; Sidon; Asclepius-identified; mystery cult; dying deity'
WHERE entity_id = 'ENT_PHO_ESHMUN';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'city patron; dying and rising; Tyre; Heracles-identified; Phoenician colonisation'
WHERE entity_id = 'ENT_PHO_MELQART';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'divine queenship; Queen of Heaven; Carthage; fertility; Juno Caelestis'
WHERE entity_id = 'ENT_PHO_TANIT';

-- ── Phrygian ─────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Primordial Deity',
  primary_domains = 'primordial hermaphrodite; castration; origin of Attis; Pessinuntine myth'
WHERE entity_id = 'ENT_PHRYG_AGDISTIS';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'great mother; mountain; lions; fertility; divine sovereignty; Cybele predecessor'
WHERE entity_id = 'ENT_PHRYG_MATAR';

-- ── Pre-Islamic Arabian ───────────────────────────────────────────────────────
UPDATE entities SET category = 'High Deity',
  primary_domains = 'chief deity; moon; tribal sovereignty; Mecca; Kaaba; pre-Islamic Arabian pantheon'
WHERE entity_id = 'ENT_ARA_HUBAL';

-- ── Scythian ─────────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'earth; ground; chthonic; serpent-goddess; Gaea-equivalent; Scythian cosmology'
WHERE entity_id = 'ENT_SCYTH_API';

UPDATE entities SET category = 'Love Deity',
  primary_domains = 'love; sky; Venus; Aphrodite Urania equivalent; divine feminine; celestial'
WHERE entity_id = 'ENT_SCYTH_ARTIMPASA';

UPDATE entities SET category = 'Sun Deity',
  primary_domains = 'sun; light; Apollo-equivalent; solar divination; archery; far-sight'
WHERE entity_id = 'ENT_SCYTH_OETOSYRUS';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'sky; chief deity; Zeus-equivalent; divine authority; Scythian pantheon head'
WHERE entity_id = 'ENT_SCYTH_PAPAEUS';

UPDATE entities SET category = 'War Deity',
  primary_domains = 'war; sword cult; akinakes; Ares-equivalent; martial sovereignty; iron'
WHERE entity_id = 'ENT_SCYTH_SWORD_ARES';

UPDATE entities SET category = 'High Deity',
  primary_domains = 'hearth; fire; divine queen; Hestia-equivalent; Scythian royalty; oaths'
WHERE entity_id = 'ENT_SCYTH_TABITI';

UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'sea; water; Poseidon-equivalent; Royal Scythian ancestor; rivers'
WHERE entity_id = 'ENT_SCYTH_THAGIMASADAS';

-- ── South Arabian ─────────────────────────────────────────────────────────────
UPDATE entities SET category = 'High Deity',
  primary_domains = 'moon; state patron; Sabaean national deity; temple of Marib; divine sovereignty'
WHERE entity_id = 'ENT_SAB_ALMAQAH';

UPDATE entities SET category = 'War Deity',
  primary_domains = 'Venus; morning star; war; South Arabian astral deity; male form of Astarte tradition'
WHERE entity_id = 'ENT_SAB_ATHTAR';

UPDATE entities SET category = 'Sun Deity',
  primary_domains = 'sun; South Arabian solar cult; feminine solar deity; light; cosmic order'
WHERE entity_id = 'ENT_SAB_SHAMS';

UPDATE entities SET category = 'Nature Deity',
  primary_domains = 'moon; Qatabanian tribal deity; lunar cycle; ancestral divine patron'
WHERE entity_id = 'ENT_SAB_AMM';

-- ── Zoroastrian ───────────────────────────────────────────────────────────────
UPDATE entities SET category = 'Adversarial Being',
  primary_domains = 'wrath; violence; aggression; demon of rage; Aeshma Daeva; Gabriel''s adversary'
WHERE entity_id = 'ENT_ZOR_AESHMA_DAEVA';

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS still_missing_category
FROM entities WHERE category IS NULL OR category = '';

SELECT tradition, COUNT(*) AS now_categorised
FROM entities
WHERE entity_id IN (
  'ENT_CAN_DAGON','ENT_CAN_RESHEPH',
  'ENT_CEL_LUGUS','ENT_CEL_MAPONOS','ENT_CEL_MATRES','ENT_CEL_ROSMERTA',
  'ENT_ETR_TINIA','ENT_ETR_UNI','ENT_ETR_TURAN','ENT_ETR_USIL',
  'ENT_ETR_MENRVA','ENT_ETR_CHARUN','ENT_ETR_TUCHULCHA','ENT_ETR_FUFLUNS',
  'ENT_ETR_NETHUNS','ENT_ETR_THESAN','ENT_ETR_LASA','ENT_ETR_VOLTUMNA',
  'ENT_SCYTH_TABITI','ENT_SCYTH_PAPAEUS','ENT_SCYTH_ARTIMPASA',
  'ENT_SCYTH_API','ENT_SCYTH_SWORD_ARES','ENT_SCYTH_OETOSYRUS','ENT_SCYTH_THAGIMASADAS'
)
GROUP BY tradition;

COMMIT;
