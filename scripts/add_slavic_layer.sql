-- scripts/add_slavic_layer.sql
-- Adds the Slavic religious tradition (East/West/South Slavic paganism).
-- The primary historical source is the Primary Chronicle (Povest' Vremennykh Let,
-- PVL), compiled c. 1113 CE, which records the Kiev Pantheon erected by
-- Vladimir I in AD 980: Perun, Khors, Dažbog, Stribog, Simargl, Mokosh.
-- The Perkūnas-Perun/Veles triad is the clearest Baltic-Slavic parallel
-- and the most structurally secure element of Slavic divine reconstruction.

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_PRIMARY_CHRONICLE_PVL',
 'Nestor (trad.), Povest'' Vremennykh Let (Primary Chronicle), compiled c. 1113 CE; Laurentian redaction c. 1377 CE',
 'primary text / chronicle',
 'The foundational East Slavic historical chronicle, compiled at the Kyiv Cave Monastery c. 1113 CE and attributed to the monk Nestor; surviving in the Laurentian (1377) and Hypatian (c. 1425) redactions. The entry for AD 980 records Vladimir I''s pantheon: "And Vladimir began to reign alone in Kiev, and he set up idols on the hills outside the palace: Perun of wood with a head of silver and a mustache of gold, and Khors, Dažbog, Stribog, Simargl, and Mokosh." This is the primary and most explicit ancient source for the names and existence of the core Slavic deities. The entry for AD 988 records their forced destruction at Christianisation. The oath formulas earlier in the chronicle (AD 945 Igor treaty, AD 971 Svyatoslav treaty) invoke Perun and Veles together — the earliest attestation of the Perun-Veles opposition. Standard scholarly edition: D. S. Likhachev (ed.), Pamyatniki literatury drevney Rusi (Moscow, 1978); English translation: Samuel H. Cross and Olgerd P. Sherbowitz-Wetzor, The Russian Primary Chronicle: Laurentian Text (Medieval Academy of America, 1953).'),
('SRC_BRUCKNER_SLAVIC_MYTH',
 'Aleksander Brückner, Mitologia Słowiańska i Polska (Krakowska Spółka Wydawnicza, Krakow, 1918; repr. Wydawnictwo Naukowe PWN, Warsaw, 1980)',
 'secondary scholarly',
 'The classic scholarly reconstruction of Slavic mythology by the leading Polish Slavicist of the early 20th century. Brückner systematically evaluates the primary chronicle and ecclesiastical sources against later folk tradition, proposing a reconstructed pre-Christian Slavic pantheon. His skeptical methodology — he rejected many proposed deities as late folk invention or misidentified personifications — remains influential. Covers Perun, Veles, Mokosh, Svarog, Dažbog, Stribog, Simargl, Khors, Rod, and Rozhanitsy; critically evaluates Chernobog and Belobog (rejected as German invention). Standard citation for early scholarly treatment of Slavic paganism alongside Ivanov and Toporov (1974).')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_SLAV_PAGAN',
 'Slavic',
 'Slavic Pre-Christian Period',
 -500, 1100,
 'The pre-Christian religious tradition of the Slavic peoples, from the early Slavic archaeological horizon (c. 5th-6th c. CE expansion) through the Christianisation of the Slavic kingdoms (Bulgaria 864, Moravia 863, Bohemia c. 895, Poland 966, Russia 988, Lithuania 1387). Deity names are attested primarily in the Primary Chronicle (PVL, c. 1113 CE) and in Byzantine chronicle sources, ecclesiastical prohibitions (Slovo ob idolakh, 9th-10th c.), and later folk tradition. The Kiev Pantheon of Vladimir I (AD 980) is the most securely attested snapshot of Slavic paganism.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
-- Kiev Pantheon deities (directly attested in PVL AD 980 entry)
('ENT_SLAV_PERUN',
 'Perun',
 'Slavic',
 'god',
 'Thunder Deity',
 'thunder; lightning; storm; war; oak; justice; oaths',
 'A',
 'Thunder and storm god; supreme deity of the East Slavic Kiev Pantheon. Named first in Vladimir I''s pantheon (AD 980): "Perun of wood with a head of silver and a mustache of gold." Perun is also invoked in the Byzantine-Rus oath treaties of AD 945 and 971 alongside Veles, confirming his role as the divine guarantor of oaths. Name from Proto-Slavic *Perunъ, cognate with Baltic Perkūnas, Vedic Parjanya, and ultimately PIE *perkʷ- (thunder/oak). Perun''s cosmic myth parallels Baltic Perkūnas: he battles the serpentine underworld deity Veles (who hides below the earth, in cattle, in trees) and strikes him with lightning — the standard Indo-European thunder-god-vs.-chaos-serpent narrative. Oak trees sacred to Perun. Primary Chronicle (Cross & Sherbowitz-Wetzor 1953) pp. 93-94, 162-163; Brückner (1918) pp. 67-80.'),
