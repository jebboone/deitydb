-- scripts/build_mandaean_core.sql
-- Content normalization V (v1.47.0): Mandaean build-out. The Mandaean lightworld of the
-- uthras, the guardians of the living water, the celestial prototypes, the cosmic realms
-- and the underworld kings — the DB had only the 15-entity skeleton (the Four Lives, the
-- saviour-uthras, Ruha and Ur). This brings it to solid canonical depth (15 -> 31), each
-- entity to a primary Mandaean source (the Ginza Rabba, the Book of John, the Qolasta).

BEGIN;

-- ── New source: the Qolasta (Ginza, Book of John, Drower already registered) ──
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_QOLASTA','The Canonical Prayerbook of the Mandaeans (Qolasta), trans. E. S. Drower, 1959','','primary text','The Mandaean liturgical corpus of baptism and the masiqta (ascent of the soul)')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- the lightworld and its uthras
 ('ENT_MAN_UTHRAS','Uthras','Mandaean','Lightworld collective','Light-beings','the World of Light; the rivers of living water','Mandaean','A','candidate_verified_name','Mandaean light-beings',0,false,false,'The uthras, the radiant beings of the World of Light who dwell by the streams of living water.'),
 ('ENT_MAN_SIMAT_HAYYI','Simat Hayyi','Mandaean','Lightworld being','Treasure of Life','the consort of the Great Life; the source of souls','Mandaean','A','candidate_verified_name','Consort of the Great Life',0,false,false,'Simat Hayyi, the Treasure of Life, the female counterpart of the Great Life.'),
 ('ENT_MAN_YAWAR_ZIWA','Yawar Ziwa','Mandaean','Lightworld being','Great uthra','radiance; the helping of souls','Mandaean','A','candidate_verified_name','Great uthra',0,false,false,'Yawar Ziwa, "the Dazzling," a great uthra of light and a helper of souls.'),
 ('ENT_MAN_SHILMAI','Shilmai','Mandaean','Guardian uthra','Guardian of the Jordan','the guarding of the living water; baptism','Mandaean','A','candidate_verified_name','Guardian uthra of the yardna',0,false,false,'Shilmai, one of the two guardian uthras set over the Jordan (yardna).'),
 ('ENT_MAN_NIDBAI','Nidbai','Mandaean','Guardian uthra','Guardian of the Jordan','the guarding of the living water; baptism','Mandaean','A','candidate_verified_name','Guardian uthra of the yardna',0,false,false,'Nidbai, one of the two guardian uthras set over the Jordan (yardna).'),
 ('ENT_MAN_BIHRAM','Bihram','Mandaean','Lightworld being','Uthra of baptism','baptism; the living water; purification','Mandaean','A','candidate_verified_name','Uthra of baptism',0,false,false,'Bihram, the great uthra invoked over the baptismal waters in the masbuta.'),
 ('ENT_MAN_KUSHTA','Kushta','Mandaean','Personified virtue','Truth','truth; faith; the sacred handclasp','Mandaean','A','candidate_verified_name','Personified truth',0,false,false,'Kushta, Truth personified, sealed in the sacred handclasp (kushta) of the faithful.'),
 ('ENT_MAN_ADAM_KASIA','Adam Kasia','Mandaean','Celestial prototype','Hidden Adam','the celestial soul of humanity; the inner Adam','Mandaean','A','candidate_verified_name','Hidden/celestial Adam',0,false,false,'Adam Kasia, the hidden celestial Adam, the inner light-soul of which earthly Adam is the image.'),
 ('ENT_MAN_HAWWA_KASIA','Hawwa Kasia','Mandaean','Celestial prototype','Hidden Eve','the celestial counterpart of Eve','Mandaean','B','candidate_verified_name','Hidden/celestial Eve',0,false,false,'Hawwa Kasia, the hidden celestial Eve, counterpart of Adam Kasia.'),
 -- the cosmic realms
 ('ENT_MAN_WORLD_LIGHT','World of Light','Mandaean','Cosmological realm','Lightworld','the abode of the Great Life and the uthras','Mandaean','A','candidate_verified_name','Mandaean lightworld',0,false,false,'Alma d-Nhura, the World of Light, the abode of the Great Life and the uthras.'),
 ('ENT_MAN_WORLD_DARKNESS','World of Darkness','Mandaean','Cosmological realm','Underworld','the lower waters; the abode of the dark powers','Mandaean','A','candidate_verified_name','Mandaean underworld',0,true,false,'Alma d-Hshuka, the World of Darkness, the realm of the black waters and the dark powers.'),
 ('ENT_MAN_TIBIL','Tibil','Mandaean','Cosmological realm','Material world','the middle earth; the place of trial','Mandaean','A','candidate_verified_name','Mandaean material world',2,false,false,'Tibil, the material earth between the worlds of light and darkness, fashioned by Ptahil.'),
 ('ENT_MAN_MATARTAS','Matartas','Mandaean','Cosmological realm','Purgatory stations','the watch-stations of the soul''s ascent; judgment','Mandaean','A','candidate_verified_name','Soul''s toll-stations',0,false,false,'The matartas, the watch-houses and purgatories through which the ascending soul must pass.'),
 -- the dark powers
 ('ENT_MAN_KRUN','Krun','Mandaean','Underworld king','Primordial dark king','the lowest darkness; the oldest of the dark powers','Mandaean','A','candidate_verified_name','Chief underworld king',0,true,false,'Krun, the "mountain of flesh," the oldest and greatest of the kings of the World of Darkness.'),
 ('ENT_MAN_TWELVE','The Twelve','Mandaean','Astral ruler collective','Zodiacal rulers','the zodiac; the misleading of souls','Mandaean','A','candidate_verified_name','Zodiacal rulers',0,false,false,'The Twelve, the rulers of the zodiac, children of Ruha who beset and mislead souls with the Seven.'),
 ('ENT_MAN_SAURIEL','Sauriel','Mandaean','Death angel','Severer of souls','death; the cutting of the soul from the body','Mandaean','B','candidate_verified_name','Mandaean angel of death',0,true,false,'Sauriel, the angel of death who severs the soul from the body at the end of life.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_MAN_UTHRAS','SRC_GINZA_RBA','Direct attestation','Ginza Rabba (Right Ginza): the uthras, the beings of light who dwell in the World of Light.'),
 ('ENT_MAN_SIMAT_HAYYI','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Simat Hayyi, the Treasure of Life, consort of the Great Life.'),
 ('ENT_MAN_YAWAR_ZIWA','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Yawar Ziwa, the dazzling uthra and helper of souls.'),
 ('ENT_MAN_SHILMAI','SRC_QOLASTA','Direct attestation','The Qolasta (the baptismal liturgy): Shilmai, guardian uthra of the yardna.'),
 ('ENT_MAN_NIDBAI','SRC_QOLASTA','Direct attestation','The Qolasta: Nidbai, guardian uthra of the yardna, with Shilmai.'),
 ('ENT_MAN_BIHRAM','SRC_QOLASTA','Direct attestation','The Qolasta: Bihram, the great uthra invoked over the baptismal waters.'),
 ('ENT_MAN_KUSHTA','SRC_QOLASTA','Direct attestation','The Qolasta; the Ginza: Kushta, Truth, sealed in the sacred handclasp of the faithful.'),
 ('ENT_MAN_ADAM_KASIA','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Adam Kasia, the hidden celestial Adam, the inner soul of humankind.'),
 ('ENT_MAN_HAWWA_KASIA','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Hawwa Kasia, the hidden celestial Eve, counterpart of Adam Kasia.'),
 ('ENT_MAN_WORLD_LIGHT','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Alma d-Nhura, the World of Light, the abode of the Great Life.'),
 ('ENT_MAN_WORLD_DARKNESS','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Alma d-Hshuka, the World of Darkness and its black waters.'),
 ('ENT_MAN_TIBIL','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Tibil, the material earth fashioned by Ptahil between light and darkness.'),
 ('ENT_MAN_MATARTAS','SRC_GINZA_RBA','Direct attestation','Ginza Rabba; the masiqta: the matartas, the watch-stations of the ascending soul.'),
 ('ENT_MAN_KRUN','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Krun, the "mountain of flesh," the oldest king of the World of Darkness.'),
 ('ENT_MAN_TWELVE','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: the Twelve, the zodiacal rulers, children of Ruha who mislead souls.'),
 ('ENT_MAN_SAURIEL','SRC_GINZA_RBA','Direct attestation','Ginza Rabba: Sauriel, the angel who severs the soul from the body at death.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_MAN_UTHRAS','dwells_in','ENT_MAN_WORLD_LIGHT','high','The uthras dwell in the World of Light.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_MANDA_D_HAYYI','member_of','ENT_MAN_UTHRAS','high','Manda d-Hayyi is the foremost of the uthras.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_HIBIL_ZIWA','member_of','ENT_MAN_UTHRAS','high','Hibil Ziwa is a saviour-uthra.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_SITIL','member_of','ENT_MAN_UTHRAS','high','Sitil is an uthra of light.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_ANOSH','member_of','ENT_MAN_UTHRAS','high','Anosh is an uthra of light.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_YAWAR_ZIWA','member_of','ENT_MAN_UTHRAS','high','Yawar Ziwa is a great uthra.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_BIHRAM','member_of','ENT_MAN_UTHRAS','high','Bihram is an uthra of the living water.','SRC_QOLASTA','reviewed'),
 ('ENT_MAN_SIMAT_HAYYI','consort_of','ENT_MAN_HAYYI_RABBI','high','Simat Hayyi is the female counterpart of the Great Life.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_YAWAR_ZIWA','emanates_from','ENT_MAN_HAYYI_RABBI','medium','Yawar Ziwa proceeds from the Great Life.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_SHILMAI','guardian_of','ENT_MAN_JORDAN','high','Shilmai guards the living water of the yardna.','SRC_QOLASTA','reviewed'),
 ('ENT_MAN_NIDBAI','guardian_of','ENT_MAN_JORDAN','high','Nidbai guards the living water of the yardna.','SRC_QOLASTA','reviewed'),
 ('ENT_MAN_BIHRAM','aligned_with','ENT_MAN_JORDAN','high','Bihram presides over the baptism performed in the yardna.','SRC_QOLASTA','reviewed'),
 ('ENT_MAN_KUSHTA','embodies','ENT_TRUTH','high','Kushta is Truth personified.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_ADAM_KASIA','consort_of','ENT_MAN_HAWWA_KASIA','high','Adam Kasia and Hawwa Kasia are the hidden celestial pair.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_ADAM_KASIA','emanates_from','ENT_MAN_WORLD_LIGHT','medium','The hidden Adam is the light-soul descended from the World of Light.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_HAYYI_RABBI','dwells_in','ENT_MAN_WORLD_LIGHT','high','The Great Life dwells in the World of Light.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_WORLD_DARKNESS','opposes','ENT_MAN_WORLD_LIGHT','medium','The World of Darkness stands over against the World of Light.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_RUHA','dwells_in','ENT_MAN_WORLD_DARKNESS','high','Ruha rules amid the lower world of darkness.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_UR','dwells_in','ENT_MAN_WORLD_DARKNESS','high','Ur, the great dark dragon, dwells in the World of Darkness.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_PTAHIL','creator_of','ENT_MAN_TIBIL','high','Tibil, the material world, is fashioned by the demiurge Ptahil.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_ABATHUR','presides_over','ENT_MAN_MATARTAS','medium','Abathur the weigher presides over the judgment of souls at the watch-stations.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_KRUN','dwells_in','ENT_MAN_WORLD_DARKNESS','high','Krun is the deepest king of the World of Darkness.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_KRUN','aligned_with','ENT_MAN_UR','medium','Krun and Ur are among the great powers of the darkness.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_TWELVE','child_of','ENT_MAN_RUHA','high','The Twelve of the zodiac are children of Ruha.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_TWELVE','aligned_with','ENT_MAN_PLANETS','high','The Twelve and the Seven Planets together beset the souls of the living.','SRC_GINZA_RBA','reviewed'),
 ('ENT_MAN_SAURIEL','embodies','ENT_DEATH','high','Sauriel is the Mandaean angel of death.','SRC_GINZA_RBA','reviewed')
ON CONFLICT DO NOTHING;

-- ── Duplicate-name discipline: "World of Light" now exists in both Mandaean and
--    Manichaean cosmologies (Alma d-Nhura vs the Manichaean lightworld). Distinct. ──
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('World of Light','ENT_MAN_WORLD_LIGHT','Reviewed duplicate canonical name; the Mandaean Alma d-Nhura, distinct from the Manichaean World of Light.','intentional_distinct'),
 ('World of Light','ENT_MANICH_WORLD_LIGHT','Reviewed duplicate canonical name; the Manichaean World of Light, distinct from the Mandaean Alma d-Nhura.','intentional_distinct')
ON CONFLICT (canonical_name, entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Mandaean entities' AS label, count(*) FROM entities WHERE tradition='Mandaean';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
