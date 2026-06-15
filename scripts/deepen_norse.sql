-- =====================================================================
-- deepen_norse.sql  (v1.60.0 batch)
-- Germanic/Norse 46 -> ~84. Second deepening pass from the Poetic and Prose
-- Eddas (Gylfaginning, Skaldskaparmal, the thulur). Keeps entity-KINDS
-- distinct (god/goddess/jotunn/dwarf/animal/collective) and wires the
-- myth-families (Loki's kin, Thor's sons, the sun/moon/day/night genealogy,
-- Odin's ancestry, the Mead of Poetry, the forging of Mjollnir).
-- Disguises (Thokk=Loki) and pure name-list filler excluded.
-- Additive; ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_SIMEK_NORTHERN','Rudolf Simek, Dictionary of Northern Mythology (trans. A. Hall, D. S. Brewer, 1993)',NULL,'secondary scholarship','Norse/Germanic mythology'),
 ('SRC_LINDOW_NORSE','John Lindow, Norse Mythology: A Guide to the Gods, Heroes, Rituals, and Beliefs (Oxford University Press, 2001)',NULL,'secondary scholarship','Norse mythology')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
-- gods & goddesses
 ('ENT_NOR_HOENIR','Hœnir','Germanic/Norse','God','Aesir','the giving of reason/sense; the hostage to the Vanir','mythological','A','candidate_verified_name','Voluspa; Gylfaginning',0,false,false,'An Aesir god who, with Odin, gives sense/reason to the first humans; sent to the Vanir as a hostage after their war.'),
 ('ENT_NOR_LODURR','Lóðurr','Germanic/Norse','God','Aesir','the giving of blood/vital warmth to the first humans','mythological','C','candidate_verified_name','Voluspa 18',0,false,false,'One of the three creator-gods (with Odin and Hœnir) who gave life to Ask and Embla; identity (perhaps Loki) unresolved. UNCERTAIN.'),
 ('ENT_NOR_GEFJON','Gefjon','Germanic/Norse','Goddess','Asynjur','ploughing; virginity; the founding of Zealand','mythological','A','candidate_verified_name','Gylfaginning 35',3,false,false,'A goddess who ploughed the island of Zealand out of Sweden with her ox-sons; virgins go to her after death.'),
 ('ENT_NOR_SKIRNIR','Skírnir','Germanic/Norse','God','Servant of Freyr','wooing; messages; the winning of Gerd','mythological','A','candidate_verified_name','Skirnismal',0,false,false,'The servant and messenger of Freyr, who wins the giantess Gerd for him and obtains the fetter Gleipnir from the dwarves.'),
 ('ENT_NOR_SIGYN','Sigyn','Germanic/Norse','Goddess','Asynjur','wifely faithfulness; the venom-bowl','mythological','A','candidate_verified_name','Gylfaginning 50',0,false,false,'The faithful wife of Loki, who holds a bowl to catch the serpent''s venom dripping on the bound Loki.'),
 ('ENT_NOR_HERMOD','Hermóðr','Germanic/Norse','God','Aesir','the ride to Hel; the ransom of Baldr','mythological','A','candidate_verified_name','Gylfaginning 49',0,true,false,'"Hermóðr the Bold," son of Odin, who rides Sleipnir down to Hel to seek Baldr''s release.'),
 ('ENT_NOR_THRUD','Þrúðr','Germanic/Norse','Goddess','Asynjur','strength; (daughter of Thor)','mythological','B','candidate_verified_name','Skaldskaparmal',0,false,false,'A goddess, daughter of Thor and Sif; her name ("strength") also appears among the valkyries.'),
 ('ENT_NOR_MODI','Móði','Germanic/Norse','God','Aesir','wrath; (heir of Thor)','mythological','A','candidate_verified_name','Vafthrudnismal 51',0,false,false,'"Wrath," a son of Thor who, with his brother Magni, inherits the hammer Mjollnir and survives Ragnarok.'),
 ('ENT_NOR_MAGNI','Magni','Germanic/Norse','God','Aesir','strength; (heir of Thor)','mythological','A','candidate_verified_name','Skaldskaparmal',0,false,false,'"Strength," son of Thor by the giantess Jarnsaxa, who as a child lifts Hrungnir''s leg off his father; survives Ragnarok.'),
 ('ENT_NOR_FULLA','Fulla','Germanic/Norse','Goddess','Asynjur','Frigg''s confidante; the keeping of secrets','mythological','B','candidate_verified_name','Gylfaginning 35',0,false,false,'Frigg''s handmaid who bears her casket and knows her secrets.'),
 ('ENT_NOR_EIR','Eir','Germanic/Norse','Goddess','Asynjur','healing; medicine','mythological','B','candidate_verified_name','Gylfaginning 35',0,false,false,'A goddess called "the best of physicians," associated with healing.'),
 ('ENT_NOR_SOL','Sól','Germanic/Norse','Goddess','Celestial deity','the sun; the sun-chariot','mythological','A','candidate_verified_name','Vafthrudnismal; Gylfaginning 11',1,false,false,'The personified Sun, who drives the sun-chariot across the sky pursued by the wolf Skoll; daughter of Mundilfari.'),
 ('ENT_NOR_MANI','Máni','Germanic/Norse','God','Celestial deity','the moon; the moon-chariot','mythological','A','candidate_verified_name','Vafthrudnismal; Gylfaginning 11',0,false,false,'The personified Moon, who drives the moon-chariot pursued by the wolf Hati; son of Mundilfari, brother of Sol.'),
 ('ENT_NOR_NOTT','Nótt','Germanic/Norse','Goddess','Celestial deity','the night','mythological','A','candidate_verified_name','Vafthrudnismal; Gylfaginning 10',1,true,false,'The personified Night, of giant descent (daughter of Norfi), mother of Dagr; rides the sky before the day.'),
 ('ENT_NOR_DAGR','Dagr','Germanic/Norse','God','Celestial deity','the day','mythological','A','candidate_verified_name','Vafthrudnismal; Gylfaginning 10',1,false,false,'The personified Day, son of Dellingr and Nott, who rides the bright horse across the sky.'),
 ('ENT_NOR_DELLINGR','Dellingr','Germanic/Norse','God','Celestial/dawn deity','the dawn','mythological','B','candidate_verified_name','Vafthrudnismal 25',1,false,false,'An Aesir of the dawn, husband of Nott and father of Dagr.'),
 ('ENT_NOR_BORR','Borr','Germanic/Norse','God','Primeval god','the second generation; (father of Odin)','mythological','A','candidate_verified_name','Voluspa 4; Gylfaginning 6',0,false,false,'Son of Buri and father (by the giantess Bestla) of Odin, Vili and Ve.'),
 ('ENT_NOR_BESTLA','Bestla','Germanic/Norse','Goddess','Giant progenitrix','the maternal line of Odin','mythological','A','candidate_verified_name','Gylfaginning 6; Havamal 140',0,false,false,'A giantess, daughter of Bolthorn, mother of Odin, Vili and Ve by Borr.'),
 ('ENT_NOR_SJOFN','Sjöfn','Germanic/Norse','Goddess','Asynjur','love; turning hearts to affection','mythological','C','candidate_verified_name','Gylfaginning 35',0,false,false,'A goddess of the sixteen Asynjur who turns minds toward love.'),
 ('ENT_NOR_VAR','Vár','Germanic/Norse','Goddess','Asynjur','oaths; marriage vows','mythological','C','candidate_verified_name','Gylfaginning 35',0,false,false,'A goddess who hears oaths and marriage agreements and punishes those who break them.'),
 ('ENT_NOR_SAGA','Sága','Germanic/Norse','Goddess','Asynjur','wisdom; the drinking-hall Sokkvabekk','mythological','B','candidate_verified_name','Grimnismal 7',0,false,false,'A goddess who drinks daily with Odin at the hall Sokkvabekk; associated with memory/story.'),
-- jötnar / giants
 ('ENT_NOR_HYMIR','Hymir','Germanic/Norse','Jötunn','Jötnar','the great brewing-cauldron; the fishing of Jormungandr','mythological','A','candidate_verified_name','Hymiskvida',1,false,false,'The giant owner of the mile-deep cauldron, in whose boat Thor hooks the World-Serpent.'),
 ('ENT_NOR_UTGARDALOKI','Útgarða-Loki','Germanic/Norse','Jötunn','Jötnar','illusion; the stronghold of Utgard','mythological','A','candidate_verified_name','Gylfaginning 45-47',1,false,false,'The giant-king of Utgard who defeats Thor and Loki with a series of magical illusions.'),
 ('ENT_NOR_THJAZI','Þjazi','Germanic/Norse','Jötunn','Jötnar','the abduction of Idun; (father of Skadi)','mythological','A','candidate_verified_name','Skaldskaparmal',1,false,false,'The giant who abducts Idun and her apples; slain by the Aesir; father of Skadi.'),
 ('ENT_NOR_GEIRROD_GIANT','Geirröðr','Germanic/Norse','Jötunn','Jötnar','the duel with a weaponless Thor','mythological','B','candidate_verified_name','Skaldskaparmal (Thorsdrapa)',0,false,false,'A giant who lures Thor weaponless to his hall; killed by a glowing iron Thor hurls back.'),
 ('ENT_NOR_GUNNLOD','Gunnlöð','Germanic/Norse','Jötunn','Jötnar','the guarding of the Mead of Poetry','mythological','A','candidate_verified_name','Havamal 104-110',0,false,false,'The giantess, daughter of Suttungr, who guards the Mead of Poetry and is seduced by Odin.'),
 ('ENT_NOR_SUTTUNGR','Suttungr','Germanic/Norse','Jötunn','Jötnar','the keeping of the Mead of Poetry','mythological','A','candidate_verified_name','Skaldskaparmal; Havamal',0,false,false,'The giant who takes the Mead of Poetry as wergild and hides it under the mountain; father of Gunnlod.'),
 ('ENT_NOR_VAFTHRUDNIR','Vafþrúðnir','Germanic/Norse','Jötunn','Jötnar','ancient wisdom; the wisdom-contest','mythological','A','candidate_verified_name','Vafthrudnismal',0,false,false,'The exceedingly wise giant who loses a head-staking wisdom-contest to the disguised Odin.'),
 ('ENT_NOR_FARBAUTI','Fárbauti','Germanic/Norse','Jötunn','Jötnar','(father of Loki)','mythological','B','candidate_verified_name','Gylfaginning 33',0,false,false,'The giant "cruel-striker," father of Loki by Laufey.'),
 ('ENT_NOR_LAUFEY','Laufey','Germanic/Norse','Jötunn','Jötnar','(mother of Loki)','mythological','B','candidate_verified_name','Gylfaginning; Lokasenna',1,false,false,'Laufey (Nal), the mother of Loki, by whose name he is matronymically called Loki Laufeyjarson.'),
 ('ENT_NOR_ANGRBODA','Angrboða','Germanic/Norse','Jötunn','Jötnar','the mothering of monsters','mythological','A','candidate_verified_name','Gylfaginning 34',0,false,false,'The giantess who bears Loki the three monsters Fenrir, Jormungandr and Hel.'),
 ('ENT_NOR_MUNDILFARI','Mundilfari','Germanic/Norse','Jötunn','Jötnar','(father of Sun and Moon)','mythological','B','candidate_verified_name','Vafthrudnismal 23',0,false,false,'The father of Sol and Mani, who named his children for the sun and moon and angered the gods.'),
-- dwarves
 ('ENT_NOR_BROKKR','Brokkr','Germanic/Norse','Dwarf','Dwarves','smithing; the forging of the gods'' treasures','mythological','A','candidate_verified_name','Skaldskaparmal',2,false,false,'A dwarf smith who, with his brother Sindri/Eitri, forges Mjollnir, Draupnir and Gullinbursti in a wager with Loki.'),
 ('ENT_NOR_SINDRI','Sindri','Germanic/Norse','Dwarf','Dwarves','smithing; the forging of Mjollnir','mythological','A','candidate_verified_name','Skaldskaparmal',2,false,false,'The dwarf smith (Eitri) who forges the gods'' treasures while his brother Brokkr works the bellows.'),
 ('ENT_NOR_FJALAR_DWARF','Fjalar','Germanic/Norse','Dwarf','Dwarves','the brewing of the Mead of Poetry','mythological','B','candidate_verified_name','Skaldskaparmal',0,false,false,'A dwarf who, with Galar, murders Kvasir and brews the Mead of Poetry from his blood. (Distinct from the giant and the cock of the same name.)'),
 ('ENT_NOR_GALAR','Galar','Germanic/Norse','Dwarf','Dwarves','the brewing of the Mead of Poetry','mythological','B','candidate_verified_name','Skaldskaparmal',0,false,false,'The dwarf who, with Fjalar, kills Kvasir and brews the Mead of Poetry.'),
 ('ENT_NOR_ANDVARI','Andvari','Germanic/Norse','Dwarf','Dwarves','the cursed gold; the ring Andvaranaut','mythological','A','candidate_verified_name','Reginsmal; Voluspa',2,false,false,'The dwarf who dwells as a pike under a waterfall, whose cursed gold and ring Andvaranaut Loki seizes.'),
 ('ENT_NOR_ALVISS','Alvíss','Germanic/Norse','Dwarf','Dwarves','wisdom; the cosmic name-lore','mythological','B','candidate_verified_name','Alvissmal',0,false,false,'The all-wise dwarf who, claiming Thor''s daughter, is kept talking until the sunrise turns him to stone.'),
 ('ENT_NOR_DVALINN','Dvalinn','Germanic/Norse','Dwarf','Dwarves','smithing; runes','mythological','B','candidate_verified_name','Voluspa 14; Havamal 143',2,false,false,'A leading dwarf of the Dvergatal, associated with runes and the crafting of treasures.'),
 ('ENT_NOR_DURINN','Durinn','Germanic/Norse','Dwarf','Dwarves','the shaping of the dwarf-race','mythological','B','candidate_verified_name','Voluspa 10',2,false,false,'The "second" dwarf, who with Motsognir shapes the race of dwarves from the earth.'),
 ('ENT_NOR_MOTSOGNIR','Mótsognir','Germanic/Norse','Dwarf','Dwarves','the first and greatest of dwarves','mythological','B','candidate_verified_name','Voluspa 10',2,false,false,'The first and greatest of the dwarves in the Dvergatal.'),
-- mythological animals & a collective
 ('ENT_NOR_SLEIPNIR','Sleipnir','Germanic/Norse','Mythical animal','Steeds','Odin''s eight-legged horse; the ride between worlds','mythological','A','candidate_verified_name','Grimnismal 44',1,false,false,'Odin''s eight-legged horse, offspring of Loki and the stallion Svadilfari, who bears riders even to Hel.'),
 ('ENT_NOR_HUGINN','Huginn','Germanic/Norse','Mythical animal','Odin''s ravens','thought; Odin''s sight over the world','mythological','A','candidate_verified_name','Grimnismal 20',0,false,false,'"Thought," one of the two ravens who fly the world each day and report to Odin.'),
 ('ENT_NOR_MUNINN','Muninn','Germanic/Norse','Mythical animal','Odin''s ravens','memory; Odin''s sight over the world','mythological','A','candidate_verified_name','Grimnismal 20',0,false,false,'"Memory," one of the two ravens who report the world''s tidings to Odin.'),
 ('ENT_NOR_GERI','Geri','Germanic/Norse','Mythical animal','Odin''s wolves','the feast at Odin''s table','mythological','B','candidate_verified_name','Grimnismal 19',0,false,false,'"Ravenous," one of the two wolves Odin feeds at his table in Valhalla.'),
 ('ENT_NOR_FREKI','Freki','Germanic/Norse','Mythical animal','Odin''s wolves','the feast at Odin''s table','mythological','B','candidate_verified_name','Grimnismal 19',0,false,false,'"Greedy," one of the two wolves who eat at Odin''s table.'),
 ('ENT_NOR_RATATOSKR','Ratatoskr','Germanic/Norse','Mythical animal','Yggdrasil''s creatures','strife-bearing between the eagle and the serpent','mythological','B','candidate_verified_name','Grimnismal 32',2,false,false,'The squirrel who runs up and down Yggdrasil carrying spiteful words between the eagle above and Nidhogg below.'),
 ('ENT_NOR_HATI','Hati','Germanic/Norse','Mythical animal','Wolves of Ragnarok','the pursuit and swallowing of the moon','mythological','B','candidate_verified_name','Grimnismal 39',0,false,false,'The wolf who pursues Mani the moon and devours him at Ragnarok.'),
 ('ENT_NOR_SKOLL','Sköll','Germanic/Norse','Mythical animal','Wolves of Ragnarok','the pursuit and swallowing of the sun','mythological','B','candidate_verified_name','Grimnismal 39',0,false,false,'The wolf who pursues Sol the sun and devours her at Ragnarok.'),
 ('ENT_NOR_EINHERJAR','Einherjar','Germanic/Norse','Collective','The honoured dead','the slain warriors of Valhalla; the host of Ragnarok','mythological','A','candidate_verified_name','Grimnismal; Gylfaginning',0,false,false,'The chosen slain who feast and fight daily in Valhalla, kept by Odin to fight at Ragnarok.')
ON CONFLICT (entity_id) DO NOTHING;

-- sources: bulk Simek + Lindow; primary attestations on the well-known myth figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_SIMEK_NORTHERN','scholarly attestation','Simek, Dictionary of Northern Mythology.'
FROM entities WHERE tradition='Germanic/Norse' AND review_status='candidate_verified_name' AND entity_id LIKE 'ENT_NOR_%'
  AND entity_id NOT IN ('ENT_NOR_AEGIR','ENT_NOR_AESIR','ENT_NOR_AUDHUMLA','ENT_NOR_BALDR','ENT_NOR_BRAGI','ENT_NOR_BURI','ENT_NOR_DWARVES','ENT_NOR_FENRIR','ENT_NOR_FORSETI','ENT_NOR_FREYJA','ENT_NOR_FREYR','ENT_NOR_FRIGG','ENT_NOR_GARM','ENT_NOR_GULLVEIG','ENT_NOR_HEIMDALL','ENT_NOR_HEL','ENT_NOR_HODR','ENT_NOR_HRUNGNIR','ENT_NOR_IDUN','ENT_NOR_JORMUNGANDR','ENT_NOR_JOTNAR','ENT_NOR_KVASIR','ENT_NOR_LOKI','ENT_NOR_MIMIR','ENT_NOR_NANNA','ENT_NOR_NIDHOGG','ENT_NOR_NJORD','ENT_NOR_NORNS','ENT_NOR_ODIN','ENT_NOR_RAN','ENT_NOR_SIF','ENT_NOR_SKADI','ENT_NOR_SKULD','ENT_NOR_SURTR','ENT_NOR_THOR','ENT_NOR_THRYM','ENT_NOR_TYR','ENT_NOR_ULLR','ENT_NOR_URD','ENT_NOR_VALI','ENT_NOR_VALKYRIES','ENT_NOR_VANIR','ENT_NOR_VERDANDI','ENT_NOR_VIDAR','ENT_NOR_YGGDRASIL','ENT_NOR_YMIR')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_POETIC_EDDA','direct attestation','Attested in the Poetic Edda.'
FROM entities WHERE entity_id IN ('ENT_NOR_HOENIR','ENT_NOR_LODURR','ENT_NOR_SKIRNIR','ENT_NOR_SOL','ENT_NOR_MANI','ENT_NOR_NOTT','ENT_NOR_DAGR','ENT_NOR_DELLINGR','ENT_NOR_BORR','ENT_NOR_BESTLA','ENT_NOR_SAGA','ENT_NOR_HYMIR','ENT_NOR_GUNNLOD','ENT_NOR_VAFTHRUDNIR','ENT_NOR_MUNDILFARI','ENT_NOR_ANDVARI','ENT_NOR_ALVISS','ENT_NOR_DVALINN','ENT_NOR_DURINN','ENT_NOR_MOTSOGNIR','ENT_NOR_SLEIPNIR','ENT_NOR_HUGINN','ENT_NOR_MUNINN','ENT_NOR_GERI','ENT_NOR_FREKI','ENT_NOR_RATATOSKR','ENT_NOR_HATI','ENT_NOR_SKOLL','ENT_NOR_EINHERJAR','ENT_NOR_MODI')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_PROSE_EDDA','direct attestation','Attested in Snorri''s Prose Edda.'
FROM entities WHERE entity_id IN ('ENT_NOR_GEFJON','ENT_NOR_SIGYN','ENT_NOR_HERMOD','ENT_NOR_THRUD','ENT_NOR_MAGNI','ENT_NOR_FULLA','ENT_NOR_EIR','ENT_NOR_SJOFN','ENT_NOR_VAR','ENT_NOR_UTGARDALOKI','ENT_NOR_THJAZI','ENT_NOR_GEIRROD_GIANT','ENT_NOR_SUTTUNGR','ENT_NOR_FARBAUTI','ENT_NOR_LAUFEY','ENT_NOR_ANGRBODA','ENT_NOR_BROKKR','ENT_NOR_SINDRI','ENT_NOR_FJALAR_DWARF','ENT_NOR_GALAR')
ON CONFLICT DO NOTHING;

-- periods: all Viking-Age (the Eddic corpus)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_NOR_VIKING','A','Attested in the Eddic corpus of the Viking Age / medieval Iceland.','SRC_SIMEK_NORTHERN','reviewed'
FROM entities WHERE tradition='Germanic/Norse' AND review_status='candidate_verified_name' AND entity_id LIKE 'ENT_NOR_%'
  AND entity_id IN ('ENT_NOR_HOENIR','ENT_NOR_LODURR','ENT_NOR_GEFJON','ENT_NOR_SKIRNIR','ENT_NOR_SIGYN','ENT_NOR_HERMOD','ENT_NOR_THRUD','ENT_NOR_MODI','ENT_NOR_MAGNI','ENT_NOR_FULLA','ENT_NOR_EIR','ENT_NOR_SOL','ENT_NOR_MANI','ENT_NOR_NOTT','ENT_NOR_DAGR','ENT_NOR_DELLINGR','ENT_NOR_BORR','ENT_NOR_BESTLA','ENT_NOR_SJOFN','ENT_NOR_VAR','ENT_NOR_SAGA','ENT_NOR_HYMIR','ENT_NOR_UTGARDALOKI','ENT_NOR_THJAZI','ENT_NOR_GEIRROD_GIANT','ENT_NOR_GUNNLOD','ENT_NOR_SUTTUNGR','ENT_NOR_VAFTHRUDNIR','ENT_NOR_FARBAUTI','ENT_NOR_LAUFEY','ENT_NOR_ANGRBODA','ENT_NOR_MUNDILFARI','ENT_NOR_BROKKR','ENT_NOR_SINDRI','ENT_NOR_FJALAR_DWARF','ENT_NOR_GALAR','ENT_NOR_ANDVARI','ENT_NOR_ALVISS','ENT_NOR_DVALINN','ENT_NOR_DURINN','ENT_NOR_MOTSOGNIR','ENT_NOR_SLEIPNIR','ENT_NOR_HUGINN','ENT_NOR_MUNINN','ENT_NOR_GERI','ENT_NOR_FREKI','ENT_NOR_RATATOSKR','ENT_NOR_HATI','ENT_NOR_SKOLL','ENT_NOR_EINHERJAR')
ON CONFLICT DO NOTHING;

-- relationships: the myth-family graph
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
-- creation of mankind
 ('ENT_NOR_HOENIR','member_of','ENT_NOR_AESIR','high','An Aesir god.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_HOENIR','paired_with','ENT_NOR_ODIN','medium','With Odin (and Lodurr) gives life and sense to the first humans.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_LODURR','paired_with','ENT_NOR_ODIN','medium','One of the three creator-gods of Voluspa 18.','SRC_POETIC_EDDA','reviewed'),
-- Odin's ancestry
 ('ENT_NOR_BORR','child_of','ENT_NOR_BURI','high','Borr, son of the primeval Buri.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_BORR','consort_of','ENT_NOR_BESTLA','high','Borr and the giantess Bestla, parents of Odin.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_ODIN','child_of','ENT_NOR_BORR','high','Odin, son of Borr and Bestla.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_ODIN','child_of','ENT_NOR_BESTLA','high','Odin, son of Bestla.','SRC_PROSE_EDDA','reviewed'),
-- Loki's family
 ('ENT_NOR_LOKI','child_of','ENT_NOR_FARBAUTI','high','Loki, son of the giant Farbauti.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_LOKI','child_of','ENT_NOR_LAUFEY','high','Loki Laufeyjarson, son of Laufey.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_FARBAUTI','consort_of','ENT_NOR_LAUFEY','high','Farbauti and Laufey, the parents of Loki.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SIGYN','consort_of','ENT_NOR_LOKI','high','Sigyn, the faithful wife of Loki.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_ANGRBODA','consort_of','ENT_NOR_LOKI','high','Angrboda bears Loki the three monsters.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_FENRIR','child_of','ENT_NOR_ANGRBODA','high','Fenrir, child of Loki and Angrboda.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_JORMUNGANDR','child_of','ENT_NOR_ANGRBODA','high','Jormungandr, child of Loki and Angrboda.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_HEL','child_of','ENT_NOR_ANGRBODA','high','Hel, child of Loki and Angrboda.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SLEIPNIR','child_of','ENT_NOR_LOKI','high','Sleipnir, borne by Loki in the form of a mare.','SRC_PROSE_EDDA','reviewed'),
-- Thor's children
 ('ENT_NOR_THRUD','child_of','ENT_NOR_THOR','high','Thrud, daughter of Thor and Sif.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_THRUD','child_of','ENT_NOR_SIF','high','Thrud, daughter of Sif.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_MODI','child_of','ENT_NOR_THOR','high','Modi, son of Thor.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_MAGNI','child_of','ENT_NOR_THOR','high','Magni, son of Thor by the giantess Jarnsaxa.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_MODI','sibling_of','ENT_NOR_MAGNI','high','The two sons of Thor who inherit Mjollnir.','SRC_PROSE_EDDA','reviewed'),
-- sun / moon / day / night genealogy
 ('ENT_NOR_SOL','child_of','ENT_NOR_MUNDILFARI','high','Sol, daughter of Mundilfari.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_MANI','child_of','ENT_NOR_MUNDILFARI','high','Mani, son of Mundilfari.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_SOL','sibling_of','ENT_NOR_MANI','high','Sun and Moon, the children of Mundilfari.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_DAGR','child_of','ENT_NOR_NOTT','high','Day, son of Night.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_DAGR','child_of','ENT_NOR_DELLINGR','high','Day, son of Dellingr.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_DELLINGR','consort_of','ENT_NOR_NOTT','high','Dellingr and Nott, the parents of Day.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SKOLL','slays','ENT_NOR_SOL','high','The wolf Skoll devours the sun at Ragnarok.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_HATI','slays','ENT_NOR_MANI','high','The wolf Hati devours the moon at Ragnarok.','SRC_POETIC_EDDA','reviewed'),
-- the Mead of Poetry cycle
 ('ENT_NOR_FJALAR_DWARF','slays','ENT_NOR_KVASIR','high','Fjalar and Galar murder Kvasir and brew the Mead of Poetry.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_GALAR','slays','ENT_NOR_KVASIR','high','Galar, with Fjalar, kills Kvasir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_FJALAR_DWARF','sibling_of','ENT_NOR_GALAR','high','The two dwarves of the Mead of Poetry.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SUTTUNGR','parent_of','ENT_NOR_GUNNLOD','high','Suttungr, father of Gunnlod.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_GUNNLOD','guardian_of','ENT_NOR_KVASIR','low','Gunnlod guards the Mead of Poetry brewed from Kvasir.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_ODIN','deceives_or_tempts','ENT_NOR_GUNNLOD','medium','Odin seduces Gunnlod to win the Mead of Poetry.','SRC_POETIC_EDDA','reviewed'),
-- the forging of Mjollnir
 ('ENT_NOR_BROKKR','sibling_of','ENT_NOR_SINDRI','high','Brokkr and Sindri/Eitri, the dwarf-smith brothers.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_BROKKR','creator_of','ENT_NOR_THOR','low','Forges Mjollnir, the hammer of Thor.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_DURINN','paired_with','ENT_NOR_MOTSOGNIR','high','Durinn and Motsognir shape the race of dwarves.','SRC_POETIC_EDDA','reviewed'),
-- giants and their myth-roles
 ('ENT_NOR_THJAZI','parent_of','ENT_NOR_SKADI','high','Thjazi, father of Skadi.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_THJAZI','member_of','ENT_NOR_JOTNAR','high','Of the giants.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_HYMIR','member_of','ENT_NOR_JOTNAR','high','Of the giants.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_UTGARDALOKI','member_of','ENT_NOR_JOTNAR','high','Of the giants.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SUTTUNGR','member_of','ENT_NOR_JOTNAR','high','Of the giants.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_VAFTHRUDNIR','member_of','ENT_NOR_JOTNAR','high','Of the giants.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_THOR','slays','ENT_NOR_GEIRROD_GIANT','high','Thor kills the giant Geirrod.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_THOR','opposes','ENT_NOR_UTGARDALOKI','high','Thor is defeated by Utgarda-Loki''s illusions.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_THOR','opposes','ENT_NOR_HYMIR','medium','Thor fishes for the World-Serpent from Hymir''s boat.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_ODIN','opposes','ENT_NOR_VAFTHRUDNIR','low','Odin wins the wisdom-contest against Vafthrudnir.','SRC_POETIC_EDDA','reviewed'),
-- Odin's animals; Idun/Thjazi; Baldr ride
 ('ENT_NOR_HUGINN','member_of','ENT_NOR_AESIR','low','One of Odin''s ravens.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_HUGINN','paired_with','ENT_NOR_MUNINN','high','Huginn and Muninn, Odin''s ravens.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_GERI','paired_with','ENT_NOR_FREKI','high','Geri and Freki, Odin''s wolves.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_HERMOD','child_of','ENT_NOR_ODIN','medium','Hermod, son of Odin, who rides to Hel for Baldr.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_THJAZI','imprisons','ENT_NOR_IDUN','high','Thjazi abducts Idun and her apples.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_RATATOSKR','dwells_in','ENT_NOR_YGGDRASIL','high','The squirrel of the World-Tree.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_RATATOSKR','transmits','ENT_NOR_NIDHOGG','medium','Bears words between the eagle and Nidhogg.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_EINHERJAR','member_of','ENT_NOR_AESIR','low','The slain warriors gathered by Odin in Valhalla.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_EINHERJAR','presided_over_by','ENT_NOR_ODIN','high','Odin gathers and leads the einherjar.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_GEFJON','member_of','ENT_NOR_AESIR','low','One of the Asynjur.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_HERMOD','member_of','ENT_NOR_AESIR','medium','Of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SKIRNIR','member_of','ENT_NOR_VANIR','low','The servant of the Van Freyr.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_SKIRNIR','transmits','ENT_NOR_FREYR','high','Skirnir woos Gerd on Freyr''s behalf.','SRC_POETIC_EDDA','reviewed')
ON CONFLICT DO NOTHING;

-- connectivity supplement: wire new (and previously-floating) nodes into their
-- collectives so the deepening does not leave Norse under-wired.
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_NOR_BROKKR','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_SINDRI','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_FJALAR_DWARF','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_GALAR','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_ANDVARI','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_ALVISS','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_DVALINN','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_DURINN','member_of','ENT_NOR_DWARVES','high','One of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_MOTSOGNIR','member_of','ENT_NOR_DWARVES','high','The first of the dwarves.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_URD','member_of','ENT_NOR_NORNS','high','One of the three Norns.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_VERDANDI','member_of','ENT_NOR_NORNS','high','One of the three Norns.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_SKULD','member_of','ENT_NOR_NORNS','high','One of the three Norns.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_EIR','member_of','ENT_NOR_AESIR','medium','One of the Asynjur.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_FULLA','member_of','ENT_NOR_AESIR','medium','One of the Asynjur; Frigg''s handmaid.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_SAGA','member_of','ENT_NOR_AESIR','medium','One of the Asynjur.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_SJOFN','member_of','ENT_NOR_AESIR','medium','One of the Asynjur.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_VAR','member_of','ENT_NOR_AESIR','medium','One of the Asynjur.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_SIGYN','member_of','ENT_NOR_AESIR','medium','Reckoned among the Asynjur.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_FULLA','transmits','ENT_NOR_FRIGG','medium','Frigg''s handmaid and confidante.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_HEIMDALL','member_of','ENT_NOR_AESIR','high','Of the Aesir; watchman of the gods.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_FORSETI','member_of','ENT_NOR_AESIR','high','Of the Aesir; god of justice.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_ULLR','member_of','ENT_NOR_AESIR','high','Of the Aesir; god of the bow and ski.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_BRAGI','member_of','ENT_NOR_AESIR','high','Of the Aesir; god of poetry.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_SURTR','member_of','ENT_NOR_JOTNAR','high','The fire-giant of Muspell.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_THRYM','member_of','ENT_NOR_JOTNAR','high','The giant who steals Thor''s hammer.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_GEIRROD_GIANT','member_of','ENT_NOR_JOTNAR','high','Of the giants.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_AEGIR','consort_of','ENT_NOR_RAN','high','Aegir and Ran, the sea-god and sea-goddess.','SRC_SIMEK_NORTHERN','reviewed')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Norse count (expect ~84) =='
SELECT count(*) FROM entities WHERE tradition='Germanic/Norse';
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
