-- wire_singleedge_v1.sql — connectivity remediation batch 3 (v1.63.2)
-- Enriches under-wired (degree-1) Egyptian & Mesopotamian entities with ADDITIONAL
-- typed, source-backed edges (family, pantheon, syncretism, domain), researched per
-- cluster. Boilerplate per-Assessor "presides_over Truth" spokes were dropped as noise.
-- Idempotent: validates ids/types, edge source = each subject's own attesting source,
-- skips duplicates.
BEGIN;
CREATE TEMP TABLE _p3(subject text, rtype text, object text, confidence text, rationale text) ON COMMIT DROP;
INSERT INTO _p3 VALUES
-- Egyptian
 ('ENT_EGY_AKER','embodies','ENT_EARTH','high','Personified earth god of the deep ground and horizon'),
 ('ENT_EGY_HESAT','syncretized_with','ENT_EGY_HATHOR','high','Milk-cow goddess treated as an aspect of Hathor'),
 ('ENT_EGY_HESAT','patron_of','ENT_MOTHERHOOD','high','Goddess of milk and nourishment, mother of the bull gods'),
 ('ENT_EGY_IHY','child_of','ENT_EGY_HATHOR','high','Child god, son of Hathor in the Dendera theology'),
 ('ENT_EGY_IHY','patron_of','ENT_JOY','high','God of jubilation and joyful sistrum music'),
 ('ENT_EGY_IUSAASET','patron_of','ENT_MOTHERHOOD','high','Heliopolitan mother goddess and grandmother of the gods'),
 ('ENT_EGY_IUSAASET','participates_in_creation','ENT_CREATION','medium','As the hand of Atum, agent of the first creative act'),
 ('ENT_EGY_KHENTAMENTIU','belongs_to_realm','ENT_EGY_DUAT','high','Foremost of the Westerners ruling the necropolis underworld'),
 ('ENT_EGY_KHENTAMENTIU','presides_over','ENT_DEATH','high','Jackal god of the dead and the Abydos necropolis'),
 ('ENT_EGY_KHERTY','presides_over','ENT_DEATH','medium','Underworld ferryman and guardian of the dead'),
 ('ENT_EGY_MEHEN','opposes','ENT_EGY_APEP','high','Coils around the solar barque to defend Ra against Apep'),
 ('ENT_EGY_MEHETWERET','embodies','ENT_WATER','high','The Great Flood personifying the primeval celestial waters'),
 ('ENT_EGY_MEHETWERET','syncretized_with','ENT_EGY_HATHOR','medium','The celestial cow identified with Hathor'),
 ('ENT_EGY_AMENHOTEP_HAPU','patron_of','ENT_HEALING','high','Deified sage with a healing incubation cult at Deir el-Bahari'),
 ('ENT_EGY_KAMAAT','embodies','ENT_TRUTH','high','The Bull of Maat personifies cosmic truth in the night barque of Ra'),
 ('ENT_EGY_BABI','presides_over','ENT_DEATH','medium','Fierce baboon power of the afterlife and the judgment hall'),
 ('ENT_EGY_NEFERTEM','child_of','ENT_EGY_SEKHMET','high','Son of Sekhmet in the Memphite triad'),
 ('ENT_EGY_NEFERTEM','child_of','ENT_EGY_PTAH','high','Son of Ptah in the Memphite triad'),
 ('ENT_EGY_NEHEBUKAU','presides_over','ENT_PROTECTION','high','Protective serpent guarding the ka in the afterlife'),
 ('ENT_EGY_NEPER','syncretized_with','ENT_EGY_OSIRIS','high','The death and renewal of the grain god assimilated to Osiris'),
 ('ENT_EGY_NEPER','presides_over','ENT_AGRICULTURE','high','God of grain, barley and emmer, and the harvest'),
 ('ENT_EGY_TATENEN','presides_over','ENT_EARTH','high','Personifies the primordial emergent earth mound'),
 ('ENT_EGY_WADJWER','presides_over','ENT_FERTILITY','medium','Fecundity god of the sea and Delta lagoons'),
 ('ENT_EGY_NEHMETAWY','presides_over','ENT_PROTECTION','medium','Protective goddess who rescues and embraces the needy'),
 ('ENT_EGY_SHESMETET','presides_over','ENT_PROTECTION','medium','Fierce protective lioness goddess'),
