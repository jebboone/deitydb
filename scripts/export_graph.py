#!/usr/bin/env python3
"""Export the DeityDB entity-relationship graph to standard interchange formats.

Reads the published SQLite (deitydb.sqlite, built by scripts/export_sqlite.sh) and
writes, into exports/:
  - deitydb.graphml       GraphML — opens directly in Gephi, yEd, NetworkX, igraph
  - deitydb.cypher        Neo4j CREATE statements (nodes + relationships)
  - deitydb_graph.json    node-link JSON (networkx.node_link_graph compatible)

Nodes carry: name, tradition, entity_class, entity_type.
Edges carry: relationship_type, confidence, source_id.

Usage:  python3 scripts/export_graph.py [sqlite_path]   (default: deitydb.sqlite)
"""
import sqlite3, json, sys, os, html, re

DB = sys.argv[1] if len(sys.argv) > 1 else "deitydb.sqlite"
OUT = "static/exports"
os.makedirs(OUT, exist_ok=True)

con = sqlite3.connect(DB)
con.row_factory = sqlite3.Row
nodes = con.execute(
    "select entity_id, canonical_name, tradition, entity_class, entity_type from entities"
).fetchall()
edges = con.execute(
    "select subject_entity_id s, object_entity_id o, relationship_type rel, confidence, source_id"
    " from entity_relationships"
).fetchall()
node_ids = {n["entity_id"] for n in nodes}
# keep only edges whose endpoints both exist as nodes (defensive)
edges = [e for e in edges if e["s"] in node_ids and e["o"] in node_ids]

# ---- GraphML ----
NODE_ATTRS = [("name", "canonical_name"), ("tradition", "tradition"),
              ("entity_class", "entity_class"), ("entity_type", "entity_type")]
EDGE_ATTRS = [("relationship_type", "rel"), ("confidence", "confidence"), ("source_id", "source_id")]
def esc(v): return html.escape(str(v)) if v is not None else ""
with open(f"{OUT}/deitydb.graphml", "w", encoding="utf-8") as f:
    f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    f.write('<graphml xmlns="http://graphml.graphdrawing.org/xmlns">\n')
    for k, _ in NODE_ATTRS:
        f.write(f'  <key id="{k}" for="node" attr.name="{k}" attr.type="string"/>\n')
    for k, _ in EDGE_ATTRS:
        f.write(f'  <key id="{k}" for="edge" attr.name="{k}" attr.type="string"/>\n')
    f.write('  <graph edgedefault="directed">\n')
    for n in nodes:
        f.write(f'    <node id="{esc(n["entity_id"])}">\n')
        for k, col in NODE_ATTRS:
            f.write(f'      <data key="{k}">{esc(n[col])}</data>\n')
        f.write('    </node>\n')
    for i, e in enumerate(edges):
        f.write(f'    <edge id="e{i}" source="{esc(e["s"])}" target="{esc(e["o"])}">\n')
        for k, col in EDGE_ATTRS:
            f.write(f'      <data key="{k}">{esc(e[col])}</data>\n')
        f.write('    </edge>\n')
    f.write('  </graph>\n</graphml>\n')

# ---- Neo4j Cypher ----
def cq(v): return "'" + str(v).replace("\\", "\\\\").replace("'", "\\'") + "'" if v is not None else "null"
def rel_token(r): return re.sub(r'[^A-Z0-9_]', '_', str(r).upper()) or "RELATED"
with open(f"{OUT}/deitydb.cypher", "w", encoding="utf-8") as f:
    f.write("// DeityDB graph — Neo4j import. Run with cypher-shell or :source in Neo4j Browser.\n")
    f.write("CREATE CONSTRAINT deitydb_entity_id IF NOT EXISTS FOR (e:Entity) REQUIRE e.id IS UNIQUE;\n")
    for n in nodes:
        props = ", ".join([f"id:{cq(n['entity_id'])}"] + [f"{k}:{cq(n[col])}" for k, col in NODE_ATTRS])
        f.write(f"CREATE (:Entity {{{props}}});\n")
    for e in edges:
        props = f"confidence:{cq(e['confidence'])}, source_id:{cq(e['source_id'])}"
        f.write(f"MATCH (a:Entity {{id:{cq(e['s'])}}}),(b:Entity {{id:{cq(e['o'])}}}) "
                f"CREATE (a)-[:{rel_token(e['rel'])} {{{props}}}]->(b);\n")

# ---- node-link JSON (networkx-compatible) ----
nl = {
    "directed": True, "multigraph": True, "graph": {"name": "DeityDB"},
    "nodes": [{"id": n["entity_id"], "name": n["canonical_name"], "tradition": n["tradition"],
               "entity_class": n["entity_class"], "entity_type": n["entity_type"]} for n in nodes],
    "links": [{"source": e["s"], "target": e["o"], "relationship_type": e["rel"],
               "confidence": e["confidence"], "source_id": e["source_id"]} for e in edges],
}
with open(f"{OUT}/deitydb_graph.json", "w", encoding="utf-8") as f:
    json.dump(nl, f, ensure_ascii=False, indent=0)

print(f"exported {len(nodes)} nodes, {len(edges)} edges -> {OUT}/deitydb.graphml, deitydb.cypher, deitydb_graph.json")
