# deitydb v0.2 Scoring Upgrade

This package adds a separate `entity_scores` table for interpretive correspondences.

It covers:

- Classical elements: earth, air, fire, water
- Classical planets: moon, mercury, venus, sun, mars, jupiter, saturn

Important: the seed scores are algorithmic first-pass scores generated from the existing v0.1 fields:
`category`, `entity_type`, `primary_domains`, `tags`, `chthonic_flag`, `serpent_flag`, `earth_association_score`, and `short_note`.

They are marked `needs_review` and should not be treated as final scholarly claims.

## Apply locally

From your Linux shell, not inside psql, copy the files into the container:

```bash
cd ~/projects/deitydb
cp /mnt/c/Users/jebbo/Downloads/deitydb_v0_2_scoring_upgrade/upgrade_v0_2_scoring.sql .
cp /mnt/c/Users/jebbo/Downloads/deitydb_v0_2_scoring_upgrade/entity_scores_seed_v0_2.csv .

docker cp upgrade_v0_2_scoring.sql deitydb:/upgrade_v0_2_scoring.sql
docker cp entity_scores_seed_v0_2.csv deitydb:/entity_scores_seed_v0_2.csv
```

Apply schema upgrade:

```bash
docker exec -i deitydb psql -U postgres -d deitydb < upgrade_v0_2_scoring.sql
```

Import scores:

```bash
docker exec -it deitydb psql -U postgres -d deitydb
```

Inside psql:

```sql
\copy entity_scores(entity_id, system, score_name, score, confidence, rationale, source_id, review_status)
FROM '/entity_scores_seed_v0_2.csv' CSV HEADER;

SELECT COUNT(*) FROM entity_scores;
```

Expected count: 4268.

## Useful queries

Earth + Saturn:

```sql
SELECT canonical_name, entity_type, category, earth_score, saturn_score
FROM v_entity_correspondences
WHERE earth_score >= 4 AND saturn_score >= 4
ORDER BY earth_score DESC, saturn_score DESC, canonical_name;
```

Moon + water:

```sql
SELECT canonical_name, entity_type, category, moon_score, water_score
FROM v_entity_correspondences
WHERE moon_score >= 4 AND water_score >= 4
ORDER BY moon_score DESC, water_score DESC, canonical_name;
```

Review only high scores:

```sql
SELECT e.canonical_name, es.system, es.score_name, es.score, es.rationale
FROM entity_scores es
JOIN entities e ON e.entity_id = es.entity_id
WHERE es.score >= 4
ORDER BY es.system, es.score_name, es.score DESC, e.canonical_name;
```

Update a score manually after review:

```sql
UPDATE entity_scores
SET score = 5,
    confidence = 'high',
    rationale = 'Reviewed manually: strong lunar magical associations.',
    review_status = 'reviewed',
    updated_at = now()
WHERE entity_id = 'ENT_HECATE'
  AND system = 'classical_planet'
  AND score_name = 'moon';
```
