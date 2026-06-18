import re
raw=open('/tmp/gut348.txt',encoding='utf-8').read(); L=raw.split('\n')
def body_idx(t):
    ix=[i for i,l in enumerate(L) if l.strip()==t]; return ix[-1]
seg='\n'.join(L[body_idx('THE HOMERIC HYMNS'):])
seg=seg.split('*** END')[0]

def clean(t):
    t=re.sub(r'\s+',' ',t).strip()
    t=t.replace('“','"').replace('”','"').replace('’',"'").replace('‘',"'").replace('—','-')
    t=re.sub(r'\b\d{3,}\b','',t); t=re.sub(r'\s+([,.;])',r'\1',t); t=re.sub(r'\s+',' ',t).strip()
    return t
seg_clean=clean(seg)

ROM={'I':1,'II':2,'III':3,'IV':4,'V':5,'VI':6,'VII':7,'VIII':8,'IX':9,'X':10,'XI':11,'XII':12,'XIII':13,'XIV':14,'XV':15,'XVI':16,'XVII':17,'XVIII':18,'XIX':19,'XX':20,'XXI':21,'XXII':22,'XXIII':23,'XXIV':24,'XXV':25,'XXVI':26,'XXVII':27,'XXVIII':28,'XXIX':29,'XXX':30,'XXXI':31,'XXXII':32,'XXXIII':33}
NAME={'aphrodite':5,'pan':19,'demeter':2,'apollo':3,'hermes':4,'dionysus':1,'gaia':30,'earth':30,'asclepius':16,'heracles':15,'dioscuri':33,'helios':31,'selene':32,'ares':8,'athena':11,'artemis':9}
# split into hymns by header lines like "II. TO DEMETER 2502"
hdr=re.compile(r'^([IVXL]+)\.\s+TO\s+(.+?)\s*\d*$',re.M)
marks=[(m.start(),ROM.get(m.group(1)),m.group(2).strip()) for m in hdr.finditer(seg)]
hymns={}
for i,(pos,num,title) in enumerate(marks):
    if not num: continue
    endp=marks[i+1][0] if i+1<len(marks) else len(seg)
    body=seg[pos:endp]
    blocks=[]
    p=re.split(r'\(ll\.\s*(\d+)\s*[-–]\s*(\d+)\)',body)
    for j in range(1,len(p),3):
        a,b,tx=int(p[j]),int(p[j+1]),clean(p[j+2])
        if tx: blocks.append((a,b,tx))
    hymns[num]=blocks

def excerpt(t,cap=460):
    if len(t)<=cap: return t
    c=t.rfind('. ',0,cap); 
    if c<120: c=t.rfind(' ',0,cap)
    return t[:c+1].strip()
def sqlesc(s): return s.replace("'","''")

rows=[];deferred=[]
for line in open('/tmp/hymns_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    eid,name,note=line.split('\t',2)
    num=None
    m=re.search(r'(?:HH|Homeric Hymn|Hymn)\s+(\d+)',note)
    if m: num=int(m.group(1))
    if not num:
        for nm,n in NAME.items():
            if re.search(r'[Hh]ymn (?:to )?'+nm,note,re.I) or ('to '+nm) in note.lower(): num=n;break
    if not num or num not in hymns or not hymns[num]: deferred.append((eid,'no-hymn'));continue
    lm=re.search(r'\b(\d+)\s*[-–]\s*\d+',note) or re.search(r'\b(\d+)\b',re.sub(r'(?:HH|Hymn|Homeric Hymn)\s+\d+','',note))
    blocks=hymns[num]; chosen=None
    if lm:
        ln=int(lm.group(1))
        for a,b,t in blocks:
            if a<=ln<=b: chosen=(a,b,t);break
    if not chosen: chosen=blocks[0]
    a,b,t=chosen; q=excerpt(t)
    if q not in seg_clean: deferred.append((eid,'verbatim'));continue
    rows.append((eid,name,num,a,b,q))

with open('/tmp/build_hymns_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,num,a,b,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_HH')[:60]
        vals.append("('%s','%s','SRC_HOMERIC_HYMNS','Homeric Hymn %d','lines %d-%d','%s','Hugh G. Evelyn-White',1914,'https://www.gutenberg.org/ebooks/348','primary-verbatim',NULL,DATE '2026-06-17','deterministic verbatim extraction + substring gate (Gutenberg #348)',1)"%(sqlesc(cid),sqlesc(eid),num,a,b,sqlesc(q)))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,work_title=EXCLUDED.work_title,verify_method=EXCLUDED.verify_method;\n")
print("hymns parsed:",len(hymns),"| citations:",len(rows),"| deferred:",len(deferred))
for d in deferred: print("  defer",d)
