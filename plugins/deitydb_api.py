"""DeityDB public JSON API.

Clean, stable, documented endpoints over the read-only graph, registered as Datasette
routes (CORS is enabled globally via --cors). Powers the /path, /constellation and /graph
front-end pages and is documented at /api.

  GET /api/entity/<id>                 — one entity + its relationships, sources, periods
  GET /api/neighbors/<id>?type=&tradition=&direction=   — adjacent entities
  GET /api/path?from=&to=&maxdepth=    — shortest relationship path between two entities
  GET /api/search?q=&limit=            — name search
  GET /api/tradition/<name>            — entities of a tradition
  GET /api/graph.json?tradition=&limit= — nodes+links for the constellation map
  GET /api/meta                        — counts + relationship-type & tradition vocab
  GET /api/openapi.json                — OpenAPI 3 spec
"""
from datasette import hookimpl
from datasette.utils.asgi import Response

DBN = "deitydb"


@hookimpl
def register_routes():
    return [
        (r"^/api/entity/(?P<eid>[^/]+)$", api_entity),
        (r"^/api/neighbors/(?P<eid>[^/]+)$", api_neighbors),
        (r"^/api/path$", api_path),
        (r"^/api/search$", api_search),
        (r"^/api/tradition/(?P<name>[^/]+)$", api_tradition),
        (r"^/api/graph\.json$", api_graph),
        (r"^/api/meta$", api_meta),
        (r"^/api/openapi\.json$", api_openapi),
    ]


def _db(datasette):
    return datasette.get_database(DBN)


async def _rows(datasette, sql, params=None):
    res = await _db(datasette).execute(sql, params or [])
    return [dict(r) for r in res.rows]


def _err(msg, status=400):
    return Response.json({"error": msg}, status=status)


async def api_entity(datasette, request):
    eid = request.url_vars["eid"]
    ent = await _rows(datasette, "select * from entities where entity_id=?", [eid])
    if not ent:
        return _err(f"entity '{eid}' not found", 404)
    rels = await _rows(datasette,
        "select er.relationship_type rel,"
        " case when er.subject_entity_id=? then 'out' else 'in' end direction,"
        " case when er.subject_entity_id=? then er.object_entity_id else er.subject_entity_id end other_id,"
        " case when er.subject_entity_id=? then o.canonical_name else s.canonical_name end other_name,"
        " case when er.subject_entity_id=? then o.tradition else s.tradition end other_tradition,"
        " er.confidence, er.rationale, er.source_id"
        " from entity_relationships er join entities s on s.entity_id=er.subject_entity_id"
        " join entities o on o.entity_id=er.object_entity_id"
        " where er.subject_entity_id=? or er.object_entity_id=? order by direction desc, rel, other_name",
        [eid, eid, eid, eid, eid, eid])
    pers = await _rows(datasette,
        "select p.period_id, p.period_name, p.start_year, p.end_year from entity_periods ep"
        " join periods p on p.period_id=ep.period_id where ep.entity_id=? order by p.start_year", [eid])
    srcs = await _rows(datasette,
        "select s.source_id, s.title, s.source_type, s.url, es.evidence_type from entity_sources es"
        " join sources s on s.source_id=es.source_id where es.entity_id=? order by s.title", [eid])
    e = ent[0]
    return Response.json({
        "entity": e, "relationships": rels, "periods": pers, "sources": srcs,
        "counts": {"relationships": len(rels), "sources": len(srcs)},
    })


async def api_neighbors(datasette, request):
    eid = request.url_vars["eid"]
    rtype = request.args.get("type")
    trad = request.args.get("tradition")
    direction = request.args.get("direction")  # out | in | both(default)
    where = ["(er.subject_entity_id=? or er.object_entity_id=?)"]
    params = [eid, eid]
    if direction == "out":
        where = ["er.subject_entity_id=?"]; params = [eid]
    elif direction == "in":
        where = ["er.object_entity_id=?"]; params = [eid]
    if rtype:
        where.append("er.relationship_type=?"); params.append(rtype)
    sql = ("select er.relationship_type rel,"
           " case when er.subject_entity_id=? then 'out' else 'in' end direction,"
           " case when er.subject_entity_id=? then er.object_entity_id else er.subject_entity_id end id,"
           " case when er.subject_entity_id=? then o.canonical_name else s.canonical_name end name,"
           " case when er.subject_entity_id=? then o.tradition else s.tradition end tradition,"
           " er.confidence, er.rationale"
           " from entity_relationships er join entities s on s.entity_id=er.subject_entity_id"
           " join entities o on o.entity_id=er.object_entity_id where " + " and ".join(where))
    params = [eid, eid, eid, eid] + params
    rows = await _rows(datasette, sql, params)
    if trad:
        rows = [r for r in rows if (r.get("tradition") or "") == trad]
    return Response.json({"id": eid, "count": len(rows), "neighbors": rows})


