import re,sys
STOP=set('the a an of and to in is on at by for with from as his her their they who whom which that this these those who he she it him them was were are be been being into out over under upon also who god gods son daughter named name great who one two three'.split())
CONFIGS={
 'irenaeus':dict(file='iren_all.txt',sid='SRC_IRENAEUS_AH',wt='Irenaeus, Against Heresies',tr='Roberts & Rambaut (Ante-Nicene Fathers)',yr=1885,url='https://en.wikisource.org/wiki/Ante-Nicene_Fathers/Volume_I/IRENAEUS',clean='plain',reason='Heresiological source (hostile witness) located by name; verify chapter.section.'),
 'virgil':dict(file='aeneid.txt',sid='SRC_VIRGIL_AENEID',wt='Virgil, Aeneid',tr='John Dryden',yr=1697,url='https://www.gutenberg.org/ebooks/228',clean='plain',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.02.0055',reason='English verse translation located by name; the locus is the Latin line-numbering — consult the original.'),
 # ovidm_all.txt = BOTH Riley volumes concatenated: Gutenberg #21765 (Books I-VII) + #26073 (Books VIII-XV).
 'ovidm':dict(file='ovidm_all.txt',sid='SRC_OVID_METAMORPHOSES',wt='Ovid, Metamorphoses',tr='Henry T. Riley',yr=1851,url='https://www.gutenberg.org/ebooks/21765',clean='plain',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.02.0029',reason='English translation located by name; the locus is the Latin line-numbering — consult the original.'),

 'prose_edda2':dict(file='prose_edda2.txt',sid='SRC_PROSE_EDDA',wt='Snorri Sturluson, Prose Edda (Faulkes)',tr='Anthony Faulkes',yr=1987,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt located by name; verify section.'),
 'poetic_edda2':dict(file='poetic_edda2.txt',sid='SRC_POETIC_EDDA',wt='The Poetic Edda',tr='trans.',yr=0,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt located by name; verify the poem/stanza.'),

 'homer_il':dict(file='iliad.txt',sid='SRC_HOMER_ILIAD_ODYSSEY',wt='Homer, Iliad',tr='Samuel Butler',yr=1898,url='https://www.gutenberg.org/ebooks/2199',clean='plain',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0133',reason='English prose translation located by name; locus is the Greek line-numbering — consult the original.'),
 'homer_od':dict(file='odyssey.txt',sid='SRC_HOMER_ILIAD_ODYSSEY',wt='Homer, Odyssey',tr='Samuel Butler',yr=1900,url='https://www.gutenberg.org/ebooks/1727',clean='plain',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0135',reason='English prose translation located by name; locus is the Greek line-numbering — consult the original.'),

 'ovidf':dict(file='fasti2.txt',sid='SRC_OVID_FASTI',wt='Ovid, Fasti (Riley, Bohn Classical Library)',tr='Henry T. Riley',yr=1851,url='https://archive.org/details/fastitristiapon00ovid',clean='ocr',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.02.0547',reason='English prose translation (Riley) located by name; OCR scan; the locus is the Latin line-numbering — consult the original (linked).'),

 'zohar2':dict(file='zohar2.txt',sid='SRC_ZOHAR',wt='The Zohar (Soncino edition)',tr='Sperling & Simon',yr=1934,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify section.'),
 'ginza':dict(file='ginza.txt',sid='SRC_GINZA_RBA',wt='Ginza Rabba (The Great Treasure)',tr='Al-Saadi',yr=2019,url=None,clean='plain',reason='Located by name; verify book/section.'),
 'manich_psalm':dict(file='manich.txt',sid='SRC_MANICHAEAN_PSALM_BOOK',wt='Manichaean Texts from the Roman Empire (Psalm-Book)',tr='Gardner & Lieu',yr=2004,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify.'),
 'manich_keph':dict(file='manich.txt',sid='SRC_MANICHAEAN_KEPHALAIA',wt='Manichaean Texts from the Roman Empire (Kephalaia)',tr='Gardner & Lieu',yr=2004,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify.'),
 'ventris':dict(file='ventris.txt',sid='SRC_VENTRIS_CHADWICK',wt='Ventris & Chadwick, Documents in Mycenaean Greek',tr='Ventris & Chadwick',yr=1973,url=None,clean='plain',reason='Linear B attestation — brief flagged excerpt; verify the tablet.'),
 'farley':dict(file='farley.txt',sid='SRC_SYNAXARION',wt='A Daily Calendar of Saints (Farley)',tr='Lawrence Farley',yr=2018,url=None,clean='plain',reason='Located by name in an Orthodox synaxarion; brief flagged excerpt; verify the commemoration.'),

 'dee':dict(file='dee.txt',sid='SRC_DEE_ENOCHIAN',wt='A True and Faithful Relation (Dee & Kelley)',tr='Meric Casaubon',yr=1659,url='https://archive.org/details/truefaithfulrela00deej',clean='ocr',reason='OCR scan, located by name; verify the action/aethyr.'),
 'apocrypha':dict(file='apocrypha.txt',sid='SRC_APOCRYPHA_NRSV',wt='The Apocrypha (King James Version)',tr='King James Version',yr=1611,url='https://www.gutenberg.org/ebooks/10900',clean='plain',reason='English (KJV Apocrypha) located by name; verify book:chapter.'),
 'secretdoctrine':dict(file='secretdoctrine.txt',sid='SRC_BLAVATSKY_SECRET_DOCTRINE',wt='H. P. Blavatsky, The Secret Doctrine',tr='H. P. Blavatsky',yr=1888,url='https://www.gutenberg.org/ebooks/54824',clean='plain',reason='Located by name; verify volume/page.'),
 'eusebius':dict(file='eusebius.txt',sid='SRC_PHILO_BYBLOS',wt='Philo of Byblos, Phoenician History (in Eusebius, Praeparatio I)',tr='E. H. Gifford',yr=1903,url='https://www.tertullian.org/fathers/eusebius_pe_01_book1.htm',clean='plain',reason='Sanchuniathon via Eusebius; located by name; verify section.'),
  'lebor':dict(file='lebor4.txt',sid='SRC_LEBOR_GABALA',wt='Lebor Gabála Érenn (Macalister, Vol. IV)',tr='R. A. S. Macalister',yr=1941,url='https://archive.org/details/leborgablare04macauoft',clean='ocr',reason='OCR scan of Macalister Vol. IV (English translation regions); located by name; verify the poem/paragraph section.'),
 'cathmaige':dict(file='cathmaige.txt',sid='SRC_CATH_MAIGE_TUIRED',wt='Cath Maige Tuired (The Second Battle of Mag Tuired)',tr='Whitley Stokes',yr=1891,url='https://celt.ucc.ie/published/T300010.html',clean='plain',reason='Located by name; verify section.'),

 'enoch1':dict(file='enoch1.txt',sid='SRC_1_ENOCH',wt='The Book of Enoch (1 Enoch)',tr='R. H. Charles',yr=1912,url='https://archive.org/details/bookofenochor1en00char',clean='ocr',reason='OCR scan, located by name; verify chapter.'),
 'dionysius_ch':dict(file='dionysius.txt',sid='SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY',wt='Pseudo-Dionysius, The Celestial Hierarchy',tr='John Parker',yr=1897,url='https://archive.org/details/theworksofdionys00dionuoft',clean='ocr',reason='OCR scan, located by name; verify chapter.'),
 'dionysius_eh':dict(file='dionysius.txt',sid='SRC_PSEUDO_DIONYSIUS_ECCLESIASTICAL_HIERARCHY',wt='Pseudo-Dionysius, The Ecclesiastical Hierarchy',tr='John Parker',yr=1897,url='https://archive.org/details/theworksofdionys00dionuoft',clean='ocr',reason='OCR scan, located by name; verify chapter.'),
 'goldenlegend':dict(file='goldenlegend.txt',sid='SRC_GOLDEN_LEGEND',wt='The Golden Legend (Caxton)',tr='William Caxton',yr=1483,url='https://archive.org/details/TheGoldenLegendV1',clean='ocr',reason='OCR scan of Caxton''s Golden Legend, located by name; verify the saint.'),
 'budge_df':dict(file='budge_df.txt',sid='SRC_WARD_SAYINGS',wt='The Paradise of the Holy Fathers (Budge)',tr='E. A. Wallis Budge',yr=1907,url='https://archive.org/details/paradiseofholyfa0001unse_f8u3',clean='ocr',reason='Desert Fathers sayings (Budge, PD substitute for Ward), located by name; verify.'),

 'enoch3':dict(file='enoch3.txt',sid='SRC_3_ENOCH',wt='3 Enoch (The Hebrew Book of Enoch)',tr='Hugo Odeberg',yr=1928,url='https://archive.org/details/ksigaxiienochorthehebrewbookofenoch_202012',clean='ocr',reason='OCR scan, located by name; verify chapter against a clean edition.'),
 'kabbalah':dict(file='kabbalah.txt',sid='SRC_ZOHAR',wt='The Kabbalah Unveiled (Zohar: Idras & Siphra Dtzenioutha)',tr='S. L. MacGregor Mathers',yr=1887,url='https://sacred-texts.com/jud/tku/',clean='ocr',reason='OCR scan of Mathers'' Zohar selections, located by name; verify section.'),
 'hermetica':dict(file='hermetica.txt',sid='SRC_CORPUS_HERMETICUM',wt='Corpus Hermeticum (Thrice-Greatest Hermes)',tr='G. R. S. Mead',yr=1906,url='https://archive.org/details/GRSMeadThriceGreatestHermesVolII',clean='ocr',reason='OCR scan, located by name; verify tractate.'),

 'etcsl':dict(file='etcsl.txt',sid='SRC_ETCSL',wt='Electronic Text Corpus of Sumerian Literature (ETCSL)',tr='Black, Cunningham, Robson, Zólyomi et al.',yr=2006,url='https://etcsl.orinst.ox.ac.uk/',clean='plain',reason='Located by name in the ETCSL translations; verify the composition (c.x.x) reference.'),

 'etzhayim':dict(file='etzhayim.txt',sid='SRC_ETZ_HAYYIM',wt='Hayyim Vital, Etz Hayyim',tr='trans.',yr=1573,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify gate/section.'),
 'ibnishaq2':dict(file='ibnishaq2.txt',sid='SRC_IBN_ISHAQ_SIRA',wt='Ibn Ishaq, The Life of Muhammad (Guillaume)',tr='A. Guillaume',yr=1955,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify.'),
 'malory':dict(file='malory.txt',sid='SRC_MALORY_MORTE',wt="Malory, Le Morte d'Arthur",tr='Sir Thomas Malory',yr=1485,url=None,clean='plain',reason='Located by name; verify book/chapter.'),
 'harazim':dict(file='harazim.txt',sid='SRC_SEFER_HARAZIM',wt='Sefer ha-Razim (Book of the Mysteries)',tr='Morgan',yr=1983,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify.'),
 'mandaean':dict(file='mandaean.txt',sid='SRC_MANDAEAN_BOOK_JOHN',wt='The Mandaean Book of John',tr='Häberl & McGrath',yr=2020,url=None,clean='plain',reason='Open-access translation; located by name; verify.'),
 'hittite':dict(file='hittite.txt',sid='SRC_HOFFNER_HITTITE_MYTHS',wt='Hoffner, Hittite Myths',tr='H. A. Hoffner Jr.',yr=1998,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify.'),
 'bukhari':dict(file='bukhari.txt',sid='SRC_SAHIH_BUKHARI',wt='Sahih al-Bukhari',tr='M. Muhsin Khan',yr=1971,url=None,clean='plain',reason='Located by name; verify book/hadith number.'),
 'synax':dict(file='prologue.txt',sid='SRC_SYNAXARION',wt='The Prologue of Ohrid (Synaxarion)',tr='St Nikolai Velimirovic',yr=1928,url='https://archive.org/details/ThePrologueFromOhrid_BishopNikolaiVelimirovich',clean='ocr',reason='Located by name in the Prologue of Ohrid; brief flagged excerpt, verify the commemoration date.'),
 'volsungs':dict(file='volsungs.txt',sid='SRC_BYOCK_VOLSUNGS',wt='The Saga of the Volsungs (Crawford)',tr='Jackson Crawford',yr=2017,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify.'),
 'picatrix':dict(file='picatrix.txt',sid='SRC_PICATRIX',wt='Picatrix (Ghayat al-Hakim)',tr='Greer & Warnock',yr=2011,url=None,clean='plain',reason='In-copyright translation — brief flagged excerpt; verify.'),

 'pyramid':dict(file='pyramid.txt',sid='SRC_FAULKNER_PYRAMID_TEXTS',wt='The Ancient Egyptian Pyramid Texts (Faulkner)',tr='R. O. Faulkner',yr=1969,url=None,clean='plain',
   reason='In-copyright modern translation — brief excerpt for identification, located by name; verify Utterance against the edition.'),
 'ibnishaq':dict(file='ibnishaq.txt',sid='SRC_IBN_ISHAQ_SIRA',wt='Ibn Ishaq, The Life of Muhammad (Sira)',tr='A. Guillaume',yr=1955,url=None,clean='plain',
   reason='In-copyright modern translation — brief excerpt for identification, located by name; verify against the edition.'),

 'jeu':dict(file='jeu.txt',sid='SRC_BOOKS_OF_JEU',wt='The Books of Jeu (Bruce Codex)',tr='Schmidt & MacDermot',yr=1978,url=None,clean='plain',
   reason='In-copyright modern translation — brief excerpt for identification, located by name; verify against the edition.'),
 'nhc_meyer':dict(file='nhc_meyer.txt',sid='SRC_NHC',wt='The Nag Hammadi Scriptures (Meyer, ed.)',tr='Marvin Meyer et al.',yr=2007,url=None,clean='plain',
   reason='In-copyright modern translation — brief excerpt for identification, located by name; verify against the edition.'),
 'orphic':dict(file='orphic.txt',sid='SRC_ORPHIC_HYMNS',wt='The Orphic Hymns',tr='Thomas Taylor',yr=1792,url=None,clean='plain',
   reason='English translation located by name; verify the hymn number.'),

 'nhc':dict(file='nhc.txt',sid='SRC_NAG_HAMMADI_SCRIPTURES',wt='The Nag Hammadi Library (Robinson, ed.)',tr='J. M. Robinson et al.',yr=1990,url=None,clean='plain',
   reason='In-copyright modern translation — brief excerpt for scholarly identification, located by name; verify against the published edition.'),

 'pistis':dict(file='pistis.txt',sid='SRC_PISTIS_SOPHIA',wt='Pistis Sophia (Mead)',tr='G. R. S. Mead',yr=1921,url='https://archive.org/details/pistissophia00mead',clean='ocr',
   reason='Re-sourced to the related Gnostic primary text Pistis Sophia (OCR), located by name; confirm against a clean edition / the entity\'s own tractate.'),

 'avesta_kanga':dict(file='avesta_kanga.txt',sid='SRC_AVESTA',wt='Khordeh Avesta (Kanga, English)',tr='Kavasji Edalji Kanga',yr=1880,url=None,clean='plain',
   orig='https://www.avesta.org/',reason='English translation (Kanga) located by name/alias; verify exact Yasna/Yasht locus.'),

 'testsol':dict(file='testsol.txt',sid='SRC_TESTAMENT_SOLOMON',wt='The Testament of Solomon',tr='F. C. Conybeare',yr=1898,url='https://www.esotericarchives.com/solomon/testamen.htm',clean='plain',
   reason='Conybeare 1898 translation (clean digital edition), located by name; verify the verse number against the edition.'),
 'avesta':dict(file='avesta.txt',sid='SRC_AVESTA',wt='The Zend-Avesta',tr='Darmesteter & Mills (Sacred Books of the East)',yr=1887,url='https://archive.org/details/zendavesta02darm',clean='ocr',
   reason='OCR scan, located by name; verify wording and exact Yasna/Yasht locus against a clean edition.'),

 'bundahishn':dict(file='bundahishn.txt',sid='SRC_BUNDAHISHN',wt='Bundahishn',tr='E. W. West (Sacred Books of the East 5)',yr=1880,url='https://archive.org/details/pahlavitexts01westuoft',clean='ocr',
   reason='OCR scan, located by name; verify wording and exact chapter against a clean edition.'),
 'agrippa':dict(file='agrippa_full.txt',sid='SRC_AGRIPPA_OCCULTA',wt='Agrippa, Three Books of Occult Philosophy',tr='J. F. (1651 English)',yr=1651,url='https://archive.org/details/threebooksofoccu00agri',clean='ocr',
   reason='OCR scan of the 1651 English translation, located by name; verify wording and exact book.chapter.'),

 'prose_edda':dict(file='prose_edda.txt',sid='SRC_PROSE_EDDA',wt='Snorri Sturluson, Prose Edda',tr='Rasmus B. Anderson',yr=1880,url='https://www.gutenberg.org/ebooks/18947',clean='plain',
   reason='English translation (Anderson, The Younger Edda) located by name within the work (not exact chapter); verify locus.'),
 'poetic_edda':dict(file='poetic_edda.txt',sid='SRC_POETIC_EDDA',wt='The Poetic Edda',tr='Benjamin Thorpe',yr=1866,url='https://www.gutenberg.org/ebooks/14726',clean='plain',
   reason='English translation (Benjamin Thorpe, in the Norroena ed. Gutenberg #14726) located by name within the work (not exact stanza); verify locus.'),
 'pausanias_sh':dict(file='pausanias_sh.txt',sid='SRC_PAUSANIAS_DESCRIPTION',wt='Pausanias, Description of Greece',tr='A. R. Shilleto',yr=1886,url='https://www.gutenberg.org/ebooks/68946',clean='plain',
   orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0159',reason='English translation (A. R. Shilleto, Bohn ed., Gutenberg #68946/#68680) located by name; verify book.chapter.'),
 'geoffrey':dict(file='geoffrey.txt',sid='SRC_GEOFFREY_MONMOUTH',wt='Geoffrey of Monmouth, Historia Regum Britanniae',tr='J. A. Giles',yr=1848,url='https://www.gutenberg.org/ebooks/37848',clean='plain',
   reason='English translation (J. A. Giles, in Old English Chronicles, Gutenberg #37848) located by name; verify book.chapter.'),
 # livy_all.txt = Canon Roberts, concatenated Gutenberg #19725 (Bks 1-8) + #10907 (9-26) + #12582 (27-36).
 'livy':dict(file='livy_all.txt',sid='SRC_LIVY_AUC',wt='Livy, Ab Urbe Condita',tr='Canon Roberts',yr=1912,url='https://www.gutenberg.org/ebooks/19725',clean='plain',
   reason='English translation (Canon Roberts, Everyman ed.) located by name; verify book.chapter.'),
 'mabinogion':dict(file='mabinogion.txt',sid='SRC_MABINOGION',wt='The Mabinogion',tr='Lady Charlotte Guest',yr=1877,url='https://www.gutenberg.org/ebooks/5160',clean='plain',
   reason='English translation located by name within the work; verify locus.'),
 'kalevala':dict(file='kalevala.txt',sid='SRC_KALEVALA',wt='The Kalevala',tr='John Martin Crawford',yr=1888,url='https://www.gutenberg.org/ebooks/5186',clean='plain',
   reason='English translation located by name within the work (not exact rune); verify locus.'),
 'quran':dict(file='quran_rodwell.txt',sid='SRC_QURAN',wt='The Qur’an',tr='J. M. Rodwell',yr=1861,url='https://www.gutenberg.org/ebooks/2800',clean='plain',
   orig='https://quran.com/',reason='English translation (Rodwell, chronological sura order) located by name; the cited sura:ayah is the standard reference — consult the Arabic (linked).'),
 'augustine':dict(file='augustine.txt',sid='SRC_AUGUSTINE_CITY_OF_GOD',wt='Augustine, City of God',tr='Marcus Dods',yr=1871,url='https://www.gutenberg.org/ebooks/45304',clean='plain',
   reason='English translation located by name within the work; verify book.chapter locus.'),
 'apollodorus':dict(file='apollod.txt',sid='SRC_APOLLODORUS_LIBRARY',wt='Pseudo-Apollodorus, Library',tr='J. G. Frazer',yr=1921,url='https://archive.org/details/library00athegoog',clean='ocr',
   orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0021',reason='Source is an OCR scan, located by name; verify wording and exact chapter.section against a clean edition.'),
}
key=sys.argv[1]; c=CONFIGS[key]
raw=open('/tmp/'+c['file'],encoding='utf-8').read()
# strip gutenberg boilerplate
if '*** START OF' in raw:
    raw=raw.split('*** START OF',1)[1].split('***',1)[-1]
if '*** END OF' in raw:
    raw=raw.split('*** END OF',1)[0]
import unicodedata as _ud
def _dia(x): return ''.join(c for c in _ud.normalize('NFKD',x) if not _ud.combining(c))
def clean(t):
    t=_dia(t)
    t=re.sub(r'\[\d+[a-z]?\]','',t)
    if c['clean']=='ocr': t=t.replace(' ;',';').replace(' ,',',').replace(' .','.')
    t=re.sub(r'\s+',' ',t).strip().replace('’',"'").replace('“','"').replace('”','"').replace('—','-').replace('æ','ae').replace('Æ','Ae')
    return t
full=clean(raw)
def kw(s): return set(w.lower() for w in re.findall(r'[A-Za-z]{4,}',s))-STOP
_APP=re.compile(r'\bcompare\b|\bcf\.|\bsqq|\bibid|\bop\. cit|\d(st|nd|rd|th) ed\.|\bpara\.?\s*\d|this fact is clearly seen|disconnected allusion|the name for .* in .* was|in middle persian|in the (greek|latin) (text|version)|\bfootnote|\btransl(ator|ation) |\bviz\.|\bff\.|\bvol\.\s*\d|see (also |the )?(para|p\.|note|chap|above|below)|\bpp\.\s*\d|manuscript reads|\beditor',re.I)
_GARB=re.compile(r'file:///|,\s*,|„|\|\s*\||\d+,\s*\d+,\s*\d+|Contents of|VOL\.|seqq|\bBd\.\s*\d|&[a-zA-Z];|\biae|\biea |Myths \d|\bnn?\.\b|\d{3,}\s+\d{2,}')
def _garbage(seg):
    if _GARB.search(seg): return True
    a=sum(ch.isalpha() or ch.isspace() for ch in seg)/max(1,len(seg))
    d=sum(ch.isdigit() for ch in seg)/max(1,len(seg))
    return a<0.80 or d>0.06
def _excerpt(i):
    s=full.rfind('. ',0,i); s=0 if s<0 else s+2
    if i-s>180: s=max(0,i-90)
    seg=full[s:s+460]; cut=seg.rfind('. ')
    if cut>170: seg=seg[:cut+1]
    return seg.strip()
def anchor(name,note,aliases=None):
    nm=re.sub(r'\s*\(.*?\)','',name).strip()
    words=[w for w in re.findall(r'[A-Za-z]{5,}',nm)]
    extra=[]
    for a in (aliases or []):
        a=a.strip()
        if len(a)>=5: extra.append(a)
        extra+=[w for w in re.findall(r'[A-Za-z]{5,}',a)]
    seen=set();cands=[]
    for c in ([nm] if len(nm)>=5 else [])+sorted(words,key=len,reverse=True)+extra:
        if c and c not in seen: seen.add(c);cands.append(c)
    notek=kw(note)
    scored=[]
    for cand in cands:
        occ=[m.start() for m in re.finditer(re.escape(cand),full)][:120]
        if not occ: continue
        for i in occ:
            scored.append((len(kw(full[max(0,i-160):i+260])&notek), i))
        break
    if not scored: return None
    for score,i in sorted(scored,key=lambda x:-x[0]):
        seg=_excerpt(i)
        if not _APP.search(seg) and not _garbage(seg): return seg   # skip apparatus + OCR garbage
    return None
def esc(s): return s.replace("'","''")
rows=[];deferred=[]
for line in open('/tmp/cohort_%s.tsv'%key,encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    p=line.split('\t'); eid,name,note=p[0],p[1],(p[2] if len(p)>2 else ''); aliases=(p[3].split('|') if len(p)>3 else [])
    q=anchor(name,note,aliases)
    nmbase=re.sub(r'\s*\(.*?\)','',name).strip()
    if not q or q not in full or len(q)<40 or not any(w.lower() in q.lower() for w in (re.findall(r'[A-Za-z]{4,}',nmbase)+[a for a in aliases if len(a)>=4])):
        deferred.append(eid);continue
    locm=re.search(r'[A-Z][[:alpha:]]*\.?\s?\d[\d.:,-]*',note) if False else re.search(r'([A-Z][A-Za-z]+\.? \d[\d.:,-]*)',note)
    loc=locm.group(1) if locm else c['wt']
    rows.append((eid,name,loc,q))
orig=c.get('orig')
with open('/tmp/build_%s_citations.sql'%key,'w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,loc,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_'+key.upper()[:6])[:60]
        vals.append("('%s','%s','%s','%s','%s','%s','%s',%d,'%s',%s,'primary-verbatim',NULL,true,'%s',DATE '2026-06-18','name-anchored (note-keyword scored) + substring gate; locus per attestation',1)"%(
          esc(cid),esc(eid),c['sid'],esc(c['wt']),esc(loc),esc(q),esc(c['tr']),c['yr'],c['url'],("'%s'"%esc(orig) if orig else 'NULL'),esc(c['reason'])))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,verify_method=EXCLUDED.verify_method;\n")
print("%s: %d citations, %d deferred"%(key,len(rows),len(deferred)))