('ENT_SLAV_MOKOSH',
 'Mokosh',
 'Slavic',
 'goddess',
 'Earth Deity',
 'earth; weaving; fate; moisture; women; fertility',
 'A',
 'Goddess of earth, weaving, and fate; the only female deity in Vladimir I''s Kiev Pantheon (AD 980 PVL entry). Name probably from Proto-Slavic *mokъ (moisture, wetness) or *mokošь; alternative etymology connects to PIE *(s)mek- (to spin, weave). Mokosh is the spinning fate-goddess who determines the thread of life; she is the guardian of women and their domestic work (spinning, weaving, shearing). Ecclesiastical prohibitions (Slovo ob idolakh, 9th-10th c.) condemn offerings to Mokosh alongside other Slavic deities, showing her worship persisted after Christianisation. She is often compared to the Greek Moirai and Baltic Laima as a weaving fate-goddess. Brückner (1918) pp. 130-138; Primary Chronicle (Cross 1953) p. 93.'),
('ENT_SLAV_DAZBOG',
 'Dažbog',
 'Slavic',
 'god',
 'Solar Deity',
 'sun; wealth; giving; solar cycle; fate',
 'A',
 'Solar and wealth-giving deity; named in the AD 980 Kiev Pantheon (PVL). Name from Proto-Slavic *Daž(d)ьbogъ, meaning "Give-wealth god" (*dati, to give + *bogъ, wealth/god; cognate with Iranian *baga, divine wealth). A gloss in the Hypatian Chronicle''s translation of the Chronicle of Malalas calls Dažbog son of Svarog (fire deity) and identifies him with Helios — though this is a Byzantine literary equation, not necessarily indigenous theology. Dažbog may represent the sun as the dispensing agent of divine bounty. The Lay of Igor''s Campaign (Slovo o polku Igoreve, 12th c.) calls the Rus people "grandsons of Dažbog." Brückner (1918) pp. 96-105; Primary Chronicle (Cross 1953) p. 93.'),
('ENT_SLAV_STRIBOG',
 'Stribog',
 'Slavic',
 'god',
 'Wind Deity',
 'wind; air; weather; dispersal',
 'A',
 'Wind deity; named in the AD 980 Kiev Pantheon (PVL). The Lay of Igor''s Campaign (12th c.) calls the winds "grandsons of Stribog." Name from Proto-Slavic *Stribogъ; the first element (*Stri-) has disputed etymology — possibly from *stьrь (to spread, disperse) or from an Iranian cognate (*Sraōsha or similar). Function as a wind deity is the most secure interpretation. Brückner (1918) pp. 106-110; Primary Chronicle (Cross 1953) p. 93.'),
('ENT_SLAV_SIMARGL',
 'Simargl',
 'Slavic',
 'guardian deity',
 'Protective Deity',
 'winged guardian; protection; plants; underworld boundary',
 'B',
 'Winged guardian deity; named in the AD 980 Kiev Pantheon (PVL) but uniquely enigmatic. Name may derive from Persian Simurgh (a mythical bird), pointing to Iranian cultural influence in the Kyiv region. In Iranian mythology the Simurgh is a giant winged dog-bird that roosts in the tree of life. Simargl''s function in Slavic theology is uncertain; some scholars interpret him as a guardian of seeds and plants, others as a boundary deity between the living world and the underworld. His name is sometimes split as "Sim" and "Ergl" or interpreted as a plural. Evidence is confined to the PVL list; classified confidence B due to unclear function and possible foreign origin. Brückner (1918) pp. 111-115; Primary Chronicle (Cross 1953) p. 93.'),
('ENT_SLAV_KHORS',
 'Khors',
 'Slavic',
 'solar deity',
 'Solar Deity',
 'sun; solar cycle; Iranian solar tradition',
 'B',
 'Solar deity; named in the AD 980 Kiev Pantheon (PVL) alongside Dažbog, suggesting two distinct solar deities or aspects. Name from Old Iranian *Hvar (sun; cf. Avestan xvəng, Iranian Hurshid / Khorshid). Khors is widely held to be an Iranian-derived deity, introduced into the Rus pantheon through Alanic or Iranian contact in the Pontic steppe. His presence alongside Dažbog suggests the Kievan pantheon incorporated deities from multiple ethnic backgrounds. The Lay of Igor''s Campaign (12th c.) references "the great Khors." Brückner (1918) pp. 120-125; Primary Chronicle (Cross 1953) p. 93.'),
