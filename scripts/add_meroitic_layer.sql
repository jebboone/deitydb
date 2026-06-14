-- scripts/add_meroitic_layer.sql
-- Adds the Meroitic/Nubian pantheon: five deities of the Kingdom of Kush
-- (Napatan–Meroitic period, c. 750 BCE – 350 CE), centered on the middle Nile
-- region (modern Sudan). Meroitic religion combined distinctly indigenous
-- Sudanese deities with selective adoption and transformation of Egyptian cult.
--
-- Primary archaeological evidence: temples at Musawwarat es-Sufra, Naga,
-- and Kalabsha; relief programs; Greek, Demotic, and Meroitic inscriptions.
-- Secondary: Török (1997), Žabkar (1975).

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_TÖRÖK_MEROE',
 'László Török, The Kingdom of Kush: Handbook of the Napatan-Meroitic Civilization (Handbook of Oriental Studies, Section 1: The Near and Middle East, Vol. 31; E.J. Brill, Leiden / New York / Cologne, 1997)',
 'secondary scholarly',
 'The standard comprehensive reference on the Kingdom of Kush in the Napatan (c. 750–270 BCE) and Meroitic (c. 270 BCE – 350 CE) periods. Part IV (Chapters 16-18) surveys Meroitic religion, the pantheon, cult centers, and the relationship between indigenous Meroitic deities and Egyptian religious borrowings. Török discusses Apedemak as the most distinctly Meroitic deity — he has no Egyptian counterpart and appears first in the temple programs of Musawwarat es-Sufra (c. 270 BCE); Arensnuphis and his identification with Anhur/Onuris at Philae; Mandulis as the solar deity of Lower Nubia attested at Kalabsha (ancient Talmis) in dozens of Greek and Demotic dedications; Sebiumeker as the creator deity of Musawwarat es-Sufra; and Amesemi as Apedemak''s consort. Primary scholarly citation for all five entities in this layer.'),
('SRC_ZABKAR_APEDEMAK',
 'Louis V. Žabkar, Apedemak, Lion God of Meroe: A Study in Egyptian-Meroitic Syncretism (Aris & Phillips, Warminster, 1975)',
 'secondary scholarly',
 'The dedicated monograph on Apedemak, the pre-eminent indigenous Meroitic deity. Žabkar analyzes all attestations of Apedemak across the relief programs of Musawwarat es-Sufra, Naga (including the famous Lion Temple of Apedemak built by Natakamani and Amanitore, c. 1–20 CE), and Meroe itself. He demonstrates that Apedemak is not an Egyptian import but an indigenous Nubian/Meroitic lion deity who developed his iconographic program partly by borrowing Egyptian artistic conventions while remaining theologically distinct — there is no Egyptian lion war god precisely corresponding to him. Covers Apedemak''s role in the Meroitic royal ideology as the divine guarantor of military victory, his lion-headed human iconography (and variant multi-headed, multi-armed forms at Naga), and his relationship with the queen and king in Meroitic royal theology. Cited primarily for ENT_MER_APEDEMAK and secondarily for Amesemi as his consort.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_MER_NAPATAN_MEROITIC',
 'Meroitic',
 'Napatan–Meroitic Kingdom of Kush',
 -750, 350,
 'The period of the Kingdom of Kush during which the Meroitic religious tradition reached its fullest development, spanning the Napatan phase (c. 750–270 BCE, centered on Napata and the Nile Fourth Cataract region) through the Meroitic phase (c. 270 BCE – 350 CE, centered on Meroe between the Fifth and Sixth Cataracts, in modern Sudan). The Napatan rulers conquered Egypt in the 25th Dynasty (747–656 BCE) and maintained Egyptian religious forms before returning south and developing a more distinctly Meroitic cultic tradition. The Meroitic phase sees the construction of the great indigenous temples: the Lion Temple at Musawwarat es-Sufra (principal cult center of Apedemak, c. 270 BCE), the Lion Temple at Naga (Natakamani and Amanitore, c. 1–20 CE), and the temple of Mandulis at Kalabsha (rebuilt under Augustus, c. 20 BCE). The Meroitic script (both hieroglyphic and cursive forms) was developed in this period; Meroitic remains substantially undeciphered as a language, so the religious evidence depends heavily on the relief programs and the Greek/Demotic dedications found at cult centers. The kingdom''s end is conventionally placed c. 350 CE, though regional successor states (the Noba kingdoms) carried elements of the tradition forward. Török (1997) is the standard handbook; Žabkar (1975) covers Apedemak in depth.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_MER_APEDEMAK',
 'Apedemak',
 'Meroitic',
 'lion war god / royal deity',
 'War Deity',
 'war; military victory; royal power; lion; protection',
 'A',
 'Apedemak is the most distinctly indigenous deity of the Meroitic pantheon — unlike most other major Meroitic deities, he has no direct Egyptian counterpart and was not borrowed or syncretized from the Egyptian tradition. He is a lion-headed war deity who embodies military victory and royal power; his epithet is "Lord of Royal Power" (in Meroitic rendering, as reconstructed from bilingual cult contexts). His principal cult center was the Great Enclosure at Musawwarat es-Sufra (ancient Apedemak, c. 270 BCE — one of the largest ancient monument complexes in sub-Saharan Africa), and his Lion Temple at Naga (c. 1–20 CE, built by King Natakamani and Queen Amanitore) is the best-preserved Meroitic temple. He is depicted in three iconographic modes: (1) fully lion-headed with human body, holding a scepter and bow, enemies crushed underfoot; (2) a three-headed, four-armed form at Naga, holding different attributes in each arm — a unique Meroitic iconographic innovation; (3) a serpent-bodied form at Musawwarat. The Meroitic kings are consistently depicted in the relief programs receiving victory from Apedemak — he is the theological guarantor of royal military success. Žabkar (1975) is the definitive study; Török (1997) pp. 461-475 surveys his distribution.'),
