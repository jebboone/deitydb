-- scripts/add_urartian_layer.sql
-- Adds the Urartian divine triad plus Arubani: four deities of the Kingdom of
-- Urartu (c. 860–590 BCE), the Iron Age state centered on Lake Van in eastern
-- Anatolia that directly preceded the Armenian cultural sphere.
--
-- Primary evidence: Urartian cuneiform annals, dedicatory inscriptions, and
-- building records from Tushpa (Van), Musasir (Ardini), Erebuni, and Karmir Blur.
-- Secondary: Zimansky (1985), Piotrovsky (1969).

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_ZIMANSKY_URARTU',
 'Paul E. Zimansky, Ecology and Empire: The Structure of the Urartian State (Studies in Ancient Oriental Civilization 41; Oriental Institute of the University of Chicago, Chicago, 1985)',
 'secondary scholarly',
 'The standard English-language monograph on Urartian political structure, economy, and religion. Chapter 4 ("The Urartian Pantheon") surveys the divine hierarchy from the primary triad (Khaldi-Teisheba-Shivini) through the attested secondary deities, drawing on the corpus of royal annals and dedicatory inscriptions. Zimansky analyses the divine triad structure as reflecting a merger of indigenous Urartian tradition with the Hurrian theological inheritance, demonstrates Khaldi''s role as the war-deity who commands and legitimates the royal campaigns, documents Teisheba''s cognate relationship with Hurrian Teshub, and discusses the solar deity Shivini''s role as witness to oaths. Also covers the Musasir temple complex (principal Khaldi sanctuary, sacked by Sargon II of Assyria in 714 BCE) and its implications for Urartian-Assyrian religious relations. Primary scholarly citation for the Urartian layer.'),
('SRC_PIOTROVSKY_URARTU',
 'Boris B. Piotrovsky, The Ancient Civilization of Urartu: An Archaeological Adventure, trans. James Hogarth (Cowles / Cresset Press, New York / London, 1969)',
 'secondary scholarly',
 'Authoritative survey of Urartian civilization by the foremost Soviet scholar of Urartu, drawing on excavations at Karmir Blur (Teishebaini) and the wider corpus of Urartian archaeology. Covers the pantheon, cult centers, and religious iconography alongside the material culture. Chapters 5-6 treat the divine triad (Khaldi, Teisheba, Shivini), the Musasir temple, and the secondary deities including Arubani. Piotrovsky''s excavations at Karmir Blur (the Urartian fortress-city named "city of Teisheba") produced the richest archaeological evidence for Urartian cult practice, including bronze shields with divine figures, temple furnishings, and the famous Rusa II''s dedicatory inscriptions. Cited for all four Urartian entities in this layer.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_URA_IRON_AGE',
 'Urartian',
 'Kingdom of Urartu',
 -860, -590,
 'The period of the Kingdom of Urartu (also: Van Kingdom, Biainili), from the earliest inscribed king Sarduri I (c. 860 BCE) through the destruction of the kingdom by the Medes and Scythians c. 590 BCE. The Urartian state was the most powerful rival of the Neo-Assyrian Empire in the 9th–8th centuries BCE, controlling the highland region around Lake Van (eastern Anatolia / Armenia / northwestern Iran). The Urartian divine triad Khaldi-Teisheba-Shivini is attested across hundreds of cuneiform inscriptions in Urartian (a Hurro-Urartian language, related to Hurrian) from sites including Tushpa (capital, modern Van), Musasir (Ardini, principal Khaldi sanctuary), Erebuni (modern Yerevan), Argishtihinili, and Karmir Blur (Teishebaini, "city of Teisheba"). The kingdom''s collapse opened the region for the emergence of the Armenian cultural sphere — placing Urartu as the direct institutional predecessor of the Armenian tradition added in v1.8.0. Zimansky (1985) is the standard structural reference; Piotrovsky (1969) the best survey of the archaeological evidence.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_URA_KHALDI',
 'Khaldi',
 'Urartian',
 'supreme deity / war god',
 'High Deity',
 'war; national sovereignty; victory; sky; divine command; conquest',
 'A',
 'Supreme deity and national god of the Kingdom of Urartu (c. 860–590 BCE); the most extensively attested Urartian deity. Khaldi (also Ḫaldi) is a war deity who commands and legitimates the royal campaigns: every major Urartian inscription opens with the formula "By the greatness of Khaldi, Sarduri/Ispuini/Menua/Argishti/Rusa, king of Urartu, says..." His principal cult center was the great temple at Musasir (Ardini), whose destruction by Sargon II of Assyria in 714 BCE prompted an unusually detailed record in Sargon''s eighth campaign letter (an Assyrian primary source): the temple''s bronze shields, statues, and treasures are described item by item as war booty. Khaldi is depicted standing on a lion (the war-deity iconographic tradition of the ancient Near East). He heads the divine triad Khaldi-Teisheba-Shivini that structures the Urartian divine hierarchy — mirroring the Hurrian three-god tradition of Teshub-Shaushka-Shimegi and the Mesopotamian Anu-Enlil-Ea triad. His name is preserved in the Armenians'' ancient designation of the eastern Black Sea coastal region as "Khaldia." Zimansky (1985) pp. 56-80; Piotrovsky (1969) pp. 90-110.'),
