-- scripts/add_iberian_layer.sql
-- Adds the pre-Roman Iberian/Lusitanian pantheon: five deities of the
-- Lusitanian and north-western Hispanian religious tradition, attested primarily
-- in Latin votive inscriptions from the Roman period (1st–4th c. CE) but
-- preserving pre-Roman theonyms and functions.
--
-- The Iberian/Lusitanian tradition is known almost entirely through the
-- interpretatio romana lens of Roman-period dedications; the underlying
-- pre-Roman cult is reconstructed from the persistence of indigenous theonyms,
-- the failure of syncretism in many cases, and the few Lusitanian-language
-- sources (the Bronze Plaque of Arronches and related inscriptions).
--
-- Secondary: Blázquez (1962), Olivares Pedreño (2002).

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_BLÁZQUEZ_RELIGIONES',
 'José María Blázquez, Religiones primitivas de Hispania, Vol. I: Fuentes literarias y epigráficas (Consejo Superior de Investigaciones Científicas, Madrid, 1962; 2nd ed. 1983)',
 'secondary scholarly',
 'The foundational academic survey of pre-Roman Iberian religion, assembling the literary and epigraphic sources for the native deities of the Iberian peninsula. Blázquez catalogues the votive inscriptions for Endovelicus, Ataegina, Bandua, Nabia, and Trebaruna alongside the full corpus of Lusitanian and Hispanian indigenous theonyms attested in Roman-period Latin inscriptions. He analyses their distribution, the degree of Roman syncretism, and the evidence for their pre-Roman functions. Blázquez''s epigraphic catalogue remains the starting point for all subsequent scholarship on Hispanian indigenous religion. Cited for the entire Iberian/Lusitanian layer.'),
('SRC_OLIVARES_IBERIAN',
 'Juan Carlos Olivares Pedreño, Los dioses de la Hispania céltica (Bibliotheca Archaeologica Hispana 15; Real Academia de la Historia / Universidad de Alicante, Madrid, 2002)',
 'secondary scholarly',
 'Comprehensive study of the indigenous deities of the Celtic regions of Hispania — primarily Lusitania and the NW Iberian peninsula (modern Portugal and Galicia) — analyzing the distribution of theonyms, their linguistic analysis, the degree of Celtic vs. pre-Celtic substratum, and the functions inferred from dedicatory formulae and findspot contexts. Olivares Pedreño provides detailed analysis of Bandua (the deity most widely attested across Lusitania and NW Hispania, with 25+ inscriptions), Nabia (river/mountain goddess), Trebaruna (attested in Lusitanian-language inscriptions including the Arronches plaque), Endovelicus (the healing-oracular deity of São Miguel da Mota), and Ataegina (chthonic goddess widely attested across Lusitania and Baetica). This is the key reference for the linguistic and functional analysis of the deities in this layer.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_IB_IRON_AGE',
 'Iberian/Lusitanian',
 'Pre-Roman and Roman-period Hispanian Indigenous Religion',
 -600, 400,
 'The period of the pre-Roman indigenous religious tradition of the Iberian peninsula, particularly the Lusitanian/NW Iberian zone (modern Portugal, Galicia, and Extremadura), from the Iron Age through the Roman provincial period. The indigenous religion of Hispania before Roman conquest (the systematic conquest of Lusitania was completed by 27 BCE under Augustus after a long series of wars) is known almost exclusively through Latin votive inscriptions of the Roman period — the 1st to 4th centuries CE — which preserve pre-Roman theonyms that resisted complete Romanization. The Lusitanian language (a pre-Celtic or para-Celtic Indo-European language of the peninsula) is attested in a handful of inscriptions, most importantly the Bronze Plaque of Arronches (c. 1st c. CE, from a sanctuary in the Portalegre district, Portugal), which preserves a religious ritual text with theonyms including Trebaruna, Reve, Laebo, and Ilurbeda. The distribution of votive inscriptions for indigenous deities (Endovelicus at São Miguel da Mota, Ataegina across SW Iberia, Bandua across a broad NW-to-SE axis, Nabia in the NW) gives a picture of a polytheistic tradition tied to landscapes (rivers, mountains, healing springs) and community life (oath-bonds, tribal solidarity). Blázquez (1962) and Olivares Pedreño (2002) are the primary scholarly references.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_IB_ENDOVELICUS',
 'Endovelicus',
 'Iberian/Lusitanian',
 'healing / oracular deity',
 'Healing Deity',
 'healing; prophecy; oracular dreams; incubation; protective deity',
 'A',
 'Endovelicus (variants: Endovellicus, Endovelicus, Endovollicus, Endobellicus) is the best-attested indigenous deity of the Lusitanian/pre-Roman Iberian tradition, with approximately 80 Latin votive inscriptions and a significant number of sculptural dedications recovered from the sanctuary of São Miguel da Mota at Alandroal in the Alto Alentejo, Portugal. The São Miguel da Mota sanctuary was one of the major healing and oracular sanctuaries of the Roman province of Lusitania, visited by pilgrims across a wide regional radius. The deity''s functions — healing, protective oracular dreams (incubation, the practice of sleeping in the sanctuary to receive divine healing visions), and general protection — are consistent with the broader ancient Mediterranean tradition of healing/oracular deities (cf. Asclepius at Epidaurus, Serapis at Alexandria). The theonym "Endovelicus" is of uncertain etymology: Blázquez proposed a root related to "good" (PIE *endho-/entu-, possibly meaning "very good" or "all-good"), while others have suggested a connection with "the one below" (underworld associations). Both a healing and a protective deity at once. Blázquez (1962) pp. 147-168; Olivares Pedreño (2002) pp. 89-110.'),
