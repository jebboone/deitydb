-- scripts/build_norse_core.sql
-- Content deepening (v1.56.0, part 1): the Norse pantheon. Closes the first of the two
-- thin pre-Christ pantheons from the audit. Germanic/Norse 20 -> 46: the missing Aesir,
-- the sea and wisdom beings, the primordial cosmogony and the great jötnar, and the three
-- named Norns. Each to the Poetic or Prose Edda; period-linked (Viking Age); wired.

BEGIN;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- Aesir gods and goddesses
 ('ENT_NOR_HEIMDALL','Heimdall','Germanic/Norse','God','Watchman of the gods','the Bifröst watch; the Gjallarhorn; foreknowledge','Norse','A','candidate_verified_name','Aesir god',0,false,false,'The ever-watchful warden of the gods at the rainbow bridge, who will sound the Gjallarhorn at Ragnarök.'),
 ('ENT_NOR_BRAGI','Bragi','Germanic/Norse','God','God of poetry','poetry; eloquence; skaldcraft','Norse','A','candidate_verified_name','Aesir god',0,false,false,'The god of poetry and eloquence, husband of Idun.'),
 ('ENT_NOR_IDUN','Idun','Germanic/Norse','Goddess','Goddess of youth','the apples of immortality; youth','Norse','A','candidate_verified_name','Aesir goddess',1,false,false,'The keeper of the golden apples that preserve the gods'' youth, wife of Bragi.'),
 ('ENT_NOR_SIF','Sif','Germanic/Norse','Goddess','Goddess of the harvest','golden hair; the grain harvest','Norse','A','candidate_verified_name','Aesir goddess',2,false,false,'The golden-haired goddess, wife of Thor, whose hair the dwarves remade in gold.'),
 ('ENT_NOR_HODR','Hodr','Germanic/Norse','God','Blind god','blindness; the slaying of Baldr','Norse','A','candidate_verified_name','Aesir god',0,false,false,'The blind god who, guided by Loki, slew his brother Baldr with the mistletoe.'),
 ('ENT_NOR_VIDAR','Vidar','Germanic/Norse','God','God of vengeance','silence; vengeance; survival of Ragnarök','Norse','A','candidate_verified_name','Aesir god',0,false,false,'The silent god of vengeance who will avenge Odin by slaying Fenrir at Ragnarök.'),
 ('ENT_NOR_VALI','Vali','Germanic/Norse','God','God of vengeance','vengeance for Baldr','Norse','A','candidate_verified_name','Aesir god',0,false,false,'The god born to avenge Baldr, who slew Hodr when one night old.'),
 ('ENT_NOR_FORSETI','Forseti','Germanic/Norse','God','God of justice','justice; reconciliation; the assembly','Norse','B','candidate_verified_name','Aesir god',0,false,false,'The god of justice and reconciliation who settles all disputes in his hall Glitnir.'),
 ('ENT_NOR_ULLR','Ullr','Germanic/Norse','God','God of archery','archery; skiing; the hunt; single combat','Norse','B','candidate_verified_name','Aesir god',1,false,false,'The god of archery, skiing and the hunt, invoked in single combat.'),
 ('ENT_NOR_NANNA','Nanna','Germanic/Norse','Goddess','Goddess; wife of Baldr','devotion; grief','Norse','B','candidate_verified_name','Aesir goddess',0,false,false,'The wife of Baldr, who died of grief and was laid on his pyre.'),
 -- sea powers
 ('ENT_NOR_AEGIR','Aegir','Germanic/Norse','Sea god','Jötunn of the sea','the sea; the brewing of ale; the feast of the gods','Norse','A','candidate_verified_name','Sea-giant',0,false,false,'The sea-giant who brews ale and hosts the gods'' feasts; lord of the ocean.'),
 ('ENT_NOR_RAN','Ran','Germanic/Norse','Sea goddess','Goddess of the drowned','the sea-net; the drowned dead','Norse','A','candidate_verified_name','Sea-goddess',0,true,false,'The sea-goddess who draws the drowned into her net, wife of Aegir.'),
 -- wisdom and the mead of poetry
 ('ENT_NOR_MIMIR','Mimir','Germanic/Norse','Wisdom being','Guardian of the well of wisdom','wisdom; counsel; the well beneath Yggdrasil','Norse','A','candidate_verified_name','Wisdom-being',0,false,false,'The wise being of the well beneath Yggdrasil, whose severed head still counsels Odin.'),
 ('ENT_NOR_KVASIR','Kvasir','Germanic/Norse','Wisdom being','Origin of the mead of poetry','wisdom; the mead of poetry','Norse','A','candidate_verified_name','Wisdom-being',0,false,false,'The wisest of beings, born of the gods'' truce, from whose blood the mead of poetry was made.'),
 ('ENT_NOR_GULLVEIG','Gullveig','Germanic/Norse','Vanir being','Witch of the Aesir-Vanir war','gold; witchcraft (seiðr); the first war','Norse','B','candidate_verified_name','Vanir-being',0,false,false,'The thrice-burnt witch whose ill-treatment by the Aesir sparked the war with the Vanir.'),
 -- giantess-goddess
 ('ENT_NOR_SKADI','Skadi','Germanic/Norse','Goddess','Goddess of winter and the hunt','winter; mountains; skiing; the hunt','Norse','A','candidate_verified_name','Jötunn-goddess',2,false,false,'The giantess of winter and the hunt who joined the Aesir by marrying Njord.'),
 -- primordial cosmogony and the great jötnar
 ('ENT_NOR_YMIR','Ymir','Germanic/Norse','Primordial giant','The first being','the primordial body; the making of the world','Norse','A','candidate_verified_name','Primordial giant',3,false,false,'The primordial giant from whose slain body Odin and his brothers fashioned the world.'),
 ('ENT_NOR_SURTR','Surtr','Germanic/Norse','Fire giant','Lord of Muspelheim','primordial fire; the burning of the world at Ragnarök','Norse','A','candidate_verified_name','Fire-giant',0,false,false,'The fire-giant of Muspelheim whose flaming sword will burn the world at Ragnarök.'),
 ('ENT_NOR_AUDHUMLA','Audhumla','Germanic/Norse','Primordial being','The primordial cow','nourishment; the primordial ice','Norse','A','candidate_verified_name','Primordial being',1,false,false,'The primordial cow whose milk fed Ymir and who licked Buri free from the ice.'),
 ('ENT_NOR_BURI','Buri','Germanic/Norse','Primordial being','Ancestor of the Aesir','the first god; the ancestry of Odin','Norse','B','candidate_verified_name','Primordial ancestor',0,false,false,'The first god, licked free from the ice by Audhumla, grandfather of Odin.'),
 ('ENT_NOR_THRYM','Thrym','Germanic/Norse','Giant','Jötunn','the theft of Thor''s hammer','Norse','B','candidate_verified_name','Named jötunn',0,false,false,'The giant-king who stole Thor''s hammer and demanded Freyja as ransom (Þrymskviða).'),
 ('ENT_NOR_HRUNGNIR','Hrungnir','Germanic/Norse','Giant','Jötunn','the duel with Thor; the stone heart','Norse','B','candidate_verified_name','Named jötunn',0,false,false,'The strongest of the giants, of stone head and heart, slain by Thor in single combat.'),
 -- monster
 ('ENT_NOR_GARM','Garm','Germanic/Norse','Monster','Hound of Hel','the guarding of the underworld road; Ragnarök','Norse','B','candidate_verified_name','Hellhound',0,true,false,'The blood-stained hound that guards the road to Hel and bays at Ragnarök.'),
 -- the named Norns
 ('ENT_NOR_URD','Urd','Germanic/Norse','Norn','Norn of the past','fate; what has become; the well of Urd','Norse','A','candidate_verified_name','The Norn of the past',0,false,false,'Urd ("that which became"), eldest of the three Norns, who tends the well at Yggdrasil''s root.'),
 ('ENT_NOR_VERDANDI','Verdandi','Germanic/Norse','Norn','Norn of the present','fate; what is becoming','Norse','A','candidate_verified_name','The Norn of the present',0,false,false,'Verdandi ("that which is becoming"), the Norn of the present.'),
 ('ENT_NOR_SKULD','Skuld','Germanic/Norse','Norn','Norn of the future','fate; what shall be; necessity','Norse','A','candidate_verified_name','The Norn of the future',0,false,false,'Skuld ("that which shall be"), the Norn of the future and necessity.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_NOR_HEIMDALL','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning); Völuspá: Heimdall, warden of the gods.'),
 ('ENT_NOR_BRAGI','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning, Skáldskaparmál): Bragi, god of poetry.'),
 ('ENT_NOR_IDUN','SRC_PROSE_EDDA','direct attestation','Prose Edda (Skáldskaparmál): Idun and the apples of youth.'),
 ('ENT_NOR_SIF','SRC_PROSE_EDDA','direct attestation','Prose Edda (Skáldskaparmál): Sif of the golden hair, wife of Thor.'),
 ('ENT_NOR_HODR','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning): the blind Hodr slays Baldr with the mistletoe.'),
 ('ENT_NOR_VIDAR','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning); Vafþrúðnismál: Vidar avenges Odin upon Fenrir.'),
 ('ENT_NOR_VALI','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning); Baldrs draumar: Vali, born to avenge Baldr.'),
 ('ENT_NOR_FORSETI','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning); Grímnismál: Forseti, god of justice in Glitnir.'),
 ('ENT_NOR_ULLR','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning); Grímnismál: Ullr, god of archery and skiing.'),
 ('ENT_NOR_NANNA','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning): Nanna, wife of Baldr, who dies of grief.'),
 ('ENT_NOR_AEGIR','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Lokasenna, Hymiskviða): Aegir, the sea-giant who feasts the gods.'),
 ('ENT_NOR_RAN','SRC_PROSE_EDDA','direct attestation','Prose Edda (Skáldskaparmál): Ran, who nets the drowned, wife of Aegir.'),
 ('ENT_NOR_MIMIR','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Völuspá 46, Sigrdrífumál): Mimir''s well and counselling head.'),
 ('ENT_NOR_KVASIR','SRC_PROSE_EDDA','direct attestation','Prose Edda (Skáldskaparmál): Kvasir and the origin of the mead of poetry.'),
 ('ENT_NOR_GULLVEIG','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Völuspá 21-22): Gullveig, thrice burnt, and the first war.'),
 ('ENT_NOR_SKADI','SRC_PROSE_EDDA','direct attestation','Prose Edda (Skáldskaparmál, Gylfaginning); Lokasenna: Skadi, who weds Njord.'),
 ('ENT_NOR_YMIR','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning); Vafþrúðnismál: Ymir, from whose body the world is made.'),
 ('ENT_NOR_SURTR','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Völuspá 52); Prose Edda: Surtr, who burns the world at Ragnarök.'),
 ('ENT_NOR_AUDHUMLA','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning): Audhumla, the primordial cow.'),
 ('ENT_NOR_BURI','SRC_PROSE_EDDA','direct attestation','Prose Edda (Gylfaginning): Buri, first god, grandfather of Odin.'),
 ('ENT_NOR_THRYM','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Þrymskviða): Thrym steals Thor''s hammer.'),
 ('ENT_NOR_HRUNGNIR','SRC_PROSE_EDDA','direct attestation','Prose Edda (Skáldskaparmál): Hrungnir, slain by Thor in the duel.'),
 ('ENT_NOR_GARM','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Völuspá, Grímnismál): Garm, the hound at the gates of Hel.'),
 ('ENT_NOR_URD','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Völuspá 20): Urd, eldest of the three Norns.'),
 ('ENT_NOR_VERDANDI','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Völuspá 20): Verdandi, the Norn of the present.'),
 ('ENT_NOR_SKULD','SRC_POETIC_EDDA','direct attestation','Poetic Edda (Völuspá 20): Skuld, the Norn of the future.')