('ENT_URA_TEISHEBA',
 'Teisheba',
 'Urartian',
 'storm god / thunder deity',
 'Thunder Deity',
 'thunder; storm; lightning; rain; war; sky; the bull',
 'A',
 'Storm and thunder deity of Urartu; the second member of the divine triad Khaldi-Teisheba-Shivini. Teisheba (Teišeba) is linguistically and theologically identical to Hurrian Teshub (the chief storm deity of Hurrian and Hittite/Hurrian religion), with the name corresponding by regular Hurrian-to-Urartian sound change (Hurrian Teš(u)b → Urartian Teišeba). He is called "lord of the sky" in Urartian inscriptions and is associated with thunder, storms, and military valor; his sacred animal is the bull, consistent with the Anatolian storm deity iconographic tradition across Tarhunna (Hittite), Teshub (Hurrian), Adad (Akkadian), and Baal (Canaanite). His principal temple was at the Urartian capital Tushpa (modern Van); the major fortress-city Teishebaini ("city of Teisheba," modern Karmir Blur near Yerevan) was named for him. Piotrovsky''s excavations at Karmir Blur yielded the richest Urartian cult material. Teisheba stands in a direct succession from the Hurrian storm deity tradition that entered Urartu through the Hurro-Urartian linguistic and cultural inheritance. Zimansky (1985) pp. 68-75; Piotrovsky (1969) pp. 95-100.'),
('ENT_URA_SHIVINI',
 'Shivini',
 'Urartian',
 'sun deity',
 'Sun Deity',
 'sun; light; solar order; oaths; divine witness; sky',
 'A',
 'Sun deity of Urartu; the third member of the divine triad Khaldi-Teisheba-Shivini. Shivini (also Šivini, Siwini) is depicted as a winged sun disk — the canonical ancient Near Eastern solar iconographic symbol shared with Assyrian Shamash, Egyptian Ra/Aten, and the Hittite sun deity. His role as the sun deity who witnesses and validates oaths is consistent with the ancient Near Eastern theology of the sun as the deity of justice and cosmic order (cf. Mesopotamian Shamash as lord of justice). The triad placement of Shivini as the sun deity in third position mirrors the Hittite/Hurrian triad structure where the sun deity (Shimegi) holds the third rank after the storm deity (Teshub) and the love/war goddess (Shaushka). The name Shivini may derive from a Proto-Anatolian root for sun, consistent with the depth of the solar deity cult in Anatolian religious history from the Hittite "Sun Goddess of Arinna" through the Urartian period. Zimansky (1985) pp. 70-72; Piotrovsky (1969) pp. 96-98.'),
('ENT_URA_ARUBANI',
 'Arubani',
 'Urartian',
 'goddess / consort of Khaldi',
 'Love Deity',
 'arts; beauty; love; fertility; female divine power',
 'B',
 'Goddess associated with Khaldi in Urartian inscriptions; likely his divine consort. Arubani appears in dedicatory texts as "the deity of Khaldi" and is associated with the feminine complement to his war and sovereignty functions — arts, beauty, and fertility. Some scholars identify her as the Urartian reception of the Hurrian Shaushka tradition: Shaushka (the Hurrian love/war goddess, related to Mesopotamian Ishtar/Inanna) is the consort of Teshub in Hurrian theology, and if Teisheba = Teshub and Khaldi occupies the Teshub-equivalent supreme position in Urartian theology, then Arubani as Khaldi''s consort would correspond to Shaushka. The identification is plausible but the surviving evidence is thinner than for the three primary triad members. Confidence B: she is attested in Urartian inscriptions but her functions and mythological role are not as fully documented as Khaldi, Teisheba, or Shivini. Piotrovsky (1969) pp. 100-102; Zimansky (1985) p. 72.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_URA_KHALDI', 'SRC_ZIMANSKY_URARTU', 'Secondary scholarly',
 'Zimansky (1985) pp. 56-80: Khaldi as supreme deity; the divine triad structure; Khaldi''s war-deity function in the royal campaign annals; the Musasir temple and its sacking by Sargon II in 714 BCE; Khaldi''s iconography (standing on a lion).'),
