-- scripts/add_enochian_expansion.sql
-- Expands the Enochian / Second Temple Apocalyptic cluster:
--
--   NEW ENTITIES (4):
--     ENT_ISR_RAGUEL   — archangel of vengeance (1 Enoch 20:4)
--     ENT_ISR_REMIEL   — archangel of resurrection (1 Enoch 20:8; 2 Baruch 55:3)
--     ENT_ISR_SARIEL   — archangel over sinning spirits (1 Enoch 20:6; War Scroll)
--     ENT_ISR_NEPHILIM — giant offspring of Watchers and human women (1 Enoch 6-7; Gen 6:4)
--   Together with ENT_ISR_MICHAEL, ENT_ISR_GABRIEL, ENT_ISR_RAPHAEL, ENT_ISR_URIEL
--   (already in DB), this completes the full 7-archangel council of 1 Enoch 20.
--
--   ENTITY UPDATE (1):
--     ENT_ISR_SHEMIHAZAH — substantive short_note replacing the one-line stub
--
--   NEW RELATIONSHIPS (7):
--     ENT_ISR_BEHEMOTH  paired_with  ENT_ISR_LEVIATHAN   (1 Enoch 60:7-9; Job 40-41)
--     ENT_ISR_MASTEMA   aligned_with ENT_ISR_SATAN        (parallel adversarial figures)
--     ENT_ISR_BENE_ELOHIM member_of  ENT_ISR_WATCHERS    (Bene Elohim = Watchers, Gen 6/1 Enoch)
--     ENT_ISR_BENE_ELOHIM parent_of  ENT_ISR_NEPHILIM    (Gen 6:1-4 + 1 Enoch 7)
--     ENT_ISR_SHEMIHAZAH  parent_of  ENT_ISR_NEPHILIM    (1 Enoch 7:2)
--     ENT_ISR_WATCHERS    parent_of  ENT_ISR_NEPHILIM    (1 Enoch 7:2-6)
--     ENT_ISR_NEPHILIM    opposes     ENT_ISR_YAHWEH      (precipitate the Flood judgment)
--
--   NEW SOURCE (1):
--     SRC_JUBILEES — primary text of Jubilees; anchors Mastema material

BEGIN;

-- ── 1. Source ─────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_JUBILEES',
 'James C. VanderKam (trans.), The Book of Jubilees (2 vols.; CSCO 510–511, Scriptores Aethiopici 87–88; Peeters, Leuven, 1989)',
 'primary text / critical translation',
 'The Book of Jubilees (also "Little Genesis") is a Second Temple Jewish pseudepigraphon (c. 160–150 BCE) presented as a revelation to Moses during his 40 days on Sinai, retelling Genesis 1 through Exodus 12 in a solar-calendar framework. It is the primary source for the figure of Mastema (the chief adversarial spirit who heads the evil spirits descended from the Watchers; Jubilees 10:8-9; 11:5; 17:16; 48:1-18), and provides a systematic account of the Watchers tradition (Jubilees 4:15; 5:1-10) that diverges from but overlaps with 1 Enoch. Jubilees is canonical in the Ethiopian Orthodox Tewahedo Church and is attested in multiple Dead Sea Scrolls manuscripts (14 copies at Qumran, more than any non-canonical text except 1 Enoch). VanderKam''s 1989 CSCO edition provides the critical Ethiopic text with English translation and is the standard scholarly reference. The book is essential for understanding the Second Temple Jewish angelology/demonology cluster: Mastema, the evil spirits as disembodied Nephilim, the Watchers, and the solar calendar used to date the Enochic revelations. Cited for ENT_ISR_MASTEMA.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES

