-- scripts/add_finnish_layer.sql
-- Adds seven deities from Finnish/Kalevala tradition: Ukko, Väinämöinen, Ilmatar,
-- Tapio, Mielikki, Ahti, and Louhi.  Core sources are the 1849 Kalevala (oral
-- tradition compiled by Elias Lönnrot) and Mikael Agricola's 1551 Finnish Primer,
-- the earliest written attestation of Finnish deity names.
--
-- Primary sources by entity:
--   Ukko:         Kalevala Runo 2:323-328, 47; Agricola 1551 (named in deity list)
--   Väinämöinen:  Kalevala Runos 1-3, 5-11, 16-17, 26-30, 42-50
--   Ilmatar:      Kalevala Runo 1 (world-creation from the egg)
--   Tapio:        Kalevala Runos 14, 32, 46; Agricola 1551
--   Mielikki:     Kalevala Runos 14, 46 (invocations of the bear hunt)
--   Ahti/Ahto:    Kalevala Runos 6, 42-49; Agricola 1551
--   Louhi:        Kalevala Runos 5-8, 10-11, 30-38, 42-49

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_KALEVALA',
 'Elias Lönnrot, The Kalevala (Kalevala taikka vanhoja Karjalan runoja Suomen kansan muinosista ajoista), expanded edition 1849; trans. Keith Bosley (Oxford World''s Classics, Oxford University Press, 1989)',
 'primary literary',
 'The national epic of Finland, compiled by Elias Lönnrot from oral folk poetry (runo-songs) collected mainly from Karelia between 1828 and 1834, with an expanded edition in 1849 (50 cantos / runos, ~22,795 verses). The oral tradition underlying the Kalevala is far older, preserving pre-Christian Finnish and Karelian religious material; the earliest layer of the runo-song tradition is estimated to the Iron Age or earlier. The Kalevala is the primary source for Finnish mythology: it presents the creation of the world from a cosmic egg (Runo 1, Ilmatar), the shaman-bard Väinämöinen as the central culture hero, the forest deity Tapio and his wife Mielikki (Runo 14, 32, 46), the sea deity Ahti/Ahto (Runo 42-49), the thunder deity Ukko (Runo 2, 47), and the antagonist Louhi, mistress of the northern realm Pohjola (Runos 5-8, 10-11, 30-38, 42-49). Keith Bosley''s Oxford translation (1989) is the standard modern English edition. Primary citation for all Finnish entities in this layer.'),
('SRC_AGRICOLA_PRIMER',
 'Mikael Agricola, Se Wsi Testamenti (The New Testament) and Psalttari (Finnish Psalter), 1548/1551; deity list in the Psalter introduction (Rucouskiria, 1544)',
 'primary literary',
 'Mikael Agricola (c. 1510-1557), Bishop of Turku and father of written Finnish, included in the prologue to his 1551 Finnish Psalter translation a poetic catalogue of deities worshipped by the Häme (Tavastians) and Karelians — the earliest written attestation of Finnish deity names. The Häme list includes Ukko (thunder, crops), Tapio (forest game), Ahti (water, fish), Piru (evil spirits), Rauni (Ukko''s wife), Egres (beans/turnips), Kekri (harvest), and others. The Karelian list adds further deities. This is the single most important pre-Kalevala primary source for Finnish deity names, predating Lönnrot''s compilations by nearly three centuries and confirming that the Kalevala deities were historically worshipped. Cited here for Ukko, Tapio, and Ahti.'),
