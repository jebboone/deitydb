-- scripts/build_lurianic_kabbalah.sql
-- Content deepening (v1.55.0): Lurianic / theosophical Kabbalah. The Jewish-mystical set
-- had the full Sefirot, Ein Sof, Adam Kadmon and Shekhinah, but not the theosophical
-- superstructure. This adds the five partzufim (the divine "configurations"), the four
-- worlds (ABYA), the Lurianic cosmogony (the Tzimtzum, the breaking of the vessels, the
-- holy sparks, the Tikkun), and the realm of evil (the Qliphoth / Sitra Achra). Each to a
-- primary source (the Zohar; Vital's Etz Hayyim); period-linked; wired into the existing
-- Sefirot. (Uses the normalized evidence_type vocabulary and creator_of, not created_by.)

BEGIN;

-- ── A period for the Lurianic/Safed Kabbalah, and the Lurianic primary source ─
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes) VALUES
('PER_JM_LURIANIC','Jewish Mystical','Lurianic / Safed Kabbalah',1500,1700,
 'The Safed Kabbalah of Moshe Cordovero and Isaac Luria (the Ari, 1534-1572) and its transmission by Hayyim Vital; the theosophy of the partzufim, the tzimtzum, the breaking of the vessels and the tikkun.')
ON CONFLICT (period_id) DO NOTHING;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_ETZ_HAYYIM','Hayyim Vital, Etz Hayyim (the Tree of Life), c. 1573 (the systematic exposition of Isaac Luria''s teaching)','','primary text','The foundational systematic text of Lurianic Kabbalah: the tzimtzum, the partzufim, the shevirah and the tikkun')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- the partzufim (divine configurations)
 ('ENT_JM_ARIKH_ANPIN','Arikh Anpin','Jewish Mystical','Partzuf','Divine configuration','the Long Face; mercy; the configuration of Keter','Kabbalistic','A','candidate_verified_name','Lurianic partzuf',0,false,false,'Arikh Anpin ("the Long/Patient Face," Macroprosopus), the partzuf of pure mercy configured from Keter.'),
 ('ENT_JM_ATIKA_KADISHA','Atika Kadisha','Jewish Mystical','Partzuf','Divine configuration','the Ancient Holy One; the innermost mercy','Kabbalistic','A','candidate_verified_name','Lurianic partzuf',0,false,false,'Atika Kadisha ("the Ancient Holy One"), the most concealed inner aspect of Arikh Anpin.'),
 ('ENT_JM_ABBA','Abba','Jewish Mystical','Partzuf','Divine configuration','the supernal Father; wisdom; the configuration of Hokhmah','Kabbalistic','A','candidate_verified_name','Lurianic partzuf',0,false,false,'Abba ("the Father"), the partzuf configured from Hokhmah, who with Imma generates the lower partzufim.'),
 ('ENT_JM_IMMA','Imma','Jewish Mystical','Partzuf','Divine configuration','the supernal Mother; understanding; the configuration of Binah','Kabbalistic','A','candidate_verified_name','Lurianic partzuf',0,false,false,'Imma ("the Mother"), the partzuf configured from Binah, womb of the lower configurations.'),
 ('ENT_JM_ZEIR_ANPIN','Zeir Anpin','Jewish Mystical','Partzuf','Divine configuration','the Small Face; the six emotive sefirot; the Holy One blessed be He','Kabbalistic','A','candidate_verified_name','Lurianic partzuf',0,false,false,'Zeir Anpin ("the Small/Impatient Face," Microprosopus), the partzuf of the six emotive sefirot, "the Holy One."'),
 ('ENT_JM_NUKVA','Nukva','Jewish Mystical','Partzuf','Divine configuration','the Female; Malkhut; the Shekhinah; the divine couple','Kabbalistic','A','candidate_verified_name','Lurianic partzuf',0,false,false,'Nukva de-Zeir Anpin ("the Female"), the partzuf of Malkhut and the Shekhinah, consort of Zeir Anpin.'),
 -- the four worlds (ABYA)
 ('ENT_JM_ATZILUTH','Atziluth','Jewish Mystical','Cosmological realm','World of Emanation','the world of the sefirot; pure divinity','Kabbalistic','A','candidate_verified_name','The four worlds (ABYA)',0,false,false,'Atziluth, the World of Emanation, the realm of the undifferentiated sefirot closest to the Infinite.'),
 ('ENT_JM_BERIAH','Beriah','Jewish Mystical','Cosmological realm','World of Creation','the throne; the highest angels','Kabbalistic','A','candidate_verified_name','The four worlds (ABYA)',0,false,false,'Beriah, the World of Creation, the realm of the divine Throne and the highest angels.'),
 ('ENT_JM_YETZIRAH','Yetzirah','Jewish Mystical','Cosmological realm','World of Formation','the angelic hosts; the formative powers','Kabbalistic','A','candidate_verified_name','The four worlds (ABYA)',0,false,false,'Yetzirah, the World of Formation, the realm of the angelic hosts.'),
 ('ENT_JM_ASSIAH','Assiah','Jewish Mystical','Cosmological realm','World of Action','the material world; the lowest realm','Kabbalistic','A','candidate_verified_name','The four worlds (ABYA)',2,false,false,'Assiah, the World of Action/Making, the lowest world, bordering the material and the shells.'),
 -- the Lurianic cosmogony
 ('ENT_JM_TZIMTZUM','Tzimtzum','Jewish Mystical','Cosmogonic process','Divine contraction','the self-withdrawal of the Infinite; the making of space for creation','Kabbalistic','A','candidate_verified_name','Lurianic cosmogony',0,false,false,'The Tzimtzum, the primordial self-contraction of Ein Sof that vacates a space for creation.'),
 ('ENT_JM_RESHIMU','Reshimu','Jewish Mystical','Cosmogonic process','Residual light','the trace of divine light left after the contraction','Kabbalistic','B','candidate_verified_name','Lurianic cosmogony',0,false,false,'The Reshimu, the residue of divine light remaining in the vacated space after the Tzimtzum.'),
 ('ENT_JM_KAV','Kav','Jewish Mystical','Cosmogonic process','Ray of light','the line of light that re-enters the vacated space','Kabbalistic','A','candidate_verified_name','Lurianic cosmogony',0,false,false,'The Kav, the thin ray of the Infinite Light that re-enters the vacated space to begin creation.'),
 ('ENT_JM_TOHU','Olam ha-Tohu','Jewish Mystical','Cosmological realm','World of Chaos','the primordial unstable world; the unbalanced sefirot','Kabbalistic','A','candidate_verified_name','Lurianic cosmogony',0,false,false,'Olam ha-Tohu, the World of Chaos, whose vessels could not contain the light and shattered.'),
 ('ENT_JM_SHEVIRAH','Shevirat ha-Kelim','Jewish Mystical','Cosmogonic process','Breaking of the Vessels','the cosmic catastrophe; the shattering of the sefirotic vessels','Kabbalistic','A','candidate_verified_name','Lurianic cosmogony',0,false,false,'Shevirat ha-Kelim, the Breaking of the Vessels, the cosmic catastrophe that scattered the divine light.'),
 ('ENT_JM_NETZOTZOT','Netzotzot','Jewish Mystical','Cosmogonic principle','Holy sparks','the fallen sparks of divine light trapped in the shells','Kabbalistic','A','candidate_verified_name','Lurianic cosmogony',0,false,false,'The Netzotzot, the holy sparks of divine light scattered and trapped among the shells at the Shevirah.'),
 ('ENT_JM_TIKKUN','Tikkun','Jewish Mystical','Cosmogonic process','Cosmic repair','the restoration; the gathering of the sparks; redemption','Kabbalistic','A','candidate_verified_name','Lurianic cosmogony',0,false,false,'The Tikkun, the cosmic repair: the gathering of the fallen sparks and the restoration of the broken order.'),
 -- the realm of evil
 ('ENT_JM_QLIPHOTH','Qliphoth','Jewish Mystical','Demonic collective','The shells','the husks that imprison the sparks; the powers of impurity','Kabbalistic','A','candidate_verified_name','Kabbalistic realm of evil',0,true,false,'The Qliphoth (kelipot), the "shells/husks" formed from the broken vessels that imprison the holy sparks.'),
 ('ENT_JM_SITRA_ACHRA','Sitra Achra','Jewish Mystical','Demonic realm','The Other Side','the realm of evil opposed to holiness','Kabbalistic','A','candidate_verified_name','Kabbalistic realm of evil',0,true,false,'The Sitra Achra ("the Other Side"), the realm of impurity and evil, ruled by Samael and Lilith.'),
 -- the hidden sefirah
 ('ENT_JM_DAAT','Da''at','Jewish Mystical','Sefirah','The hidden sefirah','knowledge; the union of wisdom and understanding','Kabbalistic','A','candidate_verified_name','The non-sefirah sefirah',0,false,false,'Da''at ("Knowledge"), the hidden eleventh sefirah, the union of Hokhmah and Binah on the Tree.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_JM_ARIKH_ANPIN','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim; cf. the Zohar Idra Rabba: Arikh Anpin, the partzuf of Keter.'),
 ('ENT_JM_ATIKA_KADISHA','SRC_ZOHAR','direct attestation','Zohar, Idra Rabba/Idra Zuta: Atika Kadisha, the Ancient Holy One.'),
 ('ENT_JM_ABBA','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: Abba, the partzuf of Hokhmah.'),
 ('ENT_JM_IMMA','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: Imma, the partzuf of Binah.'),
 ('ENT_JM_ZEIR_ANPIN','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim; cf. the Zohar Idra: Zeir Anpin, the partzuf of the six emotive sefirot.'),
 ('ENT_JM_NUKVA','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: Nukva de-Zeir Anpin, the partzuf of Malkhut/Shekhinah.'),
 ('ENT_JM_ATZILUTH','SRC_ZOHAR','direct attestation','The Zohar; the four worlds (ABYA): Atziluth, the World of Emanation.'),
 ('ENT_JM_BERIAH','SRC_ZOHAR','direct attestation','The Zohar; the four worlds: Beriah, the World of Creation.'),
 ('ENT_JM_YETZIRAH','SRC_ZOHAR','direct attestation','The Zohar; the four worlds: Yetzirah, the World of Formation.'),
 ('ENT_JM_ASSIAH','SRC_ZOHAR','direct attestation','The Zohar; the four worlds: Assiah, the World of Action.'),
 ('ENT_JM_TZIMTZUM','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim (Sha''ar ha-Hakdamot): the Tzimtzum, the self-contraction of Ein Sof.'),
 ('ENT_JM_RESHIMU','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: the Reshimu, the residue of light after the contraction.'),
 ('ENT_JM_KAV','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: the Kav, the ray of Infinite Light re-entering the vacated space.'),
 ('ENT_JM_TOHU','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: Olam ha-Tohu, the World of Chaos of the unbalanced vessels.'),
 ('ENT_JM_SHEVIRAH','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: Shevirat ha-Kelim, the Breaking of the Vessels.'),
 ('ENT_JM_NETZOTZOT','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: the Netzotzot, the holy sparks scattered at the Shevirah.'),
 ('ENT_JM_TIKKUN','SRC_ETZ_HAYYIM','direct attestation','Vital, Etz Hayyim: the Tikkun, the gathering of the sparks and the restoration of the order.'),
 ('ENT_JM_QLIPHOTH','SRC_ZOHAR','direct attestation','The Zohar: the kelipot/qliphoth, the shells of impurity surrounding the holy.'),
 ('ENT_JM_SITRA_ACHRA','SRC_ZOHAR','direct attestation','The Zohar: the Sitra Achra, the Other Side, the realm of evil.'),
 ('ENT_JM_DAAT','SRC_ZOHAR','direct attestation','The Zohar; Kabbalistic tradition: Da''at, the hidden sefirah uniting Hokhmah and Binah.')