('ENT_MER_ARENSNUPHIS',
 'Arensnuphis',
 'Meroitic',
 'Meroitic deity / syncretized with Anhur-Shu',
 'Warrior Deity',
 'companionship; sky; protection; warrior',
 'A',
 'Arensnuphis (also Arsnuphis, Ari-hes-nefer — "Good Companion") is a Meroitic deity extensively attested at Philae, where he had his own chapel (the Kiosk of Qertassi, and chapels on Philae island proper), and at Musawwarat es-Sufra. His name in Meroitic transliteration suggests "the beautiful (good) companion." At Philae, Arensnuphis was closely associated with the Isis cult (Philae being the principal Isis sanctuary in the Greco-Roman world) and was explicitly syncretized with Anhur/Onuris, the Egyptian war and sky deity. The syncretism is well-attested in Greek dedications from Philae: Arensnuphis Onuphris (= Onuris), making him both Meroitic and Egyptian simultaneously. He is also linked with Shu, the Egyptian air deity, through the Onuris-Shu theological complex. His iconography at Philae shows him in Egyptian style — the double-plumed crown and carrying a spear. The deity clearly represents an early phase of the Meroitic-Egyptian religious interface at the border zone of the First/Second Cataract. Török (1997) pp. 475-478.'),
('ENT_MER_MANDULIS',
 'Mandulis',
 'Meroitic',
 'solar deity / lord of the Abaton',
 'Sun Deity',
 'sun; solar light; divine epiphany; healing; protection; Lower Nubia',
 'A',
 'Mandulis (also Marul, in Meroitic; Mandoulis or Malul in Greek inscriptions) is the solar deity of Lower Nubia (the region between the First and Second Cataracts, the Dodekaschoinos), whose principal cult center was the temple at Kalabsha (ancient Talmis, modern Kalabsha near Aswan). The Kalabsha temple was rebuilt under the Roman Emperor Augustus (c. 20 BCE) and is the largest free-standing ancient Egyptian-style temple in Nubia — now relocated to New Kalabsha following the construction of the High Dam at Aswan. Mandulis is one of the most extensively documented Meroitic deities through Greek inscriptions: approximately 30 Greek votive inscriptions from Kalabsha survive, including the famous Hymn of Isidoros (c. 100 BCE–100 CE), a lengthy Greek hexameter hymn to "Mandulis, Lord of the Abaton," describing his solar epiphany and healing power. He is described as seeing the whole world with his solar eye, driving away darkness, and revealing divine truth to the initiate. Like Egyptian Ra and Horus, he is depicted as a falcon-headed figure with a solar disk; he was also assimilated to Horus in the Nubian syncretic tradition. Perfectly attested as a solar deity paralleling both Ra and Horus in function. Török (1997) pp. 478-482.'),
