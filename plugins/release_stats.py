"""Inject live release statistics into every template.

Exposes db_entities / db_relationships / db_sources / db_traditions (comma-formatted
strings) drawn from v_release_metrics at render time, plus db_version read from the
VERSION file, so the hero, about, database, explore pages and footer never carry stale
hard-coded counts or version strings again.
"""
import pathlib

from datasette import hookimpl

# Read the release version once at startup (VERSION is copied into the image alongside
# the sqlite db). Falls back to an empty string if the file is missing.
try:
    DB_VERSION = pathlib.Path("VERSION").read_text(encoding="utf-8").strip()
except Exception:
    DB_VERSION = ""

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
        out = {"db_version": DB_VERSION}
        try:
            db = datasette.get_database("deitydb")
            row = (await db.execute(STATS_SQL)).first()
            fmt = lambda n: "{:,}".format(int(n))
            out.update({
                "db_entities": fmt(row["entities"]),
                "db_relationships": fmt(row["relationships"]),
                "db_sources": fmt(row["sources"]),
                "db_traditions": str(int(row["traditions"])),
            })
        except Exception:
            # Never let a stats lookup break page rendering.
            pass
        return out
    return _vars
