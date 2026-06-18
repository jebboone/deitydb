import re,collections
exec(open('/tmp/extract_bible.py').read().split('NAMES=sorted')[0])
NAMES=sorted(CANON,key=lambda s:-len(s))
OT=set(CANON[:39]); NT=set(CANON[39:])
STOP=set('the a an of and to in is on at by for with from as his her their who that this god lord son daughter king was were are be name named also son'.split())
def kw(s): return set(w.lower() for w in re.findall(r'[A-Za-z]{4,}',s))-STOP
def find_book(note):
    for nm in NAMES:
        m=re.search(r'(?<![A-Za-z])'+re.escape(nm)+r'(?:\s+(\d+))?',note)
        if m: return nm,(int(m.group(1)) if m.group(1) else None)
    return None,None
def best_verse(scope, name, notek):
    nm=re.sub(r'\s*\(.*?\)','',name).strip()
    cands=[nm]+[w for w in re.findall(r'[A-Za-z]{4,}',nm) if len(w)>3]
    best=None
    for c in cands:
        occ=[m.start() for m in re.finditer(r'(?<![A-Za-z])'+re.escape(c),scope)][:80]
        if not occ: continue
        for i in occ:
            vm=None
            for mm in re.finditer(r'(?<![\d:])(\d+):(\d+) ',scope[max(0,i-600):i]): vm=mm
            if not vm: continue
            base=max(0,i-600)
            ch,vs=vm.group(1),vm.group(2)
            nxt=re.search(r'(?<![\d:])\d+:\d+ ',scope[base+vm.end():])
            seg=scope[base+vm.start(): base+vm.end()+(nxt.start() if nxt else 300)]
            seg=re.sub(r'^\d+:\d+ ','',clean(seg))[:400]
            if c not in seg and nm not in seg: continue
            sc=len(kw(seg)&notek)
            if best is None or sc>best[0]: best=(sc,int(ch),int(vs),seg)
        if best: break
    return best
def esc(s): return s.replace("'","''")
ORIG={'SRC_HEBREW_BIBLE':'https://www.sefaria.org/texts/Tanakh','SRC_NEW_TESTAMENT':'https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0155'}
rows=[];deferred=[]
for line in open('/tmp/bible2_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    p=line.split('\t'); eid,sid,name,note=p[0],p[1],p[2],(p[3] if len(p)>3 else '')
    notek=kw(note)
    bk,ch=find_book(note)
    chosen=None
    if bk and bk in booktext:
        scope=booktext[bk]
        if ch is not None:
            cm=re.search(r'(?<![\d:])%d:1 '%ch,scope)
            if cm:
                nc=re.search(r'(?<![\d:])%d:1 '%(ch+1),scope[cm.end():]); scope=scope[cm.start(): cm.end()+(nc.start() if nc else 4000)]
        bv=best_verse(scope,name,notek)
        if bv: chosen=(bk,bv[1],bv[2],bv[3])
    if not chosen:
        books=OT if sid=='SRC_HEBREW_BIBLE' else NT
        gb=None
        for b in books:
            if b not in booktext: continue
            bv=best_verse(booktext[b],name,notek)
            if bv and (gb is None or bv[0]>gb[0]): gb=(bv[0],b,bv[1],bv[2],bv[3])
        if gb and (gb[0]>0 or True): chosen=(gb[1],gb[2],gb[3],gb[4]) if gb else None
    if not chosen: deferred.append(eid);continue
    rows.append((eid,sid,name)+chosen)
with open('/tmp/build_bible2_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,sid,name,bk,ch,vs,seg in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_KJV')[:60]
        vals.append("('%s','%s','%s','The Bible (King James Version)','%s %d:%d','%s','King James Version',1611,'https://www.gutenberg.org/ebooks/10','%s','primary-verbatim','English (KJV); chapter:verse is translation-independent — consult the original (linked).',true,'Verse located by name (note-scored) within the Bible; confirm it is the intended attestation.',DATE '2026-06-18','name-anchored to enclosing verse + substring gate (Gutenberg #10 KJV)',1)"%(
          esc(cid),esc(eid),sid,esc(bk),ch,vs,esc(seg),ORIG.get(sid,'')))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,needs_review=EXCLUDED.needs_review,review_reason=EXCLUDED.review_reason,verify_method=EXCLUDED.verify_method;\n")
print("bible2 citations:",len(rows),"| deferred:",len(deferred))