('ENT_MER_SEBIUMEKER',
 'Sebiumeker',
 'Meroitic',
 'creator deity / lord of Musawwarat',
 'Creator Deity',
 'creation; procreation; generation; fertility; cosmic order',
 'B',
 'Sebiumeker is an indigenous Meroitic creator deity attested primarily at Musawwarat es-Sufra, where he is depicted in relief programs alongside Apedemak. His name in Meroitic is rendered as "Sebiumeker" or "Sebi-u-meker"; the meaning is uncertain but may involve concepts of creation or generation. He is depicted in human form — unlike the lion-headed Apedemak — and his role as a creator/progenitor deity is inferred from the relief contexts and his pairing with Apedemak in the Musawwarat program. He represents the distinctly Meroitic stratum of divine imagination that developed independently of Egyptian theological influence: a creator deity with no Egyptian equivalent whose cult was centered at the major indigenous Meroitic sanctuary. Confidence B: attested in relief programs but the surviving Meroitic textual evidence is limited by the still-undeciphered state of the Meroitic language. Török (1997) pp. 482-484.'),
('ENT_MER_AMESEMI',
 'Amesemi',
 'Meroitic',
 'Meroitic goddess / consort of Apedemak',
 'Love Deity',
 'divine queenship; royal protection; female divine power',
 'B',
 'Amesemi is a Meroitic goddess who appears in temple programs as the consort of Apedemak. She is depicted wearing a hawk-crown (a solar hawk perched on a basket on her head), which gives her an iconographic resemblance to Isis, the Egyptian goddess also associated with the hawk and the royal throne. Her role in the relief programs at Naga is specifically linked to Meroitic royal theology: she stands alongside Apedemak in scenes of royal investiture, suggesting her domain involves divine queenship and the protection of Meroitic royalty through the female divine power. As Apedemak''s consort, she occupies a structural position analogous to Isis as consort of Osiris in Egyptian theology — but the details of her mythological role are not recoverable from the surviving evidence, since Meroitic remains largely undeciphered. Confidence B: clearly attested in relief contexts but her functions and mythology are imperfectly understood. Žabkar (1975) pp. 40-45; Török (1997) p. 484.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_MER_APEDEMAK', 'SRC_ZABKAR_APEDEMAK', 'Primary archaeological / epigraphic',
 'Žabkar (1975): complete corpus analysis of Apedemak attestations — Musawwarat es-Sufra Great Enclosure relief programs (c. 270 BCE), Lion Temple at Naga (c. 1–20 CE, Natakamani/Amanitore), Meroe, and secondary sites; iconographic analysis of lion-headed, multi-headed, and serpent-bodied forms; royal ideology of military victory from Apedemak.'),
('ENT_MER_APEDEMAK', 'SRC_TÖRÖK_MEROE', 'Secondary scholarly',
 'Török (1997) pp. 461-475: Apedemak in the Meroitic pantheon; distribution across cult centers; relationship to Egyptian artistic conventions and theological independence; role in royal military ideology.'),
('ENT_MER_ARENSNUPHIS', 'SRC_TÖRÖK_MEROE', 'Primary epigraphic / secondary scholarly',
 'Török (1997) pp. 475-478: Arensnuphis at Philae; Greek dedications identifying Arensnuphis with Anhur/Onuris ("Arensnuphis Onuphris"); cult at Musawwarat es-Sufra; iconography; relation to Shu through the Onuris-Shu complex.'),
('ENT_MER_MANDULIS', 'SRC_TÖRÖK_MEROE', 'Primary epigraphic (Greek) / secondary scholarly',
 'Török (1997) pp. 478-482: Mandulis at Kalabsha (Talmis); Greek votive inscription corpus (~30 texts); the Isidoros Hymn (c. 100 BCE–100 CE) as the richest primary text; solar deity function; syncretism with Ra and Horus; falcon-headed iconography; Augustan rebuilding of the Kalabsha temple.'),
('ENT_MER_SEBIUMEKER', 'SRC_TÖRÖK_MEROE', 'Primary archaeological (relief) / secondary scholarly',
 'Török (1997) pp. 482-484: Sebiumeker in the Musawwarat es-Sufra relief program; creator deity function; human iconographic form; Meroitic theological independence from Egyptian models.'),
