import re,sys
def rom(s):
    s=s.upper(); m={'M':1000,'D':500,'C':100,'L':50,'X':10,'V':5,'I':1};v=0;p=0
    for c in reversed(s):
        if c not in m: return None
        x=m[c]; v+=-x if x<p else x; p=max(p,x)
    return v
WORD={'FIRST':1,'SECOND':2,'THIRD':3,'FOURTH':4,'FIFTH':5,'SIXTH':6,'SEVENTH':7,'EIGHTH':8,'NINTH':9,'TENTH':10,'ELEVENTH':11,'TWELFTH':12,'THIRTEENTH':13,'FOURTEENTH':14,'FIFTEENTH':15}
def clean(t,ocr=False):
    t=re.sub(r'\[\d+[a-z]?\]','',t); t=re.sub(r'\{\d+\}','',t)
    t=t.replace('“','"').replace('”','"').replace('’',"'").replace('‘',"'").replace('—','-').replace('æ','ae').replace('Æ','Ae')
    if ocr: t=t.replace(' ;',';').replace(' ,',',')
    t=re.sub(r'\s+',' ',t).strip()
    return t
def load(files): return '\n@@@\n'.join(open(f,encoding='utf-8').read() for f in files)
def build_books(raw,book_re,kind):
    hs=list(re.finditer(book_re,raw,re.M)); books={}
    for i,m in enumerate(hs):
        g=m.group(1)
        k=rom(g) if kind=='roman' else (WORD.get(g.upper()) if kind=='word' else int(g))
        if not k: continue
        end=hs[i+1].start() if i+1<len(hs) else len(raw)
        blk=raw[m.end():end]
        if k not in books or len(blk)>len(books[k]): books[k]=blk   # body block beats TOC stub
    return {k:clean(v) for k,v in books.items()}
def window(text,name,cap=430):
    base=re.sub(r'\s*\(.*?\)','',name).strip()
    cands=[base]+ ([base.split()[0]] if base.split() else []) + re.findall(r'[A-Z][a-z]{4,}',name)
    idx=-1
    for c in cands:
        if len(c)<3: continue
        idx=text.find(c)
        if idx>=0: break
    if idx<0: return None
    s=text.rfind('. ',0,idx); s=0 if s<0 else s+2
    seg=text[s:s+cap]; cut=seg.rfind('. ')
    if cut>140: seg=seg[:cut+1]
    return seg.strip()
def esc(s): return s.replace("'","''")

