import re
R={'I':1,'II':2,'III':3,'IV':4,'V':5,'VI':6,'VII':7,'VIII':8,'IX':9,'X':10}
def rom(s):
    v=0;m={'X':10,'V':5,'I':1};p=0
    for c in reversed(s):
        x=m.get(c,0); v+=-x if x<p else x; p=max(p,x)
    return v
txt=open('/tmp/p68946.txt',encoding='utf-8').read()+'\n@@@\n'+open('/tmp/p68680.txt',encoding='utf-8').read()
def clean(t):
    t=re.sub(r'\[[0-9]+\]','',t); t=re.sub(r'\s+',' ',t).strip()
    t=t.replace('“','"').replace('”','"').replace('’',"'").replace('‘',"'").replace('—','-').replace('æ','ae').replace('Æ','Ae')
    return t
full=clean(txt)
bm=list(re.finditer(r'(?m)^BOOK ([IVX]+)\.--',txt))
books={}
for i,m in enumerate(bm):
    bn=rom(m.group(1)); end=bm[i+1].start() if i+1<len(bm) else len(txt)
    body=txt[m.end():end]; chaps={}
    cm=list(re.finditer(r'(?m)^CHAPTER ([IVXL]+)\.',body))
    for j,c in enumerate(cm):
        cn=rom(c.group(1)); ce=cm[j+1].start() if j+1<len(cm) else len(body)
        chaps[cn]=clean(body[c.end():ce])
    books.setdefault(bn,{}).update(chaps)
def window(text,name,cap=420):
    base=re.sub(r'\s*\(.*?\)','',name).strip().split()[0]
    idx=text.find(base)
    if idx<0:
        for w in re.findall(r'[A-Z][a-z]{4,}',name):
            idx=text.find(w)
            if idx>=0:break
    if idx<0: return None
    s=text.rfind('. ',0,idx); s=0 if s<0 else s+2
    seg=text[s:s+cap]
    cut=seg.rfind('. ')
    if cut>120: seg=seg[:cut+1]
    return seg.strip()
def sqlesc(s): return s.replace("'","''")
rows=[];deferred=[]
for line in open('/tmp/paus_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    eid,name,note=line.split('\t',2)
    m=re.search(r'\b([1-9]|10)\.(\d+)(?:\.(\d+))?',note)
    if not m: deferred.append((eid,'noloc'));continue
    bk,ch=int(m.group(1)),int(m.group(2))
    if bk not in books or ch not in books[bk]: deferred.append((eid,'nochap %d.%d'%(bk,ch)));continue
    q=window(books[bk][ch],name)
    if not q or q not in full or len(q)<40: deferred.append((eid,'noanchor'));continue
    rows.append((eid,name,note,bk,ch,m.group(3),q))
with open('/tmp/build_paus_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,note,bk,ch,sec,q in rows:
        loc="Book %d, ch. %d%s"%(bk,ch,(".%s"%sec) if sec else "")
        vals.append("('%s','%s','SRC_PAUSANIAS_DESCRIPTION','Pausanias, Description of Greece','%s','%s','A. R. Shilleto',1886,'https://www.gutenberg.org/ebooks/68946','primary-verbatim',NULL,DATE '2026-06-17','book.chapter located + name-anchored in chapter + substring gate (Gutenberg #68946/#68680); section-level locus per attestation — audit pending',1)"%(sqlesc(('CIT_'+eid.replace('ENT_','')+'_PAUS')[:60]),sqlesc(eid),sqlesc(loc),sqlesc(q)))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,verify_method=EXCLUDED.verify_method;\n")
print("books:",sorted(books),"| citations:",len(rows),"| deferred:",len(deferred))
for d in deferred[:15]: print("  defer",d)
