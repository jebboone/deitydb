-- scripts/build_zoroastrian_core.sql
-- Content normalization I (v1.43.0): Zoroastrian build-out. The dataset is heavily
-- weighted toward the Gnostic bloc (186); Zoroastrianism (17) is the thinnest of the
-- major late-antique traditions despite being the Iranian substrate that fed Second
-- Temple Jewish, Gnostic and Manichaean dualism. This brings it to solid canonical
-- depth (~54): the major yazatas, the daeva counter-pantheon mirroring the Amesha
-- Spentas, and the primordial/eschatological cast. Every entity is attested to its
-- Avestan (Yasht/Gathic/Vendidad) or Pahlavi locus; typed relationships wired.

BEGIN;

-- ── New Pahlavi/secondary sources (Avesta + Bundahishn already registered) ────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_DENKARD','Denkard (Acts of the Religion), Pahlavi compendium, 9th-10th c. CE','','primary text','The great Middle Persian encyclopedia of Zoroastrian doctrine and cosmology'),
('SRC_MENOG_I_KHRAD','Menog-i Khrad (The Spirit of Wisdom), Pahlavi text, 6th c. CE','','primary text','A Middle Persian catechism on cosmology, eschatology and the demons'),
('SRC_ZAEHNER_ZURVAN','R. C. Zaehner, Zurvan: A Zoroastrian Dilemma (1955)','','secondary scholarship','The standard study of the Zurvanite heresy and the figure of Zurvan/Time')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- Yazatas and divine beings
 ('ENT_ZOR_SPENTA_MAINYU','Spenta Mainyu','Zoroastrian','Divine being','Creative Spirit','creation; goodness; the choice for life','Iranian','A','candidate_verified_name','Gathic primal spirit',0,false,false,'The Bounteous Spirit of Ahura Mazda, the twin who chose life against Angra Mainyu.'),
 ('ENT_ZOR_VERETHRAGNA','Verethragna','Zoroastrian','Yazata','War Deity','victory; war; might','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'The yazata of victory, manifest in ten incarnations.'),
 ('ENT_ZOR_TISHTRYA','Tishtrya','Zoroastrian','Yazata','Astral Deity','rain; the star Sirius; fertility','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'The star Sirius, rain-bringer who defeats the drought-demon Apaosha.'),
 ('ENT_ZOR_RASHNU','Rashnu','Zoroastrian','Yazata','Justice Deity','justice; the weighing of souls','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'The yazata of justice who weighs souls at the Chinvat Bridge.'),
 ('ENT_ZOR_VAYU','Vayu','Zoroastrian','Yazata','Wind Deity','wind; the intermediate air; fate','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'The dual wind-god, both beneficent and dangerous.'),
 ('ENT_ZOR_HAOMA','Haoma','Zoroastrian','Yazata','Sacred Plant','the sacred plant and drink; healing; inspiration','Iranian','A','candidate_verified_name','Deified ritual substance',0,false,false,'The deified sacred plant and its pressed, immortality-giving drink.'),
 ('ENT_ZOR_APAM_NAPAT','Apam Napat','Zoroastrian','Yazata','Water Deity','the waters; fire within water; the royal glory','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'"Son of the Waters," the fiery spirit dwelling within the waters.'),
 ('ENT_ZOR_ASHI','Ashi','Zoroastrian','Yazata','Fortune Deity','reward; recompense; good fortune','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'The yazata of reward and good fortune, daughter of Ahura Mazda.'),
 ('ENT_ZOR_DAENA','Daena','Zoroastrian','Yazata','Personified Religion','conscience; religion; the inner self','Iranian','A','candidate_verified_name','Personified Yazata',0,false,false,'Conscience and religion personified, met as a maiden at the Chinvat Bridge.'),
 ('ENT_ZOR_CHISTA','Chista','Zoroastrian','Yazata','Wisdom Deity','knowledge; the straight paths','Iranian','B','candidate_verified_name','Yazata',0,false,false,'The yazata of right knowledge and the straight paths of religion.'),
 ('ENT_ZOR_HVAR','Hvar Khshaeta','Zoroastrian','Yazata','Solar Deity','the sun; light; purification','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'"The radiant Sun," whose rising purifies the creation.'),
 ('ENT_ZOR_MAH','Mah','Zoroastrian','Yazata','Lunar Deity','the moon; the seed of cattle','Iranian','A','candidate_verified_name','Major Yazata',0,false,false,'The Moon, keeper of the seed of cattle.'),
 ('ENT_ZOR_ASMAN','Asman','Zoroastrian','Yazata','Sky Deity','the sky; the stone heaven','Iranian','B','candidate_verified_name','Yazata',0,false,false,'The personified Sky, the outermost stone heaven.'),
 ('ENT_ZOR_KHVARENAH','Khvarenah','Zoroastrian','Divine power','Divine Glory','glory; fortune; royal legitimacy','Iranian','A','candidate_verified_name','Personified divine power',0,false,false,'The divine Glory (farr), the kavyan splendour that legitimates kings.'),
 ('ENT_ZOR_GEUSH_URVAN','Geush Urvan','Zoroastrian','Divine being','Primordial Soul','cattle; the soul of the living world','Iranian','A','candidate_verified_name','Gathic figure',1,false,false,'The Soul of the Primordial Bovine, whose complaint opens Yasna 29.'),
 ('ENT_ZOR_NAIRYOSANGHA','Nairyosangha','Zoroastrian','Yazata','Messenger Deity','divine messages; the sacred fire of priests','Iranian','B','candidate_verified_name','Yazata',0,false,false,'The messenger of Ahura Mazda.'),
 ('ENT_ZOR_DRVASPA','Drvaspa','Zoroastrian','Yazata','Pastoral Deity','the health of horses and cattle','Iranian','B','candidate_verified_name','Yazata',1,false,false,'The yazata who keeps horses and cattle sound.'),
 -- Cosmological / primordial / eschatological / heroic
 ('ENT_ZOR_ZURVAN','Zurvan','Zoroastrian','Supreme deity','Time Deity','infinite time; fate; the father of the twin spirits','Iranian','B','candidate_verified_name','Zurvanite high god',0,false,false,'In the Zurvanite system, Time, the father of Ohrmazd and Ahriman.'),
 ('ENT_ZOR_GAYOMARD','Gayomard','Zoroastrian','Primordial being','First Man','primordial humanity; the first creation','Iranian','A','candidate_verified_name','Primordial man',1,false,false,'The primordial man, slain by Ahriman; from his seed sprang the human race.'),
 ('ENT_ZOR_SAOSHYANT','Saoshyant','Zoroastrian','Savior figure','Eschatological Savior','the final renovation; resurrection; the defeat of evil','Iranian','A','candidate_verified_name','Eschatological savior',0,false,false,'Astvat-ereta, the future savior born of Zoroaster''s seed who brings the Frashokereti.'),
 ('ENT_ZOR_YIMA','Yima','Zoroastrian','Primordial king','First King','the first kingship; the vara refuge; the golden age','Iranian','A','candidate_verified_name','Primordial ruler',0,false,false,'Yima Khshaeta, the first king, who built the vara to shelter life from the great winter.'),
 ('ENT_ZOR_THRAETAONA','Thraetaona','Zoroastrian','Hero','Dragon-slayer','heroism; healing; the binding of the dragon','Iranian','A','candidate_verified_name','Dragon-slaying hero',0,false,false,'The hero who smote and bound the three-headed dragon Azhi Dahaka.'),
 ('ENT_ZOR_KERESASPA','Keresaspa','Zoroastrian','Hero','Monster-slayer','heroism; the club; the slaying of monsters','Iranian','A','candidate_verified_name','Warrior hero',0,false,false,'The club-bearing hero, slayer of the serpent Srvara and other monsters.'),
 ('ENT_ZOR_ZARATHUSTRA','Zarathustra','Zoroastrian','Prophet','Founder-prophet','revelation; the Gathas; the founding of the religion','Iranian','A','candidate_verified_name','Founder-prophet',0,false,false,'The prophet Zarathushtra, recipient of the revelation of Ahura Mazda.'),
 -- The daeva counter-pantheon and the druj
 ('ENT_ZOR_AKA_MANAH','Aka Manah','Zoroastrian','Demon','Arch-daeva','evil mind; evil purpose','Iranian','A','candidate_verified_name','Arch-daeva (counter to Vohu Manah)',0,true,false,'The Evil Mind, the daeva opposing Vohu Manah (the Good Mind).'),
 ('ENT_ZOR_INDRA_DAEVA','Indra','Zoroastrian','Demon','Arch-daeva','apostasy; the turning from righteousness','Iranian','B','candidate_verified_name','Arch-daeva (counter to Asha)',0,true,false,'The arch-daeva Indra, who turns people from Asha Vahishta (Truth).'),
 ('ENT_ZOR_SAURVA','Saurva','Zoroastrian','Demon','Arch-daeva','misrule; tyranny; oppression','Iranian','B','candidate_verified_name','Arch-daeva (counter to Khshathra)',0,true,false,'The daeva of misrule, opposing Khshathra Vairya (Dominion).'),
 ('ENT_ZOR_NANGHAITHYA','Nanghaithya','Zoroastrian','Demon','Arch-daeva','discontent; heresy; presumption','Iranian','B','candidate_verified_name','Arch-daeva (counter to Armaiti)',0,true,false,'The daeva of discontent, opposing Spenta Armaiti (Devotion).'),
 ('ENT_ZOR_AZ','Az','Zoroastrian','Demon','Demon of Greed','greed; concupiscence; insatiable hunger','Iranian','B','candidate_verified_name','Major demon',0,true,false,'The demon of greed and concupiscence, who devours all and even threatens the other demons.'),
 ('ENT_ZOR_JEH','Jeh','Zoroastrian','Demon','Primal Female Demon','menstruation; defilement; the rousing of evil','Iranian','B','candidate_verified_name','Primal female demon',0,true,false,'Jeh (Jahi), the primal Whore, who rouses Ahriman from his three-thousand-year stupor.'),
 ('ENT_ZOR_ASTOVIDATU','Astovidatu','Zoroastrian','Demon','Death Demon','death; the noose that drags the dying','Iranian','A','candidate_verified_name','Demon of death',0,true,false,'Asto-vidotu, the demon of death who casts the noose over the dying.'),
 ('ENT_ZOR_VIZARESH','Vizaresh','Zoroastrian','Demon','Psychopomp Demon','the dragging-off of wicked souls','Iranian','B','candidate_verified_name','Demon',0,true,false,'The demon who drags the souls of the wicked toward the abyss.'),
 ('ENT_ZOR_NASU','Nasu','Zoroastrian','Demon','Corpse Demon','putrefaction; corpse-pollution','Iranian','A','candidate_verified_name','Demon of corpse-pollution',0,true,false,'The Druj Nasu, the corpse-fly demon of putrefaction who rushes upon the dead.'),
 ('ENT_ZOR_APAOSHA','Apaosha','Zoroastrian','Demon','Drought Demon','drought; the withholding of rain','Iranian','A','candidate_verified_name','Demon of drought',0,false,false,'The demon of drought, defeated by Tishtrya in the battle for the rains.'),
 ('ENT_ZOR_AZHI_DAHAKA','Azhi Dahaka','Zoroastrian','Dragon','Cosmic Serpent','the three-headed dragon; tyranny; chaos','Iranian','A','candidate_verified_name','Cosmic dragon',0,true,true,'The three-headed, six-eyed dragon, bound by Thraetaona until he breaks free at the end of time.'),
 ('ENT_ZOR_BUSHYASTA','Bushyasta','Zoroastrian','Demon','Sloth Demon','sloth; lethargy; oversleeping','Iranian','B','candidate_verified_name','Demon',0,true,false,'The long-handed demoness of sloth, who keeps the faithful from rising for prayer.'),
 ('ENT_ZOR_DRUJ','Druj','Zoroastrian','Demon','The Lie','falsehood; deceit; the cosmic Lie','Iranian','A','candidate_verified_name','Gathic principle of evil',0,true,false,'The Druj, the Lie/Falsehood, the cosmic opposite of Asha (Truth).')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources (each entity to its Avestan/Pahlavi locus) ───────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_ZOR_SPENTA_MAINYU','SRC_AVESTA','Direct attestation','Avesta, Yasna 30.3-6 (Gathas): the two primal Spirits, the better and the bad, who chose life and not-life.'),
 ('ENT_ZOR_VERETHRAGNA','SRC_AVESTA','Direct attestation','Avesta, Yasht 14 (Bahram Yasht): the yazata of victory, appearing in ten incarnations.'),
 ('ENT_ZOR_TISHTRYA','SRC_AVESTA','Direct attestation','Avesta, Yasht 8 (Tir Yasht): the star Sirius and rain-bringer who battles Apaosha.'),
 ('ENT_ZOR_RASHNU','SRC_AVESTA','Direct attestation','Avesta, Yasht 12 (Rashn Yasht): the yazata who weighs souls at the Chinvat Bridge.'),
 ('ENT_ZOR_VAYU','SRC_AVESTA','Direct attestation','Avesta, Yasht 15 (Ram Yasht): the dual wind-god, beneficent and dangerous.'),
 ('ENT_ZOR_HAOMA','SRC_AVESTA','Direct attestation','Avesta, Yasna 9-11 (the Hom Yasht): the deified sacred plant and its pressed drink.'),
 ('ENT_ZOR_APAM_NAPAT','SRC_AVESTA','Direct attestation','Avesta, Yasht 19.51-52; Yasna 1.5: "Son of the Waters," the fiery spirit in the waters.'),
 ('ENT_ZOR_ASHI','SRC_AVESTA','Direct attestation','Avesta, Yasht 17 (Ard Yasht): the yazata of reward and good fortune.'),
 ('ENT_ZOR_DAENA','SRC_AVESTA','Direct attestation','Avesta, Yasht 16 (Den Yasht); Vendidad 19.30: conscience/religion, met as a maiden at the Chinvat Bridge.'),
 ('ENT_ZOR_CHISTA','SRC_AVESTA','Direct attestation','Avesta, Yasht 16: Razishta Chista, the yazata of right knowledge and the straight paths.'),
 ('ENT_ZOR_HVAR','SRC_AVESTA','Direct attestation','Avesta, Yasht 6 (Khwarshed Yasht): "the radiant Sun," whose rising purifies creation.'),
 ('ENT_ZOR_MAH','SRC_AVESTA','Direct attestation','Avesta, Yasht 7 (Mah Yasht): the Moon, "containing the seed of cattle."'),
 ('ENT_ZOR_ASMAN','SRC_AVESTA','Direct attestation','Avesta, Sih-rozag 1.27: the personified Sky, the highest of the stone heavens.'),
 ('ENT_ZOR_KHVARENAH','SRC_AVESTA','Direct attestation','Avesta, Yasht 19 (Zamyad Yasht): the divine Glory (khvarenah), the kavyan splendour of kings.'),
 ('ENT_ZOR_GEUSH_URVAN','SRC_AVESTA','Direct attestation','Avesta, Yasna 29 (the Gathic Complaint of the Ox-Soul): the Soul of the Primordial Bovine.'),
 ('ENT_ZOR_NAIRYOSANGHA','SRC_AVESTA','Direct attestation','Avesta, Yasna 17.11; Vendidad 22.7: the messenger of Ahura Mazda.'),
 ('ENT_ZOR_DRVASPA','SRC_AVESTA','Direct attestation','Avesta, Yasht 9 (Gosh Yasht): the yazata who keeps horses and cattle sound.'),
 ('ENT_ZOR_ZURVAN','SRC_ZAEHNER_ZURVAN','Secondary analysis','Zaehner, Zurvan (1955): in the Zurvanite heresy, Time/Zurvan fathers the twin spirits Ohrmazd and Ahriman.'),
 ('ENT_ZOR_ZURVAN','SRC_BUNDAHISHN','Direct attestation','Greater Bundahishn 1: the boundless Time (Zurvan) framing the cosmogony.'),
 ('ENT_ZOR_GAYOMARD','SRC_BUNDAHISHN','Direct attestation','Greater Bundahishn 3-4, 14: Gayomard the primordial man, slain by Ahriman; from his seed the human race.'),
 ('ENT_ZOR_SAOSHYANT','SRC_AVESTA','Direct attestation','Avesta, Yasht 19.88-96: Astvat-ereta, the future Saoshyant born of Zoroaster''s seed, who brings the Renovation.'),
 ('ENT_ZOR_YIMA','SRC_AVESTA','Direct attestation','Avesta, Vendidad 2; Yasht 19.31-38: Yima, the first king, who built the vara against the great winter.'),
 ('ENT_ZOR_THRAETAONA','SRC_AVESTA','Direct attestation','Avesta, Yasht 5.33-34; 19.36-37: Thraetaona, who smote the three-headed dragon Azhi Dahaka.'),
 ('ENT_ZOR_KERESASPA','SRC_AVESTA','Direct attestation','Avesta, Yasht 19.38-44: the hero Keresaspa, slayer of the serpent Srvara.'),
 ('ENT_ZOR_ZARATHUSTRA','SRC_AVESTA','Direct attestation','Avesta, the Gathas (Yasna 28-53): the prophet Zarathushtra and his revelation.'),
 ('ENT_ZOR_AKA_MANAH','SRC_AVESTA','Direct attestation','Avesta, Vendidad 19.43: Aka Manah (Evil Mind), the daeva opposing Vohu Manah.'),
 ('ENT_ZOR_INDRA_DAEVA','SRC_AVESTA','Direct attestation','Avesta, Vendidad 10.9; 19.43: the arch-daeva Indra, who opposes Asha Vahishta.'),
 ('ENT_ZOR_SAURVA','SRC_AVESTA','Direct attestation','Avesta, Vendidad 10.9; 19.43: the daeva Saurva, demon of misrule, opposing Khshathra Vairya.'),
 ('ENT_ZOR_NANGHAITHYA','SRC_AVESTA','Direct attestation','Avesta, Vendidad 10.9; 19.43: the daeva Nanghaithya, opposing Spenta Armaiti.'),
 ('ENT_ZOR_AZ','SRC_DENKARD','Direct attestation','Denkard; Greater Bundahishn: Az, the demon of greed and concupiscence who devours all.'),
 ('ENT_ZOR_JEH','SRC_BUNDAHISHN','Direct attestation','Greater Bundahishn 4: Jeh (Jahi), the primal Whore, who rouses Ahriman from his stupor.'),
 ('ENT_ZOR_ASTOVIDATU','SRC_AVESTA','Direct attestation','Avesta, Vendidad 5.8-9; Yasht 11: Asto-vidotu, the demon of death who casts the noose.'),
 ('ENT_ZOR_VIZARESH','SRC_AVESTA','Direct attestation','Avesta, Vendidad 19.29: Vizaresh, who drags off the souls of the wicked.'),
 ('ENT_ZOR_NASU','SRC_AVESTA','Direct attestation','Avesta, Vendidad 7-8: the Druj Nasu, the corpse-demon of putrefaction.'),
 ('ENT_ZOR_APAOSHA','SRC_AVESTA','Direct attestation','Avesta, Yasht 8.21-29 (Tir Yasht): Apaosha, the demon of drought defeated by Tishtrya.'),
 ('ENT_ZOR_AZHI_DAHAKA','SRC_AVESTA','Direct attestation','Avesta, Yasht 5.29-31; 9.7-8: Azhi Dahaka, the three-headed dragon, bound until the end of time.'),
 ('ENT_ZOR_BUSHYASTA','SRC_AVESTA','Direct attestation','Avesta, Vendidad 18.16: Bushyasta, the long-handed demoness of sloth.'),
 ('ENT_ZOR_DRUJ','SRC_AVESTA','Direct attestation','Avesta, Yasna 30-31, 44 (Gathas): the Druj, the Lie, the cosmic opposite of Asha.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 -- the twin-spirits axis and Zurvanite parentage
 ('ENT_ZOR_SPENTA_MAINYU','opposes','ENT_ZOR_ANGRA_MAINYU','high','The two primal Spirits choose life and not-life (Yasna 30.3-5).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_SPENTA_MAINYU','emanates_from','ENT_ZOR_AHURA_MAZDA','high','Spenta Mainyu is the Bounteous Spirit of Ahura Mazda.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_ZURVAN','parent_of','ENT_ZOR_AHURA_MAZDA','medium','In the Zurvanite myth, Time fathers Ohrmazd.','SRC_ZAEHNER_ZURVAN','reviewed'),
 ('ENT_ZOR_ZURVAN','parent_of','ENT_ZOR_ANGRA_MAINYU','medium','In the Zurvanite myth, Time fathers Ahriman.','SRC_ZAEHNER_ZURVAN','reviewed'),
 -- yazata embodiments and associations
 ('ENT_ZOR_HVAR','embodies','ENT_SUN','high','Hvar Khshaeta is the deified Sun (Yasht 6).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_MAH','embodies','ENT_MOON','high','Mah is the deified Moon (Yasht 7).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_VAYU','embodies','ENT_WIND','high','Vayu is the deified Wind (Yasht 15).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_ASHI','embodies','ENT_FORTUNE','high','Ashi embodies reward and good fortune (Yasht 17).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_KHVARENAH','symbolizes','ENT_FORTUNE','high','The khvarenah is the divine Glory/Fortune of kings (Yasht 19).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_RASHNU','embodies','ENT_JUDGMENT','high','Rashnu embodies judgement, weighing souls (Yasht 12).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_APAM_NAPAT','dwells_in','ENT_WATER','high','Apam Napat, "Son of the Waters," dwells within the waters (Yasht 19.51).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_VERETHRAGNA','aligned_with','ENT_ZOR_MITHRA','high','Verethragna marches before Mithra as his ally (Yasht 10).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_ASTOVIDATU','embodies','ENT_DEATH','high','Asto-vidotu is the demon of death (Vendidad 5.8).','SRC_AVESTA','reviewed'),
 -- prophet, primordial, eschatological
 ('ENT_ZOR_ZARATHUSTRA','taught_by','ENT_ZOR_AHURA_MAZDA','high','Zarathushtra receives the revelation from Ahura Mazda (the Gathas).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_ZARATHUSTRA','reveals','ENT_ZOR_DAENA','high','Zarathushtra reveals the Daena (the religion).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_GAYOMARD','slain_by','ENT_ZOR_ANGRA_MAINYU','high','Gayomard the primordial man is slain by Ahriman (Bundahishn 4).','SRC_BUNDAHISHN','reviewed'),
 ('ENT_ZOR_YIMA','possesses','ENT_ZOR_KHVARENAH','medium','Yima holds, then loses, the divine Glory (Yasht 19.31-34).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_SAOSHYANT','opposes','ENT_ZOR_ANGRA_MAINYU','high','The Saoshyant defeats evil at the final Renovation (Yasht 19.89-96).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_THRAETAONA','slays','ENT_ZOR_AZHI_DAHAKA','high','Thraetaona smites and binds the dragon Azhi Dahaka (Yasht 5.34).','SRC_AVESTA','reviewed'),
 -- the daeva counter-pantheon: membership and the mirror-oppositions to the Amesha Spentas
 ('ENT_ZOR_AKA_MANAH','member_of','ENT_ZOR_DAEVAS','high','Aka Manah is an arch-daeva.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_INDRA_DAEVA','member_of','ENT_ZOR_DAEVAS','high','Indra is an arch-daeva.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_SAURVA','member_of','ENT_ZOR_DAEVAS','high','Saurva is an arch-daeva.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_NANGHAITHYA','member_of','ENT_ZOR_DAEVAS','high','Nanghaithya is an arch-daeva.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_AZ','member_of','ENT_ZOR_DAEVAS','high','Az is a chief demon of Ahriman''s host.','SRC_DENKARD','reviewed'),
 ('ENT_ZOR_NASU','member_of','ENT_ZOR_DAEVAS','high','The Druj Nasu is a demon of Ahriman''s host.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_BUSHYASTA','member_of','ENT_ZOR_DAEVAS','high','Bushyasta is a demoness of Ahriman''s host.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_AKA_MANAH','opposes','ENT_ZOR_VOHU_MANAH','high','The Evil Mind is the mirror-opposite of the Good Mind (Vendidad 19.43).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_INDRA_DAEVA','opposes','ENT_ZOR_ASHA_VAHISHTA','high','Indra turns people from Asha/Truth (Vendidad 19.43).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_SAURVA','opposes','ENT_ZOR_KHSHATHRA','high','Saurva is the mirror-opposite of Khshathra Vairya (Vendidad 19.43).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_NANGHAITHYA','opposes','ENT_ZOR_SPENTA_ARMATI','high','Nanghaithya is the mirror-opposite of Spenta Armaiti (Vendidad 19.43).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_SRAOSHA','opposes','ENT_ZOR_AESHMA_DAEVA','high','Sraosha (Obedience) is the standing adversary of Aeshma (Wrath).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_TISHTRYA','opposes','ENT_ZOR_APAOSHA','high','Tishtrya defeats Apaosha for the rains (Yasht 8.21-29).','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_DRUJ','opposes','ENT_ZOR_ASHA_VAHISHTA','high','The Lie (Druj) is the cosmic opposite of Truth (Asha) in the Gathas.','SRC_AVESTA','reviewed'),
 ('ENT_ZOR_JEH','member_of','ENT_ZOR_DAEVAS','high','Jeh is the primal female demon of Ahriman''s host.','SRC_BUNDAHISHN','reviewed'),
 ('ENT_ZOR_ANGRA_MAINYU','creator_of','ENT_ZOR_AZHI_DAHAKA','high','Ahriman fashions the dragon Azhi Dahaka against the creation.','SRC_BUNDAHISHN','reviewed'),
 ('ENT_ZOR_AHURA_MAZDA','creator_of','ENT_ZOR_SPENTA_MAINYU','medium','Ahura Mazda acts through his Bounteous Spirit.','SRC_AVESTA','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Zoroastrian entities' AS label, count(*) FROM entities WHERE tradition='Zoroastrian';
SELECT count(*) AS unsourced_zor FROM entities e WHERE e.tradition='Zoroastrian'
  AND NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT * FROM v_release_metrics;

COMMIT;
