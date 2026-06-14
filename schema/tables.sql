-- schema/tables.sql
-- Canonical table, sequence, and column-default DDL for DeityDB, loaded first
-- by schema/bootstrap.sql (before constraints.sql and views.sql).
-- Generated from the live instance via pg_dump --section=pre-data (views stripped;
-- they live in schema/views.sql). Schema-qualified (public.) and idempotent-friendly.

--
-- PostgreSQL database dump
--


-- Dumped from database version 17.10 (Debian 17.10-1.pgdg13+1)
-- Dumped by pg_dump version 17.10 (Debian 17.10-1.pgdg13+1)




--
-- Name: animals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.animals (
    animal text NOT NULL
);


--
-- Name: claims; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.claims (
    claim_id text NOT NULL,
    entity_id text,
    claim_type text NOT NULL,
    claim_value text NOT NULL,
    confidence text,
    source_id text,
    review_status text,
    CONSTRAINT claims_confidence_check CHECK ((confidence = ANY (ARRAY['A'::text, 'B'::text, 'C'::text, 'D'::text])))
);


--
-- Name: classification_audit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.classification_audit (
    audit_id bigint NOT NULL,
    relationship_id bigint NOT NULL,
    rule_set_id integer,
    applied_rule_id text,
    input_subject text,
    input_object text,
    input_category text,
    output_relationship_type text,
    confidence text,
    rationale text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: classification_audit_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.classification_audit_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: classification_audit_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.classification_audit_audit_id_seq OWNED BY public.classification_audit.audit_id;


--
-- Name: cult_centers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cult_centers (
    cult_center_id text NOT NULL,
    name text NOT NULL,
    tradition text,
    region text,
    modern_location text,
    notes text
);


--
-- Name: entities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entities (
    entity_id text NOT NULL,
    canonical_name text NOT NULL,
    greek_name text,
    tradition text,
    entity_type text,
    category text,
    primary_domains text,
    tags text,
    cult_scope text,
    primary_period text,
    evidence_confidence text,
    review_status text,
    inclusion_basis text,
    earth_association_score integer,
    chthonic_flag boolean,
    serpent_flag boolean,
    short_note text,
    CONSTRAINT entities_earth_association_score_check CHECK (((earth_association_score >= 0) AND (earth_association_score <= 5))),
    CONSTRAINT entities_evidence_confidence_check CHECK ((evidence_confidence = ANY (ARRAY['A'::text, 'B'::text, 'C'::text, 'D'::text])))
);


--
-- Name: entity_aliases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_aliases (
    alias_id bigint NOT NULL,
    entity_id text NOT NULL,
    alias_name text NOT NULL,
    alias_type text,
    language text,
    source_id text,
    confidence text DEFAULT 'medium'::text,
    review_status text DEFAULT 'needs_review'::text,
    notes text
);


--
-- Name: entity_aliases_alias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.entity_aliases_alias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entity_aliases_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.entity_aliases_alias_id_seq OWNED BY public.entity_aliases.alias_id;


--
-- Name: entity_animals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_animals (
    entity_id text NOT NULL,
    animal text NOT NULL,
    confidence text,
    rationale text,
    source_id text,
    review_status text
);


--
-- Name: entity_cult_centers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_cult_centers (
    entity_id text NOT NULL,
    cult_center_id text NOT NULL,
    confidence text,
    rationale text,
    source_id text,
    review_status text
);


--
-- Name: entity_duplicate_review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_duplicate_review (
    canonical_name text NOT NULL,
    entity_id text NOT NULL,
    duplicate_group_note text,
    decision text DEFAULT 'intentional_distinct'::text,
    reviewed_at timestamp without time zone DEFAULT now()
);


--
-- Name: entity_epithets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_epithets (
    entity_id text NOT NULL,
    epithet_id text NOT NULL,
    confidence text,
    source_id text,
    notes text
);


--
-- Name: entity_functions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_functions (
    entity_id text NOT NULL,
    function_name text NOT NULL,
    confidence text,
    rationale text,
    source_id text,
    review_status text
);


--
-- Name: entity_merge_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_merge_log (
    old_entity_id text NOT NULL,
    new_entity_id text NOT NULL,
    merge_reason text,
    merged_at timestamp without time zone DEFAULT now()
);


--
-- Name: entity_metals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_metals (
    entity_id text NOT NULL,
    metal text NOT NULL,
    confidence text,
    rationale text,
    source_id text,
    review_status text
);


--
-- Name: entity_periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_periods (
    entity_id text NOT NULL,
    period_id text NOT NULL,
    confidence text,
    rationale text,
    source_id text,
    review_status text
);


--
-- Name: entity_plants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_plants (
    entity_id text NOT NULL,
    plant text NOT NULL,
    confidence text,
    rationale text,
    source_id text,
    review_status text
);


--
-- Name: entity_regions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_regions (
    entity_id text NOT NULL,
    region text NOT NULL,
    confidence text,
    rationale text,
    source_id text,
    review_status text
);


--
-- Name: entity_relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_relationships (
    relationship_id bigint NOT NULL,
    subject_entity_id text NOT NULL,
    relationship_type text NOT NULL,
    object_entity_id text NOT NULL,
    confidence text NOT NULL,
    rationale text,
    source_id text,
    review_status text DEFAULT 'needs_review'::text,
    period_id text
);


--
-- Name: relationship_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relationship_types (
    relationship_type text NOT NULL,
    inverse_relationship_type text,
    description text
);


--
-- Name: entity_relationships_expanded; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: entity_relationships_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.entity_relationships_relationship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entity_relationships_relationship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.entity_relationships_relationship_id_seq OWNED BY public.entity_relationships.relationship_id;


--
-- Name: entity_scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_scores (
    entity_id text NOT NULL,
    system text NOT NULL,
    score_name text NOT NULL,
    score integer,
    confidence text,
    rationale text,
    source_id text,
    review_status text,
    CONSTRAINT entity_scores_score_check CHECK (((score >= 0) AND (score <= 5)))
);


--
-- Name: entity_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_sources (
    entity_id text NOT NULL,
    source_id text NOT NULL,
    evidence_type text NOT NULL,
    source_note text
);


--
-- Name: entity_tradition_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entity_tradition_tags (
    entity_id text NOT NULL,
    tradition_tag text NOT NULL,
    confidence text DEFAULT 'medium'::text,
    source_id text,
    review_status text DEFAULT 'needs_review'::text,
    notes text
);


--
-- Name: epithets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.epithets (
    epithet_id text NOT NULL,
    epithet_name text NOT NULL,
    translation text,
    description text
);


--
-- Name: functions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.functions (
    function_name text NOT NULL
);


--
-- Name: import_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.import_batches (
    batch_id text NOT NULL,
    tradition text NOT NULL,
    source_id text,
    description text,
    imported_at timestamp without time zone DEFAULT now(),
    entity_count integer,
    relationship_count integer,
    notes text
);


--
-- Name: metals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metals (
    metal text NOT NULL
);


--
-- Name: names; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.names (
    entity_id text,
    name text NOT NULL,
    name_type text,
    language text,
    source_id text
);


--
-- Name: periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.periods (
    period_id text NOT NULL,
    tradition text,
    period_name text NOT NULL,
    start_year integer,
    end_year integer,
    notes text
);


--
-- Name: places; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.places (
    entity_id text,
    place_name text NOT NULL,
    place_type text,
    place_authority_id text,
    source_id text,
    confidence text,
    review_status text,
    CONSTRAINT places_confidence_check CHECK ((confidence = ANY (ARRAY['A'::text, 'B'::text, 'C'::text, 'D'::text])))
);


--
-- Name: plants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plants (
    plant text NOT NULL
);


--
-- Name: regions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regions (
    region text NOT NULL
);


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relationships (
    subject_entity_id text,
    object_entity_id text,
    relationship_type text NOT NULL,
    confidence text,
    source_id text,
    review_status text,
    CONSTRAINT relationships_confidence_check CHECK ((confidence = ANY (ARRAY['A'::text, 'B'::text, 'C'::text, 'D'::text])))
);


--
-- Name: rule_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rule_sets (
    rule_set_id integer NOT NULL,
    version text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    description text
);


--
-- Name: rule_sets_rule_set_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rule_sets_rule_set_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rule_sets_rule_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rule_sets_rule_set_id_seq OWNED BY public.rule_sets.rule_set_id;


--
-- Name: semantic_relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.semantic_relationships (
    semantic_id bigint NOT NULL,
    relationship_id bigint NOT NULL,
    subject_entity_id text,
    object_entity_id text,
    relationship_type text,
    confidence text,
    rule_set_id integer,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: semantic_relationships_semantic_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.semantic_relationships_semantic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: semantic_relationships_semantic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.semantic_relationships_semantic_id_seq OWNED BY public.semantic_relationships.semantic_id;


--
-- Name: sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sources (
    source_id text NOT NULL,
    title text NOT NULL,
    url text,
    source_type text,
    scope text
);


--
-- Name: staging_entities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staging_entities (
    canonical_name text,
    tradition text,
    category text,
    primary_domains text,
    notes text,
    entity_id text,
    entity_type text,
    cult_scope text,
    evidence_confidence text DEFAULT 'B'::text,
    review_status text DEFAULT 'needs_review'::text,
    inclusion_basis text,
    earth_association_score integer DEFAULT 0,
    chthonic_flag boolean DEFAULT false,
    serpent_flag boolean DEFAULT false,
    short_note text
);


--
-- Name: staging_relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staging_relationships (
    subject_name text,
    relationship_type text,
    object_name text,
    source_id text,
    confidence text DEFAULT 'medium'::text,
    rationale text,
    review_status text DEFAULT 'needs_review'::text
);


--
-- Name: v_associated_with_conversion_candidates; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_category_distribution; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_entity_correspondences; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_entity_epithet_relationships; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_entity_epithet_summary; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_entity_relationships_full; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_entity_taxonomy_summary; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_entity_traditions; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_possible_duplicate_entities; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_relationships_needing_review; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_priority_relationship_review; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_adversarial_beings; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_angelic_beings; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_comparative_domains; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_domain_overview; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_relationship_overview; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_relationship_triples; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_revealer_figures; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_serpent_dragon_beings; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_tradition_overview; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_underworld_entities; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_public_wisdom_knowledge_beings; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_staging_relationship_unresolved; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_unreviewed_duplicate_entities; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_release_metrics; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_review_by_tradition; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_review_dashboard; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_staging_entity_duplicates; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: v_staging_relationships_resolved; Type: VIEW; Schema: public; Owner: -
--



--
-- Name: classification_audit audit_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.classification_audit ALTER COLUMN audit_id SET DEFAULT nextval('public.classification_audit_audit_id_seq'::regclass);


--
-- Name: entity_aliases alias_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_aliases ALTER COLUMN alias_id SET DEFAULT nextval('public.entity_aliases_alias_id_seq'::regclass);


--
-- Name: entity_relationships relationship_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entity_relationships ALTER COLUMN relationship_id SET DEFAULT nextval('public.entity_relationships_relationship_id_seq'::regclass);


--
-- Name: rule_sets rule_set_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rule_sets ALTER COLUMN rule_set_id SET DEFAULT nextval('public.rule_sets_rule_set_id_seq'::regclass);


--
-- Name: semantic_relationships semantic_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semantic_relationships ALTER COLUMN semantic_id SET DEFAULT nextval('public.semantic_relationships_semantic_id_seq'::regclass);


--
-- PostgreSQL database dump complete
--


