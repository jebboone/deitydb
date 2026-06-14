-- scripts/add_elamite_layer.sql
-- Adds the Elamite pantheon: four deities of the Kingdom of Elam
-- (c. 2200–539 BCE), the ancient state of SW Iran centered on Susa (modern
-- Khuzestan) that was the dominant non-Mesopotamian civilisation of the
-- ancient Near East and the direct cultural predecessor of Achaemenid Iran.
--
-- Elam is the missing node between the Mesopotamian and Zoroastrian/Iranian
-- layers already in the DB: it connects Sumero-Akkadian civilization to the
-- Iranian religious tradition that produced Zoroastrianism and the
-- Achaemenid imperial cult.
--
-- Primary evidence: cuneiform inscriptions from Susa, votive objects,
-- the Chogha Zanbil (Dur-Untash) ziggurat complex, Louvre bronze statuary.
-- Secondary: Potts (1999), Carter & Stolper (1984).

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_POTTS_ELAM',
 'Daniel T. Potts, The Archaeology of Elam: Formation and Transformation of an Ancient Iranian State (Cambridge World Archaeology; Cambridge University Press, Cambridge, 1999)',
 'secondary scholarly',
 'The comprehensive reference on Elamite civilization from the Proto-Elamite period (c. 3200 BCE) through the Neo-Elamite collapse (539 BCE). Chapter 8 ("Elamite Religion") surveys the pantheon systematically: Inshushinak as the supreme city deity of Susa and judge of the dead; Napirisha as the "great god" of the Middle Elamite period and the patron deity of the Untash-Napirisha dynasty (builders of Chogha Zanbil, c. 1250 BCE); Kiririsha as the principal goddess of Liyan and Susa; Humban as the dominant divine name in Old and Neo-Elamite royal nomenclature. Potts documents the Chogha Zanbil (Dur-Untash) ziggurat complex in detail — the best-preserved ancient ziggurat and the most important Elamite religious monument — which was dedicated to both Inshushinak and Napirisha, with subsidiary temples to Kiririsha and other deities. Also covers the bronze statue of Napirisha (c. 1340 BCE, Louvre), the Inshushinak votive objects from Susa, and the Neo-Elamite royal inscriptions invoking Humban and Kiririsha. Primary scholarly citation for all four Elamite entities.'),
