import re
raw=open('/tmp/ani.txt',encoding='utf-8').read()
def clean(t):
    t=re.sub(r'(?is)<ref[^>]*>.*?</ref>','',t); t=re.sub(r'<[^>]+>','',t)
    t=re.sub(r'\{\{[^{}]*\}\}','',t); t=re.sub(r'\{\{[^{}]*\}\}','',t)
    t=re.sub(r'\[\[(?:[^\]|]*\|)?([^\]]*)\]\]',r'\1',t)
    t=re.sub(r"'''?|=+|°",'',t)
    t=re.sub(r'\[\d+\]','',t)
    t=re.sub(r'\s+',' ',t).strip().replace('’',"'").replace('“','"').replace('”','"')
    return t
full=clean(raw)
def window(text,name,cap=420):
    nm=re.sub(r'\s*\(.*?\)','',name).strip()
    cands=[nm]+[w for w in re.split(r'[ \-]',nm) if len(w)>3]
    idx=-1
    for c in cands:
        m=re.search(re.escape(c),text)
        if m: idx=m.start();break
    if idx<0: return None
    s=text.rfind('. ',0,idx); s=0 if s<0 else s+2
    seg=text[s:s+cap]; cut=seg.rfind('. ')
    if cut>110: seg=seg[:cut+1]
    return seg.strip()
def esc(s): return s.replace("'","''")
rows=[];deferred=[]
for line in open('/tmp/budge_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    parts=line.split('\t')
    eid,name=parts[0],parts[1]
    q=window(full,name)
    if not q or q not in full or len(q)<35: deferred.append((eid,name));continue
    rows.append((eid,name,q))
with open('/tmp/build_budge_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_ANI')[:60]
        vals.append("('%s','%s','SRC_BUDGE_PAPYRUS_ANI','The Papyrus of Ani (Egyptian Book of the Dead)','%s (Papyrus of Ani)','%s','E. A. Wallis Budge',1913,'https://en.wikisource.org/wiki/The_Papyrus_of_Ani_(1913)',NULL,'primary-verbatim','Budge (1913) is a dated translation; consult a modern edition for philological precision.',false,NULL,DATE '2026-06-18','name-anchored extraction + substring gate (Wikisource Budge text)',1)"%(
          esc(cid),esc(eid),esc(name),esc(q)))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,verify_method=EXCLUDED.verify_method;\n")
print("budge citations:",len(rows),"| deferred:",len(deferred))
for d in deferred[:10]: print("  defer",d)
