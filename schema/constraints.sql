-- schema/constraints.sql
-- Primary keys, foreign keys, unique/check constraints, and indexes for DeityDB,
-- loaded by schema/bootstrap.sql after tables.sql. Generated from the live instance
-- via pg_dump --section=post-data. Supersedes the earlier hand-written subset.

--
-- PostgreSQL database dump
--


-- Dumped from database version 17.10 (Debian 17.10-1.pgdg13+1)
-- Dumped by pg_dump version 17.10 (Debian 17.10-1.pgdg13+1)



--
-- Name: animals animals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_pkey PRIMARY KEY (animal);


--
-- Name: claims claims_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_pkey PRIMARY KEY (claim_id);


--
-- Name: classification_audit classification_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.classification_audit
    ADD CONSTRAINT classification_audit_pkey PRIMARY KEY (audit_id);


--
-- Name: cult_centers cult_centers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cult_centers
    ADD CONSTRAINT cult_centers_pkey PRIMARY KEY (cult_center_id);


--
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (entity_id);


--
-- Name: entity_class entity_class_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_class
    ADD CONSTRAINT entity_class_pkey PRIMARY KEY (class_id);


--
-- Name: entity_type_class_map entity_type_class_map_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_type_class_map
    ADD CONSTRAINT entity_type_class_map_pkey PRIMARY KEY (entity_type);


--
-- Name: entity_aliases entity_aliases_entity_id_alias_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_aliases
    ADD CONSTRAINT entity_aliases_entity_id_alias_name_key UNIQUE (entity_id, alias_name);


--
-- Name: entity_aliases entity_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_aliases
    ADD CONSTRAINT entity_aliases_pkey PRIMARY KEY (alias_id);


--
-- Name: entity_animals entity_animals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_animals
    ADD CONSTRAINT entity_animals_pkey PRIMARY KEY (entity_id, animal);


--
-- Name: entity_cult_centers entity_cult_centers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_cult_centers
    ADD CONSTRAINT entity_cult_centers_pkey PRIMARY KEY (entity_id, cult_center_id);


--
-- Name: entity_duplicate_review entity_duplicate_review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_duplicate_review
    ADD CONSTRAINT entity_duplicate_review_pkey PRIMARY KEY (canonical_name, entity_id);


--
-- Name: entity_epithets entity_epithets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_epithets
    ADD CONSTRAINT entity_epithets_pkey PRIMARY KEY (entity_id, epithet_id);


--
-- Name: entity_functions entity_functions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_functions
    ADD CONSTRAINT entity_functions_pkey PRIMARY KEY (entity_id, function_name);


--
-- Name: entity_merge_log entity_merge_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_merge_log
    ADD CONSTRAINT entity_merge_log_pkey PRIMARY KEY (old_entity_id);


--
-- Name: entity_metals entity_metals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_metals
    ADD CONSTRAINT entity_metals_pkey PRIMARY KEY (entity_id, metal);


--
-- Name: entity_periods entity_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_periods
    ADD CONSTRAINT entity_periods_pkey PRIMARY KEY (entity_id, period_id);


--
-- Name: entity_plants entity_plants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_plants
    ADD CONSTRAINT entity_plants_pkey PRIMARY KEY (entity_id, plant);


--
-- Name: entity_regions entity_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_regions
    ADD CONSTRAINT entity_regions_pkey PRIMARY KEY (entity_id, region);


--
-- Name: entity_relationships entity_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships
    ADD CONSTRAINT entity_relationships_pkey PRIMARY KEY (relationship_id);


--
-- Name: entity_relationships entity_relationships_subject_entity_id_relationship_type_ob_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships
    ADD CONSTRAINT entity_relationships_subject_entity_id_relationship_type_ob_key UNIQUE (subject_entity_id, relationship_type, object_entity_id);


--
-- Name: entity_scores entity_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_scores
    ADD CONSTRAINT entity_scores_pkey PRIMARY KEY (entity_id, system, score_name);


--
-- Name: entity_sources entity_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_sources
    ADD CONSTRAINT entity_sources_pkey PRIMARY KEY (entity_id, source_id, evidence_type);


