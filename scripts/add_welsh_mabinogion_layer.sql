-- scripts/add_welsh_mabinogion_layer.sql
-- Welsh tradition layer — entities from the Mabinogion (Four Branches + Culhwch ac Olwen)
--
-- The Mabinogion (SRC_MABINOGION) was registered as a source but had 0 entity links
-- because no Welsh entities existed in the database. This script:
--   1. Adds PER_CEL_MEDIEVAL_WELSH (c. 1050-1400 CE)
--   2. Adds 15 Welsh mythological entities
--   3. Links them to SRC_MABINOGION + secondary sources
--   4. Links two reception chains to existing Irish cognates
--
-- Source basis: The Mabinogion's Four Branches of the Mabinogi are preserved in
-- the White Book of Rhydderch (c. 1350 CE) and Red Book of Hergest (c. 1382 CE);
-- linguistic and stylistic analysis dates the composition of the Four Branches to
-- c. 1050-1120 CE; the oral mythological traditions behind them reflect Iron Age
-- British/Welsh divine figures whose names correspond to continental Celtic and
-- Irish cognates (Lleu/Lugh/Lugus; Rhiannon/*Rigantona/Epona; Manawydan/Manannán).
--
-- The tradition label 'Celtic/Welsh' follows the existing pattern:
-- 'Celtic/Irish', 'Celtic/Gaulish'.
--
-- Mabinogion structural reference (Lady Guest / Sioned Davies translations):
--   First Branch  : Pwyll Pendefig Dyfed  (Pwyll, Rhiannon, Pryderi's birth, Arawn)
--   Second Branch : Branwen ferch Llŷr    (Bran, Branwen, Manawydan, Cauldron)
--   Third Branch  : Manawydan fab Llŷr    (Manawydan, Pryderi, enchantment of Dyfed)
--   Fourth Branch : Math fab Mathonwy     (Math, Gwydion, Aranrhod, Lleu, Blodeuwedd)
--   Culhwch ac Olwen: Gwyn ap Nudd, the Otherworld hunt tradition

BEGIN;

-- ── 1. New period ─────────────────────────────────────────────────────────────

INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES (
  'PER_CEL_MEDIEVAL_WELSH',
  'Celtic/Welsh',
  'Medieval Welsh',
  1050,
  1400,
  'Period of the Four Branches of the Mabinogi and other Welsh mythological texts preserved in the White Book of Rhydderch (c. 1350) and Red Book of Hergest (c. 1382). Linguistic evidence dates the Four Branches composition to c. 1050-1120 CE; oral traditions behind them are older.'
) ON CONFLICT DO NOTHING;

-- ── 2. Welsh entities ─────────────────────────────────────────────────────────

INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, primary_domains,
  tags, evidence_confidence, review_status, inclusion_basis, short_note
) VALUES

  -- First Branch
  ('ENT_WEL_RHIANNON', 'Rhiannon', 'Celtic/Welsh', 'Sovereignty goddess',
   'sovereignty, horses, otherworld, fate, birds',
   'sovereignty, otherworld, birds, horses, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Divine horsewoman and sovereignty goddess; First Branch of the Mabinogi; her name from *Rigantona ("Great Queen"); her magical white horse cannot be caught; her Otherworldly birds wake the dead and send the living to sleep; wrongly accused of killing her son Pryderi; probable cognate of Gaulish Epona'),

  ('ENT_WEL_PWYLL', 'Pwyll', 'Celtic/Welsh', 'Otherworld-adjacent king',
   'sovereignty, otherworld, honor, Dyfed',
   'otherworld, Dyfed, sovereignty, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Prince of Dyfed; First Branch; enters the Otherworld (Annwn) and exchanges kingdoms with Arawn for a year; earns the title Pen Annwn (Head of Annwn); marries Rhiannon; father of Pryderi; a liminal hero figure who bridges the human and Otherworldly realms'),

  ('ENT_WEL_ARAWN', 'Arawn', 'Celtic/Welsh', 'Otherworld king',
   'otherworld, hunting, death, sovereignty',
   'Annwn, Otherworld, hunting, death, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'King of Annwn (the Welsh Otherworld); First Branch; he exchanges places with Pwyll for a year to defeat his rival Hafgan; grants Pwyll the title Pen Annwn; associated with the white hounds with red-tipped ears (Cŵn Annwn, the Otherworld hunting pack); one of the primary figures ruling the Welsh Otherworld'),

  ('ENT_WEL_PRYDERI', 'Pryderi', 'Celtic/Welsh', 'Divine hero',
   'fate, sovereignty, tragedy, Dyfed',
   'fate, Dyfed, tragedy, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Son of Pwyll and Rhiannon; First Branch through Third Branch; the only character to appear in all four branches of the Mabinogi; born under enchantment and immediately stolen; his name means "Care/Anxiety"; a tragic hero figure whose life is framed by magical crises; killed by Gwydion in single combat in the Fourth Branch'),

  -- Second Branch
  ('ENT_WEL_BRAN', 'Brân the Blessed', 'Celtic/Welsh', 'Giant divine king',
   'sovereignty, death, rebirth, cauldron, sacred head',
   'giant, cauldron, sacred-head, sovereignty, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Bendigeidfran (Brân the Blessed); Second Branch; king of Britain; so giant he cannot enter a house; possessor of the magical Cauldron of Rebirth (given to him by Irish king Matholwch) which resurrects the dead; mortally wounded by a poisoned spear at the Battle of Ir Ireland; his head commands that it be carried to Gwales where it speaks and feasts for 87 years; a key figure in the insular Celtic severed-head cult'),

  ('ENT_WEL_BRANWEN', 'Branwen', 'Celtic/Welsh', 'Tragic queen/goddess',
   'sovereignty, love, tragedy, Ireland-Wales',
   'tragedy, sovereignty, Welsh-Irish, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Branwen daughter of Llŷr; Second Branch; one of the "Three Chief Maidens of the Island of Britain"; given in marriage to Matholwch king of Ireland to seal a peace treaty; subjected to humiliating kitchen work in Ireland after Efnysien mutilates Matholwch''s horses; trains a starling to carry a message to her brother Bran; dies of grief after the war she inadvertently caused; her name possibly from Celtic *Bran-winda ("White Raven")'),

  ('ENT_WEL_MANAWYDAN', 'Manawydan', 'Celtic/Welsh', 'Otherworld craftsman god',
   'craftsmanship, patience, otherworld, sea',
   'craftsmanship, otherworld, sea, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Manawydan fab Llŷr; Second and Third Branch; son of Llŷr, brother of Brân; his name is the Welsh cognate of Irish Manannán mac Lir (both from a common Celtic prototype *Manawydanō); a skilled craftsman in the Third Branch (makes saddles, shields, shoes); patient and strategic where Pryderi is impulsive; associated with the sea despite largely terrestrial adventures in the text'),

  -- Fourth Branch
  ('ENT_WEL_MATH', 'Math fab Mathonwy', 'Celtic/Welsh', 'Magician-king',
   'magic, sovereignty, fate, Gwynedd',
   'magic, kingship, Gwynedd, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Math son of Mathonwy; Fourth Branch; lord of Gwynedd; possesses a characteristic magical taboo — he must keep his feet in the lap of a virgin at all times when not at war or he will die; the taboo drives the plot when Gilfaethwy (his nephew) rapes the foot-holder Goewin; Math punishes Gwydion and Gilfaethwy by transforming them into breeding pairs of deer, pigs, and wolves for three years; co-creator of Blodeuwedd'),

  ('ENT_WEL_GWYDION', 'Gwydion', 'Celtic/Welsh', 'Trickster magician',
   'magic, shapeshifting, trickery, storytelling, creation',
   'trickster, magic, shapeshifting, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Gwydion fab Dôn; Fourth Branch; nephew and student of Math; the great magician-trickster of Welsh mythology; conjures an illusory army from mushrooms to trick Pryderi out of his pigs; creates Lleu''s wife Blodeuwedd from flowers; the most active and morally ambiguous figure in the Fourth Branch; creates the path of stars called Caer Gwydion (the Milky Way) in Welsh tradition'),

  ('ENT_WEL_LLEU_LLAW_GYFFES', 'Lleu Llaw Gyffes', 'Celtic/Welsh', 'Solar hero',
   'craftsmanship, solar, fate, death-rebirth',
   'solar, fate, death-rebirth, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   '"Lleu of the Skillful Hand"; Fourth Branch; son of Aranrhod (and Gwydion); his mother refuses to acknowledge him and places three tyngedau (magical taboos) on him: no name, no weapons, no human wife; Gwydion circumvents each; killed by Gronw Pebyr (his wife''s lover) with the only spear that can harm him; transformed into an eagle; restored to human form by Gwydion; his name cognate with Irish Lugh and Gaulish Lugus — the pan-Celtic "many-skilled" solar hero'),

  ('ENT_WEL_BLODEUWEDD', 'Blodeuwedd', 'Celtic/Welsh', 'Flower goddess / divine creation',
   'love, betrayal, fate, transformation, flowers',
   'flower-creation, betrayal, owl, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   '"Flower-Face"; Fourth Branch; created by Gwydion and Math from the flowers of the oak, broom, and meadowsweet to be a wife for Lleu (who cannot marry a human woman per his mother''s taboo); falls in love with Gronw Pebyr; engineers Lleu''s death; punished by Gwydion who transforms her into an owl; the only character in Welsh mythology created specifically as a solution to a magical prohibition; her betrayal and transformation is the Welsh tradition''s most complex female character arc'),

  ('ENT_WEL_ARANRHOD', 'Aranrhod', 'Celtic/Welsh', 'Star goddess / destiny figure',
   'fate, stars, magic, maternity, taboo',
   'stars, fate, taboo, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Aranrhod daughter of Dôn; Fourth Branch; refuses to acknowledge her son Lleu after he falls from her womb during a magical test of her virginity; places three tyngedau on him; her name means "Silver Wheel" (arian = silver; rhod = wheel), connecting her to the stars or a spinning wheel; her caer (fort) Caer Aranrhod is identified with a rocky reef and the Corona Borealis constellation; a sovereign-fate-goddess figure'),

  ('ENT_WEL_DON', 'Dôn', 'Celtic/Welsh', 'Mother goddess collective',
   'divine family, primordial motherhood, magic',
   'mother-goddess, divine-family, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'Dôn is the ancestral mother of the divine family in the Fourth Branch (Gwydion, Aranrhod, Gilfaethwy, Arianrhod are all "children of Dôn"); she appears only as a name but her family constitutes the Welsh divine order in Gwynedd; cognate with Irish Danu (mother of the Tuatha Dé Danann) and possibly the Gaulish goddess Dôn; the Welsh equivalent of the pan-Celtic divine mother'),

  -- Otherworld realm
  ('ENT_WEL_ANNWN', 'Annwn', 'Celtic/Welsh', 'Otherworld realm',
   'otherworld, death, feasting, magic, sovereignty',
   'Otherworld, Annwn, realm, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   'The Welsh Otherworld; First Branch: ruled by Arawn, who grants the title Pen Annwn (Head of Annwn) to Pwyll; characterized by hunting, feasting, magical animals (the white hounds with red-tipped ears), and the absence of time; the name Annwn (or Annwfn) possibly from *ande-dubno- ("under-world" or "very deep"); it is not primarily a realm of the dead but of the living gods, magic, and abundance'),

  -- Culhwch ac Olwen
  ('ENT_WEL_GWYN_AP_NUDD', 'Gwyn ap Nudd', 'Celtic/Welsh', 'Otherworld king',
   'otherworld, hunting, death, fairy court, winter',
   'Wild-Hunt, fairy-king, Otherworld, Welsh, Mabinogion',
   'A', 'reviewed', 'primary_text',
   '"Gwyn son of Nudd"; appears in Culhwch ac Olwen (Mabinogion) as a leader of the Otherworld hunt and a champion who Arthur must use for the hunt of Twrch Trwyth; his name ("white" + "mist/lord") suggests an Otherworld sovereignty figure; later tradition makes him king of the Tylwyth Teg (fairy folk) and associated with the souls of the dead; he fights Gwythyr ap Greidawl every May Day until Doomsday for the love of Creiddylad')

ON CONFLICT DO NOTHING;

-- ── 3. Entity sources ─────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  -- SRC_MABINOGION primary for all
  ('ENT_WEL_RHIANNON',       'SRC_MABINOGION', 'primary_attestation',
   'First Branch (Pwyll Pendefig Dyfed): Rhiannon first appears riding an impossibly fast white horse; Pwyll woos her; she is accused of infanticide and punished; her birds are specified as having power over sleep and waking; Third Branch: she marries Manawydan after Pwyll''s death; the primary text for the sovereignty-goddess / magical-horsewoman tradition in Welsh mythology'),
  ('ENT_WEL_PWYLL',          'SRC_MABINOGION', 'primary_attestation',
   'First Branch (Pwyll Pendefig Dyfed): the narrative is named after him; his exchange with Arawn establishes the Otherworld as a parallel realm with political structure; he earns the title Pen Annwn; his marriage to Rhiannon and the birth of Pryderi constitute the branch''s narrative arc; primary attestation'),
  ('ENT_WEL_ARAWN',          'SRC_MABINOGION', 'primary_attestation',
   'First Branch: Arawn king of Annwn encounters Pwyll hunting; proposes a year-long exchange; his rival Hafgan can only be killed with a single blow (a second blow resurrects him); the First Branch is the primary ancient text for Arawn as a named Otherworld ruler'),
  ('ENT_WEL_PRYDERI',        'SRC_MABINOGION', 'primary_attestation',
   'First through Fourth Branch: the only character present in all four branches; his birth (First Branch), maturity and marriage (Second Branch), enchantment and rescue of Dyfed (Third Branch), and death at Gwydion''s hands (Fourth Branch) span the entire Mabinogi; the most extensively attested Welsh mythological character'),
  ('ENT_WEL_BRAN',           'SRC_MABINOGION', 'primary_attestation',
   'Second Branch (Branwen ferch Llŷr): Bran is the narrative''s dominant figure; he gives the Cauldron of Rebirth to Matholwch; leads the invasion of Ireland; is mortally wounded by the poisoned spear of Llassar; commands his head to be carried to Gwales for 87 years of speaking/feasting; the text is the primary source for the Welsh sacred-head tradition and the divine giant-king figure'),
  ('ENT_WEL_BRANWEN',        'SRC_MABINOGION', 'primary_attestation',
   'Second Branch (Branwen ferch Llŷr): the branch is named after Branwen; she is given to Matholwch of Ireland; subjected to humiliation in the Irish kitchen; trains a starling; dies of grief at the Alaw river saying "woe that I was ever born"; the primary text for this tragic figure; one of the "Three Fortunate Concealments of the Island of Britain" is the head of Brân she supervises'),
  ('ENT_WEL_MANAWYDAN',      'SRC_MABINOGION', 'primary_attestation',
   'Second and Third Branch: Second: travels to Ireland with Bran''s retinue; Third: the branch is titled after him (Manawydan fab Llŷr); he and Pryderi find the enchanted castle and Pryderi is trapped; Manawydan patiently learns crafts (saddle-making, shoemaking, shielding) and finally catches the enchanter Llwyd and forces him to lift the enchantment; the primary medieval Welsh text for this figure'),
  ('ENT_WEL_MATH',           'SRC_MABINOGION', 'primary_attestation',
   'Fourth Branch (Math fab Mathonwy): Math''s taboo drives the plot; he transforms his nephews as punishment; co-creates Blodeuwedd with Gwydion; creates Lleu''s arms and name by tricking Aranrhod; the lord of Gwynedd who embodies sovereign magic in the Fourth Branch; primary attestation'),
  ('ENT_WEL_GWYDION',        'SRC_MABINOGION', 'primary_attestation',
   'Fourth Branch: Gwydion is the most active character; he tricks Pryderi, engineers the violation of Math''s foot-holder, protects and names Lleu, creates Blodeuwedd, retrieves Lleu from eagle-form and restores him; he is the narrative''s trickster-magician whose actions drive every turn of the plot; primary attestation for this figure'),
  ('ENT_WEL_LLEU_LLAW_GYFFES','SRC_MABINOGION', 'primary_attestation',
   'Fourth Branch: Lleu''s story is the climax; three tyngedau from Aranrhod, each circumvented by Gwydion; his marriage to Blodeuwedd; his unique vulnerability (the only spear made only while mass is being said for a year; must be standing with one foot on a goat and one in a bathtub); transformed into an eagle when struck; rescued and restored; the primary text for the Welsh solar-hero tradition and the Lugh/Lugus cognate'),
  ('ENT_WEL_BLODEUWEDD',     'SRC_MABINOGION', 'primary_attestation',
   'Fourth Branch: created by Gwydion and Math "from the blossoms of the oak, and the blossoms of the broom, and the blossoms of the meadowsweet" (Sioned Davies translation); her infidelity with Gronw Pebyr and engineering of Lleu''s death; her punishment (transformation into an owl, forbidden from daylight, shunned by all birds); the most detailed and complex female character in the Four Branches; primary attestation'),
  ('ENT_WEL_ARANRHOD',       'SRC_MABINOGION', 'primary_attestation',
   'Fourth Branch: Aranrhod steps over Math''s wand to prove her virginity; two children fall from her; one becomes Dylan, one becomes Lleu; she refuses to acknowledge Lleu and places three tyngedau on him out of shame; the only character in the Mabinogion who actively and persistently curses her own child; primary attestation'),
  ('ENT_WEL_DON',            'SRC_MABINOGION', 'primary_attestation',
   'Fourth Branch: Dôn is mentioned only as the mother of the divine family — Gwydion fab Dôn, Arianrhod ferch Dôn, Gilfaethwy fab Dôn — but her name anchors the Welsh divine order''s divine matrilineal descent structure; the "Children of Dôn" constitute the Welsh mythological divine family parallel to Ireland''s Tuatha Dé Danann ("Tribes of the Goddess Danu")'),
  ('ENT_WEL_ANNWN',          'SRC_MABINOGION', 'primary_attestation',
   'First Branch: Annwn is the Otherworld ruled by Arawn; described as a realm with its own court, hunting, feasting, and political conflicts; its animals (white hounds with red-tipped ears) are immediately recognizable as Otherworldly; Pwyll enters Annwn and returns changed; the primary text establishing Annwn as a named Welsh Otherworld realm'),
  ('ENT_WEL_GWYN_AP_NUDD',   'SRC_MABINOGION', 'primary_attestation',
   'Culhwch ac Olwen: Arthur must recruit Gwyn ap Nudd for the hunt of Twrch Trwyth because only Gwyn can control the demonic boar; Gwyn is described as holding the power of the demons of Annwn lest they destroy the present world; he fights Gwythyr every May Day for Creiddylad; primary Mabinogion attestation'),

  -- Secondary source links for all
  ('ENT_WEL_RHIANNON',       'SRC_GREEN_CELTIC_GODS', 'secondary_reference',
   'Green (1992) pp. 181-183: Rhiannon as a sovereignty goddess; the *Rigantona etymology; comparison with Gaulish Epona the horse goddess; Green documents the widespread Celtic pattern of the divine horsewoman as a sovereignty figure'),
  ('ENT_WEL_LLEU_LLAW_GYFFES','SRC_GREEN_CELTIC_GODS', 'secondary_reference',
   'Green (1992) pp. 131-132: Lleu as the Welsh cognate of Lugh and Lugus; the "many-skilled" epithet and the solar hero pattern across Celtic traditions; the name etymology from *Lugus'),
  ('ENT_WEL_MANAWYDAN',      'SRC_GREEN_CELTIC_GODS', 'secondary_reference',
   'Green (1992) pp. 139-140: Manawydan as the Welsh cognate of Manannán mac Lir; both from *Manawydanō; the sea-god/otherworld-craftsman tradition shared between the insular Celtic traditions'),
  ('ENT_WEL_DON',            'SRC_GREEN_CELTIC_GODS', 'secondary_reference',
   'Green (1992) pp. 78-79: Dôn as the Welsh cognate of Irish Danu and possibly the Gaulish divine mother; the "children of Dôn" pattern as the Welsh expression of the pan-Celtic divine family structure'),
  ('ENT_WEL_BRAN',           'SRC_GREEN_CELTIC_GODS', 'secondary_reference',
   'Green (1992) pp. 35-36: Brân and the Celtic cult of the divine severed head; the head as the seat of divine power that continues to speak after death; Green documents the archaeological evidence for the head cult alongside the literary tradition'),
  ('ENT_WEL_GWYN_AP_NUDD',   'SRC_GREEN_CELTIC_GODS', 'secondary_reference',
   'Green (1992) pp. 104-105: Gwyn ap Nudd as the psychopomp fairy-king and Wild Hunt leader in Welsh tradition; his role as controller of the demons of Annwn; connection to the Otherworld sovereignty traditions'),

  -- Mac Cana for Lleu/Lugh and Manawydan/Manannán comparanda
  ('ENT_WEL_LLEU_LLAW_GYFFES','SRC_MACCANA_CELTIC_MYTH', 'secondary_reference',
   'Mac Cana (1970) pp. 53-57: the Lugus/Lugh/Lleu as the pan-Celtic "many-skilled" deity; the shared name *Lugus (Gaulish) with cognates in Irish Lugh Lámhfhada and Welsh Lleu Llaw Gyffes; Mac Cana argues for a single pan-Celtic prototype'),
  ('ENT_WEL_MANAWYDAN',      'SRC_MACCANA_CELTIC_MYTH', 'secondary_reference',
   'Mac Cana (1970) pp. 66-67: the Manawydan/Manannán comparison; both from *Manawydanō; the sea-god prototype who becomes an Otherworld craftsman in Welsh and a sea-god psychopomp in Irish; the different textual traditions have developed the figure in divergent directions')
ON CONFLICT DO NOTHING;

-- ── 4. Period assignments ─────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_WEL_RHIANNON',        'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Rhiannon is attested in the First Branch of the Mabinogi, composed c. 1050-1120 CE and preserved in MSS from c. 1350; she is the primary sovereignty-goddess figure of the Welsh mythological tradition',
   'SRC_MABINOGION', 'reviewed'),
  ('ENT_WEL_RHIANNON',        'PER_CEL_IRON_AGE', 'low',
   'The etymology *Rigantona ("Great Queen") and the Epona parallel suggest her divine prototype has roots in Iron Age Celtic religion; her horse-goddess attributes (the impossible white horse, the processional approach) parallel the Gaulish Epona cult documented in Iron Age and Roman-period inscriptions; confidence is low because no direct Iron Age textual evidence for a Welsh Rhiannon-figure exists',
   'SRC_GREEN_CELTIC_GODS', 'reviewed'),

  ('ENT_WEL_PWYLL',           'PER_CEL_MEDIEVAL_WELSH', 'high',
   'First Branch of the Mabinogi; the text''s primary narrative subject; medieval Welsh literary attestation',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_ARAWN',           'PER_CEL_MEDIEVAL_WELSH', 'high',
   'First Branch of the Mabinogi; lord of Annwn in the medieval Welsh text tradition',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_PRYDERI',         'PER_CEL_MEDIEVAL_WELSH', 'high',
   'First through Fourth Branch of the Mabinogi; the character spans all four branches; medieval Welsh literary tradition',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_BRAN',            'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Second Branch of the Mabinogi; the narrative''s central figure; medieval Welsh literary attestation',
   'SRC_MABINOGION', 'reviewed'),
  ('ENT_WEL_BRAN',            'PER_CEL_IRON_AGE', 'low',
   'The Celtic severed-head cult documented archaeologically from the Iron Age (Roquepertuse, Entremont; La Tène period) provides the probable cultic substrate for Brân''s speaking head tradition; Green (1992) argues for continuity between Iron Age head-cult practice and the Mabinogi narrative; confidence is low as there is no direct inscription or attestation for a "Brân" figure in the Iron Age',
   'SRC_GREEN_CELTIC_GODS', 'reviewed'),

  ('ENT_WEL_BRANWEN',         'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Second Branch of the Mabinogi (Branwen ferch Llŷr); the branch is named for her',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_MANAWYDAN',       'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Second and Third Branch of the Mabinogi (Third Branch titled Manawydan fab Llŷr)',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_MATH',            'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Fourth Branch of the Mabinogi (Math fab Mathonwy)',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_GWYDION',         'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Fourth Branch of the Mabinogi; the most active protagonist in the branch',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_LLEU_LLAW_GYFFES','PER_CEL_MEDIEVAL_WELSH', 'high',
   'Fourth Branch of the Mabinogi; his story is the Fourth Branch''s climactic narrative',
   'SRC_MABINOGION', 'reviewed'),
  ('ENT_WEL_LLEU_LLAW_GYFFES','PER_CEL_IRON_AGE', 'medium',
   'Gaulish *Lugus is attested in Iron Age inscriptions from Spain (Uxama Argaela; the Celtiberian city Lugudunum) and is the probable common Celtic prototype for Lugh (Irish) and Lleu (Welsh); the "many-skilled" deity prototype has Pan-Celtic Iron Age currency; confidence is medium because the Welsh Lleu''s specific mythology is only preserved in medieval texts',
   'SRC_GREEN_CELTIC_GODS', 'reviewed'),

  ('ENT_WEL_BLODEUWEDD',      'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Fourth Branch of the Mabinogi; a figure unique to the Welsh medieval literary tradition with no direct Iron Age antecedent',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_ARANRHOD',        'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Fourth Branch of the Mabinogi; her name (Silver Wheel) and her caer (fort) identified with stars suggest a cosmic dimension that may reflect older tradition, but her textual attestation is wholly medieval Welsh',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_DON',             'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Present as the ancestral mother in the Fourth Branch of the Mabinogi; the "Children of Dôn" are the divine family of the Fourth Branch',
   'SRC_MABINOGION', 'reviewed'),
  ('ENT_WEL_DON',             'PER_CEL_IRON_AGE', 'low',
   'The name Dôn has been compared to Irish Danu and potentially to Gaulish divine-mother figures; if the comparison holds, the divine-mother prototype has Iron Age currency across the Celtic world; confidence is low because the equation of Dôn with Danu is debated and because the Irish Danu herself barely appears in the texts (she too is known primarily through her children''s epithets)',
   'SRC_GREEN_CELTIC_GODS', 'reviewed'),

  ('ENT_WEL_ANNWN',           'PER_CEL_MEDIEVAL_WELSH', 'high',
   'The Welsh Otherworld; named and described in the First Branch of the Mabinogi; further developed in the "Preiddeu Annwfn" (Spoils of Annwn), a poem attributed to Taliesin c. 9th-10th c.',
   'SRC_MABINOGION', 'reviewed'),

  ('ENT_WEL_GWYN_AP_NUDD',    'PER_CEL_MEDIEVAL_WELSH', 'high',
   'Culhwch ac Olwen (Mabinogion); also in the Welsh triads and later Arthurian tradition',
   'SRC_MABINOGION', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 5. Reception chains — Welsh ↔ Irish cognates ─────────────────────────────
-- These are name-cognate / structural parallel relationships, not
-- narrative reception chains. Using 'reception_of' with low confidence
-- following the pattern established for Mesopotamian→Greek chains.

INSERT INTO entity_relationships (
  subject_entity_id, relationship_type, object_entity_id,
  confidence, rationale, source_id, period_id, review_status
)
VALUES
  -- Lleu Llaw Gyffes → Lugh (both from *Lugus; "many-skilled" solar hero)
  ('ENT_WEL_LLEU_LLAW_GYFFES', 'reception_of', 'ENT_CEL_LUGH',
   'medium',
   'Lleu Llaw Gyffes and Irish Lugh Lámhfhada are both cognates of the Gaulish deity *Lugus; all three share: the "many-skilled" / "long arm" epithet, a divine craftsman who answers every skill at once, spear as primary weapon, a fate/destiny narrative involving their birth and naming, and the defeat of a dark antagonist; Green (1992) pp. 131-132; Mac Cana (1970) pp. 53-57; the Welsh Lleu preserves the more archaic narrative framework (three tyngedau, flower-wife) while the Irish Lugh is more extensively attested',
   'SRC_GREEN_CELTIC_GODS', 'PER_CEL_MEDIEVAL_WELSH', 'reviewed'),

  -- Manawydan → Manannán (name-cognate; divergent development in Welsh/Irish)
  ('ENT_WEL_MANAWYDAN', 'reception_of', 'ENT_CEL_MANANNAN',
   'low',
   'Manawydan (Welsh) and Manannán mac Lir (Irish) share a common Celtic name-prototype *Manawydanō; in Irish tradition Manannán is an active sea-god and psychopomp; in Welsh tradition Manawydan is a land-based craftsman; the divergence suggests independent development from a common prototype rather than direct textual transmission; Mac Cana (1970) pp. 66-67; Green (1992) pp. 139-140; confidence is low because the character types are quite different despite the name connection',
   'SRC_MACCANA_CELTIC_MYTH', 'PER_CEL_MEDIEVAL_WELSH', 'reviewed')

ON CONFLICT DO NOTHING;

-- ── 6. Verification ───────────────────────────────────────────────────────────

SELECT COUNT(*) AS welsh_entities_added
FROM entities WHERE tradition = 'Celtic/Welsh';

SELECT COUNT(DISTINCT entity_id) AS entities_linked_to_mabinogion
FROM entity_sources WHERE source_id = 'SRC_MABINOGION';

SELECT * FROM v_release_metrics;

COMMIT;
