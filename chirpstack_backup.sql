--
-- PostgreSQL database dump
--

-- Dumped from database version 14.14
-- Dumped by pg_dump version 14.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __diesel_schema_migrations; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.__diesel_schema_migrations (
    version character varying(50) NOT NULL,
    run_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.__diesel_schema_migrations OWNER TO chirpstack;

--
-- Name: api_key; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.api_key (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    is_admin boolean NOT NULL,
    tenant_id uuid
);


ALTER TABLE public.api_key OWNER TO chirpstack;

--
-- Name: application; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.application (
    id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    mqtt_tls_cert bytea,
    tags jsonb NOT NULL
);


ALTER TABLE public.application OWNER TO chirpstack;

--
-- Name: application_integration; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.application_integration (
    application_id uuid NOT NULL,
    kind character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    configuration jsonb NOT NULL
);


ALTER TABLE public.application_integration OWNER TO chirpstack;

--
-- Name: device; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device (
    dev_eui bytea NOT NULL,
    application_id uuid NOT NULL,
    device_profile_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone,
    scheduler_run_after timestamp with time zone,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    external_power_source boolean NOT NULL,
    battery_level numeric(5,2),
    margin integer,
    dr smallint,
    latitude double precision,
    longitude double precision,
    altitude real,
    dev_addr bytea,
    enabled_class character(1) NOT NULL,
    skip_fcnt_check boolean NOT NULL,
    is_disabled boolean NOT NULL,
    tags jsonb NOT NULL,
    variables jsonb NOT NULL,
    join_eui bytea NOT NULL,
    secondary_dev_addr bytea,
    device_session bytea
);


ALTER TABLE public.device OWNER TO chirpstack;

--
-- Name: device_keys; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_keys (
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    nwk_key bytea NOT NULL,
    app_key bytea NOT NULL,
    dev_nonces jsonb NOT NULL,
    join_nonce integer NOT NULL
);


ALTER TABLE public.device_keys OWNER TO chirpstack;

--
-- Name: device_profile; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_profile (
    id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    region character varying(10) NOT NULL,
    mac_version character varying(10) NOT NULL,
    reg_params_revision character varying(20) NOT NULL,
    adr_algorithm_id character varying(100) NOT NULL,
    payload_codec_runtime character varying(20) NOT NULL,
    uplink_interval integer NOT NULL,
    device_status_req_interval integer NOT NULL,
    supports_otaa boolean NOT NULL,
    supports_class_b boolean NOT NULL,
    supports_class_c boolean NOT NULL,
    class_b_timeout integer NOT NULL,
    class_b_ping_slot_nb_k integer NOT NULL,
    class_b_ping_slot_dr smallint NOT NULL,
    class_b_ping_slot_freq bigint NOT NULL,
    class_c_timeout integer NOT NULL,
    abp_rx1_delay smallint NOT NULL,
    abp_rx1_dr_offset smallint NOT NULL,
    abp_rx2_dr smallint NOT NULL,
    abp_rx2_freq bigint NOT NULL,
    tags jsonb NOT NULL,
    payload_codec_script text NOT NULL,
    flush_queue_on_activate boolean NOT NULL,
    description text NOT NULL,
    measurements jsonb NOT NULL,
    auto_detect_measurements boolean NOT NULL,
    region_config_id character varying(100),
    is_relay boolean NOT NULL,
    is_relay_ed boolean NOT NULL,
    relay_ed_relay_only boolean NOT NULL,
    relay_enabled boolean NOT NULL,
    relay_cad_periodicity smallint NOT NULL,
    relay_default_channel_index smallint NOT NULL,
    relay_second_channel_freq bigint NOT NULL,
    relay_second_channel_dr smallint NOT NULL,
    relay_second_channel_ack_offset smallint NOT NULL,
    relay_ed_activation_mode smallint NOT NULL,
    relay_ed_smart_enable_level smallint NOT NULL,
    relay_ed_back_off smallint NOT NULL,
    relay_ed_uplink_limit_bucket_size smallint NOT NULL,
    relay_ed_uplink_limit_reload_rate smallint NOT NULL,
    relay_join_req_limit_reload_rate smallint NOT NULL,
    relay_notify_limit_reload_rate smallint NOT NULL,
    relay_global_uplink_limit_reload_rate smallint NOT NULL,
    relay_overall_limit_reload_rate smallint NOT NULL,
    relay_join_req_limit_bucket_size smallint NOT NULL,
    relay_notify_limit_bucket_size smallint NOT NULL,
    relay_global_uplink_limit_bucket_size smallint NOT NULL,
    relay_overall_limit_bucket_size smallint NOT NULL,
    allow_roaming boolean NOT NULL,
    rx1_delay smallint NOT NULL
);


ALTER TABLE public.device_profile OWNER TO chirpstack;

--
-- Name: device_profile_template; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_profile_template (
    id text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    vendor character varying(100) NOT NULL,
    firmware character varying(100) NOT NULL,
    region character varying(10) NOT NULL,
    mac_version character varying(10) NOT NULL,
    reg_params_revision character varying(20) NOT NULL,
    adr_algorithm_id character varying(100) NOT NULL,
    payload_codec_runtime character varying(20) NOT NULL,
    payload_codec_script text NOT NULL,
    uplink_interval integer NOT NULL,
    device_status_req_interval integer NOT NULL,
    flush_queue_on_activate boolean NOT NULL,
    supports_otaa boolean NOT NULL,
    supports_class_b boolean NOT NULL,
    supports_class_c boolean NOT NULL,
    class_b_timeout integer NOT NULL,
    class_b_ping_slot_nb_k integer NOT NULL,
    class_b_ping_slot_dr smallint NOT NULL,
    class_b_ping_slot_freq bigint NOT NULL,
    class_c_timeout integer NOT NULL,
    abp_rx1_delay smallint NOT NULL,
    abp_rx1_dr_offset smallint NOT NULL,
    abp_rx2_dr smallint NOT NULL,
    abp_rx2_freq bigint NOT NULL,
    tags jsonb NOT NULL,
    measurements jsonb NOT NULL,
    auto_detect_measurements boolean NOT NULL
);


ALTER TABLE public.device_profile_template OWNER TO chirpstack;

--
-- Name: device_queue_item; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_queue_item (
    id uuid NOT NULL,
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    f_port smallint NOT NULL,
    confirmed boolean NOT NULL,
    data bytea NOT NULL,
    is_pending boolean NOT NULL,
    f_cnt_down bigint,
    timeout_after timestamp with time zone,
    is_encrypted boolean NOT NULL,
    expires_at timestamp with time zone
);


ALTER TABLE public.device_queue_item OWNER TO chirpstack;

--
-- Name: gateway; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.gateway (
    gateway_id bytea NOT NULL,
    tenant_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    altitude real NOT NULL,
    stats_interval_secs integer NOT NULL,
    tls_certificate bytea,
    tags jsonb NOT NULL,
    properties jsonb NOT NULL
);


ALTER TABLE public.gateway OWNER TO chirpstack;

--
-- Name: multicast_group; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group (
    id uuid NOT NULL,
    application_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    region character varying(10) NOT NULL,
    mc_addr bytea NOT NULL,
    mc_nwk_s_key bytea NOT NULL,
    mc_app_s_key bytea NOT NULL,
    f_cnt bigint NOT NULL,
    group_type character(1) NOT NULL,
    dr smallint NOT NULL,
    frequency bigint NOT NULL,
    class_b_ping_slot_nb_k smallint NOT NULL,
    class_c_scheduling_type character varying(20) NOT NULL
);


ALTER TABLE public.multicast_group OWNER TO chirpstack;

--
-- Name: multicast_group_device; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group_device (
    multicast_group_id uuid NOT NULL,
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.multicast_group_device OWNER TO chirpstack;

--
-- Name: multicast_group_gateway; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group_gateway (
    multicast_group_id uuid NOT NULL,
    gateway_id bytea NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.multicast_group_gateway OWNER TO chirpstack;

--
-- Name: multicast_group_queue_item; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group_queue_item (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    scheduler_run_after timestamp with time zone NOT NULL,
    multicast_group_id uuid NOT NULL,
    gateway_id bytea NOT NULL,
    f_cnt bigint NOT NULL,
    f_port smallint NOT NULL,
    data bytea NOT NULL,
    emit_at_time_since_gps_epoch bigint,
    expires_at timestamp with time zone
);


ALTER TABLE public.multicast_group_queue_item OWNER TO chirpstack;

--
-- Name: relay_device; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.relay_device (
    relay_dev_eui bytea NOT NULL,
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.relay_device OWNER TO chirpstack;

--
-- Name: relay_gateway; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.relay_gateway (
    tenant_id uuid NOT NULL,
    relay_id bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    stats_interval_secs integer NOT NULL,
    region_config_id character varying(100) NOT NULL
);


ALTER TABLE public.relay_gateway OWNER TO chirpstack;

--
-- Name: tenant; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.tenant (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    can_have_gateways boolean NOT NULL,
    max_device_count integer NOT NULL,
    max_gateway_count integer NOT NULL,
    private_gateways_up boolean NOT NULL,
    private_gateways_down boolean NOT NULL,
    tags jsonb NOT NULL
);


ALTER TABLE public.tenant OWNER TO chirpstack;

--
-- Name: tenant_user; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.tenant_user (
    tenant_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_device_admin boolean NOT NULL,
    is_gateway_admin boolean NOT NULL
);


ALTER TABLE public.tenant_user OWNER TO chirpstack;

--
-- Name: user; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public."user" (
    id uuid NOT NULL,
    external_id text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_active boolean NOT NULL,
    email text NOT NULL,
    email_verified boolean NOT NULL,
    password_hash character varying(200) NOT NULL,
    note text NOT NULL
);


ALTER TABLE public."user" OWNER TO chirpstack;

--
-- Data for Name: __diesel_schema_migrations; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.__diesel_schema_migrations (version, run_on) FROM stdin;
00000000000000	2024-11-15 12:54:03.498929
20220426153628	2024-11-15 12:54:03.948156
20220428071028	2024-11-15 12:54:03.956759
20220511084032	2024-11-15 12:54:03.963712
20220614130020	2024-11-15 12:54:04.006868
20221102090533	2024-11-15 12:54:04.011889
20230103201442	2024-11-15 12:54:04.017746
20230112130153	2024-11-15 12:54:04.021888
20230206135050	2024-11-15 12:54:04.024318
20230213103316	2024-11-15 12:54:04.044359
20230216091535	2024-11-15 12:54:04.047653
20230925105457	2024-11-15 12:54:04.097616
20231019142614	2024-11-15 12:54:04.338309
20231122120700	2024-11-15 12:54:04.347542
20240207083424	2024-11-15 12:54:04.350996
20240326134652	2024-11-15 12:54:04.365203
20240430103242	2024-11-15 12:54:04.39303
20240613122655	2024-11-15 12:54:04.396591
20240916123034	2024-11-15 12:54:04.414193
20241112135745	2025-03-22 03:31:33.719375
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.api_key (id, created_at, name, is_admin, tenant_id) FROM stdin;
cd940028-b78b-486e-a9af-31837065bdbc	2025-03-22 04:56:11.325347+00	lora	t	\N
6ae14cf7-f851-4e2a-a89e-4ee4e20a1fdd	2025-03-22 05:00:46.170132+00	otra	t	\N
\.


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.application (id, tenant_id, created_at, updated_at, name, description, mqtt_tls_cert, tags) FROM stdin;
8d5752a8-fbfe-4050-aadd-70b509214f39	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-03-18 02:49:17.366851+00	2025-03-18 02:49:17.366851+00	T1000-A_AP		\N	{}
53586660-f658-4419-9cde-6cc3e474d540	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-01-20 01:07:45.926665+00	2025-03-19 10:57:29.490777+00	WioTerminal_AP		\N	{}
c67d98f0-a41e-43c8-92f1-9e7d1bd7b598	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-03-22 19:50:52.929621+00	2025-03-22 19:50:52.929621+00	TrackerD_AP		\N	{}
1af2dc17-2aa9-40ed-b52f-f2405e725b0f	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-04-23 02:01:47.826695+00	2025-04-23 02:01:47.826695+00	M5U_AP		\N	{}
\.


--
-- Data for Name: application_integration; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.application_integration (application_id, kind, created_at, updated_at, configuration) FROM stdin;
\.


--
-- Data for Name: device; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device (dev_eui, application_id, device_profile_id, created_at, updated_at, last_seen_at, scheduler_run_after, name, description, external_power_source, battery_level, margin, dr, latitude, longitude, altitude, dev_addr, enabled_class, skip_fcnt_check, is_disabled, tags, variables, join_eui, secondary_dev_addr, device_session) FROM stdin;
\\x5550000000000555	53586660-f658-4419-9cde-6cc3e474d540	8d4a04b0-68b6-4ee7-b4f7-e05f6b5d6cfb	2025-03-20 00:01:37.924654+00	2025-03-20 00:01:37.924654+00	2025-05-05 21:14:36.303459+00	\N	WioTerminal_02		f	\N	8	0	\N	\N	\N	\\x01cd0509	A	f	f	{}	{}	\\x5550000000000555	\N	\\x120401cd050920032a107bf37578eb9847ac9ca50c45a14d48fd32107bf37578eb9847ac9ca50c45a14d48fd3a107bf37578eb9847ac9ca50c45a14d48fd421212100ff1d2f409079a9996256e1e22faeb59489d04509d0470018001088801a0e1a1b80392010908090a0b0c0d0e0f41b00101b80101f2010c088904153333634120022808f2010c088a04150000504120022806f2010c088b04153333134120022806f2010c088c04150000604120022805f2010c088d0415cdcc5c4120022803f2010c088e04150000584120022802f2010c088f0415000060412002280af2010c089004150000184120022806f2010c089104150000604120022808f2010c08920415cdcc4c4120022803f2010c089304150000584120022807f2010c08940415cdcc5c4120022802f2010c08950415cdcc5c4120022806f2010c08960415cdcc5c4120022803f2010c089704150000504120022804f2010c089804150000584120022803f2010c089904150000184120022806f2010c089a0415cdcc5c4120022803f2010c089b0415cdcc4c4120022806f2010c089c0415cdcc5c412002280282020b08b8c6dfc0061088e2e018c2020775733931355f31
\\x20bb9da5b97addf2	1af2dc17-2aa9-40ed-b52f-f2405e725b0f	00163ec3-1e4f-46c8-a71d-cc6c578477f7	2025-04-23 02:05:29.75303+00	2025-04-23 02:05:29.75303+00	2025-04-28 14:49:44.363911+00	\N	M5U_01		f	39.37	13	3	\N	\N	\N	\\x00767305	A	f	f	{}	{}	\\x0300003000003000	\N	\\x12040076730520032a1078f6688d54e6b8c881c6eedd6948b558321078f6688d54e6b8c881c6eedd6948b5583a1078f6688d54e6b8c881c6eedd6948b55842121210d33d78afa53af801fbe9b0bf8a18b7374803500370018001088801a0e1a1b80392010908090a0b0c0d0e0f41b00101b80101c00104c80103d00101f20116080215cdcc0c411804200228daffffffffffffffff0182020c0881abbec0061088c6d0fa01c2020775733931355f31
\\x8880000000044444	53586660-f658-4419-9cde-6cc3e474d540	8d4a04b0-68b6-4ee7-b4f7-e05f6b5d6cfb	2025-01-20 01:10:11.152313+00	2025-03-19 10:58:12.944808+00	2025-05-05 21:21:35.249528+00	\N	WioTerminal_01		f	\N	11	2	\N	\N	\N	\\x01f7f415	A	f	f	{}	{}	\\x8880000000044444	\N	\\x120401f7f41520032a10f1f207f6ff1141d421bfea53310751793210f1f207f6ff1141d421bfea53310751793a10f1f207f6ff1141d421bfea533107517942121210ef1b3825f121809604edc4931db6614748970650950670018001088801a0e1a1b80392010908090a0b0c0d0e0f41b00101b80101c80102f2010c088306153333634120022801f2010c088406159a99814120022803f2010c088506150000684120022805f2010c088606153333634120022803f2010c08870615cdcc5c4120022801f2010c088806153333234120022803f2010c08890615cdcc6c4120022801f2010c088a06150000684120022803f2010c088b06153333634120022805f2010c088c06150000604120022801f2010c088d06159a99814120022803f2010c088e06150000684120022803f2010c088f06153333234120022801f2010c089006153333634120022801f2011508910615cdcc5c41200128f8ffffffffffffffff01f2010c089206159a99814120022803f2010c089306150000704120022805f2010c08940615cdcc6c4120022803f2010c089506150000604120022803f2010c08960615000068412002280182020b08e2ace0c00610c4ce8051c2020775733931355f31
\\x2cf7f1c054100368	8d5752a8-fbfe-4050-aadd-70b509214f39	4abd0824-efb0-4cd3-8487-e602ff6141f9	2025-03-18 02:50:31.35235+00	2025-03-18 02:50:31.35235+00	2025-05-05 21:23:08.734057+00	\N	T1000-A_01		f	100.00	12	3	\N	\N	\N	\\x01bc6988	A	f	f	{}	{}	\\x6b1d6d7a06ed0e50	\N	\\x120401bc698820042a104e2609fc0702331c5ea5a3abbb49c0b332104e2609fc0702331c5ea5a3abbb49c0b33a104e2609fc0702331c5ea5a3abbb49c0b342121210ef2479ee9242f19208b67b42ec86ef2548fd1f50b61d70018001088801a0e1a1b80392010908090a0b0c0d0e0f41b00101b80101c0010ac80103d00101f2011708e91f15cdcc2c41180a200228e5ffffffffffffffff01f2011708ea1f1533336341180a200228e7ffffffffffffffff01f2011708eb1f15cdcc6c41180a200228e8ffffffffffffffff01f2011708ec1f1500003041180a200228e5ffffffffffffffff01f2011708ed1f1500007041180a200228e7ffffffffffffffff01f2011708ee1f1500007841180a200228e5ffffffffffffffff01f2011708ef1f15cdcc6c41180a200228e6ffffffffffffffff01f2011708f01f15cdcc6c41180a200228e7ffffffffffffffff01f2011708f11f15cdcc6c41180a200228e4ffffffffffffffff01f2011708f21f1533336341180a200228e7ffffffffffffffff01f2011708f31f1500007041180a200228e8ffffffffffffffff01f2011708f41f1533336341180a200228e6ffffffffffffffff01f2011708f51f1500007841180a200228e5ffffffffffffffff01f2011708f61f1500006841180a200228e7ffffffffffffffff01f2011708f71f15cdcc6c41180a200228e4ffffffffffffffff01f2011708f81f1500003041180a200228e5ffffffffffffffff01f2011708f91f15cdcc6c41180a200228e7ffffffffffffffff01f2011708fa1f1533336341180a200228e7ffffffffffffffff01f2011708fb1f15cdcc2c41180a200228e5ffffffffffffffff01f2011708fc1f15cdcc7c41180a200228e5ffffffffffffffff0182020c089bdce3c00610c3d0e8c601c2020775733931355f31
\\xa84041fa318804dc	c67d98f0-a41e-43c8-92f1-9e7d1bd7b598	71d18d2f-fa17-4077-a575-1221b8344760	2025-03-22 19:51:51.167237+00	2025-03-22 19:51:51.167237+00	2025-04-30 17:19:25.213633+00	\N	TrackerD_01		f	\N	6	3	\N	\N	\N	\\x0064d88e	A	f	f	{}	{}	\\xa840410000000102	\N	\\x12040064d88e20032a104aa82f04e5cd9e3aa7e642be005d81bc32104aa82f04e5cd9e3aa7e642be005d81bc3a104aa82f04e5cd9e3aa7e642be005d81bc421212101c4ba26ff5d6f43fe71152cf222a807e70018001088801a0e1a1b80392010908090a0b0c0d0e0f41b00101b80101c2020775733931355f31
\.


--
-- Data for Name: device_keys; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_keys (dev_eui, created_at, updated_at, nwk_key, app_key, dev_nonces, join_nonce) FROM stdin;
\\x2cf7f1c054100368	2025-03-18 02:50:51.951256+00	2025-04-23 02:54:52.226899+00	\\xa24e7104898bd3227d75e86cb99120c8	\\x00000000000000000000000000000000	{"6b1d6d7a06ed0e50": [65535]}	4
\\x8880000000044444	2025-01-20 01:10:21.168625+00	2025-04-28 00:02:17.952633+00	\\x88800000000444448880000000044444	\\x00000000000000000000000000000000	{"8880000000044444": [35964, 11362, 5495, 29210, 14034, 58188, 48927, 48963, 48609, 13633, 11082, 9558, 11020, 11039]}	14
\\x20bb9da5b97addf2	2025-04-23 02:05:43.850949+00	2025-04-28 14:49:31.962042+00	\\x27dfe264ca33ac1957c005eb48ba4721	\\x00000000000000000000000000000000	{"0300003000003000": [65440, 35787, 55868, 7584, 64252, 32679, 11894, 10346, 39457, 9361, 31585, 27401, 22890, 9496, 52781, 54443, 38120, 5176, 20281, 25057, 21069, 2169, 50760, 45668, 49597, 9280, 22113, 5091, 25869, 32277, 62721, 4376]}	32
\\x5550000000000555	2025-03-20 00:01:41.011368+00	2025-04-29 21:43:03.493575+00	\\x55500000000005555550000000000555	\\x00000000000000000000000000000000	{"5550000000000555": [32727, 5459, 3975, 62601, 6604, 20624, 9127, 11061, 18704, 57660, 9859, 11514, 11884, 6960, 35986, 16668, 46907, 51063, 10525, 20691, 51573, 37545, 26065, 63893, 13283, 59457, 63690, 64684, 8908]}	29
\\xa84041fa318804dc	2025-03-22 19:52:08.59201+00	2025-04-30 17:19:33.366536+00	\\xa9f1d9180e496de4ffaf07865dd29c85	\\x00000000000000000000000000000000	{"a840410000000102": [26003, 27839, 14120, 34194, 699]}	17892
\.


--
-- Data for Name: device_profile; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_profile (id, tenant_id, created_at, updated_at, name, region, mac_version, reg_params_revision, adr_algorithm_id, payload_codec_runtime, uplink_interval, device_status_req_interval, supports_otaa, supports_class_b, supports_class_c, class_b_timeout, class_b_ping_slot_nb_k, class_b_ping_slot_dr, class_b_ping_slot_freq, class_c_timeout, abp_rx1_delay, abp_rx1_dr_offset, abp_rx2_dr, abp_rx2_freq, tags, payload_codec_script, flush_queue_on_activate, description, measurements, auto_detect_measurements, region_config_id, is_relay, is_relay_ed, relay_ed_relay_only, relay_enabled, relay_cad_periodicity, relay_default_channel_index, relay_second_channel_freq, relay_second_channel_dr, relay_second_channel_ack_offset, relay_ed_activation_mode, relay_ed_smart_enable_level, relay_ed_back_off, relay_ed_uplink_limit_bucket_size, relay_ed_uplink_limit_reload_rate, relay_join_req_limit_reload_rate, relay_notify_limit_reload_rate, relay_global_uplink_limit_reload_rate, relay_overall_limit_reload_rate, relay_join_req_limit_bucket_size, relay_notify_limit_bucket_size, relay_global_uplink_limit_bucket_size, relay_overall_limit_bucket_size, allow_roaming, rx1_delay) FROM stdin;
4abd0824-efb0-4cd3-8487-e602ff6141f9	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-03-18 02:48:55.005752+00	2025-03-18 02:51:28.749367+00	T1000-A_DP	US915	1.0.4	A	default	JS	3600	1	t	f	f	0	0	0	0	0	0	0	0	0	{}	function decodeUplink (input) {\n    const bytes = input['bytes']\n    const fport = parseInt(input['fPort'])\n    const bytesString = bytes2HexString(bytes)\n    const originMessage = bytesString.toLocaleUpperCase()\n    const decoded = {\n        valid: true,\n        err: 0,\n        payload: bytesString,\n        messages: []\n    }\n    if (fport === 199 || fport === 192) {\n        decoded.messages.push({fport: fport, payload: bytesString})\n        return { data: decoded }\n    }\n    let measurement = messageAnalyzed(originMessage)\n    if (measurement.length === 0) {\n        decoded.valid = false\n        return { data: decoded }\n    }\n\n    for (let message of measurement) {\n        if (message.length === 0) {\n            continue\n        }\n        let elements = []\n        for (let element of message) {\n            if (element.errorCode) {\n                decoded.err = element.errorCode\n                decoded.errMessage = element.error\n            } else {\n                elements.push(element)\n            }\n        }\n        if (elements.length > 0) {\n            decoded.messages.push(elements)\n        }\n    }\n    // decoded.messages = measurement\n    return { data: decoded }\n}\n\nfunction messageAnalyzed (messageValue) {\n    try {\n        let frames = unpack(messageValue)\n        let measurementResultArray = []\n        for (let i = 0; i < frames.length; i++) {\n            let item = frames[i]\n            let dataId = item.dataId\n            let dataValue = item.dataValue\n            let measurementArray = deserialize(dataId, dataValue)\n            measurementResultArray.push(measurementArray)\n        }\n        return measurementResultArray\n    } catch (e) {\n        return e.toString()\n    }\n}\n\nfunction unpack (messageValue) {\n    let frameArray = []\n\n    for (let i = 0; i < messageValue.length; i++) {\n        let remainMessage = messageValue\n        let dataId = remainMessage.substring(0, 2).toUpperCase()\n        let dataValue\n        let dataObj = {}\n        let packageLen\n        switch (dataId) {\n            case '01':\n                dataValue = remainMessage.substring(2, 94)\n                messageValue = remainMessage.substring(94)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '02':\n                dataValue = remainMessage.substring(2, 32)\n                messageValue = remainMessage.substring(32)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '03':\n                dataValue = remainMessage.substring(2, 64)\n                messageValue = remainMessage.substring(64)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '04':\n                dataValue = remainMessage.substring(2, 20)\n                messageValue = remainMessage.substring(20)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '05':\n                dataValue = remainMessage.substring(2, 10)\n                messageValue = remainMessage.substring(10)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '06':\n                dataValue = remainMessage.substring(2, 44)\n                messageValue = remainMessage.substring(44)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '07':\n                dataValue = remainMessage.substring(2, 84)\n                messageValue = remainMessage.substring(84)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '08':\n                dataValue = remainMessage.substring(2, 70)\n                messageValue = remainMessage.substring(70)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '09':\n                dataValue = remainMessage.substring(2, 36)\n                messageValue = remainMessage.substring(36)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '0A':\n                dataValue = remainMessage.substring(2, 76)\n                messageValue = remainMessage.substring(76)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '0B':\n                dataValue = remainMessage.substring(2, 62)\n                messageValue = remainMessage.substring(62)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '0C':\n                break\n            case '0D':\n                dataValue = remainMessage.substring(2, 10)\n                messageValue = remainMessage.substring(10)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '0E':\n                packageLen = getInt(remainMessage.substring(8, 10)) * 2 + 10\n                dataValue = remainMessage.substring(2, 8) + remainMessage.substring(10, packageLen)\n                messageValue = remainMessage.substring(packageLen)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '0F':\n                dataValue = remainMessage.substring(2, 34)\n                messageValue = remainMessage.substring(34)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '10':\n                dataValue = remainMessage.substring(2, 26)\n                messageValue = remainMessage.substring(26)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '11':\n                dataValue = remainMessage.substring(2, 28)\n                messageValue = remainMessage.substring(28)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '1A':\n                dataValue = remainMessage.substring(2, 56)\n                messageValue = remainMessage.substring(56)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '1B':\n                dataValue = remainMessage.substring(2, 96)\n                messageValue = remainMessage.substring(96)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '1C':\n                dataValue = remainMessage.substring(2, 82)\n                messageValue = remainMessage.substring(82)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            case '1D':\n                dataValue = remainMessage.substring(2, 40)\n                messageValue = remainMessage.substring(40)\n                dataObj = {\n                    'dataId': dataId, 'dataValue': dataValue\n                }\n                break\n            default:\n                return frameArray\n        }\n        if (dataValue.length < 2) {\n            break\n        }\n        frameArray.push(dataObj)\n    }\n    return frameArray\n}\n\nfunction deserialize (dataId, dataValue) {\n    let measurementArray = []\n    let eventList = []\n    let measurement = {}\n    let collectTime = 0\n    let groupId = 0\n    let shardFlag = {}\n    let payload = ''\n    let motionId = ''\n    switch (dataId) {\n        case '01':\n            measurementArray = getUpShortInfo(dataValue)\n            measurementArray.push(...getMotionSetting(dataValue.substring(30, 40)))\n            measurementArray.push(...getStaticSetting(dataValue.substring(40, 46)))\n            measurementArray.push(...getShockSetting(dataValue.substring(46, 52)))\n            measurementArray.push(...getTempSetting(dataValue.substring(52, 72)))\n            measurementArray.push(...getLightSetting(dataValue.substring(72, 92)))\n            break\n        case '02':\n            measurementArray = getUpShortInfo(dataValue)\n            break\n        case '03':\n            measurementArray.push(...getMotionSetting(dataValue.substring(0, 10)))\n            measurementArray.push(...getStaticSetting(dataValue.substring(10, 16)))\n            measurementArray.push(...getShockSetting(dataValue.substring(16, 22)))\n            measurementArray.push(...getTempSetting(dataValue.substring(22, 42)))\n            measurementArray.push(...getLightSetting(dataValue.substring(42, 62)))\n            break\n        case '04':\n            let interval = 0\n            let workMode = getInt(dataValue.substring(0, 2))\n            let heartbeatInterval = getMinsByMin(dataValue.substring(4, 8))\n            let periodicInterval = getMinsByMin(dataValue.substring(8, 12))\n            let eventInterval = getMinsByMin(dataValue.substring(12, 16))\n            switch (workMode) {\n                case 0:\n                    interval = heartbeatInterval\n                    break\n                case 1:\n                    interval = periodicInterval\n                    break\n                case 2:\n                    interval = eventInterval\n                    break\n            }\n            measurementArray = [\n                {measurementId: '3940', type: 'Work Mode', measurementValue: workMode},\n                {measurementId: '3942', type: 'Heartbeat Interval', measurementValue: heartbeatInterval},\n                {measurementId: '3943', type: 'Periodic Interval', measurementValue: periodicInterval},\n                {measurementId: '3944', type: 'Event Interval', measurementValue: eventInterval},\n                {measurementId: '3941', type: 'SOS Mode', measurementValue: getSOSMode(dataValue.substring(16, 18))},\n                {measurementId: '3900', type: 'Uplink Interval', measurementValue: interval}\n            ]\n            break;\n        case '05':\n            measurementArray = [\n                {measurementId: '3000', type: 'Battery', measurementValue: getBattery(dataValue.substring(0, 2))},\n                {measurementId: '3940', type: 'Work Mode', measurementValue: getWorkingMode(dataValue.substring(2, 4))},\n                {measurementId: '3965', type: 'Positioning Strategy', measurementValue: getPositioningStrategy(dataValue.substring(4, 6))},\n                {measurementId: '3941', type: 'SOS Mode', measurementValue: getSOSMode(dataValue.substring(6, 8))}\n            ]\n            break\n        case '06':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId: motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '4197', timestamp: collectTime, motionId: motionId, type: 'Longitude', measurementValue: parseFloat(getSensorValue(dataValue.substring(16, 24), 1000000))},\n                {measurementId: '4198', timestamp: collectTime, motionId: motionId, type: 'Latitude', measurementValue: parseFloat(getSensorValue(dataValue.substring(24, 32), 1000000))},\n                {measurementId: '4097', timestamp: collectTime, motionId: motionId, type: 'Air Temperature', measurementValue: getSensorValue(dataValue.substring(32, 36), 10)},\n                {measurementId: '4199', timestamp: collectTime, motionId: motionId, type: 'Light', measurementValue: getSensorValue(dataValue.substring(36, 40))},\n                {measurementId: '3000', timestamp: collectTime, motionId: motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(40, 42))}\n            ]\n            break\n        case '07':\n            eventList = getEventStatus(dataValue.substring(0, 6))\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId: motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '5001', timestamp: collectTime, motionId: motionId, type: 'Wi-Fi Scan', measurementValue: getMacAndRssiObj(dataValue.substring(16, 72))},\n                {measurementId: '4097', timestamp: collectTime, motionId: motionId, type: 'Air Temperature', measurementValue: getSensorValue(dataValue.substring(72, 76), 10)},\n                {measurementId: '4199', timestamp: collectTime, motionId: motionId, type: 'Light', measurementValue: getSensorValue(dataValue.substring(76, 80))},\n                {measurementId: '3000', timestamp: collectTime, motionId: motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(80, 82))}\n            ]\n            break\n        case '08':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId: motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '5002', timestamp: collectTime, motionId: motionId, type: 'BLE Scan', measurementValue: getMacAndRssiObj(dataValue.substring(16, 58))},\n                {measurementId: '4097', timestamp: collectTime, motionId: motionId, type: 'Air Temperature', measurementValue: getSensorValue(dataValue.substring(58, 62), 10)},\n                {measurementId: '4199', timestamp: collectTime, motionId: motionId, type: 'Light', measurementValue: getSensorValue(dataValue.substring(62, 66))},\n                {measurementId: '3000', timestamp: collectTime, motionId: motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(66, 68))}\n            ]\n            break\n        case '09':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId: motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '4197', timestamp: collectTime, motionId: motionId, type: 'Longitude', measurementValue: parseFloat(getSensorValue(dataValue.substring(16, 24), 1000000))},\n                {measurementId: '4198', timestamp: collectTime, motionId: motionId, type: 'Latitude', measurementValue: parseFloat(getSensorValue(dataValue.substring(24, 32), 1000000))},\n                {measurementId: '3000', timestamp: collectTime, motionId: motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(32, 34))}\n            ]\n            break\n        case '0A':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '5001', timestamp: collectTime, motionId, type: 'Wi-Fi Scan', measurementValue: getMacAndRssiObj(dataValue.substring(16, 72))},\n                {measurementId: '3000', timestamp: collectTime, motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(72, 74))}\n            ]\n            break\n        case '0B':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '5002', timestamp: collectTime, motionId, type: 'BLE Scan', measurementValue: getMacAndRssiObj(dataValue.substring(16, 58))},\n                {measurementId: '3000', timestamp: collectTime, motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(58, 60))},\n            ]\n            break\n        case '0D':\n            let errorCode = getInt(dataValue)\n            let error = ''\n            switch (errorCode) {\n                case 1:\n                    error = 'FAILED TO OBTAIN THE UTC TIMESTAMP'\n                    break\n                case 2:\n                    error = 'ALMANAC TOO OLD'\n                    break\n                case 3:\n                    error = 'DOPPLER ERROR'\n                    break\n            }\n            measurementArray.push({errorCode, error})\n            break\n        case '0E':\n            shardFlag = getShardFlag(dataValue.substring(0, 2))\n            groupId = getInt(dataValue.substring(2, 6))\n            payload = dataValue.substring(6)\n            measurement = {\n                measurementId: '6152',\n                groupId: groupId,\n                index: shardFlag.index,\n                count: shardFlag.count,\n                type: 'gnss-ng payload',\n                measurementValue: payload\n            }\n            measurementArray.push(measurement)\n            break\n        case '0F':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            shardFlag = getShardFlag(dataValue.substring(26, 28))\n            groupId = getInt(dataValue.substring(28, 32))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray.push({\n                measurementId: '4200',\n                timestamp: collectTime,\n                motionId,\n                groupId: groupId,\n                index: shardFlag.index,\n                count: shardFlag.count,\n                type: 'Event Status',\n                measurementValue: getEventStatus(dataValue.substring(0, 6))\n            })\n            measurementArray.push({\n                measurementId: '4097',\n                timestamp: collectTime,\n                motionId,\n                groupId: groupId,\n                index: shardFlag.index,\n                count: shardFlag.count,\n                type: 'Air Temperature',\n                measurementValue: getSensorValue(dataValue.substring(16, 20), 10)\n            })\n            measurementArray.push({\n                measurementId: '4199',\n                timestamp: collectTime,\n                motionId,\n                groupId: groupId,\n                index: shardFlag.index,\n                count: shardFlag.count,\n                type: 'Light',\n                measurementValue: getSensorValue(dataValue.substring(20, 24))\n            })\n            measurementArray.push({\n                measurementId: '3000',\n                timestamp: collectTime,\n                motionId,\n                groupId: groupId,\n                index: shardFlag.index,\n                count: shardFlag.count,\n                type: 'Battery',\n                measurementValue: getBattery(dataValue.substring(24, 26))\n            })\n            break\n        case '10':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            shardFlag = getShardFlag(dataValue.substring(18, 20))\n            groupId = getInt(dataValue.substring(20, 24))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray.push({\n                measurementId: '4200',\n                timestamp: collectTime,\n                motionId,\n                groupId: groupId,\n                index: shardFlag.index,\n                count: shardFlag.count,\n                type: 'Event Status',\n                measurementValue: getEventStatus(dataValue.substring(0, 6))\n            })\n            measurementArray.push({\n                measurementId: '3000',\n                timestamp: collectTime,\n                motionId,\n                groupId: groupId,\n                index: shardFlag.index,\n                count: shardFlag.count,\n                type: 'Battery',\n                measurementValue: getBattery(dataValue.substring(16, 18))\n            })\n            break\n        case '11':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            measurementArray.push({\n                measurementId: '3576',\n                timestamp: collectTime,\n                type: 'Positioning Status',\n                measurementValue: getPositingStatus(dataValue.substring(0, 2))\n            })\n            measurementArray.push({\n                timestamp: collectTime,\n                measurementId: '4200',\n                type: 'Event Status',\n                measurementValue: getEventStatus(dataValue.substring(2, 8))\n            })\n            if (!isNaN(parseFloat(getSensorValue(dataValue.substring(16, 20), 10)))) {\n                measurementArray.push({\n                    timestamp: collectTime,\n                    measurementId: '4097',\n                    type: 'Air Temperature',\n                    measurementValue: getSensorValue(dataValue.substring(16, 20), 10)\n                })\n            }\n            if (!isNaN(parseFloat(getSensorValue(dataValue.substring(20, 24))))) {\n                measurementArray.push({\n                    timestamp: collectTime,\n                    measurementId: '4199',\n                    type: 'Light',\n                    measurementValue: getSensorValue(dataValue.substring(20, 24))\n                })\n            }\n            measurementArray.push({\n                timestamp: collectTime,\n                measurementId: '3000',\n                type: 'Battery',\n                measurementValue: getBattery(dataValue.substring(24, 26))\n            })\n            break\n        case '1A':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '4197', timestamp: collectTime, motionId, type: 'Longitude', measurementValue: parseFloat(getSensorValue(dataValue.substring(16, 24), 1000000))},\n                {measurementId: '4198', timestamp: collectTime, motionId, type: 'Latitude', measurementValue: parseFloat(getSensorValue(dataValue.substring(24, 32), 1000000))},\n                {measurementId: '4097', timestamp: collectTime, motionId, type: 'Air Temperature', measurementValue: getSensorValue(dataValue.substring(32, 36), 10)},\n                {measurementId: '4199', timestamp: collectTime, motionId, type: 'Light', measurementValue: getSensorValue(dataValue.substring(36, 40))},\n                {measurementId: '4210', timestamp: collectTime, motionId, type: 'AccelerometerX', measurementValue: getSensorValue(dataValue.substring(40, 44))},\n                {measurementId: '4211', timestamp: collectTime, motionId, type: 'AccelerometerY', measurementValue: getSensorValue(dataValue.substring(44, 48))},\n                {measurementId: '4212', timestamp: collectTime, motionId, type: 'AccelerometerZ', measurementValue: getSensorValue(dataValue.substring(48, 52))},\n                {measurementId: '3000', timestamp: collectTime, motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(52, 54))},\n            ]\n            break\n        // WIFI定位数据+sensor+三轴+电量\n        case '1B':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '5001', timestamp: collectTime, motionId, type: 'Wi-Fi Scan', measurementValue: getMacAndRssiObj(dataValue.substring(16, 72))},\n                {measurementId: '4097', timestamp: collectTime, motionId, type: 'Air Temperature', measurementValue: getSensorValue(dataValue.substring(72, 76), 10)},\n                {measurementId: '4199', timestamp: collectTime, motionId, type: 'Light', measurementValue: getSensorValue(dataValue.substring(76, 80))},\n                {measurementId: '4210', timestamp: collectTime, motionId, type: 'AccelerometerX', measurementValue: getSensorValue(dataValue.substring(80, 84))},\n                {measurementId: '4211', timestamp: collectTime, motionId, type: 'AccelerometerY', measurementValue: getSensorValue(dataValue.substring(84, 88))},\n                {measurementId: '4212', timestamp: collectTime, motionId, type: 'AccelerometerZ', measurementValue: getSensorValue(dataValue.substring(88, 92))},\n                {measurementId: '3000', timestamp: collectTime, motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(92, 94))}\n            ]\n            break\n        // BLE定位数据+sensor+三轴+电量\n        case '1C':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            motionId = getMotionId(dataValue.substring(6, 8))\n            measurementArray = [\n                {measurementId: '4200', timestamp: collectTime, motionId, type: 'Event Status', measurementValue: getEventStatus(dataValue.substring(0, 6))},\n                {measurementId: '5002', timestamp: collectTime, motionId, type: 'BLE Scan', measurementValue: getMacAndRssiObj(dataValue.substring(16, 58))},\n                {measurementId: '4097', timestamp: collectTime, motionId, type: 'Air Temperature', measurementValue: getSensorValue(dataValue.substring(58, 62), 10)},\n                {measurementId: '4199', timestamp: collectTime, motionId, type: 'Light', measurementValue: getSensorValue(dataValue.substring(62, 66))},\n                {measurementId: '4210', timestamp: collectTime, motionId, type: 'AccelerometerX', measurementValue: getSensorValue(dataValue.substring(66, 70))},\n                {measurementId: '4211', timestamp: collectTime, motionId, type: 'AccelerometerY', measurementValue: getSensorValue(dataValue.substring(70, 74))},\n                {measurementId: '4212', timestamp: collectTime, motionId, type: 'AccelerometerZ', measurementValue: getSensorValue(dataValue.substring(74, 78))},\n                {measurementId: '3000', timestamp: collectTime, motionId, type: 'Battery', measurementValue: getBattery(dataValue.substring(78, 80))}\n            ]\n            break\n        // 定位状态 + sensor+三轴数据上报\n        case '1D':\n            collectTime = getUTCTimestamp(dataValue.substring(8, 16))\n            measurementArray.push({\n                measurementId: '3576',\n                timestamp: collectTime,\n                type: 'Positioning Status',\n                measurementValue: getPositingStatus(dataValue.substring(0, 2))\n            })\n            measurementArray.push({\n                timestamp: collectTime,\n                measurementId: '4200',\n                type: 'Event Status',\n                measurementValue: getEventStatus(dataValue.substring(2, 8))\n            })\n            if (!isNaN(parseFloat(getSensorValue(dataValue.substring(16, 20), 10)))) {\n                measurementArray.push({\n                    timestamp: collectTime,\n                    measurementId: '4097',\n                    type: 'Air Temperature',\n                    measurementValue: getSensorValue(dataValue.substring(16, 20), 10)\n                })\n            }\n            if (!isNaN(parseFloat(getSensorValue(dataValue.substring(20, 24))))) {\n                measurementArray.push({\n                    timestamp: collectTime,\n                    measurementId: '4199',\n                    type: 'Light',\n                    measurementValue: getSensorValue(dataValue.substring(20, 24))\n                })\n            }\n            measurementArray.push({\n                timestamp: collectTime,\n                measurementId: '4210',\n                type: 'AccelerometerX',\n                measurementValue: getSensorValue(dataValue.substring(24, 28))\n            })\n            measurementArray.push({\n                timestamp: collectTime,\n                measurementId: '4211',\n                type: 'AccelerometerY',\n                measurementValue: getSensorValue(dataValue.substring(28, 32))\n            })\n            measurementArray.push({\n                timestamp: collectTime,\n                measurementId: '4212',\n                type: 'AccelerometerZ',\n                measurementValue: getSensorValue(dataValue.substring(32, 36))\n            })\n            measurementArray.push({\n                timestamp: collectTime,\n                measurementId: '3000',\n                type: 'Battery',\n                measurementValue: getBattery(dataValue.substring(36, 38))\n            })\n            break\n    }\n    return measurementArray\n}\n\nfunction getMotionId (str) {\n    return getInt(str)\n}\n\nfunction getPositingStatus (str) {\n    let status = getInt(str)\n    switch (status) {\n        case 0:\n            return {id:status, statusName:"Positioning successful."}\n        case 1:\n            return {id:status, statusName:"The GNSS scan timed out and failed to obtain the location."}\n        case 2:\n            return {id:status, statusName:"The Wi-Fi scan timed out and failed to obtain the location."}\n        case 3:\n            return {id:status, statusName:"The Wi-Fi + GNSS scan timed out and failed to obtain the location."}\n        case 4:\n            return {id:status, statusName:"The GNSS + Wi-Fi scan timed out and failed to obtain the location."}\n        case 5:\n            return {id:status, statusName:"The Bluetooth scan timed out and failed to obtain the location."}\n        case 6:\n            return {id:status, statusName:"The Bluetooth + Wi-Fi scan timed out and failed to obtain the location."}\n        case 7:\n            return {id:status, statusName:"The Bluetooth + GNSS scan timed out and failed to obtain the location."}\n        case 8:\n            return {id:status, statusName:"The Bluetooth + Wi-Fi + GNSS scan timed out and failed to obtain the location."}\n        case 9:\n            return {id:status, statusName:"Location Server failed to parse the GNSS location."}\n        case 10:\n            return {id:status, statusName:"Location Server failed to parse the Wi-Fi location."}\n        case 11:\n            return {id:status, statusName:"Location Server failed to parse the Bluetooth location."}\n        case 12:\n            return {id:status, statusName:"Failed to parse the GNSS location due to the poor accuracy."}\n        case 13:\n            return {id:status, statusName:"Time synchronization failed."}\n        case 14:\n            return {id:status, statusName:"Failed to obtain location due to the old Almanac."}\n    }\n    return getInt(str)\n}\n\nfunction getUpShortInfo (messageValue) {\n    return [\n        {\n            measurementId: '3000', type: 'Battery', measurementValue: getBattery(messageValue.substring(0, 2))\n        }, {\n            measurementId: '3502', type: 'Firmware Version', measurementValue: getSoftVersion(messageValue.substring(2, 6))\n        }, {\n            measurementId: '3001', type: 'Hardware Version', measurementValue: getHardVersion(messageValue.substring(6, 10))\n        }, {\n            measurementId: '3940', type: 'Work Mode', measurementValue: getWorkingMode(messageValue.substring(10, 12))\n        }, {\n            measurementId: '3965', type: 'Positioning Strategy', measurementValue: getPositioningStrategy(messageValue.substring(12, 14))\n        }, {\n            measurementId: '3942', type: 'Heartbeat Interval', measurementValue: getMinsByMin(messageValue.substring(14, 18))\n        }, {\n            measurementId: '3943', type: 'Periodic Interval', measurementValue: getMinsByMin(messageValue.substring(18, 22))\n        }, {\n            measurementId: '3944', type: 'Event Interval', measurementValue: getMinsByMin(messageValue.substring(22, 26))\n        }, {\n            measurementId: '3945', type: 'Sensor Enable', measurementValue: getInt(messageValue.substring(26, 28))\n        }, {\n            measurementId: '3941', type: 'SOS Mode', measurementValue: getSOSMode(messageValue.substring(28, 30))\n        }\n    ]\n}\n\nfunction getMotionSetting (str) {\n    return [\n        {measurementId: '3946', type: 'Motion Enable', measurementValue: getInt(str.substring(0, 2))},\n        {measurementId: '3947', type: 'Any Motion Threshold', measurementValue: getSensorValue(str.substring(2, 6), 1)},\n        {measurementId: '3948', type: 'Motion Start Interval', measurementValue: getMinsByMin(str.substring(6, 10))},\n    ]\n}\n\nfunction getStaticSetting (str) {\n    return [\n        {measurementId: '3949', type: 'Static Enable', measurementValue: getInt(str.substring(0, 2))},\n        {measurementId: '3950', type: 'Device Static Timeout', measurementValue: getMinsByMin(str.substring(2, 6))}\n    ]\n}\n\nfunction getShockSetting (str) {\n    return [\n        {measurementId: '3951', type: 'Shock Enable', measurementValue: getInt(str.substring(0, 2))},\n        {measurementId: '3952', type: 'Shock Threshold', measurementValue: getInt(str.substring(2, 6))}\n    ]\n}\n\nfunction getTempSetting (str) {\n    return [\n        {measurementId: '3953', type: 'Temp Enable', measurementValue: getInt(str.substring(0, 2))},\n        {measurementId: '3954', type: 'Event Temp Interval', measurementValue: getMinsByMin(str.substring(2, 6))},\n        {measurementId: '3955', type: 'Event Temp Sample Interval', measurementValue: getSecondsByInt(str.substring(6, 10))},\n        {measurementId: '3956', type: 'Temp ThMax', measurementValue: getSensorValue(str.substring(10, 14), 10)},\n        {measurementId: '3957', type: 'Temp ThMin', measurementValue: getSensorValue(str.substring(14, 18), 10)},\n        {measurementId: '3958', type: 'Temp Warning Type', measurementValue: getInt(str.substring(18, 20))}\n    ]\n}\n\nfunction getLightSetting (str) {\n    return [\n        {measurementId: '3959', type: 'Light Enable', measurementValue: getInt(str.substring(0, 2))},\n        {measurementId: '3960', type: 'Event Light Interval', measurementValue: getMinsByMin(str.substring(2, 6))},\n        {measurementId: '3961', type: 'Event Light Sample Interval', measurementValue: getSecondsByInt(str.substring(6, 10))},\n        {measurementId: '3962', type: 'Light ThMax', measurementValue: getSensorValue(str.substring(10, 14), 10)},\n        {measurementId: '3963', type: 'Light ThMin', measurementValue: getSensorValue(str.substring(14, 18), 10)},\n        {measurementId: '3964', type: 'Light Warning Type', measurementValue: getInt(str.substring(18, 20))}\n    ]\n}\n\nfunction getShardFlag (str) {\n    let bitStr = getByteArray(str)\n    return {\n        count: parseInt(bitStr.substring(0, 4), 2),\n        index: parseInt(bitStr.substring(4), 2)\n    }\n}\n\nfunction getBattery (batteryStr) {\n    return loraWANV2DataFormat(batteryStr)\n}\nfunction getSoftVersion (softVersion) {\n    return `${loraWANV2DataFormat(softVersion.substring(0, 2))}.${loraWANV2DataFormat(softVersion.substring(2, 4))}`\n}\nfunction getHardVersion (hardVersion) {\n    return `${loraWANV2DataFormat(hardVersion.substring(0, 2))}.${loraWANV2DataFormat(hardVersion.substring(2, 4))}`\n}\n\nfunction getSecondsByInt (str) {\n    return getInt(str)\n}\n\nfunction getMinsByMin (str) {\n    return getInt(str)\n}\n\nfunction getSensorValue (str, dig) {\n    if (str === '8000') {\n        return null\n    } else {\n        return loraWANV2DataFormat(str, dig)\n    }\n}\n\nfunction bytes2HexString (arrBytes) {\n    var str = ''\n    for (var i = 0; i < arrBytes.length; i++) {\n        var tmp\n        var num = arrBytes[i]\n        if (num < 0) {\n            tmp = (255 + num + 1).toString(16)\n        } else {\n            tmp = num.toString(16)\n        }\n        if (tmp.length === 1) {\n            tmp = '0' + tmp\n        }\n        str += tmp\n    }\n    return str\n}\nfunction loraWANV2DataFormat (str, divisor = 1) {\n    let strReverse = bigEndianTransform(str)\n    let str2 = toBinary(strReverse)\n    if (str2.substring(0, 1) === '1') {\n        let arr = str2.split('')\n        let reverseArr = arr.map((item) => {\n            if (parseInt(item) === 1) {\n                return 0\n            } else {\n                return 1\n            }\n        })\n        str2 = parseInt(reverseArr.join(''), 2) + 1\n        return parseFloat('-' + str2 / divisor)\n    }\n    return parseInt(str2, 2) / divisor\n}\n\nfunction bigEndianTransform (data) {\n    let dataArray = []\n    for (let i = 0; i < data.length; i += 2) {\n        dataArray.push(data.substring(i, i + 2))\n    }\n    return dataArray\n}\n\nfunction toBinary (arr) {\n    let binaryData = arr.map((item) => {\n        let data = parseInt(item, 16)\n            .toString(2)\n        let dataLength = data.length\n        if (data.length !== 8) {\n            for (let i = 0; i < 8 - dataLength; i++) {\n                data = `0` + data\n            }\n        }\n        return data\n    })\n    return binaryData.toString().replace(/,/g, '')\n}\n\nfunction getSOSMode (str) {\n    return loraWANV2DataFormat(str)\n}\n\nfunction getMacAndRssiObj (pair) {\n    let pairs = []\n    if (pair.length % 14 === 0) {\n        for (let i = 0; i < pair.length; i += 14) {\n            let mac = getMacAddress(pair.substring(i, i + 12))\n            if (mac) {\n                let rssi = getInt8RSSI(pair.substring(i + 12, i + 14))\n                pairs.push({mac: mac, rssi: rssi})\n            } else {\n                continue\n            }\n        }\n    }\n    return pairs\n}\n\nfunction getMacAddress (str) {\n    if (str.toLowerCase() === 'ffffffffffff') {\n        return null\n    }\n    let macArr = []\n    for (let i = 1; i < str.length; i++) {\n        if (i % 2 === 1) {\n            macArr.push(str.substring(i - 1, i + 1))\n        }\n    }\n    let mac = ''\n    for (let i = 0; i < macArr.length; i++) {\n        mac = mac + macArr[i]\n        if (i < macArr.length - 1) {\n            mac = mac + ':'\n        }\n    }\n    return mac\n}\n\nfunction getInt8RSSI (str) {\n    return loraWANV2DataFormat(str)\n}\n\nfunction getInt (str) {\n    return parseInt(str, 16)\n}\n\nfunction getEventStatus (str) {\n    // return getInt(str)\n    let bitStr = getByteArray(str)\n    let bitArr = []\n    for (let i = 0; i < bitStr.length; i++) {\n        bitArr[i] = bitStr.substring(i, i + 1)\n    }\n    bitArr = bitArr.reverse()\n    let event = []\n    for (let i = 0; i < bitArr.length; i++) {\n        if (bitArr[i] !== '1') {\n            continue\n        }\n        switch (i){\n            case 0:\n                event.push({id:1, eventName:"Start moving event."})\n                break\n            case 1:\n                event.push({id:2, eventName:"End movement event."})\n                break\n            case 2:\n                event.push({id:3, eventName:"Motionless event."})\n                break\n            case 3:\n                event.push({id:4, eventName:"Shock event."})\n                break\n            case 4:\n                event.push({id:5, eventName:"Temperature event."})\n                break\n            case 5:\n                event.push({id:6, eventName:"Light event."})\n                break\n            case 6:\n                event.push({id:7, eventName:"SOS event."})\n                break\n            case 7:\n                event.push({id:8, eventName:"Press once event."})\n                break\n        }\n    }\n    return event\n}\n\nfunction getByteArray (str) {\n    let bytes = []\n    for (let i = 0; i < str.length; i += 2) {\n        bytes.push(str.substring(i, i + 2))\n    }\n    return toBinary(bytes)\n}\n\nfunction getWorkingMode (workingMode) {\n    return getInt(workingMode)\n}\n\nfunction getPositioningStrategy (strategy) {\n    return getInt(strategy)\n}\n\nfunction getUTCTimestamp(str){\n    return parseInt(loraWANV2PositiveDataFormat(str)) * 1000\n}\n\nfunction loraWANV2PositiveDataFormat (str, divisor = 1) {\n    let strReverse = bigEndianTransform(str)\n    let str2 = toBinary(strReverse)\n    return parseInt(str2, 2) / divisor\n}	t		{"err": {"kind": "UNKNOWN", "name": ""}, "valid": {"kind": "UNKNOWN", "name": ""}, "payload": {"kind": "UNKNOWN", "name": ""}, "errMessage": {"kind": "UNKNOWN", "name": ""}, "messages_0_0_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_1_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_2_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_3_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_4_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_5_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_6_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_7_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_8_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_9_type": {"kind": "UNKNOWN", "name": ""}, "messages_0_0_motionId": {"kind": "UNKNOWN", "name": ""}, "messages_0_1_motionId": {"kind": "UNKNOWN", "name": ""}, "messages_0_2_motionId": {"kind": "UNKNOWN", "name": ""}, "messages_0_3_motionId": {"kind": "UNKNOWN", "name": ""}, "messages_0_4_motionId": {"kind": "UNKNOWN", "name": ""}, "messages_0_5_motionId": {"kind": "UNKNOWN", "name": ""}, "messages_0_0_timestamp": {"kind": "UNKNOWN", "name": ""}, "messages_0_1_timestamp": {"kind": "UNKNOWN", "name": ""}, "messages_0_2_timestamp": {"kind": "UNKNOWN", "name": ""}, "messages_0_3_timestamp": {"kind": "UNKNOWN", "name": ""}, "messages_0_4_timestamp": {"kind": "UNKNOWN", "name": ""}, "messages_0_5_timestamp": {"kind": "UNKNOWN", "name": ""}, "messages_0_0_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_1_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_2_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_3_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_4_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_5_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_6_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_7_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_8_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_9_measurementId": {"kind": "UNKNOWN", "name": ""}, "messages_0_0_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_1_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_2_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_3_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_4_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_5_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_6_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_7_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_8_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_9_measurementValue": {"kind": "UNKNOWN", "name": ""}, "messages_0_0_measurementValue_id": {"kind": "UNKNOWN", "name": ""}, "messages_0_1_measurementValue_0_id": {"kind": "UNKNOWN", "name": ""}, "messages_0_0_measurementValue_statusName": {"kind": "UNKNOWN", "name": ""}, "messages_0_1_measurementValue_0_eventName": {"kind": "UNKNOWN", "name": ""}}	t	us915_1	f	f	f	f	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	f	0
71d18d2f-fa17-4077-a575-1221b8344760	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-03-22 13:22:57.036264+00	2025-03-22 20:30:53.02178+00	TrackerD_DP	US915	1.0.3	A	default	JS	3600	1	t	f	f	0	0	0	0	0	0	0	0	0	{}	function datalog(i,bytes){\n  var aa= (bytes[1+i]<<8 | bytes[2+i]);\n  var bb= (bytes[3+i]<<8 | bytes[4+i]);\n  var cc =  bytes[5+i]<<24>>24;\n  \n  var string='['+'MAJOR'+':'+aa+','+'MINOR'+':'+bb+','+'RSSI'+':'+cc+']'+',';  \n  \n  return string;\n}\n\nfunction decodeUplink(input) {\n        return { \n            data: Decode(input.fPort, input.bytes, input.variables)\n        };   \n}\nfunction Decode(fPort, bytes, variables) {\n\n// Decode an uplink message from a buffer\n// (array) of bytes to an object of fields.\n\tvar i;\n\tvar con;\n\tvar con1;\n\tvar con2;\n\tvar str = "";\n\tvar major = 1;\n\tvar minor = 1;\n\tvar rssi = 0;\n\tvar power = 0;\n\tvar device_information1 = 0;\n\tvar device_information2 = 0;\n\tvar device_information3 = 0;\n\tvar addr = "";\n\tvar alarm=0;//Alarm status\n\tvar batV=0;//Battery,units:V\n\tvar bat=0;//Battery,units:V\n\tvar mod = 0;\n\tvar led_updown="";//LED status for position,uplink and downlink\n\tvar Firmware = 0;  // Firmware version; 5 bits   \n\tvar hum=0;//hum,units: °\n\tvar tem=0; //tem,units: °  \n\tvar latitude=0;//gps latitude,units: °  \n\tvar longitude = 0;//gps longitude,units: ° \n\tvar location=0;\n\tvar time =0;\n\tvar date =0;\n  var sub_band;\n  var freq_band;\n  var sensor; \n  var firm_ver;\t\n  var sensor_mod;\n  var gps_mod;\n  var ble_mod;\n  var pnackmd;\n  var lon;\n  var intwk;\n  var BG;\n  var location_tago = {};\n  var rssi1m;\n  var mac1;\n  var mac2;\n  var mac3;\n  var rssi1 = 0;\n  var rssi2 = 0;\n  var rssi3 = 0;\n\tif(fPort == 2 || fPort == 3)\n\t{\n\t\tbat =(((bytes[8] & 0x3f) <<8) | bytes[9]);//Battery,units:V\n\t\tBG = bytes[10]>>3 & 0x01;\n\t\tlatitude=(bytes[0]<<24 | bytes[1]<<16 | bytes[2]<<8 | bytes[3])/1000000;//gps latitude,units: °\n\t\tlongitude=(bytes[4]<<24 | bytes[5]<<16 | bytes[6]<<8 | bytes[7])/1000000;//gps longitude,units: °\n\t\tif(BG == 1)\n\t\t{\n\t\t  var year = bytes[11] << 8 | bytes[12];\n\t\t  var month = bytes[13];\n\t\t  var day = bytes[14];\n\t\t  var hour = bytes[15];\n\t\t  var min = bytes[16];\n\t\t  var sec = bytes[17];\n\n\t\t  // Crear la fecha y hora en formato UTC\n\t\t  var utcDate = new Date(Date.UTC(year, month - 1, day, hour, min, sec));\n\n\t\t  // Convertir la fecha y hora a GMT-5\n\t\t  var gmtMinus5Date = new Date(utcDate.getTime() - 0 * 60 * 60 * 1000);\n\n\t\t  // Obtener los componentes de la fecha y hora en GMT-5\n\t\t  var gmtMinus5Year = gmtMinus5Date.getFullYear();\n\t\t  var gmtMinus5Month = gmtMinus5Date.getMonth() + 1;\n\t\t  var gmtMinus5Day = gmtMinus5Date.getDate();\n\t\t  var gmtMinus5Hour = gmtMinus5Date.getHours();\n\t\t  var gmtMinus5Min = gmtMinus5Date.getMinutes();\n\t\t  var gmtMinus5Sec = gmtMinus5Date.getSeconds();\n\n\t\t  var date = gmtMinus5Year + '-' + gmtMinus5Month + '-' + gmtMinus5Day;\n\t\t  var time = gmtMinus5Hour + ':' + gmtMinus5Min + ':' + gmtMinus5Sec;\n\t\t}\n\n\t\tif ((latitude < 190) && (latitude > -190)) {\n\t\t\t\tif ((longitude < 190) && (longitude > -190)) {\n\t\t\t\t\tif ((latitude !== 0) && (longitude !==0)) {\n\t\t\t\t\t\t\tfield: "location",\n\t\t\t\t\t\t  location= "" + latitude + "," + longitude + "";\n\t\t\t\t\t} \n\t\t\t   }\n\t\t}\n\t\telse\n\t\tlocation_tago="invalid value";\n\t\t\n\t\tif ((latitude < 190) && (latitude > -190)) {\n\t\t\t\tif ((longitude < 190) && (longitude > -190)) {\n\t\t\t\t\tif ((latitude !== 0) && (longitude !==0)) {\t\n\t\t          location_tago.latitude=(bytes[0]<<24 | bytes[1]<<16 | bytes[2]<<8 | bytes[3])/1000000;//gps latitude,units: °\n\t\t          location_tago.longitude=(bytes[4]<<24 | bytes[5]<<16 | bytes[6]<<8 | bytes[7])/1000000;//gps longitude,units: °\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t}\n\t\telse\n\t\tlocation_tago="invalid value";\n\t\t\t\t\t\n\t\talarm=(bytes[8] & 0x40)?"TRUE":"FALSE";//Alarm status\n\t\tbatV=(((bytes[8] & 0x3f) <<8) | bytes[9])/1000;//Battery,units:V\n\t\tmod = bytes[10] & 0xC0;\n\n\t\tif(mod !== 1 && BG == 0) \n\t\t{\n\t\t hum=(bytes[11]<<8 | bytes[12])/10;//hum,units: °\n\t\t tem=(bytes[13]<<24>>16 | bytes[14])/100; //tem,units: °   \n\t\t}\n\t\tled_updown=(bytes[10] & 0x20)?"ON":"OFF";//LED status for position,uplink and downlink\n\t    intwk = (bytes[10] & 0x10)?"MOVE":"STILL";\n\t\t\t\n\t\t\tif(fPort == 2)\n\t\t\t{\n\t\t\t\treturn {\n\t\t\t\t  Location: location,\n\t\t\t\t  Latitude: latitude,\n\t\t\t\t  Longitud: longitude,\n\t\t\t\t  location_tago:location_tago,\n\t\t\t\t  Hum:hum,\n\t\t\t\t  Tem:tem,\n\t\t\t\t  BatV:batV,\n\t\t\t\t  ALARM_status:alarm,\n\t\t\t\t  MD:mod,\n\t\t\t\t  Bg:BG,\n\t\t\t\t  Date: date,\n\t\t\t\t  Time: time,\t\t\t  \n\t\t\t\t  LON:led_updown,\n\t\t\t\t  Transport:intwk,\n\t\t\t\t  };\t\t\n\t\t\t}\n\t\t\telse if(fPort == 3)\n\t\t\t{\n\t\t\t\treturn {\n\t\t\t\t  Location: location,\n\t\t\t\t  Latitude: latitude,\n\t\t\t\t  Longitud: longitude,\n\t\t\t\t  location_tago:location_tago,\n\t\t\t\t  BatV:batV,\n\t\t\t\t  ALARM_status:alarm,\n\t\t\t\t  MD:mod,\n\t\t\t\t  LON:led_updown,\n\t\t\t\t  Transport:intwk,\n\t\t\t\t  };\t\t\n\t\t\t}\t\n\t}\n\n\tif (fPort == 0x04) \n\t{\n\t\tvar latitude = (bytes[0] << 24 | bytes[1] << 16 | bytes[2] << 8 | bytes[3]) / 1000000; //gps latitude,units: °\n\t\tvar longitude = (bytes[4] << 24 | bytes[5] << 16 | bytes[6] << 8 | bytes[7]) / 1000000; //gps longitude,units: °\n\n\n\t\tif ((latitude < 190) && (latitude > -190)) {\n\t\t\t\tif ((longitude < 190) && (longitude > -190)) {\n\t\t\t\t\tif ((latitude !== 0) && (longitude !==0)) {\n\t\t\t\t\t\t\tfield: "location",\n\t\t\t\t\t\t  location= "" + latitude + "," + longitude + "";\n\t\t\t\t\t} \n\t\t\t   }\n\t\t}\n\t\telse\n\t\tlocation="invalid value";\n\t\tif ((latitude < 190) && (latitude > -190)) {\n\t\t\t\tif ((longitude < 190) && (longitude > -190)) {\n\t\t\t\t\tif ((latitude !== 0) && (longitude !==0)) {\t\n\t\t\t\t\t\tlocation_tago.latitude=(bytes[0]<<24 | bytes[1]<<16 | bytes[2]<<8 | bytes[3])/1000000;//gps latitude,units: °\n\t\t\t\t\t\tlocation_tago.longitude=(bytes[4]<<24 | bytes[5]<<16 | bytes[6]<<8 | bytes[7])/1000000;//gps longitude,units: °\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t}\n\t\telse\n\t\tlocation_tago="invalid value";\n\n\t\tvar year = bytes[8] << 8 | bytes[9];\n\t\tvar month = bytes[10];\n\t\tvar day = bytes[11];\n\t\tvar hour = bytes[12];\n\t\tvar min = bytes[13];\n\t\tvar sec = bytes[14];\n\n\t\t// Crear la fecha y hora en formato UTC\n\t\tvar utcDate = new Date(Date.UTC(year, month - 1, day, hour, min, sec));\n\n\t\t// Convertir la fecha y hora a GMT-5\n\t\tvar gmtMinus5Date = new Date(utcDate.getTime() - 0 * 60 * 60 * 1000);\n\n\t\t// Obtener los componentes de la fecha y hora en GMT-5\n\t\tvar gmtMinus5Year = gmtMinus5Date.getFullYear();\n\t\tvar gmtMinus5Month = gmtMinus5Date.getMonth() + 1;\n\t\tvar gmtMinus5Day = gmtMinus5Date.getDate();\n\t\tvar gmtMinus5Hour = gmtMinus5Date.getHours();\n\t\tvar gmtMinus5Min = gmtMinus5Date.getMinutes();\n\t\tvar gmtMinus5Sec = gmtMinus5Date.getSeconds();\n\n\t\tvar date = gmtMinus5Year + '-' + gmtMinus5Month + '-' + gmtMinus5Day;\n\t\tvar time = gmtMinus5Hour + ':' + gmtMinus5Min + ':' + gmtMinus5Sec;\n\n\t\treturn {\n\t\t\tLocation: location,\n\t\t\tLatitude: latitude,\n\t\t\tLongitud: longitude,\n\t\t\tlocation_tago:location_tago,\n\t\t\tDate: date,\n\t\t\tTime: time,\n\t\t};\n\t}\n\tif(fPort == 0x07)\n\t{\n\t\talarm=(bytes[0] & 0x40)?"TRUE":"FALSE";//Alarm status\n\t\tbatV=(((bytes[0] & 0x3f) <<8) | bytes[1])/1000;//Battery,units:V\n\t\tmod = bytes[2] & 0xC0;\n\t\tled_updown=(bytes[2] & 0x20)?"ON":"OFF";//LED status for position,uplink and downlink\n\t\treturn {\n\t\t  BatV:batV,\n\t\t  ALARM_status:alarm,\n\t\t  MD:mod,\n\t\t  LON:led_updown,\n\t\t  };\t\t\t\t\n\t}\n\tif(fPort==0x08)\n\t{\n\t\tcon = "";\n\t\tfor(i = 0 ; i < 6 ; i++) {\n\t\t\tcon = bytes[i].toString();\n\t\t\tstr += String.fromCharCode(con);\n\t\t}\n\t\tvar wifissid = str,\n\t\trssi =  bytes[6]<<24>>24;\n\t\talarm=(bytes[7] & 0x40)?"TRUE":"FALSE";//Alarm status\n\t\tbatV=(((bytes[7] & 0x3f) <<8) | bytes[8])/1000;//Battery,units:V\n\t\tmod = (bytes[9] & 0xC0)>>6;\n\t\tled_updown=(bytes[9] & 0x20)?"ON":"OFF";//LED status for position,uplink and downlink\n\t\treturn {\n\t\t  WIFISSID:wifissid,\n\t\t  RSSI:rssi,\n\t\t  BatV:batV,\n\t\t  ALARM_status:alarm,\t\n\t\t  MD:mod,\n\t\t  LON:led_updown,\t\t\t  \n\t\t  };\t  \n\t}\n\tif(fPort==0x05)\n\t{\n\t\tif(bytes[0]==0x13)\n\t\t  sensor_mode="TrackerD";\n\t\telse\n\t\t  sensor_mode="NULL"; \n\t\t   \n\t\tif(bytes[4]==0xff)\n\t\t  sub_band="NULL";\n\t\telse\n\t\t  sub_band=bytes[4];\n\t\t\n\t\tif(bytes[3]==0x01)\n\t\t  freq_band="EU868";\n\t\telse if(bytes[3]==0x02)\n\t\t  freq_band="US915";\n\t\telse if(bytes[3]==0x03)\n\t\t  freq_band="IN865";\n\t\telse if(bytes[3]==0x04)\n\t\t  freq_band="AU915";\n\t\telse if(bytes[3]==0x05)\n\t\t  freq_band="KZ865";\n\t\telse if(bytes[3]==0x06)\n\t\t  freq_band="RU864";\n\t\telse if(bytes[3]==0x07)\n\t\t  freq_band="AS923";\n\t\telse if(bytes[3]==0x08)\n\t\t  freq_band="AS923_1";\n\t\telse if(bytes[3]==0x09)\n\t\t  freq_band="AS923_2";\n\t\telse if(bytes[3]==0x0A)\n\t\t  freq_band="AS923_3";\n\t\telse if(bytes[3]==0x0B)\n\t\t  freq_band="CN470";\n\t\telse if(bytes[3]==0x0C)\n\t\t  freq_band="EU433";\n\t\telse if(bytes[3]==0x0D)\n\t\t  freq_band="KR920";\n\t\telse if(bytes[3]==0x0E)\n\t\t  freq_band="MA869";\n\t\t  \n\t\tfirm_ver= (bytes[1]&0x0f)+'.'+(bytes[2]>>4&0x0f)+'.'+(bytes[2]&0x0f);\n\t\tbatV= (bytes[5]<<8 | bytes[6])/1000;\n\t\tsemsor_mod = (bytes[7]>>6)&0x3f;\n\t\tgps_mod = (bytes[7]>>4)&0x03;\n\t\tble_mod = bytes[7]&0x0f;\n\t\tpanackmd = bytes[8]&0x04;\n\t\tlon = ((bytes[8]>>1)&0x01)?"ON":"OFF";;\n\t\tintwk = bytes[8]&0x01;\n\t\t\n\t\tif(semsor_mod == 1)\n\t\t   sensor= "GPS";\n\t\telse if(semsor_mod == 2)\n\t\t   sensor= "BLE"; \n\t\telse if(intwk == 1)\n\t\t   sensor= "Spots";         \n\t\t else if(semsor_mod == 3)\n\t\t   sensor= "BLE+GPS Hybrid";     \n\t\treturn {\n\t\tBatV:batV,\n\t\tSENSOR_MODEL:sensor_mode,\n\t\tFIRMWARE_VERSION:firm_ver,\n\t\tFREQUENCY_BAND:freq_band,\n\t\tSUB_BAND:sub_band, \n\t\tSMODE:sensor,\n\t\tGPS_M0D:gps_mod,\n\t\tBLE_MD:ble_mod,\n\t\tPNACKMD:pnackmd,\n\t\tLON:lon,\n\t\tIntwk:intwk,\n\t\t};\n\t}\t\n\tif(fPort==0x06)\n\t{\n\t\tmajor =  bytes[16] << 8 | bytes[17];\n\t\t\n\t\tminor =  bytes[18] << 8 | bytes[19];\n\t\t\n\t\tpower = bytes[15];\n\t\t\n\t\trssi1m = bytes[21]<<24>>24;\n\t\t\n\t\trssi =  bytes[23]<<24>>24;\n\n\t\tcon = "";\n\t\tfor(i = 0 ; i < 16 ; i++) {\n\t\t\tcon += bytes[i].toString(16);\n\t\t}\n\t\tvalue =  con;\n\t\tvar uuid = value;\t\n\t\talarm=(bytes[24] & 0x40)?"TRUE":"FALSE";//Alarm status\n\t\tbatV=(((bytes[24] & 0x3f) <<8) | bytes[25])/1000;//Battery,units:V\n\t\tmod = (bytes[26] & 0xC0)>>6;\n\t\tled_updown=(bytes[26] & 0x20)?"ON":"OFF";//LED status for position,uplink and downlink\n\t\tif(bytes[26] & 0xC0==0x40) \n\t\t{\n\t\t\thum=(bytes[27]<<8 | bytes[28])/10;//hum,units: °\n\t\t\ttem=(bytes[29]<<24>>16 | bytes[30])/100; //tem,units: °\n\t\t}\n\t\treturn {\n\t\t  BatV:batV,\n\t\t  ALARM_status:alarm,\n\t\t  MD:mod,\n\t\t  LON:led_updown,\n\t\t  UUID: uuid,\n\t\t  MAJOR: major,\n\t\t  MINOR: minor,\n\t\t  RSSI:rssi,\n\t\t  RSSI1M:rssi1m,\n\t\t  POWER:power,\n\t\t  };\t\t\t\n\t}\n\tif(fPort==0x0A)\n\t{\n\t  function bytesToHex(bytes) {\n    return bytes.map(byte => byte.toString(16).padStart(2, '0')).join('');\n}\n\t\tconst MAC1 = bytesToHex(bytes.slice(0, 6));\n\t\t\n\t\tconst RSSI1 = bytes[6]<<24>>24;\n\t\t\n\t\tconst MAC2 = bytesToHex(bytes.slice(7, 13));\n\t\t\n\t\tconst RSSI2 =  bytes[13]<<24>>24;\n\n\t\tconst MAC3 = bytesToHex(bytes.slice(14, 20));\n\t\t\n\t\tconst RSSI3 =  bytes[20]<<24>>24;\n\t\t\n\t\talarm=(bytes[21] & 0x40)?"TRUE":"FALSE";//Alarm status\n\t\tbatV=(((bytes[21] & 0x3f) <<8) | bytes[22])/1000;//Battery,units:V\n\t\tmod = (bytes[23] & 0xC0)>>6;\n\t\treturn {\n\t\t  BatV:batV,\n\t\t  ALARM_status:alarm,\n\t\t  MD:mod,\n\t\t  MAC1:MAC1,\n\t\t  MAC2: MAC2,\n\t\t  MAC3: MAC3,\n\t\t  RSSI1: RSSI1,\n\t\t  RSSI2:RSSI2,\n\t\t  RSSI3:RSSI3,\n\t\t  };\t\t\n\t \n\t}\n}	t		{"Bg": {"kind": "UNKNOWN", "name": ""}, "MD": {"kind": "UNKNOWN", "name": ""}, "Hum": {"kind": "GAUGE", "name": "Humidity"}, "LON": {"kind": "UNKNOWN", "name": ""}, "Tem": {"kind": "GAUGE", "name": "Temperature"}, "BatV": {"kind": "GAUGE", "name": "Battery"}, "Date": {"kind": "UNKNOWN", "name": ""}, "Time": {"kind": "UNKNOWN", "name": ""}, "Intwk": {"kind": "UNKNOWN", "name": ""}, "SMODE": {"kind": "UNKNOWN", "name": ""}, "BLE_MD": {"kind": "UNKNOWN", "name": ""}, "GPS_M0D": {"kind": "UNKNOWN", "name": ""}, "Latitude": {"kind": "GAUGE", "name": "Latitude"}, "Location": {"kind": "UNKNOWN", "name": ""}, "Longitud": {"kind": "GAUGE", "name": "Longitude"}, "SUB_BAND": {"kind": "UNKNOWN", "name": ""}, "Transport": {"kind": "UNKNOWN", "name": ""}, "ALARM_status": {"kind": "UNKNOWN", "name": ""}, "SENSOR_MODEL": {"kind": "UNKNOWN", "name": ""}, "FREQUENCY_BAND": {"kind": "UNKNOWN", "name": ""}, "FIRMWARE_VERSION": {"kind": "UNKNOWN", "name": ""}, "location_tago_latitude": {"kind": "UNKNOWN", "name": ""}, "location_tago_longitude": {"kind": "UNKNOWN", "name": ""}}	t	us915_1	f	f	f	f	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	f	0
00163ec3-1e4f-46c8-a71d-cc6c578477f7	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-04-23 02:00:42.411202+00	2025-04-26 16:00:53.844908+00	M5U_DP	US915	1.0.3	A	default	NONE	3600	1	t	f	f	0	0	0	0	0	0	0	0	0	{}	/**\n * Decode uplink function\n * \n * @param {object} input\n * @param {number[]} input.bytes Byte array containing the uplink payload, e.g. [255, 230, 255, 0]\n * @param {number} input.fPort Uplink fPort.\n * @param {Record<string, string>} input.variables Object containing the configured device variables.\n * \n * @returns {{data: object}} Object representing the decoded payload.\n */\nfunction decodeUplink(input) {\n  return {\n    data: {\n      // temp: 22.5\n    }\n  };\n}\n\n/**\n * Encode downlink function.\n * \n * @param {object} input\n * @param {object} input.data Object representing the payload that must be encoded.\n * @param {Record<string, string>} input.variables Object containing the configured device variables.\n * \n * @returns {{bytes: number[]}} Byte array containing the downlink payload.\n */\nfunction encodeDownlink(input) {\n  return {\n    // bytes: [225, 230, 255, 0]\n  };\n}\n	t		{}	t	us915_1	f	f	f	f	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	f	0
8d4a04b0-68b6-4ee7-b4f7-e05f6b5d6cfb	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-01-20 01:05:12.20581+00	2025-03-19 10:56:35.535034+00	WioTerminal_DP	US915	1.0.3	A	default	NONE	3600	1	t	f	f	0	0	0	0	0	0	0	0	0	{}	/**\n * Decode uplink function\n * \n * @param {object} input\n * @param {number[]} input.bytes Byte array containing the uplink payload, e.g. [255, 230, 255, 0]\n * @param {number} input.fPort Uplink fPort.\n * @param {Record<string, string>} input.variables Object containing the configured device variables.\n * \n * @returns {{data: object}} Object representing the decoded payload.\n */\nfunction decodeUplink(input) {\n  return {\n    data: {\n      // temp: 22.5\n    }\n  };\n}\n\n/**\n * Encode downlink function.\n * \n * @param {object} input\n * @param {object} input.data Object representing the payload that must be encoded.\n * @param {Record<string, string>} input.variables Object containing the configured device variables.\n * \n * @returns {{bytes: number[]}} Byte array containing the downlink payload.\n */\nfunction encodeDownlink(input) {\n  return {\n    // bytes: [225, 230, 255, 0]\n  };\n}\n	t		{}	t	us915_1	f	f	f	f	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	f	0
\.


--
-- Data for Name: device_profile_template; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_profile_template (id, created_at, updated_at, name, description, vendor, firmware, region, mac_version, reg_params_revision, adr_algorithm_id, payload_codec_runtime, payload_codec_script, uplink_interval, device_status_req_interval, flush_queue_on_activate, supports_otaa, supports_class_b, supports_class_c, class_b_timeout, class_b_ping_slot_nb_k, class_b_ping_slot_dr, class_b_ping_slot_freq, class_c_timeout, abp_rx1_delay, abp_rx1_dr_offset, abp_rx2_dr, abp_rx2_freq, tags, measurements, auto_detect_measurements) FROM stdin;
\.


--
-- Data for Name: device_queue_item; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_queue_item (id, dev_eui, created_at, f_port, confirmed, data, is_pending, f_cnt_down, timeout_after, is_encrypted, expires_at) FROM stdin;
\.


--
-- Data for Name: gateway; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.gateway (gateway_id, tenant_id, created_at, updated_at, last_seen_at, name, description, latitude, longitude, altitude, stats_interval_secs, tls_certificate, tags, properties) FROM stdin;
\\x840d8effff23f1bc	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-02-25 20:25:26.377346+00	2025-03-20 19:05:38.743256+00	2025-05-05 21:26:40.577019+00	HTM01S-109922-01		0	0	0	60	\N	{}	{"region_config_id": "us915_1", "region_common_name": "US915"}
\\x787264fffee04f72	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2024-11-18 03:43:04.513254+00	2025-04-11 14:45:08.343699+00	2025-05-05 21:27:16.491649+00	HT-M02-109922-01		6.224174322234499	-75.57410365122374	0	30	\N	{}	{"region_config_id": "us915_1", "region_common_name": "US915"}
\\xa840411eeed84153	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-03-18 03:05:34.551237+00	2025-03-18 03:05:34.551237+00	2025-05-05 21:27:28.189761+00	LPS08-109922-01		6.2461	-75.58244	1500	30	\N	{}	{"region_config_id": "us915_1", "region_common_name": "US915"}
\\xa8404121d2c84150	52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2025-03-20 18:51:50.899247+00	2025-03-20 18:51:50.899247+00	2025-05-05 21:27:32.312687+00	LPS08-109922-02		6.244729	-75.55198	1597	30	\N	{}	{"region_config_id": "us915_1", "region_common_name": "US915"}
\.


--
-- Data for Name: multicast_group; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group (id, application_id, created_at, updated_at, name, region, mc_addr, mc_nwk_s_key, mc_app_s_key, f_cnt, group_type, dr, frequency, class_b_ping_slot_nb_k, class_c_scheduling_type) FROM stdin;
\.


--
-- Data for Name: multicast_group_device; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group_device (multicast_group_id, dev_eui, created_at) FROM stdin;
\.


--
-- Data for Name: multicast_group_gateway; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group_gateway (multicast_group_id, gateway_id, created_at) FROM stdin;
\.


--
-- Data for Name: multicast_group_queue_item; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group_queue_item (id, created_at, scheduler_run_after, multicast_group_id, gateway_id, f_cnt, f_port, data, emit_at_time_since_gps_epoch, expires_at) FROM stdin;
\.


--
-- Data for Name: relay_device; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.relay_device (relay_dev_eui, dev_eui, created_at) FROM stdin;
\.


--
-- Data for Name: relay_gateway; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.relay_gateway (tenant_id, relay_id, created_at, updated_at, last_seen_at, name, description, stats_interval_secs, region_config_id) FROM stdin;
\.


--
-- Data for Name: tenant; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.tenant (id, created_at, updated_at, name, description, can_have_gateways, max_device_count, max_gateway_count, private_gateways_up, private_gateways_down, tags) FROM stdin;
52f14cd4-c6f1-4fbd-8f87-4025e1d49242	2024-11-15 12:54:03.498929+00	2024-11-15 12:54:03.498929+00	ChirpStack		t	0	0	f	f	{}
\.


--
-- Data for Name: tenant_user; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.tenant_user (tenant_id, user_id, created_at, updated_at, is_admin, is_device_admin, is_gateway_admin) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public."user" (id, external_id, created_at, updated_at, is_admin, is_active, email, email_verified, password_hash, note) FROM stdin;
05244f12-6daf-4e1f-8315-c66783a0ab56	\N	2024-11-15 12:54:03.498929+00	2024-11-15 12:54:03.498929+00	t	t	admin	f	$pbkdf2-sha512$i=1,l=64$l8zGKtxRESq3PA2kFhHRWA$H3lGMxOt55wjwoc+myeOoABofJY9oDpldJa7fhqdjbh700V6FLPML75UmBOt9J5VFNjAL1AvqCozA1HJM0QVGA	
\.


--
-- Name: __diesel_schema_migrations __diesel_schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.__diesel_schema_migrations
    ADD CONSTRAINT __diesel_schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: application_integration application_integration_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application_integration
    ADD CONSTRAINT application_integration_pkey PRIMARY KEY (application_id, kind);


--
-- Name: application application_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_pkey PRIMARY KEY (id);


--
-- Name: device_keys device_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_keys
    ADD CONSTRAINT device_keys_pkey PRIMARY KEY (dev_eui);


--
-- Name: device device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (dev_eui);


--
-- Name: device_profile device_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_profile
    ADD CONSTRAINT device_profile_pkey PRIMARY KEY (id);


--
-- Name: device_profile_template device_profile_template_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_profile_template
    ADD CONSTRAINT device_profile_template_pkey PRIMARY KEY (id);


--
-- Name: device_queue_item device_queue_item_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_queue_item
    ADD CONSTRAINT device_queue_item_pkey PRIMARY KEY (id);


--
-- Name: gateway gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.gateway
    ADD CONSTRAINT gateway_pkey PRIMARY KEY (gateway_id);


--
-- Name: multicast_group_device multicast_group_device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_device
    ADD CONSTRAINT multicast_group_device_pkey PRIMARY KEY (multicast_group_id, dev_eui);


--
-- Name: multicast_group_gateway multicast_group_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_gateway
    ADD CONSTRAINT multicast_group_gateway_pkey PRIMARY KEY (multicast_group_id, gateway_id);


--
-- Name: multicast_group multicast_group_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group
    ADD CONSTRAINT multicast_group_pkey PRIMARY KEY (id);


--
-- Name: multicast_group_queue_item multicast_group_queue_item_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_queue_item
    ADD CONSTRAINT multicast_group_queue_item_pkey PRIMARY KEY (id);


--
-- Name: relay_device relay_device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_device
    ADD CONSTRAINT relay_device_pkey PRIMARY KEY (relay_dev_eui, dev_eui);


--
-- Name: relay_gateway relay_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_gateway
    ADD CONSTRAINT relay_gateway_pkey PRIMARY KEY (tenant_id, relay_id);


--
-- Name: tenant tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- Name: tenant_user tenant_user_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant_user
    ADD CONSTRAINT tenant_user_pkey PRIMARY KEY (tenant_id, user_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_api_key_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_api_key_tenant_id ON public.api_key USING btree (tenant_id);


--
-- Name: idx_application_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_application_name_trgm ON public.application USING gin (name public.gin_trgm_ops);


--
-- Name: idx_application_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_application_tags ON public.application USING gin (tags);


--
-- Name: idx_application_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_application_tenant_id ON public.application USING btree (tenant_id);


--
-- Name: idx_device_application_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_application_id ON public.device USING btree (application_id);


--
-- Name: idx_device_dev_addr; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_dev_addr ON public.device USING btree (dev_addr);


--
-- Name: idx_device_dev_addr_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_dev_addr_trgm ON public.device USING gin (encode(dev_addr, 'hex'::text) public.gin_trgm_ops);


--
-- Name: idx_device_dev_eui_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_dev_eui_trgm ON public.device USING gin (encode(dev_eui, 'hex'::text) public.gin_trgm_ops);


--
-- Name: idx_device_device_profile_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_device_profile_id ON public.device USING btree (device_profile_id);


--
-- Name: idx_device_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_name_trgm ON public.device USING gin (name public.gin_trgm_ops);


--
-- Name: idx_device_profile_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_profile_name_trgm ON public.device_profile USING gin (name public.gin_trgm_ops);


--
-- Name: idx_device_profile_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_profile_tags ON public.device_profile USING gin (tags);


--
-- Name: idx_device_profile_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_profile_tenant_id ON public.device_profile USING btree (tenant_id);


--
-- Name: idx_device_queue_item_created_at; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_queue_item_created_at ON public.device_queue_item USING btree (created_at);


--
-- Name: idx_device_queue_item_dev_eui; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_queue_item_dev_eui ON public.device_queue_item USING btree (dev_eui);


--
-- Name: idx_device_queue_item_timeout_after; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_queue_item_timeout_after ON public.device_queue_item USING btree (timeout_after);


--
-- Name: idx_device_secondary_dev_addr; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_secondary_dev_addr ON public.device USING btree (secondary_dev_addr);


--
-- Name: idx_device_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_tags ON public.device USING gin (tags);


--
-- Name: idx_gateway_id_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_id_trgm ON public.gateway USING gin (encode(gateway_id, 'hex'::text) public.gin_trgm_ops);


--
-- Name: idx_gateway_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_name_trgm ON public.gateway USING gin (name public.gin_trgm_ops);


--
-- Name: idx_gateway_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_tags ON public.gateway USING gin (tags);


--
-- Name: idx_gateway_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_tenant_id ON public.gateway USING btree (tenant_id);


--
-- Name: idx_multicast_group_application_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_application_id ON public.multicast_group USING btree (application_id);


--
-- Name: idx_multicast_group_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_name_trgm ON public.multicast_group USING gin (name public.gin_trgm_ops);


--
-- Name: idx_multicast_group_queue_item_multicast_group_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_queue_item_multicast_group_id ON public.multicast_group_queue_item USING btree (multicast_group_id);


--
-- Name: idx_multicast_group_queue_item_scheduler_run_after; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_queue_item_scheduler_run_after ON public.multicast_group_queue_item USING btree (scheduler_run_after);


--
-- Name: idx_tenant_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_tenant_name_trgm ON public.tenant USING gin (name public.gin_trgm_ops);


--
-- Name: idx_tenant_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_tenant_tags ON public.tenant USING gin (tags);


--
-- Name: idx_tenant_user_user_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_tenant_user_user_id ON public.tenant_user USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE UNIQUE INDEX idx_user_email ON public."user" USING btree (email);


--
-- Name: idx_user_external_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE UNIQUE INDEX idx_user_external_id ON public."user" USING btree (external_id);


--
-- Name: api_key api_key_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: application_integration application_integration_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application_integration
    ADD CONSTRAINT application_integration_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.application(id) ON DELETE CASCADE;


--
-- Name: application application_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: device device_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.application(id) ON DELETE CASCADE;


--
-- Name: device device_device_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_device_profile_id_fkey FOREIGN KEY (device_profile_id) REFERENCES public.device_profile(id) ON DELETE CASCADE;


--
-- Name: device_keys device_keys_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_keys
    ADD CONSTRAINT device_keys_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: device_profile device_profile_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_profile
    ADD CONSTRAINT device_profile_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: device_queue_item device_queue_item_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_queue_item
    ADD CONSTRAINT device_queue_item_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: gateway gateway_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.gateway
    ADD CONSTRAINT gateway_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: multicast_group multicast_group_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group
    ADD CONSTRAINT multicast_group_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.application(id) ON DELETE CASCADE;


--
-- Name: multicast_group_device multicast_group_device_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_device
    ADD CONSTRAINT multicast_group_device_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: multicast_group_device multicast_group_device_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_device
    ADD CONSTRAINT multicast_group_device_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES public.multicast_group(id) ON DELETE CASCADE;


--
-- Name: multicast_group_gateway multicast_group_gateway_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_gateway
    ADD CONSTRAINT multicast_group_gateway_gateway_id_fkey FOREIGN KEY (gateway_id) REFERENCES public.gateway(gateway_id) ON DELETE CASCADE;


--
-- Name: multicast_group_gateway multicast_group_gateway_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_gateway
    ADD CONSTRAINT multicast_group_gateway_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES public.multicast_group(id) ON DELETE CASCADE;


--
-- Name: multicast_group_queue_item multicast_group_queue_item_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_queue_item
    ADD CONSTRAINT multicast_group_queue_item_gateway_id_fkey FOREIGN KEY (gateway_id) REFERENCES public.gateway(gateway_id) ON DELETE CASCADE;


--
-- Name: multicast_group_queue_item multicast_group_queue_item_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_queue_item
    ADD CONSTRAINT multicast_group_queue_item_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES public.multicast_group(id) ON DELETE CASCADE;


--
-- Name: relay_device relay_device_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_device
    ADD CONSTRAINT relay_device_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: relay_device relay_device_relay_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_device
    ADD CONSTRAINT relay_device_relay_dev_eui_fkey FOREIGN KEY (relay_dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: relay_gateway relay_gateway_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_gateway
    ADD CONSTRAINT relay_gateway_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: tenant_user tenant_user_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant_user
    ADD CONSTRAINT tenant_user_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: tenant_user tenant_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant_user
    ADD CONSTRAINT tenant_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