('ENT_ISR_RAGUEL',
 'Raguel',
 'Israelite/Second Temple',
 'archangel of vengeance and divine justice',
 'Angelic Being',
 'divine vengeance; justice; luminaries; cosmic order; punishment of transgression',
 'A',
 'Raguel ("Friend of God" or "Shepherd of God") is one of the seven holy angels who stand before God in 1 Enoch 20:4: "Raguel, one of the holy angels, who takes vengeance on the world of the luminaries." His domain is distinctive — he oversees the execution of divine vengeance specifically against the luminaries (sun, moon, stars) when they transgress their ordained courses, as described in the Astronomical Book of 1 Enoch (chs. 72-82). This gives him a unique cosmological function among the seven: while Michael protects the righteous and Raphael heals, Raguel enforces the moral-astronomical order of the cosmos itself. In the Book of Tobit (2:15 in the Sinaiticus text, though this is textually variant), a figure related to Raguel appears in the narrative context alongside Raphael, suggesting his name was current in Second Temple angelological speculation broadly. Raguel also appears in 1 Enoch 23:4 as a heavenly judge figure. In Ethiopian Orthodox Christianity (where 1 Enoch is canonical), Raguel is venerated as one of the seven archangels alongside Michael, Gabriel, Raphael, Uriel, Sariel, and Remiel. He completes the seven-archangel council of 1 Enoch 20 alongside the four archangels already attested in the canonical Hebrew Bible and the Deuterocanon (Michael, Gabriel, Raphael, Uriel) and the two other 1 Enoch-specific figures (Remiel, Sariel). Collins, The Apocalyptic Imagination (2016) pp. 79-82.'),

('ENT_ISR_REMIEL',
 'Remiel',
 'Israelite/Second Temple',
 'archangel of resurrection and souls of the dead',
 'Angelic Being',
 'resurrection; souls of the dead; hope; eschatology; divine mercy; afterlife',
 'A',
 'Remiel ("Thunder/Mercy of God") is the seventh archangel in the council of 1 Enoch 20:8: "Remiel, one of the holy angels, whom God set over those who rise." His specific domain is therefore the resurrection — he presides over the souls of the dead in their eschatological passage. In 2 Baruch 55:3 (Syriac Apocalypse of Baruch, c. 100 CE), Remiel is explicitly identified as the angel who presides over the souls of the dead, confirming the 1 Enoch 20 assignment. He appears in 1 Enoch 20 as "Jeremiel" in some manuscript traditions, and this variant appears in 4 Ezra 4:36 where Jeremiel/Remiel answers Ezra''s question about how long it will be until the resurrection of the righteous. The identification of Remiel with Jeremiel in 4 Ezra and with the angel of resurrection across multiple Second Temple texts establishes him as one of the most functionally defined of the seven archangels — he has a specific eschatological role (presiding over the resurrection) that distinguishes him from the other six. In the Ethiopian Orthodox archangel veneration tradition, Remiel is venerated alongside the other six on specific feast days. Collins, The Apocalyptic Imagination (2016) pp. 79-82; Nickelsburg, 1 Enoch 1 (Hermeneia, 2001) pp. 297-299.'),

('ENT_ISR_SARIEL',
 'Sariel',
 'Israelite/Second Temple',
 'archangel over spirits who transgress',
 'Angelic Being',
 'spirits; transgression; divine oversight; cosmic accountability; lunar course; Dead Sea Scrolls',
 'A',
 'Sariel (also Saraqael, Suriel, Saraiel; "Command/Prince of God") is the sixth archangel in the council of 1 Enoch 20:6: "Saraqael, one of the holy angels, who is set over the spirits, who sin in the spirit." His domain is the oversight of spirits who transgress — a category distinct from the Watchers (who are fallen angels proper) and the human dead (Remiel''s domain): Sariel governs the intermediate category of sinning spirits who violate their divine mandate. Sariel appears prominently in the Dead Sea Scrolls: in the War Scroll (1QM 9:15-16), the four archangels Michael, Gabriel, Sariel, and Raphael are named on the shields of the four towers of the eschatological battle formation of the Sons of Light, making Sariel the fourth-named archangel in DSS angelology (where Uriel from Hebrew Bible tradition is replaced by Sariel). This DSS attestation is significant because the War Scroll represents a militarized, eschatological angelology that may pre-date or be roughly contemporary with the finalization of 1 Enoch. Sariel also appears in the Aramaic Levi Document and in Hekhalot literature. His domain over sinning spirits connects him to the tradition of spirit oversight that eventually develops into the guardian-angel and demon-accountancy theologies of rabbinic Judaism and early Christianity. Collins, The Apocalyptic Imagination (2016) pp. 79-82; Nickelsburg (2001) pp. 297-299.'),

