# Installation

## Requirements

- PostgreSQL 15+
- psql
- git

## Clone

```bash
git clone https://github.com/jebboone/deitydb.git
cd deitydb
```

## Create database

```bash
createdb deitydb
```

## Build schema

```bash
psql -U postgres -d deitydb -f schema/bootstrap.sql
```

## Import seed data

Load:

- entities
- entity_relationships
- sources
- tradition_tags
