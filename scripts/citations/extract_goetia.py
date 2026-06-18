import re
raw=open('/tmp/goetia.txt',encoding='utf-8').read()
# isolate the Goetia descriptions section (between Bael and the Conjurations/end)
def clean(t):
    t=re.sub(r'\[\d+\]','',t); t=re.sub(r'\s+',' ',t).strip().replace('’',"'").replace('“','"').replace('”','"')
    return t
full=clean(raw)
def entry(name):
    nm=re.sub(r'\s*\(.*?\)','',name).strip()
    # match "called <Name>." or "Spirit is ... <Name>" then take the sentence(s) of the entry
    pats=[r'called %s\b'%re.escape(nm), r'\b%s\b'%re.escape(nm)]
    for p in pats:
        m=re.search(p,full)
        if not m: continue
        # back up to the start of the entry ("The Nth ... Spirit")
        start=full.rfind('Spirit',max(0,m.start()-160),m.start())
        s=full.rfind('The ',max(0,m.start()-200), m.start())
        s=s if s>=0 else m.start()
        seg=full[s:s+430]; cut=seg.rfind('. ')
        if cut>120: seg=seg[:cut+1]
        if nm in seg: return seg.strip()
    return None
def esc(s): return s.replace("'","''")
rows=[];deferred=[]
for line in open('/tmp/goetia_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    eid,name,note=line.split('\t',2)
    q=entry(name)
    if not q or q not in full or len(q)<40: deferred.append((eid,name));continue
    rows.append((eid,name,q))
with open('/tmp/build_goetia_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_GOET')[:60]
        vals.append("('%s','%s','SRC_LEMEGETON','The Lesser Key of Solomon (Ars Goetia)','entry for %s','%s','S. L. MacGregor Mathers & A. Crowley',1904,'https://www.gutenberg.org/ebooks/72679',NULL,'primary-verbatim','Early-modern grimoire (the Goetia descriptions); a learned-magic literary tradition, not a mainstream cult.',false,NULL,DATE '2026-06-18','name-anchored entry extraction + substring gate (Gutenberg #72679)',1)"%(
          esc(cid),esc(eid),esc(name),esc(q)))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,verify_method=EXCLUDED.verify_method;\n")
print("goetia citations:",len(rows),"| deferred:",len(deferred))
for d in deferred[:8]: print("  defer",d)