ON CONFLICT DO NOTHING;

-- ── Periods ──────────────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_NOR_VIKING', 'A', 'Norse deity/being of the Viking-Age Eddic tradition.', 'reviewed'
FROM entities WHERE tradition='Germanic/Norse'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=entities.entity_id)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_NOR_HEIMDALL','member_of','ENT_NOR_AESIR','high','Heimdall is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_BRAGI','member_of','ENT_NOR_AESIR','high','Bragi is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_IDUN','member_of','ENT_NOR_AESIR','high','Idun is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SIF','member_of','ENT_NOR_AESIR','high','Sif is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_HODR','member_of','ENT_NOR_AESIR','high','Hodr is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_VIDAR','member_of','ENT_NOR_AESIR','high','Vidar is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_VALI','member_of','ENT_NOR_AESIR','high','Vali is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_FORSETI','member_of','ENT_NOR_AESIR','high','Forseti is one of the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_ULLR','member_of','ENT_NOR_AESIR','high','Ullr is counted among the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_NANNA','member_of','ENT_NOR_AESIR','high','Nanna is one of the Aesir goddesses.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_BRAGI','consort_of','ENT_NOR_IDUN','high','Bragi is the husband of Idun.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SIF','consort_of','ENT_NOR_THOR','high','Sif is the wife of Thor.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_NANNA','consort_of','ENT_NOR_BALDR','high','Nanna is the wife of Baldr.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_HODR','slays','ENT_NOR_BALDR','high','Hodr, guided by Loki, slays Baldr with the mistletoe.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_VALI','slays','ENT_NOR_HODR','high','Vali avenges Baldr by slaying Hodr.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_VIDAR','slays','ENT_NOR_FENRIR','high','Vidar slays Fenrir at Ragnarök to avenge Odin.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SKADI','consort_of','ENT_NOR_NJORD','high','Skadi marries Njord, joining the Aesir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_RAN','consort_of','ENT_NOR_AEGIR','high','Ran is the wife of Aegir.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_MIMIR','aligned_with','ENT_NOR_ODIN','high','Odin consults the well and the severed head of Mimir for wisdom.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_GULLVEIG','aligned_with','ENT_NOR_VANIR','medium','Gullveig, associated with the Vanir, sparks the Aesir-Vanir war.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_YMIR','slain_by','ENT_NOR_ODIN','high','Odin and his brothers slay Ymir and shape the world from his body.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_AUDHUMLA','aligned_with','ENT_NOR_BURI','high','Audhumla licks Buri free from the primordial ice.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_SURTR','slays','ENT_NOR_FREYR','high','Surtr slays Freyr at Ragnarök.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_THRYM','member_of','ENT_NOR_JOTNAR','high','Thrym is one of the jötnar.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_HRUNGNIR','member_of','ENT_NOR_JOTNAR','high','Hrungnir is one of the jötnar.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_HRUNGNIR','slain_by','ENT_NOR_THOR','high','Thor slays Hrungnir in single combat.','SRC_PROSE_EDDA','reviewed'),
 ('ENT_NOR_GARM','aligned_with','ENT_NOR_HEL','medium','Garm guards the road to Hel.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_URD','member_of','ENT_NOR_NORNS','high','Urd is one of the three Norns.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_VERDANDI','member_of','ENT_NOR_NORNS','high','Verdandi is one of the three Norns.','SRC_POETIC_EDDA','reviewed'),
 ('ENT_NOR_SKULD','member_of','ENT_NOR_NORNS','high','Skuld is one of the three Norns.','SRC_POETIC_EDDA','reviewed')
ON CONFLICT DO NOTHING;

SELECT 'Germanic/Norse' AS k, count(*) v FROM entities WHERE tradition='Germanic/Norse';
SELECT count(*) AS norse_undated FROM entities e WHERE e.tradition='Germanic/Norse' AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id);

COMMIT;