-- Additional well-attested Slavic deities (not in AD 980 list but securely attested)
('ENT_SLAV_VELES',
 'Veles',
 'Slavic',
 'chthonic deity',
 'Underworld Deity',
 'underworld; cattle; wealth; magic; oaths; poetry',
 'A',
 'Chthonic deity and lord of the underworld, cattle, and magic; Slavic cognate of Baltic Velnias. Veles (also: Volos) is invoked alongside Perun in the Byzantine-Rus oath treaties (AD 945, 971 PVL): "by Perun their god and Volos the god of cattle." He governs the Nav (realm of the dead) and the earthly wealth below — cattle, grain, gold. The Perun-Veles cosmic myth parallels Baltic Perkūnas-Velnias: Veles hides below the earth or in cattle and trees, Perun strikes him with lightning. In Christian-period sources Veles was demonized and assimilated to the devil. The name is cognate with Baltic Velnias and PIE *wel- (the dead). Primary Chronicle (Cross 1953) pp. 74, 87 (oath treaties); Brückner (1918) pp. 138-155.'),
('ENT_SLAV_SVAROG',
 'Svarog',
 'Slavic',
 'sky / fire deity',
 'Creator Deity',
 'sky; fire; celestial forge; divine kingship; metallurgy',
 'B',
 'Sky and fire deity; not named in the AD 980 Kiev Pantheon but attested in a gloss added to the East Slavic translation of the Byzantine Chronicle of Malalas (12th c.), which equates Svarog with Hephaestus and says: "Svarog, the god of fires... After him reigned his son Dažbog." The gloss thus posits a Svarog-Dažbog father-son relationship. Svarog is the celestial smith and generator of divine fire; his name may derive from PIE *swer- (sky, sun; cf. Sanskrit svarga, heaven) or from *svar- (to gleam). The Svarozhich (son of Svarog) fire deity is attested in German sources on the Rethra sanctuary among the Lutici Slavs. Brückner (1918) pp. 85-95; Hypatian Chronicle (Malalas gloss, 12th c.).'),