async def api_path(datasette, request):
    a = request.args.get("from")
    b = request.args.get("to")
    if not a or not b:
        return _err("provide ?from=<entity_id>&to=<entity_id>")
    try:
        maxd = min(int(request.args.get("maxdepth", 7)), 8)
    except ValueError:
        maxd = 7
    ends = await _rows(datasette, "select entity_id from entities where entity_id in (?,?)", [a, b])
    have = {r["entity_id"] for r in ends}
    if a not in have:
        return _err(f"entity '{a}' not found", 404)
    if b not in have:
        return _err(f"entity '{b}' not found", 404)
    if a == b:
        return _err("from and to are the same entity")
    # undirected BFS, expanding one frontier level at a time via SQL
    came = {a: None}            # id -> (prev_id, rel_type)
    frontier = [a]
    found = False
    for _ in range(maxd):
        if not frontier:
            break
        ph = ",".join("?" * len(frontier))
        rows = await _rows(datasette,
            f"select subject_entity_id s, object_entity_id o, relationship_type t"
            f" from entity_relationships where subject_entity_id in ({ph}) or object_entity_id in ({ph})",
            frontier + frontier)
        nxt = []
        fset = set(frontier)
        for r in rows:
            for cur, nb in ((r["s"], r["o"]), (r["o"], r["s"])):
                if cur in fset and nb not in came:
                    came[nb] = (cur, r["t"])
                    nxt.append(nb)
                    if nb == b:
                        found = True
        if found:
            break
        frontier = nxt
    if b not in came:
        return Response.json({"from": a, "to": b, "found": False,
                              "message": f"no path within {maxd} steps", "path": [], "edges": []})
    # reconstruct
    chain = []
    cur = b
    while cur is not None:
        prev = came[cur]
        chain.append((cur, prev[1] if prev else None, prev[0] if prev else None))
        cur = prev[0] if prev else None
    chain.reverse()  # [(id, rel_from_prev, prev_id), ...] from a..b
    ids = [c[0] for c in chain]
    ph = ",".join("?" * len(ids))
    meta = {r["entity_id"]: r for r in await _rows(datasette,
        f"select e.entity_id, e.canonical_name, e.tradition, e.entity_class, e.entity_type,"
        f" (select min(p.start_year) from entity_periods ep join periods p on p.period_id=ep.period_id where ep.entity_id=e.entity_id) start_year"
        f" from entities e where e.entity_id in ({ph})", ids)}
    nodes = [meta.get(i, {"entity_id": i}) for i in ids]
    edges = []
    for i in range(1, len(chain)):
        nid, rel, prev = chain[i]
        # the recorded edge between prev->nid may be stored in either direction; fetch rationale + true direction
        er = await _rows(datasette,
            "select subject_entity_id s, object_entity_id o, relationship_type t, rationale ra, source_id src"
            " from entity_relationships where relationship_type=? and"
            " ((subject_entity_id=? and object_entity_id=?) or (subject_entity_id=? and object_entity_id=?)) limit 1",
            [rel, prev, nid, nid, prev])
        e = er[0] if er else {"s": prev, "o": nid, "t": rel, "ra": "", "src": ""}
        edges.append({"from": e["s"], "to": e["o"], "rel": e["t"], "rationale": e.get("ra"), "source_id": e.get("src")})
    return Response.json({"from": a, "to": b, "found": True, "length": len(ids) - 1,
                          "path": nodes, "edges": edges})