WORKS=sys.argv[1]
cfgs={
 'apollod':dict(tsv='apollod_cohort.tsv',files=['apollod.txt'],ocr=True,book_re=r'BOOK ([IVX]+)\b',kind='roman',
    lbook=r'(\d+)\.\d+',sid='SRC_APOLLODORUS_LIBRARY',wt='Pseudo-Apollodorus, Library',tr='J. G. Frazer',yr=1921,
    surl='https://archive.org/details/library00athegoog',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0021',
    flag=True,reason='Source is an OCR scan and the passage was auto-located within the cited Book by name-match; verify wording and exact chapter.section against a clean edition.'),
 'homer':dict(tsv='homer_cohort.tsv',files=None,ocr=False,book_re=r'(?m)^\s*BOOK ([IVXL]+)\.',kind='roman',
    lbook=r'(?:Iliad|Odyssey)\s+([IVXL]+|\d+)',sid='SRC_HOMER_ILIAD_ODYSSEY',wt='Homer',tr='Samuel Butler',yr=1898,
    surl='https://www.gutenberg.org/ebooks/2199',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0133',
    flag=True,reason='English prose translation auto-located within the cited Book by name-match; the locus is the Greek line-numbering — consult the original (linked).'),
 'ovidm':dict(tsv='ovidm_cohort.tsv',files=['ovid1.txt','ovid2.txt'],ocr=False,book_re=r'BOOK THE (\w+)\.',kind='word',
    lbook=r'(?:Metamorphoses|Met\.?)\s+(\d+)',sid='SRC_OVID_METAMORPHOSES',wt='Ovid, Metamorphoses',tr='Henry T. Riley',yr=1851,
    surl='https://www.gutenberg.org/ebooks/21765',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.02.0029',
    flag=True,reason='English translation auto-located within the cited Book by name-match; the locus is the Latin line-numbering — consult the original (linked).'),
 'ovidf':dict(tsv='ovidf_cohort.tsv',files=['fasti.txt'],ocr=False,book_re=r'BOOK THE (\w+)\.',kind='word',
    lbook=r'Fasti\s+(\d+)',sid='SRC_OVID_FASTI',wt='Ovid, Fasti',tr='Henry T. Riley',yr=1851,
    surl='https://www.gutenberg.org/ebooks/8738',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.02.0547',
    flag=True,reason='English translation auto-located within the cited Book by name-match; the locus is the Latin line-numbering — consult the original (linked).'),
 'virgil':dict(tsv='virgil_cohort.tsv',files=['aeneid.txt'],ocr=False,book_re=r'(?m)^\s*BOOK ([IVXL]+)\b',kind='roman',
    lbook=r'(?:Aeneid|Aen\.?)\s+([IVXL]+|\d+)',sid='SRC_VIRGIL_AENEID',wt='Virgil, Aeneid',tr='John Dryden',yr=1697,
    surl='https://www.gutenberg.org/ebooks/228',orig='https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.02.0055',
    flag=True,reason='English verse translation auto-located within the cited Book by name-match; the locus is the Latin line-numbering — consult the original (linked).'),
}
c=cfgs[WORKS]
out=open('/tmp/build_%s_citations.sql'%WORKS,'w',encoding='utf-8')
rows=[];deferred=[]
# homer needs two texts routed by note
if WORKS=='homer':
    il=build_books(open('iliad.txt',encoding='utf-8').read(),c['book_re'],'roman')
    od=build_books(open('odyssey.txt',encoding='utf-8').read(),c['book_re'],'roman')
    full_il=clean(open('iliad.txt',encoding='utf-8').read()); full_od=clean(open('odyssey.txt',encoding='utf-8').read())
else:
    raw=load(c['files']); books=build_books(raw,c['book_re'],c['kind']); full=clean(raw)

for line in open('/tmp/'+c['tsv'],encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    eid,name,note=line.split('\t',2)
    m=re.search(c['lbook'],note)
    if not m: deferred.append((eid,'nobook'));continue
    g=m.group(1); bk=rom(g) if not g.isdigit() else int(g)
    if WORKS=='homer':
        bm=(od,full_od,'Odyssey') if 'odyssey' in note.lower() else (il,full_il,'Iliad')
        bks,full,wlabel=bm
    else:
        bks=books; wlabel=c['wt']
    located='book'
    q=window(bks[bk],name) if (bk and bk in bks) else None
    if not q:
        q=window(full,name); located='work'
    if not q or q not in full or len(q)<40: deferred.append((eid,'noanchor'));continue
    locustok=(note[m.start():m.start()+40] if m else (wlabel+' (locus per attestation)')).split(':')[0].split('(')[0].strip().rstrip('.,;')
    rows.append((eid,name,wlabel,locustok,q,located))
out.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
vals=[]
for eid,name,wlabel,loc,q,located in rows:
    cid=('CIT_'+eid.replace('ENT_','')+'_'+WORKS.upper())[:60]
    vals.append("('%s','%s','%s','%s','%s','%s','%s',%d,'%s','%s','primary-verbatim',NULL,true,'%s',DATE '2026-06-17','quote is a verbatim substring of the PD text; located within the cited book by name-anchor + substring gate',1)"%(
      esc(cid),esc(eid),c['sid'],esc(wlabel),esc(loc),esc(q),esc(c['tr']),c['yr'],c['surl'],c['orig'],esc(c['reason']+(' [book unresolved; located in full work]' if located=='work' else ''))))
out.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,needs_review=EXCLUDED.needs_review,review_reason=EXCLUDED.review_reason,original_text_url=EXCLUDED.original_text_url,verify_method=EXCLUDED.verify_method;\n")
out.close()
print("%s: citations=%d deferred=%d"%(WORKS,len(rows),len(deferred)))