('ENT_MER_AMESEMI', 'SRC_ZABKAR_APEDEMAK', 'Primary archaeological (relief) / secondary scholarly',
 'Žabkar (1975) pp. 40-45: Amesemi as Apedemak''s consort in the Naga temple relief program; hawk-crown iconography; role in royal investiture scenes; comparison with Isis iconography.'),
('ENT_MER_AMESEMI', 'SRC_TÖRÖK_MEROE', 'Secondary scholarly',
 'Török (1997) p. 484: Amesemi in the Meroitic pantheon; consort role and distribution of attestations.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_MER_APEDEMAK',   'PER_MER_NAPATAN_MEROITIC', 'high',
 'Apedemak''s earliest temple evidence dates to Musawwarat es-Sufra c. 270 BCE; his cult persists through the Naga temple c. 1–20 CE and beyond. Attested across the entire Meroitic period.',
 'SRC_ZABKAR_APEDEMAK', 'reviewed'),
('ENT_MER_ARENSNUPHIS', 'PER_MER_NAPATAN_MEROITIC', 'high',
 'Attested at Philae in Greek inscriptions from the Ptolemaic period onward through Roman times; Musawwarat attestations push the cult back further.',
 'SRC_TÖRÖK_MEROE', 'reviewed'),
('ENT_MER_MANDULIS',   'PER_MER_NAPATAN_MEROITIC', 'high',
 'The Kalabsha temple, rebuilt under Augustus c. 20 BCE, is the principal cult site; the Greek inscription corpus spans c. 100 BCE–300 CE. Present throughout the Meroitic period.',
 'SRC_TÖRÖK_MEROE', 'reviewed'),
('ENT_MER_SEBIUMEKER', 'PER_MER_NAPATAN_MEROITIC', 'high',
 'Present in the Musawwarat es-Sufra relief programs, which were established c. 270 BCE and expanded through the Meroitic period.',
 'SRC_TÖRÖK_MEROE', 'reviewed'),
