import re
def clean(t):
    t=re.sub(r'\(\d+\)','',t); t=re.sub(r'\[[^\]]*\]','',t)
    t=re.sub(r'\s+',' ',t).strip().replace('’',"'").replace('“','"').replace('”','"').replace('--','-').replace('AE','Ae')
    return t
full=clean(open('/tmp/ir1.txt',encoding='utf-8').read()+' '+open('/tmp/ir2.txt',encoding='utf-8').read()+' '+open('/tmp/ir3.txt',encoding='utf-8').read())
def window(text,name,cap=430):
    nm=re.sub(r'\s*\(.*?\)','',name).strip().replace('AE','Ae')
    cands=[nm]+re.findall(r'[A-Z][a-z]{4,}',nm)
    idx=-1
    for c in cands:
        if len(c)<4: continue
        for m in re.finditer(re.escape(c),text):
            idx=m.start();break
        if idx>=0:break
    if idx<0: return None
    s=text.rfind('. ',0,idx); s=0 if s<0 else s+2
    seg=text[s:s+cap]; cut=seg.rfind('. ')
    if cut>140: seg=seg[:cut+1]
    return seg.strip()
def esc(s): return s.replace("'","''")
rows=[];deferred=[]
for line in open('/tmp/ir_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    eid,name,note=line.split('\t',2)
    lm=re.search(r'AH\s+[IVX]+\.\d+(?:\.\d+)?(?:-\d+)?',note) or re.search(r'[IVX]+\.\d+\.\d+',note)
    loc=lm.group(0) if lm else 'Against Heresies (Book I)'
    q=window(full,name)
    if not q or q not in full or len(q)<40: deferred.append((eid,name));continue
    rows.append((eid,name,loc,q))
with open('/tmp/build_iren_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,loc,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_IREN')[:60]
        vals.append("('%s','%s','SRC_IRENAEUS_AH','Irenaeus, Against Heresies','%s','%s','Roberts & Rambaut (Ante-Nicene Fathers, Vol. I)',1885,'https://en.wikisource.org/wiki/Ante-Nicene_Fathers/Volume_I/IRENAEUS/Against_Heresies:_Book_I',NULL,'heresiological-verbatim','HOSTILE WITNESS: Irenaeus reports the Valentinian system in order to refute it; not a self-description.',true,'Located by name within Against Heresies; confirm the exact chapter.section locus cited.',DATE '2026-06-18','name-anchored within the work + substring gate (Ante-Nicene Fathers text); section locus per attestation',1)"%(
          esc(cid),esc(eid),esc(loc),esc(q)))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,needs_review=EXCLUDED.needs_review,review_reason=EXCLUDED.review_reason,verify_method=EXCLUDED.verify_method;\n")
print("irenaeus citations:",len(rows),"| deferred:",len(deferred))
for d in deferred[:10]: print("  defer",d)
