import fitz,sys
doc=fitz.open(sys.argv[1])
with open(sys.argv[2],'w',encoding='utf-8') as f:
    for pg in doc: f.write(pg.get_text())
print(sys.argv[2],"pages",doc.page_count)