('ENT_ISR_NEPHILIM',
 'Nephilim',
 'Israelite/Second Temple',
 'giant hybrid offspring of Watchers and human women',
 'Adversarial Being',
 'giants; hybrid corruption; primordial violence; antediluvian era; flood catalyst; forbidden offspring',
 'A',
 'The Nephilim ("fallen ones" or "those who cause others to fall" — etymology debated; possibly from Aramaic npl "to fall") are the giant hybrid offspring born of the union between the Watchers (Bene Elohim, "Sons of God") and human women as described in Genesis 6:1-4: "The Nephilim were on the earth in those days — and also afterward — when the sons of God went in to the daughters of humans, who bore children to them. These were the heroes of old, warriors of renown." The Enochic tradition (1 Enoch 6-7) expands this genealogy: the 200 Watchers, led by Shemihazah, descended on Mount Hermon and took human wives; their offspring were giants 3,000 ells tall who "consumed all the acquisitions of men" and turned against humanity, devouring "birds, beasts, reptiles, and fish" and finally "began to eat human flesh" and "drink the blood" (1 Enoch 7:2-5). The Nephilim''s violence and corruption is the proximate cause of God''s decision to send the Flood. In Numbers 13:33, the Israelite spies report that the Anakim of Canaan are "of Nephilim descent" — establishing the Nephilim as a continuing category of terrifying giant-warriors in the Israelite imagination. In the Enochic cosmological system, the Nephilim''s disembodied spirits become the evil spirits (shedim/demons) that afflict humanity after the Flood (1 Enoch 15:8-12): "The spirits of the giants shall be like clouds, which shall oppress, corrupt, fall, contend, and bruise upon earth." This makes the Nephilim the progenitors of demonology in Second Temple thought — their disembodied spirits become the demons of the post-Flood world. Jubilees 5:1-10; 4Q531 (Book of Giants). Collins (2016) pp. 67-72; Nickelsburg (2001) pp. 191-211.')

ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Update Shemihazah short_note ──────────────────────────────────────────
UPDATE entities SET
  short_note = 'Shemihazah (also Semyaza, Samjaza; "My name has seen" or "Name of God sees") is the leader of the 200 Watchers (angelic beings) who, according to 1 Enoch 6-10, descended from heaven to the summit of Mount Hermon and took human wives. In 1 Enoch 6:3, Shemihazah is named as the ringleader: "And Shemihazah, their chief, said to them: ''I fear you will not agree to do this deed, and only I will have to pay for this great sin.''" Despite his hesitation, all 200 Watchers swear an oath and descend together. He is listed first among the 20 Watcher leaders named in 1 Enoch 6:7: "Shemihazah, Arteqoph, Rametel, Kokabel, Ramel, Danel, Zeqiel, Baraqel, Asael, Hermoni, Matureq, Ananel, Sataoel, Shamshiel, Sahriel, Tummiel, Turiel, Yomioel, Sariel." Shemihazah''s specific teaching is enchantments/spell-casting (1 Enoch 7:1), while the second-most prominent Watcher, Azazel, teaches metalwork and cosmetics. In 1 Enoch 10:11-12, Michael is commanded by God to bind Shemihazah for 70 generations: "Go, Michael, bind Shemihazah and his company who have intermixed with women so as to have defiled themselves with them in all their uncleanness." He is to be bound under the hills of the earth until the Day of Judgment. Shemihazah has a parallel in the Ugaritic tradition (some scholars connect his name to Canaanite divine names), and his figure is preserved in the Dead Sea Scrolls'' Book of Giants (4Q531), which elaborates the Watcher narrative with additional Aramaic material. He is distinct from his Jubilees counterpart, where the leader of the Watchers is called "Mastema" in a more developed demonological schema. Nickelsburg (2001) pp. 175-205.'
