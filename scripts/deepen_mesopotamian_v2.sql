-- =====================================================================
-- deepen_mesopotamian_v2.sql  (v1.60.0 batch)
-- Mesopotamian 76 -> ~112. Second deepening pass (the An=Anum god-list +
-- Black & Green + the Uruk List of Sages). Civic/functional gods, the named
-- viziers, the Seven Sages by name, underworld officials/demons, and the
-- primordial theogony. All verified; alternate names (Dimme=Lamashtu,
-- Asakku=Asag, Sherida=Aya) folded as aliases, not new entities.
-- Additive; ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_LAMBERT_BCM','W. G. Lambert, Babylonian Creation Myths (Eisenbrauns, 2013)',NULL,'secondary scholarship','Mesopotamian theogony / An=Anum'),
 ('SRC_URUK_SAGES','The Uruk List of Kings and Sages (W 20030,7) and Bit Meseri III (the antediluvian apkallu)',NULL,'primary inscription/artifact','Mesopotamian apkallu tradition')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
-- civic / functional gods
 ('ENT_MES_NINSHUBUR','Ninshubur','Mesopotamian','God','Vizier deity','the sukkal (vizier) of Inanna; messenger','regional','A','candidate_verified_name','Inanna''s Descent',0,false,false,'The faithful sukkal (vizier/minister) of Inanna (and of An), whose intercession rescues her from the underworld.'),
 ('ENT_MES_ISIMUD','Isimud','Mesopotamian','God','Vizier deity','the two-faced vizier of Enki','regional','A','candidate_verified_name','Black & Green',0,false,false,'The two-faced sukkal of Enki, who carries his master''s messages and guards the gate of the Abzu.'),
 ('ENT_MES_KAKKA','Kakka','Mesopotamian','God','Messenger deity','messenger of Anu and Anshar','regional','B','candidate_verified_name','Enuma Elish',0,false,false,'The divine messenger of Anu and Anshar, sent between the gods in Enuma Elish and the Descent of Ishtar.'),
 ('ENT_MES_NINGUBLAGA','Ningublaga','Mesopotamian','God','Cattle god','cattle; the herds of the moon-god','regional','B','candidate_verified_name','An=Anum',2,false,false,'A cattle-god of Kiabrig, son of Nanna/Sin, who oversaw the moon-god''s herds.'),
 ('ENT_MES_NUMUSHDA','Numushda','Mesopotamian','God','Nature/flood god','floods; wild nature; the city of Kazallu','regional','B','candidate_verified_name','An=Anum',2,false,false,'A violent flood and nature god, tutelary deity of Kazallu, son of Nanna and Ningal.'),
 ('ENT_MES_ISHARA','Ishara','Mesopotamian','Goddess','Love/oath goddess','love; marriage; oaths; divination; the scorpion','regional','A','candidate_verified_name','Black & Green',0,false,true,'A goddess of love, marriage, oaths and divination (scorpion/Scorpius symbol), of Syrian origin, distinct from Ishtar.'),
 ('ENT_MES_SHULPAE','Shul-pa-e','Mesopotamian','God','Astral god','the planet Jupiter; feasts; disease','regional','B','candidate_verified_name','An=Anum',0,false,false,'An astral god (Jupiter), lord of feasts and bringer of disease; consort of Ninhursag.'),
 ('ENT_MES_LUGALIRRA','Lugal-irra','Mesopotamian','God','Twin/guardian god','doorways; the underworld; war','regional','B','candidate_verified_name','Black & Green',0,true,false,'One of the divine twins (with Meslamta-ea), apotropaic guardians of doorways, equated with Nergal; the constellation Gemini.'),
 ('ENT_MES_MESLAMTAEA','Meslamta-ea','Mesopotamian','God','Twin/guardian god','doorways; the underworld; war','regional','B','candidate_verified_name','Black & Green',0,true,false,'The other of the divine twins (with Lugal-irra), guardian of doorways, equated with Nergal.'),
 ('ENT_MES_LULAL','Lulal','Mesopotamian','God','Protective god','the steppe; protection; the servant of Inanna','regional','B','candidate_verified_name','Inanna''s Descent',1,false,false,'"King of the Steppe," a protective god and servant of Inanna at Bad-tibira; later apotropaic.'),
 ('ENT_MES_TISHPAK','Tishpak','Mesopotamian','God','War god','war; the serpent-dragon; the city of Eshnunna','regional','B','candidate_verified_name','Black & Green',0,false,true,'The warrior tutelary god of Eshnunna, associated with the mushhushshu-dragon, who locally supplanted Ninazu.'),
 ('ENT_MES_NINSIANNA','Ninsianna','Mesopotamian','Deity','Astral deity','the planet Venus','regional','B','candidate_verified_name','An=Anum',0,false,false,'The personified planet Venus, whose gender varied by city; closely linked to Inanna.'),
 ('ENT_MES_UTTU','Uttu','Mesopotamian','Goddess','Crafts goddess','weaving; clothing; the spider','regional','B','candidate_verified_name','Enki and Ninhursag',0,false,false,'The goddess of weaving and clothing (spider iconography), daughter of Enki; distinct from the sun-god Utu.'),
 ('ENT_MES_ASHNAN','Ezina-Ashnan','Mesopotamian','Goddess','Grain goddess','grain; the harvest','regional','A','candidate_verified_name','Debate between Sheep and Grain',3,false,false,'The grain goddess (Sumerian Ezina = Akkadian Ashnan), sister of Lahar, who contends with the flocks in the Sumerian debate-poem.'),
 ('ENT_MES_LAHAR','Lahar','Mesopotamian','Deity','Cattle/flocks deity','sheep; flocks; wool','regional','B','candidate_verified_name','Debate between Sheep and Grain',3,false,false,'The deity of flocks and wool, sibling of Ashnan in the Debate between Sheep and Grain.'),
 ('ENT_MES_ENBILULU','Enbilulu','Mesopotamian','God','Irrigation god','canals; irrigation; rivers','regional','B','candidate_verified_name','Lambert, BCM',3,false,false,'The god of canals and irrigation, son of Enki, later counted among the fifty names of Marduk.'),
 ('ENT_MES_KULLA','Kulla','Mesopotamian','God','Building god','bricks; brickmaking','regional','B','candidate_verified_name','Black & Green',3,false,false,'The brick-god, formed by Ea from clay, invoked at the start of building and banished at its completion.'),
 ('ENT_MES_MUSHDAMMA','Mushdamma','Mesopotamian','God','Building god','building; architecture','regional','B','candidate_verified_name','Enki and the World Order',3,false,false,'The divine architect, "great builder of Enlil," appointed by Enki; paired with Kulla.'),
 ('ENT_MES_SHAKKAN','Shakkan','Mesopotamian','God','Steppe/herds god','wild animals; cattle of the steppe','regional','B','candidate_verified_name','Black & Green',3,false,false,'God of the herds and wild animals of the steppe (Sumuqan/Shamagan), "shepherd of everything."'),
 ('ENT_MES_ENNUGI','Ennugi','Mesopotamian','God','Irrigation/underworld god','canal-inspection; agriculture; the underworld','regional','B','candidate_verified_name','An=Anum',3,true,false,'The "canal-inspector of the gods," throne-bearer of Enlil, with underworld associations; of Nippur.'),
 ('ENT_MES_SIRSIR','Sirsir','Mesopotamian','God','Sailors'' god','boats; sailors; the sea','regional','B','candidate_verified_name','Lambert, BCM',2,false,false,'The god of sailors and boatmen, boatman of Enki of Eridu; later a name of Marduk.'),
 ('ENT_MES_PABILSAG','Pabilsag','Mesopotamian','God','Warrior/judge god','war; judgement; the constellation Sagittarius','regional','A','candidate_verified_name','Black & Green',0,false,false,'A warrior god and divine judge, husband of the healing goddess Gula, identified with Sagittarius; of Isin/Larak.'),
 ('ENT_MES_DAGAN','Dagan','Mesopotamian','God','Grain/chief god','grain; fertility; the chief god of the middle Euphrates','regional','A','candidate_verified_name','Black & Green',3,false,false,'The grain god and "father of the gods" of the middle Euphrates (Tuttul, Terqa), father of the storm-god Hadad.'),
 ('ENT_MES_AMURRU','Amurru','Mesopotamian','God','Nomad god','the steppe; the Amorite nomads','regional','B','candidate_verified_name','Black & Green',2,false,false,'"Martu," the god of the western nomads (the Amorites), son of Anu, husband of Ashratum.'),
 ('ENT_MES_NINTINUGGA','Nintinugga','Mesopotamian','Goddess','Healing goddess','healing; medicine','regional','B','candidate_verified_name','An=Anum',0,false,false,'A Nippur healing goddess, "the lady who restores the dead to life," distinct from but akin to Gula.'),
