"""Inject live release statistics into every template.

Exposes db_entities / db_relationships / db_sources / db_traditions (comma-formatted
strings) drawn from v_release_metrics at render time, so the hero, about, database, and
explore pages never carry stale hard-coded counts again.
"""
from datasette import hookimpl

STATS_SQL = """
SELECT
  (SELECT entities      FROM v_release_metrics) AS entities,
  (SELECT relationships FROM v_release_metrics) AS relationships,
  (SELECT sources       FROM v_release_metrics) AS sources,
  (SELECT count(DISTINCT tradition) FROM entities
     WHERE tradition IS NOT NULL AND tradition <> '') AS traditions
"""


@hookimpl
def extra_template_vars(datasette):
    async def _vars():
        try:
            db = datasette.get_database("deitydb")
            row = (await db.execute(STATS_SQL)).first()
            fmt = lambda n: "{:,}".format(int(n))
            return {
                "db_entities": fmt(row["entities"]),
                "db_relationships": fmt(row["relationships"]),
                "db_sources": fmt(row["sources"]),
                "db_traditions": str(int(row["traditions"])),
            }
        except Exception:
            # Never let a stats lookup break page rendering.
            return {}
    return _vars