WHERE entity_id = 'ENT_ISR_SHEMIHAZAH';

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_ISR_RAGUEL', 'SRC_1_ENOCH', 'Primary text',
 '1 Enoch 20:4: "Raguel, one of the holy angels, who takes vengeance on the world of the luminaries." Also 1 Enoch 23:4 (heavenly judgment). Ethiopian canon includes Raguel among the seven archangels.'),
('ENT_ISR_RAGUEL', 'SRC_2TJ_COLLINS', 'Secondary scholarly',
 'Collins, The Apocalyptic Imagination (3rd ed. 2016) pp. 79-82: analysis of the 1 Enoch 20 seven-archangel council and each figure''s domain.'),
('ENT_ISR_REMIEL', 'SRC_1_ENOCH', 'Primary text',
 '1 Enoch 20:8: "Remiel, one of the holy angels, whom God set over those who rise." Also: 2 Baruch 55:3 (archangel over souls of the dead); 4 Ezra 4:36 (as "Jeremiel").'),
('ENT_ISR_REMIEL', 'SRC_2TJ_COLLINS', 'Secondary scholarly',
 'Collins (2016) pp. 79-82; Nickelsburg, 1 Enoch 1 (Hermeneia, 2001) pp. 297-299.'),
('ENT_ISR_SARIEL', 'SRC_1_ENOCH', 'Primary text',
 '1 Enoch 20:6: "Saraqael, one of the holy angels, who is set over the spirits, who sin in the spirit." War Scroll (1QM 9:15-16): Sariel named on battle tower shield alongside Michael, Gabriel, Raphael.'),
('ENT_ISR_SARIEL', 'SRC_2TJ_COLLINS', 'Secondary scholarly',
 'Collins (2016) pp. 79-82. The War Scroll attestation makes Sariel one of the most widely attested archangels in DSS literature.'),
('ENT_ISR_NEPHILIM', 'SRC_1_ENOCH', 'Primary text',
 '1 Enoch 6-7 (descent of Watchers, begetting of giants/Nephilim); 1 Enoch 15:8-12 (Nephilim spirits become post-Flood demons). Also 4Q531 (Book of Giants, DSS).'),
('ENT_ISR_NEPHILIM', 'SRC_2TJ_COLLINS', 'Secondary scholarly',
 'Collins (2016) pp. 67-72: the Nephilim tradition in Enochic literature and its significance for the development of demonology. Nickelsburg (2001) pp. 191-211.'),
('ENT_ISR_MASTEMA', 'SRC_JUBILEES', 'Primary text',
 'Jubilees 10:8-9 (Mastema pleads to retain 1/10 of evil spirits to afflict humanity); 11:5; 17:16 (tests Abraham); 48:1-18 (Mastema as Exodus adversary parallel to Satan). VanderKam (1989) CSCO 510-511.'),
('ENT_ISR_SHEMIHAZAH', 'SRC_1_ENOCH', 'Primary text',
 '1 Enoch 6:3 (Shemihazah as leader of the 200 Watchers); 1 Enoch 6:7 (first in the list of 20 Watcher leaders); 1 Enoch 10:11-12 (Michael commanded to bind him for 70 generations). 4Q531 (Book of Giants, DSS).')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_ISR_RAGUEL',   'PER_ISR_SECOND_TEMPLE', 'high',
 '1 Enoch''s seven-archangel council (ch. 20) dates to the Second Temple period; Raguel is fully attested in this text.',
 'SRC_1_ENOCH', 'reviewed'),