-- the Seven Sages (apkallu) by name
 ('ENT_MES_UANNEDUGGA','Uannedugga','Mesopotamian','Sage','Antediluvian apkallu','antediluvian wisdom; the second sage','regional','B','candidate_verified_name','Uruk List of Sages',0,false,false,'The second of the Seven Sages, of "broad intelligence," who advised king Alalgar before the Flood.'),
 ('ENT_MES_ENMEDUGGA','Enmedugga','Mesopotamian','Sage','Antediluvian apkallu','antediluvian wisdom; the third sage','regional','B','candidate_verified_name','Uruk List of Sages',0,false,false,'The third of the Seven Sages, "allotted a good fate," who advised king Ammeluanna.'),
 ('ENT_MES_ENMEGALAMMA','Enmegalamma','Mesopotamian','Sage','Antediluvian apkallu','antediluvian wisdom; the fourth sage','regional','B','candidate_verified_name','Uruk List of Sages',0,false,false,'The fourth of the Seven Sages, who advised king Amegalanna.'),
 ('ENT_MES_ENMEBULUGGA','Enmebulugga','Mesopotamian','Sage','Antediluvian apkallu','antediluvian wisdom; the fifth sage','regional','B','candidate_verified_name','Uruk List of Sages',0,false,false,'The fifth of the Seven Sages, who advised king Enmeushumgalanna.'),
 ('ENT_MES_ANENLILDA','Anenlilda','Mesopotamian','Sage','Antediluvian apkallu','antediluvian wisdom; the incantation-priest of Eridu','regional','B','candidate_verified_name','Uruk List of Sages',0,false,false,'The sixth of the Seven Sages, "incantation-priest of Eridu," who advised Dumuzi the shepherd.'),
 ('ENT_MES_UTUABZU','Utuabzu','Mesopotamian','Sage','Antediluvian apkallu','antediluvian wisdom; ascent to heaven','regional','B','candidate_verified_name','Uruk List of Sages',0,false,false,'The seventh and last antediluvian sage, "who ascended to heaven," who advised Enmeduranki.'),
