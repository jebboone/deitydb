-- =====================================================================
-- deepen_egyptian.sql  (v1.58.0)
-- Content deepening: bring the Egyptian roster up to the cataloguing depth
-- the Greek set enjoys.  Egyptian ~91 -> ~187.  +96 entities.
--
-- Five verified groups (every name attested to a primary text / scholarly
-- edition; rosters cross-checked by four research passes; NOTHING fabricated
-- — uncertain readings were deliberately excluded):
--   1. The 42 Assessors of Maat (Book of the Dead, Spell 125)         +43
--   2. The Duat cast (Amduat / Book of Gates / Litany of Re)          +22
--   3. The Egyptian astronomical decans (Sopdet, Sah, the system)      +3
--   4. Deified humans (Imhotep, Amenhotep s. Hapu, Heqaib, Isi)        +4
--   5. Nome / local gods + pan-Egyptian omissions                     +24
--
-- Mandulis intentionally NOT added (already ENT_MER_MANDULIS, Meroitic).
-- Sia / Hu / Nun / Tatenen / Khepri / Atum / Shu / Tefnut / Nut / Geb /
-- Nephthys / Aker / Mehen already existed and were reused, not duplicated.
-- The 36 decan NAMES are NOT reconstructed (readings contested; would be
-- fabrication) — only Sopdet, Sah, and the decanal system as a collective.
-- The Testament-of-Solomon decan-demons (ENT_LAT_DECAN_*) are wired as the
-- Hellenistic reception of the Egyptian system.
-- Additive; ON CONFLICT DO NOTHING; verify block at the end.
-- =====================================================================

BEGIN;

-- ---------------------------------------------------------------------
-- (a) SOURCES
-- ---------------------------------------------------------------------
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
  ('SRC_FAULKNER_BOOK_OF_DEAD',
   'R. O. Faulkner, The Ancient Egyptian Book of the Dead, ed. Carol Andrews (British Museum Press, 1972; rev. 1985)',
   NULL, 'primary text', 'Egyptian funerary literature'),
  ('SRC_BUDGE_PAPYRUS_ANI',
   'E. A. Wallis Budge, The Book of the Dead: The Papyrus of Ani (London, 1895/1913)',
   'https://archive.org/details/papyrusofanirepr01budg', 'primary text', 'Egyptian funerary literature'),
  ('SRC_PIANKOFF_LITANY_RE',
   'Alexandre Piankoff, The Litany of Re (Egyptian Religious Texts and Representations 4 / Bollingen XL.4, 1964)',
   NULL, 'primary text', 'Egyptian afterlife literature'),
  ('SRC_NEUGEBAUER_PARKER_EAT',
   'O. Neugebauer & R. A. Parker, Egyptian Astronomical Texts, 3 vols. (Brown Univ. Press / Lund Humphries, 1960-1969)',
   NULL, 'secondary scholarship', 'Egyptian astronomy / the decans'),
  ('SRC_HABACHI_HEQAIB',
   'Labib Habachi, The Sanctuary of Heqaib (Elephantine IV; Deutsches Archäologisches Institut, Mainz, 1985)',
   NULL, 'secondary scholarship', 'Egyptian deified humans')
