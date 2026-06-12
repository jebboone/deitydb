# Maintenance

## Standard Audit Cycle

1. Run relationship audit.
2. Review remaining `associated_with` edges.
3. Check duplicate entity names.
4. Check duplicate relationship edges.
5. Review unresolved `review_status` records.
6. Update ontology docs if a new relation type is required.
7. Commit data and documentation together.

## Commands

```bash
psql -U postgres -d deitydb -f scripts/audit_relationships.sql
psql -U postgres -d deitydb -f scripts/audit_duplicates.sql