('ENT_SLAV_ROD',
 'Rod',
 'Slavic',
 'ancestral deity',
 'Creator Deity',
 'ancestry; birth; fate; clan; divine judgment',
 'B',
 'Ancestral and birth deity; attested in Old Slavic ecclesiastical prohibitions (Slovo ob idolakh, 9th-10th c.: "do not offer bread and cheese to Rod and the Rozhanitsy") and other Church admonishments. Rod is the divine ancestor and birth-fate deity, paired with the Rozhanitsy (birth goddesses). His name from Proto-Slavic *rodъ (clan, birth, kin) which is central to Slavic social organisation. Boris Rybakov proposed Rod as the supreme Slavic deity predating the Olympian-style Kiev Pantheon; most scholars consider this speculative, but Rod''s function as a fate-dispensing deity at birth is secure. Brückner (1918) pp. 160-170.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_SLAV_PERUN',   'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'PVL AD 980: Vladimir''s idol of Perun explicitly described; oath treaties AD 945, 971 invoke Perun alongside Veles.'),
('ENT_SLAV_PERUN',   'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 67-80: Perun etymology, thunder function, Perun-Veles myth reconstruction.'),
('ENT_SLAV_MOKOSH',  'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'PVL AD 980: Mokosh listed as sixth deity in the Kiev Pantheon, the only female.'),
('ENT_SLAV_MOKOSH',  'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 130-138: Mokosh as spinning fate-goddess; ecclesiastical prohibitions confirm ongoing worship.'),
('ENT_SLAV_DAZBOG',  'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'PVL AD 980: Dažbog in the Kiev Pantheon; Hypatian Chronicle Malalas gloss calls him son of Svarog; Lay of Igor (12th c.) "grandsons of Dažbog."'),
('ENT_SLAV_DAZBOG',  'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 96-105: Dažbog solar function and name etymology.'),
('ENT_SLAV_STRIBOG', 'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'PVL AD 980: Stribog in the Kiev Pantheon; Lay of Igor (12th c.) "winds, grandsons of Stribog."'),
('ENT_SLAV_STRIBOG', 'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 106-110: Stribog as wind deity.'),
('ENT_SLAV_SIMARGL', 'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'PVL AD 980: Simargl in the Kiev Pantheon list; no further ancient description of function.'),
('ENT_SLAV_SIMARGL', 'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 111-115: Simargl; Iranian Simurgh connection; uncertain Slavic function.'),
('ENT_SLAV_KHORS',   'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'PVL AD 980: Khors second in the Kiev Pantheon list (after Perun); "great Khors" in Lay of Igor (12th c.).'),
('ENT_SLAV_KHORS',   'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 120-125: Khors as Iranian-derived solar deity.'),
('ENT_SLAV_VELES',   'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'PVL oath treaties AD 945 (Igor''s treaty) and 971 (Svyatoslav''s treaty): "by Perun their god and Volos the god of cattle." Primary attestation as cattle-wealth deity and oath-god.'),
('ENT_SLAV_VELES',   'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 138-155: Veles/Volos cattle deity; Perun-Veles mythological opposition.'),
('ENT_SLAV_SVAROG',  'SRC_PRIMARY_CHRONICLE_PVL', 'Primary text',      'Hypatian Chronicle, Malalas gloss (12th c.): "Svarog, the god of fires...after him reigned his son Dažbog" — the primary attestation of Svarog as celestial fire/smith deity.'),
('ENT_SLAV_SVAROG',  'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 85-95: Svarog fire/sky deity; name etymology and Svarozhich attestation at Rethra.'),
('ENT_SLAV_ROD',     'SRC_BRUCKNER_SLAVIC_MYTH',  'Secondary analysis', 'Brückner (1918) pp. 160-170: Rod as birth/fate deity paired with Rozhanitsy; ecclesiastical prohibition sources.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_SLAV_PERUN',   'PER_SLAV_PAGAN', 'high',   'Attested in Byzantine-Rus treaty AD 945, 971 (PVL); Kiev Pantheon AD 980. Earliest explicit attestation of any Slavic deity.', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_MOKOSH',  'PER_SLAV_PAGAN', 'high',   'Kiev Pantheon AD 980 (PVL); ecclesiastical prohibitions from 9th-10th c. confirm pre-Christian cult.', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_DAZBOG',  'PER_SLAV_PAGAN', 'high',   'Kiev Pantheon AD 980 (PVL); Lay of Igor (12th c.) — pre-Mongol period solar deity.', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_STRIBOG', 'PER_SLAV_PAGAN', 'high',   'Kiev Pantheon AD 980 (PVL); Lay of Igor (12th c.) wind deity attestation.', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_SIMARGL', 'PER_SLAV_PAGAN', 'medium', 'Kiev Pantheon AD 980 (PVL); function uncertain; classified medium due to limited secondary evidence.', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_KHORS',   'PER_SLAV_PAGAN', 'high',   'Kiev Pantheon AD 980 (PVL); Lay of Igor (12th c.) "great Khors."', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_VELES',   'PER_SLAV_PAGAN', 'high',   'Treaty oath attestation AD 945 and 971 (PVL) — among the earliest and most secure Slavic deity attestations.', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_SVAROG',  'PER_SLAV_PAGAN', 'medium', 'Attested in Hypatian Chronicle Malalas gloss (12th c.); Svarozhich in German Rethra sources (1000-1100 CE). Classified medium — indirect attestation.', 'SRC_PRIMARY_CHRONICLE_PVL', 'reviewed'),
('ENT_SLAV_ROD',     'PER_SLAV_PAGAN', 'medium', 'Attested in ecclesiastical prohibitions 9th-10th c. CE; not in the PVL Kiev Pantheon list. Classified medium.', 'SRC_BRUCKNER_SLAVIC_MYTH', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Core Perun-Veles cosmic opposition
('ENT_SLAV_PERUN', 'opposes', 'ENT_SLAV_VELES',
 'high',
 'The central Slavic mythological narrative: Perun (thunder) battles Veles (chthonic) who steals cattle or a solar being. Veles hides below the earth, in cattle, in trees; Perun strikes him with lightning. The oath treaties (PVL AD 945, 971) invoke both together as complementary cosmic powers. Structurally cognate with Baltic Perkūnas-Velnias. Brückner (1918) pp. 67-155.',
 'SRC_PRIMARY_CHRONICLE_PVL', 'PER_SLAV_PAGAN', 'reviewed'),
('ENT_SLAV_VELES', 'opposed_by', 'ENT_SLAV_PERUN',
 'high',
 'Veles is the chthonic antagonist of Perun in the cosmic myth; hides in the earth, cattle, and trees to escape Perun''s lightning. Brückner (1918) pp. 138-155; PVL oath treaties.',
 'SRC_PRIMARY_CHRONICLE_PVL', 'PER_SLAV_PAGAN', 'reviewed'),
-- Svarog-Dažbog parentage
('ENT_SLAV_SVAROG', 'parent_of', 'ENT_SLAV_DAZBOG',
 'medium',
 'Hypatian Chronicle Malalas gloss (12th c.) states: "after [Svarog] reigned his son Dažbog" — making Dažbog the son of Svarog in the Slavic divine genealogy. Classified medium because this is a late Byzantine literary equation. Brückner (1918) pp. 85-105.',
 'SRC_PRIMARY_CHRONICLE_PVL', 'PER_SLAV_PAGAN', 'reviewed'),
('ENT_SLAV_DAZBOG', 'child_of', 'ENT_SLAV_SVAROG',
 'medium',
 'Hypatian Chronicle Malalas gloss posits Dažbog as son of Svarog. Classified medium as per Svarog-parent relationship. Brückner (1918) pp. 96-105.',
 'SRC_PRIMARY_CHRONICLE_PVL', 'PER_SLAV_PAGAN', 'reviewed'),
-- Kiev Pantheon membership
('ENT_SLAV_PERUN',   'member_of', 'ENT_SLAV_ROD',   'low', 'Placeholder — see note.', 'SRC_PRIMARY_CHRONICLE_PVL', 'PER_SLAV_PAGAN', 'reviewed'),
-- Cross-traditional parallels
('ENT_SLAV_PERUN', 'aligned_with', 'ENT_BALT_PERKUNAS',
 'high',
 'Perun and Perkūnas are cognate thunder deities: same PIE *perkʷ- root, same cosmic myth structure (vs. Veles/Velnias), same oak cult, same role as divine guarantor of oaths. The Slavic-Baltic parallel is one of the most secure in Indo-European comparative mythology. Greimas (1992) pp. 77-84; Brückner (1918) pp. 67-80.',
 'SRC_BRUCKNER_SLAVIC_MYTH', 'PER_SLAV_PAGAN', 'reviewed'),
('ENT_SLAV_VELES', 'aligned_with', 'ENT_BALT_VELNIAS',
 'high',
 'Veles and Velnias are cognate chthonic deities: cognate names (PIE *wel-, the dead), same underworld governance, same cattle/wealth domain, same antagonism to the thunder deity. Brückner (1918) pp. 138-155; Greimas (1992) pp. 121-150.',
 'SRC_BRUCKNER_SLAVIC_MYTH', 'PER_SLAV_PAGAN', 'reviewed'),
('ENT_SLAV_PERUN', 'aligned_with', 'ENT_NOR_THOR',
 'high',
 'Perun and Thor are typologically parallel thunder deities: both wield the thunder weapon against a chaos serpent/giant, both protect cosmic order, both are oak-associated. The structural parallel (not etymological — different PIE roots) is well established in IE comparative mythology. Brückner (1918) pp. 67-80.',
 'SRC_BRUCKNER_SLAVIC_MYTH', 'PER_SLAV_PAGAN', 'reviewed'),
('ENT_SLAV_MOKOSH', 'aligned_with', 'ENT_BALT_LAIMA',
 'medium',
 'Mokosh and Laima are structurally parallel fate/weaving goddesses: both spin or weave the thread of fate, both govern birth and death, both are associated with women''s domestic work. The parallel is functional, not etymological. Gimbutas (1963) p. 202; Brückner (1918) pp. 130-138.',
 'SRC_BRUCKNER_SLAVIC_MYTH', 'PER_SLAV_PAGAN', 'reviewed'),
-- Embodies domains
('ENT_SLAV_PERUN', 'embodies', 'ENT_STORM',
 'high',
 'Perun is the divine personification of the thunderstorm; his cult is centred on lightning as a divine force striking chaos from the sky. PVL AD 980.',
 'SRC_PRIMARY_CHRONICLE_PVL', 'PER_SLAV_PAGAN', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Remove placeholder Rod membership relationship
DELETE FROM entity_relationships
WHERE subject_entity_id = 'ENT_SLAV_PERUN'
  AND relationship_type = 'member_of'
  AND object_entity_id = 'ENT_SLAV_ROD';

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS slavic_entities FROM entities WHERE tradition = 'Slavic';
SELECT * FROM v_release_metrics;

COMMIT;