('SRC_PENTIKÄINEN_KALEVALA',
 'Juha Pentikäinen, Kalevala Mythology, trans. Ritva Poom (Indiana University Press, Bloomington IN, 1999)',
 'secondary scholarly',
 'Standard English-language scholarly monograph on Kalevala mythology and Finnish folk religion. Covers the mythological background, the oral tradition underlying the text, the structure and meaning of the principal myths, and the religious practices reflected in the runo-songs. Chapters address cosmogony (the Ilmatar/world-egg creation), shamanism (Väinämöinen as paradigmatic shaman), the cult of the forest (Tapio, Mielikki), the sea deity Ahti, the thunder deity Ukko, and the antagonist figure Louhi as mistress of Pohjola. Also covers bear cult (central to Mielikki), death rituals, and the relationship between Finnish folk religion and broader Uralic/Siberian shamanic traditions. Primary secondary citation for all Finnish entities in this layer.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_FINN_TRADITIONAL',
 'Finnish',
 'Finnish Traditional / Pre-Christian',
 -500, 1300,
 'Period of Finnish and Karelian pre-Christian religious practice, from the emergence of the Baltic Finnic culture group (c. 500 BCE) through the completion of formal Christianization (12th–14th centuries CE; Bishop Henry''s crusade in Finland c. 1155 CE; full Christianization of Karelia by c. 1300 CE). The religious traditions documented in the Kalevala oral poetry represent this period, though the surviving written attestation comes later: Mikael Agricola''s 1551 deity list is the earliest written primary source, and Elias Lönnrot''s 1835/1849 Kalevala compilations are the main documentary corpus. The oral runo-song tradition preserved in the Kalevala is estimated to reflect religious practices from the Iron Age through early medieval Finnish/Karelian culture. Pentikäinen (1999) is the standard scholarly reference for this period''s religious content.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_FINN_UKKO',
 'Ukko',
 'Finnish',
 'thunder god / sky father',
 'Thunder Deity',
 'thunder; rain; sky; crops; weather; harvest; lightning',
 'A',
 'Supreme deity and thunder god of the Finnish pantheon; name means "old man" (also cf. Estonian Uku, Sami Hovrengaellies). The most important deity in Finnish folk religion. Mikael Agricola''s 1551 Psalter is the earliest written attestation: Agricola lists Ukko as the first of the Häme (Tavastian) deities: "Ukko ruled weather and the air / and gave rain when summer was dry." The Kalevala invokes Ukko repeatedly as the highest divine authority — Runo 2:323-328 calls on him explicitly: "Ukko, thou of gods the highest" (Bosley trans.). He gives rain, controls storms, and governs the harvest. His wife is Akka or Rauni (the Rowan tree deity, possibly a loanword). Ukko is cognate with the Baltic thunder deity Perkūnas and the broader Indo-European thunder deity pattern (Thor/Perun/Zeus/Indra). Pentikäinen (1999) pp. 121-140.'),
('ENT_FINN_VAINAMOINEN',
 'Väinämöinen',
 'Finnish',
 'shaman-bard / culture hero / primordial sage',
 'Hero',
 'music; poetry; wisdom; shamanism; magic; creation; seas; kantele',
 'A',
 'The central figure of the Kalevala; eternal sage, primordial shaman, and culture hero of Finnish mythology. Son of Ilmatar, the air spirit who floated on the primordial sea. Väinämöinen spent 700 years in his mother''s womb before emerging as an already-old man with full wisdom. He is the greatest singer in the world — his kantele (Finnish harp, which he carves from a pike''s jaw) has magical power over nature and humans. The Kalevala''s main narrative follows Väinämöinen''s quest for the Sampo (a magical mill), his contests of wisdom and music, his descent to the realm of the dead (Tuonela) to retrieve knowledge, and his conflicts with the sorceress Louhi. He is a paradigmatic shaman figure in the tradition described by Eliade — capable of soul-journey, magical singing, and cosmogonic action. At the end of the Kalevala (Runo 50) he departs in his boat to a realm between sky and earth, promising to return when needed. Pentikäinen (1999) pp. 148-220; Kalevala Runos 1-3, 16-17, 26-30.'),