-- underworld officials & demons
 ('ENT_MES_HUMUTTABAL','Humut-tabal','Mesopotamian','Demon','Underworld official','the ferry of the underworld','regional','B','candidate_verified_name','Underworld Vision of an Assyrian Prince',0,true,false,'The bird-headed ferryman of the underworld ("Bring-hither-quickly"), a servant of Ereshkigal.'),
 ('ENT_MES_HUSHBISHAG','Hushbishag','Mesopotamian','Goddess','Underworld official','the household of the underworld','regional','B','candidate_verified_name','Black & Green',0,true,false,'The stewardess/housekeeper of the underworld, wife of Namtar in Ereshkigal''s court.'),
 ('ENT_MES_SALTU','Saltu','Mesopotamian','Goddess','Personified strife','strife; discord','regional','B','candidate_verified_name','Agushaya Hymn',0,false,false,'The personification of strife, created by Ea from the dirt of his fingernails to humble Ishtar in the Agushaya Hymn.'),
 ('ENT_MES_SULAK','Sulak','Mesopotamian','Demon','Disease demon','the latrine; sudden seizure','regional','B','candidate_verified_name','Babylonian Diagnostic Handbook',0,true,false,'A lion-shaped demon "the lurker of the privy," who strikes the solitary with seizure (stroke).'),
 ('ENT_MES_LAMASSU','Lamassu','Mesopotamian','Spirit','Protective spirit','protection; the guardian of thresholds','national','A','candidate_verified_name','Black & Green',0,false,false,'The benevolent female tutelary spirit (the human-headed winged bull/lion as guardian), paired with the male Shedu.'),
 ('ENT_MES_SHEDU','Shedu','Mesopotamian','Spirit','Protective spirit','protection; the guardian of thresholds','national','A','candidate_verified_name','Black & Green',0,false,false,'The benevolent male tutelary spirit (Alad), guardian of palace and gate, paired with the female Lamassu.'),