ON CONFLICT DO NOTHING;

-- ── Periods ──────────────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_JM_LURIANIC', 'A', 'Lurianic/Safed Kabbalah (the partzufim and the Lurianic cosmogony).', 'reviewed'
FROM entities WHERE canonical_name IN
 ('Arikh Anpin','Atika Kadisha','Abba','Imma','Zeir Anpin','Nukva',
  'Tzimtzum','Reshimu','Kav','Olam ha-Tohu','Shevirat ha-Kelim','Netzotzot','Tikkun')
  AND tradition='Jewish Mystical'
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_JM_MEDIEVAL', 'A', 'Zoharic/medieval Kabbalah (the four worlds, the qliphoth, Da''at).', 'reviewed'
FROM entities WHERE canonical_name IN
 ('Atziluth','Beriah','Yetzirah','Assiah','Qliphoth','Sitra Achra','Da''at')
  AND tradition='Jewish Mystical'
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 -- the partzufim configured from the sefirot
 ('ENT_JM_ARIKH_ANPIN','identified_with','ENT_JM_KETER','high','Arikh Anpin is the partzuf configured from Keter.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_ATIKA_KADISHA','aligned_with','ENT_JM_ARIKH_ANPIN','high','Atika Kadisha is the innermost concealed aspect of Arikh Anpin.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_ABBA','identified_with','ENT_JM_HOKHMAH','high','Abba is the partzuf configured from Hokhmah.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_IMMA','identified_with','ENT_JM_BINAH','high','Imma is the partzuf configured from Binah.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_ZEIR_ANPIN','aligned_with','ENT_JM_TIFERET','high','Zeir Anpin comprises the six emotive sefirot, centred on Tiferet.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_NUKVA','identified_with','ENT_JM_MALKHUT','high','Nukva is the partzuf configured from Malkhut.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_NUKVA','aligned_with','ENT_JM_SHEKHINAH','high','Nukva is the Shekhinah, the indwelling divine presence.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_ZEIR_ANPIN','child_of','ENT_JM_ABBA','high','Zeir Anpin is generated from the union of Abba and Imma.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_ZEIR_ANPIN','child_of','ENT_JM_IMMA','high','Zeir Anpin is generated from the union of Abba and Imma.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_NUKVA','consort_of','ENT_JM_ZEIR_ANPIN','high','Nukva and Zeir Anpin are the divine couple whose union the tikkun restores.','SRC_ETZ_HAYYIM','reviewed'),
 -- the Lurianic cosmogony
 ('ENT_JM_TZIMTZUM','aligned_with','ENT_JM_EIN_SOF','high','The Tzimtzum is the self-contraction of Ein Sof, the Infinite.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_RESHIMU','aligned_with','ENT_JM_TZIMTZUM','high','The Reshimu is the light left behind by the Tzimtzum.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_KAV','emanates_from','ENT_JM_EIN_SOF','high','The Kav is the ray of the Infinite Light re-entering the vacated space.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_ADAM_KADMON','emanates_from','ENT_JM_KAV','high','Adam Kadmon is the first emanation projected through the Kav into the vacated space.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_TOHU','aligned_with','ENT_JM_SHEVIRAH','high','The vessels of Olam ha-Tohu are those that shattered in the Shevirah.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_NETZOTZOT','aligned_with','ENT_JM_SHEVIRAH','high','The holy sparks were scattered by the Breaking of the Vessels.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_QLIPHOTH','aligned_with','ENT_JM_SHEVIRAH','high','The shells (qliphoth) formed from the shards of the broken vessels.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_TIKKUN','aligned_with','ENT_JM_NETZOTZOT','high','The Tikkun is accomplished by gathering up the fallen sparks.','SRC_ETZ_HAYYIM','reviewed'),
 ('ENT_JM_TIKKUN','opposes','ENT_JM_QLIPHOTH','high','The Tikkun liberates the sparks from the shells, undoing the power of the qliphoth.','SRC_ETZ_HAYYIM','reviewed'),
 -- the four worlds descending
 ('ENT_JM_BERIAH','emanates_from','ENT_JM_ATZILUTH','high','Beriah proceeds from Atziluth in the descent of the worlds.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_YETZIRAH','emanates_from','ENT_JM_BERIAH','high','Yetzirah proceeds from Beriah.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_ASSIAH','emanates_from','ENT_JM_YETZIRAH','high','Assiah proceeds from Yetzirah, the lowest of the four worlds.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_ATZILUTH','aligned_with','ENT_JM_SEFIROT','high','Atziluth is the world in which the sefirot are manifest as pure divinity.','SRC_ZOHAR','reviewed'),
 -- the realm of evil
 ('ENT_JM_SITRA_ACHRA','ruled_by','ENT_GNO_SAMAEL','high','The Sitra Achra is ruled by Samael, its king.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_LILITH','aligned_with','ENT_JM_SITRA_ACHRA','high','Lilith, consort of Samael, is queen of the Sitra Achra.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_QLIPHOTH','aligned_with','ENT_JM_SITRA_ACHRA','high','The qliphoth are the powers of the Sitra Achra.','SRC_ZOHAR','reviewed'),
 -- the hidden sefirah
 ('ENT_JM_DAAT','aligned_with','ENT_JM_SEFIROT','high','Da''at is the hidden sefirah on the Tree, the union of Hokhmah and Binah.','SRC_ZOHAR','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Jewish Mystical' AS k, count(*) v FROM entities WHERE tradition='Jewish Mystical';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS undated FROM entities e WHERE e.tradition='Jewish Mystical' AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
