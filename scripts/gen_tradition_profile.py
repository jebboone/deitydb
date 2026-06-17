#!/usr/bin/env python3
# Generates build_tradition_profile.sql — a tradition-level metadata layer classifying every tradition
# by KIND (mainstream-scriptural / civic-polytheism / mystical-current / heterodox-sect / esoteric-magic /
# modern-esoteric / comparative) and PREVALENCE, with a status note that captures the crucial distinction
# the entity counts alone obscure: e.g. the grimoire/occult traditions were historically present and
# influential but were learned textual subcultures embedded in a host religion, not mainstream faiths.
# Creates tradition_profile (table) + v_public_tradition_profile (view). v1.76.0. Idempotent (upsert).
import json, os
HERE = os.path.dirname(os.path.abspath(__file__))

CLASS_NOTE = {
 "mainstream-scriptural":"A mainstream scriptural religion — the dominant faith of its society, worshipped communally by the broad population.",
 "civic-polytheism":"An established civic/state polytheism — the mainstream public religion of its society in its era.",
 "mystical-current":"A mystical or contemplative current embedded WITHIN a mainstream faith, practiced by a devout minority — not a separate religion.",
 "heterodox-sect":"A heterodox or minority sect — a real religious community but marginal to, and often suppressed by, the dominant faith.",
 "esoteric-magic":"A learned ritual-magic / grimoire tradition — historically present and genuinely influential, but a textual subculture of a few literate specialists, framed within and drawing on the dominant religion rather than a mainstream faith in its own right.",
 "modern-esoteric":"A modern (19th-20th c.) esoteric movement — an organized but comparatively small new-religious / occult current, not a mainstream faith.",
 "legendary-literary":"A legendary/literary mythos rather than a practiced religion — its figures live in story (and, for the Grail, in Christian devotion), but it was never the cult of a community.",
 "vernacular-folklore":"Contemporary vernacular & digital folklore — emergent supernatural beings people genuinely engage ritually (summoning), devotionally (petition/veneration), or apotropaically (warding/protection), outside any organized religion: urban legends, cryptids, sleep-paralysis and entheogenic encounter-entities, meme-magic egregores, and New Age / Gen-Z devotional currents. Lived belief and practice (ostension), NOT fiction — purely fictional creepypasta and franchises are excluded.",
 "comparative":"Not a religion: a cross-traditional layer of shared abstractions used for comparison.",
}
# tradition -> (class, prevalence[, note_override])
P = {
 # mainstream-scriptural
 "Christian":("mainstream-scriptural","dominant"),"Christian/Biblical":("mainstream-scriptural","dominant"),
 "Christian/Orthodox":("mainstream-scriptural","dominant"),"Christian reception":("mainstream-scriptural","regional"),
 "Islamic":("mainstream-scriptural","dominant"),"Islamic/Shi'a":("mainstream-scriptural","dominant"),
 "Israelite":("mainstream-scriptural","dominant"),"Israelite/Second Temple":("mainstream-scriptural","dominant"),
 "Jewish":("mainstream-scriptural","dominant"),
 # mystical-current (embedded in a mainstream faith)
 "Christian/Theurgic":("mystical-current","widespread","The Pseudo-Dionysian / Christian-theurgic current — mainstream Christian theology of the angelic hierarchy, contemplative rather than a separate religion."),
 "Islamic/Sufi":("mystical-current","widespread"),"Islamic/Sufi/Shi'a":("mystical-current","regional"),
 "Jewish Mystical":("mystical-current","learned-subculture","Kabbalah and Merkavah mysticism — a learned esoteric current embedded within Judaism, transmitted among a devout scholarly minority."),
 "Hermetic/Theurgic":("mystical-current","learned-subculture"),"Hermetic/Greco-Egyptian":("mystical-current","learned-subculture"),
 # heterodox-sect
 "Gnostic":("heterodox-sect","marginal"),"Sethian":("heterodox-sect","marginal"),"Valentinian":("heterodox-sect","marginal"),
 "Ophite/Archontic":("heterodox-sect","marginal"),"Basilidean":("heterodox-sect","marginal"),"Carpocratian":("heterodox-sect","marginal"),
 "Simonian":("heterodox-sect","marginal"),"Saturnilian":("heterodox-sect","marginal"),"Marcionite":("heterodox-sect","marginal"),
 "Sethian/Ophite/Jewish":("heterodox-sect","marginal"),"Thomasine/Christian-Gnostic":("heterodox-sect","marginal"),
 "Mandaean":("heterodox-sect","marginal","The Mandaeans — a small gnostic baptismal religion, marginal and surviving as a minority to the present."),
 "Manichaean":("heterodox-sect","marginal","Manichaeism — once a widespread world religion from Rome to China, later suppressed everywhere and extinct; a major but ultimately marginalized sect."),
 # whole missing religions added in the completeness build-out (Phase 1)
 "Yazidi":("heterodox-sect","living-minority","The Yazidi — a distinct living Kurdish religion centered on Tawûsî Melek (the Peacock Angel) and the Heptad; an endogamous minority, NOT a sect of Islam."),
 "Druze":("heterodox-sect","living-minority","The Druze (Muwahhidun) — a closed living religion of the Levant, an offshoot of Ismaili Islam with its own cosmology of the five luminaries (al-hudud)."),
 "Yarsan":("heterodox-sect","living-minority","Yarsan / Ahl-e Haqq — a living western-Iranian religion centered on Sultan Sahak and the chain of divine manifestations."),
 "Alawite":("heterodox-sect","living-minority","Alawite / Nusayri — a living Syrian religion with the ʿAyn-Mim-Sin trinity; an esoteric offshoot of Twelver Shi'a Islam."),
 "Bahá'í":("mainstream-scriptural","modern-worldwide","The Bahá'í Faith — an independent modern world religion of Abrahamic lineage built on progressive revelation through the Manifestations of God."),
 "Samaritan":("heterodox-sect","living-minority","Samaritanism — a distinct surviving Israelite religion centered on Mount Gerizim; a very small ancient community."),
 "Latter-day Saint":("mainstream-scriptural","modern-worldwide","The Latter-day Saint (Mormon) movement — a large modern Restorationist branch of Christianity with a distinctive cosmology (premortal existence, exaltation, Kolob)."),
 "Sabian/Harranian":("civic-polytheism","regional-extinct","The Sabians of Harran — the late-antique planetary star-religion and Harranian Hermetism; long extinct."),
 "Alevi":("mystical-current","living-minority","Alevi-Bektashi — a living Anatolian tradition blending Shi'a, Sufi and folk elements around the Allah-Muhammad-Ali trinity and the Assembly of the Forty."),
 # the Oriental & Eastern Christian churches + the heterodox/demonology layer (completeness Phase 2)
 "Syriac Christian":("mainstream-scriptural","regional","Syriac Christianity (West & East Syriac / Church of the East) — a major early-Christian branch with its own Fathers (Ephrem, Isaac of Nineveh)."),
 "Armenian Christian":("mainstream-scriptural","regional","The Armenian Apostolic Church — the world's first state church; distinct from the pre-Christian Armenian pantheon."),
 "Ethiopian Christian":("mainstream-scriptural","regional","Ethiopian Tewahedo Christianity — a major non-Chalcedonian church with the Kebra Nagast cycle and its own saints and angelology."),
 "Coptic Christian":("mainstream-scriptural","regional","Coptic (Egyptian) Christianity — the church of Athanasius and Shenoute, cradle of monasticism."),
 "Christian/Heterodox":("heterodox-sect","marginal","Intra-Christian heresies and dualist movements (Arian, Nestorian, Pelagian, Bogomil, Cathar) — condemned/suppressed by the mainstream church."),
 "Christian demonology":("esoteric-magic","learned-subculture","The learned Christian demonological tradition beyond the Goetia — the demonologists' chief-demon hierarchies (the Seven Princes, the Loudun possession demons)."),
 # ancient-depth additions (completeness Phase 3)
 "Mithraic Mysteries":("mystical-current","Roman-imperial initiatory","The Roman cult of Mithras — an initiatory all-male mystery religion of the imperial army (2nd-4th c. CE), structured around the tauroctony and seven grades."),
 "Lydian":("civic-polytheism","regional","The Lydian pantheon of Iron-Age western Anatolia (Kuvava/Kybebe, Santas), ancestral to several Greek-Anatolian cults."),
 "Lycian":("civic-polytheism","regional","The Lycian civic polytheism of SW Anatolia (Trqqas, the Twelve Gods, Eni Mahanahi)."),
 "Carian":("civic-polytheism","regional","The Carian civic polytheism of SW Anatolia, centered on Zeus Labraundos and the great Hecate of Lagina."),
 "Commagene":("civic-polytheism","regional","The syncretic Hellenistic-Iranian royal cult of Commagene (Antiochus I, Nemrud Dağ): Zeus-Oromasdes, Apollo-Mithras, Artagnes-Heracles."),
 # European-depth additions (completeness Phase 4)
 "Anglo-Saxon":("civic-polytheism","regional","The pre-Christian Old English pantheon (Woden, Thunor, Tiw, Frige, Ēostre), reconstructed from royal genealogies, place-names, Bede and charms."),
 "Continental Germanic":("civic-polytheism","regional","The Romano-Germanic continental deities and the Matronae (triple mother-goddesses) of the Rhineland, attested mostly in Roman-era votive inscriptions."),
 "Illyrian":("civic-polytheism","regional","The Illyrian pantheon of the western Balkans (Medaurus, Redon, En), attested in inscriptions and Roman interpretatio."),
 "Germanic Legend":("legendary-literary","literary","The Germanic heroic-legendary cycle (the Völsung/Nibelung matter — Sigurð, Brynhild, Wayland) — a mythos in saga and epic, like the Arthurian material."),
 "Nart (Ossetian/Sarmatian)":("civic-polytheism","regional","The Nart sagas of the Caucasus — the surviving Scythian/Sarmatian-Alanic mythology (Batraz, Satana, Uastyrdzhi), a living oral epic among the Ossetians and neighbours."),
 "Venetic":("civic-polytheism","regional","The Venetic pantheon of pre-Roman NE Italy, centered on the goddess Reitia."),
 # esoteric & modern-NRM additions (completeness Phase 5)
 "Wicca":("modern-esoteric","modern-worldwide","Wicca / modern pagan witchcraft — the largest contemporary neopagan religion (Gardner, 1940s+), duotheist (the Horned God & the Triple Goddess)."),
 "Alchemical":("esoteric-magic","learned-subculture","Western alchemy as a spiritual-symbolic system — the personified principles (tria prima, the King & Queen, the Rebis, Azoth)."),
 "Modern Satanism":("modern-esoteric","modern-worldwide","Organized modern Satanism, Luciferianism and the Temple of Set (Church of Satan 1966, The Satanic Temple, Temple of Set) — symbolic and theistic currents."),
 "Masonic/Rosicrucian":("esoteric-magic","learned-subculture","Freemasonry and Rosicrucianism — fraternal esoteric traditions (the Great Architect, Hiram Abiff, Christian Rosenkreutz)."),
 "UFO Religion":("modern-esoteric","modern-worldwide","UFO/contactee religions (Raëlism, Heaven's Gate, the channeling milieu) — the Space Brothers, Ashtar, the Nine, the Elohim."),
 "Scientology":("modern-esoteric","modern-worldwide","The Church of Scientology — a modern new religion; its cosmology of thetans and the Xenu account modeled here as held belief."),
 "Discordianism":("modern-esoteric","modern-worldwide","Discordianism — a genuinely-engaged absurdist religion venerating Eris/Discordia (Principia Discordia, 1958+)."),
 "Modern Paganism":("modern-esoteric","modern-worldwide","Reconstructionist & revival paganism beyond Wicca — modern Heathenry/Ásatrú, Druidry, the Goddess movement, plus Martinist/New-Thought currents."),
 # esoteric-magic (learned ritual-magic / grimoire)
 "Goetic/Solomonic":("esoteric-magic","learned-subculture"),"Renaissance Esoteric":("esoteric-magic","learned-subculture"),
 "Solomonic Magic":("esoteric-magic","learned-subculture"),"Astral Magic":("esoteric-magic","learned-subculture"),
 "Greco-Egyptian Magical":("esoteric-magic","learned-subculture"),"Late Antique Ritual":("esoteric-magic","learned-subculture"),
 "19th-century occultism":("esoteric-magic","learned-subculture"),
 # modern-esoteric
 "Theosophical":("modern-esoteric","modern-revival"),"Anthroposophy":("modern-esoteric","modern-revival"),
 "Spiritualist":("modern-esoteric","modern-revival"),"Thelemic":("modern-esoteric","modern-revival"),
 "Modern Occult":("modern-esoteric","modern-revival"),"Modern reception":("modern-esoteric","modern-revival"),
 # civic-polytheism — dominant (major literate state religions)
 "Greek":("civic-polytheism","dominant"),"Greek/Orphic":("civic-polytheism","dominant"),"Greek/Roman":("civic-polytheism","dominant"),
 "Greek/Roman/Egyptian":("civic-polytheism","dominant"),"Greek/Anatolian":("civic-polytheism","dominant"),
 "Greek/Phrygian":("civic-polytheism","dominant"),"Greek/Phrygian/Cretan":("civic-polytheism","dominant"),"Greek/Rhodian":("civic-polytheism","dominant"),
 "Roman":("civic-polytheism","dominant"),"Roman/Persian reception":("civic-polytheism","dominant"),
 "Egyptian":("civic-polytheism","dominant"),"Greco-Egyptian":("civic-polytheism","dominant"),"Greco-Egyptian/Libyan":("civic-polytheism","dominant"),
 "Mesopotamian":("civic-polytheism","dominant"),"Germanic/Norse":("civic-polytheism","dominant"),"Zoroastrian":("civic-polytheism","dominant"),
 "Canaanite/Ugaritic":("civic-polytheism","dominant"),"Hittite":("civic-polytheism","dominant"),"Hittite/Hurrian":("civic-polytheism","dominant"),
 # civic-polytheism — regional (smaller / attestation-limited indigenous polytheisms; mainstream for their people but limited in reach)
 "Celtic/Irish":("civic-polytheism","regional"),"Celtic/Welsh":("civic-polytheism","regional"),"Celtic/Gaulish":("civic-polytheism","regional"),
 "Celtic/Gaulish/Roman":("civic-polytheism","regional"),"Celtic/British":("civic-polytheism","regional"),
 "Phoenician":("civic-polytheism","regional"),"Etruscan":("civic-polytheism","regional"),"Italic/Sabine":("civic-polytheism","regional"),
 "Mycenaean":("civic-polytheism","regional"),"Phrygian":("civic-polytheism","regional"),"Luwian":("civic-polytheism","regional"),
 "Aramean":("civic-polytheism","regional"),"Armenian":("civic-polytheism","regional"),"Nabataean":("civic-polytheism","regional"),
 "Pre-Islamic Arabian":("civic-polytheism","regional"),"South Arabian":("civic-polytheism","regional"),"Meroitic":("civic-polytheism","regional"),
 "Aksumite":("civic-polytheism","regional"),"Urartian":("civic-polytheism","regional"),"Elamite":("civic-polytheism","regional"),
 "Baltic":("civic-polytheism","regional"),"Slavic":("civic-polytheism","regional"),"Finnish":("civic-polytheism","regional"),
 "Thracian":("civic-polytheism","regional"),"Dacian":("civic-polytheism","regional"),"Scythian":("civic-polytheism","regional"),
 "Iberian/Lusitanian":("civic-polytheism","regional"),"Moabite":("civic-polytheism","regional"),"Ammonite":("civic-polytheism","regional"),
 "Edomite":("civic-polytheism","regional"),"Basque":("civic-polytheism","regional"),"Sámi":("civic-polytheism","regional"),
 "Hungarian":("civic-polytheism","regional"),
 # legendary-literary
 "Arthurian":("legendary-literary","literary"),
 # vernacular-folklore (contemporary online + urban-legend + New Age devotional)
 "Contemporary Folklore & Vernacular Religion":("vernacular-folklore","emergent"),
 # comparative
 "Cross-traditional":("comparative","abstraction"),
}
def q(x): return "'" + str(x).replace("'","''") + "'"
rows=[]
for trad,(cls,prev,*ov) in sorted(P.items()):
    note = ov[0] if ov else CLASS_NOTE[cls]
    rows.append(" (%s,%s,%s,%s)"%(q(trad),q(cls),q(prev),q(note)))