-- primordial / theogonic
 ('ENT_MES_LAHAMU','Lahamu','Mesopotamian','Primordial deity','Theogonic pair','the primeval silt; the first generation','national','A','candidate_verified_name','Enuma Elish',0,false,true,'The female counterpart of Lahmu, second of the primeval pair born of Apsu and Tiamat; parents of Anshar and Kishar.'),
 ('ENT_MES_ENMESHARRA','Enmesharra','Mesopotamian','Primordial deity','Underworld primordial','the underworld; the ancient "me"s; the dead gods','regional','B','candidate_verified_name','Lambert, BCM',0,true,false,'A primordial "dead god," lord of the ancient powers (me), an underworld figure who contends with Enlil/Ninurta/Marduk.'),
 ('ENT_MES_ALALA','Alala','Mesopotamian','Primordial deity','Theogonic ancestor','the ancestors of Anu','national','B','candidate_verified_name','An=Anum',0,false,false,'A primordial ancestor of Anu (paired with Belili) in the theogonic god-lists.'),
 ('ENT_MES_BELILI','Belili','Mesopotamian','Primordial deity','Theogonic ancestor','the ancestors of Anu','national','B','candidate_verified_name','An=Anum',0,false,false,'A primordial ancestress of Anu (paired with Alala) in the theogonic god-lists.')
ON CONFLICT (entity_id) DO NOTHING;

-- sources: bulk Black & Green; sages -> Uruk List; primordials -> Lambert/Enuma Elish
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_BLACK_GREEN_MESO','scholarly attestation','Black & Green, Gods, Demons and Symbols of Ancient Mesopotamia.'
FROM entities WHERE tradition='Mesopotamian' AND review_status='candidate_verified_name'
  AND entity_id IN ('ENT_MES_NINSHUBUR','ENT_MES_ISIMUD','ENT_MES_KAKKA','ENT_MES_NINGUBLAGA','ENT_MES_NUMUSHDA','ENT_MES_ISHARA','ENT_MES_SHULPAE','ENT_MES_LUGALIRRA','ENT_MES_MESLAMTAEA','ENT_MES_LULAL','ENT_MES_TISHPAK','ENT_MES_NINSIANNA','ENT_MES_UTTU','ENT_MES_ASHNAN','ENT_MES_LAHAR','ENT_MES_ENBILULU','ENT_MES_KULLA','ENT_MES_MUSHDAMMA','ENT_MES_SHAKKAN','ENT_MES_ENNUGI','ENT_MES_SIRSIR','ENT_MES_PABILSAG','ENT_MES_DAGAN','ENT_MES_AMURRU','ENT_MES_NINTINUGGA','ENT_MES_HUMUTTABAL','ENT_MES_HUSHBISHAG','ENT_MES_SALTU','ENT_MES_SULAK','ENT_MES_LAMASSU','ENT_MES_SHEDU')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_URUK_SAGES','inscriptional attestation','Named in the Uruk List of Kings and Sages / Bit Meseri III.'
FROM entities WHERE entity_id IN ('ENT_MES_UANNEDUGGA','ENT_MES_ENMEDUGGA','ENT_MES_ENMEGALAMMA','ENT_MES_ENMEBULUGGA','ENT_MES_ANENLILDA','ENT_MES_UTUABZU')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_LAMBERT_BCM','scholarly attestation','Lambert, Babylonian Creation Myths (theogony / An=Anum).'
FROM entities WHERE entity_id IN ('ENT_MES_LAHAMU','ENT_MES_ENMESHARRA','ENT_MES_ALALA','ENT_MES_BELILI','ENT_MES_ENBILULU','ENT_MES_SIRSIR')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_ENUMA_ELISH','direct attestation','Named in Enuma Elish.'
FROM entities WHERE entity_id IN ('ENT_MES_LAHAMU','ENT_MES_KAKKA')
ON CONFLICT DO NOTHING;