('SRC_CARTER_STOLPER_ELAM',
 'Elizabeth Carter and Matthew W. Stolper, Elam: Surveys of Political History and Archaeology (University of California Publications, Near Eastern Studies 25; University of California Press, Berkeley / Los Angeles / London, 1984)',
 'secondary scholarly',
 'The classic survey of Elamite political history (Carter) and archaeology (Stolper) covering Old Elamite (c. 2200–1600 BCE), Middle Elamite (c. 1600–1100 BCE), and Neo-Elamite (c. 1100–539 BCE) periods. Carter''s chapters on the Old and Middle Elamite periods document the royal inscriptions in which the Elamite kings invoke Inshushinak, Napirisha, Kiririsha, and Humban — providing the primary epigraphic evidence for their functions and relationships. Particularly important for the Middle Elamite religious synthesis under Untash-Napirisha (c. 1340–1300 BCE), who built Dur-Untash/Chogha Zanbil as a sacred city combining the Susian Inshushinak cult with the Anshan Napirisha cult, creating a unified Elamite national religion. Stolper''s survey of Neo-Elamite material covers the period in which Humban re-emerges as the dominant theophoric element in Elamite royal names (Humban-Haltash, Humban-Numena, Humban-Undasha) before the Achaemenid conquest. Cited for historical context and epigraphic evidence for all four entities.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_ELAM_CLASSICAL',
 'Elamite',
 'Kingdom of Elam',
 -2200, -539,
 'The period of the Kingdom of Elam (Elamite: haltamti; Sumerian: NIM.MA; Akkadian: Elam) from the Old Elamite period through the Neo-Elamite period, ending with the Achaemenid Persian conquest of Susa in 539 BCE. Elam was the dominant non-Mesopotamian civilisation of the ancient Near East for nearly two millennia, centered on Susa (modern Shush, Khuzestan, SW Iran) in the lowlands and Anshan (near Shiraz, Fars, SW Iran) in the highlands. The three principal phases: Old Elamite (c. 2200–1600 BCE), during which Elamite civilization interacted intensively with Ur III Mesopotamia and developed its cuneiform-based recording tradition; Middle Elamite (c. 1600–1100 BCE), the period of Elamite imperial expansion, including the sacking of Babylon (1155 BCE, when Shutruk-Nahhunte captured the stele of Hammurabi and the stele of Naram-Sin, now in the Louvre); and Neo-Elamite (c. 1100–539 BCE), the period of conflict with the Neo-Assyrian Empire culminating in Assurbanipal''s destruction of Susa (647 BCE) and the subsequent Achaemenid incorporation of Elamite territory. The Elamite language (a language isolate — not related to Semitic or Indo-European families) was used in administration through the Achaemenid period; Elamite religious traditions directly influenced the emerging Achaemenid Iranian religious culture, making Elam the missing link between the Mesopotamian and Zoroastrian/Iranian layers in the DeityDB dataset. Potts (1999) and Carter & Stolper (1984) are the standard references.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_ELAM_INSHUSHINAK',
 'Inshushinak',
 'Elamite',
 'city god of Susa / lord of the dead',
 'Underworld Deity',
 'city sovereignty; judgment of the dead; royal patronage; underworld; divine justice; Susa',
 'A',
 'Inshushinak (Sumerian: en-šušin-ak, "Lord of Susa"; Elamite: Inšušinak) is the principal deity of Susa and the most extensively attested divine figure in the Elamite inscriptional record, present from the Old Elamite period (c. 2200 BCE) through the Neo-Elamite period and the Achaemenid continuation. He combined the roles of city tutelary deity, supreme judge of the dead, and royal patron — the functions that made him the theological center of Susa''s civic and religious identity across two millennia. As lord of the dead he presided over the fate of souls after death, a judicial function that invites comparison with Mesopotamian Utu/Shamash (both are divine judges operating at the threshold of death). The Elamite kings consistently invoke Inshushinak in royal inscriptions alongside Napirisha and Kiririsha; dedications to him fill the votive deposits excavated from the acropolis of Susa by Jacques de Morgan and subsequent excavators (the Susa deposits are among the richest ancient Near Eastern archaeological hoards, now largely in the Louvre). The Chogha Zanbil (Dur-Untash) ziggurat complex, built by Untash-Napirisha c. 1250 BCE, was dedicated jointly to Inshushinak and Napirisha — the combination of the Susian tutelary deity with the new "great god" of the Middle Elamite dynasty expressed a deliberate theological synthesis of the lowland and highland Elamite traditions. His iconography includes the horned crown (the standard ancient Near Eastern marker of divinity) and the snake (a consistent symbol of Inshushinak that also appears on the famous "Sit-shamshi" bronze ritual scene from Susa). Potts (1999) pp. 261-280; Carter & Stolper (1984) pp. 38-45.'),