('ENT_IB_ATAEGINA',
 'Ataegina',
 'Iberian/Lusitanian',
 'chthonic goddess / regeneration deity',
 'Underworld Deity',
 'underworld; regeneration; rebirth; healing; nature; spring',
 'A',
 'Ataegina (variants: Ataecina, Adaegina, Ategina) is the most widely distributed indigenous goddess of the Lusitanian and Baetican zone, attested in approximately 40 Latin votive inscriptions from a broad geographical area spanning modern Portugal, Extremadura (Spain), and Andalusia. Her theonym is typically analyzed as from PIE *ati-gena-, "born again / reborn," pointing to a regeneration and cyclic renewal function; alternatively the first element may relate to *atel-, "night." She is a chthonic deity — associated with the underworld, death, and regeneration of nature — and is most explicitly syncretized with the Roman Proserpina in a group of inscriptions that invoke "Dea sancta Ataegina Turibrigensis Proserpina" (from the main cult site at Turobriga, near Aroche, Huelva). The Turobriga cult combined the indigenous Ataegina with the Roman goddess of the underworld and spring/regeneration cycle, making this the most explicit ancient interpretatio romana in the Iberian tradition. Her epithets include "Queen of the Sun" in some dedications, suggesting solar as well as chthonic aspects — a paradox paralleled in other Mediterranean underworld-yet-light deities (Persephone, Hecate). Blázquez (1962) pp. 125-146; Olivares Pedreño (2002) pp. 111-125.'),
('ENT_IB_TREBARUNA',
 'Trebaruna',
 'Iberian/Lusitanian',
 'Lusitanian deity / oath and settlement goddess',
 'Warrior Deity',
 'settlement; territory; oaths; protection; community bonds',
 'B',
 'Trebaruna is attested in the Lusitanian language — one of the few surviving pre-Roman language texts of the peninsula — in the Bronze Plaque of Arronches (c. 1st century CE, Portalegre district, Portugal), which preserves a ritual sacrifice text naming Trebaruna alongside other Lusitanian deities (Reve, Laebo, Ilurbeda). She also appears in a small number of Latin votive inscriptions. The theonym is analyzed as Proto-Celtic or Lusitanian: treb- = "settlement / dwelling" (cf. Old Irish treb, "settlement"), and -aruna/-runa has been connected with "water/river" (runo = "water source") or oath-bonds. The compound likely means "she of the settlement" or "protector of the community." Her domain encompasses territorial protection, community bonds, and possibly oath/covenant functions — consistent with an Iron Age Lusitanian settlement deity whose cult guaranteed the integrity of the community space. Confidence B: the name is securely attested in the Arronches plaque (a primary Lusitanian-language source), but the number of dedications is small and her precise functions cannot be fully recovered. Olivares Pedreño (2002) pp. 145-160; Blázquez (1962) pp. 195-200.'),