('ENT_URA_KHALDI', 'SRC_PIOTROVSKY_URARTU', 'Secondary scholarly',
 'Piotrovsky (1969) pp. 90-110: Khaldi in the Urartian cult; the bronze shields and divine figures from Karmir Blur; the annals formula "By the greatness of Khaldi"; the Musasir treasury as described in Sargon II''s campaign letter.'),
('ENT_URA_TEISHEBA', 'SRC_ZIMANSKY_URARTU', 'Secondary scholarly',
 'Zimansky (1985) pp. 68-75: Teisheba as the storm deity; cognate analysis with Hurrian Teshub; the bull iconography; the Tushpa temple; the divine triad placement.'),
('ENT_URA_TEISHEBA', 'SRC_PIOTROVSKY_URARTU', 'Secondary scholarly',
 'Piotrovsky (1969) pp. 95-100: Teisheba cult at Teishebaini (Karmir Blur); excavation finds; storm-deity function in Urartian inscriptions.'),
('ENT_URA_SHIVINI', 'SRC_ZIMANSKY_URARTU', 'Secondary scholarly',
 'Zimansky (1985) pp. 70-72: Shivini as the third triad member; solar deity function; winged sun disk iconography; oath-witness role.'),
('ENT_URA_SHIVINI', 'SRC_PIOTROVSKY_URARTU', 'Secondary scholarly',
 'Piotrovsky (1969) pp. 96-98: Shivini in the divine triad; solar iconography in Urartian art and inscriptions.'),
('ENT_URA_ARUBANI', 'SRC_PIOTROVSKY_URARTU', 'Secondary scholarly',
 'Piotrovsky (1969) pp. 100-102: Arubani as goddess associated with Khaldi; her dedications and role; the Shaushka comparison.'),
('ENT_URA_ARUBANI', 'SRC_ZIMANSKY_URARTU', 'Secondary scholarly',
 'Zimansky (1985) p. 72: Arubani in the Urartian deity list; her identification as Khaldi''s consort; secondary position relative to the divine triad.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_URA_KHALDI',   'PER_URA_IRON_AGE', 'high',
 'Khaldi is attested in hundreds of Urartian cuneiform inscriptions from Sarduri I (c. 860 BCE) through Rusa II (680s BCE); the Musasir temple sacking in 714 BCE is documented in Sargon II''s letter. Present throughout the kingdom''s history.',
 'SRC_ZIMANSKY_URARTU', 'reviewed'),
('ENT_URA_TEISHEBA', 'PER_URA_IRON_AGE', 'high',
 'Teisheba is attested throughout the Urartian inscriptional corpus; the city Teishebaini (Karmir Blur) is named for him and was inhabited until the kingdom''s destruction c. 590 BCE.',
 'SRC_PIOTROVSKY_URARTU', 'reviewed'),
('ENT_URA_SHIVINI',  'PER_URA_IRON_AGE', 'high',
 'Shivini appears in the divine triad formula throughout the Urartian inscriptional corpus, from the earliest kings through the kingdom''s end.',
 'SRC_ZIMANSKY_URARTU', 'reviewed'),