('ENT_ELAM_KIRIRISHA',
 'Kiririsha',
 'Elamite',
 'great goddess / mother goddess',
 'Love Deity',
 'divine motherhood; fertility; sovereignty; cosmic female power; Liyan; protection',
 'A',
 'Kiririsha ("the Great Goddess," Elamite: kiri = goddess, riša = great) is the principal goddess of the Elamite pantheon, worshipped especially at Liyan (ancient name of the Bushehr region on the Persian Gulf coast) but also centrally at Susa and at the Chogha Zanbil (Dur-Untash) complex where she has her own temple. Her epithet — literally "the great goddess" — identifies her as the paramount female divine power of Elamite religion, a title analogous to Inanna/Ishtar''s "Queen of Heaven" in Mesopotamian theology. She is a mother goddess figure whose domain encompasses divine fertility, cosmic female sovereignty, and the protection of the Elamite state and dynasty. The Middle Elamite kings pair her consistently with Napirisha in their divine invocations: the standard formula "Inshushinak, Napirisha, and Kiririsha" appears in major royal inscriptions and dedicatory texts from the Untash-Napirisha dynasty (c. 1340-1300 BCE). In earlier periods she is sometimes paired with Humban as the female counterpart of the chief male deity. A distinctive Elamite theological trait is her prominence as a named, individually-worshipped goddess rather than merely an unnamed consort — she holds divine authority in her own right. The Liyan temple remains excavated at Haft Tappeh preserve some of the best evidence for her independent cult. Potts (1999) pp. 280-290; Carter & Stolper (1984) pp. 40-48.'),
('ENT_ELAM_NAPIRISHA',
 'Napirisha',
 'Elamite',
 'great god / water deity',
 'High Deity',
 'divine supremacy; life-giving water; healing; Anshan; cosmic order; Middle Elamite kingship',
 'A',
 'Napirisha ("the Great God," Elamite: nap = god, irisha/rīša = great) is the supreme divine figure of the Middle Elamite period (c. 1600-1100 BCE), rising to theological prominence under the Untash-Napirisha dynasty whose very name means "devoted to Napirisha." He is the patron deity of the highland region of Anshan (modern Fars province, SW Iran) and represents the highland Elamite theological tradition in contrast to the lowland Susian tradition centered on Inshushinak. His most tangible monument is the ziggurat city of Dur-Untash (modern Chogha Zanbil, c. 1250 BCE) — the best-preserved ancient ziggurat, a UNESCO World Heritage Site — built by Untash-Napirisha to honor both Napirisha and Inshushinak in a deliberate unification of highland and lowland Elamite divine traditions. His divine domains are centered on life-giving water and healing: he is associated with the waters that sustain life, paralleling the role of Enki/Ea in Mesopotamian theology (wisdom-through-water, the life-principle carried by water). The most famous representation of Napirisha is a bronze statue (c. 1340 BCE, excavated at Susa, now in the Louvre, inv. Sb 2731) — a seated figure in royal garb with hands clasped in the posture of divine service, one of the finest examples of Elamite metalwork. He was paired with Kiririsha as his divine consort in the Chogha Zanbil theology. Potts (1999) pp. 234-260; Carter & Stolper (1984) pp. 44-55.'),
('ENT_ELAM_HUMBAN',
 'Humban',
 'Elamite',
 'chief god / sky sovereign',
 'High Deity',
 'divine supremacy; sky; cosmic order; royal victory; oath; Neo-Elamite kingship',
 'A',
 'Humban (also Ḫumban, Ḫumpa; rendered as Umman or Khumban in Assyrian texts) is the chief male deity of the Old Elamite and Neo-Elamite periods and the theophoric element most prevalent in Elamite royal names throughout the entire historical record. Royal names bearing Humban''s name include: Humban-Haltash I, II, III (Neo-Elamite kings, 8th–7th c. BCE), Humban-Numena, Humban-Undasha, and Atta-Humban — a concentration of royal theophoric names paralleled in the Mesopotamian tradition only by Enlil- and Ashur-bearing royal names, indicating that Humban was understood as the supreme divine patron of Elamite kingship. He appears to occupy the role of sky sovereign and divine guarantor of royal power — the function that in neighboring Mesopotamia belonged to Anu (sky), Enlil (divine authority), and Ashur (national patron). His relationship to Napirisha is a complex scholarly question: they appear to be temporally distinct expressions of the same theological need for a supreme male divine figure (Humban dominant in Old and Neo-Elamite periods; Napirisha dominant in the Middle Elamite Untash-Napirisha dynasty), possibly reflecting regional (Anshan vs. Susa) and dynastic emphases. The Neo-Assyrian sources — particularly Assurbanipal''s annals recording the sacking of Susa in 647 BCE — describe Humban''s statues and cult objects being carried off to Nineveh as war spoils, documenting his central importance to Neo-Elamite state religion. Potts (1999) pp. 261-265; Carter & Stolper (1984) pp. 56-70.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_ELAM_INSHUSHINAK', 'SRC_POTTS_ELAM', 'Primary epigraphic (Elamite cuneiform) / secondary scholarly',
 'Potts (1999) pp. 261-280: Inshushinak''s role across all Elamite periods; the Susa votive deposit corpus; the Chogha Zanbil joint dedication; the "Sit-shamshi" bronze scene; his judicial (lord of the dead) function; royal inscription invocations.'),
