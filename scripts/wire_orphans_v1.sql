-- wire_orphans_v1.sql — connectivity audit remediation, batch 1 (v1.63.0)
-- Wires 48 previously-orphan entities (0 relationships) into the graph with
-- typed, source-backed edges. Researched per tradition against primary/scholarly
-- sources; SAINTS are kept strictly as venerated humans (member_of the Fourteen
-- Holy Helpers only — no divine framing). Each edge reuses a source the entity is
-- already attested by. Idempotent & safe: validates every id/type/source and skips
-- any duplicate (ON CONFLICT) — re-runnable.
BEGIN;

CREATE TEMP TABLE _prop(subject text, rtype text, object text, confidence text, rationale text, source_id text) ON COMMIT DROP;
INSERT INTO _prop(subject,rtype,object,confidence,rationale,source_id) VALUES
-- Christian saints (Fourteen Holy Helpers only)
 ('ENT_CHR_BARBARA','member_of','ENT_SAINT_FOURTEEN_HELPERS','high','One of the canonical Fourteen Holy Helpers','SRC_GOLDEN_LEGEND'),
 ('ENT_CHR_CHRISTOPHER','member_of','ENT_SAINT_FOURTEEN_HELPERS','high','One of the canonical Fourteen Holy Helpers','SRC_GOLDEN_LEGEND'),
 ('ENT_CHR_MARGARET','member_of','ENT_SAINT_FOURTEEN_HELPERS','high','One of the canonical Fourteen Holy Helpers','SRC_GOLDEN_LEGEND'),
 ('ENT_SAINT_DENIS','member_of','ENT_SAINT_FOURTEEN_HELPERS','high','One of the canonical Fourteen Holy Helpers','SRC_FARMER_SAINTS'),
-- Egyptian
 ('ENT_EGY_HA','paired_with','ENT_EGY_ASH','high','Western-desert protector god, counterpart of Ash','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_IGAI','paired_with','ENT_EGY_HA','medium','Oasis god of the western desert, akin to Ha','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_HEQAIB','patron_of','ENT_PROTECTION','high','Deified Elephantine sage venerated as a protective local patron','SRC_HABACHI_HEQAIB'),
 ('ENT_EGY_ISI_EDFU','patron_of','ENT_PROTECTION','medium','Deified Edfu nomarch venerated as a protective local god','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_HEREHEQENU','cult_form_of','ENT_EGY_HORUS','medium','Horus the Praiser, a Horus hypostasis in the Amduat','SRC_HORNUNG_DUAT'),
 ('ENT_EGY_HEREHEQENU','paired_with','ENT_EGY_NEBETWIA','high','Fellow member of the solar night-barque crew','SRC_HORNUNG_DUAT'),
 ('ENT_EGY_IPY_OPET','paired_with','ENT_EGY_TAWERET','high','Theban hippopotamus protective-maternal goddess, akin to Taweret','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_IPY_OPET','paired_with','ENT_EGY_RERET','medium','Grouped among the hippopotamus goddesses with Reret','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_IUSAASET','consort_of','ENT_EGY_ATUM','high','The hand of Atum, his feminine creative complement','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_KHERTY','belongs_to_realm','ENT_EGY_DUAT','high','Ram-form underworld god and ferryman of the dead','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_SEKHET_AARU','belongs_to_realm','ENT_EGY_DUAT','high','Field of Reeds, paradise within the netherworld','SRC_FAULKNER_BOOK_OF_DEAD'),
 ('ENT_EGY_SEKHET_AARU','paired_with','ENT_EGY_SEKHET_HETEPET','high','Field of Reeds and Field of Offerings are paired afterlife realms','SRC_FAULKNER_BOOK_OF_DEAD'),
 ('ENT_EGY_SEKHET_HETEPET','belongs_to_realm','ENT_EGY_DUAT','high','Field of Offerings, provisioning realm of the blessed dead','SRC_FAULKNER_BOOK_OF_DEAD'),
 ('ENT_EGY_TUTU_TITHOES','child_of','ENT_EGY_NEITH','high','Tutu the apotropaic sphinx, attested as son of Neith','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_TUTU_TITHOES','patron_of','ENT_PROTECTION','high','Apotropaic deity who wards off hostile demons','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_WENEG','child_of','ENT_EGY_RA','high','Son of Ra who supports the sky in the Pyramid Texts','SRC_FAULKNER_PYRAMID_TEXTS'),
 ('ENT_EGY_WERETHEKAU','embodies','ENT_MAGIC','high','Great of Magic, personified power of the crowns','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_WERETHEKAU','patron_of','ENT_PROTECTION','medium','Protective magic guarding the king and crowns','SRC_WILKINSON_EGYPTIAN_GODS'),
 ('ENT_EGY_WADJWER','paired_with','ENT_EGY_HAPY_NILE','medium','Great Green sea-fecundity figure, marine counterpart of Hapy','SRC_WILKINSON_EGYPTIAN_GODS'),
