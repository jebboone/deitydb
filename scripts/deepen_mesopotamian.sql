-- scripts/deepen_mesopotamian.sql
-- Content deepening (v1.52.0): the Mesopotamian pantheon. The pre-Christ audit flagged
-- this as the biggest content gap by importance — the world's oldest literate religion had
-- only its top tier (36 entities). This roughly doubles it (→ ~76) with the canonical
-- city-patron and functional gods, the full Enuma Elish theogony, the underworld officials,
-- the demon/monster register, and the Erra epic. Each entity to a primary source (ETCSL,
-- Enuma Elish, Atrahasis, Gilgamesh, Foster's Before the Muses) or Black & Green; typed
-- relationships and period links wired (uses the normalized evidence_type vocabulary).

BEGIN;

-- ── New primary-text sources (ETCSL, Gilgamesh, Black & Green already registered) ──
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_ENUMA_ELISH','Enuma Elish (the Babylonian Epic of Creation), c. late 2nd millennium BCE','','primary text','The Babylonian creation epic; the theogony from Apsu and Tiamat and the exaltation of Marduk'),
('SRC_ATRAHASIS','The Atrahasis Epic (Akkadian flood and creation-of-humanity myth), c. 1700 BCE','','primary text','The Old Babylonian epic of the creation of humankind and the great flood'),
('SRC_FOSTER_MUSES','Benjamin R. Foster, Before the Muses: An Anthology of Akkadian Literature','','primary text','The standard anthology of Akkadian literature in translation (the Erra Epic, Adapa, Etana, hymns)')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- city-patron and functional gods (Sumerian)
 ('ENT_MES_GULA','Gula','Mesopotamian','Goddess','Healing deity','healing; medicine; dogs','Mesopotamian','A','candidate_verified_name','Great healing goddess',0,false,false,'The great healing goddess ("the great physician"), also called Ninisina; her animal is the dog.'),
 ('ENT_MES_NANSHE','Nanshe','Mesopotamian','Goddess','Justice/divination deity','social justice; dream-divination; fish; the poor','Mesopotamian','A','candidate_verified_name','City goddess of Lagash',1,false,false,'The Lagash goddess of social justice, dream interpretation and fish.'),
 ('ENT_MES_NINGIRSU','Ningirsu','Mesopotamian','God','Warrior/agriculture deity','war; irrigation; the city of Lagash','Mesopotamian','A','candidate_verified_name','City god of Lagash',1,false,false,'The warrior and irrigation god of Lagash, a local form of Ninurta; patron of Gudea.'),
 ('ENT_MES_BAU','Bau','Mesopotamian','Goddess','Healing/mother deity','healing; abundance; the city of Lagash','Mesopotamian','A','candidate_verified_name','City goddess of Lagash',0,false,false,'The mother and healing goddess of Lagash (Baba), consort of Ningirsu.'),
 ('ENT_MES_NINAZU','Ninazu','Mesopotamian','God','Underworld/healing deity','the underworld; healing; serpents','Mesopotamian','B','candidate_verified_name','Underworld/healing god',0,true,true,'The god of the underworld and healing, father of Ningishzida.'),
 ('ENT_MES_NINGISHZIDA','Ningishzida','Mesopotamian','God','Underworld/vegetation deity','the underworld; vegetation; serpents; the throne','Mesopotamian','A','candidate_verified_name','Chthonic serpent god',1,true,true,'The chthonic serpent god of vegetation and the underworld threshold, personal god of Gudea.'),
 ('ENT_MES_SHARA','Shara','Mesopotamian','God','City/war deity','war; the city of Umma','Mesopotamian','B','candidate_verified_name','City god of Umma',0,false,false,'The warrior city-god of Umma, a son of Inanna.'),
 ('ENT_MES_ISHTARAN','Ishtaran','Mesopotamian','God','Justice deity','divine justice; the city of Der; serpents','Mesopotamian','B','candidate_verified_name','City god of Der',0,false,true,'The divine judge and city-god of Der, served by the serpent-god Nirah.'),
 ('ENT_MES_ZABABA','Zababa','Mesopotamian','God','War deity','war; the city of Kish','Mesopotamian','B','candidate_verified_name','City god of Kish',0,false,false,'The warrior city-god of Kish.'),
 ('ENT_MES_DAMU','Damu','Mesopotamian','God','Healing/dying deity','healing; the dying vegetation; the return of life','Mesopotamian','B','candidate_verified_name','Healing/dying god',1,false,false,'The healing and dying-and-rising vegetation god, son of Gula.'),
 ('ENT_MES_NINKASI','Ninkasi','Mesopotamian','Goddess','Beer deity','beer; brewing','Mesopotamian','A','candidate_verified_name','Goddess of beer',1,false,false,'The goddess of beer and brewing, celebrated in the Hymn to Ninkasi.'),
 ('ENT_MES_NANAYA','Nanaya','Mesopotamian','Goddess','Love deity','love; sensuality; eroticism','Mesopotamian','B','candidate_verified_name','Goddess of love',0,false,false,'The goddess of love and sensuality, closely associated with Inanna.'),
 ('ENT_MES_NUSKA','Nuska','Mesopotamian','God','Fire/light deity','fire; light; the vizier of Enlil','Mesopotamian','A','candidate_verified_name','God of fire and light',0,false,false,'The god of fire and lamplight, the vizier and messenger of Enlil.'),
 -- heroes, sages, deified kings
 ('ENT_MES_LUGALBANDA','Lugalbanda','Mesopotamian','Hero','Deified king','heroism; the city of Uruk; deified kingship','Mesopotamian','A','candidate_verified_name','Deified hero-king',0,false,false,'The deified hero-king of Uruk, husband of Ninsun and father of Gilgamesh.'),
 ('ENT_MES_ADAPA','Adapa','Mesopotamian','Sage','Primordial sage','wisdom; the lost chance at immortality','Mesopotamian','A','candidate_verified_name','Primordial sage',0,false,false,'The sage of Eridu, son of Ea, who broke the South Wind and refused the bread of life.'),
 ('ENT_MES_ETANA','Etana','Mesopotamian','Hero','Deified king','kingship; the flight to heaven on the eagle','Mesopotamian','B','candidate_verified_name','Deified hero-king',0,false,false,'The early king of Kish who flew to heaven on an eagle seeking the plant of birth.'),
 -- underworld officials
 ('ENT_MES_NAMTAR','Namtar','Mesopotamian','Demon','Death/plague demon','fate; death; plague; the vizier of Ereshkigal','Mesopotamian','A','candidate_verified_name','Vizier of the underworld',0,true,false,'Namtar ("Fate"), the demon of death and plague, vizier of Ereshkigal.'),
 ('ENT_MES_NETI','Neti','Mesopotamian','God','Underworld gatekeeper','the gates of the underworld','Mesopotamian','B','candidate_verified_name','Gatekeeper of the underworld',0,true,false,'Neti, the chief gatekeeper of the underworld who admits the descending Inanna.'),
 ('ENT_MES_BELET_SERI','Belet-seri','Mesopotamian','Goddess','Underworld scribe','the records of the dead','Mesopotamian','B','candidate_verified_name','Scribe of the underworld',0,true,false,'Belet-seri, the scribe of the underworld who keeps the register of the dead.'),
 ('ENT_MES_GUGALANNA','Gugalanna','Mesopotamian','Monster','Bull of Heaven','the Bull of Heaven; drought; the underworld','Mesopotamian','A','candidate_verified_name','Bull of Heaven',0,true,false,'The Bull of Heaven, first husband of Ereshkigal, sent against Gilgamesh by Ishtar.'),
 -- the Enuma Elish theogony and Marduk circle
 ('ENT_MES_LAHMU','Lahmu','Mesopotamian','Primordial being','Protective primordial','the primordial silt; protection; the cosmic deep','Mesopotamian','A','candidate_verified_name','Primordial pair (Enuma Elish)',0,false,false,'Lahmu (with Lahamu), the first pair born of Apsu and Tiamat; also a hairy protective hero.'),
 ('ENT_MES_ANSHAR','Anshar','Mesopotamian','Primordial being','Sky horizon','the horizon of heaven; the host of the gods','Mesopotamian','A','candidate_verified_name','Primordial (Enuma Elish)',0,false,false,'Anshar, the "whole sky," father of Anu, who marshals the gods against Tiamat.'),
 ('ENT_MES_KISHAR','Kishar','Mesopotamian','Primordial being','Earth horizon','the horizon of earth','Mesopotamian','A','candidate_verified_name','Primordial (Enuma Elish)',2,false,false,'Kishar, the "whole earth," consort of Anshar.'),
 ('ENT_MES_MUMMU','Mummu','Mesopotamian','Primordial being','Vizier of Apsu','the mist; counsel; the craftsman principle','Mesopotamian','B','candidate_verified_name','Primordial (Enuma Elish)',0,false,false,'Mummu, the vizier and counsellor of Apsu, bound by Ea at the cosmos'' beginning.'),
 ('ENT_MES_DAMKINA','Damkina','Mesopotamian','Goddess','Mother of Marduk','the deep waters; motherhood','Mesopotamian','A','candidate_verified_name','Consort of Ea',0,false,false,'Damkina (Damgalnuna), consort of Ea and mother of Marduk.'),
 ('ENT_MES_SARPANIT','Sarpanit','Mesopotamian','Goddess','Consort of Marduk','birth; the city of Babylon','Mesopotamian','A','candidate_verified_name','Consort of Marduk',0,false,false,'Sarpanit (Zarpanitu), consort of Marduk and mother of Nabu, honoured at Babylon.'),
 ('ENT_MES_AYA','Aya','Mesopotamian','Goddess','Dawn deity','dawn; light; love','Mesopotamian','B','candidate_verified_name','Consort of Shamash',0,false,false,'Aya, the dawn goddess and consort of the sun-god Shamash.'),
 ('ENT_MES_BELET_ILI','Belet-ili','Mesopotamian','Goddess','Mother/birth deity','the creation of humankind; birth','Mesopotamian','A','candidate_verified_name','Birth-mother goddess',1,false,false,'Belet-ili (Mami/Nintu), the womb-goddess who fashions humankind from clay in Atrahasis.'),
 -- monsters and the demon register
 ('ENT_MES_MUSHHUSHSHU','Mushhushshu','Mesopotamian','Monster','Dragon','the snake-dragon; the symbol of Marduk','Mesopotamian','A','candidate_verified_name','Dragon of Marduk',0,true,true,'The snake-dragon ("furious serpent") of the Ishtar Gate, emblem of Marduk and Nabu.'),
 ('ENT_MES_BASHMU','Bashmu','Mesopotamian','Monster','Horned serpent','the venomous horned serpent','Mesopotamian','B','candidate_verified_name','Serpent monster',0,true,true,'Bashmu, the horned venomous serpent among the monsters of Tiamat.'),
 ('ENT_MES_GIRTABLULLU','Girtablullu','Mesopotamian','Monster','Scorpion-man','the scorpion-men; the guarding of the sun''s gate','Mesopotamian','B','candidate_verified_name','Scorpion-man',0,false,false,'The scorpion-men who guard the gate of Mount Mashu where the sun rises.'),
 ('ENT_MES_UGALLU','Ugallu','Mesopotamian','Demon','Apotropaic demon','storm; protection of the threshold','Mesopotamian','B','candidate_verified_name','Apotropaic lion-demon',0,true,false,'The "Big Weather-Beast," a lion-headed storm demon used apotropaically at doorways.'),
 ('ENT_MES_KUSARIKKU','Kusarikku','Mesopotamian','Monster','Bull-man','the bull-man; the guardian of the sun','Mesopotamian','B','candidate_verified_name','Bull-man',0,false,false,'The bull-man, attendant of the sun-god and a guardian figure.'),
 ('ENT_MES_ASAG','Asag','Mesopotamian','Demon','Disease demon','disease; the stones; chaos','Mesopotamian','A','candidate_verified_name','Demon slain by Ninurta',0,true,false,'Asag (Asakku), the monstrous demon of disease slain by Ninurta in the Lugale.'),
 ('ENT_MES_HUMBABA','Humbaba','Mesopotamian','Monster','Forest guardian','the Cedar Forest; the terrifying radiance','Mesopotamian','A','candidate_verified_name','Forest guardian monster',1,false,false,'Humbaba (Huwawa), the fearsome guardian of the Cedar Forest, slain by Gilgamesh and Enkidu.'),
 ('ENT_MES_LILITU','Lilitu','Mesopotamian','Demon','Night demoness','the night; the wind; the seduction of men','Mesopotamian','B','candidate_verified_name','Night demoness (Lilith ancestor)',0,true,false,'Lilitu (with Lilu and Ardat-lili), a night/wind demoness, a forerunner of the later Lilith.'),
 ('ENT_MES_EDIMMU','Edimmu','Mesopotamian','Spirit','Ghost of the dead','the restless dead; haunting; affliction','Mesopotamian','B','candidate_verified_name','Vengeful ghost class',0,true,false,'The edimmu, the restless ghost of one improperly buried, who afflicts the living.'),
 -- the Erra epic
 ('ENT_MES_ERRA','Erra','Mesopotamian','God','Plague/war deity','plague; war; violence; destruction','Mesopotamian','A','candidate_verified_name','God of plague and war',0,false,false,'Erra (Errakal), the god of plague, war and indiscriminate destruction; protagonist of the Erra Epic.'),
 ('ENT_MES_ISHUM','Ishum','Mesopotamian','God','Herald/fire deity','fire; the night-watch; restraint; the herald of Erra','Mesopotamian','B','candidate_verified_name','Herald of Erra',0,false,false,'Ishum, the benevolent fire-god and herald who restrains the fury of Erra.'),
 ('ENT_MES_SEBITTI','Sebitti','Mesopotamian','Deity collective','The Seven','the seven warrior-gods; the weapons of Erra; the Pleiades','Mesopotamian','A','candidate_verified_name','The Seven warrior-gods',0,false,false,'The Sebitti, the seven warrior-gods born of Anu, weapons of Erra, identified with the Pleiades.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_MES_GULA','SRC_ETCSL','direct attestation','The Sumerian hymns to Nininsina/Gula (ETCSL); Bullussa-rabi''s Gula Hymn.'),
 ('ENT_MES_NANSHE','SRC_ETCSL','direct attestation','The Nanshe Hymn (ETCSL 4.14.1): the goddess of justice, divination and the poor of Lagash.'),
 ('ENT_MES_NINGIRSU','SRC_ETCSL','direct attestation','The Gudea Cylinders (ETCSL 2.1.7): Ningirsu and the building of the Eninnu at Lagash.'),
 ('ENT_MES_BAU','SRC_ETCSL','direct attestation','The Gudea Cylinders and Lagash hymns (ETCSL): Bau (Baba), consort of Ningirsu.'),
 ('ENT_MES_NINAZU','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green, Gods, Demons and Symbols: Ninazu, underworld/healing god, father of Ningishzida.'),
 ('ENT_MES_NINGISHZIDA','SRC_ETCSL','direct attestation','The Gudea Cylinders (ETCSL): Ningishzida, the personal god of Gudea, chthonic serpent god.'),
 ('ENT_MES_SHARA','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: Shara, the city-god of Umma, son of Inanna.'),
 ('ENT_MES_ISHTARAN','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: Ishtaran, divine judge and city-god of Der.'),
 ('ENT_MES_ZABABA','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: Zababa, the warrior city-god of Kish.'),
 ('ENT_MES_DAMU','SRC_ETCSL','direct attestation','The Sumerian Damu laments (ETCSL): the dying-and-returning healing god, son of Gula.'),
 ('ENT_MES_NINKASI','SRC_ETCSL','direct attestation','The Hymn to Ninkasi (ETCSL 4.23.1): the goddess of beer and brewing.'),
 ('ENT_MES_NANAYA','SRC_ETCSL','direct attestation','The Sumerian love songs (ETCSL): Nanaya, goddess of love and sensuality.'),
 ('ENT_MES_NUSKA','SRC_ETCSL','direct attestation','The Sumerian hymns (ETCSL): Nuska, god of fire and light, vizier of Enlil.'),
 ('ENT_MES_LUGALBANDA','SRC_ETCSL','direct attestation','Lugalbanda in the Mountain Cave / Lugalbanda and the Anzud Bird (ETCSL 1.8.2.1-2).'),
 ('ENT_MES_ADAPA','SRC_FOSTER_MUSES','direct attestation','The Adapa myth (Foster, Before the Muses): the sage who refused the bread and water of life.'),
 ('ENT_MES_ETANA','SRC_FOSTER_MUSES','direct attestation','The Etana Epic (Foster, Before the Muses): the king who flew to heaven on the eagle.'),
 ('ENT_MES_NAMTAR','SRC_ETCSL','direct attestation','The Descent of Inanna (ETCSL 1.4.1): Namtar, the death-demon vizier of Ereshkigal.'),
 ('ENT_MES_NETI','SRC_ETCSL','direct attestation','The Descent of Inanna (ETCSL 1.4.1): Neti, the chief gatekeeper of the underworld.'),
 ('ENT_MES_BELET_SERI','SRC_GEORGE_GILGAMESH','direct attestation','Gilgamesh / the Descent of Ishtar: Belet-seri, the scribe who keeps the register of the dead.'),
 ('ENT_MES_GUGALANNA','SRC_GEORGE_GILGAMESH','direct attestation','Gilgamesh VI; the Descent of Inanna: the Bull of Heaven, Ereshkigal''s husband.'),
 ('ENT_MES_LAHMU','SRC_ENUMA_ELISH','direct attestation','Enuma Elish I.10: Lahmu and Lahamu, the first pair brought forth by Apsu and Tiamat.'),
 ('ENT_MES_ANSHAR','SRC_ENUMA_ELISH','direct attestation','Enuma Elish I.12-16: Anshar, who marshals the gods and sends Marduk against Tiamat.'),
 ('ENT_MES_KISHAR','SRC_ENUMA_ELISH','direct attestation','Enuma Elish I.12: Kishar, consort of Anshar.'),
 ('ENT_MES_MUMMU','SRC_ENUMA_ELISH','direct attestation','Enuma Elish I.30-72: Mummu, vizier of Apsu, bound by Ea.'),
 ('ENT_MES_DAMKINA','SRC_ENUMA_ELISH','direct attestation','Enuma Elish I.78-84: Damkina, consort of Ea, mother of Marduk.'),
 ('ENT_MES_SARPANIT','SRC_ENUMA_ELISH','direct attestation','Enuma Elish; the Babylon cult: Sarpanit, consort of Marduk.'),
 ('ENT_MES_AYA','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: Aya, dawn goddess and consort of Shamash.'),
 ('ENT_MES_BELET_ILI','SRC_ATRAHASIS','direct attestation','Atrahasis I: Belet-ili/Mami fashions humankind from clay mixed with the blood of a slain god.'),
 ('ENT_MES_MUSHHUSHSHU','SRC_ENUMA_ELISH','direct attestation','Enuma Elish I.140-143: the mushhushshu among Tiamat''s monsters; later the emblem of Marduk.'),
 ('ENT_MES_BASHMU','SRC_ENUMA_ELISH','direct attestation','Enuma Elish I.140-143: the bashmu (horned serpent) among the monsters of Tiamat.'),
 ('ENT_MES_GIRTABLULLU','SRC_GEORGE_GILGAMESH','direct attestation','Gilgamesh IX: the scorpion-men (girtablullu) who guard the gate of Mount Mashu.'),
 ('ENT_MES_UGALLU','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: the ugallu, lion-headed storm demon used as an apotropaic doorway figure.'),
 ('ENT_MES_KUSARIKKU','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: the kusarikku (bull-man), guardian attendant of the sun-god.'),
 ('ENT_MES_ASAG','SRC_ETCSL','direct attestation','Lugale (Ninurta''s Exploits, ETCSL 1.6.2): Asag, the disease-demon slain by Ninurta.'),
 ('ENT_MES_HUMBABA','SRC_GEORGE_GILGAMESH','direct attestation','Gilgamesh II-V: Humbaba (Huwawa), guardian of the Cedar Forest, slain by Gilgamesh and Enkidu.'),
 ('ENT_MES_LILITU','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: lilu/lilitu/ardat-lili, the night demons, forerunners of Lilith.'),
 ('ENT_MES_EDIMMU','SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green: the edimmu, the restless ghost of the improperly buried dead.'),
 ('ENT_MES_ERRA','SRC_FOSTER_MUSES','direct attestation','The Erra Epic (Foster, Before the Muses): Erra, god of plague and war.'),
 ('ENT_MES_ISHUM','SRC_FOSTER_MUSES','direct attestation','The Erra Epic (Foster, Before the Muses): Ishum, the herald who restrains Erra.'),
 ('ENT_MES_SEBITTI','SRC_FOSTER_MUSES','direct attestation','The Erra Epic (Foster, Before the Muses): the Sebitti, the seven warrior-gods, weapons of Erra.')
ON CONFLICT DO NOTHING;

-- ── Periods ──────────────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_MES_EARLY', 'A', 'Sumerian-attested deity/figure (Early Dynastic–Ur III literary tradition).', 'reviewed'
FROM entities WHERE tradition='Mesopotamian' AND canonical_name IN
 ('Gula','Nanshe','Ningirsu','Bau','Ninazu','Ningishzida','Shara','Ishtaran','Zababa','Damu',
  'Ninkasi','Nanaya','Nuska','Lugalbanda','Namtar','Neti','Asag')
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_MES_OLD_BAB', 'A', 'Attested in Old Babylonian literature (Enuma Elish, Atrahasis, the Gilgamesh tradition).', 'reviewed'
FROM entities WHERE tradition='Mesopotamian' AND canonical_name IN
 ('Lahmu','Anshar','Kishar','Mummu','Damkina','Sarpanit','Aya','Belet-ili','Belet-seri','Adapa','Etana',
  'Mushhushshu','Bashmu','Girtablullu','Kusarikku','Humbaba','Gugalanna')
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_MES_NEO_ASS', 'A', 'Attested in the first-millennium corpus (the Erra Epic; the apotropaic/incantation series).', 'reviewed'
FROM entities WHERE tradition='Mesopotamian' AND canonical_name IN
 ('Erra','Ishum','Sebitti','Ugallu','Lilitu','Edimmu')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 -- the Enuma Elish theogony
 ('ENT_MES_LAHMU','child_of','ENT_MES_APSU','high','Apsu and Tiamat bring forth Lahmu and Lahamu (Enuma Elish I.10).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_ANSHAR','child_of','ENT_MES_LAHMU','high','Lahmu and Lahamu beget Anshar and Kishar (Enuma Elish I.12).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_KISHAR','consort_of','ENT_MES_ANSHAR','high','Anshar and Kishar, the horizons of heaven and earth (Enuma Elish I.12).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_ANU','child_of','ENT_MES_ANSHAR','high','Anshar begets Anu (Enuma Elish I.14).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_MUMMU','aligned_with','ENT_MES_APSU','high','Mummu is the vizier and counsellor of Apsu (Enuma Elish I.30-48).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_MARDUK','slays','ENT_MES_TIAMAT','high','Marduk slays Tiamat and forms the cosmos from her body (Enuma Elish IV).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_TIAMAT','creator_of','ENT_MES_MUSHHUSHSHU','high','The mushhushshu is among the eleven monsters Tiamat creates (Enuma Elish I.140-143).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_MUSHHUSHSHU','aligned_with','ENT_MES_MARDUK','high','After Tiamat''s defeat the mushhushshu becomes the emblematic dragon of Marduk.','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_TIAMAT','creator_of','ENT_MES_BASHMU','medium','The bashmu (horned serpent) is among Tiamat''s monster host (Enuma Elish I.140-143).','SRC_ENUMA_ELISH','reviewed'),
 -- the Ea/Marduk family
 ('ENT_MES_DAMKINA','consort_of','ENT_MES_ENKI_EA','high','Damkina is the consort of Ea (Enuma Elish I.78-84).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_DAMKINA','parent_of','ENT_MES_MARDUK','high','Damkina is the mother of Marduk (Enuma Elish I.83-84).','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_SARPANIT','consort_of','ENT_MES_MARDUK','high','Sarpanit is the consort of Marduk.','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_SARPANIT','parent_of','ENT_MES_NABU','high','Sarpanit, with Marduk, is the mother of Nabu.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_NABU','child_of','ENT_MES_MARDUK','high','Nabu is the son of Marduk.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_ADAPA','child_of','ENT_MES_ENKI_EA','high','Adapa, the sage of Eridu, is the son/creature of Ea.','SRC_FOSTER_MUSES','reviewed'),
 ('ENT_MES_BELET_ILI','participates_in_creation','ENT_CREATION','high','Belet-ili/Mami fashions humankind from clay in Atrahasis.','SRC_ATRAHASIS','reviewed'),
 -- the sun and dawn
 ('ENT_MES_AYA','consort_of','ENT_MES_UTU_SHAMASH','high','Aya, the dawn goddess, is the consort of the sun-god Shamash.','SRC_BLACK_GREEN_MESO','reviewed'),
 -- Lagash circle
 ('ENT_MES_NINGIRSU','identified_with','ENT_MES_NINURTA','high','Ningirsu of Lagash is a local form of the warrior god Ninurta.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_BAU','consort_of','ENT_MES_NINGIRSU','high','Bau (Baba) is the consort of Ningirsu at Lagash.','SRC_ETCSL','reviewed'),
 ('ENT_MES_NINGISHZIDA','child_of','ENT_MES_NINAZU','high','Ningishzida is the son of Ninazu.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_DAMU','child_of','ENT_MES_GULA','medium','Damu, the healing/dying god, is the son of Gula.','SRC_ETCSL','reviewed'),
 ('ENT_MES_NANSHE','child_of','ENT_MES_ENKI_EA','medium','Nanshe is a daughter of Ea/Enki.','SRC_ETCSL','reviewed'),
 ('ENT_MES_NUSKA','aligned_with','ENT_MES_ENLIL','high','Nuska is the vizier and messenger of Enlil.','SRC_ETCSL','reviewed'),
 ('ENT_MES_NUSKA','embodies','ENT_FIRE','medium','Nuska is the deified fire and lamplight.','SRC_ETCSL','reviewed'),
 -- Ninurta and Asag; Anzu
 ('ENT_MES_ASAG','slain_by','ENT_MES_NINURTA','high','Ninurta destroys the demon Asag in the Lugale.','SRC_ETCSL','reviewed'),
 ('ENT_MES_ANZU','slain_by','ENT_MES_NINURTA','high','Ninurta slays the Anzu bird and recovers the Tablet of Destinies.','SRC_FOSTER_MUSES','reviewed'),
 -- underworld
 ('ENT_MES_NAMTAR','aligned_with','ENT_MES_ERESHKIGAL','high','Namtar is the death-demon vizier of Ereshkigal.','SRC_ETCSL','reviewed'),
 ('ENT_MES_NAMTAR','embodies','ENT_DEATH','high','Namtar ("Fate") is the bringer of death and plague.','SRC_ETCSL','reviewed'),
 ('ENT_MES_NETI','aligned_with','ENT_MES_ERESHKIGAL','high','Neti, the gatekeeper, serves Ereshkigal at the seven gates.','SRC_ETCSL','reviewed'),
 ('ENT_MES_BELET_SERI','aligned_with','ENT_MES_ERESHKIGAL','medium','Belet-seri is the scribe in the court of Ereshkigal.','SRC_GEORGE_GILGAMESH','reviewed'),
 ('ENT_MES_GUGALANNA','consort_of','ENT_MES_ERESHKIGAL','high','Gugalanna, the Bull of Heaven, is the first husband of Ereshkigal.','SRC_ETCSL','reviewed'),
 ('ENT_MES_GUGALANNA','slain_by','ENT_MES_GILGAMESH','high','Gilgamesh and Enkidu slay the Bull of Heaven (Gilgamesh VI).','SRC_GEORGE_GILGAMESH','reviewed'),
 -- Gilgamesh cycle and deified kings
 ('ENT_MES_HUMBABA','slain_by','ENT_MES_GILGAMESH','high','Gilgamesh and Enkidu slay Humbaba in the Cedar Forest (Gilgamesh V).','SRC_GEORGE_GILGAMESH','reviewed'),
 ('ENT_MES_LUGALBANDA','parent_of','ENT_MES_GILGAMESH','high','Lugalbanda is the father of Gilgamesh.','SRC_GEORGE_GILGAMESH','reviewed'),
 ('ENT_MES_LUGALBANDA','consort_of','ENT_MES_NINSUN','high','Lugalbanda is the husband of the goddess Ninsun.','SRC_GEORGE_GILGAMESH','reviewed'),
 -- the Erra epic
 ('ENT_MES_ERRA','identified_with','ENT_MES_NERGAL','high','Erra, god of plague and war, is closely identified with Nergal.','SRC_FOSTER_MUSES','reviewed'),
 ('ENT_MES_ISHUM','aligned_with','ENT_MES_ERRA','high','Ishum is the herald of Erra who restrains his fury.','SRC_FOSTER_MUSES','reviewed'),
 ('ENT_MES_SEBITTI','aligned_with','ENT_MES_ERRA','high','The Sebitti are the seven warrior-gods who serve as the weapons of Erra.','SRC_FOSTER_MUSES','reviewed'),
 ('ENT_MES_SEBITTI','child_of','ENT_MES_ANU','medium','The Sebitti are born of Anu (the Erra Epic I).','SRC_FOSTER_MUSES','reviewed'),
 -- the lil-demons
 ('ENT_MES_LILITU','aligned_with','ENT_MES_LAMASHTU','medium','Lilitu stands among the female night-demons alongside Lamashtu.','SRC_BLACK_GREEN_MESO','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Mesopotamian entities' AS label, count(*) FROM entities WHERE tradition='Mesopotamian';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS undated_mes FROM entities e WHERE e.tradition='Mesopotamian'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT count(*) AS dup_pairs FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d;
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
