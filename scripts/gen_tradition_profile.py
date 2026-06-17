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