('ENT_FINN_ILMATAR',
 'Ilmatar',
 'Finnish',
 'air spirit / water mother / cosmogonic deity',
 'Primordial Deity',
 'air; water; creation; cosmogony; virgin mother; primordial sea',
 'A',
 'Cosmogonic deity of Finnish mythology; "Daughter of the Air" (Ilmatar = "air woman"). The Kalevala opens with her creation myth (Runo 1): Ilmatar, a virgin spirit of the air, descended to the primordial sea and lay floating on its surface. A teal (sea-duck) came to nest on her knee and laid seven eggs — six of gold, one of iron. When Ilmatar moved, the eggs fell and broke: the lower half of the eggshell became the earth, the upper half the vault of heaven, the yolk became the sun, the white became the moon, and the speckled fragments became the stars. Ilmatar then shaped the earth''s features with her hands. She carried Väinämöinen in her womb for 700 years before he was born into the sea. She is the primal mother of Finnish cosmogony, combining the functions of virgin cosmic deity and world-shaper. Also called Luonnotar ("Nature Woman") in some variants. Pentikäinen (1999) pp. 55-80; Kalevala Runo 1.'),
('ENT_FINN_TAPIO',
 'Tapio',
 'Finnish',
 'lord of the forest / hunting deity',
 'Nature Deity',
 'forest; hunting; game animals; wilderness; woodland abundance',
 'A',
 'Lord of the forest and patron of hunters in Finnish and Karelian folk religion. Rules the forest realm Tapiola (Finnish "Tapio''s domain" — the name survives in the Helsinki suburb Tapiola). Mikael Agricola''s 1551 Psalter includes Tapio in the Häme deity list: "Tapio [gave] forest birds and animals." Hunters invoked Tapio before entering the forest and made offerings to him to ensure game abundance. The Kalevala (Runo 14, 32, 46) includes invocations to Tapio for a successful hunt. Tapio is described with a beard of lichen and a hat of leaves, emerging from the forest like a forest spirit. His wife is Mielikki, who holds direct authority over the game animals, especially bears. Tapio embodies the forest not as hostile wilderness but as the domain of abundance and sustenance if approached with proper respect and ritual. Pentikäinen (1999) pp. 140-160; Agricola 1551.'),
('ENT_FINN_MIELIKKI',
 'Mielikki',
 'Finnish',
 'forest goddess / patroness of bears',
 'Nature Deity',
 'forest; bears; animals; healing; hunting; woodland abundance',
 'A',
 'Goddess of the forest and patroness of bears in Finnish and Karelian folk religion; wife of Tapio, co-ruler of the forest realm Tapiola. Bears occupy the highest sacred status in Finnish folk religion — they are "Otava" (the Great Bear), Tapio''s cattle — and Mielikki is their special protector and keeper. The bear hunt was a major ritual complex, and hunter invocations to Mielikki were essential for a successful bear kill and for the proper return of the bear''s spirit to Tapiola. Kalevala Runo 14 includes an extended invocation to Mielikki to release game from her forest storehouse: "O Mielikki, forest''s mistress, fair-faced mistress of the woodland" (Bosley trans., Runo 14:213). Also called Tellervo (her daughter) and Luonnotar in some variants. Mielikki''s name is connected to the Finnish word mieluinen ("pleasant, beloved"). Her healing aspects relate to the bear''s fat, used as medicine. Pentikäinen (1999) pp. 145-158.'),
('ENT_FINN_AHTI',
 'Ahti',
 'Finnish',
 'sea deity / lord of the waters',
 'Sea Deity',
 'sea; water; fish; fishing; underwater realm; rivers; lakes',
 'A',
 'Sea deity and lord of the waters in Finnish and Karelian folk religion; also called Ahto. Agricola''s 1551 Psalter names Ahti explicitly in the Häme deity list as the deity of water and fish: "Ahti gave fish and water creatures." He rules the underwater realm Ahtola from its palace on the sea floor. His wife is Vellamo ("the calm one"), who governs the surface of water and is described as a great fish-woman or mermaid. Fishermen made offerings to Ahti and invoked him before setting out. In the Kalevala (Runo 42-49), Ahti/Ahto appears in connection with the quest for the Sampo and the contest with Louhi. He is an ambiguous deity — generous when properly propitiated but dangerous and jealous of his waters. The name Ahti may connect to the Estonian and Finnic sea/water deity tradition (cf. Estonian Ahti). Pentikäinen (1999) pp. 105-120; Kalevala Runo 42.'),