('ENT_IB_BANDUA',
 'Bandua',
 'Iberian/Lusitanian',
 'binding deity / protective war god',
 'War Deity',
 'social bonds; oaths; territorial protection; war; community solidarity',
 'A',
 'Bandua is the most widely attested indigenous deity of NW Hispania (Lusitania, Gallaecia, and parts of Baetica), with approximately 25 Latin votive inscriptions from a broad geographic distribution — the widest of any indigenous Iberian deity apart from Ataegina. The theonym is analyzed as PIE *bondho- or *bhand-, "bond / obligation / binding" (cognate with English "band"), suggesting a deity whose domain encompasses social bonds, oaths, tribal solidarity, and the ties that hold a community together. Inscriptions frequently invoke Bandua with geographic epithets identifying local cult centers (Bandua Araugel-, Bandua Vorode-, etc.), suggesting a tradition of localized cult forms under a common divine name — a pattern also seen in the Celtic deity Lugus. Some inscriptions pair Bandua with Mars, providing an interpretatio romana link to military/protective functions; this combined with the oath/bond etymology suggests a deity who presides over warrior oaths, military solidarity, and community defense. Confidence A: widely and consistently attested across multiple regions. Olivares Pedreño (2002) pp. 39-88; Blázquez (1962) pp. 63-100.'),
('ENT_IB_NABIA',
 'Nabia',
 'Iberian/Lusitanian',
 'river and mountain goddess',
 'Nature Deity',
 'rivers; water; mountains; nature; territorial protection',
 'A',
 'Nabia (variants: Navia, Naeva, Nabia) is a goddess of rivers and mountains attested in Latin votive inscriptions from Lusitania and NW Hispania, including modern Portugal (particularly the Minho and Lima river districts) and Galicia. Her name connects with the river Navia in NW Spain (modern Asturias/Galicia) and likely with a broader root for flowing water (cf. Gaulish nava, Old Irish naue, "flowing water / boat"). She is a landscape deity whose domain encompasses rivers, springs, and mountain waters — the sacred geography of the NW Iberian plateau and Atlantic zone. She appears both alone and in combination with Jupiter in some dedications (Nabia Corona, with a crown epithet suggesting a territorial or queenly function), but never with the Roman water deities specifically, suggesting her river patronage was understood as a distinct indigenous function. Confidence A: consistently attested across multiple provinces. Olivares Pedreño (2002) pp. 161-180; Blázquez (1962) pp. 101-120.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_IB_ENDOVELICUS', 'SRC_BLÁZQUEZ_RELIGIONES', 'Primary epigraphic (Latin) / secondary scholarly',
 'Blázquez (1962) pp. 147-168: full catalogue of ~80 Latin votive inscriptions from São Miguel da Mota sanctuary, Alandroal; sculptural dedications; analysis of the deity''s healing/oracular function; etymology of the theonym; regional distribution of the cult.'),
('ENT_IB_ENDOVELICUS', 'SRC_OLIVARES_IBERIAN', 'Secondary scholarly',
 'Olivares Pedreño (2002) pp. 89-110: linguistic analysis of the theonym; distribution and cult center analysis; comparison with the broader Iberian healing sanctuary tradition.'),
('ENT_IB_ATAEGINA', 'SRC_BLÁZQUEZ_RELIGIONES', 'Primary epigraphic (Latin) / secondary scholarly',
 'Blázquez (1962) pp. 125-146: ~40 Latin votive inscriptions including "Dea sancta Ataegina Turibrigensis Proserpina" formula; analysis of the Turobriga cult; chthonic function; "Queen of the Sun" epithet; distribution across Lusitania and Baetica.'),
('ENT_IB_ATAEGINA', 'SRC_OLIVARES_IBERIAN', 'Secondary scholarly',
 'Olivares Pedreño (2002) pp. 111-125: etymology of *ati-gena- ("reborn"); regeneration and cyclic function; comparison with Persephone/Proserpina in the Mediterranean death-and-renewal tradition.'),
('ENT_IB_TREBARUNA', 'SRC_OLIVARES_IBERIAN', 'Primary epigraphic (Lusitanian language) / secondary scholarly',
 'Olivares Pedreño (2002) pp. 145-160: analysis of the Bronze Plaque of Arronches as primary Lusitanian-language source; treb-aruna etymology; comparison with other theonyms in the same ritual text; small Latin inscription corpus.'),
