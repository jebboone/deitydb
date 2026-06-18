import re,sys,unicodedata
# Avestan/Zoroastrian canonical -> variant forms found in PD texts (Kanga/Darmesteter/Bundahishn)
ZMAP={
 'asha vahishta':['Ardibehesht','Asha','Asha Vahishta','Ardwahisht'],'vohu manah':['Bahman','Vohu Manah','Vohuman'],
 'khshathra vairya':['Shahrevar','Khshathra','Kshathra'],'spenta armaiti':['Spendarmad','Armaiti','Spenta Armaiti','Spendármad'],
 'haurvatat':['Haurvatat','Khordad','Haurvatat','Haurvat'],'ameretat':['Ameretat','Amardad','Amerodad','Ameretât'],
 'verethragna':['Behram','Verethraghna','Bahram','Verethragna'],'tishtrya':['Tishtar','Tir','Tishtrya','Tistrya'],
 'rashnu':['Rashne','Rashnu','Rashn'],'sraosha':['Srosh','Sraosha','Seraosha'],'ashi':['Ashishvangh','Ashi','Ard'],
 'daena':['Din','Daena','Dén'],'chista':['Chisti','Chista','Cheesti'],'atar':['Atar','Adar','Atash'],
 'vayu':['Vayu','Ram','Vai'],'mah':['Mah','Mohor','Mah Bokhtar'],'anahita':['Anahita','Ardvisura','Aredvi','Aban','Ardevisur'],
 'mithra':['Mithra','Meher','Mihr'],'apam napat':['Apam Napat','Burj','Apãm Napât'],'geush urvan':['Geush Urvan','Gosh','Drvaspa'],
 'khvarenah':['Khvarenah','Farr','Khwarrah','Glory'],'nairyosangha':['Nairyosangha','Neryosang'],'saoshyant':['Saoshyant','Soshyant','Saoshyans'],
 'aka manah':['Aka Manah','Akoman','Akem Manah'],'aeshma':['Aeshma','Eshm','Khashm'],'astovidatu':['Astovidatu','Asto-vidotu','Astwihad'],
 'nasu':['Nasu','Nasush','Druj Nasu'],'druj':['Druj','Drug','Druje'],'yima':['Yima','Jamshid','Jam'],'zarathustra':['Zarathushtra','Zoroaster','Zartusht'],
}
GMAP={'yaldabaoth':['Ialdabaoth','Jaldabaoth','Ialdabaoth'],'samael':['Sammael'],'saklas':['Sakla'],'sabaoth':['Sabaoth'],'barbelo':['Barbelo'],'authades':['Authades','Self-willed'],'jeu':['Jeu','Ieou'],'abraxas':['Abrasax'],'yao':['Iao','Jao'],'archon':['ruler','rulers']}
SUMMAP={'inanna':['Inana'],'ninhursaga':['Ninhursaja','Ninhursag','Nintur','Ninmah','Ninmena'],'dumuzi':['Dumuzid'],'ereshkigal':['Erec-ki-gala','Ereshkigala'],'ningishzida':['Ninjiczida','Ningiczida'],'gilgamesh':['Bilgames','Gilgamec'],'ninlil':['Ninlil'],'nergal':['Nergal'],'geshtinanna':['Jectin-ana','Gestinanna'],'ningal':['Ningal'],'nintu':['Nintur'],'damgalnuna':['Damgalnuna','Damkina'],'nanshe':['Nance','Nanshe'],'ninisina':['Nin-Isina','Nininsina']}
KMAP={'arikh anpin':['Macroprosopus','Arik Anpin','Long Face','Ancient of Days'],'zeir anpin':['Microprosopus','Lesser Countenance','Short Face'],'macroprosopus':['Arikh Anpin','Arik Anpin'],'microprosopus':['Zeir Anpin'],'atika kadisha':['Ancient Holy One','Ancient of Days','Atika'],'chokmah':['Wisdom','Hokhmah','Chokhmah'],'binah':['Understanding'],'kether':['Crown','Keter'],'chesed':['Mercy','Gedulah'],'geburah':['Severity','Gevurah','Pachad'],'tiphereth':['Beauty','Tiferet'],'yesod':['Foundation'],'malkuth':['Kingdom','Malkhut','Shekinah'],'shekinah':['Shekhinah','Matronit']}
def strip(s): return ''.join(c for c in unicodedata.normalize('NFKD',s) if not unicodedata.combining(c))
def variants(name):
    base=re.sub(r'\s*\(.*?\)','',name).strip()
    out=set()
    nd=strip(base); out.add(nd)
    for s in {base,nd}:
        t=(s.replace('þ','th').replace('Þ','Th').replace('ð','d').replace('Ð','D').replace('ø','o').replace('Ø','O')
            .replace('æ','ae').replace('Æ','Ae').replace('ǫ','o').replace('œ','oe').replace('ʿ','').replace('ʾ',''))
        out.add(t); out.add(t.replace('d','th'))
    more=set()
    for w in out:
        more.add(re.sub(r'rr$','',w)); more.add(re.sub(r'r$','',w))  # ON nominative -r/-rr
    out|=more
    # per-word significant tokens (>=4)
    for w in list(out):
        for tok in re.findall(r"[A-Za-z]{4,}",w): out.add(tok)
    z=ZMAP.get(base.lower(),[])+GMAP.get(base.lower(),[])+SUMMAP.get(base.lower(),[])+KMAP.get(base.lower(),[])
    out|=set(z)
    out.discard(base)
    return sorted(x for x in out if len(x)>=4)

inf=sys.argv[1]
lines=open(inf,encoding='utf-8').read().split('\n')
out=[]
for line in lines:
    if not line.strip(): out.append(line); continue
    p=line.split('\t')
    eid=p[0]; name=p[1] if len(p)>1 else ''; note=p[2] if len(p)>2 else ''
    existing=(p[3] if len(p)>3 else '')
    al=variants(name)
    merged='|'.join([a for a in al if a]+([existing] if existing.strip('|') else []))
    out.append('\t'.join([eid,name,note,merged]))
open(inf,'w',encoding='utf-8').write('\n'.join(out))
print(inf,"enriched; sample aliases:",variants(lines[0].split('\t')[1]) if lines and '\t' in lines[0] else '')