('ENT_MER_AMESEMI',    'PER_MER_NAPATAN_MEROITIC', 'high',
 'Attested in the Naga temple relief program (c. 1–20 CE) and other Meroitic royal cult contexts throughout the period.',
 'SRC_ZABKAR_APEDEMAK', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Apedemak
('ENT_MER_APEDEMAK', 'patron_of', 'ENT_WAR',
 'high',
 'Apedemak is the divine guarantor of military victory in Meroitic royal ideology. Every major battle relief shows the king receiving victory from Apedemak; his epithet "Lord of Royal Power" reflects the identity of his war-patron function with the divine sanction of kingship. This is his most extensively and unambiguously attested domain across the full corpus of Musawwarat and Naga reliefs. Žabkar (1975) pp. 15-30.',
 'SRC_ZABKAR_APEDEMAK', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
('ENT_MER_APEDEMAK', 'aligned_with', 'ENT_EGY_SEKHMET',
 'high',
 'Apedemak and Sekhmet are both lion-headed war deities whose core function is military violence and the destruction of enemies in divine service to royal power. Though Apedemak developed independently of Egyptian lion deity traditions (Žabkar demonstrates he is not borrowed from Sekhmet), the functional and iconographic parallel is striking: both are lions who guarantee military victory, both are associated with the pharaoh/king as divine warriors. The alignment is cross-traditional and structural rather than an ancient explicit equation. Žabkar (1975) pp. 35-40; Török (1997) p. 470.',
 'SRC_ZABKAR_APEDEMAK', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
('ENT_MER_APEDEMAK', 'aligned_with', 'ENT_EGY_HORUS',
 'medium',
 'Apedemak is sometimes depicted alongside Horus in Meroitic relief programs, and both are divine warriors associated with royal legitimacy and the destruction of enemies. At several Meroitic sites, Apedemak and Horus appear in parallel columns flanking a doorway — suggesting theological alignment in the Meroitic royal cult. Confidence medium: the alignment is iconographic and contextual rather than inscriptionally explicit. Török (1997) p. 472.',
 'SRC_TÖRÖK_MEROE', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
-- Arensnuphis
('ENT_MER_ARENSNUPHIS', 'syncretized_with', 'ENT_EGY_ANHUR',
 'high',
 'Arensnuphis is explicitly identified with Anhur (Onuris) in Greek dedications from Philae: he appears as "Arensnuphis Onuphris" in inscriptions, where Onuphris is the Greek rendering of Egyptian Onuris/Anhur. At Philae, the Chapel of Arensnuphis (early Ptolemaic period) was the principal cult location for both deities simultaneously. The Meroitic "Good Companion" and the Egyptian sky/war hunter deity were fused into a single cult figure. This is the most explicitly attested syncretism in the Meroitic layer, paralleling (but distinct from) the Egyptian identification of Onuris with Shu. Török (1997) pp. 475-478.',
 'SRC_TÖRÖK_MEROE', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
('ENT_MER_ARENSNUPHIS', 'aligned_with', 'ENT_EGY_SHU',
 'medium',
 'Through the Onuris-Shu theological identification in late Egyptian religion (Anhur/Onuris was regularly equated with Shu as the air deity who holds up the sky), Arensnuphis inherits a secondary alignment with Shu. The chain is: Arensnuphis syncretized_with Anhur, and Anhur identified_with Shu in Egyptian theology. Confidence medium: the alignment is indirect (mediated through the Onuris-Shu equation) rather than a direct ancient statement about Arensnuphis and Shu. Török (1997) p. 477.',
 'SRC_TÖRÖK_MEROE', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
-- Mandulis
('ENT_MER_MANDULIS', 'aligned_with', 'ENT_EGY_RA',
 'medium',
 'Mandulis is described in the Isidoros Hymn from Kalabsha as the solar deity who illuminates the world, drives away darkness, and oversees cosmic order — functions parallel to those of Egyptian Ra. His falcon-headed iconography with solar disk directly borrows the Ra-Harakhty iconographic convention. Confidence medium: the alignment is structural and iconographic; ancient sources associate Mandulis with solar power without explicitly equating him with Ra by name. Török (1997) p. 480.',
 'SRC_TÖRÖK_MEROE', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
('ENT_MER_MANDULIS', 'aligned_with', 'ENT_EGY_HORUS',
 'medium',
 'Mandulis is depicted as falcon-headed in his solar form, and the Isidoros Hymn describes his epiphany in terms closely parallel to Horus as the solar falcon. In some Meroitic temple contexts, Mandulis is depicted receiving offerings alongside Horus, suggesting a close theological alignment. The solar warrior deity parallel — Horus as the solar champion who defeats Set, Mandulis as the solar deity who drives away darkness — is structurally strong. Confidence medium: iconographic and contextual rather than explicit equation. Török (1997) p. 481.',
 'SRC_TÖRÖK_MEROE', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
-- Sebiumeker
('ENT_MER_SEBIUMEKER', 'patron_of', 'ENT_FERTILITY',
 'medium',
 'Sebiumeker''s role as a creator/progenitor deity at Musawwarat es-Sufra places him in the domain of fertility and generation. His human form (as opposed to Apedemak''s lion head) and his depiction in scenes of divine procreation suggest fertility patronage. Confidence medium: the creator deity attribution is inferred from iconographic context rather than directly inscribed in surviving texts. Török (1997) p. 483.',
 'SRC_TÖRÖK_MEROE', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
-- Amesemi
('ENT_MER_AMESEMI', 'spouse_of', 'ENT_MER_APEDEMAK',
 'high',
 'Amesemi is depicted in the Naga Lion Temple relief program standing alongside Apedemak in positions that clearly identify her as his divine consort. The pairing Apedemak-Amesemi in the Naga relief program is structurally analogous to the Osiris-Isis pairing in Egyptian royal theology: the warrior king-god and his queenly divine consort. Žabkar (1975) pp. 40-45.',
 'SRC_ZABKAR_APEDEMAK', 'PER_MER_NAPATAN_MEROITIC', 'reviewed'),
('ENT_MER_AMESEMI', 'aligned_with', 'ENT_EGY_ISIS',
 'medium',
 'Amesemi wears a hawk-crown — a solar hawk perched on a basket — which is iconographically similar to one of Isis''s crown forms. As the divine consort of a warrior deity who legitimates royal power, she occupies the same theological structural role as Isis in relation to Osiris-Horus in Egyptian royal theology. Confidence medium: the parallel is structural and iconographic; ancient sources do not explicitly equate Amesemi with Isis. Žabkar (1975) p. 42; Török (1997) p. 484.',
 'SRC_ZABKAR_APEDEMAK', 'PER_MER_NAPATAN_MEROITIC', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities WHERE tradition = 'Meroitic'
GROUP BY tradition;

SELECT * FROM v_release_metrics;

COMMIT;