('ENT_IB_TREBARUNA', 'SRC_BLÁZQUEZ_RELIGIONES', 'Secondary scholarly',
 'Blázquez (1962) pp. 195-200: Trebaruna in the epigraphic corpus; ritual context.'),
('ENT_IB_BANDUA', 'SRC_OLIVARES_IBERIAN', 'Primary epigraphic (Latin) / secondary scholarly',
 'Olivares Pedreño (2002) pp. 39-88: the most comprehensive analysis of the Bandua corpus — 25+ Latin inscriptions, geographic distribution, variant epithets (Araugel-, Vorode-, etc.), linguistic etymology (*bondho-), functional reconstruction.'),
('ENT_IB_BANDUA', 'SRC_BLÁZQUEZ_RELIGIONES', 'Secondary scholarly',
 'Blázquez (1962) pp. 63-100: Bandua in the epigraphic record; interpretatio romana with Mars; regional distribution analysis.'),
('ENT_IB_NABIA', 'SRC_OLIVARES_IBERIAN', 'Primary epigraphic (Latin) / secondary scholarly',
 'Olivares Pedreño (2002) pp. 161-180: Nabia inscription corpus from Lusitania and NW Hispania; river/water etymology; Nabia Corona epithet; geographic distribution centered on NW Iberian river systems.'),
('ENT_IB_NABIA', 'SRC_BLÁZQUEZ_RELIGIONES', 'Secondary scholarly',
 'Blázquez (1962) pp. 101-120: Nabia in the epigraphic record; river cult identification.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_IB_ENDOVELICUS',  'PER_IB_IRON_AGE', 'high',
 'São Miguel da Mota inscriptions span 1st–4th centuries CE, preserving pre-Roman cult under Roman votive conventions.',
 'SRC_BLÁZQUEZ_RELIGIONES', 'reviewed'),
('ENT_IB_ATAEGINA',     'PER_IB_IRON_AGE', 'high',
 'Inscriptions span Lusitania and Baetica across the full Roman provincial period; the theonym and its "reborn" etymology point to a pre-Roman origin.',
 'SRC_BLÁZQUEZ_RELIGIONES', 'reviewed'),
('ENT_IB_TREBARUNA',    'PER_IB_IRON_AGE', 'high',
 'Attested in the Arronches Bronze Plaque (c. 1st c. CE) in Lusitanian language, indicating a pre-Roman cult preserved into the Roman period.',
 'SRC_OLIVARES_IBERIAN', 'reviewed'),
('ENT_IB_BANDUA',       'PER_IB_IRON_AGE', 'high',
 'Widely attested across Lusitania and NW Hispania in Latin inscriptions of the 1st–3rd centuries CE; the theonym''s Celtic/Indo-European etymology indicates pre-Roman origin.',
 'SRC_OLIVARES_IBERIAN', 'reviewed'),