-- periods: Sumerian/Old-Bab civic gods -> EARLY; sages/demons/theogony -> NEO_ASS (1st-millennium codification)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_MES_EARLY','B','Sumerian/early Mesopotamian deity attested from the third millennium.','SRC_BLACK_GREEN_MESO','reviewed'
FROM entities WHERE tradition='Mesopotamian' AND review_status='candidate_verified_name'
  AND entity_id IN ('ENT_MES_NINSHUBUR','ENT_MES_ISIMUD','ENT_MES_NINGUBLAGA','ENT_MES_NUMUSHDA','ENT_MES_SHULPAE','ENT_MES_LUGALIRRA','ENT_MES_MESLAMTAEA','ENT_MES_LULAL','ENT_MES_TISHPAK','ENT_MES_NINSIANNA','ENT_MES_UTTU','ENT_MES_ASHNAN','ENT_MES_LAHAR','ENT_MES_ENBILULU','ENT_MES_KULLA','ENT_MES_MUSHDAMMA','ENT_MES_SHAKKAN','ENT_MES_ENNUGI','ENT_MES_SIRSIR','ENT_MES_PABILSAG','ENT_MES_DAGAN','ENT_MES_AMURRU','ENT_MES_NINTINUGGA','ENT_MES_ISHARA')
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_MES_NEO_ASS','B','Attested/codified in first-millennium god-lists, sage-lists, and ritual texts.','SRC_BLACK_GREEN_MESO','reviewed'
FROM entities WHERE tradition='Mesopotamian' AND review_status='candidate_verified_name'
  AND entity_id IN ('ENT_MES_KAKKA','ENT_MES_UANNEDUGGA','ENT_MES_ENMEDUGGA','ENT_MES_ENMEGALAMMA','ENT_MES_ENMEBULUGGA','ENT_MES_ANENLILDA','ENT_MES_UTUABZU','ENT_MES_HUMUTTABAL','ENT_MES_HUSHBISHAG','ENT_MES_SALTU','ENT_MES_SULAK','ENT_MES_LAMASSU','ENT_MES_SHEDU','ENT_MES_LAHAMU','ENT_MES_ENMESHARRA','ENT_MES_ALALA','ENT_MES_BELILI')
ON CONFLICT DO NOTHING;