async def api_search(datasette, request):
    q = (request.args.get("q") or "").strip()
    if len(q) < 2:
        return _err("provide ?q= (>=2 chars)")
    try:
        limit = min(int(request.args.get("limit", 20)), 100)
    except ValueError:
        limit = 20
    rows = await _rows(datasette,
        "select entity_id, canonical_name, tradition, entity_class, entity_type from entities"
        " where canonical_name like ? order by length(canonical_name) limit ?",
        ["%" + q + "%", limit])
    return Response.json({"query": q, "count": len(rows), "results": rows})


async def api_tradition(datasette, request):
    name = request.url_vars["name"].replace("+", " ")
    rows = await _rows(datasette,
        "select entity_id, canonical_name, entity_class, entity_type from entities where tradition=? order by canonical_name", [name])
    if not rows:
        return _err(f"tradition '{name}' not found or empty", 404)
    prof = await _rows(datasette,
        "select tradition_class, prevalence, status_note from tradition_profile where tradition=?", [name])
    return Response.json({"tradition": name, "profile": prof[0] if prof else None,
                          "count": len(rows), "entities": rows})


async def api_graph(datasette, request):
    trad = request.args.get("tradition")
    try:
        limit = min(int(request.args.get("limit", 5000)), 8000)
    except ValueError:
        limit = 5000
    if trad:
        nodes = await _rows(datasette,
            "select entity_id id, canonical_name name, tradition trad from entities where tradition=? limit ?", [trad, limit])
    else:
        nodes = await _rows(datasette,
            "select entity_id id, canonical_name name, tradition trad from entities limit ?", [limit])
    ids = {n["id"] for n in nodes}
    links = []
    for r in await _rows(datasette, "select subject_entity_id s, object_entity_id o, relationship_type t from entity_relationships"):
        if r["s"] in ids and r["o"] in ids:
            links.append([r["s"], r["o"], r["t"]])
    return Response.json({"node_count": len(nodes), "link_count": len(links),
                          "nodes": [[n["id"], n["name"], n["trad"]] for n in nodes], "links": links})


async def api_meta(datasette, request):
    counts = (await _rows(datasette,
        "select (select count(*) from entities) entities, (select count(*) from entity_relationships) relationships,"
        " (select count(*) from sources) sources, (select count(distinct tradition) from entities) traditions"))[0]
    rtypes = [r["relationship_type"] for r in await _rows(datasette, "select relationship_type from relationship_types order by 1")]
    trads = [r["tradition"] for r in await _rows(datasette, "select distinct tradition from entities order by 1")]
    return Response.json({"counts": counts, "relationship_types": rtypes, "traditions": trads})


async def api_openapi(datasette, request):
    base = str(request.url).split("/api/openapi.json")[0]
    def op(summary, params):
        return {"get": {"summary": summary, "parameters": params,
                        "responses": {"200": {"description": "OK"}}}}
    P = lambda n, inn, req, desc: {"name": n, "in": inn, "required": req, "schema": {"type": "string"}, "description": desc}
    return Response.json({
        "openapi": "3.0.0",
        "info": {"title": "DeityDB API", "version": "1.0", "description": "Read-only JSON API over the DeityDB comparative-religion graph."},
        "servers": [{"url": base}],
        "paths": {
            "/api/entity/{id}": op("An entity with its relationships, sources and periods", [P("id", "path", True, "entity_id")]),
            "/api/neighbors/{id}": op("Adjacent entities", [P("id", "path", True, "entity_id"), P("type", "query", False, "relationship_type filter"), P("tradition", "query", False, "tradition filter"), P("direction", "query", False, "out|in|both")]),
            "/api/path": op("Shortest relationship path between two entities", [P("from", "query", True, "start entity_id"), P("to", "query", True, "end entity_id"), P("maxdepth", "query", False, "max steps (<=8)")]),
            "/api/search": op("Search entities by name", [P("q", "query", True, "query (>=2 chars)"), P("limit", "query", False, "max results")]),
            "/api/tradition/{name}": op("Entities of a tradition + its profile", [P("name", "path", True, "tradition name")]),
            "/api/graph.json": op("Nodes+links for graph rendering", [P("tradition", "query", False, "restrict to a tradition"), P("limit", "query", False, "max nodes")]),
            "/api/meta": op("Counts + relationship-type and tradition vocabularies", []),
        },
    })