('ENT_FINN_LOUHI',
 'Louhi',
 'Finnish',
 'shamanistic mistress of Pohjola',
 'Adversarial Being',
 'magic; shamanism; the North; Pohjola; cold; shape-shifting; obstruction',
 'A',
 'Mistress of Pohjola (the Far North, "the place of darkness"); the primary antagonist of the Kalevala. Louhi is a powerful shamanistic figure — "the gap-toothed crone of Pohjola" in Lönnrot''s text — who controls the resources of the North and drives the Kalevala''s main plot conflicts. Väinämöinen and Ilmarinen must negotiate with her for brides and for the Sampo (a magical mill that generates wealth); she demands the construction of the Sampo as bride-price (Runos 5-8, 10-11). When the heroes steal the Sampo back, Louhi pursues them as a great eagle-hawk and destroys the Sampo in the conflict (Runos 42-49). She can also spread plague and disease, and she steals the sun and moon, locking them in the mountain of Pohjola (Runo 47-49). Louhi is not a simple evil figure — she is a legitimate authority in her own domain, a mother protecting her daughters, and a formidable equal to Väinämöinen in magical power. As an adversarial shamanistic ruler she represents the hostile wilderness north of the Finnish homeland. Pentikäinen (1999) pp. 220-260.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
-- Ukko
('ENT_FINN_UKKO', 'SRC_AGRICOLA_PRIMER', 'Primary literary',
 'Agricola 1551 Psalter prologue: Ukko listed first among the Häme deities — "Ukko ruled weather and the air / and gave rain when summer was dry." Earliest written attestation of Ukko by name.'),
('ENT_FINN_UKKO', 'SRC_KALEVALA', 'Primary literary',
 'Kalevala Runo 2:323-328: "Ukko, thou of gods the highest"; Runo 47: Ukko is called to restore the stolen sun and moon; pervasive invocations throughout as the highest divine authority.'),
('ENT_FINN_UKKO', 'SRC_PENTIKÄINEN_KALEVALA', 'Secondary scholarly',
 'Pentikäinen (1999) pp. 121-140: Ukko as supreme thunder deity; cognate analysis with Baltic Perkūnas and Norse Thor; the rain-making and harvest-protection functions; decline of the cult under Christianization.'),
-- Väinämöinen
('ENT_FINN_VAINAMOINEN', 'SRC_KALEVALA', 'Primary literary',
 'Central figure of the Kalevala across Runos 1-3, 5-11, 16-17, 26-30, 42-50. His birth from Ilmatar (Runo 1-3), contest with Joukahainen (Runo 3), descent to Tuonela (Runo 16), creation of the kantele (Runo 40-41), and departure at the end (Runo 50) are core mythological events.'),
('ENT_FINN_VAINAMOINEN', 'SRC_PENTIKÄINEN_KALEVALA', 'Secondary scholarly',
 'Pentikäinen (1999) pp. 148-220: Väinämöinen as paradigmatic shaman-figure in Finnish tradition; the soul-journey motif (descent to Tuonela); shamanism and the kantele; comparison with Siberian shaman-hero traditions.'),
-- Ilmatar
('ENT_FINN_ILMATAR', 'SRC_KALEVALA', 'Primary literary',
 'Kalevala Runo 1 (the world-creation cosmogony): Ilmatar descends from the air to the primordial sea; the duck lays eggs on her knee; the eggs break and form the world from their fragments; Ilmatar shapes the earth. She carries Väinämöinen for 700 years (Runos 1-3).'),
('ENT_FINN_ILMATAR', 'SRC_PENTIKÄINEN_KALEVALA', 'Secondary scholarly',
 'Pentikäinen (1999) pp. 55-80: the cosmic egg creation myth and its Uralic parallels; Ilmatar as world-mother; the relationship to Estonian and Votic cosmogonic traditions; the motif of the virgin cosmic deity.'),
-- Tapio
('ENT_FINN_TAPIO', 'SRC_AGRICOLA_PRIMER', 'Primary literary',
 'Agricola 1551 Psalter prologue: Tapio named in the Häme deity list as the deity of forest game. Earliest written attestation of Tapio by name.'),
('ENT_FINN_TAPIO', 'SRC_KALEVALA', 'Primary literary',
 'Kalevala Runos 14, 32, 46: invocations to Tapio for successful hunting; description of the forest realm Tapiola; Tapio as the lord whose permission hunters must seek before entering the forest.'),
('ENT_FINN_TAPIO', 'SRC_PENTIKÄINEN_KALEVALA', 'Secondary scholarly',
 'Pentikäinen (1999) pp. 140-155: the Finnish hunter cult and its deities; Tapio and Mielikki as co-rulers of Tapiola; ritual invocations (pyyntiluvat, hunting permissions); the forest as sacred domain.'),
-- Mielikki
('ENT_FINN_MIELIKKI', 'SRC_KALEVALA', 'Primary literary',
 'Kalevala Runo 14:213 ff.: extended invocation to Mielikki — "O Mielikki, forest''s mistress, fair-faced mistress of the woodland" — asking her to open her forest storehouse of game. Also Runo 46 (bear-hunt invocations).'),
('ENT_FINN_MIELIKKI', 'SRC_PENTIKÄINEN_KALEVALA', 'Secondary scholarly',
 'Pentikäinen (1999) pp. 145-158: Mielikki as mistress of the bear and of game animals; the bear-hunt ritual complex; her healing function (bear fat as medicine); wife of Tapio in the Tapiola rulership.'),
-- Ahti
('ENT_FINN_AHTI', 'SRC_AGRICOLA_PRIMER', 'Primary literary',
 'Agricola 1551 Psalter prologue: Ahti named in the Häme deity list: "Ahti gave fish and water creatures." Earliest written attestation of Ahti by name.'),
('ENT_FINN_AHTI', 'SRC_KALEVALA', 'Primary literary',
 'Kalevala Runo 42-49: Ahti/Ahto and his wife Vellamo in the underwater realm Ahtola; the sea journey sequence; invocations of Ahti by fishermen. Also Runo 6 (Väinämöinen falls into Ahti''s sea).'),
('ENT_FINN_AHTI', 'SRC_PENTIKÄINEN_KALEVALA', 'Secondary scholarly',
 'Pentikäinen (1999) pp. 105-120: Ahti as water deity; the Ahtola underwater realm; Vellamo as co-ruler; the fisherman''s cult and ritual offerings; Finnic parallels in Estonian and Votic water deity traditions.'),
-- Louhi
('ENT_FINN_LOUHI', 'SRC_KALEVALA', 'Primary literary',
 'Kalevala Runos 5-8 (Väinämöinen arrives in Pohjola and negotiates the Sampo bride-price), 10-11 (Ilmarinen forges the Sampo for Louhi), 30-38 (the heroes steal the Sampo; Louhi pursues), 42-49 (Louhi steals sun and moon; Ukko restores them). The most plot-active deity in the Kalevala after Väinämöinen.'),
('ENT_FINN_LOUHI', 'SRC_PENTIKÄINEN_KALEVALA', 'Secondary scholarly',
 'Pentikäinen (1999) pp. 220-260: Louhi as shamanistic authority of the North; the Pohjola mytheme as the hostile otherworld; Louhi''s shape-shifting (eagle-hawk form); the Sampo as axis mundi / cosmic wealth; ambivalent characterization as mother and antagonist.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_FINN_UKKO',        'PER_FINN_TRADITIONAL', 'high',
 'Named in Agricola''s 1551 deity list (earliest written source) as the primary sky-thunder deity of the Häme; pervasively invoked in the Kalevala oral tradition. Pre-Christian attestation confirmed by Agricola.',
 'SRC_AGRICOLA_PRIMER', 'reviewed'),
('ENT_FINN_VAINAMOINEN', 'PER_FINN_TRADITIONAL', 'high',
 'Central figure of the Kalevala oral runo-song tradition preserved from the pre-Christian Finnish period; Pentikäinen (1999) traces the shaman-bard archetype to Iron Age Finnish culture.',
 'SRC_KALEVALA', 'reviewed'),
('ENT_FINN_ILMATAR',     'PER_FINN_TRADITIONAL', 'high',
 'The Ilmatar/world-egg cosmogony in Kalevala Runo 1 reflects pre-Christian Finno-Ugric cosmogonic tradition; close parallels in Estonian (Vanemuine) and Votic cosmogonies confirm antiquity.',
 'SRC_KALEVALA', 'reviewed'),
('ENT_FINN_TAPIO',       'PER_FINN_TRADITIONAL', 'high',
 'Named in Agricola''s 1551 deity list; the forest-deity cult is attested across Karelian and Finnish hunter communities as a pre-Christian practice persisting through Christianization.',
 'SRC_AGRICOLA_PRIMER', 'reviewed'),
('ENT_FINN_MIELIKKI',    'PER_FINN_TRADITIONAL', 'high',
 'Invoked in the Kalevala bear-hunt runos (Runo 14, 46) which preserve pre-Christian hunting ritual material; the bear cult is one of the best-attested pre-Christian religious practices in Finno-Ugric archaeology.',
 'SRC_KALEVALA', 'reviewed'),
('ENT_FINN_AHTI',        'PER_FINN_TRADITIONAL', 'high',
 'Named in Agricola''s 1551 deity list as the deity of fish and water; the water-deity cult is attested across Finnish and Estonian folk practice as pre-Christian.',
 'SRC_AGRICOLA_PRIMER', 'reviewed'),
('ENT_FINN_LOUHI',       'PER_FINN_TRADITIONAL', 'high',
 'The Pohjola mytheme and the Louhi figure are attested across the Kalevala runo-song tradition; Pentikäinen (1999) places the Pohjola narrative complex in the pre-Christian Finnish cosmological worldview.',
 'SRC_KALEVALA', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Ukko: thunder deity cross-tradition alignments
('ENT_FINN_UKKO', 'patron_of', 'ENT_STORM',
 'high',
 'Ukko is the Finnish thunder and storm deity; Agricola 1551 states he "ruled weather and the air." The Kalevala invokes Ukko whenever a storm or lightning is needed. His primary domain is control of thunder, lightning, and rain. Agricola 1551.',
 'SRC_AGRICOLA_PRIMER', 'PER_FINN_TRADITIONAL', 'reviewed'),
('ENT_FINN_UKKO', 'aligned_with', 'ENT_NOR_THOR',
 'high',
 'Ukko and Thor are structurally and functionally parallel thunder deities of neighboring Northern European traditions. Both are the highest-ranking thunder gods in their respective pantheons, both associated with rain and protection of crops, both invoked against evil forces. The cognate pattern reflects shared IE/Uralic-contact origins. Pentikäinen (1999) pp. 125-130.',
 'SRC_PENTIKÄINEN_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
('ENT_FINN_UKKO', 'aligned_with', 'ENT_BALT_PERKUNAS',
 'high',
 'Ukko and Baltic Perkūnas are the closest structural parallels among Northern European thunder deities — both are supreme thunder gods of cultures in long-term contact (Baltic and Finnic peoples share the southeastern Baltic region). Linguistic and functional analysis confirms the alignment: both govern thunder, lightning, rain, and agricultural fertility. Pentikäinen (1999) pp. 127-128; Russell (1987) on Indo-European thunder deity patterns.',
 'SRC_PENTIKÄINEN_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
('ENT_FINN_UKKO', 'aligned_with', 'ENT_SLAV_PERUN',
 'medium',
 'Ukko and Slavic Perun share the same structural role as supreme thunder deities in closely related Northern European traditions; both are associated with lightning, storms, and the oak tree. The alignment is structural and comparative, not a direct ancient equation. Pentikäinen (1999) p. 128. Confidence medium: geographic proximity and function are strong, but no ancient source explicitly equates them.',
 'SRC_PENTIKÄINEN_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
-- Ilmatar cosmogony
('ENT_FINN_ILMATAR', 'parent_of', 'ENT_FINN_VAINAMOINEN',
 'high',
 'Kalevala Runo 1-3 explicitly identifies Ilmatar as the mother of Väinämöinen: she carried him in her womb for 700 years before he was born into the sea. The birth from the virgin air spirit is the foundational event of Finnish cosmogony, linking the world-creation myth directly to the birth of the culture hero. Kalevala Runo 1-3.',
 'SRC_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
-- Väinämöinen cross-tradition alignment
('ENT_FINN_VAINAMOINEN', 'aligned_with', 'ENT_ORPHEUS',
 'medium',
 'Väinämöinen and Orpheus share the structural role of the shaman-bard whose music has cosmic power — both charm nature with their playing, both descend to the realm of the dead to retrieve something (Väinämöinen descends to Tuonela; Orpheus to Hades), and both are associated with mysteries of death and immortality. Pentikäinen (1999) pp. 150-155 notes the parallel. The alignment is structural and comparative, not a historical equation; both figures draw on widespread shaman-bard archetype patterns. Confidence medium.',
 'SRC_PENTIKÄINEN_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
-- Tapio and Mielikki: forest pair
('ENT_FINN_TAPIO', 'spouse_of', 'ENT_FINN_MIELIKKI',
 'high',
 'The Kalevala and Finnish folk tradition consistently present Tapio and Mielikki as husband and wife, co-rulers of the forest realm Tapiola. Kalevala Runo 14 addresses both in the hunter''s forest invocation — Tapio as the lord and Mielikki as the mistress who controls the release of game. The spouse relationship is explicit in the Kalevala text. Pentikäinen (1999) pp. 140-158.',
 'SRC_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
('ENT_FINN_MIELIKKI', 'spouse_of', 'ENT_FINN_TAPIO',
 'high',
 'Mielikki is explicitly described as Tapio''s wife and co-ruler of Tapiola in the Kalevala and Finnish folk tradition. See ENT_FINN_TAPIO spouse_of ENT_FINN_MIELIKKI for full rationale.',
 'SRC_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
-- Mielikki cross-tradition alignment
('ENT_FINN_MIELIKKI', 'aligned_with', 'ENT_BALT_MEDEINA',
 'medium',
 'Mielikki and Baltic Medeina are structurally parallel female forest deities of neighboring traditions: both govern the forest, hunt, and wild animals; both are the primary recipients of hunters'' invocations. The alignment reflects the shared hunting-cult pattern across Baltic Finnic and Baltic Indo-European cultures of the southeastern Baltic region. Pentikäinen (1999) pp. 145-155. Confidence medium: functional parallel is strong; no ancient source explicitly equates them.',
 'SRC_PENTIKÄINEN_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed'),
-- Louhi antagonism
('ENT_FINN_LOUHI', 'opposes', 'ENT_FINN_VAINAMOINEN',
 'high',
 'Louhi is the principal antagonist of Väinämöinen throughout the Kalevala. She demands the Sampo as bride-price (Runos 5-8), pursues the heroes when they steal it back (Runos 30-38), attacks them as a giant eagle-hawk (Runo 42-43), and finally steals the sun and moon in retaliation (Runo 47). Their opposition structures the Kalevala''s main plot arc across more than half the epic. Kalevala Runos 5-8, 10-11, 30-38, 42-49.',
 'SRC_KALEVALA', 'PER_FINN_TRADITIONAL', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities
WHERE tradition = 'Finnish'
GROUP BY tradition;

SELECT e.canonical_name, COUNT(er.relationship_id) AS rels
FROM entities e
LEFT JOIN entity_relationships er
  ON (er.subject_entity_id = e.entity_id OR er.object_entity_id = e.entity_id)
WHERE e.entity_id IN (
  'ENT_FINN_UKKO','ENT_FINN_VAINAMOINEN','ENT_FINN_ILMATAR',
  'ENT_FINN_TAPIO','ENT_FINN_MIELIKKI','ENT_FINN_AHTI','ENT_FINN_LOUHI'
)
GROUP BY e.entity_id, e.canonical_name
ORDER BY e.canonical_name;

SELECT * FROM v_release_metrics;

COMMIT;