-- Mesopotamian / Anatolian
 ('ENT_HTT_LELWANI','identified_with','ENT_MES_ERESHKIGAL','medium','Hittite underworld deity equated with Allatu and Ereshkigal','SRC_TARACHA_ANATOLIA'),
 ('ENT_HTT_HUTENA','embodies','ENT_FATE','high','Hurrian fate-and-birth goddesses who allot destiny','SRC_TARACHA_ANATOLIA'),
 ('ENT_MES_GIRTABLULLU','guardian_of','ENT_MES_UTU_SHAMASH','high','Scorpion-men who guard the gate of the rising sun','SRC_GEORGE_GILGAMESH'),
 ('ENT_MES_KUSARIKKU','guardian_of','ENT_MES_UTU_SHAMASH','high','Bull-man attendant and gate-guardian of the sun-god','SRC_BLACK_GREEN_MESO'),
 ('ENT_MES_NANAYA','identified_with','ENT_MES_INANNA_ISHTAR','high','Love goddess closely syncretized with Inanna and Ishtar','SRC_ETCSL'),
 ('ENT_MES_NINKASI','child_of','ENT_MES_NINHURSAG','medium','Healing deity born of Ninhursag in Enki and Ninhursag','SRC_ETCSL'),
 ('ENT_MES_SHARA','child_of','ENT_MES_INANNA_ISHTAR','high','Warrior city-god of Umma, son of Inanna','SRC_BLACK_GREEN_MESO'),
 ('ENT_MES_SHARA','member_of','ENT_MES_ANUNNAKI','medium','City-god counted among the great gods','SRC_BLACK_GREEN_MESO'),
 ('ENT_MES_SHAKKAN','member_of','ENT_MES_ANUNNAKI','medium','Steppe-herds god counted among the great gods','SRC_BLACK_GREEN_MESO'),
 ('ENT_MES_ISHTARAN','member_of','ENT_MES_ANUNNAKI','medium','Divine judge of Der counted among the great gods','SRC_BLACK_GREEN_MESO'),
 ('ENT_MES_SULAK','causes_affliction','ENT_DISEASE','high','Lurker of the privy who strikes with sudden seizure','SRC_BLACK_GREEN_MESO'),
 ('ENT_MES_EDIMMU','causes_affliction','ENT_DISEASE','high','Restless ghost that afflicts the living with illness','SRC_BLACK_GREEN_MESO'),
 ('ENT_MES_ZABABA','identified_with','ENT_MES_NINURTA','high','Warrior city-god of Kish syncretized with Ninurta','SRC_BLACK_GREEN_MESO'),