-- relationships: the family/myth/function graph
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_MES_NINSHUBUR','member_of','ENT_MES_ANUNNAKI','low','Of the great gods; sukkal of Inanna and An.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_NINSHUBUR','rescues','ENT_MES_INANNA_ISHTAR','high','Ninshubur''s intercession secures Inanna''s release from the underworld.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_ISIMUD','member_of','ENT_MES_ENKI_EA','low','The two-faced vizier in the service of Enki.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_ISIMUD','transmits','ENT_MES_ENKI_EA','medium','Carries the messages and commands of Enki.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_KAKKA','transmits','ENT_MES_ANU','medium','Messenger of Anu and Anshar.','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_NINGUBLAGA','child_of','ENT_MES_NANNA_SIN','high','Son of the moon-god Nanna/Sin.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_NUMUSHDA','child_of','ENT_MES_NANNA_SIN','high','Son of Nanna and Ningal.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_NUMUSHDA','child_of','ENT_MES_NINGAL','high','Son of Nanna and Ningal.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_ISHARA','aligned_with','ENT_MES_INANNA_ISHTAR','medium','Goddess of love associated with, but distinct from, Ishtar.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_SHULPAE','consort_of','ENT_MES_NINHURSAG','high','Consort of the mother-goddess Ninhursag.','SRC_LAMBERT_BCM','reviewed'),
 ('ENT_MES_LUGALIRRA','paired_with','ENT_MES_MESLAMTAEA','high','The divine twins, guardians of doorways (Gemini).','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_LUGALIRRA','identified_with','ENT_MES_NERGAL','medium','The twin gods are equated with Nergal.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_MESLAMTAEA','identified_with','ENT_MES_NERGAL','medium','The twin gods are equated with Nergal.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_LULAL','member_of','ENT_MES_INANNA_ISHTAR','low','A servant-god of Inanna at Bad-tibira.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_TISHPAK','opposes','ENT_MES_NINAZU','low','Locally supplanted Ninazu as city-god of Eshnunna.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_NINSIANNA','aligned_with','ENT_MES_INANNA_ISHTAR','medium','The personified Venus, closely linked to Inanna.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_UTTU','child_of','ENT_MES_ENKI_EA','high','Daughter of Enki (Enki and Ninhursag).','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_ASHNAN','sibling_of','ENT_MES_LAHAR','high','Grain and flocks, the sibling pair of the Sumerian debate.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_ENBILULU','child_of','ENT_MES_ENKI_EA','medium','The canal-god, son of Enki.','SRC_LAMBERT_BCM','reviewed'),
 ('ENT_MES_KULLA','paired_with','ENT_MES_MUSHDAMMA','medium','The brick-god and the divine builder, paired at construction.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_KULLA','creator_of','ENT_MES_ENKI_EA','low','Formed from clay by Ea.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_SIRSIR','member_of','ENT_MES_ENKI_EA','low','Boatman of Enki of Eridu.','SRC_LAMBERT_BCM','reviewed'),
 ('ENT_MES_ENNUGI','member_of','ENT_MES_ENLIL','low','Throne-bearer and canal-inspector of Enlil.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_PABILSAG','consort_of','ENT_MES_GULA','high','Husband of the healing goddess Gula.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_PABILSAG','parent_of','ENT_MES_DAMU','medium','Father of the healing god Damu.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_PABILSAG','parent_of','ENT_MES_NINAZU','low','Father of Ninazu in some traditions.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_NINTINUGGA','aligned_with','ENT_MES_GULA','high','A Nippur healing goddess akin to Gula.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_AMURRU','child_of','ENT_MES_ANU','medium','The nomad-god, son of Anu.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_UANNEDUGGA','member_of','ENT_MES_APKALLU','high','One of the Seven antediluvian Sages.','SRC_URUK_SAGES','reviewed'),
 ('ENT_MES_ENMEDUGGA','member_of','ENT_MES_APKALLU','high','One of the Seven antediluvian Sages.','SRC_URUK_SAGES','reviewed'),
 ('ENT_MES_ENMEGALAMMA','member_of','ENT_MES_APKALLU','high','One of the Seven antediluvian Sages.','SRC_URUK_SAGES','reviewed'),
 ('ENT_MES_ENMEBULUGGA','member_of','ENT_MES_APKALLU','high','One of the Seven antediluvian Sages.','SRC_URUK_SAGES','reviewed'),
 ('ENT_MES_ANENLILDA','member_of','ENT_MES_APKALLU','high','One of the Seven antediluvian Sages.','SRC_URUK_SAGES','reviewed'),
 ('ENT_MES_UTUABZU','member_of','ENT_MES_APKALLU','high','The seventh antediluvian Sage, who ascended to heaven.','SRC_URUK_SAGES','reviewed'),
 ('ENT_MES_ADAPA','member_of','ENT_MES_APKALLU','high','Adapa (Uanna/Oannes), the first of the Seven Sages.','SRC_URUK_SAGES','reviewed'),
 ('ENT_MES_HUMUTTABAL','member_of','ENT_MES_ERESHKIGAL','low','Ferryman in the service of Ereshkigal.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_HUMUTTABAL','dwells_in','ENT_MES_ERESHKIGAL','low','Serves in the underworld of Ereshkigal.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_HUSHBISHAG','consort_of','ENT_MES_NAMTAR','high','Wife of Namtar in the underworld court.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_SALTU','creator_of','ENT_MES_ENKI_EA','low','Created by Ea to humble Ishtar.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_SALTU','opposes','ENT_MES_INANNA_ISHTAR','medium','Made as a rival to humble Ishtar in the Agushaya Hymn.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_LAMASSU','paired_with','ENT_MES_SHEDU','high','The female and male protective tutelary spirits (aladlammu).','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_LAMASSU','protects','ENT_HUMANS','medium','Benevolent guardian spirit of persons and buildings.','SRC_BLACK_GREEN_MESO','reviewed'),
 ('ENT_MES_LAHAMU','sibling_of','ENT_MES_LAHMU','high','Lahmu and Lahamu, the first primeval pair.','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_LAHAMU','child_of','ENT_MES_TIAMAT','high','Born of Apsu and Tiamat.','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_LAHAMU','parent_of','ENT_MES_ANSHAR','high','Lahmu and Lahamu, parents of Anshar and Kishar.','SRC_ENUMA_ELISH','reviewed'),
 ('ENT_MES_ALALA','paired_with','ENT_MES_BELILI','high','The primordial ancestor-pair of Anu.','SRC_LAMBERT_BCM','reviewed'),
 ('ENT_MES_ENMESHARRA','opposes','ENT_MES_ENLIL','medium','The dead primordial god who contends with Enlil''s line.','SRC_LAMBERT_BCM','reviewed'),
 ('ENT_MES_DAGAN','aligned_with','ENT_MES_ENLIL','medium','The "father of gods" of the Euphrates, equated with Enlil.','SRC_BLACK_GREEN_MESO','reviewed')
ON CONFLICT DO NOTHING;

-- homonym: Mesopotamian Alala vs the Greek war-cry personification (both sides)
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Alala','ENT_MES_ALALA','Mesopotamian primordial ancestor of Anu vs the Greek personification of the war-cry (ENT_ALALA) — unrelated homonyms.','intentional_distinct'),
 ('Alala','ENT_ALALA','Greek war-cry personification vs the Mesopotamian primordial Alala (ENT_MES_ALALA) — unrelated homonyms.','intentional_distinct')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Mesopotamian count (expect ~112) =='
SELECT count(*) FROM entities WHERE tradition='Mesopotamian';
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