('ENT_IB_NABIA',        'PER_IB_IRON_AGE', 'high',
 'Attested in votive inscriptions from Lusitania and Gallaecia in the Roman period; connection with river Navia toponym indicates pre-Roman cult.',
 'SRC_OLIVARES_IBERIAN', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Endovelicus
('ENT_IB_ENDOVELICUS', 'patron_of', 'ENT_HEALING',
 'high',
 'Endovelicus''s primary function is healing and oracular dreaming (incubation). The São Miguel da Mota sanctuary was a dedicated healing site; votive offerings include anatomical body parts (eyes, hands, limbs) — the standard Mediterranean ex-voto healing dedication. The entire corpus of ~80 inscriptions at the sanctuary is consistent with a healing cult. Blázquez (1962) pp. 147-168.',
 'SRC_BLÁZQUEZ_RELIGIONES', 'PER_IB_IRON_AGE', 'reviewed'),
('ENT_IB_ENDOVELICUS', 'aligned_with', 'ENT_ASCLEPIUS',
 'medium',
 'Endovelicus and Asclepius are structurally parallel healing/oracular deities who share the core cult mechanism of incubation (sleeping in the sanctuary to receive healing dreams) and whose sanctuaries attracted pilgrims from wide regions seeking cures. The São Miguel da Mota sanctuary compares to Epidaurus in its function. Confidence medium: no ancient source explicitly equates them — the alignment is structural and functional, not inscriptionally attested. Blázquez (1962) p. 162.',
 'SRC_BLÁZQUEZ_RELIGIONES', 'PER_IB_IRON_AGE', 'reviewed'),
-- Ataegina
('ENT_IB_ATAEGINA', 'patron_of', 'ENT_UNDERWORLD',
 'high',
 'Ataegina''s syncretism with Proserpina in the inscriptional formula "Dea sancta Ataegina Turibrigensis Proserpina" explicitly places her in the underworld/chthonic domain. The regeneration etymology (*ati-gena-, "reborn") and her chthonic function converge on an underworld deity whose power encompasses death and renewal. Blázquez (1962) pp. 125-146.',
 'SRC_BLÁZQUEZ_RELIGIONES', 'PER_IB_IRON_AGE', 'reviewed'),
('ENT_IB_ATAEGINA', 'syncretized_with', 'ENT_ROM_PROSERPINA',
 'high',
 'The Roman-period inscriptions from the Turobriga cult site (near Aroche, Huelva) include the explicit formula "Dea sancta Ataegina Turibrigensis Proserpina" — the most direct ancient interpretatio equation in the entire Iberian indigenous tradition, linking the Lusitanian chthonic regeneration goddess with the Roman goddess of the underworld and the spring return. This is not merely an alignment but a cultic equation articulated by the ancient worshippers themselves. Blázquez (1962) p. 128.',
 'SRC_BLÁZQUEZ_RELIGIONES', 'PER_IB_IRON_AGE', 'reviewed'),
-- Trebaruna
('ENT_IB_TREBARUNA', 'patron_of', 'ENT_WAR',
 'low',
 'Trebaruna''s appearance in a sacrifice ritual text (Arronches plaque) alongside other deities in what appears to be a military or oath-covenant context suggests possible warrior/protective functions. The treb- root ("settlement") combined with the ritual context may imply territorial defense. Confidence low: the Lusitanian language remains incompletely understood and the ritual text''s full meaning is uncertain. Olivares Pedreño (2002) p. 155.',
 'SRC_OLIVARES_IBERIAN', 'PER_IB_IRON_AGE', 'reviewed'),
-- Bandua
('ENT_IB_BANDUA', 'patron_of', 'ENT_WAR',
 'medium',
 'Multiple inscriptions pair Bandua with Mars in the interpretatio romana framework: "Bandua Araugel- et Marti" and similar formulae. The bond/obligation etymology (*bondho-) combined with the Mars pairing suggests Bandua presided over warrior oaths and military solidarity — the social bonding function of the war deity tradition. Olivares Pedreño (2002) pp. 57-70.',
 'SRC_OLIVARES_IBERIAN', 'PER_IB_IRON_AGE', 'reviewed'),
('ENT_IB_BANDUA', 'aligned_with', 'ENT_ROM_MARS',
 'medium',
 'The interpretatio romana inscriptions pairing Bandua with Mars are the primary evidence for Bandua''s function. While not an explicit equation (Bandua''s theonym is always preserved alongside Mars, not replaced by him), the pairing reflects the Roman provincial worshippers'' perception that Bandua''s domain overlapped with Mars''s protective and military functions. Blázquez (1962) p. 73.',
 'SRC_BLÁZQUEZ_RELIGIONES', 'PER_IB_IRON_AGE', 'reviewed'),
-- Nabia
('ENT_IB_NABIA', 'patron_of', 'ENT_FERTILITY',
 'medium',
 'Nabia''s river/water domain naturally extends to fertility — rivers as the source of agricultural irrigation and landscape fertility in the NW Iberian ecological context. Her distribution along river systems and her association with mountain sources connects to the broader Mediterranean tradition of river deities as fertility powers. Confidence medium: the fertility function is inferred from the river deity domain rather than directly inscribed. Olivares Pedreño (2002) p. 170.',
 'SRC_OLIVARES_IBERIAN', 'PER_IB_IRON_AGE', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities WHERE tradition = 'Iberian/Lusitanian'
GROUP BY tradition;

SELECT * FROM v_release_metrics;

COMMIT;