('ENT_ELAM_INSHUSHINAK', 'SRC_CARTER_STOLPER_ELAM', 'Secondary scholarly',
 'Carter & Stolper (1984) pp. 38-45: Inshushinak in Old and Middle Elamite royal inscriptions; his role as city god and judge in the Elamite state religion; the Susian epigraphic corpus.'),
('ENT_ELAM_KIRIRISHA', 'SRC_POTTS_ELAM', 'Primary epigraphic / secondary scholarly',
 'Potts (1999) pp. 280-290: Kiririsha''s cult at Liyan (Bushehr); Chogha Zanbil temple; Middle Elamite divine triad invocations; her role as "the Great Goddess" and divine feminine sovereign.'),
('ENT_ELAM_KIRIRISHA', 'SRC_CARTER_STOLPER_ELAM', 'Secondary scholarly',
 'Carter & Stolper (1984) pp. 40-48: Kiririsha in Elamite royal inscriptions; her pairing with Napirisha (Middle Elamite) and Humban (Old Elamite); the Haft Tappeh sanctuary evidence.'),
('ENT_ELAM_NAPIRISHA', 'SRC_POTTS_ELAM', 'Primary archaeological / epigraphic / secondary scholarly',
 'Potts (1999) pp. 234-260: Napirisha as the patron deity of Dur-Untash/Chogha Zanbil; the Louvre bronze statue (Sb 2731, c. 1340 BCE); his water/healing domain; the Untash-Napirisha dynasty''s theological program; relationship to Inshushinak.'),
('ENT_ELAM_NAPIRISHA', 'SRC_CARTER_STOLPER_ELAM', 'Secondary scholarly',
 'Carter & Stolper (1984) pp. 44-55: Napirisha in Middle Elamite royal inscriptions; the Untash-Napirisha religious synthesis of Anshan and Susa traditions; Chogha Zanbil as the primary monument.'),
('ENT_ELAM_HUMBAN', 'SRC_POTTS_ELAM', 'Primary epigraphic (cuneiform) / secondary scholarly',
 'Potts (1999) pp. 261-265: Humban in Old and Neo-Elamite royal inscriptions; theophoric royal names; his function as chief deity and sky sovereign; Assurbanipal''s annals on the Susa sacking and the deportation of Humban''s cult objects.'),
('ENT_ELAM_HUMBAN', 'SRC_CARTER_STOLPER_ELAM', 'Secondary scholarly',
 'Carter & Stolper (1984) pp. 56-70: Humban in Neo-Elamite royal nomenclature — Humban-Haltash, Humban-Numena, Humban-Undasha; his relationship to Napirisha; the Assyrian evidence for his cult.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_ELAM_INSHUSHINAK', 'PER_ELAM_CLASSICAL', 'high',
 'Inshushinak is attested from the Old Elamite period (earliest inscriptions, c. 2200 BCE) through the Neo-Elamite period; his cult at Susa continued into the Achaemenid period.',
 'SRC_POTTS_ELAM', 'reviewed'),