-- Mesopotamian
 ('ENT_MES_ASAG','causes_affliction','ENT_DISEASE','high','The monstrous demon of disease in the Lugale'),
 ('ENT_MES_BASHMU','opposes','ENT_MES_MARDUK','high','Among the eleven monsters of Tiamat opposed by Marduk'),
 ('ENT_MES_BAU','presides_over','ENT_HEALING','high','The healing goddess of Lagash'),
 ('ENT_MES_BELET_ILI','identified_with','ENT_MES_NINHURSAG','high','The womb goddess identified with the mother goddess Ninhursag'),
 ('ENT_MES_BELET_SERI','belongs_to_realm','ENT_UNDERWORLD','high','Scribe of the underworld keeping the register of the dead'),
 ('ENT_MES_DAGAN','parent_of','ENT_MES_ADAD_ISHKUR','high','Father of the storm god Hadad in the middle Euphrates tradition'),
 ('ENT_MES_EDIMMU','belongs_to_realm','ENT_UNDERWORLD','high','The restless ghost of the improperly buried dead'),
 ('ENT_MES_ENBILULU','presides_over','ENT_WATER','high','God of canals, irrigation and rivers'),
 ('ENT_MES_ENMESHARRA','belongs_to_realm','ENT_UNDERWORLD','high','A primordial dead god of the underworld'),
 ('ENT_MES_ENMESHARRA','opposes','ENT_MES_MARDUK','medium','Contends with Marduk over the ancient powers'),
 ('ENT_MES_ENNUGI','belongs_to_realm','ENT_UNDERWORLD','medium','The canal inspector with underworld associations at Nippur'),
 ('ENT_MES_ASHNAN','presides_over','ENT_AGRICULTURE','high','Goddess of grain and the harvest'),
 ('ENT_MES_GESHTINANNA','belongs_to_realm','ENT_UNDERWORLD','high','Substitutes for Dumuzi and dwells in the underworld'),
 ('ENT_MES_HUMBABA','slain_by','ENT_MES_ENKIDU','high','Slain by Gilgamesh together with Enkidu in the Cedar Forest'),
 ('ENT_MES_HUSHBISHAG','belongs_to_realm','ENT_UNDERWORLD','high','Stewardess of the underworld in the court of Ereshkigal'),
 ('ENT_MES_ISHARA','presides_over','ENT_LOVE','high','A goddess of love and marriage'),
 ('ENT_MES_ISHTARAN','presides_over','ENT_JUSTICE','high','The divine judge and city god of Der'),
 ('ENT_MES_ISHUM','presides_over','ENT_FIRE','high','The benevolent fire god and herald'),
 ('ENT_MES_KAKKA','transmits','ENT_MES_ANSHAR','high','Messenger of Anshar carrying word in Enuma Elish'),
 ('ENT_MES_KISHAR','parent_of','ENT_MES_ANU','high','Anshar and Kishar are the parents of Anu in Enuma Elish'),
 ('ENT_MES_KUSARIKKU','opposes','ENT_MES_MARDUK','medium','The bull-man counted among the brood of Tiamat opposed by Marduk'),
 ('ENT_MES_LAHAR','presides_over','ENT_AGRICULTURE','medium','Deity of flocks and wool in the pastoral economy'),
 ('ENT_MES_MUMMU','imprisoned_by','ENT_MES_ENKI_EA','high','The vizier of Apsu bound by Ea at the beginning'),
 ('ENT_MES_NANAYA','presides_over','ENT_LOVE','high','Goddess of love and sensuality'),
 ('ENT_MES_NANSHE','presides_over','ENT_JUSTICE','high','The Lagash goddess of social justice and care for the poor'),
 ('ENT_MES_NETI','dwells_in','ENT_UNDERWORLD','high','The chief gatekeeper of the underworld'),
 ('ENT_MES_NINGISHZIDA','spouse_of','ENT_MES_GESHTINANNA','high','Geshtinanna is the wife of Ningishzida'),
 ('ENT_MES_NINGISHZIDA','belongs_to_realm','ENT_UNDERWORLD','high','A chthonic god of the underworld threshold'),
 ('ENT_MES_NINGUBLAGA','presides_over','ENT_ANIMALS','medium','A cattle god overseeing the herds of the moon god'),
 ('ENT_MES_NINSIANNA','embodies','ENT_VENUS','high','The personified planet Venus'),
 ('ENT_MES_NINTINUGGA','presides_over','ENT_HEALING','high','A Nippur healing goddess who restores the dead to life'),
 ('ENT_MES_SHAKKAN','presides_over','ENT_ANIMALS','high','God of the herds and wild animals of the steppe'),
 ('ENT_MES_SHEDU','guardian_of','ENT_THRESHOLDS','high','Tutelary guardian of palace and gate'),
 ('ENT_MES_SHEDU','presides_over','ENT_PROTECTION','high','A benevolent protective tutelary spirit'),
 ('ENT_MES_SHULPAE','causes_affliction','ENT_DISEASE','medium','Regarded as a bringer of disease'),
 ('ENT_MES_SIRSIR','presides_over','ENT_WATER','medium','God of boats, sailors and the sea'),
 ('ENT_MES_TISHPAK','presides_over','ENT_WAR','high','The warrior tutelary god of Eshnunna'),
 ('ENT_MES_UGALLU','presides_over','ENT_STORM','high','The Big Weather-Beast, a lion-headed storm demon'),
 ('ENT_MES_UGALLU','presides_over','ENT_PROTECTION','high','Used apotropaically as a doorway guardian'),
 ('ENT_MES_UTUKKU','belongs_to_realm','ENT_UNDERWORLD','medium','Spirits including restless ghosts from the underworld'),
 ('ENT_MES_ZABABA','presides_over','ENT_WAR','high','The warrior city-god of Kish');

\echo '--- REJECTED (bad id/type or no source) — should be empty ---'
SELECT p.subject,p.rtype,p.object FROM _p3 p
WHERE NOT (EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.subject)
  AND EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.object)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=p.rtype)
  AND EXISTS(SELECT 1 FROM entity_sources es WHERE es.entity_id=p.subject));

INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status)
SELECT p.subject,p.rtype,p.object,p.confidence,p.rationale,
  (SELECT es.source_id FROM entity_sources es WHERE es.entity_id=p.subject ORDER BY es.source_id LIMIT 1),'reviewed'
FROM _p3 p
WHERE EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.subject)
  AND EXISTS(SELECT 1 FROM entities e WHERE e.entity_id=p.object)
  AND EXISTS(SELECT 1 FROM relationship_types t WHERE t.relationship_type=p.rtype)
  AND EXISTS(SELECT 1 FROM entity_sources es WHERE es.entity_id=p.subject)
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

COMMIT;
