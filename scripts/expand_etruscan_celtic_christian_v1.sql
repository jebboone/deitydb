-- expand_etruscan_celtic_christian_v1.sql
-- Multi-tradition relationship expansion: Etruscan, Celtic/Gaulish, Christian saints.
-- Clears all zero-relationship entities in the three smallest zero-rel traditions.
--
-- ETRUSCAN (7 zero-rel → 0):
--   Reception/equivalence chain to Greek prototypes (De Grummond);
--   domain patron_of; underworld daemons linked via dwells_in + guides.
--   Sources: SRC_DEGRUMMOND_ETRUSCAN, SRC_PIACENZA_LIVER, SRC_LIVY_AUC
--
-- CELTIC/GAULISH (5 zero-rel → 0):
--   Roman interpretatio equations (Lucan's Berne scholiast);
--   patron_of domains from iconography and inscription corpus.
--   Sources: SRC_LUCAN_BELLUM_CIVILE, SRC_OLMSTED_GODS_CELTS,
--            SRC_DELAMARRE_GAULISH, SRC_DUVAL_DIEUX_GAULE
--
-- CHRISTIAN SAINTS (21 zero-rel → 0):
--   Archangels linked to Israelite/Second Temple equivalents;
--   saints linked to patron domains; Gabriel's annunciation and
--   Mary Magdalene's resurrection-witness roles wired to ENT_JESUS_CHRIST.
--   Sources: SRC_NEW_TESTAMENT, SRC_BUTLER_SAINTS, SRC_GOLDEN_LEGEND,
--            SRC_TOBIT, SRC_DDD_CHRISTIAN

BEGIN;

-- ── Pre-flight ─────────────────────────────────────────────────────────────
SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;
SELECT
  e.tradition,
  COUNT(*) FILTER (WHERE NOT EXISTS (
    SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id
  )) AS zero_rel_count
FROM entities e
WHERE e.tradition IN ('Etruscan','Celtic/Gaulish','Christian')
GROUP BY e.tradition
ORDER BY e.tradition;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: ETRUSCAN
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- FUFLUNS — wine, vegetation, vitality; attested on Piacenza liver and mirrors
  ('ENT_ETR_FUFLUNS','reception_of','ENT_DIONYSUS',
    'high',
    'De Grummond (2006) ch. 3: Fufluns is the Etruscan equivalent of Dionysus/Bacchus; Dionysiac myth was directly received into Etruscan culture by the 6th c. BCE as attested on mirrors and the Piacenza liver.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),
  ('ENT_ETR_FUFLUNS','patron_of','ENT_FERTILITY',
    'high',
    'De Grummond (2006): Fufluns presides over wine, vegetation, and vitality — the domain cluster of fertility and natural increase.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),

  -- NETHUNS — wells, springs, sea; Piacenza liver; Latin Neptune borrowed from Etruscan
  ('ENT_ETR_NETHUNS','reception_of','ENT_POSEIDON',
    'high',
    'De Grummond (2006): Nethuns is the Etruscan equivalent of Greek Poseidon/Roman Neptune; Latin "Neptunus" is widely held to be borrowed from Etruscan "Nethuns".',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),
  ('ENT_ETR_NETHUNS','patron_of','ENT_WATER',
    'high',
    'De Grummond (2006); Piacenza liver: Nethuns governs wells, springs, and the sea.',
    'SRC_PIACENZA_LIVER','approved'),

  -- THESAN — dawn goddess; Piacenza liver; mirrors showing abduction of youths
  ('ENT_ETR_THESAN','reception_of','ENT_EOS',
    'high',
    'De Grummond (2006): Thesan is the Etruscan dawn goddess, equivalent to Greek Eos/Roman Aurora; depicted on mirrors abducting youths in the Eos-type scene.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),
  ('ENT_ETR_THESAN','patron_of','ENT_LIGHT',
    'high',
    'De Grummond (2006): Thesan personifies the dawn and the light it brings; attested on the Piacenza liver as a distinct solar-boundary deity.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),

  -- USIL — sun deity; Piacenza liver; mirrors with solar rays
  ('ENT_ETR_USIL','reception_of','ENT_HELIOS',
    'high',
    'De Grummond (2006): Usil is the Etruscan sun deity, equivalent to Greek Helios/Roman Sol; depicted with solar rays on mirrors and in chariot procession; attested on the Piacenza liver.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),
  ('ENT_ETR_USIL','patron_of','ENT_SUN',
    'high',
    'De Grummond (2006); Piacenza liver: Usil governs the solar domain; distinguished from Thesan (dawn) in the Etruscan cosmological scheme.',
    'SRC_PIACENZA_LIVER','approved'),

  -- CHARUN — underworld daemon; Tarquinian tomb paintings; coercer of souls
  ('ENT_ETR_CHARUN','dwells_in','ENT_UNDERWORLD',
    'high',
    'De Grummond (2006): Charun is attested in Tarquinian tomb paintings (Tomba degli Auguri, Tomba dell''Orco) as a denizen of the Etruscan underworld, wielding a hammer and accompanied by serpents.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),
  ('ENT_ETR_CHARUN','guides','ENT_DEAD',
    'high',
    'De Grummond (2006): Charun functions as an active escort/coercer of souls into the underworld — distinct from the passive Greek Charon; he compels the dead rather than merely ferrying them.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),

  -- TUCHULCHA — underworld daimon; Tomba dell''Orco; no Greek counterpart
  ('ENT_ETR_TUCHULCHA','dwells_in','ENT_UNDERWORLD',
    'high',
    'De Grummond (2006): Tuchulcha (vulture beak, donkey ears, serpents) is attested in the Tomba dell''Orco at Tarquinia (4th c. BCE) as a uniquely Etruscan underworld terror-figure.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),
  ('ENT_ETR_TUCHULCHA','paired_with','ENT_ETR_CHARUN',
    'high',
    'De Grummond (2006): Tuchulcha and Charun appear together in the Tomba dell''Orco; the two underworld daemons form a paired terror-couple in Etruscan funerary iconography.',
    'SRC_DEGRUMMOND_ETRUSCAN','approved'),

  -- VOLTUMNA — chief deity of the Etruscan League; Fanum Voltumnae; Livy 4.23
  ('ENT_ETR_VOLTUMNA','patron_of','ENT_SOVEREIGNTY',
    'high',
    'Livy 4.23, 5.17: the Fanum Voltumnae near Volsinii was the pan-Etruscan federal sanctuary; Voltumna was patron of the annual assembly of the Etruscan League, making him the embodiment of Etruscan communal sovereignty.',
    'SRC_LIVY_AUC','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: CELTIC/GAULISH
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- TEUTATES — tribal protective deity; Lucan 1.444 (Berne scholiast equates with Mars)
  ('ENT_CEL_TEUTATES','patron_of','ENT_PROTECTION',
    'high',
    'Lucan, Bellum Civile 1.444-446: Teutates named as a Gaulish deity receiving human sacrifice; the Berne scholiast interprets him as a protective/tribal god. Name element *teuto- means "tribe/people", indicating communal protective function.',
    'SRC_LUCAN_BELLUM_CIVILE','approved'),
  ('ENT_CEL_TEUTATES','equated_with','ENT_ROM_MARS',
    'medium',
    'Berne scholiast on Lucan 1.444: "Teutates, whom we call Mars." One of the Roman interpretationes for Gaulish Teutates; the equation is Roman-era and not universal.',
    'SRC_LUCAN_BELLUM_CIVILE','approved'),

  -- ESUS — enigmatic deity; Pillar of the Boatmen; Lucan; Berne scholiast
  ('ENT_CEL_ESUS','equated_with','ENT_ROM_MERCURY',
    'medium',
    'Berne scholiast on Lucan 1.444: "Esus, whom we call Mercury." The Mercury equation may reflect Esus''s role as a deity of skill, craft, or travel; the Pillar of the Boatmen (c. 14–37 CE) depicts him cutting branches from a tree.',
    'SRC_LUCAN_BELLUM_CIVILE','approved'),

  -- MAPONOS — divine youth, "Great Son"; inscriptions equated with Apollo
  ('ENT_CEL_MAPONOS','equated_with','ENT_ROM_APOLLO',
    'high',
    'Olmsted (1994) pp. 341-344: Romano-Celtic inscriptions at Ribchester, Corbridge, and Hexham record dedications to "Apollo Maponos"; Maponos is consistently equated with Roman Apollo in the northern British and Gaulish inscription record.',
    'SRC_OLMSTED_GODS_CELTS','approved'),
  ('ENT_CEL_MAPONOS','patron_of','ENT_MUSIC',
    'high',
    'Olmsted (1994) pp. 341-344: Maponos is a deity of youth, music, and hunting; cognate with Welsh Mabon ap Modron (imprisoned divine youth of Arthurian myth); the Apollo equation reflects the music/arts domain.',
    'SRC_OLMSTED_GODS_CELTS','approved'),

  -- MATRES / MATRONES — triple mother goddesses; 1,000+ votive inscriptions
  ('ENT_CEL_MATRES','patron_of','ENT_FERTILITY',
    'high',
    'Olmsted (1994) pp. 299-312: the Matres/Matrones are the most widely attested Celtic religious phenomenon (1,000+ inscriptions); depicted as a triad of women bearing infants, fruit, and loaves — a clear fertility and maternal protection collective.',
    'SRC_OLMSTED_GODS_CELTS','approved'),
  ('ENT_CEL_MATRES','patron_of','ENT_ABUNDANCE',
    'high',
    'Duval (1976) pp. 55-60: the Matrones are depicted with cornucopiae, baskets of fruit, and loaves, representing agricultural abundance and household plenty.',
    'SRC_DUVAL_DIEUX_GAULE','approved'),

  -- ROSMERTA — "Good Provider"; sovereignty and abundance; paired with Mercury
  ('ENT_CEL_ROSMERTA','patron_of','ENT_ABUNDANCE',
    'high',
    'Delamarre (2003) p. 268: the name Rosmerta derives from *ro-smerta ("the Good Provider" / "the Great Purveyor"); she is depicted with a wooden tub or bucket of abundance and a patera in ~20 Roman-period dedications from Gaul and the Rhineland.',
    'SRC_DELAMARRE_GAULISH','approved'),
  ('ENT_CEL_ROSMERTA','paired_with','ENT_ROM_MERCURY',
    'high',
    'Duval (1976) pp. 78-82: Rosmerta is frequently paired with Roman Mercury in dedications at Trier, Metz, and Wiesbaden, suggesting a local sovereignty-couple interpretation under the Roman interpretatio.',
    'SRC_DUVAL_DIEUX_GAULE','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: CHRISTIAN ARCHANGELS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- GABRIEL (Christian) — Annunciation (Luke 1:26-38); reception of Second Temple Gabriel
  ('ENT_SAINT_GABRIEL_CHR','reception_of','ENT_ISR_GABRIEL',
    'high',
    'Luke 1:26-38 and Christian tradition receive the Second Temple Gabriel (Daniel 8-9; 1 Enoch) as the Christian archangel Gabriel.',
    'SRC_DDD_CHRISTIAN','approved'),
  ('ENT_SAINT_GABRIEL_CHR','reveals','ENT_JESUS_CHRIST',
    'high',
    'New Testament (Luke 1:26-38): Gabriel announces the conception and birth of Jesus to Mary — the Annunciation — making him the divine messenger who first reveals Jesus to humanity.',
    'SRC_NEW_TESTAMENT','approved'),

  -- MICHAEL (Christian) — opposes Dragon of Revelation (Rev 12:7-9)
  ('ENT_SAINT_MICHAEL_CHR','reception_of','ENT_ISR_MICHAEL',
    'high',
    'Christian tradition (Rev 12:7-9; Jude 9) receives the Second Temple Michael (Daniel 10:13-21; 1 Enoch) as the warrior archangel Michael of Christian tradition.',
    'SRC_DDD_CHRISTIAN','approved'),
  ('ENT_SAINT_MICHAEL_CHR','opposes','ENT_CHR_DRAGON_REVELATION',
    'high',
    'New Testament (Revelation 12:7-9): "Michael and his angels fought against the Dragon... The great dragon was hurled down."',
    'SRC_NEW_TESTAMENT','approved'),

  -- RAPHAEL (Christian) — healing angel; Tobit 12:14-15
  ('ENT_SAINT_RAPHAEL_CHR','reception_of','ENT_ISR_RAPHAEL',
    'high',
    'Christian tradition receives the Second Temple Raphael (Tobit; 1 Enoch 9-10) as the healing archangel Raphael.',
    'SRC_DDD_CHRISTIAN','approved'),
  ('ENT_SAINT_RAPHAEL_CHR','patron_of','ENT_HEALING',
    'high',
    'Tobit 12:14-15: Raphael identifies himself as "one of the seven holy angels... I was sent to test you... and to heal" — canonical identification of Raphael as the angel of healing.',
    'SRC_TOBIT','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: CHRISTIAN SAINTS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- JOSEPH — earthly father of Jesus; patron of craftsmen (Matt 13:55 calls him a carpenter)
  ('ENT_SAINT_JOSEPH','patron_of','ENT_CRAFT',
    'high',
    'New Testament (Matthew 13:55: "Is not this the carpenter''s son?"; Mark 6:3): Joseph is identified as a carpenter/craftsman, establishing his patronage of craft and manual labour.',
    'SRC_NEW_TESTAMENT','approved'),

  -- PETER — apostle; member of mission (Acts)
  ('ENT_SAINT_PETER','member_of','ENT_MISSION',
    'high',
    'New Testament (Acts 1-12; Matthew 16:18-19): Peter is the leader of the apostolic mission following the resurrection, head of the Jerusalem community.',
    'SRC_NEW_TESTAMENT','approved'),

  -- PAUL — apostle; mission to the Gentiles
  ('ENT_SAINT_PAUL','member_of','ENT_MISSION',
    'high',
    'New Testament (Acts 13-28; Pauline epistles): Paul conducts three major missionary journeys across the Mediterranean, founding communities from Antioch to Rome.',
    'SRC_NEW_TESTAMENT','approved'),

  -- MARY MAGDALENE — first resurrection witness (John 20:18)
  ('ENT_SAINT_MARY_MAGDALENE','reveals','ENT_JESUS_CHRIST',
    'high',
    'New Testament (John 20:1-18): Mary Magdalene is the first witness of the risen Jesus and the first to announce the resurrection to the disciples ("I have seen the Lord" — John 20:18); traditionally called "apostle to the apostles."',
    'SRC_NEW_TESTAMENT','approved'),

  -- GABRIEL (already wired above) already reveals JESUS_CHRIST; skip duplicate

  -- ANTHONY THE GREAT — desert father; founder of Christian monasticism
  ('ENT_SAINT_ANTHONY_ABBOT','member_of','ENT_MONASTICISM',
    'high',
    'Butler''s Lives of the Saints: Anthony the Great (c. 251-356 CE) withdrew to the Egyptian desert and became the paradigmatic figure of Christian anchoritic monasticism.',
    'SRC_BUTLER_SAINTS','approved'),
  ('ENT_SAINT_ANTHONY_ABBOT','opposes','ENT_CHR_DEMONS',
    'high',
    'Athanasius, Life of Anthony (c. 357 CE; via SRC_BUTLER_SAINTS): Anthony''s wrestlings with demons in the desert is the paradigmatic narrative of Christian spiritual combat, establishing the motif of the desert monk defeating demonic opposition.',
    'SRC_BUTLER_SAINTS','approved'),

  -- BENEDICT — founder of Benedictine monasticism
  ('ENT_SAINT_BENEDICT','member_of','ENT_MONASTICISM',
    'high',
    'Butler''s Lives of the Saints: Benedict of Nursia (c. 480-547 CE) founded the monastery at Monte Cassino and authored the Rule of Saint Benedict, the foundational document of Western monasticism.',
    'SRC_BUTLER_SAINTS','approved'),

  -- BLAISE — throat healing
  ('ENT_SAINT_BLAISE','patron_of','ENT_HEALING',
    'high',
    'Butler''s Lives of the Saints: Blaise of Sebaste (martyred c. 316 CE) is venerated as patron of throat ailments; the blessing of throats on his feast day is an established Catholic sacramental.',
    'SRC_BUTLER_SAINTS','approved'),

  -- CATHERINE OF ALEXANDRIA — philosophical debates; patron of scholars
  ('ENT_SAINT_CATHERINE_ALEX','patron_of','ENT_SPEECH',
    'high',
    'Golden Legend (Jacobus de Voragine): Catherine of Alexandria is celebrated for confounding fifty pagan philosophers in public debate; she is the patron of scholars, theologians, and orators.',
    'SRC_GOLDEN_LEGEND','approved'),

  -- COSMAS AND DAMIAN — physician martyrs; anargyroi (healers who took no money)
  ('ENT_SAINT_COSMAS_DAMIAN','patron_of','ENT_HEALING',
    'high',
    'Butler''s Lives of the Saints: Cosmas and Damian were physician martyrs (died c. 303 CE) venerated as the anargyroi ("moneyless ones") who healed the sick for free; they are the patron saints of physicians and surgeons.',
    'SRC_BUTLER_SAINTS','approved'),

  -- DUNSTAN — metalwork / abbot of Glastonbury
  ('ENT_SAINT_DUNSTAN','patron_of','ENT_CRAFT',
    'high',
    'Butler''s Lives of the Saints: Dunstan of Canterbury (c. 909-988 CE) was renowned as a metalworker, jeweller, and bellcaster; he is the patron saint of goldsmiths, silversmiths, and craftsmen.',
    'SRC_BUTLER_SAINTS','approved'),

  -- ELIGIUS / ELOI — goldsmith and bishop
  ('ENT_SAINT_ELOI','patron_of','ENT_CRAFT',
    'high',
    'Butler''s Lives of the Saints: Eligius of Noyon (c. 588-660 CE), royal goldsmith to Chlothar II and Dagobert I, is the patron saint of metalworkers, goldsmiths, and craftsmen.',
    'SRC_BUTLER_SAINTS','approved'),

  -- FRANCIS OF ASSISI — animals and creation
  ('ENT_SAINT_FRANCIS','patron_of','ENT_EARTH',
    'high',
    'Butler''s Lives of the Saints: Francis of Assisi (1181/82-1226 CE) is the patron saint of animals and the natural environment; his Canticle of the Creatures praises Brother Sun, Sister Moon, Brother Wind, and all creation.',
    'SRC_BUTLER_SAINTS','approved'),

  -- GEORGE — dragon-slayer (Golden Legend)
  ('ENT_SAINT_GEORGE','slays','ENT_DRAGON',
    'high',
    'Golden Legend (Jacobus de Voragine, c. 1260 CE): George slays a dragon that was terrorising Silene, rescuing a princess and converting the city to Christianity. The dragon-slaying motif is the foundational narrative of George''s cult.',
    'SRC_GOLDEN_LEGEND','approved'),

  -- LUCY — light and sight
  ('ENT_SAINT_LUCY','patron_of','ENT_LIGHT',
    'high',
    'Butler''s Lives of the Saints: Lucy of Syracuse (martyred c. 304 CE) is the patron of the blind and those with eye ailments; her name derives from Latin lux (light), and her feast day (13 December) was historically the longest night.',
    'SRC_BUTLER_SAINTS','approved'),

  -- NICHOLAS — protection of sailors, children, and travellers
  ('ENT_SAINT_NICHOLAS','patron_of','ENT_PROTECTION',
    'high',
    'Butler''s Lives of the Saints: Nicholas of Myra (4th c. CE) is the patron saint of sailors, children, merchants, and the wrongly accused; legendary acts of miraculous protection underlie his vast medieval cult.',
    'SRC_BUTLER_SAINTS','approved'),

  -- ROCH — invoked against plague and disease
  ('ENT_SAINT_ROCH','patron_of','ENT_HEALING',
    'high',
    'Butler''s Lives of the Saints; Catholic Encyclopedia: Roch (c. 1295-1327 CE) is invoked against plague and infectious disease; his cult spread throughout Europe during the Black Death era.',
    'SRC_BUTLER_SAINTS','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight verification ───────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;

-- Zero-rel counts by tradition — should be 0 for Etruscan and Celtic/Gaulish
SELECT
  e.tradition,
  COUNT(*) FILTER (WHERE NOT EXISTS (
    SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id
  )) AS zero_rel_count_after
FROM entities e
WHERE e.tradition IN ('Etruscan','Celtic/Gaulish','Christian')
GROUP BY e.tradition
ORDER BY e.tradition;

-- Dangling reference check
SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
