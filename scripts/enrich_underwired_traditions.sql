-- =====================================================================
-- enrich_underwired_traditions.sql  (v1.60.0)
-- Connectivity pass (audit-driven): the traditions expanded in v1.59.0 (and
-- some pre-existing nodes) were under-wired — Roman 1.27, Etruscan 1.26,
-- Gaulish 1.27, Phoenician 1.33, Welsh 1.49 edges/entity (healthy ~1.8-2.5),
-- leaving many near-isolated nodes invisible to the comparative views.
-- This adds MEANINGFUL typed edges (interpretatio/embodies/family/triad/
-- domain/healing patronage) — no new entities — and fixes 2 stray ref-only
-- sources (Ogmios, Andraste) with their real primary attestations.
-- ON CONFLICT DO NOTHING; verify block at end.
-- =====================================================================
BEGIN;

-- --- 2 new primary sources for the ref-only fix ---
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_LUCIAN_HERACLES','Lucian of Samosata, Heracles (the "Ogmios" prologue), c. 2nd c. CE',NULL,'primary text','Gaulish Ogmios'),
 ('SRC_CASSIUS_DIO','Cassius Dio, Roman History, c. 3rd c. CE',NULL,'primary text','Roman/Romano-British history')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_CEL_OGMIOS','SRC_LUCIAN_HERACLES','direct attestation','Lucian, Heracles 1-6 (the Gaulish Heracles "Ogmios" of eloquence).'),
 ('ENT_BRI_ANDRASTE','SRC_CASSIUS_DIO','direct attestation','Cassius Dio, Roman History 62.6-7 (Boudica''s invocation of Andraste).')
ON CONFLICT (entity_id, source_id, evidence_type) DO NOTHING;

-- ============================ ROMAN ============================
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
-- major-god interpretatio (Greek)
 ('ENT_ROM_VULCAN','syncretized_with','ENT_HEPHAESTUS','high','Vulcan is the Roman Hephaestus.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_NEPTUNE','syncretized_with','ENT_POSEIDON','high','Neptune is the Roman Poseidon.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_PLUTO','syncretized_with','ENT_HADES','high','Pluto/Dis Pater is the Roman Hades.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_BACCHUS','syncretized_with','ENT_DIONYSUS','high','Bacchus/Liber is the Roman Dionysus.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_VESTA','syncretized_with','ENT_HESTIA','high','Vesta is the Roman Hestia.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_TELLUS','syncretized_with','ENT_GAIA','high','Tellus is the Roman Gaia/Earth.','SRC_WISSOWA_RKR','reviewed'),
-- deified-virtue interpretatio
 ('ENT_ROM_CONCORDIA','syncretized_with','ENT_HOMONOIA','high','Concordia is the Roman Homonoia (civic concord).','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_PAX','syncretized_with','ENT_EIRENE','high','Pax is the Roman Eirene (peace).','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_SPES','syncretized_with','ENT_ELPIS','high','Spes is the Roman Elpis (hope).','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_SALUS','syncretized_with','ENT_HYGIEIA','high','Salus is the Roman Hygieia (health/welfare).','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_FORTUNA','syncretized_with','ENT_TYCHE','high','Fortuna is the Roman Tyche (fortune).','SRC_WISSOWA_RKR','reviewed'),
-- virtues/elements embody their abstraction
 ('ENT_ROM_FORTUNA','embodies','ENT_FORTUNE','high','Fortuna personifies fortune.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_TELLUS','embodies','ENT_EARTH','high','Tellus personifies the earth.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_VESTA','embodies','ENT_FIRE','high','Vesta is the sacred hearth-fire.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_VULCAN','embodies','ENT_FIRE','high','Vulcan is destructive and forge fire.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_VIRTUS','embodies','ENT_WAR','medium','Virtus personifies martial valour.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_FERONIA','embodies','ENT_FERTILITY','medium','Feronia, goddess of wild fertility.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_MUTUNUS','embodies','ENT_FERTILITY','high','Mutunus Tutunus, phallic god of fertility.','SRC_WISSOWA_RKR','reviewed'),
-- chthonic
 ('ENT_ROM_PLUTO','rules','ENT_UNDERWORLD','high','Pluto/Dis Pater rules the underworld.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_PLUTO','embodies','ENT_WEALTH','medium','Dis Pater ("the rich one"), god of underground wealth.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_VEIOVIS','dwells_in','ENT_UNDERWORLD','medium','Veiovis, a chthonic "anti-Jupiter".','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_LAVERNA','dwells_in','ENT_UNDERWORLD','medium','Laverna, chthonic goddess of thieves.','SRC_WISSOWA_RKR','reviewed'),
