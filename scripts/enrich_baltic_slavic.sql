-- scripts/enrich_baltic_slavic.sql
-- Enrichment (v1.24.0): the two thinnest traditions, Baltic (1.30 edges/entity) and
-- Slavic (1.44), both cognate Indo-European. Adds source-backed domain links (which
-- also surface these gods in v_public_comparative_domains) and a few cognate cross-links.
-- All typed, all sourced; reuses existing sources. No new entities, no new sources.
--
-- Sources: SRC_GIMBUTAS_BALTS (Gimbutas, The Balts), SRC_GREIMAS_LITHUANIAN (Greimas,
-- Of Gods and Men), SRC_BRUCKNER_SLAVIC_MYTH (Brückner, Mitologia Słowiańska),
-- SRC_PRIMARY_CHRONICLE_PVL (Primary Chronicle / 980 Kiev pantheon).

BEGIN;

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
VALUES
-- ── Baltic ───────────────────────────────────────────────────────────────────
('ENT_BALT_SAULE','embodies','ENT_SUN','high',
 'Saulė is the Baltic sun goddess, among the most prominent deities of the pantheon, central to the daina song-tradition and the celestial-wedding myth.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_MENESS','embodies','ENT_MOON','high',
 'Mēness is the Baltic moon deity, husband of Saulė in the celestial-marriage myth; his infidelity and Perkūnas''s punishment explain the lunar phases.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_PERKUNAS','embodies','ENT_STORM','high',
 'Perkūnas is the Baltic thunder/storm god (Lith. Perkūnas, Latv. Pērkons), the cognate of Slavic Perun and the Indo-European thunder deity.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_PERKUNAS','patron_of','ENT_JUSTICE','medium',
 'Perkūnas enforces oaths and moral order, striking the unrighteous; he punishes Mēness for infidelity, a juridical-moral function emphasised in Lithuanian sources.','SRC_GREIMAS_LITHUANIAN','reviewed'),
('ENT_BALT_LAIMA','embodies','ENT_FATE','high',
 'Laima is the Baltic goddess of fate and fortune (Lith./Latv. Laima, from laimė, luck), determining destiny and presiding over birth.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_ZEMYNA','patron_of','ENT_FERTILITY','high',
 'Žemyna is the Baltic earth goddess (from žemė, earth), patroness of agricultural fertility and recipient of the first libations.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_VELNIAS','dwells_in','ENT_UNDERWORLD','high',
 'Velnias is the Baltic chthonic deity dwelling below; lord of the dead and cattle, pursued across the sky by Perkūnas in the storm-myth.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_VELNIAS','patron_of','ENT_MAGIC','medium',
 'Velnias is associated with magic, cattle, and the dead — the structural counterpart of Slavic Veles, with whom he is aligned.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_DIEVAS','patron_of','ENT_SOVEREIGNTY','high',
 'Dievas is the supreme Baltic sky god (cognate of Dyaus/Zeus), head of the pantheon and source of cosmic and social order.','SRC_GIMBUTAS_BALTS','reviewed'),
('ENT_BALT_MEDEINA','patron_of','ENT_ANIMALS','medium',
 'Medeina is the Baltic forest goddess (from medis, tree/forest), mistress of the woodland and protector of its beasts and the hunt.','SRC_GREIMAS_LITHUANIAN','reviewed'),
('ENT_BALT_SAULE','aligned_with','ENT_HELIOS','medium',
 'Saulė is the Baltic reflex of the Indo-European sun deity (PIE *seh2ul-), structurally parallel to Greek Helios as a solar driver across the sky.','SRC_GIMBUTAS_BALTS','reviewed'),

-- ── Slavic ───────────────────────────────────────────────────────────────────
('ENT_SLAV_PERUN','patron_of','ENT_SOVEREIGNTY','high',
 'Perun heads the 980 CE Kievan pantheon of Vladimir (Primary Chronicle); supreme thunder-god and patron of the prince and druzhina, the sovereign deity of the East Slavs.','SRC_PRIMARY_CHRONICLE_PVL','reviewed'),
('ENT_SLAV_VELES','dwells_in','ENT_UNDERWORLD','high',
 'Veles is the Slavic chthonic god, lord of the underworld, cattle, and the dead; his opposition to the celestial Perun is the core of the Slavic "basic myth".','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_VELES','patron_of','ENT_MAGIC','high',
 'Veles is the god of magic, oaths, poetry, and cattle-wealth; oaths in the Rus''–Byzantine treaties are sworn by Perun and Veles.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_DAZBOG','embodies','ENT_SUN','high',
 'Dažbog is a Slavic solar deity of the 980 Kiev pantheon; the Hypatian gloss names him son of Svarog and a giver of the sun''s light and bounty.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_DAZBOG','patron_of','ENT_WEALTH','medium',
 'Dažbog (from dati, to give) is the "giving god", dispenser of fortune and material bounty; the Slavs are called "Dažbog''s grandsons" in the Lay of Igor.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_KHORS','embodies','ENT_SUN','high',
 'Khors is a solar deity of the 980 Kiev pantheon (Primary Chronicle), likely the personified sun-disk; an Iranian-derived counterpart to Dažbog''s solar power.','SRC_PRIMARY_CHRONICLE_PVL','reviewed'),
('ENT_SLAV_STRIBOG','embodies','ENT_WIND','high',
 'Stribog is the Slavic wind deity of the 980 Kiev pantheon; the Lay of Igor calls the winds "Stribog''s grandsons" blowing from the sea.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_MOKOSH','embodies','ENT_FATE','high',
 'Mokosh, the only goddess in the 980 Kiev pantheon, governs spinning, weaving, and women''s fate — the thread-spinning fate function of the Slavic tradition.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_MOKOSH','patron_of','ENT_FERTILITY','high',
 'Mokosh (Mat'' Syra Zemlya, "Moist Mother Earth") is patroness of earth-fertility, moisture, and women''s work.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_SVAROG','patron_of','ENT_CRAFT','high',
 'Svarog is the Slavic celestial smith and god of fire and metalworking; the Slavic translation of Malalas glosses him as the craftsman-god who taught smithing.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_ROD','patron_of','ENT_FATE','medium',
 'Rod, the ancestral birth-deity, is paired with the Rozhanitsy (fate-spinners) who allot each newborn''s destiny; condemned in Old Slavic ecclesiastical texts.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed'),
('ENT_SLAV_SVAROG','aligned_with','ENT_HEPHAESTUS','high',
 'The Slavic translation of the chronicle of John Malalas explicitly glosses Svarog with the Greek smith-god Hephaistos (and Dažbog with Helios), an attested medieval interpretatio.','SRC_BRUCKNER_SLAVIC_MYTH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
-- Edge density per enriched tradition (should rise well above the prior 1.3-1.4):
SELECT e.tradition,
       count(DISTINCT e.entity_id) AS entities,
       count(r.*) AS subj_edges,
       round(count(r.*)::numeric / count(DISTINCT e.entity_id), 2) AS edges_per_entity
FROM entities e
LEFT JOIN entity_relationships r ON r.subject_entity_id = e.entity_id
WHERE e.tradition IN ('Baltic','Slavic')
GROUP BY e.tradition ORDER BY e.tradition;

-- Invariants: 0 unsourced, 0 unresolved.
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT * FROM v_release_metrics;

COMMIT;