-- Roman / Celtic
 ('ENT_ROM_LIBERTAS','identified_with','ENT_ELEUTHERIA','high','Roman personified liberty, interpretatio of Greek Eleutheria','SRC_LIVY_AUC'),
 ('ENT_ROM_PIETAS','identified_with','ENT_EUSEBEIA','high','Roman personified piety, equivalent of Greek Eusebeia','SRC_LIVY_AUC'),
 ('ENT_ROM_CARNA','presides_over','ENT_HEALING','medium','Goddess guarding the heart and bodily health','SRC_OVID_FASTI'),
 ('ENT_ROM_FEBRIS','causes_affliction','ENT_DISEASE','high','Goddess of fever propitiated to avert malarial illness','SRC_WISSOWA_RKR'),
 ('ENT_ROM_MEFITIS','causes_affliction','ENT_DISEASE','medium','Goddess of noxious exhalations held to cause sickness','SRC_WISSOWA_RKR'),
 ('ENT_ROM_ORBONA','presides_over','ENT_DEATH','medium','Goddess invoked by parents bereft of children','SRC_AUGUSTINE_CITY_OF_GOD'),
 ('ENT_ROM_VOLTURNUS','presides_over','ENT_WATER','high','Archaic Roman river god with his own flamen','SRC_WISSOWA_RKR'),
 ('ENT_ROM_FURRINA','presides_over','ENT_WATER','medium','Archaic goddess of springs with her own flamen','SRC_WISSOWA_RKR'),
 ('ENT_ROM_ANGERONA','presides_over','ENT_SILENCE','medium','Goddess of silence, cult statue with bound and sealed mouth','SRC_WISSOWA_RKR'),
 ('ENT_CEL_RITONA','presides_over','ENT_WATER','medium','Treveran goddess of river-fords and crossings','SRC_CIL'),
 ('ENT_CEL_UCUETIS','presides_over','ENT_METALWORK','high','Smith-god of Alesia honored by metalworkers','SRC_CIL'),
 ('ENT_CEL_ARTIO','presides_over','ENT_ANIMALS','medium','Gaulish bear-goddess of wildlife','SRC_CIL'),
-- Zoroastrian
 ('ENT_ZOR_ASMAN','emanates_from','ENT_ZOR_AHURA_MAZDA','high','Yazata of the sky, a creation of Ahura Mazda','SRC_AVESTA'),
 ('ENT_ZOR_CHISTA','emanates_from','ENT_ZOR_AHURA_MAZDA','high','Yazata of religious insight, a creation of Ahura Mazda','SRC_AVESTA'),
 ('ENT_ZOR_DRVASPA','emanates_from','ENT_ZOR_AHURA_MAZDA','high','Yazata guarding cattle and horses, created by Ahura Mazda','SRC_AVESTA'),
 ('ENT_ZOR_GEUSH_URVAN','paired_with','ENT_ZOR_DRVASPA','medium','Soul of the Bovine, paired with cattle-guardian Drvaspa','SRC_AVESTA'),
 ('ENT_ZOR_HAOMA','emanates_from','ENT_ZOR_AHURA_MAZDA','high','Deified sacred plant and priest-god, a yazata','SRC_AVESTA'),
 ('ENT_ZOR_NAIRYOSANGHA','emanates_from','ENT_ZOR_AHURA_MAZDA','high','Messenger yazata created by Ahura Mazda','SRC_AVESTA'),
 ('ENT_ZOR_NAIRYOSANGHA','mediates','ENT_ZOR_AHURA_MAZDA','medium','Divine messenger carrying the messages of Ahura Mazda','SRC_AVESTA'),
 ('ENT_ZOR_VIZARESH','member_of','ENT_ZOR_DAEVAS','high','Demon who drags off the souls of the wicked','SRC_AVESTA');

\echo '--- REJECTED rows (bad subject/object/source/type) — should be empty ---'
SELECT p.subject, p.rtype, p.object, p.source_id,
  CASE WHEN NOT EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.subject) THEN 'no subject'
       WHEN NOT EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.object) THEN 'no object'
       WHEN NOT EXISTS(SELECT 1 FROM sources s WHERE s.source_id=p.source_id) THEN 'no source'
       WHEN NOT EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=p.rtype) THEN 'bad type'
       ELSE '?' END AS reason
FROM _prop p
WHERE NOT (EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.subject)
  AND EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.object)
  AND EXISTS(SELECT 1 FROM sources s WHERE s.source_id=p.source_id)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=p.rtype));

INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status)
SELECT p.subject,p.rtype,p.object,p.confidence,p.rationale,p.source_id,'reviewed'
FROM _prop p
WHERE EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.subject)
  AND EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.object)
  AND EXISTS(SELECT 1 FROM sources s WHERE s.source_id=p.source_id)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=p.rtype)
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

COMMIT;