ON CONFLICT (source_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (b1) ENTITIES — the 42 Assessors of Maat + their collective
--      canonical_name = Budge/Ani transliteration; note gives the
--      Faulkner sense, the place "he comes forth from", and the sin denied.
-- ---------------------------------------------------------------------
INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains,
   cult_scope, evidence_confidence, review_status, inclusion_basis,
   earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_EGY_FORTYTWO_ASSESSORS','The Forty-Two Assessors of Maat','Egyptian','Divine tribunal','Judges of the dead',
  'judgment of the dead; the Hall of the Two Truths; the Negative Confession','funerary','A','candidate_verified_name',
  'Book of the Dead Spell 125',0,true,false,
  'The tribunal of 42 divine judges before whom the deceased recites the Declaration of Innocence (the "Negative Confession") in the Hall of the Two Truths, each judge hearing the denial of one specific sin. Book of the Dead Spell 125.'),
 ('ENT_EGY_ASSESSOR_01','Usekh-nemmt','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 1 of Maat (BD 125), "Far-strider," comes forth from Heliopolis (Anu); the deceased denies wrongdoing before him.'),
 ('ENT_EGY_ASSESSOR_02','Hept-khet','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 2 of Maat (BD 125), "Fire-embracer," from Kher-aha; the deceased denies robbery with violence.'),
 ('ENT_EGY_ASSESSOR_03','Fenti','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 3 of Maat (BD 125), "Nose," from Hermopolis (Khemenu); the deceased denies theft.'),
 ('ENT_EGY_ASSESSOR_04','Am-khaibit','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 4 of Maat (BD 125), "Devourer of Shades," from the Cavern (Qernet); the deceased denies murder.'),
 ('ENT_EGY_ASSESSOR_05','Neha-her','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 5 of Maat (BD 125), "Evil-faced," from Rosetau; the deceased denies stealing grain.'),
 ('ENT_EGY_ASSESSOR_06','Ruruti','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 6 of Maat (BD 125), "Double Lion," from the sky; the deceased denies destroying offerings.'),
 ('ENT_EGY_ASSESSOR_07','Arfi-em-khet','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 7 of Maat (BD 125), "Fiery-eyes," from Letopolis (Khem); the deceased denies stealing the property of a god.'),
 ('ENT_EGY_ASSESSOR_08','Neba','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 8 of Maat (BD 125), "Flame" / he who comes forth backwards; the deceased denies lies and stealing offerings.'),
 ('ENT_EGY_ASSESSOR_09','Set-qesu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 9 of Maat (BD 125), "Crusher of bones," from Heracleopolis (Hensu); the deceased denies lies.'),
 ('ENT_EGY_ASSESSOR_10','Utu-nesert','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 10 of Maat (BD 125), "Commander of fire," from Memphis (Het-ka-Ptah); the deceased denies stealing food.'),
 ('ENT_EGY_ASSESSOR_11','Qerrti','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 11 of Maat (BD 125), "Dweller in the cavern," from the West (Amentet); the deceased denies adultery.'),
 ('ENT_EGY_ASSESSOR_12','Hraf-haf','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor of Maat (BD 125), "Backward-facing," from the West; the deceased denies causing tears. (Budge/Ani place him at #12, Faulkner at #27 — a manuscript order variant.)'),
 ('ENT_EGY_ASSESSOR_13','Basti','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 13 of Maat (BD 125), "Eater of entrails," from Bubastis (Bast); the deceased denies foul deeds. (Distinct from the goddess Bastet.)'),
 ('ENT_EGY_ASSESSOR_14','Ta-retiu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 14 of Maat (BD 125), "He of the night," from the night/Hall of Thirty; the deceased denies perjury and assault.'),
 ('ENT_EGY_ASSESSOR_15','Unem-snef','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 15 of Maat (BD 125), "Eater of blood," from the slaughter-place; the deceased denies killing the sacred cattle.'),
 ('ENT_EGY_ASSESSOR_16','Unem-besek','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 16 of Maat (BD 125), "Eater of entrails," from Mabit; the deceased denies stealing cultivated land.'),
 ('ENT_EGY_ASSESSOR_17','Neb-Maat','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 17 of Maat (BD 125), "Lord of Maat," from Maati; the deceased denies eavesdropping.'),
 ('ENT_EGY_ASSESSOR_18','Tenemiu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 18 of Maat (BD 125), "Wanderer," from Bubastis; the deceased denies slander.'),
 ('ENT_EGY_ASSESSOR_19','Sertiu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 19 of Maat (BD 125), "He who acts willfully," from Heliopolis (Anu); the deceased denies anger without cause.'),
 ('ENT_EGY_ASSESSOR_20','Tutu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 20 of Maat (BD 125), "Doubly evil," from the House of Min (Ati); the deceased denies adultery. (Distinct from the apotropaic god Tutu/Tithoes.)'),
 ('ENT_EGY_ASSESSOR_21','Uamenti','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 21 of Maat (BD 125), "He of the underworld," from the Khebt chamber; the deceased denies defiling another man''s wife.'),
 ('ENT_EGY_ASSESSOR_22','Maa-antuf','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 22 of Maat (BD 125), "He who sees what he brings," from Xois (Per-Menu); the deceased denies self-pollution.'),
 ('ENT_EGY_ASSESSOR_23','Her-uru','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 23 of Maat (BD 125), "Chief of the great ones," from Nehatu; the deceased denies inspiring terror.'),
 ('ENT_EGY_ASSESSOR_24','Khemiu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 24 of Maat (BD 125), "Destroyer," from Kaui; the deceased denies transgressing the law.'),
 ('ENT_EGY_ASSESSOR_25','Shet-kheru','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 25 of Maat (BD 125), "Orderer of speech," from Urit (Wenes); the deceased denies stirring strife.'),
 ('ENT_EGY_ASSESSOR_26','Nekhenu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 26 of Maat (BD 125), "Hooded one," from the secret place (Heqat); the deceased denies hoodwinking / shutting his ears to truth.'),
 ('ENT_EGY_ASSESSOR_27','Kenemti','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor of Maat (BD 125), "Dark one," from Kenmet (the Faiyum); the deceased denies blasphemy. (Budge/Ani #27, Faulkner #12 — order variant.)'),
 ('ENT_EGY_ASSESSOR_28','An-hetep-f','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 28 of Maat (BD 125), "Bringer of his offering," from Sais (Sau); the deceased denies acts of violence.'),
 ('ENT_EGY_ASSESSOR_29','Sera-kheru','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 29 of Maat (BD 125), "Disposer of speech," from Unaset (the darkness); the deceased denies quarrelling.'),
 ('ENT_EGY_ASSESSOR_30','Neb-heru','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 30 of Maat (BD 125), "Lord of faces," from Netchfet; the deceased denies acting in haste.'),
 ('ENT_EGY_ASSESSOR_31','Sekhriu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 31 of Maat (BD 125), "Plan-maker," from Uten; the deceased denies prying into others'' affairs.'),
 ('ENT_EGY_ASSESSOR_32','Neb-abui','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 32 of Maat (BD 125), "Lord of horns," from Asyut (Sauti); the deceased denies multiplying words in strife.'),
 ('ENT_EGY_ASSESSOR_33','Nefer-Tem','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 33 of Maat (BD 125), "Nefertem," from Memphis (Het-ka-Ptah); the deceased denies doing evil. (Assessor bearing the name of the god Nefertem; distinct entry.)'),
 ('ENT_EGY_ASSESSOR_34','Tem-Sepu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 34 of Maat (BD 125), "Temsep," from Busiris (Tetu); the deceased denies witchcraft against the king.'),
 ('ENT_EGY_ASSESSOR_35','Ari-em-ab-f','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 35 of Maat (BD 125), "Doer in his heart," from Tjebu; the deceased denies stopping a neighbour''s water.'),
 ('ENT_EGY_ASSESSOR_36','Ahi','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 36 of Maat (BD 125), "Watery one," from the abyss (Nu); the deceased denies being loud-voiced.'),
 ('ENT_EGY_ASSESSOR_37','Uatch-rekhit','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 37 of Maat (BD 125), "Commander of mankind," from Sais (Sau); the deceased denies cursing a god.'),
 ('ENT_EGY_ASSESSOR_38','Neheb-ka','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 38 of Maat (BD 125), "Nehebka," from the Harpoon nome; the deceased denies arrogance. (Assessor bearing the name of the serpent-god Nehebkau; distinct entry.)'),
 ('ENT_EGY_ASSESSOR_39','Neheb-nefert','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 39 of Maat (BD 125), "Bestower of powers," from his city; the deceased denies stealing the bread of the gods.'),
 ('ENT_EGY_ASSESSOR_40','Tcheser-tep','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,true,'Assessor 40 of Maat (BD 125), "Holy of head" / serpent with raised head, from the shrine; the deceased denies carrying off the cakes of the blessed dead.'),
 ('ENT_EGY_ASSESSOR_41','An-af','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 41 of Maat (BD 125), "Bringer of his arm," from Maati; the deceased denies despising the local god.'),
 ('ENT_EGY_ASSESSOR_42','Hetch-abhu','Egyptian','Assessor of Maat','Judge of the dead','judgment of the dead','funerary','A','candidate_verified_name','Book of the Dead Spell 125',0,true,false,'Assessor 42 of Maat (BD 125), "White of teeth," from the Faiyum (Ta-she); the deceased denies slaying the cattle of the god.')
ON CONFLICT (entity_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (b2) ENTITIES — the Duat cast (Amduat / Book of Gates / Litany of Re)
-- ---------------------------------------------------------------------
INSERT INTO entities
  (entity_id, canonical_name, greek_name, tradition, entity_type, category, primary_domains,
   cult_scope, evidence_confidence, review_status, inclusion_basis,
   earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_EGY_AFRA','Af-Ra (Flesh of Ra)',NULL,'Egyptian','Hidden form of Ra','Night-sun',
  'the night journey; union of Ra and Osiris; nocturnal regeneration','funerary','A','candidate_verified_name','Amduat / Book of Gates',0,true,false,
  'The ram-headed night form of the sun god — Ra united with his own corpse — who sails the barque through the Duat to be reborn at dawn. Central protagonist of the Amduat and Book of Gates.'),
 ('ENT_EGY_MAUAA','Mau-aa (the Great Cat of Ra)',NULL,'Egyptian','Solar form','Punishing form of Ra',
  'protection of the sun; slaying of Apophis','funerary','A','candidate_verified_name','Litany of Re / BD 17',0,true,false,
  'The great tomcat, a form of the sun god who slays the serpent Apophis beneath the ished-tree; an iconic protective/punishing aspect of Ra. Litany of Re; Book of the Dead Spell 17.'),
 ('ENT_EGY_HEKA','Heka',NULL,'Egyptian','Personified power','Divine magic',
  'magic; the creative force; the barque crew','national','A','candidate_verified_name','Coffin Texts / Amduat',0,false,false,
  'The deification of heka, magic itself — the primal creative force that even the gods wield. Paired with Sia (perception) and Hu (utterance); crews the solar barque. Cult role at Esna.'),
 ('ENT_EGY_NEBETWIA','Nebet-wia (Mistress of the Barque)',NULL,'Egyptian','Solar barque crew','Personified barque',
  'the night barque of Ra','funerary','B','candidate_verified_name','Amduat',0,true,false,
  'The goddess personifying the solar night-barque itself, named among its crew in the Amduat.'),
 ('ENT_EGY_KAMAAT','Ka-Maat (Bull of Maat)',NULL,'Egyptian','Solar barque crew','Crew of Ra',
  'the night barque; truth','funerary','B','candidate_verified_name','Amduat',0,true,false,
  'The "Bull of Maat," a member of the crew of Ra''s night barque in the Amduat.'),
 ('ENT_EGY_HEREHEQENU','Hereheqenu (Horus the Praiser)',NULL,'Egyptian','Solar barque crew','Crew of Ra',
  'the night barque; praise of the sun','funerary','B','candidate_verified_name','Amduat',0,true,false,
  'Horus-of-praise, a member of the crew of the solar night-barque in the Amduat.'),
 ('ENT_EGY_NEHES','Nehes (the Watchful One)',NULL,'Egyptian','Solar barque crew','Crew of Ra',
  'wakefulness; guarding the barque','funerary','B','candidate_verified_name','Amduat',0,true,false,
  'The "Awakener / Watchful One," the crew-member who keeps watch in the solar night-barque (Amduat).'),
 ('ENT_EGY_ANKHNETERU','Ankh-neteru (the World-Encircling Serpent)',NULL,'Egyptian','Underworld serpent','Serpent of regeneration',
  'nocturnal rebirth; the twelfth hour','funerary','B','candidate_verified_name','Amduat, 12th hour',0,true,true,
  'The great serpent ("Life of the Gods") through whose body the barque is towed in the Amduat''s twelfth hour, the sun entering aged and emerging reborn as Khepri.'),
 ('ENT_EGY_SAASET','Saa-Set (gate-serpent of the Book of Gates)',NULL,'Egyptian','Underworld serpent guardian','Gate-keeper',
  'guarding the gates of the Duat','funerary','B','candidate_verified_name','Book of Gates, gate 2',0,true,true,
  'An upright guardian serpent whose name must be known for the barque to pass; opens the second gate of the night (Book of Gates).'),
 ('ENT_EGY_TEKAHER','Teka-her (Flaming-Face)',NULL,'Egyptian','Underworld serpent guardian','Gate-keeper',
  'guarding the gates of the Duat','funerary','B','candidate_verified_name','Book of Gates, gate 4',0,true,true,
  '"He of the flaming face," an upright serpent guarding the fourth-hour gate of the Book of Gates (also Amduat, hour 3).'),
 ('ENT_EGY_SETEMMAATF','Set-em-maat-f (Guardian of the Hall of Maat)',NULL,'Egyptian','Underworld serpent guardian','Gate-keeper',
  'guarding the Judgment Hall','funerary','B','candidate_verified_name','Book of Gates, gate 6',0,true,true,
  'The serpent set as guardian before the sixth gate, the Judgment Hall of Osiris (Book of Gates).'),
 ('ENT_EGY_AKHEKHI','Akhekhi (guardian of the final gate)',NULL,'Egyptian','Underworld guardian','Gate-keeper',
  'guarding the twelfth gate of the Duat','funerary','C','candidate_verified_name','Book of Gates, gate 12',0,true,false,
  'A named guardian of the final ("Sacred Power") gate of the Book of Gates, paired with the guardian Pai. (Distinct from the winged Set-creature Akhekh.)'),
 ('ENT_EGY_FOUR_RACES','The Four Races of Mankind',NULL,'Egyptian','Anthropological collective','Peoples of the sun',
  'the four kinds of humanity; the equal care of Ra','funerary','A','candidate_verified_name','Book of Gates, 5th division',0,false,false,
  'The four peoples shepherded by Ra/Horus in the Book of Gates — Reth (Egyptians), Aamu (Asiatics), Nehesu (Nubians), Themehu (Libyans) — all destined for the afterlife.'),
 ('ENT_EGY_ENEMIES_OF_RA','The Enemies of Ra (the Damned)',NULL,'Egyptian','Underworld collective','The condemned dead',
  'rebellion against the sun; annihilation in the pits of fire','funerary','A','candidate_verified_name','Amduat / Book of Gates',0,true,false,
  'The bound, beheaded, and burned foes of the sun god — rebels condemned to the fire-pits of the Duat, their bodies, bas, and shadows annihilated.'),
 ('ENT_EGY_SEKHET_AARU','Sekhet-Aaru (Field of Reeds)',NULL,'Egyptian','Afterlife realm','Paradise of the blessed',
  'the paradise of the justified dead; the idealized Nile','funerary','A','candidate_verified_name','Book of the Dead',0,true,false,
  'The "Field of Reeds," the paradisal marsh-realm of the justified dead — an idealized Egypt where the blessed dwell and labour in plenty.'),
 ('ENT_EGY_SEKHET_HETEPET','Sekhet-Hetepet (Field of Offerings)',NULL,'Egyptian','Afterlife realm','Realm of provisioning',
  'the provisioning of the blessed dead','funerary','A','candidate_verified_name','Book of the Dead',0,true,false,
  'The "Field of Offerings / Field of Peace," the companion realm to the Field of Reeds where the blessed dead are eternally provisioned.'),
 ('ENT_EGY_WERNES','Wernes',NULL,'Egyptian','Duat region','Watery realm',
  'the watery realm of the second hour','funerary','B','candidate_verified_name','Amduat, 2nd hour',0,true,false,
  'The great fertile water-realm of the Amduat''s second hour, across which the solar barque sails.'),
 ('ENT_EGY_ROSETAU','Rosetau',NULL,'Egyptian','Duat region','Realm of Sokar',
  'the hidden passages of the necropolis-underworld','funerary','A','candidate_verified_name','Amduat, 4th-5th hours',0,true,false,
  'The "passages" — the hidden necropolis-underworld of Sokar, the labyrinthine zone of the dead in the deep hours of the Amduat.'),
 ('ENT_EGY_IMHET','Imhet (Land of Sokar)',NULL,'Egyptian','Duat region','Realm of Sokar',
  'the sandy, snake-guarded land of Sokar','funerary','B','candidate_verified_name','Amduat, 4th hour',0,true,false,
  'The barren, sandy, serpent-guarded desert-region of Sokar traversed in the Amduat''s fourth hour.'),
 ('ENT_EGY_LAKE_OF_FIRE','The Lake of Fire',NULL,'Egyptian','Duat region','Place of judgment',
  'refreshment of the blessed; punishment of the damned','funerary','A','candidate_verified_name','Book of Gates / BD',0,true,false,
  'A lake whose waters refresh the blessed dead but burn the damned; a place-power of the Duat in the Book of Gates and the Book of the Dead.'),
 ('ENT_EGY_TWELVE_HOURS','The Twelve Hours of the Night',NULL,'Egyptian','Tutelary collective','Goddesses of the hours',
  'the twelve divisions of the night; guiding the solar barque','funerary','A','candidate_verified_name','Amduat / Book of Gates',0,true,false,
  'The twelve goddesses personifying the hours of the night, each ruling and guiding the solar barque through her division of the Duat. (Their individual names are descriptive epithets that vary by copy, so represented here as the collective.)'),
 ('ENT_EGY_75_FORMS_RE','The Seventy-Five Forms of Re',NULL,'Egyptian','Litany collective','Aspects of the sun god',
  'the invocations of the sun in the underworld','funerary','A','candidate_verified_name','Litany of Re',0,true,false,
  'The seventy-five names/forms under which the sun god is invoked in the Litany of Re as he traverses the underworld — most being epithet-aspects of Ra himself rather than separate deities.')
ON CONFLICT (entity_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (b3) ENTITIES — the astronomical decans
-- ---------------------------------------------------------------------
INSERT INTO entities
  (entity_id, canonical_name, greek_name, tradition, entity_type, category, primary_domains,
   cult_scope, evidence_confidence, review_status, inclusion_basis,
   earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_EGY_SOPDET','Sopdet','Σῶθις (Sothis)','Egyptian','Stellar goddess','Decanal star-god',
  'the star Sirius; the inundation; the New Year','national','A','candidate_verified_name','Pyramid Texts; astronomical ceilings',0,false,false,
  'The deified star Sirius, chief decan, whose heliacal rising heralded the Nile inundation and the New Year. Mother of Sopdu; later identified with Isis. Greek Sothis.'),
 ('ENT_EGY_SAH','Sah','Ὠρίων (Orion)','Egyptian','Stellar god','Decanal star-god',
  'the constellation Orion; the stars; the blessed dead','national','A','candidate_verified_name','Pyramid Texts; astronomical ceilings',0,false,false,
  'The deified constellation Orion, "father of the gods," consort of Sopdet and a stellar god of the decanal registers; assimilated to Osiris.'),
 ('ENT_EGY_DECANS','The Decans (Egyptian decanal system)','δεκανοί','Egyptian','Astronomical collective','Star-clock deities',
  'the 36 decanal stars; the star-clock; the 10-day week','national','A','candidate_verified_name','coffin star-clocks; astronomical ceilings',0,false,false,
  'The system of 36 stars/star-groups rising at ten-day intervals that ruled the Egyptian decades and divided the night into hours, attested on Middle Kingdom coffin star-clocks and the astronomical ceilings of Senenmut, Seti I, and Dendera. (Individual decan readings are largely contested, so represented as the system; later received into Hellenistic astrology as the dekanoi.)')
ON CONFLICT (entity_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (b4) ENTITIES — deified humans
-- ---------------------------------------------------------------------
INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains,
   cult_scope, evidence_confidence, review_status, inclusion_basis,
   earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_EGY_IMHOTEP','Imhotep','Egyptian','Deified human','Healing god',
  'wisdom; medicine; architecture; healing','national','A','candidate_verified_name','deified architect-sage of Djoser',0,false,false,
  'The vizier, architect, and physician of Djoser (3rd Dynasty), deified as "son of Ptah" and god of wisdom, writing, and healing, with temples and an incubation cult (Saqqara, Philae); equated by the Greeks with Asklepios.'),
 ('ENT_EGY_AMENHOTEP_HAPU','Amenhotep son of Hapu','Egyptian','Deified human','Healing/oracle god',
  'wisdom; healing; oracular intercession','regional','A','candidate_verified_name','deified sage of Amenhotep III',0,false,false,
  'The architect and sage of Amenhotep III (18th Dynasty), uniquely granted a mortuary temple in his lifetime and later deified as a healer and oracle; shared a healing-incubation cult with Imhotep at Deir el-Bahari into Roman times.'),
 ('ENT_EGY_HEQAIB','Heqaib','Egyptian','Deified human','Local saint-god',
  'protection; local patronage','regional','B','candidate_verified_name','deified nomarch of Elephantine',0,false,false,
  'Pepinakht "Heqaib," a nomarch of Elephantine under Pepi II (6th Dynasty) who led Nubian expeditions and was deified as a local patron; honoured at a purpose-built sanctuary on Elephantine with shrines, stelae, and royal dedications.'),
 ('ENT_EGY_ISI_EDFU','Isi of Edfu','Egyptian','Deified human','Local deified vizier',
  'local patronage','local','B','candidate_verified_name','deified nomarch of Edfu',0,false,false,
  'A nomarch of the Edfu region (6th Dynasty) venerated after death as a local "living god" (netjer ankh), with votive stelae at his tomb.')
ON CONFLICT (entity_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (b5) ENTITIES — nome / local gods + pan-Egyptian omissions
-- ---------------------------------------------------------------------
INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, category, primary_domains,
   cult_scope, evidence_confidence, review_status, inclusion_basis,
   earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_EGY_ANDJETY','Andjety','Egyptian','Local deity','Funerary/kingship god',
  'kingship; the crook and flail; rebirth','regional','A','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  'An ancient funerary and kingship god of Busiris (Djedu), bearer of the crook and flail and prototype of the atef-crown, largely absorbed into Osiris.'),
 ('ENT_EGY_WENUT','Wenut','Egyptian','Local goddess','Hare goddess',
  'the Hare nome; swiftness','regional','A','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  'The "Swift One," hare goddess (originally a serpent) of the Hare nome and Hermopolis, associated with Thoth.'),
 ('ENT_EGY_NEMTY','Nemty','Egyptian','Local deity','Falcon ferryman god',
  'the ferry of the gods; the eastern nomes','regional','A','candidate_verified_name','Wilkinson, Complete Gods',0,false,false,
  'A falcon ferryman-god of the gods (the boatman of "The Contendings of Horus and Seth"), worshipped in the 12th and 18th Upper Egyptian nomes. ("Anty/Anti" is an obsolete reading of his name.)'),
 ('ENT_EGY_HEMEN','Hemen','Egyptian','Local deity','Falcon god',
  'the hippopotamus hunt; oracular kingship','regional','B','candidate_verified_name','Wilkinson, Complete Gods',0,false,false,
  'A falcon god of Hefat (Mo''alla) shown slaying the hippopotamus; syncretised as Horus-Hemen and attested in royal statuary (Taharqa).'),
 ('ENT_EGY_KHENTEKHTAI','Khentekhtai','Egyptian','Local deity','Crocodile/falcon god',
  'Athribis; kingship','regional','B','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  'The local god of Athribis (10th Lower nome), originally crocodile-form and later a falcon, syncretised as Horus-Khentykhety.'),
 ('ENT_EGY_IPY_OPET','Ipy (Opet)','Egyptian','Local goddess','Hippopotamus goddess',
  'protection; Osirian motherhood; Thebes','regional','A','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  'The Theban hippopotamus goddess of protection and Osirian rebirth, honoured at the Opet temple of Karnak; related to but distinct from Taweret and Reret.'),
 ('ENT_EGY_DEDWEN','Dedwen','Egyptian','Local deity','Nubian incense god',
  'incense; trade wealth; Nubia','regional','B','candidate_verified_name','Pyramid Texts; Wilkinson',0,false,false,
  'A god of incense and the wealth of trade, "lord of Nubia," worshipped by the Egyptians in the south from the Old Kingdom (Pyramid Texts) onward.'),
 ('ENT_EGY_IGAI','Igai','Egyptian','Local deity','Oasis god',
  'the western oases','local','B','candidate_verified_name','Hübschmann, Rosetta 8',0,true,false,
  '"Lord of the Oasis," a desert/oasis god of the Dakhla region attested from the 3rd Dynasty through the Middle Kingdom.'),
 ('ENT_EGY_HA','Ha','Egyptian','Local deity','Desert god',
  'the western desert; protection from Libyans','regional','B','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  '"Lord of the Western Desert," a protector god of the oases and the western frontier against Libyan incursion, shown with the desert-hills sign on his head. (Related to but distinct from Ash.)'),
 ('ENT_EGY_WENEG','Weneg','Egyptian','Cosmic deity','Sky-supporting god',
  'cosmic order; supporting the sky; judgment of the gods','national','B','candidate_verified_name','Pyramid Texts',0,false,false,
  'A cosmic "son of Ra" who supports the sky and judges among the gods, attested in the Pyramid Texts. (Distinct from the 2nd-Dynasty king of the same name.)'),
 ('ENT_EGY_KHERTY','Kherty','Egyptian','Local deity','Underworld ram god',
  'the underworld; the ferry of the dead; tomb guardianship','regional','B','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  'A ram-form earth/underworld god of Letopolis, ferryman and guardian of the dead, sometimes a menacing power the king must be protected from.'),
 ('ENT_EGY_WADJWER','Wadj-wer','Egyptian','Cosmic deity','Fecundity/sea god',
  'the sea and Delta lagoons; fecundity','regional','A','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  'The "Great Green," an androgynous fecundity god personifying the sea and the lagoons of the Delta, depicted ripple-marked with a swollen belly; attested from the Old Kingdom (Sahure temple).'),
 ('ENT_EGY_KHENTAMENTIU','Khentamentiu','Egyptian','Local deity','Necropolis god',
  'the necropolis; "Foremost of the Westerners"','regional','A','candidate_verified_name','Wilkinson, Complete Gods',0,true,false,
  'The early jackal necropolis-god of Abydos, "Foremost of the Westerners," whose cult and epithet were absorbed by Osiris (and the name survives as an epithet of Osiris and Anubis).'),
 ('ENT_EGY_APIS','Apis','Egyptian','Sacred bull','Memphite bull god',
  'the living bull of Ptah; kingship; the Serapeum','national','A','candidate_verified_name','Wilkinson, Complete Gods',2,false,false,
  'The sacred living bull of Memphis, herald and ba of Ptah, who became Osiris-Apis at death and, in the Ptolemaic period, the root of Serapis; buried in the Saqqara Serapeum.'),
 ('ENT_EGY_MNEVIS','Mnevis','Egyptian','Sacred bull','Heliopolitan bull god',
  'the living bull of Heliopolis; the ba of Ra-Atum','regional','A','candidate_verified_name','Wilkinson, Complete Gods',2,false,false,
  'The sacred black bull of Heliopolis, living herald and ba of Ra-Atum.'),
 ('ENT_EGY_BUCHIS','Buchis','Egyptian','Sacred bull','Hermonthite bull god',
  'the living bull of Armant; the ka of Montu','regional','B','candidate_verified_name','Dodson, Divine Creatures',2,false,false,
  'The sacred bull of Hermonthis (Armant), living manifestation and ka of Montu; buried in the Bucheum.'),
 ('ENT_EGY_HESAT','Hesat','Egyptian','Goddess','Cow goddess',
  'milk; motherhood of the bull gods','regional','B','candidate_verified_name','Wilkinson, Complete Gods',1,false,false,
  'A cow goddess of milk and nourishment, mother of the bull gods (Mnevis) and an aspect of Hathor.'),
 ('ENT_EGY_MEHETWERET','Mehet-Weret','Egyptian','Goddess','Celestial cow / primeval waters',
  'the primeval flood; creation; the Eye of Ra','national','A','candidate_verified_name','Pyramid Texts; BD 17',1,false,false,
  'The "Great Flood," celestial cow goddess of the primeval waters from which the sun arose; an Eye of Ra and a creation goddess (Pyramid Texts; Book of the Dead Spell 17).'),
 ('ENT_EGY_IUSAASET','Iusaaset','Egyptian','Goddess','Primordial mother',
  'creation; the "hand of Atum"; the acacia','regional','B','candidate_verified_name','Wilkinson; Hart',0,false,false,
  'A primordial Heliopolitan mother goddess, the "hand of Atum" and "grandmother of the gods," associated with the sacred acacia; Greek Saosis.'),
 ('ENT_EGY_NEPER','Neper','Egyptian','Deity','Grain god',
  'grain; barley and emmer; harvest','national','B','candidate_verified_name','Coffin Texts; Pinch',3,false,false,
  'The god of grain (barley and emmer), son of the harvest goddess Renenutet, whose death and renewal were assimilated to Osiris.'),
 ('ENT_EGY_WERETHEKAU','Werethekau','Egyptian','Goddess','Goddess of royal magic',
  'royal protective magic; the crowns','national','A','candidate_verified_name','Lesko, Great Goddesses',0,false,true,
  '"Great of Magic," a cobra- or lioness-headed goddess personifying the protective magic of the crowns and the king. (Distinct from the god Heka.)'),
 ('ENT_EGY_TAYET','Tayet','Egyptian','Goddess','Goddess of weaving',
  'weaving; linen; the mummy-wrappings','national','B','candidate_verified_name','Pyramid Texts; Pinch',1,false,false,
  'The goddess of weaving and linen, patroness of the bandages that wrap the mummy and the cloth of the embalming-tent (Pyramid Texts onward).'),
 ('ENT_EGY_RENPET','Renpet','Egyptian','Goddess','Personified year',
  'the year; time; youth and fertility','national','B','candidate_verified_name','Wilkinson, Complete Gods',0,false,false,
  'The goddess personifying the year and the passage of time, "Mistress of Eternity," bearing a notched palm-rib on her head. (Distinct from the lioness goddess Repit.)'),
 ('ENT_EGY_NEHMETAWY','Nehmetawy','Egyptian','Goddess','Consort goddess',
  'protection; Hermopolis','regional','B','candidate_verified_name','Wilkinson; Hart',0,false,false,
  'A protective consort goddess of Thoth at Hermopolis, "she who embraces / rescues the needy," shown in a sistrum-shaped headdress holding a child.'),
 ('ENT_EGY_TUTU_TITHOES','Tutu (Tithoes)','Egyptian','Apotropaic deity','Master of demons',
  'protection; mastery over hostile demons','regional','B','candidate_verified_name','Kaper, The Egyptian God Tutu',0,true,false,
  'An apotropaic sphinx god, "master of demons" and son of Neith, who commands the wandering demons and protects against them; temple at Kellis (Dakhla). Greek Tithoes. (Distinct from the assessor Tutu of BD 125.)')
ON CONFLICT (entity_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (c) ENTITY_SOURCES
-- ---------------------------------------------------------------------
-- assessors (bulk: each -> BD 125 in Faulkner + Budge), driven by entity_type
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_FAULKNER_BOOK_OF_DEAD', 'direct attestation', 'Book of the Dead Spell 125 (Declaration of Innocence).'
FROM entities WHERE entity_type IN ('Assessor of Maat','Divine tribunal')
ON CONFLICT (entity_id, source_id, evidence_type) DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_BUDGE_PAPYRUS_ANI', 'direct attestation', 'BD Spell 125, Papyrus of Ani (name-form and ordering).'
FROM entities WHERE entity_type IN ('Assessor of Maat','Divine tribunal')
ON CONFLICT (entity_id, source_id, evidence_type) DO NOTHING;

-- Duat cast
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_EGY_AFRA','SRC_HORNUNG_DUAT','scholarly attestation','The night form of Ra in the Amduat and Book of Gates.'),
 ('ENT_EGY_MAUAA','SRC_PIANKOFF_LITANY_RE','direct attestation','The great cat who slays Apophis; Litany of Re / BD 17.'),
 ('ENT_EGY_HEKA','SRC_PINCH_EGYPTIAN_MYTH','scholarly attestation','The deification of magic; barque crew.'),
 ('ENT_EGY_HEKA','SRC_FAULKNER_PYRAMID_TEXTS','direct attestation','Heka attested from the Coffin/Pyramid corpus.'),
 ('ENT_EGY_NEBETWIA','SRC_HORNUNG_DUAT','scholarly attestation','Mistress of the Barque, Amduat crew.'),
 ('ENT_EGY_KAMAAT','SRC_HORNUNG_DUAT','scholarly attestation','Bull of Maat, Amduat crew.'),
 ('ENT_EGY_HEREHEQENU','SRC_HORNUNG_DUAT','scholarly attestation','Horus the Praiser, Amduat crew.'),
 ('ENT_EGY_NEHES','SRC_HORNUNG_DUAT','scholarly attestation','The Watchful One, Amduat crew.'),
 ('ENT_EGY_ANKHNETERU','SRC_HORNUNG_DUAT','scholarly attestation','The world-encircling serpent, Amduat 12th hour.'),
 ('ENT_EGY_SAASET','SRC_HORNUNG_DUAT','scholarly attestation','Gate-serpent, Book of Gates gate 2.'),
 ('ENT_EGY_TEKAHER','SRC_HORNUNG_DUAT','scholarly attestation','Gate-serpent, Book of Gates gate 4 / Amduat hour 3.'),
 ('ENT_EGY_SETEMMAATF','SRC_HORNUNG_DUAT','scholarly attestation','Serpent of the Judgment Hall, Book of Gates gate 6.'),
 ('ENT_EGY_AKHEKHI','SRC_HORNUNG_DUAT','scholarly attestation','Guardian of the final gate, Book of Gates gate 12.'),
 ('ENT_EGY_FOUR_RACES','SRC_HORNUNG_DUAT','scholarly attestation','The four races of mankind, Book of Gates 5th division.'),
 ('ENT_EGY_ENEMIES_OF_RA','SRC_HORNUNG_DUAT','scholarly attestation','The damned, Amduat and Book of Gates fire-pits.'),
 ('ENT_EGY_SEKHET_AARU','SRC_FAULKNER_BOOK_OF_DEAD','direct attestation','The Field of Reeds, Book of the Dead (esp. Spell 110).'),
 ('ENT_EGY_SEKHET_HETEPET','SRC_FAULKNER_BOOK_OF_DEAD','direct attestation','The Field of Offerings, Book of the Dead Spell 110.'),
 ('ENT_EGY_WERNES','SRC_HORNUNG_DUAT','scholarly attestation','The water-realm of the Amduat 2nd hour.'),
 ('ENT_EGY_ROSETAU','SRC_HORNUNG_DUAT','scholarly attestation','The realm of Sokar, Amduat 4th-5th hours.'),
 ('ENT_EGY_IMHET','SRC_HORNUNG_DUAT','scholarly attestation','The land of Sokar, Amduat 4th hour.'),
 ('ENT_EGY_LAKE_OF_FIRE','SRC_HORNUNG_DUAT','scholarly attestation','The Lake of Fire, Book of Gates / Book of the Dead.'),
 ('ENT_EGY_TWELVE_HOURS','SRC_HORNUNG_DUAT','scholarly attestation','The twelve hour-goddesses of the Amduat and Book of Gates.'),
 ('ENT_EGY_75_FORMS_RE','SRC_PIANKOFF_LITANY_RE','direct attestation','The seventy-five invocations of Re; Litany of Re.'),
-- decans
 ('ENT_EGY_SOPDET','SRC_FAULKNER_PYRAMID_TEXTS','direct attestation','Sopdet/Sirius in the Pyramid Texts.'),
 ('ENT_EGY_SOPDET','SRC_NEUGEBAUER_PARKER_EAT','scholarly attestation','Chief decan; the decanal star-clocks.'),
 ('ENT_EGY_SAH','SRC_FAULKNER_PYRAMID_TEXTS','direct attestation','Sah/Orion in the Pyramid Texts.'),
 ('ENT_EGY_DECANS','SRC_NEUGEBAUER_PARKER_EAT','scholarly attestation','The 36-decan system; coffin star-clocks and astronomical ceilings.'),
-- deified humans
 ('ENT_EGY_IMHOTEP','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Deified humans (Wilkinson).'),
 ('ENT_EGY_AMENHOTEP_HAPU','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Deified humans (Wilkinson).'),
 ('ENT_EGY_HEQAIB','SRC_HABACHI_HEQAIB','scholarly attestation','The sanctuary of Heqaib at Elephantine.'),
 ('ENT_EGY_ISI_EDFU','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Deified local viziers (Wilkinson / von Lieven).'),
-- nome gods + omissions
 ('ENT_EGY_ANDJETY','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Andjety of Busiris.'),
 ('ENT_EGY_WENUT','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Wenut, hare goddess of the Hare nome.'),
 ('ENT_EGY_NEMTY','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Nemty the ferryman god.'),
 ('ENT_EGY_HEMEN','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Hemen of Hefat.'),
 ('ENT_EGY_KHENTEKHTAI','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Khentekhtai of Athribis.'),
 ('ENT_EGY_IPY_OPET','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Ipy/Opet of Thebes.'),
 ('ENT_EGY_DEDWEN','SRC_FAULKNER_PYRAMID_TEXTS','direct attestation','Dedwen of Nubia, Pyramid Texts.'),
 ('ENT_EGY_IGAI','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Igai, lord of the oasis.'),
 ('ENT_EGY_HA','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Ha, lord of the western desert.'),
 ('ENT_EGY_WENEG','SRC_FAULKNER_PYRAMID_TEXTS','direct attestation','Weneg the sky-supporter, Pyramid Texts.'),
 ('ENT_EGY_KHERTY','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Kherty of Letopolis.'),
 ('ENT_EGY_WADJWER','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Wadj-wer, the Great Green.'),
 ('ENT_EGY_KHENTAMENTIU','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Khentamentiu of Abydos.'),
 ('ENT_EGY_APIS','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','The Apis bull of Memphis.'),
 ('ENT_EGY_MNEVIS','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','The Mnevis bull of Heliopolis.'),
 ('ENT_EGY_BUCHIS','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','The Buchis bull of Armant.'),
 ('ENT_EGY_HESAT','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Hesat the cow goddess.'),
 ('ENT_EGY_MEHETWERET','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Mehet-Weret, the celestial cow.'),
 ('ENT_EGY_IUSAASET','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Iusaaset, the hand of Atum.'),
 ('ENT_EGY_NEPER','SRC_PINCH_EGYPTIAN_MYTH','scholarly attestation','Neper the grain god.'),
 ('ENT_EGY_WERETHEKAU','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Werethekau, great of magic.'),
 ('ENT_EGY_TAYET','SRC_FAULKNER_PYRAMID_TEXTS','direct attestation','Tayet the weaving goddess, Pyramid Texts.'),
 ('ENT_EGY_RENPET','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Renpet, personified year.'),
 ('ENT_EGY_NEHMETAWY','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Nehmetawy, consort of Thoth.'),
 ('ENT_EGY_TUTU_TITHOES','SRC_WILKINSON_EGYPTIAN_GODS','scholarly attestation','Tutu/Tithoes, master of demons.')
ON CONFLICT (entity_id, source_id, evidence_type) DO NOTHING;

-- ---------------------------------------------------------------------
-- (d) ENTITY_PERIODS
-- ---------------------------------------------------------------------
-- assessors + Duat funerary literature -> New Kingdom (when these books crystallise)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id, 'PER_EGY_NEW_KINGDOM', 'A',
       'Attested in the New Kingdom funerary literature (Book of the Dead / Amduat / Book of Gates / Litany of Re).',
       'SRC_HORNUNG_DUAT', 'reviewed'
FROM entities
WHERE entity_type IN ('Assessor of Maat','Divine tribunal')
   OR entity_id IN ('ENT_EGY_AFRA','ENT_EGY_MAUAA','ENT_EGY_NEBETWIA','ENT_EGY_KAMAAT','ENT_EGY_HEREHEQENU',
                    'ENT_EGY_NEHES','ENT_EGY_ANKHNETERU','ENT_EGY_SAASET','ENT_EGY_TEKAHER','ENT_EGY_SETEMMAATF',
                    'ENT_EGY_AKHEKHI','ENT_EGY_FOUR_RACES','ENT_EGY_ENEMIES_OF_RA','ENT_EGY_SEKHET_AARU',
                    'ENT_EGY_SEKHET_HETEPET','ENT_EGY_WERNES','ENT_EGY_ROSETAU','ENT_EGY_IMHET','ENT_EGY_LAKE_OF_FIRE',
                    'ENT_EGY_TWELVE_HOURS','ENT_EGY_75_FORMS_RE')
ON CONFLICT (entity_id, period_id) DO NOTHING;

-- Old-Kingdom-rooted figures (Pyramid Texts attestation / Old Kingdom cult)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_EGY_OLD_KINGDOM', 'A', 'Attested from the Old Kingdom (Pyramid Texts / Old Kingdom cult).',
       'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'
FROM (VALUES ('ENT_EGY_SOPDET'),('ENT_EGY_SAH'),('ENT_EGY_HEKA'),('ENT_EGY_WENEG'),('ENT_EGY_DEDWEN'),
             ('ENT_EGY_TAYET'),('ENT_EGY_MEHETWERET'),('ENT_EGY_WADJWER'),('ENT_EGY_KHENTAMENTIU'),
             ('ENT_EGY_ANDJETY'),('ENT_EGY_HEQAIB'),('ENT_EGY_ISI_EDFU'),('ENT_EGY_IMHOTEP'),
             ('ENT_EGY_KHERTY'),('ENT_EGY_IGAI'),('ENT_EGY_HA')) AS t(e)
ON CONFLICT (entity_id, period_id) DO NOTHING;

-- Middle-Kingdom decanal system (coffin star-clocks)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_EGY_DECANS','PER_EGY_MIDDLE_KINGDOM','A','The decanal star-clocks first appear on Middle Kingdom coffin lids.','SRC_NEUGEBAUER_PARKER_EAT','reviewed'),
 ('ENT_EGY_AMENHOTEP_HAPU','PER_EGY_NEW_KINGDOM','A','Sage of Amenhotep III (18th Dynasty).','SRC_WILKINSON_EGYPTIAN_GODS','reviewed')
ON CONFLICT (entity_id, period_id) DO NOTHING;

-- remaining nome gods / omissions with broad attestation -> Late Period anchor
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_EGY_LATE_PERIOD', 'B', 'Attested across pharaonic Egypt into the Late Period.',
       'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'
FROM (VALUES ('ENT_EGY_WENUT'),('ENT_EGY_NEMTY'),('ENT_EGY_HEMEN'),('ENT_EGY_KHENTEKHTAI'),('ENT_EGY_IPY_OPET'),
             ('ENT_EGY_APIS'),('ENT_EGY_MNEVIS'),('ENT_EGY_BUCHIS'),('ENT_EGY_HESAT'),('ENT_EGY_IUSAASET'),
             ('ENT_EGY_NEPER'),('ENT_EGY_WERETHEKAU'),('ENT_EGY_RENPET'),('ENT_EGY_NEHMETAWY'),
             ('ENT_EGY_TUTU_TITHOES')) AS t(e)
ON CONFLICT (entity_id, period_id) DO NOTHING;

-- ---------------------------------------------------------------------
-- (e) ENTITY_RELATIONSHIPS
-- ---------------------------------------------------------------------
-- assessors -> their collective (bulk)
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
SELECT entity_id, 'member_of', 'ENT_EGY_FORTYTWO_ASSESSORS', 'high', 'One of the 42 judges of the Negative Confession.', 'SRC_FAULKNER_BOOK_OF_DEAD', 'reviewed'
FROM entities WHERE entity_type = 'Assessor of Maat'
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- the judgment tribunal in its setting
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_EGY_FORTYTWO_ASSESSORS','presided_over_by','ENT_EGY_OSIRIS','high','Osiris presides over the judgment hall where the assessors sit.','SRC_FAULKNER_BOOK_OF_DEAD','reviewed'),
 ('ENT_EGY_FORTYTWO_ASSESSORS','embodies','ENT_EGY_MAAT','high','The tribunal exists to uphold Maat (truth/order) in judging the dead.','SRC_FAULKNER_BOOK_OF_DEAD','reviewed'),
 ('ENT_EGY_FORTYTWO_ASSESSORS','dwells_in','ENT_EGY_DUAT','high','The Hall of the Two Truths lies within the Duat.','SRC_FAULKNER_BOOK_OF_DEAD','reviewed'),
-- Duat: forms of Ra
 ('ENT_EGY_AFRA','cult_form_of','ENT_EGY_RA','high','The night/flesh form of the sun god.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_MAUAA','cult_form_of','ENT_EGY_RA','high','The great cat is a form of Ra who slays Apophis.','SRC_PIANKOFF_LITANY_RE','reviewed'),
 ('ENT_EGY_MAUAA','slays','ENT_EGY_APEP','high','The great cat of Ra slays the serpent Apophis beneath the ished-tree.','SRC_PIANKOFF_LITANY_RE','reviewed'),
 ('ENT_EGY_75_FORMS_RE','embodies','ENT_EGY_RA','high','The seventy-five forms are aspects of the one sun god.','SRC_PIANKOFF_LITANY_RE','reviewed'),
 ('ENT_EGY_AFRA','undergoes_process','ENT_EGY_DUAT','medium','Af-Ra traverses the Duat each night to be regenerated.','SRC_HORNUNG_DUAT','reviewed'),
-- Duat: barque crew protect/guide Ra
 ('ENT_EGY_HEKA','protects','ENT_EGY_RA','high','Heka (magic) protects the sun god in the night barque.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_NEHES','protects','ENT_EGY_RA','medium','The Watchful One guards the barque of Ra.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_NEBETWIA','associated_with','ENT_EGY_RA','medium','The personified barque carries the sun god.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_KAMAAT','member_of','ENT_EGY_75_FORMS_RE','low','Listed among the barque crew of the night journey.','SRC_HORNUNG_DUAT','reviewed'),
-- Duat: serpents and guardians dwell in the Duat
 ('ENT_EGY_ANKHNETERU','dwells_in','ENT_EGY_DUAT','high','The world-encircling serpent of the twelfth hour.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_SAASET','guardian_of','ENT_EGY_DUAT','high','Guards a gate of the Duat (Book of Gates gate 2).','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_TEKAHER','guardian_of','ENT_EGY_DUAT','high','Guards a gate of the Duat (Book of Gates gate 4).','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_SETEMMAATF','guardian_of','ENT_EGY_DUAT','high','Guards the gate before the Judgment Hall (Book of Gates gate 6).','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_AKHEKHI','guardian_of','ENT_EGY_DUAT','high','Guards the final gate of the Duat (Book of Gates gate 12).','SRC_HORNUNG_DUAT','reviewed'),
-- Duat: enemies and regeneration
 ('ENT_EGY_ENEMIES_OF_RA','opposes','ENT_EGY_RA','high','The damned are the rebels against the sun god.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_ANKHNETERU','associated_with','ENT_EGY_KHEPRI','medium','The sun emerges from the serpent reborn as Khepri.','SRC_HORNUNG_DUAT','reviewed'),
-- Duat: regions belong to the Duat / Sokar
 ('ENT_EGY_ROSETAU','belongs_to_realm','ENT_EGY_DUAT','high','Sokar''s hidden realm within the Duat.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_IMHET','belongs_to_realm','ENT_EGY_DUAT','high','The land of Sokar within the Duat.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_WERNES','belongs_to_realm','ENT_EGY_DUAT','high','The water-realm of the second hour of the Duat.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_LAKE_OF_FIRE','belongs_to_realm','ENT_EGY_DUAT','high','A place-power of the Duat.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_ROSETAU','ruled_by','ENT_EGY_SEKER','high','Rosetau is the domain of Sokar.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_IMHET','ruled_by','ENT_EGY_SEKER','high','Imhet is the land of Sokar.','SRC_HORNUNG_DUAT','reviewed'),
 ('ENT_EGY_TWELVE_HOURS','guardian_of','ENT_EGY_DUAT','medium','The hour-goddesses guide the barque through the divisions of the night.','SRC_HORNUNG_DUAT','reviewed'),
-- decans
 ('ENT_EGY_SOPDET','member_of','ENT_EGY_DECANS','high','Sopdet/Sirius is the chief decan.','SRC_NEUGEBAUER_PARKER_EAT','reviewed'),
 ('ENT_EGY_SAH','member_of','ENT_EGY_DECANS','high','Sah/Orion stands among the decanal star-gods.','SRC_NEUGEBAUER_PARKER_EAT','reviewed'),
 ('ENT_EGY_SOPDET','consort_of','ENT_EGY_SAH','high','Sopdet and Sah (Sirius and Orion) are a stellar pair, parents of Sopdu.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_SOPDET','syncretized_with','ENT_EGY_ISIS','high','Sopdet was identified with Isis as the star of the inundation.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_SAH','syncretized_with','ENT_EGY_OSIRIS','high','Sah/Orion was assimilated to Osiris.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
-- the Hellenistic reception: the Testament-of-Solomon decan-demons receive the Egyptian system (bulk)
-- (wired below via SELECT)
-- deified humans
 ('ENT_EGY_IMHOTEP','child_of','ENT_EGY_PTAH','high','Imhotep was venerated as the son of Ptah.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_AMENHOTEP_HAPU','associated_with','ENT_EGY_IMHOTEP','high','Shared a healing-oracle cult with Imhotep at Deir el-Bahari.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_IMHOTEP','patron_of','ENT_EGY_HEKA','low','Patron of healing, the domain of magic/medicine.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
-- nome gods / omissions: syncretism and family
 ('ENT_EGY_ANDJETY','syncretized_with','ENT_EGY_OSIRIS','high','Andjety of Busiris was absorbed into Osiris.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_KHENTAMENTIU','syncretized_with','ENT_EGY_OSIRIS','high','Khentamentiu''s cult and epithet were taken over by Osiris.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_KHENTEKHTAI','syncretized_with','ENT_EGY_HORUS','medium','Worshipped as Horus-Khentykhety at Athribis.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_HEMEN','syncretized_with','ENT_EGY_HORUS','medium','Worshipped as Horus-Hemen at Hefat.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_WENUT','associated_with','ENT_EGY_THOTH','medium','Hare goddess of the Hermopolitan nome of Thoth.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_NEHMETAWY','consort_of','ENT_EGY_THOTH','high','Consort of Thoth at Hermopolis.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_APIS','associated_with','ENT_EGY_PTAH','high','The Apis bull is the living herald and ba of Ptah.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_APIS','syncretized_with','ENT_SYN_SERAPIS','high','Osiris-Apis became the Ptolemaic god Serapis.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_MNEVIS','associated_with','ENT_EGY_RA','high','The Mnevis bull is the ba of Ra-Atum.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_BUCHIS','associated_with','ENT_EGY_MONTU','high','The Buchis bull is the ka of Montu.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_HESAT','parent_of','ENT_EGY_MNEVIS','medium','Hesat is the cow-mother of the bull gods.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed'),
 ('ENT_EGY_NEPER','child_of','ENT_EGY_RENENUTET','high','Neper the grain god is the son of the harvest goddess Renenutet.','SRC_PINCH_EGYPTIAN_MYTH','reviewed'),
 ('ENT_EGY_MEHETWERET','embodies','ENT_EGY_RA','medium','Mehet-Weret is an Eye of Ra and the primeval flood that bears the sun.','SRC_WILKINSON_EGYPTIAN_GODS','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- the Hellenistic reception of the decanal system (each Solomonic decan-demon -> the Egyptian system)
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
SELECT entity_id, 'reception_of', 'ENT_EGY_DECANS', 'medium',
       'The Testament of Solomon decan-demons are a Hellenistic reception of the Egyptian decanal system.',
       'SRC_NEUGEBAUER_PARKER_EAT', 'reviewed'
FROM entities WHERE entity_id LIKE 'ENT_LAT_DECAN%'
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

COMMIT;

-- ---------------------------------------------------------------------
-- (f) VERIFY
-- ---------------------------------------------------------------------
\echo '== Egyptian roster now (expect ~187) =='
SELECT count(*) AS egyptian FROM entities WHERE tradition='Egyptian';
\echo '== new entities this build (ENT_EGY_ASSESSOR / FORTYTWO / others) -- unsourced? (expect 0) =='
SELECT count(*) AS unsourced_new FROM entities e
 WHERE e.entity_id IN (SELECT entity_id FROM entities WHERE entity_type IN ('Assessor of Maat','Divine tribunal')
   UNION SELECT entity_id FROM entities WHERE entity_id LIKE 'ENT_EGY_%' AND review_status='candidate_verified_name')
   AND NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
\echo '== the 42 assessors present? (expect 42) =='
SELECT count(*) AS assessors FROM entities WHERE entity_type='Assessor of Maat';
\echo '== whole-DB integrity (expect 0 / 0) =='
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
\echo '== unsourced total + dup source-pairs (expect 0 / 0) =='
SELECT (SELECT count(*) FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id)) AS unsourced_total,
       (SELECT count(*) FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY entity_id, source_id HAVING count(*)>1) d) AS dup_source_pairs;
\echo '== any Egyptian new entity missing a period link? (expect 0) =='
SELECT count(*) AS undated FROM entities e
 WHERE e.tradition='Egyptian' AND e.review_status='candidate_verified_name'
   AND e.entity_id IN (SELECT entity_id FROM entities WHERE entity_type='Assessor of Maat'
        UNION SELECT entity_id FROM entities WHERE entity_id IN ('ENT_EGY_FORTYTWO_ASSESSORS','ENT_EGY_AFRA','ENT_EGY_DECANS','ENT_EGY_IMHOTEP','ENT_EGY_APIS','ENT_EGY_SOPDET'))
   AND NOT EXISTS (SELECT 1 FROM entity_periods p WHERE p.entity_id=e.entity_id);