-- pairings / family
 ('ENT_ROM_VERTUMNUS','consort_of','ENT_ROM_POMONA','high','Vertumnus and Pomona, the classic orchard-deity couple.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_VERTUMNUS','reception_of','ENT_ETR_VOLTUMNA','high','Vertumnus is the Roman reception of the Etruscan Voltumna.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_MUTUNUS','syncretized_with','ENT_PRIAPUS','medium','Mutunus Tutunus, an old Roman counterpart of Priapus.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_PENATES','paired_with','ENT_ROM_LARES','high','The Penates and Lares, the paired household protective powers.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_FONS','child_of','ENT_ROM_JANUS','medium','Fons, the spring-god son of Janus (Arnobius).','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_FIDES','aligned_with','ENT_ROM_SEMO_SANCUS','medium','Fides (good faith) and Semo Sancus/Dius Fidius (oaths) share the sphere of sworn faith.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_VICA_POTA','aligned_with','ENT_ROM_VICTORIA','high','Vica Pota, the archaic precursor of Victoria.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_PORTUNUS','paired_with','ENT_ROM_JANUS','medium','Portunus (gates, keys) shares Janus''s sphere of doors and passages.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_PILUMNUS','opposes','ENT_ITA_SILVANUS','medium','Pilumnus wards the woodland spirit Silvanus from the newborn child (Servius).','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_DIVUS_JULIUS','aligned_with','ENT_ROM_DIVUS_AUGUSTUS','high','The deified Julius and Augustus, founders of the imperial cult.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_ROMA','aligned_with','ENT_ROM_DIVUS_AUGUSTUS','medium','Roma and Augustus, paired in the imperial cult of Roma et Augustus.','SRC_WISSOWA_RKR','reviewed'),
-- domain edges: agricultural gods -> Agriculture (also populates comparative-domains)
 ('ENT_ROM_VERVACTOR','patron_of','ENT_AGRICULTURE','high','God of the first ploughing.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_REPARATOR','patron_of','ENT_AGRICULTURE','high','God of the second ploughing.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_IMPORCITOR','patron_of','ENT_AGRICULTURE','high','God of ridging the field.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_INSITOR','patron_of','ENT_AGRICULTURE','high','God of sowing.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_OBARATOR','patron_of','ENT_AGRICULTURE','high','God of ploughing over the seed.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_OCCATOR','patron_of','ENT_AGRICULTURE','high','God of harrowing.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_SARRITOR','patron_of','ENT_AGRICULTURE','high','God of hoeing.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_SUBRUNCINATOR','patron_of','ENT_AGRICULTURE','high','God of weeding.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_MESSOR','patron_of','ENT_AGRICULTURE','high','God of reaping.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_CONVECTOR','patron_of','ENT_AGRICULTURE','high','God of carting in the harvest.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_CONDITOR','patron_of','ENT_AGRICULTURE','high','God of storing the grain.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_PROMITOR','patron_of','ENT_AGRICULTURE','high','God of distributing stored grain.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_SEGETIA','patron_of','ENT_AGRICULTURE','high','Goddess of the standing crop.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_TUTILINA','patron_of','ENT_AGRICULTURE','high','Goddess of stored grain.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_ROBIGUS','patron_of','ENT_AGRICULTURE','high','Averter of wheat-rust.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_STERCULIUS','patron_of','ENT_AGRICULTURE','high','God of manuring the fields.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_DEA_DIA','patron_of','ENT_AGRICULTURE','high','Arval agrarian goddess of crop-growth.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_CONSUS','patron_of','ENT_AGRICULTURE','high','God of the grain-store.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_PALES','patron_of','ENT_AGRICULTURE','medium','Pastoral deity of flocks and herding.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_POMONA','patron_of','ENT_AGRICULTURE','high','Goddess of fruit trees and orchards.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_PICUMNUS','patron_of','ENT_AGRICULTURE','medium','God of the manuring and fertility of fields.','SRC_WISSOWA_RKR','reviewed'),