--
-- Name: entity_tradition_tags entity_tradition_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_tradition_tags
    ADD CONSTRAINT entity_tradition_tags_pkey PRIMARY KEY (entity_id, tradition_tag);


--
-- Name: epithets epithets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.epithets
    ADD CONSTRAINT epithets_pkey PRIMARY KEY (epithet_id);


--
-- Name: functions functions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.functions
    ADD CONSTRAINT functions_pkey PRIMARY KEY (function_name);


--
-- Name: import_batches import_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_batches
    ADD CONSTRAINT import_batches_pkey PRIMARY KEY (batch_id);


--
-- Name: metals metals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metals
    ADD CONSTRAINT metals_pkey PRIMARY KEY (metal);


--
-- Name: periods periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT periods_pkey PRIMARY KEY (period_id);


--
-- Name: plants plants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plants
    ADD CONSTRAINT plants_pkey PRIMARY KEY (plant);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region);


--
-- Name: relationship_types relationship_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationship_types
    ADD CONSTRAINT relationship_types_pkey PRIMARY KEY (relationship_type);


--
-- Name: rule_sets rule_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rule_sets
    ADD CONSTRAINT rule_sets_pkey PRIMARY KEY (rule_set_id);


--
-- Name: semantic_relationships semantic_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semantic_relationships
    ADD CONSTRAINT semantic_relationships_pkey PRIMARY KEY (semantic_id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (source_id);


--
-- Name: idx_claims_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_claims_entity ON public.claims USING btree (entity_id);


--
-- Name: idx_claims_type_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_claims_type_value ON public.claims USING btree (claim_type, claim_value);


--
-- Name: idx_entities_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_category ON public.entities USING btree (category);


--
-- Name: idx_entities_confidence; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_confidence ON public.entities USING btree (evidence_confidence);


--
-- Name: idx_entities_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_name ON public.entities USING btree (canonical_name);


--
-- Name: idx_entities_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_type ON public.entities USING btree (entity_type);


--
-- Name: idx_entities_class; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_class ON public.entities USING btree (entity_class);


--
-- Name: idx_entity_animals_animal; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_animals_animal ON public.entity_animals USING btree (animal);


--
-- Name: idx_entity_functions_function; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_functions_function ON public.entity_functions USING btree (function_name);


--
-- Name: idx_entity_metals_metal; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_metals_metal ON public.entity_metals USING btree (metal);


--
-- Name: idx_entity_plants_plant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_plants_plant ON public.entity_plants USING btree (plant);


--
-- Name: idx_entity_regions_region; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_regions_region ON public.entity_regions USING btree (region);


--
-- Name: idx_entity_relationships_period_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_relationships_period_id ON public.entity_relationships USING btree (period_id) WHERE (period_id IS NOT NULL);


--
-- Name: idx_entity_scores_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_scores_entity ON public.entity_scores USING btree (entity_id);


--
-- Name: idx_entity_scores_system_name_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entity_scores_system_name_score ON public.entity_scores USING btree (system, score_name, score);


--
-- Name: claims claims_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: claims claims_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: entity_aliases entity_aliases_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_aliases
    ADD CONSTRAINT entity_aliases_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_aliases entity_aliases_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_aliases
    ADD CONSTRAINT entity_aliases_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: entity_animals entity_animals_animal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_animals
    ADD CONSTRAINT entity_animals_animal_fkey FOREIGN KEY (animal) REFERENCES public.animals(animal);


--
-- Name: entities entities_entity_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_entity_class_fkey FOREIGN KEY (entity_class) REFERENCES public.entity_class(class_id);


--
-- Name: entity_type_class_map entity_type_class_map_entity_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_type_class_map
    ADD CONSTRAINT entity_type_class_map_entity_class_fkey FOREIGN KEY (entity_class) REFERENCES public.entity_class(class_id);


--
-- Name: entity_animals entity_animals_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_animals
    ADD CONSTRAINT entity_animals_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_cult_centers entity_cult_centers_cult_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_cult_centers
    ADD CONSTRAINT entity_cult_centers_cult_center_id_fkey FOREIGN KEY (cult_center_id) REFERENCES public.cult_centers(cult_center_id);


--
-- Name: entity_cult_centers entity_cult_centers_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_cult_centers
    ADD CONSTRAINT entity_cult_centers_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_duplicate_review entity_duplicate_review_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_duplicate_review
    ADD CONSTRAINT entity_duplicate_review_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_epithets entity_epithets_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_epithets
    ADD CONSTRAINT entity_epithets_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_epithets entity_epithets_epithet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_epithets
    ADD CONSTRAINT entity_epithets_epithet_id_fkey FOREIGN KEY (epithet_id) REFERENCES public.epithets(epithet_id);


--
-- Name: entity_functions entity_functions_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_functions
    ADD CONSTRAINT entity_functions_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_functions entity_functions_function_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_functions
    ADD CONSTRAINT entity_functions_function_name_fkey FOREIGN KEY (function_name) REFERENCES public.functions(function_name);


--
-- Name: entity_metals entity_metals_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_metals
    ADD CONSTRAINT entity_metals_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_metals entity_metals_metal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_metals
    ADD CONSTRAINT entity_metals_metal_fkey FOREIGN KEY (metal) REFERENCES public.metals(metal);


--
-- Name: entity_periods entity_periods_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_periods
    ADD CONSTRAINT entity_periods_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_periods entity_periods_period_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_periods
    ADD CONSTRAINT entity_periods_period_id_fkey FOREIGN KEY (period_id) REFERENCES public.periods(period_id);


--
-- Name: entity_plants entity_plants_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_plants
    ADD CONSTRAINT entity_plants_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_plants entity_plants_plant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_plants
    ADD CONSTRAINT entity_plants_plant_fkey FOREIGN KEY (plant) REFERENCES public.plants(plant);


--
-- Name: entity_regions entity_regions_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_regions
    ADD CONSTRAINT entity_regions_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_regions entity_regions_region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_regions
    ADD CONSTRAINT entity_regions_region_fkey FOREIGN KEY (region) REFERENCES public.regions(region);


--
-- Name: entity_relationships entity_relationships_object_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships
    ADD CONSTRAINT entity_relationships_object_entity_id_fkey FOREIGN KEY (object_entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_relationships entity_relationships_period_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships
    ADD CONSTRAINT entity_relationships_period_id_fkey FOREIGN KEY (period_id) REFERENCES public.periods(period_id);


--
-- Name: entity_relationships entity_relationships_relationship_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships
    ADD CONSTRAINT entity_relationships_relationship_type_fkey FOREIGN KEY (relationship_type) REFERENCES public.relationship_types(relationship_type);


--
-- Name: entity_relationships entity_relationships_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships
    ADD CONSTRAINT entity_relationships_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: entity_relationships entity_relationships_subject_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships
    ADD CONSTRAINT entity_relationships_subject_entity_id_fkey FOREIGN KEY (subject_entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_scores entity_scores_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_scores
    ADD CONSTRAINT entity_scores_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_sources entity_sources_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_sources
    ADD CONSTRAINT entity_sources_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_sources entity_sources_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_sources
    ADD CONSTRAINT entity_sources_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: entity_tradition_tags entity_tradition_tags_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_tradition_tags
    ADD CONSTRAINT entity_tradition_tags_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: entity_tradition_tags entity_tradition_tags_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_tradition_tags
    ADD CONSTRAINT entity_tradition_tags_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: names names_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.names
    ADD CONSTRAINT names_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: names names_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.names
    ADD CONSTRAINT names_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: places places_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- Name: places places_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: relationships relationships_object_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_object_entity_id_fkey FOREIGN KEY (object_entity_id) REFERENCES public.entities(entity_id);


--
-- Name: relationships relationships_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(source_id);


--
-- Name: relationships relationships_subject_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_subject_entity_id_fkey FOREIGN KEY (subject_entity_id) REFERENCES public.entities(entity_id);


--
-- PostgreSQL database dump complete
--


