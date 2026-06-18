import re
lines=open('/tmp/kjv.txt',encoding='utf-8').read().split('\n')
# TOC headers in canonical order (drop the 2 section-title lines)
SKIP={'The Old Testament of the King James Version of the Bible','The New Testament of the King James Bible'}
toc=[]
for i in range(23,96):
    s=lines[i].strip()
    if s and s not in SKIP: toc.append(s)
CANON=["Genesis","Exodus","Leviticus","Numbers","Deuteronomy","Joshua","Judges","Ruth","1 Samuel","2 Samuel",
"1 Kings","2 Kings","1 Chronicles","2 Chronicles","Ezra","Nehemiah","Esther","Job","Psalms","Proverbs",
"Ecclesiastes","Song of Solomon","Isaiah","Jeremiah","Lamentations","Ezekiel","Daniel","Hosea","Joel","Amos",
"Obadiah","Jonah","Micah","Nahum","Habakkuk","Zephaniah","Haggai","Zechariah","Malachi","Matthew","Mark","Luke",
"John","Acts","Romans","1 Corinthians","2 Corinthians","Galatians","Ephesians","Philippians","Colossians",
"1 Thessalonians","2 Thessalonians","1 Timothy","2 Timothy","Titus","Philemon","Hebrews","James","1 Peter",
"2 Peter","1 John","2 John","3 John","Jude","Revelation"]
assert len(toc)==len(CANON), "TOC %d vs CANON %d"%(len(toc),len(CANON))
hdr={CANON[i]:toc[i] for i in range(len(CANON))}
# body line index = last full-line match after the TOC
bodyidx={}
for nm,h in hdr.items():
    idxs=[i for i,l in enumerate(lines) if i>95 and l.strip()==h]
    if idxs: bodyidx[nm]=max(idxs)
order=sorted(bodyidx.items(),key=lambda kv:kv[1])
booktext={}
for k,(nm,i) in enumerate(order):
    end=order[k+1][1] if k+1<len(order) else len(lines)
    booktext[nm]='\n'.join(lines[i:end])
def clean(t): return re.sub(r'\s+',' ',t).strip().replace('’',"'").replace('“','"').replace('”','"')
def get_verse(nm,ch,vs):
    bt=booktext.get(nm)
    if not bt: return None
    m=re.search(r'(?<![\d:])%d:%d '%(ch,vs),bt)
    if not m: return None
    nxt=re.search(r'(?<![\d:])\d+:\d+ ',bt[m.end():])
    seg=bt[m.start(): m.end()+(nxt.start() if nxt else 300)]
    return re.sub(r'^\d+:\d+ ','',clean(seg))[:400]
NAMES=sorted(CANON,key=lambda s:-len(s))
def parse_ref(note):
    for nm in NAMES:
        m=re.search(r'(?<![A-Za-z])'+re.escape(nm)+r'\s+(\d+):(\d+)',note)
        if m: return nm,int(m.group(1)),int(m.group(2))
    return None
def esc(s): return s.replace("'","''")
ORIG={'SRC_HEBREW_BIBLE':'https://www.sefaria.org/texts/Tanakh','SRC_NEW_TESTAMENT':'https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.01.0155'}
rows=[];deferred=[]
for line in open('/tmp/bible_cohort.tsv',encoding='utf-8'):
    line=line.rstrip('\n')
    if not line.strip():continue
    eid,sid,name,note=line.split('\t',3)
    r=parse_ref(note)
    if not r: deferred.append((eid,'noref'));continue
    nm,ch,vs=r; q=get_verse(nm,ch,vs)
    if not q or len(q)<15: deferred.append((eid,'noverse %s %d:%d'%(nm,ch,vs)));continue
    rows.append((eid,sid,name,nm,ch,vs,q))
with open('/tmp/build_bible_citations.sql','w',encoding='utf-8') as f:
    f.write("INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES\n")
    vals=[]
    for eid,sid,name,nm,ch,vs,q in rows:
        cid=('CIT_'+eid.replace('ENT_','')+'_KJV')[:60]
        vals.append("('%s','%s','%s','The Bible (King James Version)','%s %d:%d','%s','King James Version',1611,'https://www.gutenberg.org/ebooks/10','%s','primary-verbatim','English (KJV); the chapter:verse locus is translation-independent — consult the original (linked) for the Hebrew/Greek.',false,NULL,DATE '2026-06-18','deterministic verse extraction by book chapter:verse + substring gate (Gutenberg #10 KJV)',1)"%(
          esc(cid),esc(eid),sid,esc(nm),ch,vs,esc(q),ORIG.get(sid,'')))
    f.write(',\n'.join(vals)+"\nON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,original_text_url=EXCLUDED.original_text_url,verify_method=EXCLUDED.verify_method;\n")
print("bible citations:",len(rows),"| deferred:",len(deferred))
import collections
print("defer reasons:",collections.Counter(d[1].split()[0] for d in deferred))