out=["-- build_tradition_profile.sql  (GENERATED by gen_tradition_profile.py) — v1.76.0",
 "-- Tradition-level metadata: kind + prevalence + status note (mainstream vs. esoteric/marginal).",
 "BEGIN;",
 "CREATE TABLE IF NOT EXISTS tradition_profile (",
 "  tradition text PRIMARY KEY,",
 "  tradition_class text NOT NULL,",
 "  prevalence text NOT NULL,",
 "  status_note text",
 ");",
 "INSERT INTO tradition_profile (tradition,tradition_class,prevalence,status_note) VALUES",
 ",\n".join(rows),
 "ON CONFLICT (tradition) DO UPDATE SET tradition_class=EXCLUDED.tradition_class, prevalence=EXCLUDED.prevalence, status_note=EXCLUDED.status_note;",
 "",
 "CREATE OR REPLACE VIEW v_public_tradition_profile AS",
 "SELECT tp.tradition, tp.tradition_class, tp.prevalence, tp.status_note,",
 "       (SELECT count(*) FROM entities e WHERE e.tradition=tp.tradition) AS entity_count",
 "FROM tradition_profile tp",
 "ORDER BY tp.tradition_class, entity_count DESC;",
 "",
 "\\echo '--- coverage: entity traditions with NO profile row (must be 0) ---'",
 "SELECT DISTINCT e.tradition FROM entities e LEFT JOIN tradition_profile tp ON tp.tradition=e.tradition WHERE tp.tradition IS NULL;",
 "\\echo '--- profile summary by class ---'",
 "SELECT tradition_class, count(*) AS traditions, sum((SELECT count(*) FROM entities e WHERE e.tradition=tp.tradition)) AS entities FROM tradition_profile tp GROUP BY 1 ORDER BY 3 DESC;",
 "COMMIT;",
]
open(os.path.join(HERE,"build_tradition_profile.sql"),"w").write("\n".join(out))
print("wrote build_tradition_profile.sql: %d tradition profiles" % len(rows))