-- birth indigitamenta under Juno Lucina's sphere
 ('ENT_ROM_VAGITANUS','presided_over_by','ENT_ROM_JUNO','medium','Birth-godling in the sphere of Juno Lucina.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_CUNINA','presided_over_by','ENT_ROM_JUNO','medium','Cradle-godling in the sphere of Juno Lucina.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_RUMINA','presided_over_by','ENT_ROM_JUNO','medium','Suckling-goddess in the sphere of Juno Lucina.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_LEVANA','presided_over_by','ENT_ROM_JUNO','medium','Birth-acknowledgement goddess in Juno''s sphere.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_NUNDINA','presided_over_by','ENT_ROM_JUNO','medium','Naming-day goddess in Juno''s sphere.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_EDUSA','presided_over_by','ENT_ROM_JUNO','low','Child-feeding godling in Juno''s sphere.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_POTINA','presided_over_by','ENT_ROM_JUNO','low','Child-drinking godling in Juno''s sphere.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed')
ON CONFLICT DO NOTHING;

-- ============================ ETRUSCAN ============================
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_ETR_LARAN','syncretized_with','ENT_ARES','high','Laran is the Etruscan Ares/Mars.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_LARAN','embodies','ENT_WAR','high','Laran personifies war.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_CEL','syncretized_with','ENT_GAIA','medium','Cel, the Etruscan earth-mother.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_CEL','embodies','ENT_EARTH','high','Cel personifies the earth.','SRC_LIVER_PIACENZA','reviewed'),
 ('ENT_ETR_CATHA','embodies','ENT_SUN','medium','Catha, a solar/light deity.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_SETHLANS','embodies','ENT_FIRE','high','Sethlans, the smith-god of the forge-fire.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_ARTUMES','paired_with','ENT_ETR_APLU','high','Artumes and Aplu, the Etruscan Artemis-Apollo pair.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_VANTH','dwells_in','ENT_UNDERWORLD','high','Vanth, psychopomp of the underworld.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_CULSU','dwells_in','ENT_UNDERWORLD','high','Culsu, underworld gate-demon.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_CULSU','paired_with','ENT_ETR_VANTH','medium','Culsu and Vanth, the female underworld attendants.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_CULSANS','aligned_with','ENT_ROM_JANUS','high','Culsans, the two-faced gate-god, counterpart of Janus.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_VETIS','dwells_in','ENT_UNDERWORLD','medium','Vetis, a chthonic underworld deity.','SRC_LIVER_PIACENZA','reviewed'),
 ('ENT_ETR_VETIS','aligned_with','ENT_ROM_VEIOVIS','medium','Vetis corresponds to the Roman Veiovis.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_MANTUS','rules','ENT_UNDERWORLD','high','Mantus, underworld god.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_MANTUS','aligned_with','ENT_ETR_AITA','medium','Mantus, an underworld god akin to Aita.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_THALNA','paired_with','ENT_ETR_THANR','medium','Thalna and Thanr, the birth-goddesses of the mirror scenes.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_LASA','associated_ritual','ENT_ETR_TURAN','low','The Lasas, attendant spirits of Turan.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_MARIS','member_of','ENT_ETR_TINIA','low','Maris, of the Etruscan pantheon headed by Tinia.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
 ('ENT_ETR_CILENS','member_of','ENT_ETR_TINIA','low','Cilens, of the Liver pantheon under Tinia.','SRC_LIVER_PIACENZA','reviewed'),
 ('ENT_ETR_SELVANS','embodies','ENT_EARTH','low','Selvans, god of woodlands and boundaries of the land.','SRC_DEGRUMMOND_ETRUSCAN','reviewed')
ON CONFLICT DO NOTHING;

-- ============================ GAULISH / BRITISH ============================
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_CEL_ESUS','paired_with','ENT_CEL_TARANIS','high','Esus, Taranis and Teutates, the Gaulish triad of Lucan.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_TEUTATES','paired_with','ENT_CEL_TARANIS','high','Teutates, of the Lucan Gaulish triad.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_BELENUS','embodies','ENT_SUN','medium','Belenus, a god of light/the sun.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_SEQUANA','patron_of','ENT_HEALING','high','Sequana, healing goddess of the Seine source.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_LITAVIS','embodies','ENT_EARTH','high','Litavis, "the Broad One," an earth-goddess.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_CATHUBODUA','embodies','ENT_WAR','high','Cathubodua, a battle-crow war-goddess.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_CATHUBODUA','aligned_with','ENT_CEL_BADB','medium','Cathubodua, linguistic cognate of Irish Badb.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_CAMULOS','embodies','ENT_WAR','high','Camulos, a war-god.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_SMERTRIOS','embodies','ENT_WAR','medium','Smertrios, a warrior serpent-slaying god.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_VOSEGUS','syncretized_with','ENT_ITA_SILVANUS','medium','Vosegus worshipped as Silvanus Vosegus.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_LENUS','patron_of','ENT_HEALING','high','Lenus Mars, a healing god.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_OGMIOS','embodies','ENT_WISDOM','medium','Ogmios, god of the binding power of eloquence.','SRC_LUCIAN_HERACLES','reviewed'),
 ('ENT_BRI_ANDRASTE','embodies','ENT_WAR','high','Andraste, war-goddess invoked by Boudica.','SRC_CASSIUS_DIO','reviewed'),
 ('ENT_CEL_BELENUS','patron_of','ENT_HEALING','medium','Belenus, a healing god of springs.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_BRI_NODENS','patron_of','ENT_HEALING','high','Nodens, healing god of the Lydney Park temple (incubation cult).','SRC_RIB','reviewed'),
 ('ENT_BRI_SULIS','patron_of','ENT_HEALING','high','Sulis, healing goddess of the hot springs of Bath.','SRC_RIB','reviewed'),
 ('ENT_BRI_COVENTINA','patron_of','ENT_HEALING','medium','Coventina, goddess of the sacred healing well at Carrawburgh.','SRC_RIB','reviewed'),
 ('ENT_BRI_COVENTINA','embodies','ENT_WATER','medium','Coventina personifies the sacred well-waters.','SRC_RIB','reviewed'),
 ('ENT_BRI_COCIDIUS','embodies','ENT_WAR','high','Cocidius, a war and hunting god.','SRC_RIB','reviewed'),
 ('ENT_BRI_BELATUCADROS','embodies','ENT_WAR','high','Belatucadros, a war-god of the northern frontier.','SRC_RIB','reviewed'),
 ('ENT_BRI_VINOTONUS','syncretized_with','ENT_ITA_SILVANUS','high','Vinotonus worshipped as Silvanus Vinotonus.','SRC_RIB','reviewed'),
 ('ENT_BRI_ANTENOCITICUS','patron_of','ENT_WAR','low','Antenociticus, invoked at Benwell for military advancement.','SRC_RIB','reviewed')
ON CONFLICT DO NOTHING;

-- ============================ IRISH ============================
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_CEL_NEMAIN','embodies','ENT_WAR','high','Nemain, goddess of the frenzy of war.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_NEIT','embodies','ENT_WAR','high','Néit, an ancient war-god.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_DANU','embodies','ENT_FERTILITY','medium','Danu/Anu, ancestral goddess of prosperity and the land.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_DONN','embodies','ENT_DEATH','high','Donn, god of the dead, who gathers the dead to Tech Duinn.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_DONN','dwells_in','ENT_UNDERWORLD','high','Donn rules Tech Duinn, the house of the dead.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_TETHRA','dwells_in','ENT_UNDERWORLD','medium','Tethra, Fomorian ruler of the dead in Mag Mell.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_BODBDERG','rules','ENT_CEL_TUATHA','high','Bodb Derg, elected king of the Tuatha Dé Danann.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_CREDNE','paired_with','ENT_CEL_GOIBNIU','high','Credne, of the three craft-gods (trí dé Dána) with Goibniu.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_LUCHTA','paired_with','ENT_CEL_GOIBNIU','high','Luchta, of the three craft-gods with Goibniu.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_FLIDAIS','embodies','ENT_FERTILITY','medium','Flidais, goddess of cattle and wild abundance.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_FLIDAIS','parent_of','ENT_CEL_FAND','medium','Flidais, mother of Fand (Metrical Dindshenchas).','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_AINE','embodies','ENT_FERTILITY','medium','Áine, goddess of summer, sovereignty and prosperity.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_CLIODHNA','aligned_with','ENT_CEL_AINE','medium','Clíodhna and Áine, Munster sovereignty goddesses.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_ETAIN','member_of','ENT_CEL_TUATHA','medium','Étaín, of the Tuatha Dé Danann.','SRC_MACKILLOP_CELTIC','reviewed')
ON CONFLICT DO NOTHING;

-- ============================ WELSH ============================
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_WEL_MODRON','reception_of','ENT_CEL_MATRES','medium','Modron derives from the Gaulish Matrona/Matres.','SRC_TRIADS_BROMWICH','reviewed'),
 ('ENT_WEL_AMAETHON','patron_of','ENT_AGRICULTURE','high','Amaethon, "the Great Ploughman," god of agriculture.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_CREIDDYLAD','consort_of','ENT_WEL_GWYTHYR','high','Creiddylad, betrothed of Gwythyr.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_LLWYD','imprisons','ENT_WEL_PRYDERI','high','Llwyd ap Cil Coed imprisons Pryderi and Rhiannon (Third Branch).','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_LLWYD','imprisons','ENT_WEL_RHIANNON','high','Llwyd imprisons Rhiannon to avenge Gwawl.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_OLWEN','embodies','ENT_FERTILITY','medium','Olwen, in whose footsteps white trefoils spring (a fertility motif).','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_BELI_MAWR','parent_of','ENT_WEL_GWYN_AP_NUDD','low','Beli Mawr, ancestor of the line of Nudd/Lludd.','SRC_TRIADS_BROMWICH','reviewed'),
 ('ENT_WEL_TEGID_FOEL','parent_of','ENT_WEL_MORFRAN','high','Tegid Foel, father of Morfran by Ceridwen.','SRC_MABINOGION','reviewed'),
 ('ENT_WEL_TEGID_FOEL','parent_of','ENT_WEL_CREIRWY','high','Tegid Foel, father of Creirwy by Ceridwen.','SRC_MABINOGION','reviewed')
ON CONFLICT DO NOTHING;

-- ============================ PHOENICIAN ============================
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_PHO_BAALAT_GEBAL','aligned_with','ENT_CAN_ASTARTE','medium','Baalat Gebal, the Lady of Byblos, akin to Astarte.','SRC_KAI','reviewed'),
 ('ENT_PHO_SHADRAPA','patron_of','ENT_HEALING','high','Shadrapa, "Shed has healed," a healing god.','SRC_KAI','reviewed'),
 ('ENT_PHO_SID','embodies','ENT_WAR','medium','Sid, a hunt and war god.','SRC_KAI','reviewed'),
 ('ENT_PHO_SAKON','aligned_with','ENT_HERMES','low','Sakon, an obscure deity tentatively equated with Hermes.','SRC_PHILO_BYBLOS','reviewed'),
 ('ENT_PHO_BAAL_SHAMEM','aligned_with','ENT_CAN_BAAL','medium','Baal-Shamem, "Lord of Heaven," a supreme Baal.','SRC_PHILO_BYBLOS','reviewed')
ON CONFLICT DO NOTHING;

-- ============================ UGARITIC ============================
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_CAN_KOTHARAT','embodies','ENT_FERTILITY','medium','The Kotharat, divine midwives of conception and birth.','SRC_KTU','reviewed'),
 ('ENT_CAN_HORON','patron_of','ENT_HEALING','high','Horon, god of healing and protection from snakebite.','SRC_KTU','reviewed'),
 ('ENT_CAN_PIDRAY','sibling_of','ENT_CAN_TALLAY','high','Pidray and Tallay, daughters of Baal.','SRC_KTU','reviewed'),
 ('ENT_CAN_TALLAY','sibling_of','ENT_CAN_ARSAY','high','Tallay and Arsay, daughters of Baal.','SRC_KTU','reviewed'),
 ('ENT_CAN_PIDRAY','sibling_of','ENT_CAN_ARSAY','high','Pidray and Arsay, daughters of Baal.','SRC_KTU','reviewed')
ON CONFLICT DO NOTHING;

COMMIT;

-- ---- VERIFY ----
\echo '== edge density of the enriched traditions (target >= 1.8) =='
SELECT e.tradition, count(DISTINCT e.entity_id) AS n,
       round(count(DISTINCT r.ctid)::numeric / count(DISTINCT e.entity_id),2) AS edges_per_entity
FROM entities e LEFT JOIN entity_relationships r ON r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id
WHERE e.tradition IN ('Roman','Etruscan','Celtic/Gaulish','Celtic/British','Celtic/Irish','Celtic/Welsh','Phoenician','Canaanite/Ugaritic')
GROUP BY e.tradition ORDER BY edges_per_entity;
\echo '== remaining ref-only outside Cross-traditional/Greek (expect 0) =='
WITH src AS (SELECT e.entity_id, e.tradition, bool_or(s.source_type IN ('primary text','secondary scholarship','primary inscription/artifact','heresiological source')) AS hg FROM entities e JOIN entity_sources es ON es.entity_id=e.entity_id JOIN sources s ON s.source_id=es.source_id GROUP BY 1,2)
SELECT count(*) FROM src WHERE NOT hg AND tradition NOT IN ('Cross-traditional','Greek');
\echo '== integrity (expect 0/0/0/0) =='
SELECT (SELECT unreviewed_duplicates FROM v_release_metrics) ud, (SELECT unresolved_relationships FROM v_release_metrics) ur,
       (SELECT count(*) FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id)) unsourced,
       (SELECT count(*) FROM (SELECT entity_id,source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d) dup_pairs;
