#!/usr/bin/env python3
"""Shared SQL-literal helpers for DeityDB's gen_*.py cohort generators.

These build *literal* values for the generated, idempotent build_<cohort>.sql seed
scripts (not parameterised queries — the runtime API in plugins/deitydb_api.py is
parameterised; this is offline codegen over trusted local JSON).

Postgres runs with standard_conforming_strings=on, so a backslash is an ordinary
character and only the single-quote needs doubling. The hand-rolled `q()` that was
copy-pasted into every generator got that right but mishandled three things, which
these helpers fix once, consistently:

  * None  -> the string 'None'  (should be SQL NULL)
  * ''    -> '' for ints via %d would crash; open-ended period years had no NULL path
  * %d    -> a non-integer year raised an opaque formatting error mid-build

Usage (drop-in for the old `q`):
    from sqlgen import sql_str as q, sql_int, sql_bool
"""
from __future__ import annotations


def sql_str(x):
    """Text literal with single-quotes doubled; None -> NULL.

    Rejects NUL bytes, which Postgres text columns cannot store (better to fail
    at generate time than to emit a script psql will reject halfway through).
    """
    if x is None:
        return "NULL"
    t = str(x)
    if "\x00" in t:
        raise ValueError(f"NUL byte in SQL string literal: {t!r}")
    return "'" + t.replace("'", "''") + "'"


def sql_int(x):
    """Integer literal; None or '' -> NULL. Raises on non-integer input.

    Failing loudly beats the old `%d`, which crashed with an unhelpful message,
    and beats silently coercing garbage into a row.
    """
    if x is None or x == "":
        return "NULL"
    return str(int(x))


def sql_bool(x):
    """Boolean literal -> true / false; None -> NULL."""
    if x is None:
        return "NULL"
    return "true" if x else "false"