('ENT_URA_ARUBANI',  'PER_URA_IRON_AGE', 'high',
 'Arubani is attested in Urartian dedicatory inscriptions within the kingdom''s period; her presence in the Karmir Blur archaeological assemblage places her in the Iron Age Urartian cult.',
 'SRC_PIOTROVSKY_URARTU', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Khaldi
('ENT_URA_KHALDI', 'patron_of', 'ENT_WAR',
 'high',
 'Khaldi is explicitly the war deity in Urartian royal annals — every campaign is conducted "by the greatness of Khaldi" and every victory is dedicated to him. He commands military action and receives the first fruits of conquest. His war-patron function is the most extensively documented aspect of his cult across the entire Urartian inscriptional corpus. Zimansky (1985) pp. 56-80.',
 'SRC_ZIMANSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
('ENT_URA_KHALDI', 'aligned_with', 'ENT_MES_ASHUR',
 'medium',
 'Khaldi and Assyrian Ashur are structurally parallel: both are the supreme national war deities of rival Iron Age kingdoms (Urartu and Assyria) in direct competition for domination of the Near East. Both receive dedication of military spoils, command campaigns, and legitimate royal authority through divine choice. The rivalry is documented in Sargon II''s eighth campaign letter (714 BCE), where the sacking of Khaldi''s Musasir temple is framed as Ashur''s victory over Khaldi. Confidence medium: the alignment is structural and adversarial, not an ancient explicit equation.',
 'SRC_ZIMANSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
-- Teisheba
('ENT_URA_TEISHEBA', 'reception_of', 'ENT_HTT_TESHUB',
 'high',
 'Urartian Teisheba is the direct reception of Hurrian Teshub through the Hurro-Urartian linguistic inheritance. The names correspond by regular sound change (Hurrian Teš(u)b → Urartian Teišeba), both are storm-thunder deities in the second rank of their divine triads, both are associated with the bull, and both command military conflict alongside their supreme deity. The Hurro-Urartian language family relationship (the two languages are closely related) makes this the most linguistically secure deity-to-deity connection in the Urartian layer. Zimansky (1985) pp. 68-70.',
 'SRC_ZIMANSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
('ENT_URA_TEISHEBA', 'patron_of', 'ENT_STORM',
 'high',
 'Teisheba is explicitly the storm and thunder deity of Urartu, called "lord of the sky" in Urartian inscriptions. The city Teishebaini ("city of Teisheba," modern Karmir Blur) takes its name from his storm-deity function. He is the direct successor of Hurrian Teshub in the Urartian theological system. Piotrovsky (1969) pp. 95-100.',
 'SRC_PIOTROVSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
('ENT_URA_TEISHEBA', 'aligned_with', 'ENT_HTT_TARHUNNA',
 'high',
 'Teisheba and Hittite Tarhunna are parallel thunder deities of neighbouring Anatolian traditions — both derive from the same deep Anatolian storm-deity complex (Proto-Anatolian *tarḫu-, "to conquer/prevail"). They occupy the same second-rank position in their divine triads and share the bull iconography. The alignment reflects the broad Anatolian storm-deity tradition that also includes Ugaritic Baal, Mesopotamian Adad, and later Zeus. Zimansky (1985) p. 69.',
 'SRC_ZIMANSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
-- Shivini
('ENT_URA_SHIVINI', 'aligned_with', 'ENT_MES_UTU_SHAMASH',
 'medium',
 'Shivini and Mesopotamian Utu/Shamash are parallel sun deities of neighboring ancient Near Eastern traditions. Both are depicted with a solar disk, both serve as witnesses to oaths and upholders of justice, and both occupy a third-rank position in their divine triads (after the sky deity and storm deity). The alignment reflects the shared ancient Near Eastern theology of the sun as the divine witness of justice. Zimansky (1985) p. 70.',
 'SRC_ZIMANSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
('ENT_URA_SHIVINI', 'aligned_with', 'ENT_HTT_ARINNA',
 'medium',
 'Shivini and the Hittite Sun Goddess of Arinna are parallel Anatolian solar deities. Both are venerated as supreme solar powers in Anatolian Iron Age and Bronze Age religion; the winged sun disk iconography is shared across both traditions. Shivini occupies a structurally similar position in the Urartian triad to the Hittite solar deity in the Hittite pantheon. Zimansky (1985) p. 70; Piotrovsky (1969) p. 97.',
 'SRC_ZIMANSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
-- Arubani
('ENT_URA_ARUBANI', 'spouse_of', 'ENT_URA_KHALDI',
 'medium',
 'Arubani is designated "the deity of Khaldi" in Urartian inscriptions and is associated with him as his divine consort. The pairing mirrors the broader Hurrian theological pattern where the supreme deity (Teshub) has a consort (Hepat). Confidence medium: the spousal relationship is inferred from the inscriptional association rather than being explicitly stated as marriage in the surviving Urartian texts. Piotrovsky (1969) pp. 100-102.',
 'SRC_PIOTROVSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed'),
('ENT_URA_ARUBANI', 'aligned_with', 'ENT_HTT_SHAUSHKA',
 'medium',
 'Arubani and Hurrian/Hittite Shaushka are structurally parallel: both are the goddess associated with the supreme storm/war deity (Arubani with Khaldi; Shaushka as consort of Teshub), both are love/arts/fertility deities complementing their consort''s war function. If Teisheba = Teshub through Hurro-Urartian inheritance, then Arubani as Khaldi''s consort plausibly inherits the Shaushka role. Confidence medium: the comparison is structurally sound but the surviving evidence for Arubani''s precise functions is thin. Zimansky (1985) p. 72.',
 'SRC_ZIMANSKY_URARTU', 'PER_URA_IRON_AGE', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities WHERE tradition = 'Urartian'
GROUP BY tradition;

SELECT e.canonical_name, COUNT(er.relationship_id) AS rels
FROM entities e
LEFT JOIN entity_relationships er
  ON (er.subject_entity_id = e.entity_id OR er.object_entity_id = e.entity_id)
WHERE e.entity_id IN ('ENT_URA_KHALDI','ENT_URA_TEISHEBA','ENT_URA_SHIVINI','ENT_URA_ARUBANI')
GROUP BY e.entity_id, e.canonical_name
ORDER BY e.canonical_name;

SELECT * FROM v_release_metrics;

COMMIT;
