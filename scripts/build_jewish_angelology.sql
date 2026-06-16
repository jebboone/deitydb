-- build_jewish_angelology.sql — Jewish angelology expansion (v1.64.0)
-- Adds the 3 Enoch / Hekhalot angelic princes (cosmic-phenomenon princes + throne
-- princes of Metatron's retinue), the missing classic angelic ranks (Maimonides),
-- and major medieval/Kabbalistic archangels — all primary/scholarly-sourced,
-- period-linked, and wired so none are left orphaned. Researched by two agents,
-- homonyms handled (Baraqiel/Kokabiel kept as the existing 1 Enoch Watchers).
-- Idempotent (ON CONFLICT DO NOTHING; edges validated).
BEGIN;

INSERT INTO periods(period_id,tradition,period_name,start_year,end_year,notes)
VALUES ('PER_JM_HEKHALOT','Jewish Mystical','Merkavah and Hekhalot mysticism',200,700,'The late-antique Jewish mystical corpus (Hekhalot literature, 3 Enoch).')
ON CONFLICT DO NOTHING;
INSERT INTO sources(source_id,title,url,source_type,scope)
VALUES ('SRC_MAIMONIDES_MISHNEH_TORAH','Maimonides, Mishneh Torah (Hilkhot Yesodei haTorah)',NULL,'primary text','Medieval halakhic code; the ten ranks of angels at Yesodei haTorah 2:7.')
ON CONFLICT DO NOTHING;

CREATE TEMP TABLE _ang(id text,name text,tradition text,etype text,domains text,note text,src text,period text) ON COMMIT DROP;
INSERT INTO _ang VALUES
-- 3 Enoch 14 cosmic / nature princes
('ENT_JM_BARADIEL','Baradiel','Jewish Mystical','Angel/prince','hail','Prince appointed over hail in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_RUCHIEL','Ruchiel','Jewish Mystical','Angel/prince','wind','Prince appointed over the wind in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_ZAAMIEL','Zaamiel','Jewish Mystical','Angel/prince','vehemence','Prince appointed over vehemence in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_ZIQIEL','Ziqiel','Jewish Mystical','Angel/prince','sparks; comets','Prince appointed over sparks in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_ZIIEL','Ziiel','Jewish Mystical','Angel/prince','commotion; quaking','Prince appointed over commotion in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_ZAPHIEL','Zaphiel','Jewish Mystical','Angel/prince','storm-wind; tempest','Prince appointed over the storm-wind in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_RAAMIEL','Raamiel','Jewish Mystical','Angel/prince','thunder','Prince appointed over the thunders in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_RAASIEL','Raasiel','Jewish Mystical','Angel/prince','earthquake','Prince appointed over the earthquake in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_SHALGIEL','Shalgiel','Jewish Mystical','Angel/prince','snow','Prince appointed over the snow in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_MATARIEL','Matariel','Jewish Mystical','Angel/prince','rain','Prince appointed over the rain in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_SHAMSHIEL','Shamshiel','Jewish Mystical','Angel/prince','day','Prince appointed over the day in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_LAILIEL','Lailiel','Jewish Mystical','Angel/prince','night','Prince appointed over the night in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_GALGALIEL','Galgaliel','Jewish Mystical','Angel/prince','the sphere of the sun','Prince of the globe of the sun in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_OPHANNIEL','Ophanniel','Jewish Mystical','Angel/prince','the sphere of the moon','Prince of the globe of the moon in 3 Enoch','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_RAHATIEL','Rahatiel','Jewish Mystical','Angel/prince','the constellations','Prince appointed over the constellations in 3 Enoch 14','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_NURIEL','Nuriel','Jewish Mystical','Angel/prince','fire','Angel of fire in Hekhalot and midrashic tradition','SRC_HEKHALOT_SCHAFER_SYNOPSE','PER_JM_HEKHALOT'),
-- throne-princes / Metatron retinue
('ENT_JM_HADRANIEL','Hadraniel','Jewish Mystical','Angel/prince','gatekeeper of the heavenly palaces','Towering gatekeeper-prince of the heavenly palaces in 3 Enoch','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_KERUBIEL','Kerubiel','Jewish Mystical','Angel/prince','prince of the cherubim; fire','Fiery prince set over the cherubim in 3 Enoch 22','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_SERAPHIEL','Seraphiel','Jewish Mystical','Angel/prince','prince of the seraphim','Radiant prince who governs the seraphim in 3 Enoch 26','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_HAYLIEL','Hayliel','Jewish Mystical','Angel/prince','prince of the chayyot','Prince set over the holy living creatures in 3 Enoch 20','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_RIKBIEL','Rikbiel','Jewish Mystical','Angel/prince','prince of the wheels of the Merkabah','Prince over the wheels of the divine chariot in 3 Enoch 23','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_RADUERIEL','Radueriel','Jewish Mystical','Angel/prince','heavenly archivist and scribe','Celestial archivist-scribe (Vretil in 2 Enoch) in 3 Enoch 27','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_SOPERIEL_MEHAYYE','Soperiel Mehayye','Jewish Mystical','Angel/prince','scribe of the book of the living','One of two great scribe-princes, who seals the records of the living','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_SOPERIEL_MEMETH','Soperiel Memeth','Jewish Mystical','Angel/prince','scribe of the book of the dead','Scribe-prince who seals the records of the dead in 3 Enoch','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_ANPIEL','Anpiel','Jewish Mystical','Angel/prince','keeper of the keys of the heavenly halls','Prince entrusted with the keys of the heavenly palaces in 3 Enoch 48','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_SOQEDHOZI','Soqedhozi','Jewish Mystical','Angel/prince','weigher of merits','Prince who weighs the merits of humankind in 3 Enoch 18','SRC_3_ENOCH','PER_JM_HEKHALOT'),
('ENT_JM_NAARIEL','Naariel','Jewish Mystical','Angel/prince','throne-prince of the seventh heaven','A throne-prince among the chiefs of the seventh heaven in the Hekhalot tradition','SRC_3_ENOCH','PER_JM_HEKHALOT'),
-- angelic ranks (Maimonides) + the host collective
('ENT_JM_HEAVENLY_HOST','The Heavenly Host','Jewish Mystical','Angelic collective','the assembled ranks of angels','Tzeva ha-Shamayim, the assembled host of the ten angelic ranks','SRC_MAIMONIDES_MISHNEH_TORAH','PER_JM_HEKHALOT'),
('ENT_JM_CHERUBIM','Cherubim','Jewish Mystical','Angelic order/rank','throne-bearers; guardians','One of the ten ranks of angels (Maimonides, Yesodei haTorah 2:7)','SRC_MAIMONIDES_MISHNEH_TORAH','PER_JM_HEKHALOT'),
('ENT_JM_ERELIM','Erelim','Jewish Mystical','Angelic order/rank','valiant ones','One of the ten ranks of angels (Maimonides; cf. Isaiah 33:7)','SRC_MAIMONIDES_MISHNEH_TORAH','PER_JM_HEKHALOT'),
('ENT_JM_MALACHIM','Malachim','Jewish Mystical','Angelic order/rank','messengers','The rank of messenger-angels (Maimonides, Yesodei haTorah 2:7)','SRC_MAIMONIDES_MISHNEH_TORAH','PER_JM_HEKHALOT'),
('ENT_JM_ELOHIM_RANK','Elohim','Jewish Mystical','Angelic order/rank','divine beings','An angelic rank named Elohim among the ten orders (Maimonides)','SRC_MAIMONIDES_MISHNEH_TORAH','PER_JM_HEKHALOT'),
('ENT_JM_ISHIM','Ishim','Jewish Mystical','Angelic order/rank','manlike angels; nearest humanity','The tenth and lowest rank of angels (Maimonides, Yesodei haTorah 2:7)','SRC_MAIMONIDES_MISHNEH_TORAH','PER_JM_HEKHALOT'),
-- medieval / Kabbalistic archangels
('ENT_JM_KEMUEL','Kemuel','Jewish Mystical','Archangel','gatekeeper of heaven','Great prince and gatekeeper who confronts Moses at the threshold of heaven','SRC_HEKHALOT_SCHAFER_SYNOPSE','PER_JM_MEDIEVAL'),
('ENT_JM_ZADKIEL','Zadkiel','Jewish Mystical','Archangel','divine mercy; benevolence','Archangel of mercy and righteousness in medieval Jewish angelology','SRC_ZOHAR','PER_JM_MEDIEVAL'),
('ENT_JM_HANIEL','Haniel','Jewish Mystical','Archangel','grace; Netzach; the sphere of Venus','Archangel of grace associated with Netzach and the planet Venus','SRC_ZOHAR','PER_JM_MEDIEVAL'),
('ENT_JM_ZAPHKIEL','Zaphkiel','Jewish Mystical','Archangel','contemplation; Binah','Archangel of contemplation associated with the sefirah Binah','SRC_ZOHAR','PER_JM_MEDIEVAL');

INSERT INTO entities(entity_id,canonical_name,tradition,entity_type,category,primary_domains,evidence_confidence,review_status,short_note)
SELECT id,name,tradition,etype,'Angel',domains,'B','candidate_verified_name',note FROM _ang
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources(entity_id,source_id,evidence_type,source_note)
SELECT id,src,CASE WHEN src IN ('SRC_MAIMONIDES_MISHNEH_TORAH','SRC_ZOHAR') THEN 'scholarly attestation' ELSE 'direct attestation' END,note FROM _ang
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods(entity_id,period_id,confidence,rationale,source_id,review_status)
SELECT id,period,'high','Attested in the named source corpus',src,'reviewed' FROM _ang
ON CONFLICT DO NOTHING;

-- Cherubim homonym (Jewish rank vs Christian/Dionysian order): register both sides
INSERT INTO entity_duplicate_review(entity_id,canonical_name,duplicate_group_note,decision,reviewed_at) VALUES
 ('ENT_JM_CHERUBIM','Cherubim','Jewish angelic rank distinct from the Christian/Dionysian Cherubim','intentional_distinct',now()),
 ('ENT_CHR_CHERUBIM','Cherubim','Christian/Dionysian order distinct from the Jewish angelic rank','intentional_distinct',now())
ON CONFLICT DO NOTHING;

CREATE TEMP TABLE _ed(subject text,rtype text,object text,confidence text,rationale text,source_id text) ON COMMIT DROP;
INSERT INTO _ed VALUES
-- cosmic princes presides_over their phenomenon
('ENT_JM_RUCHIEL','presides_over','ENT_WIND','high','Prince over the wind','SRC_3_ENOCH'),
('ENT_JM_ZAPHIEL','presides_over','ENT_STORM','high','Prince over the storm-wind','SRC_3_ENOCH'),
('ENT_JM_RAAMIEL','presides_over','ENT_STORM','medium','Prince over the thunders','SRC_3_ENOCH'),
('ENT_JM_RAASIEL','presides_over','ENT_EARTH','medium','Prince over the earthquake','SRC_3_ENOCH'),
('ENT_JM_MATARIEL','presides_over','ENT_WATER','medium','Prince over the rain','SRC_3_ENOCH'),
('ENT_JM_SHAMSHIEL','presides_over','ENT_SUN','medium','Prince over the day','SRC_3_ENOCH'),
('ENT_JM_LAILIEL','presides_over','ENT_DARKNESS','medium','Prince over the night','SRC_3_ENOCH'),
('ENT_JM_GALGALIEL','presides_over','ENT_SUN','high','Prince of the globe of the sun','SRC_3_ENOCH'),
('ENT_JM_OPHANNIEL','presides_over','ENT_MOON','high','Prince of the globe of the moon','SRC_3_ENOCH'),
('ENT_JM_NURIEL','presides_over','ENT_FIRE','medium','Angel of fire','SRC_HEKHALOT_SCHAFER_SYNOPSE'),
('ENT_ISR_BARAQIEL','presides_over','ENT_STORM','medium','In 3 Enoch 14 also the prince over the lightnings','SRC_3_ENOCH'),
-- cosmic princes under Metatron
('ENT_JM_BARADIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes tremble before the enthroned Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_RUCHIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_ZAAMIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_ZIQIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_ZIIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_ZAPHIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_RAAMIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_RAASIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_SHALGIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_MATARIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_SHAMSHIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_LAILIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_GALGALIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_OPHANNIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
('ENT_JM_RAHATIEL','mediated_by','ENT_JM_METATRON','medium','Cosmic princes under Metatron in 3 Enoch 14','SRC_3_ENOCH'),
-- throne-princes govern their orders / serve the throne
('ENT_JM_KERUBIEL','presides_over','ENT_JM_CHERUBIM','high','Prince set over the cherubim','SRC_3_ENOCH'),
('ENT_JM_SERAPHIEL','presides_over','ENT_JM_SERAPHIM','high','Prince set over the seraphim','SRC_3_ENOCH'),
('ENT_JM_HAYLIEL','presides_over','ENT_JM_CHAYYOT','high','Prince set over the chayyot','SRC_3_ENOCH'),
('ENT_JM_RIKBIEL','presides_over','ENT_JM_OPHANIM','high','Prince over the wheels (ophanim) of the chariot','SRC_3_ENOCH'),
('ENT_JM_RIKBIEL','presides_over','ENT_JM_MERKABAH','high','Prince over the wheels of the Merkabah','SRC_3_ENOCH'),
('ENT_JM_SOPERIEL_MEHAYYE','presides_over','ENT_JUDGMENT','medium','Seals the verdicts of the living in the heavenly assize','SRC_3_ENOCH'),
('ENT_JM_SOPERIEL_MEMETH','presides_over','ENT_DEATH','high','Scribe who seals the records of the dead','SRC_3_ENOCH'),
('ENT_JM_SOQEDHOZI','presides_over','ENT_JUDGMENT','high','Weighs the merits of humankind','SRC_3_ENOCH'),
('ENT_JM_RADUERIEL','mediates','ENT_JM_METATRON','medium','Scribal retinue of the throne alongside Metatron','SRC_3_ENOCH'),
('ENT_JM_ANPIEL','guardian_of','ENT_JM_MERKABAH','medium','Holds the keys of the heavenly palaces of the throne','SRC_3_ENOCH'),
('ENT_JM_HADRANIEL','guardian_of','ENT_JM_MERKABAH','medium','Gatekeeper-prince of the way to the Merkabah','SRC_3_ENOCH'),
('ENT_JM_NAARIEL','mediated_by','ENT_JM_METATRON','medium','Throne-prince of the seventh heaven under Metatron','SRC_3_ENOCH'),
-- ranks → the Heavenly Host
('ENT_JM_CHERUBIM','member_of','ENT_JM_HEAVENLY_HOST','high','One of the ten angelic ranks','SRC_MAIMONIDES_MISHNEH_TORAH'),
('ENT_JM_ERELIM','member_of','ENT_JM_HEAVENLY_HOST','high','One of the ten angelic ranks','SRC_MAIMONIDES_MISHNEH_TORAH'),
('ENT_JM_MALACHIM','member_of','ENT_JM_HEAVENLY_HOST','high','One of the ten angelic ranks','SRC_MAIMONIDES_MISHNEH_TORAH'),
('ENT_JM_ELOHIM_RANK','member_of','ENT_JM_HEAVENLY_HOST','high','One of the ten angelic ranks','SRC_MAIMONIDES_MISHNEH_TORAH'),
('ENT_JM_ISHIM','member_of','ENT_JM_HEAVENLY_HOST','high','One of the ten angelic ranks','SRC_MAIMONIDES_MISHNEH_TORAH'),
-- archangels → domains / sefirot-adjacent abstractions
('ENT_JM_KEMUEL','guardian_of','ENT_JM_MERKABAH','medium','Gatekeeper of heaven before the throne','SRC_HEKHALOT_SCHAFER_SYNOPSE'),
('ENT_JM_ZADKIEL','presides_over','ENT_GENEROSITY','medium','Archangel of mercy and benevolence','SRC_ZOHAR'),
('ENT_JM_ZAPHKIEL','presides_over','ENT_UNDERSTANDING','medium','Archangel associated with Binah, divine understanding','SRC_ZOHAR'),
('ENT_JM_HANIEL','presides_over','ENT_VENUS','medium','Archangel of the sphere of Venus','SRC_ZOHAR');

\echo '--- REJECTED edges (bad id/type/source) — should be empty ---'
SELECT e.subject,e.rtype,e.object FROM _ed e
WHERE NOT (EXISTS(SELECT 1 FROM entities x WHERE x.entity_id=e.subject)
  AND EXISTS(SELECT 1 FROM entities x WHERE x.entity_id=e.object)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=e.rtype)
  AND EXISTS(SELECT 1 FROM sources s WHERE s.source_id=e.source_id));

INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status)
SELECT e.subject,e.rtype,e.object,e.confidence,e.rationale,e.source_id,'reviewed' FROM _ed e
WHERE EXISTS(SELECT 1 FROM entities x WHERE x.entity_id=e.subject)
  AND EXISTS(SELECT 1 FROM entities x WHERE x.entity_id=e.object)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=e.rtype)
  AND EXISTS(SELECT 1 FROM sources s WHERE s.source_id=e.source_id)
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

COMMIT;
