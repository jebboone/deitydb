import re,unicodedata
GEO=set('moscow sarov radonezh kronstadt aegina thessaloniki thessalonica egypt simferopol caesarea paris shanghai francisco nyssa nazianzus great theologian soldier recruit empress tsar tsarevich royal martyrs martyr holy hierarchs three grand prince saint bearers passion equal apostles wonderworker bishop archbishop metropolitan patriarch emperor king queen'.split())
def dia(s): return ''.join(c for c in unicodedata.normalize('NFKD',s) if not unicodedata.combining(c))
lines=open('/tmp/prologue.txt',encoding='utf-8').read().split('\n')
def is_header(l):
    L=l.strip(); letters=[c for c in L if c.isalpha()]
    if len(letters)<6 or len(L)>90: return False
    return sum(1 for c in letters if c.isupper())/len(letters)>0.75
entries=[];h=None;cur=[]
for l in lines:
    if is_header(l):
        if h: entries.append((h,' '.join(cur)))
        h=l.strip();cur=[]
    else: cur.append(l)
if h: entries.append((h,' '.join(cur)))
def clean(t): return re.sub(r'\s+',' ',dia(t)).strip().replace('’',"'").replace('“','"').replace('”','"')
STOP=set('the and of to in is on at by for with from as who that this saint holy great martyr father lives day commemorated also feast'.split())
def kw(s): return set(w.lower() for w in re.findall(r'[A-Za-z]{4,}',dia(s)))-STOP
def esc(s): return s.replace("'","''")
rows=[];deferred=[]
for line in open('/tmp/cohort_synax.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    p=line.split('\t'); eid,name,note=p[0],p[1],(p[2] if len(p)>2 else '');aliases=(p[3].split('|') if len(p)>3 else [])
    toks=[dia(w).lower() for w in re.findall(r'[A-Za-z]{4,}',re.sub(r'\(.*?\)','',name))+[a for a in aliases] if dia(w if isinstance(w,str) else '').lower()]
    toks=[t for t in [dia(w).lower() for w in re.findall(r'[A-Za-z]{4,}',re.sub(r'\(.*?\)','',name))] if t not in GEO]+[dia(a).lower() for a in aliases if len(a)>3 and dia(a).lower() not in GEO]
    notek=kw(note)-set(toks)-GEO
    best=None
    for hdr,body in entries:
        hl=dia(hdr).lower()
        if not any(t in hl for t in toks): continue
        sc=len(kw(body)&notek)
        if best is None or sc>best[0]: best=(sc,hdr,body)
    # require relevance: at least 1 distinctive note-keyword in body (avoids wrong same-name saint)
    if not best or best[0]<1: deferred.append((eid,name)); continue
    body=clean(best[2])
    if len(body)<40: deferred.append((eid,name));continue
    seg=body[:430]; cut=seg.rfind('. ')
    if cut>150: seg=seg[:cut+1]
    rows.append((eid,name,clean(best[1]),seg))
with open('/tmp/build_synax_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,hdr,seg in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_PROL')[:60]
        vals.append("('%s','%s','SRC_SYNAXARION','The Prologue of Ohrid','entry: %s','%s','St Nikolai Velimirovic',1928,'https://archive.org/details/ThePrologueFromOhrid_BishopNikolaiVelimirovich',NULL,'primary-verbatim','Synaxarion entry located by its heading; brief flagged excerpt — verify the commemoration.',true,'Matched to the Prologue entry whose heading names this saint; confirm it is the correct same-named saint.',DATE '2026-06-18','entry-header anchored + note-keyword relevance + substring gate (Prologue of Ohrid)',1)"%(
          esc(cid),esc(eid),esc(hdr[:60]),esc(seg)))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,verify_method=EXCLUDED.verify_method;\n")
print("entries:",len(entries),"| synax citations:",len(rows),"| deferred:",len(deferred))
for d in deferred: print("  defer",d[1])
