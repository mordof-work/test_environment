--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: agencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE agencies (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    gshift_url character varying(255),
    is_deleted boolean DEFAULT false,
    prevent_login boolean DEFAULT false,
    banner_account_id integer,
    leads_platform_cost integer,
    time_zone character varying(255) DEFAULT 'UTC'::character varying,
    has_ecommerce_ga boolean DEFAULT false,
    pause_all_keywords boolean DEFAULT false,
    node_id integer,
    clients_treated_like_agencies boolean DEFAULT false,
    trial boolean,
    last_accessed timestamp without time zone
);


--
-- Name: agencies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE agencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE agencies_id_seq OWNED BY agencies.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE clients (
    id integer NOT NULL,
    agency_id integer,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    domain_limit integer,
    logo_file_name character varying(255),
    account_manager_id integer,
    should_remove_agency_branding_from_reports boolean DEFAULT false,
    leads_platform_cost integer,
    can_use_locations_for_search_engines boolean,
    can_use_mobile_search_engines boolean,
    can_use_social_platforms boolean,
    is_suspended boolean,
    estimated_usage integer DEFAULT 0,
    can_use_constant_contact boolean,
    time_zone character varying(255),
    has_ecommerce_ga boolean DEFAULT false,
    can_use_content_performance boolean DEFAULT false,
    agency_recommendation_template_id integer,
    delete_this_now boolean DEFAULT false,
    s3_upload_credential_id integer,
    dropbox_upload_credential_id integer,
    node_id integer,
    billable_client boolean DEFAULT false,
    enforce_keyword_limit boolean,
    trial boolean
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE nodes (
    id integer NOT NULL,
    class_name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    parent_id integer,
    plan_summary text DEFAULT '{}'::text,
    plan_needs_review boolean DEFAULT true NOT NULL,
    modules text DEFAULT '{}'::text,
    is_deleted boolean DEFAULT false,
    name text,
    sitecondor_api_key character varying,
    sitecondor_account_type character varying,
    report_custom_label_id integer,
    scheduled_reports_paused boolean,
    data_start_date timestamp without time zone
);


--
-- Name: nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE nodes_id_seq OWNED BY nodes.id;


--
-- Name: presences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE presences (
    id integer NOT NULL,
    client_id integer,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    logo_file_name character varying(255),
    is_deleted boolean DEFAULT false NOT NULL,
    default_analytics_web_site_id integer,
    favorite_search_engine_id integer,
    blekko_enabled boolean DEFAULT true,
    backlink_estimates_enabled boolean DEFAULT false,
    keyword_limit integer,
    new_backlinks_enabled boolean DEFAULT true,
    backlink_total_type integer DEFAULT 0,
    backlink_override_allowed boolean DEFAULT false,
    include_off_site_in_data boolean DEFAULT true,
    client_recommendation_template_id integer,
    pause_all_keywords boolean DEFAULT false,
    majestic_access_key text,
    majestic_verified integer DEFAULT 0,
    majestic_account_info text DEFAULT '{}'::text,
    node_id integer,
    client_deleted boolean DEFAULT false,
    favorite_kluster_id integer
);


--
-- Name: presences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE presences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: presences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE presences_id_seq OWNED BY presences.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY agencies ALTER COLUMN id SET DEFAULT nextval('agencies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY nodes ALTER COLUMN id SET DEFAULT nextval('nodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY presences ALTER COLUMN id SET DEFAULT nextval('presences_id_seq'::regclass);


--
-- Name: agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agencies
    ADD CONSTRAINT agencies_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (id);


--
-- Name: presences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY presences
    ADD CONSTRAINT presences_pkey PRIMARY KEY (id);


--
-- Name: index_agencies_on_node_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_agencies_on_node_id ON agencies USING btree (node_id);


--
-- Name: index_clients_on_node_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_clients_on_node_id ON clients USING btree (node_id);


--
-- Name: index_presences_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presences_client_id ON presences USING btree (client_id);


--
-- Name: index_presences_on_node_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presences_on_node_id ON presences USING btree (node_id);


--
-- PostgreSQL database dump complete
--

