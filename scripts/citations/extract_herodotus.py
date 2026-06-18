import re
ROM={'I':1,'II':2,'III':3,'IV':4,'V':5,'VI':6,'VII':7,'VIII':8,'IX':9}
def load(fn): return open(fn,encoding='utf-8').read()
txt=load('/tmp/hdt1.txt')+'\n'+load('/tmp/hdt2.txt')

def clean(t):
    t=re.sub(r'\[\d+[a-z]?\]','',t)        # footnote markers [131]
    t=re.sub(r'\{\d+\}','',t)
    t=re.sub(r'\s+',' ',t).strip()
    t=t.replace('“','"').replace('”','"').replace('’',"'").replace('‘',"'").replace('—','-')
    return t

# split into books
bm=list(re.finditer(r'BOOK ([IVX]+)\. THE \w+ BOOK OF THE HISTORIES', txt))
books={}
for i,m in enumerate(bm):
    num=ROM.get(m.group(1)); 
    if not num: continue
    end=bm[i+1].start() if i+1<len(bm) else len(txt)
    body=txt[m.end():end]
    # chapters: lines starting with "N. "
    chaps={}
    cm=list(re.finditer(r'(?m)^(\d+)\.\s', body))
    for j,c in enumerate(cm):
        cn=int(c.group(1)); ce=cm[j+1].start() if j+1<len(cm) else len(body)
        chaps[cn]=clean(body[c.start():ce])
    books[num]=chaps

full_clean=clean(txt)
def excerpt(t,cap=460):
    t=re.sub(r'^\d+\.\s*','',t)  # drop leading chapter number
    if len(t)<=cap: return t
    c=t.rfind('. ',0,cap)
    if c<120: c=t.rfind(' ',0,cap)
    return t[:c+1].strip()
def sqlesc(s): return s.replace("'","''")

rows=[];deferred=[]
for line in open('/tmp/hdt_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    eid,name,note=line.split('\t',2)
    # parse book.chapter: arabic "3.8" or roman "IV.93"
    m=re.search(r'\b([1-9])\.(\d+)',note)
    bk=ch=None
    if m: bk,ch=int(m.group(1)),int(m.group(2))
    else:
        rm=re.search(r'\b([IVX]+)\.(\d+)',note)
        if rm and rm.group(1) in ROM: bk,ch=ROM[rm.group(1)],int(rm.group(2))
    if not bk or bk not in books or ch not in books[bk]: deferred.append((eid,note[:40]));continue
    q=excerpt(books[bk][ch])
    if q not in full_clean: deferred.append((eid,'verbatim'));continue
    rows.append((eid,name,bk,ch,q))

with open('/tmp/build_hdt_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,bk,ch,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_HDT')[:60]
        vals.append("('%s','%s','SRC_HERODOTUS_HISTORIES','Herodotus, Histories','Book %d.%d','%s','G. C. Macaulay',1890,'https://www.gutenberg.org/ebooks/2707','primary-verbatim','Herodotus reports foreign cults via Greek interpretatio (a Greek observer, not an insider source).',DATE '2026-06-17','deterministic verbatim extraction by book.chapter + substring gate (Gutenberg #2707/#2456)',1)"%(sqlesc(cid),sqlesc(eid),bk,ch,sqlesc(q)))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,verify_method=EXCLUDED.verify_method;\n")
print("books:",sorted(books),"| citations:",len(rows),"| deferred:",len(deferred))
for d in deferred: print("  defer",d)
