import re

raw = open('/tmp/gut348.txt', encoding='utf-8').read()
lines = raw.split('\n')
def body_idx(t): 
    idxs=[i for i,l in enumerate(lines) if l.strip()==t]; return idxs[-1]
theog='\n'.join(lines[body_idx('THE THEOGONY'):body_idx('THE SHIELD OF HERACLES')])

def clean(t):
    t=re.sub(r'\s+',' ',t).strip()
    t=t.replace('“','"').replace('”','"').replace('’',"'").replace('‘',"'").replace('—','-')
    t=re.sub(r'\b\d{3,}\b','',t)        # strip Gutenberg footnote-anchor numbers
    t=re.sub(r'\s+([,.;])',r'\1',t)     # tidy space-before-punct left by stripping
    t=re.sub(r'\s+',' ',t).strip()
    return t

theog_clean=clean(theog)

parts=re.split(r'\(ll\.\s*(\d+)\s*[-–]\s*(\d+)\)', theog)
blocks=[]
for i in range(1,len(parts),3):
    a,b,txt=int(parts[i]),int(parts[i+1]),clean(parts[i+2])
    if txt: blocks.append((a,b,txt))

def find_block(n):
    for a,b,t in blocks:
        if a<=n<=b: return (a,b,t)
    best=None
    for a,b,t in blocks:
        d=min(abs(n-a),abs(n-b))
        if best is None or d<best[0]: best=(d,a,b,t)
    return best[1:]

def excerpt(t,cap=460):
    if len(t)<=cap: return t
    cut=t.rfind('. ',0,cap)
    if cut<120: cut=t.rfind(' ',0,cap)
    return t[:cut+1].strip()

def sqlesc(s): return s.replace("'","''")

rows=[]; misses=[]; badverbatim=[]
for line in open('/tmp/theog_cohort.tsv', encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip(): continue
    eid,name,note=line.split('\t',2)
    m=re.search(r'Theogony[^0-9]*(\d+)',note)
    if not m: misses.append((eid,'no-locus')); continue
    a,b,t=find_block(int(m.group(1)))
    q=excerpt(t)
    if q not in theog_clean:           # DETERMINISTIC VERBATIM GATE
        badverbatim.append(eid); continue
    rows.append((eid,name,a,b,q))

with open('/tmp/build_theog_citations.sql','w',encoding='utf-8') as f:
    f.write("-- Hesiod Theogony cohort: deterministic verbatim citations from Gutenberg #348 (Evelyn-White 1914)\n")
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,name,a,b,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_THEOG')[:60]
        vals.append("('%s','%s','SRC_HESIOD_THEOGONY','Hesiod, Theogony','lines %d-%d','%s','Hugh G. Evelyn-White',1914,'https://www.gutenberg.org/ebooks/348','primary-verbatim',NULL,DATE '2026-06-17','deterministic verbatim extraction + substring gate (Gutenberg #348, line-numbered)',1)"%(sqlesc(cid),sqlesc(eid),a,b,sqlesc(q)))
    f.write(',\n'.join(vals))
    f.write("\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,work_title=EXCLUDED.work_title,source_url=EXCLUDED.source_url,verify_method=EXCLUDED.verify_method;\n")

print("blocks:",len(blocks),"| citations:",len(rows),"| misses:",len(misses),"| verbatim-rejects:",len(badverbatim))
print("ALL quotes pass verbatim substring gate:", len(badverbatim)==0)