('ENT_ELAM_KIRIRISHA',   'PER_ELAM_CLASSICAL', 'high',
 'Kiririsha is attested from the Old Elamite period through the Middle Elamite period at Liyan and Susa, and appears in Neo-Elamite inscriptions.',
 'SRC_POTTS_ELAM', 'reviewed'),
('ENT_ELAM_NAPIRISHA',   'PER_ELAM_CLASSICAL', 'high',
 'Napirisha is the dominant divine figure of the Middle Elamite period (c. 1600–1100 BCE); his principal monument Chogha Zanbil dates to c. 1250 BCE. His cult persisted into the Neo-Elamite period.',
 'SRC_POTTS_ELAM', 'reviewed'),
('ENT_ELAM_HUMBAN',      'PER_ELAM_CLASSICAL', 'high',
 'Humban appears in Old Elamite inscriptions and dominates the Neo-Elamite royal nomenclature (8th–7th c. BCE); Assurbanipal''s account of the Susa sacking (647 BCE) is a primary Assyrian source.',
 'SRC_CARTER_STOLPER_ELAM', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Inshushinak
('ENT_ELAM_INSHUSHINAK', 'patron_of', 'ENT_DEAD',
 'high',
 'Inshushinak is explicitly "lord of the dead" in Elamite sources — his judicial function encompasses the fate of souls after death, a role consistent with his position as the supreme city deity of Susa (a major funerary cult center) and with the underworld associations of ancient Near Eastern city gods who control the boundary between living and dead. The "Sit-shamshi" bronze ritual scene from Susa (depicting funerary rites) is associated with his cult. Potts (1999) p. 273.',
 'SRC_POTTS_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
('ENT_ELAM_INSHUSHINAK', 'aligned_with', 'ENT_MES_UTU_SHAMASH',
 'medium',
 'Inshushinak and Utu/Shamash are structurally parallel as judicial deities who oversee divine justice and adjudicate the fates of the dead. Both operate at the threshold between life and death as the divine judge of last resort; both are associated with light and truth as the foundations of judgment. The parallel was recognized in antiquity through the close cultural contact between Susa and Mesopotamia: Elamite scribes used Akkadian cuneiform and were well aware of Shamash''s judicial role. Confidence medium: no ancient source explicitly equates them, but the structural and functional alignment is strong and frequently noted in modern scholarship. Potts (1999) p. 276.',
 'SRC_POTTS_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
-- Kiririsha
('ENT_ELAM_KIRIRISHA', 'patron_of', 'ENT_FERTILITY',
 'high',
 'Kiririsha is the Elamite great mother goddess whose primary domain encompasses cosmic fertility, divine motherhood, and the renewal of life. Her name ("the Great Goddess") and her Liyan cult center — associated with the Persian Gulf coast''s agricultural and maritime abundance — place her in the great mother goddess tradition. The Middle Elamite royal inscriptions invoke her alongside Inshushinak and Napirisha for the protection and fertility of the Elamite state. Potts (1999) pp. 282-286.',
 'SRC_POTTS_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
('ENT_ELAM_KIRIRISHA', 'aligned_with', 'ENT_MES_INANNA_ISHTAR',
 'medium',
 'Kiririsha and Inanna/Ishtar are parallel as the dominant great goddesses of neighboring ancient Near Eastern civilizations — both are "the great goddess" of their respective traditions, both combine fertility, sovereignty, and protection functions, and both absorbed the titles and iconographic features of earlier mother goddess traditions. During periods of strong Mesopotamian cultural influence on Elam (especially the Old Elamite period of Ur III contact), Kiririsha assimilated some Inanna/Ninhursag characteristics. Confidence medium: they are parallel rather than equated, and their theological programs differ significantly in detail. Potts (1999) p. 288; Carter & Stolper (1984) p. 42.',
 'SRC_POTTS_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
('ENT_ELAM_KIRIRISHA', 'aligned_with', 'ENT_ZOR_ANAHITA',
 'low',
 'Kiririsha and Anahita are parallel as the principal goddess figures of the Iranian cultural sphere in successive historical periods — Kiririsha as the Elamite great goddess (c. 2200–539 BCE), Anahita as the Zoroastrian/Iranian water-and-fertility goddess (attested from the Achaemenid period). Both are associated with water, fertility, and divine protection of the Iranian world. Confidence low: the parallel is typological across a large chronological gap (the Achaemenid synthesis of Iranian and Elamite religious traditions is attested but the specific Kiririsha → Anahita transmission is scholarly inference rather than inscriptional fact. Potts (1999) p. 290.',
 'SRC_POTTS_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
('ENT_ELAM_KIRIRISHA', 'spouse_of', 'ENT_ELAM_NAPIRISHA',
 'high',
 'The Middle Elamite divine triad of Inshushinak, Napirisha, and Kiririsha consistently presents Kiririsha as Napirisha''s divine consort. The Chogha Zanbil (Dur-Untash) complex, dedicated c. 1250 BCE, includes a temple to Kiririsha alongside the principal Inshushinak-Napirisha sanctuary — the paired placement reflects the divine spousal relationship. Royal inscriptions of the Untash-Napirisha dynasty invoke Napirisha and Kiririsha together as a divine pair. Carter & Stolper (1984) p. 47; Potts (1999) p. 252.',
 'SRC_CARTER_STOLPER_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
-- Napirisha
('ENT_ELAM_NAPIRISHA', 'patron_of', 'ENT_HEALING',
 'medium',
 'Napirisha''s association with life-giving water and the Anshan highland springs situates him in the healing and renewal domain. His temples were associated with sacred water sources; his iconography includes the life-water motif; and his name ("the Great God") encompasses the generative divine power from which healing flows. Confidence medium: the healing attribution is inferential from the water-and-life domain rather than directly inscribed in the surviving texts, though the functional parallel with water-healing deities (cf. Enki/Ea) is strong. Potts (1999) p. 244.',
 'SRC_POTTS_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
('ENT_ELAM_NAPIRISHA', 'aligned_with', 'ENT_MES_ENKI_EA',
 'medium',
 'Napirisha and Enki/Ea share the domain of life-giving water as a divine principle — both are associated with the fresh water that sustains life (the Mesopotamian apsû / Napirisha''s highland springs), both embody divine wisdom manifest through the water medium, and both serve as the principal "great god" of their respective traditions alongside the supreme sky deity. The geographical proximity of Elam and Mesopotamia and the documented Elamite borrowing of Akkadian scribal culture means these deities'' parallel functions would have been apparent to ancient practitioners. Confidence medium: the alignment is structural and domain-based; no ancient source explicitly equates them. Carter & Stolper (1984) p. 50.',
 'SRC_CARTER_STOLPER_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed'),
-- Humban
('ENT_ELAM_HUMBAN', 'aligned_with', 'ENT_MES_ENLIL',
 'medium',
 'Humban and Enlil are structurally parallel as the chief divine authorities of their respective civilizations in the ancient Near East — both serve as the supreme male deity whose approval legitimates royal power and whose invocation in royal inscriptions signals the highest divine sanction. As neighboring civilizations (Elam and Mesopotamia were in continuous political and cultural contact for two millennia), their chief deities occupied structurally identical positions in their respective pantheons. The Assyrian texts about Elamite kings routinely mention Humban alongside Ashur in diplomatic contexts, reflecting awareness of Humban as the Elamite equivalent of the Assyrian divine patron. Confidence medium: the parallelism is structural; the two deities were not explicitly equated by ancient commentators. Potts (1999) p. 263.',
 'SRC_POTTS_ELAM', 'PER_ELAM_CLASSICAL', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities FROM entities
WHERE tradition = 'Elamite' GROUP BY tradition;

SELECT * FROM v_release_metrics;

COMMIT;
