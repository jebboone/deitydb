import re
V={}
order=[]
for ln in open('/tmp/quran_tanzil.txt',encoding='utf-8'):
    parts=ln.rstrip('\n').split('|',2)
    if len(parts)==3 and parts[0].isdigit() and parts[1].isdigit():
        key=(int(parts[0]),int(parts[1])); V[key]=parts[2].strip(); order.append(key)
NAMEMAP={'ibrahim':'Abraham','musa':'Moses','dawud':'David','sulayman':'Solomon','ayyub':'Job','nuh':'Noah',
'isa':'Jesus','yusuf':'Joseph','harun':'Aaron','yahya':'John','zakariya':'Zachariah','ilyas':'Elijah',
'al-yasa':'Elisha','al yasa':'Elisha','yunus':'Jonah','lut':'Lot','ismail':'Ishmael','ismael':'Ishmael',
'ishaq':'Isaac','yaqub':'Jacob','maryam':'Mary','jibril':'Gabriel','dhul-kifl':'Dhul-Kifl','dhul kifl':'Dhul-Kifl',
'idris':'Idris','hud':'Hud','salih':'Salih',"shu'ayb":'Shu','adam':'Adam','iblis':'Iblis','harut':'Harut','marut':'Marut'}
STOP=set('the a an of and to in is on at by for with from as who that god lord allah surah quran throughout named prophet son'.split())
def kw(s): return set(w.lower() for w in re.findall(r'[A-Za-z]{4,}',s))-STOP
def anchor(name,note):
    nm=re.sub(r'\s*\(.*?\)','',name).strip(); base=nm.lower()
    cands=[]
    for k,v in NAMEMAP.items():
        if k in base: cands.append(v)
    cands+=[w for w in re.findall(r'[A-Za-z]{4,}',nm)]
    notek=kw(note); best=None
    for c in cands:
        hits=[k for k in order if re.search(r'\b'+re.escape(c)+r'\b',V[k])][:120]
        for k in hits:
            sc=len(kw(V[k])&notek)
            if best is None or sc>best[0]: best=(sc,k,c)
        if best: break
    return best
def esc(s): return s.replace("'","''")
rows=[];anc=[];deferred=[]
for line in open('/tmp/quran_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    p=line.split('\t'); eid,name,note=p[0],p[1],(p[2] if len(p)>2 else '')
    m=re.search(r'(\d{1,3}):(\d{1,3})',note)
    if m and (int(m.group(1)),int(m.group(2))) in V:
        su,ay=int(m.group(1)),int(m.group(2)); rows.append((eid,name,su,ay,V[(su,ay)][:430],False))
    else:
        b=anchor(name,note)
        if b: su,ay=b[1]; rows.append((eid,name,su,ay,V[(su,ay)][:430],True))
        else: deferred.append((eid,name))
with open('/tmp/build_quran2_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,su,ay,q,flag in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_QUR')[:60]
        nr='true' if flag else 'false'
        rr="'Verse located by name (no ayah in attestation); confirm it is the intended reference.'" if flag else 'NULL'
        vals.append("('%s','%s','SRC_QURAN','The Qur’an','Surah %d:%d','%s','Marmaduke Pickthall',1930,'https://tanzil.net/#%d:%d','https://quran.com/%d/%d','primary-verbatim','English (Pickthall); sura:ayah is translation-independent — consult the Arabic (linked).',%s,%s,DATE '2026-06-18','deterministic sura:ayah lookup, or name-anchored where no ayah given (Pickthall, Tanzil)',1)"%(
          esc(cid),esc(eid),su,ay,esc(q),su,ay,su,ay,nr,rr))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,needs_review=EXCLUDED.needs_review,review_reason=EXCLUDED.review_reason,verify_method=EXCLUDED.verify_method;\n")
print("citations:",len(rows),"(exact+anchored) | deferred:",len(deferred))
for d in deferred[:10]: print("  ",d)