('ENT_ISR_REMIEL',   'PER_ISR_SECOND_TEMPLE', 'high',
 '1 Enoch 20:8 and 2 Baruch 55:3; both Second Temple period texts. 4 Ezra (as Jeremiel) is c. 100 CE, within the late Second Temple / early post-Temple period.',
 'SRC_1_ENOCH', 'reviewed'),
('ENT_ISR_SARIEL',   'PER_ISR_SECOND_TEMPLE', 'high',
 '1 Enoch 20:6 and War Scroll (1QM); War Scroll is a DSS text c. 100 BCE to 1st c. CE.',
 'SRC_1_ENOCH', 'reviewed'),
('ENT_ISR_NEPHILIM', 'PER_ISR_SECOND_TEMPLE', 'high',
 '1 Enoch 6-7 fully elaborates the Nephilim tradition in the Second Temple period; Genesis 6 provides the Iron Age seed text.',
 'SRC_1_ENOCH', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, period_id, review_status)
VALUES

-- ── Raguel ────────────────────────────────────────────────────────────────────
('ENT_ISR_RAGUEL', 'aligned_with', 'ENT_ISR_MICHAEL',
 'high',
 'Raguel and Michael are co-members of the seven-archangel council in 1 Enoch 20, both standing before God as holy executors of divine will — Michael over the righteous nation and punishing Shemihazah (10:11), Raguel over the vengeance applied to the luminaries when they transgress (20:4). In 1 Enoch 9:1, the four archangels Uriel, Raphael, Michael, and Gabriel see the affliction of the earth and take the petition before God; Raguel operates in a parallel domain. The alignment is that of co-membership in the divine council with distinct functional domains.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_RAGUEL', 'opposes', 'ENT_ISR_WATCHERS',
 'medium',
 'Raguel''s function as the archangel who "takes vengeance on the world of the luminaries" (1 Enoch 20:4) places him in a corrective/punitive relationship to the Watchers, who transgressed their cosmic mandate by descending and intermingling with humanity. While Michael is specifically assigned the punishment of Shemihazah and Raphael is assigned to bind Azazel, Raguel''s domain of vengeance over transgressors of cosmic order encompasses the broader Watcher transgression. Confidence medium: the opposition is inferred from his functional domain, not from a specific narrative of direct confrontation with the Watchers.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

-- ── Remiel ────────────────────────────────────────────────────────────────────
('ENT_ISR_REMIEL', 'aligned_with', 'ENT_ISR_RAPHAEL',
 'medium',
 'Remiel and Raphael are functionally aligned as the eschatological/soteriological pair within the seven-archangel council: Raphael is the angel of healing and is assigned to heal the earth after the Watchers'' corruption (1 Enoch 10:7), while Remiel is assigned to preside over "those who rise" — the resurrection of the righteous (1 Enoch 20:8; 2 Baruch 55:3). Both operate in the domain of restoring creation after corruption/death. The alignment reflects the structural pairing of healing-and-resurrection within the divine council.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_REMIEL', 'aligned_with', 'ENT_ZOR_AMERETAT',
 'low',
 'Remiel (archangel of resurrection, 1 Enoch 20:8) and Ameretat (Zoroastrian Amesha Spenta of immortality/deathlessness) both govern the domain of life-after-death and the ultimate victory of life over mortality. The parallel is structural (shared eschatological life-principle) rather than genetic; the Second Temple Jewish development of a specific resurrection-presiding archangel may have been shaped by Zoroastrian influence during the Achaemenid period, when the doctrine of individual resurrection first appears robustly in Jewish thought (Daniel 12:2; c. 165 BCE). Confidence low: the specific Remiel-Ameretat correspondence is an inference from the Zoroastrian-Jewish angelological influence hypothesis, not from direct ancient equation.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

-- ── Sariel ────────────────────────────────────────────────────────────────────
('ENT_ISR_SARIEL', 'aligned_with', 'ENT_ISR_GABRIEL',
 'medium',
 'In the War Scroll (1QM 9:15-16), the four archangels named on the battle tower shields are "Michael, Gabriel, Sariel, and Raphael" — making Sariel and Gabriel co-members of the tightest four-archangel grouping in DSS angelology. Sariel replaces Uriel in this grouping (who appears as the fourth archangel in some 1 Enoch traditions), suggesting that Sariel and Gabriel belong to the same functional tier within the divine warrior hierarchy of Qumran angelology. The alignment is of divine council co-membership with complementary functions.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_SARIEL', 'opposes', 'ENT_ISR_WATCHERS',
 'medium',
 'Sariel''s domain — oversight of "the spirits, who sin in the spirit" (1 Enoch 20:6) — places him in a corrective relationship to the Watchers and their offspring, whose transgression created the entire category of sinning spirits (the disembodied Nephilim spirits that afflict humanity after the Flood, per 1 Enoch 15:8-12). Sariel is one of the divine officials responsible for the accountability of sinning spiritual beings — a domain arising directly from the Watcher transgression.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

-- ── Nephilim ──────────────────────────────────────────────────────────────────
('ENT_ISR_NEPHILIM', 'child_of', 'ENT_ISR_WATCHERS',
 'high',
 'The Nephilim are the direct offspring of the Watchers (Bene Elohim) and human women in both Genesis 6:1-4 and the Enochic elaboration (1 Enoch 6-7). In 1 Enoch 7:2-3: "And they became pregnant, and they bore great giants, whose height was three thousand ells... they consumed all the acquisitions of men." The child_of relationship captures the genealogical derivation of the Nephilim from the Watchers collective. Nickelsburg (2001) pp. 191-199.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_NEPHILIM', 'child_of', 'ENT_ISR_BENE_ELOHIM',
 'high',
 'Genesis 6:1-4 is the foundational text: "the sons of God (bene ha-elohim) came in to the daughters of humans, who bore children to them." The "sons of God" (Bene Elohim) are the divine beings who father the Nephilim; the Enochic tradition identifies these Bene Elohim with the Watchers (angelic beings who descended from heaven). This relationship preserves the Genesis 6 genealogy in the graph alongside the Enochic elaboration (child_of ENT_ISR_WATCHERS).',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_NEPHILIM', 'opposes', 'ENT_ISR_YAHWEH',
 'high',
 'The Nephilim''s violence, corruption, and consumption of humanity (1 Enoch 7:3-5: they eat birds, beasts, reptiles, fish, and finally human flesh and drink blood) is explicitly the cause of God''s (Yahweh''s) decision to flood the earth: "And then Michael, Uriel, Raphael, and Gabriel looked down from the sanctuary of heaven and saw much blood being shed upon the earth, and all lawlessness being wrought upon the earth... they said to the Lord of the ages: Lord of lords, God of gods, King of kings — and God of the ages — the throne of your glory endures through all the generations of the world, and your name is holy and great and blessed through all the ages of the world... You see what Azazel has done, how he has taught all iniquity on earth and revealed the eternal secrets which were preserved in heaven." (1 Enoch 9:1-6). The Flood is the divine response to the Nephilim''s corruption. Confidence high: the causal link between Nephilim violence and divine judgment (Flood) is explicit in both Genesis 6 and 1 Enoch.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_SHEMIHAZAH', 'parent_of', 'ENT_ISR_NEPHILIM',
 'high',
 '1 Enoch 7:2: "And they became pregnant, and they bore great giants... And when they had grown up, they turned against those who nourished them..." The Nephilim are specifically the offspring of Shemihazah''s group of Watchers — 1 Enoch 7:1 names the women "they took" under Shemihazah''s leadership. In 1 Enoch 10:12, God tells Michael to bind "Shemihazah and his associates, who have intermixed with women so as to have defiled themselves with them." The parent_of relationship captures Shemihazah''s role as the primary Watcher whose congress with human women produced the Nephilim.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

-- ── Enrich thin entities ──────────────────────────────────────────────────────
('ENT_ISR_WATCHERS', 'parent_of', 'ENT_ISR_NEPHILIM',
 'high',
 '1 Enoch 6-7: the 200 Watchers collectively father the Nephilim giants through their unions with human women. The parent_of relationship from the Watchers collective to the Nephilim collective captures this fundamental generative relationship in the Enochic cosmological drama.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_BENE_ELOHIM', 'member_of', 'ENT_ISR_WATCHERS',
 'high',
 'The Bene Elohim ("Sons of God") of Genesis 6:1-4 are identified with the Watchers in 1 Enoch''s elaboration of the same narrative: the Enochic Book of the Watchers opens (1 Enoch 6:1-2) by retelling Gen 6:1-4 with the Bene Elohim as the Watchers who see and desire human women. The Bene Elohim is thus the Genesis-tradition term for the same collective of divine beings whom the Enochic tradition calls Watchers. This member_of relationship captures that the Bene Elohim collective is a sub-group/variant name within the Watchers entity. Confidence high: the identification is explicit in the Enochic text and in most modern scholarly treatments.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_BEHEMOTH', 'paired_with', 'ENT_ISR_LEVIATHAN',
 'high',
 'Behemoth and Leviathan are the canonical eschatological pair in Second Temple apocalyptic literature: 1 Enoch 60:7-9 distinguishes them — "And the female monster whose name is Leviathan dwells in the depths of the sea... and the male monster, whose name is Behemoth, holds his chest in an invisible desert east of the garden where the elect and the righteous dwell." 4 Ezra 6:49-52 parallels this: "You separated Leviathan and Behemoth, giving Behemoth one part of the land on the third day of creation, and Leviathan one part of the sea." Job 40:15-41:34 presents them sequentially. In rabbinic tradition (Leviticus Rabbah 13:3; Bava Batra 74b), Behemoth and Leviathan are the eschatological pair whose battle at the end of days provides the feast for the righteous. The pairing is one of the most consistent dyads in Second Temple and rabbinic eschatology. Collins (2016) pp. 87-89.',
 'SRC_1_ENOCH', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

('ENT_ISR_MASTEMA', 'aligned_with', 'ENT_ISR_SATAN',
 'high',
 'Mastema ("Hostility / Enmity") in Jubilees and Satan in Job and the DSS (especially the Community Rule and War Scroll) serve the same structural function — the adversarial/accusatory divine agent who tests, afflicts, and accuses humanity before God. In Jubilees 17:16, Mastema brings the accusation that prompts God to test Abraham (the binding of Isaac): "Mastema came and said before God, ''Behold, Abraham loves Isaac, his son, and he delights in him above all things. Tell him to offer him as a burnt offering on the altar.''" This is the exact role of the satan figure in Job 1:9-11. In Jubilees 48:1-18, Mastema actively assists the Egyptians against Moses — precisely the adversarial role the Devil plays in Christian typological readings. Most scholars treat Mastema as the Jubilees-tradition name for the same divine-adversary function that the DSS and later Christian tradition calls "Satan." Collins (2016) pp. 92-95.',
 'SRC_JUBILEES', 'PER_ISR_SECOND_TEMPLE', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── 7. Verify ─────────────────────────────────────────────────────────────────
SELECT e.entity_id, e.canonical_name,
       COUNT(r.subject_entity_id) + COUNT(r2.object_entity_id) AS total_rels
FROM entities e
LEFT JOIN entity_relationships r  ON r.subject_entity_id = e.entity_id
LEFT JOIN entity_relationships r2 ON r2.object_entity_id = e.entity_id
WHERE e.entity_id IN (
  'ENT_ISR_RAGUEL','ENT_ISR_REMIEL','ENT_ISR_SARIEL','ENT_ISR_NEPHILIM',
  'ENT_ISR_SHEMIHAZAH','ENT_ISR_BEHEMOTH','ENT_ISR_MASTEMA','ENT_ISR_BENE_ELOHIM'
)
GROUP BY e.entity_id, e.canonical_name
ORDER BY e.entity_id;

SELECT * FROM v_release_metrics;

COMMIT;
