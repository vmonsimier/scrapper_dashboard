--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3 (Ubuntu 14.3-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.3 (Ubuntu 14.3-1.pgdg20.04+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO valentinm;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO valentinm;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO valentinm;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO valentinm;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO valentinm;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO valentinm;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO valentinm;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO valentinm;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO valentinm;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO valentinm;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO valentinm;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO valentinm;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO valentinm;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO valentinm;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO valentinm;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO valentinm;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO valentinm;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO valentinm;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO valentinm;

--
-- Name: run_script_exclude_player_links; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.run_script_exclude_player_links (
    id integer NOT NULL,
    scrapper_id integer NOT NULL,
    link character varying(120) NOT NULL,
    CONSTRAINT run_script_exclude_player_links_scrapper_id_check CHECK ((scrapper_id >= 0))
);


ALTER TABLE public.run_script_exclude_player_links OWNER TO valentinm;

--
-- Name: run_script_exclude_player_links_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.run_script_exclude_player_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_script_exclude_player_links_id_seq OWNER TO valentinm;

--
-- Name: run_script_exclude_player_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.run_script_exclude_player_links_id_seq OWNED BY public.run_script_exclude_player_links.id;


--
-- Name: run_script_exclude_team_links; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.run_script_exclude_team_links (
    id integer NOT NULL,
    scrapper_id integer NOT NULL,
    link character varying(120) NOT NULL,
    CONSTRAINT run_script_exclude_team_links_scrapper_id_check CHECK ((scrapper_id >= 0))
);


ALTER TABLE public.run_script_exclude_team_links OWNER TO valentinm;

--
-- Name: run_script_exclude_team_links_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.run_script_exclude_team_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_script_exclude_team_links_id_seq OWNER TO valentinm;

--
-- Name: run_script_exclude_team_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.run_script_exclude_team_links_id_seq OWNED BY public.run_script_exclude_team_links.id;


--
-- Name: run_script_fbreflinks; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.run_script_fbreflinks (
    id integer NOT NULL,
    link character varying(120) NOT NULL,
    league character varying(50) NOT NULL,
    season integer NOT NULL,
    CONSTRAINT run_script_fbreflinks_season_check CHECK ((season >= 0))
);


ALTER TABLE public.run_script_fbreflinks OWNER TO valentinm;

--
-- Name: run_script_fbreflinks_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.run_script_fbreflinks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_script_fbreflinks_id_seq OWNER TO valentinm;

--
-- Name: run_script_fbreflinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.run_script_fbreflinks_id_seq OWNED BY public.run_script_fbreflinks.id;


--
-- Name: run_script_files; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.run_script_files (
    id integer NOT NULL,
    path character varying(120) NOT NULL,
    player character varying(100) NOT NULL,
    team character varying(45) NOT NULL,
    league character varying(50) NOT NULL,
    season integer NOT NULL,
    "dateIns" timestamp with time zone,
    CONSTRAINT run_script_files_season_check CHECK ((season >= 0))
);


ALTER TABLE public.run_script_files OWNER TO valentinm;

--
-- Name: run_script_files_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.run_script_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_script_files_id_seq OWNER TO valentinm;

--
-- Name: run_script_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.run_script_files_id_seq OWNED BY public.run_script_files.id;


--
-- Name: run_script_scrapper_active_links; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.run_script_scrapper_active_links (
    id integer NOT NULL,
    scrapper_id integer NOT NULL,
    link character varying(120) NOT NULL,
    league character varying(45) NOT NULL,
    season integer NOT NULL,
    CONSTRAINT run_script_scrapper_active_links_scrapper_id_check CHECK ((scrapper_id >= 0)),
    CONSTRAINT run_script_scrapper_active_links_season_0d42cb51_check CHECK ((season >= 0))
);


ALTER TABLE public.run_script_scrapper_active_links OWNER TO valentinm;

--
-- Name: run_script_scrapper_active_links_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.run_script_scrapper_active_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_script_scrapper_active_links_id_seq OWNER TO valentinm;

--
-- Name: run_script_scrapper_active_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.run_script_scrapper_active_links_id_seq OWNED BY public.run_script_scrapper_active_links.id;


--
-- Name: run_script_scrapperlogs; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.run_script_scrapperlogs (
    id integer NOT NULL,
    scrapper_id integer NOT NULL,
    type character varying(5) NOT NULL,
    text character varying(200) NOT NULL,
    date timestamp with time zone,
    CONSTRAINT run_script_scrapperlogs_scrapper_id_check CHECK ((scrapper_id >= 0))
);


ALTER TABLE public.run_script_scrapperlogs OWNER TO valentinm;

--
-- Name: run_script_scrapperlogs_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.run_script_scrapperlogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_script_scrapperlogs_id_seq OWNER TO valentinm;

--
-- Name: run_script_scrapperlogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.run_script_scrapperlogs_id_seq OWNED BY public.run_script_scrapperlogs.id;


--
-- Name: run_script_scrappers; Type: TABLE; Schema: public; Owner: valentinm
--

CREATE TABLE public.run_script_scrappers (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    path character varying(64) NOT NULL,
    in_execution boolean,
    enable boolean NOT NULL,
    current_pid integer NOT NULL,
    errors text,
    last_execution timestamp with time zone,
    site character varying(40) NOT NULL,
    CONSTRAINT run_script_scrappers_current_pid_check CHECK ((current_pid >= 0))
);


ALTER TABLE public.run_script_scrappers OWNER TO valentinm;

--
-- Name: run_script_scrappers_id_seq; Type: SEQUENCE; Schema: public; Owner: valentinm
--

CREATE SEQUENCE public.run_script_scrappers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_script_scrappers_id_seq OWNER TO valentinm;

--
-- Name: run_script_scrappers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: valentinm
--

ALTER SEQUENCE public.run_script_scrappers_id_seq OWNED BY public.run_script_scrappers.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: run_script_exclude_player_links id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_exclude_player_links ALTER COLUMN id SET DEFAULT nextval('public.run_script_exclude_player_links_id_seq'::regclass);


--
-- Name: run_script_exclude_team_links id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_exclude_team_links ALTER COLUMN id SET DEFAULT nextval('public.run_script_exclude_team_links_id_seq'::regclass);


--
-- Name: run_script_fbreflinks id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_fbreflinks ALTER COLUMN id SET DEFAULT nextval('public.run_script_fbreflinks_id_seq'::regclass);


--
-- Name: run_script_files id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_files ALTER COLUMN id SET DEFAULT nextval('public.run_script_files_id_seq'::regclass);


--
-- Name: run_script_scrapper_active_links id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_scrapper_active_links ALTER COLUMN id SET DEFAULT nextval('public.run_script_scrapper_active_links_id_seq'::regclass);


--
-- Name: run_script_scrapperlogs id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_scrapperlogs ALTER COLUMN id SET DEFAULT nextval('public.run_script_scrapperlogs_id_seq'::regclass);


--
-- Name: run_script_scrappers id; Type: DEFAULT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_scrappers ALTER COLUMN id SET DEFAULT nextval('public.run_script_scrappers_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add scrappers	7	add_scrappers
26	Can change scrappers	7	change_scrappers
27	Can delete scrappers	7	delete_scrappers
28	Can view scrappers	7	view_scrappers
29	Can add scrappers	8	add_scrappers
30	Can change scrappers	8	change_scrappers
31	Can delete scrappers	8	delete_scrappers
32	Can view scrappers	8	view_scrappers
33	Can add fbref links	9	add_fbreflinks
34	Can change fbref links	9	change_fbreflinks
35	Can delete fbref links	9	delete_fbreflinks
36	Can view fbref links	9	view_fbreflinks
37	Can add scrapper_ active_ links	10	add_scrapper_active_links
38	Can change scrapper_ active_ links	10	change_scrapper_active_links
39	Can delete scrapper_ active_ links	10	delete_scrapper_active_links
40	Can view scrapper_ active_ links	10	view_scrapper_active_links
41	Can add exclude_ player_ links	11	add_exclude_player_links
42	Can change exclude_ player_ links	11	change_exclude_player_links
43	Can delete exclude_ player_ links	11	delete_exclude_player_links
44	Can view exclude_ player_ links	11	view_exclude_player_links
45	Can add exclude_ team_ links	12	add_exclude_team_links
46	Can change exclude_ team_ links	12	change_exclude_team_links
47	Can delete exclude_ team_ links	12	delete_exclude_team_links
48	Can view exclude_ team_ links	12	view_exclude_team_links
49	Can add scrapper logs	13	add_scrapperlogs
50	Can change scrapper logs	13	change_scrapperlogs
51	Can delete scrapper logs	13	delete_scrapperlogs
52	Can view scrapper logs	13	view_scrapperlogs
53	Can add files	14	add_files
54	Can change files	14	change_files
55	Can delete files	14	delete_files
56	Can view files	14	view_files
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$320000$tUkKZpWRPI6Bgm2WcQThk5$OP+8mrvGStv+F2Q0i3NjThOfY3x9hrbDYOZUudyBkGw=	2022-05-30 20:53:16.082453+00	t	valentinmonsimier	Valentin	Monsimier	monsimier.valentin@gmail.com	t	t	2021-12-17 19:22:10+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
2	2022-02-16 22:08:31.495261+00	1	valentinmonsimier	2	[{"changed": {"fields": ["First name", "Last name"]}}]	4	1
3	2022-02-16 22:08:43.43918+00	2	valentino	3		4	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	run_script	scrappers
8	football_api	scrappers
9	run_script	fbreflinks
10	run_script	scrapper_active_links
11	run_script	exclude_player_links
12	run_script	exclude_team_links
13	run_script	scrapperlogs
14	run_script	files
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-12-17 19:19:01.462167+00
2	auth	0001_initial	2021-12-17 19:19:01.538011+00
3	admin	0001_initial	2021-12-17 19:19:01.574602+00
4	admin	0002_logentry_remove_auto_add	2021-12-17 19:19:01.583231+00
5	admin	0003_logentry_add_action_flag_choices	2021-12-17 19:19:01.590382+00
6	contenttypes	0002_remove_content_type_name	2021-12-17 19:19:01.610511+00
7	auth	0002_alter_permission_name_max_length	2021-12-17 19:19:01.618512+00
8	auth	0003_alter_user_email_max_length	2021-12-17 19:19:01.62615+00
9	auth	0004_alter_user_username_opts	2021-12-17 19:19:01.636113+00
10	auth	0005_alter_user_last_login_null	2021-12-17 19:19:01.64343+00
11	auth	0006_require_contenttypes_0002	2021-12-17 19:19:01.645686+00
12	auth	0007_alter_validators_add_error_messages	2021-12-17 19:19:01.652291+00
13	auth	0008_alter_user_username_max_length	2021-12-17 19:19:01.662613+00
14	auth	0009_alter_user_last_name_max_length	2021-12-17 19:19:01.671816+00
15	auth	0010_alter_group_name_max_length	2021-12-17 19:19:01.680048+00
16	auth	0011_update_proxy_permissions	2021-12-17 19:19:01.686699+00
17	auth	0012_alter_user_first_name_max_length	2021-12-17 19:19:01.693924+00
18	sessions	0001_initial	2021-12-17 19:19:01.70672+00
19	run_script	0001_initial	2021-12-18 18:14:02.49369+00
20	football_api	0001_initial	2021-12-21 20:21:17.601039+00
21	run_script	0002_alter_scrappers_name_alter_scrappers_path	2021-12-21 20:21:17.618123+00
22	run_script	0003_alter_scrappers_id	2021-12-21 20:46:06.602771+00
24	run_script	0004_scrappers_last_execution	2021-12-28 13:23:17.920444+00
25	run_script	0005_fbreflinks	2021-12-29 13:51:35.193399+00
26	run_script	0006_scrappers_site	2021-12-29 14:21:30.825116+00
27	run_script	0007_scrapper_active_links	2021-12-29 14:32:50.276887+00
28	run_script	0008_exclude_player_links_exclude_team_links	2021-12-30 15:24:16.150977+00
29	run_script	0009_scrapper_active_links_league_and_more	2022-01-05 18:33:15.793917+00
30	run_script	0010_alter_scrapper_active_links_season	2022-01-05 18:35:08.629014+00
31	run_script	0011_alter_scrapper_active_links_season	2022-01-05 18:36:01.790718+00
32	run_script	0012_scrapperlogs	2022-01-10 20:48:17.359429+00
33	run_script	0013_files	2022-01-29 22:53:47.528812+00
34	run_script	0014_alter_scrappers_errors	2022-03-03 01:01:42.282078+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
xa0oezfxo15k2ce8tlr2ty6vgmmgo8m9	.eJxVjMsOwiAURP-FtSFcuBRw6d5vIDyuUjWQlHZl_Hdp0oUuZ-aceTMftrX4rdPi58zODNjpt4shPanuQ36Eem88tbouc-Q7wo-182vL9Loc7N9BCb0MWzorECw4S2oS0xBjQiUdgpDGGZ1jGJEsBrjJwZE1GBEiKal1To59vqqfNq0:1myIoU:DBEy-K3GJ8wkP--Kkq_sfVqiJ70RTQDCQtkaWIogi1w	2021-12-31 19:22:42.797191+00
ihb9f0ib4ti1gcfnnlmud6fdsmlliurz	.eJxVjEEOgjAQRe_StWnoUAp16Z4zNDOdqUVNSSisjHcXEha6_e-9_1YBtzWHrcoSJlZXBeryuxHGp5QD8APLfdZxLusykT4UfdKqx5nldTvdv4OMNe81WRJPxmK04vphgAhN55jBENg2OQGbTO-7pvXkO-YEDGJSahy2ewrq8wXlcjf7:1mzkJx:zgAC53CC9iu251wuJRUATgLA8WDTWDYNAmaGKmjj0WA	2022-01-04 18:57:09.820802+00
02qkud2nbectjz4p8d5elz3itr3nfp6a	.eJxVjMsOwiAQRf-FtSFTGHm4dN9vIDADUjU0Ke3K-O_apAvd3nPOfYkQt7WGreclTCwuYhCn3y1FeuS2A77HdpslzW1dpiR3RR60y3Hm_Lwe7t9Bjb1-a2QAUgRnBIShMCQTtQVtDVivnMvRZ2JNXBIUTdpopQCKsogOXfbi_QHDnDb8:1mzkNf:y_UrBroFnzCXRv_a6eDnsZOwHJRBJEZmidRzaeXg4wk	2022-01-04 19:00:59.590889+00
xvzdliz6u2a3jnthy0syqflqyqiqgb8w	.eJxVjEEOgjAQRe_StWnoUAp16Z4zNDOdqUVNSSisjHcXEha6_e-9_1YBtzWHrcoSJlZXBeryuxHGp5QD8APLfdZxLusykT4UfdKqx5nldTvdv4OMNe81WRJPxmK04vphgAhN55jBENg2OQGbTO-7pvXkO-YEDGJSahy2ewrq8wXlcjf7:1n0LJF:b4nVk890he-JXZ1p0GGu4UOnp4zoPI-J-_lN2QMOUlY	2022-01-06 10:26:53.803325+00
ye9i0bbxcldn8hwxir3yermax6g94mjm	.eJxVjEEOwiAQRe_C2hCGwiAu3fcMBAZGqoYmpV0Z765NutDtf-_9lwhxW2vYelnClMVFgDj9binSo7Qd5Htst1nS3NZlSnJX5EG7HOdcntfD_TuosddvrQwm5bgoVNZZZK-1846MgSFlJM_AYDRCGZCZrGY4M0fKHpUxlIt4fwDAETeu:1nKTmV:7ZjTndbQRN594Me0qJbm9OTZLTUd2g6MJVaRrPP09pk	2022-03-02 23:32:19.962185+00
xejxz0gcp8uik4dk3d46o7x4m1nf2d7m	.eJxVjEEOwiAQRe_C2hCGwiAu3fcMBAZGqoYmpV0Z765NutDtf-_9lwhxW2vYelnClMVFgDj9binSo7Qd5Htst1nS3NZlSnJX5EG7HOdcntfD_TuosddvrQwm5bgoVNZZZK-1846MgSFlJM_AYDRCGZCZrGY4M0fKHpUxlIt4fwDAETeu:1nL6vO:Q_dDeWhqf9nLQX7pBCMuUo82UH0a3gSlK4deXEi2HH4	2022-03-04 17:20:06.513776+00
u67jq1q10wcq2fyft3z3m8k14jxufvev	.eJxVjEEOwiAQRe_C2hCGwiAu3fcMBAZGqoYmpV0Z765NutDtf-_9lwhxW2vYelnClMVFgDj9binSo7Qd5Htst1nS3NZlSnJX5EG7HOdcntfD_TuosddvrQwm5bgoVNZZZK-1846MgSFlJM_AYDRCGZCZrGY4M0fKHpUxlIt4fwDAETeu:1nLQdQ:pSbfvMdCXSyZPnUDhBqX4WAtC-FIkIT6ixuKK2k6d6E	2022-03-05 14:22:52.74552+00
xcdcn1ad1e3709d158u22karo7d3eyo4	.eJxVjEEOwiAQRe_C2hCGwiAu3fcMBAZGqoYmpV0Z765NutDtf-_9lwhxW2vYelnClMVFgDj9binSo7Qd5Htst1nS3NZlSnJX5EG7HOdcntfD_TuosddvrQwm5bgoVNZZZK-1846MgSFlJM_AYDRCGZCZrGY4M0fKHpUxlIt4fwDAETeu:1nPZsd:xGDyasZfguUS2zZ_Liw6yPwAAXvsg8oqc1mweYpTN-4	2022-03-17 01:03:43.890897+00
\.


--
-- Data for Name: run_script_exclude_player_links; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.run_script_exclude_player_links (id, scrapper_id, link) FROM stdin;
1	2	https://fbref.com/fr/joueurs/d3e78488/matchs/2012-2013/summary/Journaux-de-match-Yohann-Thuram-Ulien
2	2	https://fbref.com/fr/joueurs/1ec4e202/matchs/2012-2013/summary/Journaux-de-match-Benjamin-Nivet
3	2	https://fbref.com/fr/joueurs/570b6a34/matchs/2012-2013/summary/Journaux-de-match-Granddi-Ngoyi
4	2	https://fbref.com/fr/joueurs/767212e6/matchs/2012-2013/summary/Journaux-de-match-Julien-Faussurier
5	2	https://fbref.com/fr/joueurs/42443716/matchs/2012-2013/summary/Journaux-de-match-Fabien-Camus
6	2	https://fbref.com/fr/joueurs/f6256137/matchs/2012-2013/summary/Journaux-de-match-Quentin-Othon
7	2	https://fbref.com/fr/joueurs/33369a23/matchs/2012-2013/summary/Journaux-de-match-Florian-Jarjat
8	2	https://fbref.com/fr/joueurs/2a13c80b/matchs/2012-2013/summary/Journaux-de-match-Jeremie-Brechet
9	2	https://fbref.com/fr/joueurs/75d97aa6/matchs/2012-2013/summary/Journaux-de-match-Stephane-Darbion
10	2	https://fbref.com/fr/joueurs/de85e3cc/matchs/2012-2013/summary/Journaux-de-match-Fabrice-NSakala
11	2	https://fbref.com/fr/joueurs/bd504946/matchs/2012-2013/summary/Journaux-de-match-Mounir-Obbadi
12	2	https://fbref.com/fr/joueurs/a8be386b/matchs/2012-2013/summary/Journaux-de-match-Jean-Christophe-Bahebeck
13	2	https://fbref.com/fr/joueurs/2f71c116/matchs/2012-2013/summary/Journaux-de-match-Maxime-Colin
14	2	https://fbref.com/fr/joueurs/62562194/matchs/2012-2013/summary/Journaux-de-match-Thiago-Xavier
15	2	https://fbref.com/fr/joueurs/4b30b37e/matchs/2010-2011/summary/Journaux-de-match-Nemanja-Vidic
16	2	https://fbref.com/fr/joueurs/51a3caf1/matchs/2010-2011/summary/Journaux-de-match-Patrice-Evra
17	2	https://fbref.com/fr/joueurs/98ee8a67/matchs/2010-2011/summary/Journaux-de-match-Edwin-van-der-Sar
\.


--
-- Data for Name: run_script_exclude_team_links; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.run_script_exclude_team_links (id, scrapper_id, link) FROM stdin;
1	2	https://fbref.com/fr/equipes/e2d8892c/2012-2013/Statistiques-Paris-Saint-Germain
2	2	https://fbref.com/fr/equipes/5725cc7b/2012-2013/Statistiques-Marseille
3	2	https://fbref.com/fr/equipes/d53c0b06/2012-2013/Statistiques-Lyon
4	2	https://fbref.com/fr/equipes/132ebc33/2012-2013/Statistiques-Nice
5	2	https://fbref.com/fr/equipes/d298ef2c/2012-2013/Statistiques-Saint-Etienne
6	2	https://fbref.com/fr/equipes/cb188c0c/2012-2013/Statistiques-Lille
7	2	https://fbref.com/fr/equipes/123f3efe/2012-2013/Statistiques-Bordeaux
8	2	https://fbref.com/fr/equipes/d2c87802/2012-2013/Statistiques-Lorient
9	2	https://fbref.com/fr/equipes/281b0e73/2012-2013/Statistiques-Montpellier
10	2	https://fbref.com/fr/equipes/3f8c4b5f/2012-2013/Statistiques-Toulouse
11	2	https://fbref.com/fr/equipes/259d3345/2012-2013/Statistiques-Valenciennes
12	2	https://fbref.com/fr/equipes/6283be2c/2012-2013/Statistiques-Bastia
13	2	https://fbref.com/fr/equipes/b3072e00/2012-2013/Statistiques-Rennes
14	2	https://fbref.com/fr/equipes/7fdd64e0/2012-2013/Statistiques-Reims
15	2	https://fbref.com/fr/equipes/b9cd3c9a/2012-2013/Statistiques-Sochaux
16	2	https://fbref.com/fr/equipes/633fbb6e/2012-2013/Statistiques-Evian
17	2	https://fbref.com/fr/equipes/7a54bb4f/2012-2013/Statistiques-Ajaccio
18	2	https://fbref.com/fr/equipes/e88fc6e5/2012-2013/Statistiques-Nancy
\.


--
-- Data for Name: run_script_fbreflinks; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.run_script_fbreflinks (id, link, league, season) FROM stdin;
1	https://fbref.com/fr/comps/13/Statistiques-Ligue-1	Current	2021
2	https://fbref.com/fr/comps/9/Statistiques-Premier-League	Current	2021
3	https://fbref.com/fr/comps/11/Statistiques-Serie-A	Current	2021
4	https://fbref.com/fr/comps/20/Statistiques-Bundesliga	Current	2021
5	https://fbref.com/fr/comps/12/Statistiques-La-Liga	Current	2021
6	https://fbref.com/fr/comps/13/401/Stats-2009-2010-Ligue-1	Ligue 1	2009
7	https://fbref.com/fr/comps/13/468/Stats-2010-2011-Ligue-1	Ligue 1	2010
8	https://fbref.com/fr/comps/13/535/Stats-2011-2012-Ligue-1	Ligue 1	2011
9	https://fbref.com/fr/comps/13/603/Stats-2012-2013-Ligue-1	Ligue 1	2012
10	https://fbref.com/fr/comps/13/670/Stats-2013-2014-Ligue-1	Ligue 1	2013
11	https://fbref.com/fr/comps/13/734/Stats-2014-2015-Ligue-1	Ligue 1	2014
12	https://fbref.com/fr/comps/13/1468/Stats-2015-2016-Ligue-1	Ligue 1	2015
13	https://fbref.com/fr/comps/13/1527/Stats-2016-2017-Ligue-1	Ligue 1	2016
14	https://fbref.com/fr/comps/13/1632/Stats-2017-2018-Ligue-1	Ligue 1	2017
15	https://fbref.com/fr/comps/13/2104/Stats-2018-2019-Ligue-1	Ligue 1	2018
16	https://fbref.com/fr/comps/13/3243/Stats-2019-2020-Ligue-1	Ligue 1	2019
17	https://fbref.com/fr/comps/13/10732/Stats-2020-2021-Ligue-1	Ligue 1	2020
18	https://fbref.com/fr/comps/9/400/Stats-2009-2010-Premier-League	Premier League	2009
19	https://fbref.com/fr/comps/9/467/Stats-2010-2011-Premier-League	Premier League	2010
20	https://fbref.com/fr/comps/9/534/Stats-2011-2012-Premier-League	Premier League	2011
21	https://fbref.com/fr/comps/9/602/Stats-2012-2013-Premier-League	Premier League	2012
22	https://fbref.com/fr/comps/9/669/Stats-2013-2014-Premier-League	Premier League	2013
23	https://fbref.com/fr/comps/9/733/Stats-2014-2015-Premier-League	Premier League	2014
24	https://fbref.com/fr/comps/9/1467/Stats-2015-2016-Premier-League	Premier League	2015
25	https://fbref.com/fr/comps/9/1526/Stats-2016-2017-Premier-League	Premier League	2016
26	https://fbref.com/fr/comps/9/1631/Stats-2017-2018-Premier-League	Premier League	2017
27	https://fbref.com/fr/comps/9/1889/Stats-2018-2019-Premier-League	Premier League	2018
28	https://fbref.com/fr/comps/9/3232/Stats-2019-2020-Premier-League	Premier League	2019
29	https://fbref.com/fr/comps/9/10728/Stats-2020-2021-Premier-League	Premier League	2020
30	https://fbref.com/fr/comps/11/410/Stats-2009-2010-Serie-A	Serie A	2009
31	https://fbref.com/fr/comps/11/477/Stats-2010-2011-Serie-A	Serie A	2010
32	https://fbref.com/fr/comps/11/544/Stats-2011-2012-Serie-A	Serie A	2011
33	https://fbref.com/fr/comps/11/611/Stats-2012-2013-Serie-A	Serie A	2012
34	https://fbref.com/fr/comps/11/678/Stats-2013-2014-Serie-A	Serie A	2013
35	https://fbref.com/fr/comps/11/742/Stats-2014-2015-Serie-A	Serie A	2014
36	https://fbref.com/fr/comps/11/1476/Stats-2015-2016-Serie-A	Serie A	2015
37	https://fbref.com/fr/comps/11/1535/Stats-2016-2017-Serie-A	Serie A	2016
38	https://fbref.com/fr/comps/11/1640/Stats-2017-2018-Serie-A	Serie A	2017
39	https://fbref.com/fr/comps/11/1896/Stats-2018-2019-Serie-A	Serie A	2018
40	https://fbref.com/fr/comps/11/3260/Stats-2019-2020-Serie-A	Serie A	2019
41	https://fbref.com/fr/comps/11/10730/Stats-2020-2021-Serie-A	Serie A	2020
42	https://fbref.com/fr/comps/20/403/Stats-2009-2010-Bundesliga	Bundesliga	2009
43	https://fbref.com/fr/comps/20/470/Stats-2010-2011-Bundesliga	Bundesliga	2010
44	https://fbref.com/fr/comps/20/537/Stats-2011-2012-Bundesliga	Bundesliga	2011
45	https://fbref.com/fr/comps/20/605/Stats-2012-2013-Bundesliga	Bundesliga	2012
46	https://fbref.com/fr/comps/20/672/Stats-2013-2014-Bundesliga	Bundesliga	2013
47	https://fbref.com/fr/comps/20/736/Stats-2014-2015-Bundesliga	Bundesliga	2014
48	https://fbref.com/fr/comps/20/1470/Stats-2015-2016-Bundesliga	Bundesliga	2015
49	https://fbref.com/fr/comps/20/1529/Stats-2016-2017-Bundesliga	Bundesliga	2016
50	https://fbref.com/fr/comps/20/1634/Stats-2017-2018-Bundesliga	Bundesliga	2017
51	https://fbref.com/fr/comps/20/2109/Stats-2018-2019-Bundesliga	Bundesliga	2018
52	https://fbref.com/fr/comps/20/3248/Stats-2019-2020-Bundesliga	Bundesliga	2019
53	https://fbref.com/fr/comps/20/10737/Stats-2020-2021-Bundesliga	Bundesliga	2020
54	https://fbref.com/fr/comps/12/422/Stats-2009-2010-La-Liga	Liga	2009
55	https://fbref.com/fr/comps/12/488/Stats-2010-2011-La-Liga	Liga	2010
56	https://fbref.com/fr/comps/12/557/Stats-2011-2012-La-Liga	Liga	2011
57	https://fbref.com/fr/comps/12/624/Stats-2012-2013-La-Liga	Liga	2012
58	https://fbref.com/fr/comps/12/690/Stats-2013-2014-La-Liga	Liga	2013
59	https://fbref.com/fr/comps/12/755/Stats-2014-2015-La-Liga	Liga	2014
60	https://fbref.com/fr/comps/12/1488/Stats-2015-2016-La-Liga	Liga	2015
61	https://fbref.com/fr/comps/12/1547/Stats-2016-2017-La-Liga	Liga	2016
62	https://fbref.com/fr/comps/12/1652/Stats-2017-2018-La-Liga	Liga	2017
63	https://fbref.com/fr/comps/12/1886/Stats-2018-2019-La-Liga	Liga	2018
64	https://fbref.com/fr/comps/12/3239/Stats-2019-2020-La-Liga	Liga	2019
65	https://fbref.com/fr/comps/12/10731/Stats-2020-2021-La-Liga	Liga	2020
\.


--
-- Data for Name: run_script_files; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.run_script_files (id, path, player, team, league, season, "dateIns") FROM stdin;
1	Ajaccio_Adrian Mutu_2012.csv	Adrian Mutu	Ajaccio	league	2012	2022-01-29 23:46:05.757689+00
2	Ajaccio_Ammar Jemal_2012.csv	Ammar Jemal	Ajaccio	league	2012	2022-01-29 23:46:05.776242+00
3	Ajaccio_Andy Delort_2011.csv	Andy Delort	Ajaccio	league	2011	2022-01-29 23:46:05.777032+00
4	Ajaccio_Andy Delort_2012.csv	Andy Delort	Ajaccio	league	2012	2022-01-29 23:46:05.777723+00
5	Ajaccio_Anthony Lippini_2011.csv	Anthony Lippini	Ajaccio	league	2011	2022-01-29 23:46:05.778381+00
6	Ajaccio_Anthony Lippini_2012.csv	Anthony Lippini	Ajaccio	league	2012	2022-01-29 23:46:05.779507+00
7	Ajaccio_Arnaud Maire_2011.csv	Arnaud Maire	Ajaccio	league	2011	2022-01-29 23:46:05.780343+00
8	Ajaccio_Arnaud Maire_2012.csv	Arnaud Maire	Ajaccio	league	2012	2022-01-29 23:46:05.781186+00
9	Ajaccio_Benjamin André_2011.csv	Benjamin André	Ajaccio	league	2011	2022-01-29 23:46:05.781962+00
10	Ajaccio_Benjamin André_2012.csv	Benjamin André	Ajaccio	league	2012	2022-01-29 23:46:05.806596+00
11	Ajaccio_Carl Medjani_2011.csv	Carl Medjani	Ajaccio	league	2011	2022-01-29 23:46:05.808106+00
12	Ajaccio_Carl Medjani_2012.csv	Carl Medjani	Ajaccio	league	2012	2022-01-29 23:46:05.809282+00
13	Ajaccio_Chahir Belghazouani_2012.csv	Chahir Belghazouani	Ajaccio	league	2012	2022-01-29 23:46:05.810172+00
14	Ajaccio_Christian Kinkela_2011.csv	Christian Kinkela	Ajaccio	league	2011	2022-01-29 23:46:05.811058+00
15	Ajaccio_Damien Tibéri_2011.csv	Damien Tibéri	Ajaccio	league	2011	2022-01-29 23:46:05.811909+00
16	Ajaccio_Damien Tibéri_2012.csv	Damien Tibéri	Ajaccio	league	2012	2022-01-29 23:46:05.812717+00
17	Ajaccio_David Gigliotti_2012.csv	David Gigliotti	Ajaccio	league	2012	2022-01-29 23:46:05.813481+00
18	Ajaccio_David Oberhauser_2012.csv	David Oberhauser	Ajaccio	league	2012	2022-01-29 23:46:05.814418+00
19	Ajaccio_Dennis Oliech_2012.csv	Dennis Oliech	Ajaccio	league	2012	2022-01-29 23:46:05.815457+00
20	Ajaccio_Eduardo dos Santos_2011.csv	Eduardo dos Santos	Ajaccio	league	2011	2022-01-29 23:46:05.816179+00
21	Ajaccio_Eduardo dos Santos_2012.csv	Eduardo dos Santos	Ajaccio	league	2012	2022-01-29 23:46:05.816872+00
22	Ajaccio_Fabrice Begeorgi_2011.csv	Fabrice Begeorgi	Ajaccio	league	2011	2022-01-29 23:46:05.817621+00
23	Ajaccio_Fabrice Begeorgi_2012.csv	Fabrice Begeorgi	Ajaccio	league	2012	2022-01-29 23:46:05.818304+00
24	Ajaccio_Felipe Saad_2011.csv	Felipe Saad	Ajaccio	league	2011	2022-01-29 23:46:05.818979+00
25	Ajaccio_Felipe Saad_2012.csv	Felipe Saad	Ajaccio	league	2012	2022-01-29 23:46:05.819614+00
26	Ajaccio_Fousseni Diawara_2011.csv	Fousseni Diawara	Ajaccio	league	2011	2022-01-29 23:46:05.820313+00
27	Ajaccio_Fousseni Diawara_2012.csv	Fousseni Diawara	Ajaccio	league	2012	2022-01-29 23:46:05.821018+00
28	Ajaccio_Frédéric Sammaritano_2011.csv	Frédéric Sammaritano	Ajaccio	league	2011	2022-01-29 23:46:05.82294+00
29	Ajaccio_Frédéric Sammaritano_2012.csv	Frédéric Sammaritano	Ajaccio	league	2012	2022-01-29 23:46:05.824894+00
30	Ajaccio_Guillermo Ochoa_2011.csv	Guillermo Ochoa	Ajaccio	league	2011	2022-01-29 23:46:05.826163+00
31	Ajaccio_Guillermo Ochoa_2012.csv	Guillermo Ochoa	Ajaccio	league	2012	2022-01-29 23:46:05.826901+00
32	Ajaccio_Ilan_2011.csv	Ilan	Ajaccio	league	2011	2022-01-29 23:46:05.827609+00
33	Ajaccio_Jackson Mendy_2011.csv	Jackson Mendy	Ajaccio	league	2011	2022-01-29 23:46:05.828282+00
34	Ajaccio_Jean-Baptiste Pierazzi_2011.csv	Jean-Baptiste Pierazzi	Ajaccio	league	2011	2022-01-29 23:46:05.828938+00
35	Ajaccio_Jean-Baptiste Pierazzi_2012.csv	Jean-Baptiste Pierazzi	Ajaccio	league	2012	2022-01-29 23:46:05.829879+00
36	Ajaccio_Johan Cavalli_2011.csv	Johan Cavalli	Ajaccio	league	2011	2022-01-29 23:46:05.830691+00
37	Ajaccio_Johan Cavalli_2012.csv	Johan Cavalli	Ajaccio	league	2012	2022-01-29 23:46:05.831667+00
38	Ajaccio_Karim El Hany_2011.csv	Karim El Hany	Ajaccio	league	2011	2022-01-29 23:46:05.832445+00
39	Ajaccio_Leyti N'Diaye_2011.csv	Leyti N'Diaye	Ajaccio	league	2011	2022-01-29 23:46:05.833354+00
40	Ajaccio_Matthieu Chalmé_2012.csv	Matthieu Chalmé	Ajaccio	league	2012	2022-01-29 23:46:05.834295+00
41	Ajaccio_Mehdi Mostefa_2011.csv	Mehdi Mostefa	Ajaccio	league	2011	2022-01-29 23:46:05.835109+00
42	Ajaccio_Mehdi Mostefa_2012.csv	Mehdi Mostefa	Ajaccio	league	2012	2022-01-29 23:46:05.835791+00
43	Ajaccio_Paul Lasne_2011.csv	Paul Lasne	Ajaccio	league	2011	2022-01-29 23:46:05.836446+00
44	Ajaccio_Paul Lasne_2012.csv	Paul Lasne	Ajaccio	league	2012	2022-01-29 23:46:05.837183+00
45	Ajaccio_Ricardo Faty_2012.csv	Ricardo Faty	Ajaccio	league	2012	2022-01-29 23:46:05.837925+00
46	Ajaccio_Richard Socrier_2011.csv	Richard Socrier	Ajaccio	league	2011	2022-01-29 23:46:05.83919+00
47	Ajaccio_Ronald Zubar_2012.csv	Ronald Zubar	Ajaccio	league	2012	2022-01-29 23:46:05.840422+00
48	Ajaccio_Samuel Bouhours_2011.csv	Samuel Bouhours	Ajaccio	league	2011	2022-01-29 23:46:05.841531+00
49	Ajaccio_Samuel Bouhours_2012.csv	Samuel Bouhours	Ajaccio	league	2012	2022-01-29 23:46:05.842326+00
50	Ajaccio_Sigamary Diarra_2012.csv	Sigamary Diarra	Ajaccio	league	2012	2022-01-29 23:46:05.843005+00
51	Ajaccio_Thierry Debès_2011.csv	Thierry Debès	Ajaccio	league	2011	2022-01-29 23:46:05.843713+00
52	Ajaccio_Yoann Poulard_2011.csv	Yoann Poulard	Ajaccio	league	2011	2022-01-29 23:46:05.844382+00
53	Ajaccio_Yoann Poulard_2012.csv	Yoann Poulard	Ajaccio	league	2012	2022-01-29 23:46:05.845025+00
54	Arles-Avignon_Amin Erbati_2010.csv	Amin Erbati	Arles-Avignon	league	2010	2022-01-29 23:46:05.845732+00
55	Arles-Avignon_Angelos Basinas_2010.csv	Angelos Basinas	Arles-Avignon	league	2010	2022-01-29 23:46:05.846475+00
56	Arles-Avignon_Angelos Charisteas_2010.csv	Angelos Charisteas	Arles-Avignon	league	2010	2022-01-29 23:46:05.84731+00
57	Arles-Avignon_Anthony Guise_2010.csv	Anthony Guise	Arles-Avignon	league	2010	2022-01-29 23:46:05.848556+00
58	Arles-Avignon_Álvaro Mejía_2010.csv	Álvaro Mejía	Arles-Avignon	league	2010	2022-01-29 23:46:05.849362+00
59	Arles-Avignon_Bakary Soro_2010.csv	Bakary Soro	Arles-Avignon	league	2010	2022-01-29 23:46:05.850181+00
60	Arles-Avignon_Benjamin Psaume_2010.csv	Benjamin Psaume	Arles-Avignon	league	2010	2022-01-29 23:46:05.8509+00
61	Arles-Avignon_Bobo Baldé_2010.csv	Bobo Baldé	Arles-Avignon	league	2010	2022-01-29 23:46:05.851666+00
62	Arles-Avignon_Camel Meriem_2010.csv	Camel Meriem	Arles-Avignon	league	2010	2022-01-29 23:46:05.85241+00
63	Arles-Avignon_Chafik Najih_2010.csv	Chafik Najih	Arles-Avignon	league	2010	2022-01-29 23:46:05.853148+00
64	Arles-Avignon_Clément Martinez_2010.csv	Clément Martinez	Arles-Avignon	league	2010	2022-01-29 23:46:05.853903+00
65	Arles-Avignon_Cyrille Merville_2010.csv	Cyrille Merville	Arles-Avignon	league	2010	2022-01-29 23:46:05.85473+00
66	Arles-Avignon_Deme N'Diaye_2010.csv	Deme N'Diaye	Arles-Avignon	league	2010	2022-01-29 23:46:05.856034+00
67	Arles-Avignon_Emmanuel Corrèze_2010.csv	Emmanuel Corrèze	Arles-Avignon	league	2010	2022-01-29 23:46:05.857132+00
68	Arles-Avignon_Fabien Laurenti_2010.csv	Fabien Laurenti	Arles-Avignon	league	2010	2022-01-29 23:46:05.857956+00
69	Arles-Avignon_Francisco Pavón_2010.csv	Francisco Pavón	Arles-Avignon	league	2010	2022-01-29 23:46:05.858603+00
70	Arles-Avignon_Franck Dja Djédjé_2010.csv	Franck Dja Djédjé	Arles-Avignon	league	2010	2022-01-29 23:46:05.859357+00
71	Arles-Avignon_Gaël Germany_2010.csv	Gaël Germany	Arles-Avignon	league	2010	2022-01-29 23:46:05.860022+00
72	Arles-Avignon_Grégory Lorenzi_2010.csv	Grégory Lorenzi	Arles-Avignon	league	2010	2022-01-29 23:46:05.860768+00
73	Arles-Avignon_Hameur Bouazza_2010.csv	Hameur Bouazza	Arles-Avignon	league	2010	2022-01-29 23:46:05.861472+00
74	Arles-Avignon_Jamel Aït Ben Idir_2010.csv	Jamel Aït Ben Idir	Arles-Avignon	league	2010	2022-01-29 23:46:05.863761+00
75	Arles-Avignon_Jean-Alain Fanchone_2010.csv	Jean-Alain Fanchone	Arles-Avignon	league	2010	2022-01-29 23:46:05.864938+00
76	Arles-Avignon_Johnathan_2010.csv	Johnathan	Arles-Avignon	league	2010	2022-01-29 23:46:05.865662+00
77	Arles-Avignon_Kaba Diawara_2010.csv	Kaba Diawara	Arles-Avignon	league	2010	2022-01-29 23:46:05.866438+00
78	Arles-Avignon_Kamel Ghilas_2010.csv	Kamel Ghilas	Arles-Avignon	league	2010	2022-01-29 23:46:05.867233+00
79	Arles-Avignon_Loïc Abenzoar_2010.csv	Loïc Abenzoar	Arles-Avignon	league	2010	2022-01-29 23:46:05.86789+00
80	Arles-Avignon_Naby Yattara_2010.csv	Naby Yattara	Arles-Avignon	league	2010	2022-01-29 23:46:05.86854+00
81	Arles-Avignon_Rachid Aliaoui_2010.csv	Rachid Aliaoui	Arles-Avignon	league	2010	2022-01-29 23:46:05.869272+00
82	Arles-Avignon_Rémy Cabella_2010.csv	Rémy Cabella	Arles-Avignon	league	2010	2022-01-29 23:46:05.870023+00
83	Arles-Avignon_Romain Rocchi_2010.csv	Romain Rocchi	Arles-Avignon	league	2010	2022-01-29 23:46:05.870791+00
84	Arles-Avignon_Sébastien Piocelle_2010.csv	Sébastien Piocelle	Arles-Avignon	league	2010	2022-01-29 23:46:05.871867+00
85	Arles-Avignon_Thomas Ayasse_2010.csv	Thomas Ayasse	Arles-Avignon	league	2010	2022-01-29 23:46:05.873124+00
86	Arles-Avignon_Vincent Planté_2010.csv	Vincent Planté	Arles-Avignon	league	2010	2022-01-29 23:46:05.873897+00
87	Arles-Avignon_Yann Kermorgant_2010.csv	Yann Kermorgant	Arles-Avignon	league	2010	2022-01-29 23:46:05.874969+00
88	Auxerre_Adama Coulibaly_2009.csv	Adama Coulibaly	Auxerre	league	2009	2022-01-29 23:46:05.875886+00
89	Auxerre_Adama Coulibaly_2010.csv	Adama Coulibaly	Auxerre	league	2010	2022-01-29 23:46:05.876697+00
90	Auxerre_Adama Coulibaly_2011.csv	Adama Coulibaly	Auxerre	league	2011	2022-01-29 23:46:05.877499+00
91	Auxerre_Alain Traoré_2009.csv	Alain Traoré	Auxerre	league	2009	2022-01-29 23:46:05.878183+00
92	Auxerre_Alain Traoré_2010.csv	Alain Traoré	Auxerre	league	2010	2022-01-29 23:46:05.878911+00
93	Auxerre_Alain Traoré_2011.csv	Alain Traoré	Auxerre	league	2011	2022-01-29 23:46:05.87992+00
94	Auxerre_Amadou Sidibé_2010.csv	Amadou Sidibé	Auxerre	league	2010	2022-01-29 23:46:05.881089+00
95	Auxerre_Amadou Sidibé_2011.csv	Amadou Sidibé	Auxerre	league	2011	2022-01-29 23:46:05.882899+00
96	Auxerre_Anthony Le Tallec_2010.csv	Anthony Le Tallec	Auxerre	league	2010	2022-01-29 23:46:05.883644+00
97	Auxerre_Anthony Le Tallec_2011.csv	Anthony Le Tallec	Auxerre	league	2011	2022-01-29 23:46:05.884376+00
98	Auxerre_Aurélien Capoue_2009.csv	Aurélien Capoue	Auxerre	league	2009	2022-01-29 23:46:05.885022+00
99	Auxerre_Ben Sahar_2011.csv	Ben Sahar	Auxerre	league	2011	2022-01-29 23:46:05.885775+00
100	Auxerre_Benoît Pedretti_2009.csv	Benoît Pedretti	Auxerre	league	2009	2022-01-29 23:46:05.886557+00
101	Auxerre_Benoît Pedretti_2010.csv	Benoît Pedretti	Auxerre	league	2010	2022-01-29 23:46:05.887234+00
102	Auxerre_Cédric Hengbart_2009.csv	Cédric Hengbart	Auxerre	league	2009	2022-01-29 23:46:05.889892+00
103	Auxerre_Cédric Hengbart_2010.csv	Cédric Hengbart	Auxerre	league	2010	2022-01-29 23:46:05.890963+00
104	Auxerre_Cédric Hengbart_2011.csv	Cédric Hengbart	Auxerre	league	2011	2022-01-29 23:46:05.891762+00
105	Auxerre_Christopher Missilou_2011.csv	Christopher Missilou	Auxerre	league	2011	2022-01-29 23:46:05.892445+00
106	Auxerre_Cyriaque Rivieyran_2011.csv	Cyriaque Rivieyran	Auxerre	league	2011	2022-01-29 23:46:05.893145+00
107	Auxerre_Daniel Niculae_2009.csv	Daniel Niculae	Auxerre	league	2009	2022-01-29 23:46:05.89381+00
108	Auxerre_Dariusz Dudka_2009.csv	Dariusz Dudka	Auxerre	league	2009	2022-01-29 23:46:05.894447+00
109	Auxerre_Dariusz Dudka_2010.csv	Dariusz Dudka	Auxerre	league	2010	2022-01-29 23:46:05.895094+00
110	Auxerre_Dariusz Dudka_2011.csv	Dariusz Dudka	Auxerre	league	2011	2022-01-29 23:46:05.895815+00
111	Auxerre_David Camps_2011.csv	David Camps	Auxerre	league	2011	2022-01-29 23:46:05.896781+00
112	Auxerre_Delvin N'Dinga_2009.csv	Delvin N'Dinga	Auxerre	league	2009	2022-01-29 23:46:05.89768+00
113	Auxerre_Delvin N'Dinga_2010.csv	Delvin N'Dinga	Auxerre	league	2010	2022-01-29 23:46:05.89873+00
114	Auxerre_Delvin N'Dinga_2011.csv	Delvin N'Dinga	Auxerre	league	2011	2022-01-29 23:46:05.899557+00
115	Auxerre_Dennis Oliech_2009.csv	Dennis Oliech	Auxerre	league	2009	2022-01-29 23:46:05.900236+00
116	Auxerre_Dennis Oliech_2010.csv	Dennis Oliech	Auxerre	league	2010	2022-01-29 23:46:05.900904+00
117	Auxerre_Dennis Oliech_2011.csv	Dennis Oliech	Auxerre	league	2011	2022-01-29 23:46:05.901644+00
118	Auxerre_Donovan Léon_2011.csv	Donovan Léon	Auxerre	league	2011	2022-01-29 23:46:05.90228+00
119	Auxerre_Édouard Cissé_2011.csv	Édouard Cissé	Auxerre	league	2011	2022-01-29 23:46:05.903049+00
120	Auxerre_Frédéric Sammaritano_2010.csv	Frédéric Sammaritano	Auxerre	league	2010	2022-01-29 23:46:05.903714+00
121	Auxerre_Georges Mandjeck_2011.csv	Georges Mandjeck	Auxerre	league	2011	2022-01-29 23:46:05.904485+00
122	Auxerre_Ireneusz Jeleń_2009.csv	Ireneusz Jeleń	Auxerre	league	2009	2022-01-29 23:46:05.905843+00
123	Auxerre_Ireneusz Jeleń_2010.csv	Ireneusz Jeleń	Auxerre	league	2010	2022-01-29 23:46:05.9069+00
124	Auxerre_Issam Jemâa_2011.csv	Issam Jemâa	Auxerre	league	2011	2022-01-29 23:46:05.907743+00
125	Auxerre_Jean-Pascal Mignot_2009.csv	Jean-Pascal Mignot	Auxerre	league	2009	2022-01-29 23:46:05.90843+00
126	Auxerre_Jean-Pascal Mignot_2010.csv	Jean-Pascal Mignot	Auxerre	league	2010	2022-01-29 23:46:05.909123+00
127	Auxerre_Jérémy Berthod_2009.csv	Jérémy Berthod	Auxerre	league	2009	2022-01-29 23:46:05.90979+00
128	Auxerre_Jérémy Berthod_2010.csv	Jérémy Berthod	Auxerre	league	2010	2022-01-29 23:46:05.910439+00
129	Auxerre_Jérémy Berthod_2011.csv	Jérémy Berthod	Auxerre	league	2011	2022-01-29 23:46:05.911084+00
130	Auxerre_Julien Quercia_2009.csv	Julien Quercia	Auxerre	league	2009	2022-01-29 23:46:05.911822+00
131	Auxerre_Julien Quercia_2010.csv	Julien Quercia	Auxerre	league	2010	2022-01-29 23:46:05.912545+00
132	Auxerre_Jung Jo-gook_2010.csv	Jung Jo-gook	Auxerre	league	2010	2022-01-29 23:46:05.913518+00
133	Auxerre_Jung Jo-gook_2011.csv	Jung Jo-gook	Auxerre	league	2011	2022-01-29 23:46:05.91447+00
134	Auxerre_Kamel Chafni_2009.csv	Kamel Chafni	Auxerre	league	2009	2022-01-29 23:46:05.915441+00
135	Auxerre_Kamel Chafni_2010.csv	Kamel Chafni	Auxerre	league	2010	2022-01-29 23:46:05.916126+00
136	Auxerre_Kamel Chafni_2011.csv	Kamel Chafni	Auxerre	league	2011	2022-01-29 23:46:05.916816+00
137	Auxerre_Kevin Lejeune_2009.csv	Kevin Lejeune	Auxerre	league	2009	2022-01-29 23:46:05.917458+00
138	Auxerre_Kévin Malaga_2009.csv	Kévin Malaga	Auxerre	league	2009	2022-01-29 23:46:05.918186+00
139	Auxerre_Maxime Bourgeois_2009.csv	Maxime Bourgeois	Auxerre	league	2009	2022-01-29 23:46:05.918877+00
140	Auxerre_Maxime Bourgeois_2010.csv	Maxime Bourgeois	Auxerre	league	2010	2022-01-29 23:46:05.919521+00
141	Auxerre_Moussa Narry_2009.csv	Moussa Narry	Auxerre	league	2009	2022-01-29 23:46:05.920251+00
142	Auxerre_Olivier Kapo_2011.csv	Olivier Kapo	Auxerre	league	2011	2022-01-29 23:46:05.920979+00
143	Auxerre_Olivier Sorin_2009.csv	Olivier Sorin	Auxerre	league	2009	2022-01-29 23:46:05.922836+00
144	Auxerre_Olivier Sorin_2010.csv	Olivier Sorin	Auxerre	league	2010	2022-01-29 23:46:05.923799+00
145	Auxerre_Olivier Sorin_2011.csv	Olivier Sorin	Auxerre	league	2011	2022-01-29 23:46:05.924664+00
146	Auxerre_Omar Kossoko_2011.csv	Omar Kossoko	Auxerre	league	2011	2022-01-29 23:46:05.926036+00
147	Auxerre_Onanga Itoua_2010.csv	Onanga Itoua	Auxerre	league	2010	2022-01-29 23:46:05.926719+00
148	Auxerre_Prince Segbefia_2010.csv	Prince Segbefia	Auxerre	league	2010	2022-01-29 23:46:05.927386+00
149	Auxerre_Prince Segbefia_2011.csv	Prince Segbefia	Auxerre	league	2011	2022-01-29 23:46:05.92811+00
150	Auxerre_Rémy Riou_2009.csv	Rémy Riou	Auxerre	league	2009	2022-01-29 23:46:05.928835+00
151	Auxerre_Roy Contout_2009.csv	Roy Contout	Auxerre	league	2009	2022-01-29 23:46:05.93008+00
152	Auxerre_Roy Contout_2010.csv	Roy Contout	Auxerre	league	2010	2022-01-29 23:46:05.930775+00
153	Auxerre_Roy Contout_2011.csv	Roy Contout	Auxerre	league	2011	2022-01-29 23:46:05.931525+00
154	Auxerre_Rudy Haddad_2011.csv	Rudy Haddad	Auxerre	league	2011	2022-01-29 23:46:05.932343+00
155	Auxerre_Soualiho Meïté_2011.csv	Soualiho Meïté	Auxerre	league	2011	2022-01-29 23:46:05.933102+00
156	Auxerre_Steeven Langil_2010.csv	Steeven Langil	Auxerre	league	2010	2022-01-29 23:46:05.933862+00
157	Auxerre_Stéphane Grichting_2009.csv	Stéphane Grichting	Auxerre	league	2009	2022-01-29 23:46:05.934533+00
158	Auxerre_Stéphane Grichting_2010.csv	Stéphane Grichting	Auxerre	league	2010	2022-01-29 23:46:05.935164+00
159	Auxerre_Stéphane Grichting_2011.csv	Stéphane Grichting	Auxerre	league	2011	2022-01-29 23:46:05.935832+00
160	Auxerre_Valter Birsa_2009.csv	Valter Birsa	Auxerre	league	2009	2022-01-29 23:46:05.936458+00
161	Auxerre_Valter Birsa_2010.csv	Valter Birsa	Auxerre	league	2010	2022-01-29 23:46:05.937176+00
162	Auxerre_Willy Boly_2010.csv	Willy Boly	Auxerre	league	2010	2022-01-29 23:46:05.939302+00
163	Auxerre_Willy Boly_2011.csv	Willy Boly	Auxerre	league	2011	2022-01-29 23:46:05.940572+00
164	Auxerre_Yaya Sanogo_2009.csv	Yaya Sanogo	Auxerre	league	2009	2022-01-29 23:46:05.941326+00
165	Auxerre_Yaya Sanogo_2011.csv	Yaya Sanogo	Auxerre	league	2011	2022-01-29 23:46:05.942103+00
166	Bastia_Abdoulaye Keita_2012.csv	Abdoulaye Keita	Bastia	league	2012	2022-01-29 23:46:05.942789+00
167	Bastia_Anthony Modeste_2012.csv	Anthony Modeste	Bastia	league	2012	2022-01-29 23:46:05.943441+00
168	Bastia_Christophe Vincent_2012.csv	Christophe Vincent	Bastia	league	2012	2022-01-29 23:46:05.944145+00
169	Bastia_Claudio Beauvue_2012.csv	Claudio Beauvue	Bastia	league	2012	2022-01-29 23:46:05.944941+00
170	Bastia_Féthi Harek_2012.csv	Féthi Harek	Bastia	league	2012	2022-01-29 23:46:05.945614+00
171	Bastia_Florian Thauvin_2012.csv	Florian Thauvin	Bastia	league	2012	2022-01-29 23:46:05.946263+00
172	Bastia_François Marque_2012.csv	François Marque	Bastia	league	2012	2022-01-29 23:46:05.946994+00
173	Bastia_Gaël Angoula_2012.csv	Gaël Angoula	Bastia	league	2012	2022-01-29 23:46:05.94781+00
174	Bastia_Gilles Cioni_2012.csv	Gilles Cioni	Bastia	league	2012	2022-01-29 23:46:05.94876+00
175	Bastia_Ilan_2012.csv	Ilan	Bastia	league	2012	2022-01-29 23:46:05.949663+00
176	Bastia_Jacques Faty_2012.csv	Jacques Faty	Bastia	league	2012	2022-01-29 23:46:05.950471+00
177	Bastia_Jérémy Choplin_2012.csv	Jérémy Choplin	Bastia	league	2012	2022-01-29 23:46:05.951183+00
178	Bastia_Jérôme Rothen_2012.csv	Jérôme Rothen	Bastia	league	2012	2022-01-29 23:46:05.951959+00
179	Bastia_Joseph Barbato_2012.csv	Joseph Barbato	Bastia	league	2012	2022-01-29 23:46:05.952733+00
180	Bastia_Julian Palmieri_2012.csv	Julian Palmieri	Bastia	league	2012	2022-01-29 23:46:05.953474+00
181	Bastia_Julien Sablé_2012.csv	Julien Sablé	Bastia	league	2012	2022-01-29 23:46:05.954188+00
182	Bastia_Landry Bonnefoi_2012.csv	Landry Bonnefoi	Bastia	league	2012	2022-01-29 23:46:05.955618+00
183	Bastia_Macedo Novaes_2012.csv	Macedo Novaes	Bastia	league	2012	2022-01-29 23:46:05.956511+00
184	Bastia_Maka Mary_2012.csv	Maka Mary	Bastia	league	2012	2022-01-29 23:46:05.957175+00
185	Bastia_Matthias Llambrich_2012.csv	Matthias Llambrich	Bastia	league	2012	2022-01-29 23:46:05.957941+00
186	Bastia_Matthieu Sans_2012.csv	Matthieu Sans	Bastia	league	2012	2022-01-29 23:46:05.958668+00
187	Bastia_Mickaël Landreau_2012.csv	Mickaël Landreau	Bastia	league	2012	2022-01-29 23:46:05.959313+00
188	Bastia_Sambou Yatabaré_2012.csv	Sambou Yatabaré	Bastia	league	2012	2022-01-29 23:46:05.959957+00
189	Bastia_Samuel Inkoom_2012.csv	Samuel Inkoom	Bastia	league	2012	2022-01-29 23:46:05.960758+00
190	Bastia_Sylvain Marchal_2012.csv	Sylvain Marchal	Bastia	league	2012	2022-01-29 23:46:05.961417+00
191	Bastia_Toifilou Maoulida_2012.csv	Toifilou Maoulida	Bastia	league	2012	2022-01-29 23:46:05.962157+00
192	Bastia_Wahbi Khazri_2012.csv	Wahbi Khazri	Bastia	league	2012	2022-01-29 23:46:05.962976+00
193	Bastia_Yannick Cahuzac_2012.csv	Yannick Cahuzac	Bastia	league	2012	2022-01-29 23:46:05.963632+00
194	Bastia_Yassin El-Azzouzi_2012.csv	Yassin El-Azzouzi	Bastia	league	2012	2022-01-29 23:46:05.96426+00
195	Bordeaux_Abdou Traoré_2009.csv	Abdou Traoré	Bordeaux	league	2009	2022-01-29 23:46:05.964945+00
196	Bordeaux_Abdou Traoré_2011.csv	Abdou Traoré	Bordeaux	league	2011	2022-01-29 23:46:05.965594+00
197	Bordeaux_Abdou Traoré_2012.csv	Abdou Traoré	Bordeaux	league	2012	2022-01-29 23:46:05.966327+00
198	Bordeaux_Abdoulaye Keita_2009.csv	Abdoulaye Keita	Bordeaux	league	2009	2022-01-29 23:46:05.966984+00
199	Bordeaux_Abdoulaye Keita_2011.csv	Abdoulaye Keita	Bordeaux	league	2011	2022-01-29 23:46:05.967617+00
200	Bordeaux_Alou Diarra_2009.csv	Alou Diarra	Bordeaux	league	2009	2022-01-29 23:46:05.968286+00
201	Bordeaux_Alou Diarra_2010.csv	Alou Diarra	Bordeaux	league	2010	2022-01-29 23:46:05.968949+00
202	Bordeaux_André Biyogo Poko_2012.csv	André Biyogo Poko	Bordeaux	league	2012	2022-01-29 23:46:05.969612+00
203	Bordeaux_André_2010.csv	André	Bordeaux	league	2010	2022-01-29 23:46:05.970278+00
204	Bordeaux_Anthony Modeste_2010.csv	Anthony Modeste	Bordeaux	league	2010	2022-01-29 23:46:05.971192+00
205	Bordeaux_Anthony Modeste_2011.csv	Anthony Modeste	Bordeaux	league	2011	2022-01-29 23:46:05.973252+00
206	Bordeaux_Benoît Trémoulinas_2009.csv	Benoît Trémoulinas	Bordeaux	league	2009	2022-01-29 23:46:05.974098+00
207	Bordeaux_Benoît Trémoulinas_2010.csv	Benoît Trémoulinas	Bordeaux	league	2010	2022-01-29 23:46:05.974819+00
208	Bordeaux_Benoît Trémoulinas_2011.csv	Benoît Trémoulinas	Bordeaux	league	2011	2022-01-29 23:46:05.975591+00
209	Bordeaux_Benoît Trémoulinas_2012.csv	Benoît Trémoulinas	Bordeaux	league	2012	2022-01-29 23:46:05.976291+00
210	Bordeaux_Cédric Carrasso_2009.csv	Cédric Carrasso	Bordeaux	league	2009	2022-01-29 23:46:05.977059+00
211	Bordeaux_Cédric Carrasso_2010.csv	Cédric Carrasso	Bordeaux	league	2010	2022-01-29 23:46:05.977811+00
212	Bordeaux_Cédric Carrasso_2011.csv	Cédric Carrasso	Bordeaux	league	2011	2022-01-29 23:46:05.978473+00
213	Bordeaux_Cédric Carrasso_2012.csv	Cédric Carrasso	Bordeaux	league	2012	2022-01-29 23:46:05.979205+00
214	Bordeaux_Cheick Diabaté_2010.csv	Cheick Diabaté	Bordeaux	league	2010	2022-01-29 23:46:05.980518+00
215	Bordeaux_Cheick Diabaté_2011.csv	Cheick Diabaté	Bordeaux	league	2011	2022-01-29 23:46:05.981516+00
216	Bordeaux_Cheick Diabaté_2012.csv	Cheick Diabaté	Bordeaux	league	2012	2022-01-29 23:46:05.982409+00
217	Bordeaux_David Bellion_2009.csv	David Bellion	Bordeaux	league	2009	2022-01-29 23:46:05.983413+00
218	Bordeaux_David Bellion_2010.csv	David Bellion	Bordeaux	league	2010	2022-01-29 23:46:05.984313+00
219	Bordeaux_David Bellion_2011.csv	David Bellion	Bordeaux	league	2011	2022-01-29 23:46:05.98504+00
220	Bordeaux_David Bellion_2012.csv	David Bellion	Bordeaux	league	2012	2022-01-29 23:46:05.985788+00
221	Bordeaux_Diego Placente_2009.csv	Diego Placente	Bordeaux	league	2009	2022-01-29 23:46:05.986486+00
222	Bordeaux_Diego Rolán_2012.csv	Diego Rolán	Bordeaux	league	2012	2022-01-29 23:46:05.987209+00
223	Bordeaux_Evan Chevalier_2010.csv	Evan Chevalier	Bordeaux	league	2010	2022-01-29 23:46:05.988422+00
224	Bordeaux_Fahid Ben Khalfallah_2010.csv	Fahid Ben Khalfallah	Bordeaux	league	2010	2022-01-29 23:46:05.98934+00
225	Bordeaux_Fahid Ben Khalfallah_2011.csv	Fahid Ben Khalfallah	Bordeaux	league	2011	2022-01-29 23:46:05.990118+00
226	Bordeaux_Fahid Ben Khalfallah_2012.csv	Fahid Ben Khalfallah	Bordeaux	league	2012	2022-01-29 23:46:05.99082+00
227	Bordeaux_Fernando Cavenaghi_2009.csv	Fernando Cavenaghi	Bordeaux	league	2009	2022-01-29 23:46:05.991488+00
228	Bordeaux_Fernando Cavenaghi_2010.csv	Fernando Cavenaghi	Bordeaux	league	2010	2022-01-29 23:46:05.992297+00
229	Bordeaux_Fernando Menegazzo_2009.csv	Fernando Menegazzo	Bordeaux	league	2009	2022-01-29 23:46:05.993004+00
230	Bordeaux_Fernando Menegazzo_2010.csv	Fernando Menegazzo	Bordeaux	league	2010	2022-01-29 23:46:05.993697+00
231	Bordeaux_Florian Marange_2010.csv	Florian Marange	Bordeaux	league	2010	2022-01-29 23:46:05.994336+00
232	Bordeaux_Florian Marange_2011.csv	Florian Marange	Bordeaux	league	2011	2022-01-29 23:46:05.994964+00
233	Bordeaux_Florian Marange_2012.csv	Florian Marange	Bordeaux	league	2012	2022-01-29 23:46:05.995745+00
234	Bordeaux_Floyd Ayité_2010.csv	Floyd Ayité	Bordeaux	league	2010	2022-01-29 23:46:05.996462+00
235	Bordeaux_Franck Jurietti_2009.csv	Franck Jurietti	Bordeaux	league	2009	2022-01-29 23:46:05.997113+00
236	Bordeaux_Grégory Sertic_2009.csv	Grégory Sertic	Bordeaux	league	2009	2022-01-29 23:46:05.997766+00
237	Bordeaux_Grégory Sertic_2011.csv	Grégory Sertic	Bordeaux	league	2011	2022-01-29 23:46:05.998529+00
238	Bordeaux_Grégory Sertic_2012.csv	Grégory Sertic	Bordeaux	league	2012	2022-01-29 23:46:05.99918+00
239	Bordeaux_Grzegorz Krychowiak_2011.csv	Grzegorz Krychowiak	Bordeaux	league	2011	2022-01-29 23:46:05.999847+00
240	Bordeaux_Hadi Sacko_2012.csv	Hadi Sacko	Bordeaux	league	2012	2022-01-29 23:46:06.000502+00
241	Bordeaux_Henri Saivet_2009.csv	Henri Saivet	Bordeaux	league	2009	2022-01-29 23:46:06.001337+00
242	Bordeaux_Henri Saivet_2010.csv	Henri Saivet	Bordeaux	league	2010	2022-01-29 23:46:06.002451+00
243	Bordeaux_Henri Saivet_2011.csv	Henri Saivet	Bordeaux	league	2011	2022-01-29 23:46:06.003314+00
244	Bordeaux_Henri Saivet_2012.csv	Henri Saivet	Bordeaux	league	2012	2022-01-29 23:46:06.004146+00
245	Bordeaux_Henrique_2009.csv	Henrique	Bordeaux	league	2009	2022-01-29 23:46:06.005317+00
246	Bordeaux_Henrique_2010.csv	Henrique	Bordeaux	league	2010	2022-01-29 23:46:06.00654+00
247	Bordeaux_Henrique_2011.csv	Henrique	Bordeaux	league	2011	2022-01-29 23:46:06.007384+00
248	Bordeaux_Henrique_2012.csv	Henrique	Bordeaux	league	2012	2022-01-29 23:46:06.00807+00
249	Bordeaux_Jaroslav Plašil_2009.csv	Jaroslav Plašil	Bordeaux	league	2009	2022-01-29 23:46:06.008727+00
250	Bordeaux_Jaroslav Plašil_2010.csv	Jaroslav Plašil	Bordeaux	league	2010	2022-01-29 23:46:06.009462+00
251	Bordeaux_Jaroslav Plašil_2011.csv	Jaroslav Plašil	Bordeaux	league	2011	2022-01-29 23:46:06.010141+00
252	Bordeaux_Jaroslav Plašil_2012.csv	Jaroslav Plašil	Bordeaux	league	2012	2022-01-29 23:46:06.010821+00
253	Bordeaux_Julien Faubert_2012.csv	Julien Faubert	Bordeaux	league	2012	2022-01-29 23:46:06.011564+00
254	Bordeaux_Jussiê_2009.csv	Jussiê	Bordeaux	league	2009	2022-01-29 23:46:06.012234+00
255	Bordeaux_Jussiê_2010.csv	Jussiê	Bordeaux	league	2010	2022-01-29 23:46:06.012876+00
256	Bordeaux_Jussiê_2011.csv	Jussiê	Bordeaux	league	2011	2022-01-29 23:46:06.013894+00
257	Bordeaux_Jussiê_2012.csv	Jussiê	Bordeaux	league	2012	2022-01-29 23:46:06.014738+00
258	Bordeaux_Kévin Olimpa_2010.csv	Kévin Olimpa	Bordeaux	league	2010	2022-01-29 23:46:06.01575+00
259	Bordeaux_Kévin Olimpa_2011.csv	Kévin Olimpa	Bordeaux	league	2011	2022-01-29 23:46:06.016636+00
260	Bordeaux_Lamine Sané_2009.csv	Lamine Sané	Bordeaux	league	2009	2022-01-29 23:46:06.017436+00
261	Bordeaux_Lamine Sané_2010.csv	Lamine Sané	Bordeaux	league	2010	2022-01-29 23:46:06.018083+00
262	Bordeaux_Lamine Sané_2011.csv	Lamine Sané	Bordeaux	league	2011	2022-01-29 23:46:06.018772+00
263	Bordeaux_Lamine Sané_2012.csv	Lamine Sané	Bordeaux	league	2012	2022-01-29 23:46:06.019438+00
264	Bordeaux_Landry N'Guémo_2011.csv	Landry N'Guémo	Bordeaux	league	2011	2022-01-29 23:46:06.020104+00
265	Bordeaux_Landry N'Guémo_2012.csv	Landry N'Guémo	Bordeaux	league	2012	2022-01-29 23:46:06.020783+00
266	Bordeaux_Ludovic Obraniak_2011.csv	Ludovic Obraniak	Bordeaux	league	2011	2022-01-29 23:46:06.022018+00
267	Bordeaux_Ludovic Obraniak_2012.csv	Ludovic Obraniak	Bordeaux	league	2012	2022-01-29 23:46:06.022754+00
268	Bordeaux_Marc Planus_2009.csv	Marc Planus	Bordeaux	league	2009	2022-01-29 23:46:06.023544+00
269	Bordeaux_Marc Planus_2010.csv	Marc Planus	Bordeaux	league	2010	2022-01-29 23:46:06.024214+00
270	Bordeaux_Marc Planus_2011.csv	Marc Planus	Bordeaux	league	2011	2022-01-29 23:46:06.024931+00
271	Bordeaux_Marc Planus_2012.csv	Marc Planus	Bordeaux	league	2012	2022-01-29 23:46:06.025576+00
272	Bordeaux_Mariano_2011.csv	Mariano	Bordeaux	league	2011	2022-01-29 23:46:06.026225+00
273	Bordeaux_Mariano_2012.csv	Mariano	Bordeaux	league	2012	2022-01-29 23:46:06.026954+00
274	Bordeaux_Marouane Chamakh_2009.csv	Marouane Chamakh	Bordeaux	league	2009	2022-01-29 23:46:06.027619+00
275	Bordeaux_Matthieu Chalmé_2009.csv	Matthieu Chalmé	Bordeaux	league	2009	2022-01-29 23:46:06.028244+00
276	Bordeaux_Matthieu Chalmé_2010.csv	Matthieu Chalmé	Bordeaux	league	2010	2022-01-29 23:46:06.02889+00
277	Bordeaux_Matthieu Chalmé_2011.csv	Matthieu Chalmé	Bordeaux	league	2011	2022-01-29 23:46:06.029698+00
278	Bordeaux_Matthieu Chalmé_2012.csv	Matthieu Chalmé	Bordeaux	league	2012	2022-01-29 23:46:06.030463+00
279	Bordeaux_Maxime Poundjé_2012.csv	Maxime Poundjé	Bordeaux	league	2012	2022-01-29 23:46:06.031151+00
280	Bordeaux_Michaël Ciani_2009.csv	Michaël Ciani	Bordeaux	league	2009	2022-01-29 23:46:06.031809+00
281	Bordeaux_Michaël Ciani_2010.csv	Michaël Ciani	Bordeaux	league	2010	2022-01-29 23:46:06.032548+00
282	Bordeaux_Michaël Ciani_2011.csv	Michaël Ciani	Bordeaux	league	2011	2022-01-29 23:46:06.033287+00
283	Bordeaux_Michaël Ciani_2012.csv	Michaël Ciani	Bordeaux	league	2012	2022-01-29 23:46:06.034088+00
284	Bordeaux_Moussa Maâzou_2010.csv	Moussa Maâzou	Bordeaux	league	2010	2022-01-29 23:46:06.034993+00
285	Bordeaux_Nicolas Maurice-Belay_2011.csv	Nicolas Maurice-Belay	Bordeaux	league	2011	2022-01-29 23:46:06.03598+00
286	Bordeaux_Nicolas Maurice-Belay_2012.csv	Nicolas Maurice-Belay	Bordeaux	league	2012	2022-01-29 23:46:06.036842+00
287	Bordeaux_Pierre Ducasse_2010.csv	Pierre Ducasse	Bordeaux	league	2010	2022-01-29 23:46:06.037752+00
288	Bordeaux_Rémi Elissalde_2010.csv	Rémi Elissalde	Bordeaux	league	2010	2022-01-29 23:46:06.038949+00
289	Bordeaux_Salif Sané_2010.csv	Salif Sané	Bordeaux	league	2010	2022-01-29 23:46:06.039997+00
290	Bordeaux_Ulrich Ramé_2009.csv	Ulrich Ramé	Bordeaux	league	2009	2022-01-29 23:46:06.04069+00
291	Bordeaux_Ulrich Ramé_2010.csv	Ulrich Ramé	Bordeaux	league	2010	2022-01-29 23:46:06.04139+00
292	Bordeaux_Vujadin Savić_2010.csv	Vujadin Savić	Bordeaux	league	2010	2022-01-29 23:46:06.042066+00
293	Bordeaux_Vujadin Savić_2011.csv	Vujadin Savić	Bordeaux	league	2011	2022-01-29 23:46:06.042822+00
294	Bordeaux_Wendel Geraldo_2009.csv	Wendel Geraldo	Bordeaux	league	2009	2022-01-29 23:46:06.043513+00
295	Bordeaux_Wendel Geraldo_2010.csv	Wendel Geraldo	Bordeaux	league	2010	2022-01-29 23:46:06.044174+00
296	Bordeaux_Yoan Gouffran_2009.csv	Yoan Gouffran	Bordeaux	league	2009	2022-01-29 23:46:06.044847+00
297	Bordeaux_Yoan Gouffran_2010.csv	Yoan Gouffran	Bordeaux	league	2010	2022-01-29 23:46:06.045543+00
298	Bordeaux_Yoan Gouffran_2011.csv	Yoan Gouffran	Bordeaux	league	2011	2022-01-29 23:46:06.046266+00
299	Bordeaux_Yoan Gouffran_2012.csv	Yoan Gouffran	Bordeaux	league	2012	2022-01-29 23:46:06.047141+00
300	Bordeaux_Yoann Gourcuff_2009.csv	Yoann Gourcuff	Bordeaux	league	2009	2022-01-29 23:46:06.048403+00
301	Bordeaux_Yoann Gourcuff_2010.csv	Yoann Gourcuff	Bordeaux	league	2010	2022-01-29 23:46:06.049326+00
302	Boulogne_Alexandre Cuvillier_2009.csv	Alexandre Cuvillier	Boulogne	league	2009	2022-01-29 23:46:06.050079+00
303	Boulogne_Antony Lecointe_2009.csv	Antony Lecointe	Boulogne	league	2009	2022-01-29 23:46:06.050921+00
304	Boulogne_Bakary Soumaré_2009.csv	Bakary Soumaré	Boulogne	league	2009	2022-01-29 23:46:06.051818+00
305	Boulogne_Bira Dembélé_2009.csv	Bira Dembélé	Boulogne	league	2009	2022-01-29 23:46:06.052542+00
306	Boulogne_Damien Marcq_2009.csv	Damien Marcq	Boulogne	league	2009	2022-01-29 23:46:06.05318+00
307	Boulogne_Damien Perrinelle_2009.csv	Damien Perrinelle	Boulogne	league	2009	2022-01-29 23:46:06.053814+00
308	Boulogne_Daniel Moreira_2009.csv	Daniel Moreira	Boulogne	league	2009	2022-01-29 23:46:06.054513+00
309	Boulogne_Dorian Lévêque_2009.csv	Dorian Lévêque	Boulogne	league	2009	2022-01-29 23:46:06.055496+00
310	Boulogne_Fabien Robert_2009.csv	Fabien Robert	Boulogne	league	2009	2022-01-29 23:46:06.056196+00
311	Boulogne_Florian Bague_2009.csv	Florian Bague	Boulogne	league	2009	2022-01-29 23:46:06.056917+00
312	Boulogne_Frédéric Da Rocha_2009.csv	Frédéric Da Rocha	Boulogne	league	2009	2022-01-29 23:46:06.057553+00
313	Boulogne_Grégory Thil_2009.csv	Grégory Thil	Boulogne	league	2009	2022-01-29 23:46:06.058258+00
314	Boulogne_Guillaume Borne_2009.csv	Guillaume Borne	Boulogne	league	2009	2022-01-29 23:46:06.058945+00
315	Boulogne_Guillaume Ducatel_2009.csv	Guillaume Ducatel	Boulogne	league	2009	2022-01-29 23:46:06.059666+00
316	Boulogne_Habib Bellaïd_2009.csv	Habib Bellaïd	Boulogne	league	2009	2022-01-29 23:46:06.060318+00
317	Boulogne_Ibrahim Koné_2009.csv	Ibrahim Koné	Boulogne	league	2009	2022-01-29 23:46:06.060965+00
318	Boulogne_Jean-François Bédénik_2009.csv	Jean-François Bédénik	Boulogne	league	2009	2022-01-29 23:46:06.061616+00
319	Boulogne_Jérémy Blayac_2009.csv	Jérémy Blayac	Boulogne	league	2009	2022-01-29 23:46:06.062367+00
320	Boulogne_Johann Ramaré_2009.csv	Johann Ramaré	Boulogne	league	2009	2022-01-29 23:46:06.063105+00
321	Boulogne_Juan Gonzalo Lorca_2009.csv	Juan Gonzalo Lorca	Boulogne	league	2009	2022-01-29 23:46:06.063782+00
322	Boulogne_Kévin das Neves_2009.csv	Kévin das Neves	Boulogne	league	2009	2022-01-29 23:46:06.064419+00
323	Boulogne_Lakdar Boussaha_2009.csv	Lakdar Boussaha	Boulogne	league	2009	2022-01-29 23:46:06.065054+00
324	Boulogne_Laurent Agouazi_2009.csv	Laurent Agouazi	Boulogne	league	2009	2022-01-29 23:46:06.065804+00
325	Boulogne_Mame N'Diaye_2009.csv	Mame N'Diaye	Boulogne	league	2009	2022-01-29 23:46:06.066494+00
326	Boulogne_Mathieu Valverde_2009.csv	Mathieu Valverde	Boulogne	league	2009	2022-01-29 23:46:06.067354+00
327	Boulogne_Matt Moussilou_2009.csv	Matt Moussilou	Boulogne	league	2009	2022-01-29 23:46:06.06806+00
328	Boulogne_Mustapha Yatabaré_2009.csv	Mustapha Yatabaré	Boulogne	league	2009	2022-01-29 23:46:06.068733+00
329	Boulogne_Nicolas Rabuel_2009.csv	Nicolas Rabuel	Boulogne	league	2009	2022-01-29 23:46:06.069389+00
330	Boulogne_Olivier Kapo_2009.csv	Olivier Kapo	Boulogne	league	2009	2022-01-29 23:46:06.070022+00
331	Boulogne_Olubayo Adefemi_2009.csv	Olubayo Adefemi	Boulogne	league	2009	2022-01-29 23:46:06.070641+00
332	Boulogne_Ovidy Karuru_2009.csv	Ovidy Karuru	Boulogne	league	2009	2022-01-29 23:46:06.071955+00
333	Boulogne_Yohan Lachor_2009.csv	Yohan Lachor	Boulogne	league	2009	2022-01-29 23:46:06.072924+00
334	Boulogne_Zargo Touré_2009.csv	Zargo Touré	Boulogne	league	2009	2022-01-29 23:46:06.07361+00
335	Brest_Abdoul Sissoko_2011.csv	Abdoul Sissoko	Brest	league	2011	2022-01-29 23:46:06.074247+00
336	Brest_Abel Khaled_2011.csv	Abel Khaled	Brest	league	2011	2022-01-29 23:46:06.074967+00
337	Brest_Adama Ba_2011.csv	Adama Ba	Brest	league	2011	2022-01-29 23:46:06.075782+00
338	Brest_Ahmed Kantari_2010.csv	Ahmed Kantari	Brest	league	2010	2022-01-29 23:46:06.076783+00
339	Brest_Ahmed Kantari_2011.csv	Ahmed Kantari	Brest	league	2011	2022-01-29 23:46:06.077664+00
340	Brest_Alexandre Alphonse_2011.csv	Alexandre Alphonse	Brest	league	2011	2022-01-29 23:46:06.078491+00
341	Brest_Anthony Bova_2010.csv	Anthony Bova	Brest	league	2010	2022-01-29 23:46:06.079182+00
342	Brest_Benoît Lesoimier_2010.csv	Benoît Lesoimier	Brest	league	2010	2022-01-29 23:46:06.079883+00
343	Brest_Benoît Lesoimier_2011.csv	Benoît Lesoimier	Brest	league	2011	2022-01-29 23:46:06.080777+00
344	Brest_Brahim Ferradj_2010.csv	Brahim Ferradj	Brest	league	2010	2022-01-29 23:46:06.081653+00
345	Brest_Brahim Ferradj_2011.csv	Brahim Ferradj	Brest	league	2011	2022-01-29 23:46:06.082415+00
346	Brest_Bruno Grougi_2010.csv	Bruno Grougi	Brest	league	2010	2022-01-29 23:46:06.083099+00
347	Brest_Bruno Grougi_2011.csv	Bruno Grougi	Brest	league	2011	2022-01-29 23:46:06.08383+00
348	Brest_Diallo Guidileye_2011.csv	Diallo Guidileye	Brest	league	2011	2022-01-29 23:46:06.084516+00
349	Brest_Eden Ben Basat_2011.csv	Eden Ben Basat	Brest	league	2011	2022-01-29 23:46:06.085168+00
350	Brest_Filippos Darlas_2010.csv	Filippos Darlas	Brest	league	2010	2022-01-29 23:46:06.085765+00
351	Brest_Fodie Traore_2010.csv	Fodie Traore	Brest	league	2010	2022-01-29 23:46:06.086439+00
352	Brest_Granddi Ngoyi_2010.csv	Granddi Ngoyi	Brest	league	2010	2022-01-29 23:46:06.087125+00
353	Brest_Grégory Lorenzi_2010.csv	Grégory Lorenzi	Brest	league	2010	2022-01-29 23:46:06.087832+00
354	Brest_Grégory Lorenzi_2011.csv	Grégory Lorenzi	Brest	league	2011	2022-01-29 23:46:06.08962+00
355	Brest_Issam Jemâa_2011.csv	Issam Jemâa	Brest	league	2011	2022-01-29 23:46:06.090437+00
356	Brest_Jhon Culma_2011.csv	Jhon Culma	Brest	league	2011	2022-01-29 23:46:06.091124+00
357	Brest_Johan Martial_2010.csv	Johan Martial	Brest	league	2010	2022-01-29 23:46:06.091807+00
358	Brest_Johan Martial_2011.csv	Johan Martial	Brest	league	2011	2022-01-29 23:46:06.092475+00
359	Brest_Jonathan Ayité_2010.csv	Jonathan Ayité	Brest	league	2010	2022-01-29 23:46:06.093149+00
360	Brest_Jonathan Ayité_2011.csv	Jonathan Ayité	Brest	league	2011	2022-01-29 23:46:06.093863+00
361	Brest_Jonathan Zebina_2011.csv	Jonathan Zebina	Brest	league	2011	2022-01-29 23:46:06.094557+00
362	Brest_Larsen Touré_2010.csv	Larsen Touré	Brest	league	2010	2022-01-29 23:46:06.095246+00
363	Brest_Larsen Touré_2011.csv	Larsen Touré	Brest	league	2011	2022-01-29 23:46:06.095846+00
364	Brest_Lionel Cappone_2011.csv	Lionel Cappone	Brest	league	2011	2022-01-29 23:46:06.096456+00
365	Brest_Mario Lička_2010.csv	Mario Lička	Brest	league	2010	2022-01-29 23:46:06.097065+00
366	Brest_Mario Lička_2011.csv	Mario Lička	Brest	league	2011	2022-01-29 23:46:06.097647+00
367	Brest_Moïse Brou Apanga_2010.csv	Moïse Brou Apanga	Brest	league	2010	2022-01-29 23:46:06.098302+00
368	Brest_Nolan Roux_2010.csv	Nolan Roux	Brest	league	2010	2022-01-29 23:46:06.098858+00
369	Brest_Nolan Roux_2011.csv	Nolan Roux	Brest	league	2011	2022-01-29 23:46:06.099478+00
370	Brest_Omar Daf_2010.csv	Omar Daf	Brest	league	2010	2022-01-29 23:46:06.100106+00
371	Brest_Omar Daf_2011.csv	Omar Daf	Brest	league	2011	2022-01-29 23:46:06.100713+00
372	Brest_Oscar Ewolo_2010.csv	Oscar Ewolo	Brest	league	2010	2022-01-29 23:46:06.101309+00
373	Brest_Oscar Ewolo_2011.csv	Oscar Ewolo	Brest	league	2011	2022-01-29 23:46:06.101858+00
374	Brest_Ousmane Coulibaly_2010.csv	Ousmane Coulibaly	Brest	league	2010	2022-01-29 23:46:06.102414+00
375	Brest_Ousmane Coulibaly_2011.csv	Ousmane Coulibaly	Brest	league	2011	2022-01-29 23:46:06.102951+00
376	Brest_Paul Baysse_2010.csv	Paul Baysse	Brest	league	2010	2022-01-29 23:46:06.103539+00
377	Brest_Paul Baysse_2011.csv	Paul Baysse	Brest	league	2011	2022-01-29 23:46:06.104026+00
378	Brest_Richard Soumah_2010.csv	Richard Soumah	Brest	league	2010	2022-01-29 23:46:06.105284+00
379	Brest_Richard Soumah_2011.csv	Richard Soumah	Brest	league	2011	2022-01-29 23:46:06.10601+00
380	Brest_Romain Poyet_2010.csv	Romain Poyet	Brest	league	2010	2022-01-29 23:46:06.106555+00
381	Brest_Romain Poyet_2011.csv	Romain Poyet	Brest	league	2011	2022-01-29 23:46:06.10702+00
382	Brest_Santiago Gentiletti_2011.csv	Santiago Gentiletti	Brest	league	2011	2022-01-29 23:46:06.107468+00
383	Brest_Steeve Elana_2010.csv	Steeve Elana	Brest	league	2010	2022-01-29 23:46:06.107915+00
384	Brest_Steeve Elana_2011.csv	Steeve Elana	Brest	league	2011	2022-01-29 23:46:06.108353+00
385	Brest_Théophile N'Tamé_2010.csv	Théophile N'Tamé	Brest	league	2010	2022-01-29 23:46:06.108794+00
386	Brest_Tomáš Mičola_2010.csv	Tomáš Mičola	Brest	league	2010	2022-01-29 23:46:06.109236+00
387	Brest_Tomáš Mičola_2011.csv	Tomáš Mičola	Brest	league	2011	2022-01-29 23:46:06.109752+00
388	Brest_Tripy Makonda_2011.csv	Tripy Makonda	Brest	league	2011	2022-01-29 23:46:06.11023+00
389	Brest_Yoann Bigné_2010.csv	Yoann Bigné	Brest	league	2010	2022-01-29 23:46:06.110687+00
390	Brest_Yoann Bigné_2011.csv	Yoann Bigné	Brest	league	2011	2022-01-29 23:46:06.111133+00
391	Caen_Alexandre Raineau_2010.csv	Alexandre Raineau	Caen	league	2010	2022-01-29 23:46:06.111581+00
392	Caen_Alexandre Raineau_2011.csv	Alexandre Raineau	Caen	league	2011	2022-01-29 23:46:06.112048+00
393	Caen_Alexis Thébaux_2010.csv	Alexis Thébaux	Caen	league	2010	2022-01-29 23:46:06.112487+00
394	Caen_Alexis Thébaux_2011.csv	Alexis Thébaux	Caen	league	2011	2022-01-29 23:46:06.112967+00
395	Caen_Anthony Deroin_2010.csv	Anthony Deroin	Caen	league	2010	2022-01-29 23:46:06.113583+00
396	Caen_Anthony Deroin_2011.csv	Anthony Deroin	Caen	league	2011	2022-01-29 23:46:06.114318+00
397	Caen_Aurélien Montaroup_2011.csv	Aurélien Montaroup	Caen	league	2011	2022-01-29 23:46:06.114914+00
398	Caen_Benjamin Morel_2010.csv	Benjamin Morel	Caen	league	2010	2022-01-29 23:46:06.115489+00
399	Caen_Benjamin Nivet_2010.csv	Benjamin Nivet	Caen	league	2010	2022-01-29 23:46:06.115971+00
400	Caen_Benjamin Nivet_2011.csv	Benjamin Nivet	Caen	league	2011	2022-01-29 23:46:06.116425+00
401	Caen_Branko Lazarević_2010.csv	Branko Lazarević	Caen	league	2010	2022-01-29 23:46:06.116902+00
402	Caen_Damien Marcq_2010.csv	Damien Marcq	Caen	league	2010	2022-01-29 23:46:06.117374+00
403	Caen_Damien Marcq_2011.csv	Damien Marcq	Caen	league	2011	2022-01-29 23:46:06.117823+00
404	Caen_Fayçal Fajr_2011.csv	Fayçal Fajr	Caen	league	2011	2022-01-29 23:46:06.118278+00
405	Caen_Frédéric Bulot_2011.csv	Frédéric Bulot	Caen	league	2011	2022-01-29 23:46:06.118789+00
406	Caen_Grégory Leca_2010.csv	Grégory Leca	Caen	league	2010	2022-01-29 23:46:06.119262+00
407	Caen_Grégory Leca_2011.csv	Grégory Leca	Caen	league	2011	2022-01-29 23:46:06.119715+00
408	Caen_Grégory Proment_2010.csv	Grégory Proment	Caen	league	2010	2022-01-29 23:46:06.12022+00
409	Caen_Grégory Proment_2011.csv	Grégory Proment	Caen	league	2011	2022-01-29 23:46:06.121569+00
410	Caen_Grégory Tafforeau_2010.csv	Grégory Tafforeau	Caen	league	2010	2022-01-29 23:46:06.122211+00
411	Caen_Ibrahima Tandia_2011.csv	Ibrahima Tandia	Caen	league	2011	2022-01-29 23:46:06.122721+00
412	Caen_Ismaïla N'Diaye_2010.csv	Ismaïla N'Diaye	Caen	league	2010	2022-01-29 23:46:06.123185+00
413	Caen_Jerry Vandam_2011.csv	Jerry Vandam	Caen	league	2011	2022-01-29 23:46:06.123726+00
414	Caen_Jérémy Sorbon_2010.csv	Jérémy Sorbon	Caen	league	2010	2022-01-29 23:46:06.124175+00
415	Caen_Jérémy Sorbon_2011.csv	Jérémy Sorbon	Caen	league	2011	2022-01-29 23:46:06.12462+00
416	Caen_Kandia Traoré_2010.csv	Kandia Traoré	Caen	league	2010	2022-01-29 23:46:06.125058+00
417	Caen_Kandia Traoré_2011.csv	Kandia Traoré	Caen	league	2011	2022-01-29 23:46:06.125497+00
418	Caen_Lenny Nangis_2011.csv	Lenny Nangis	Caen	league	2011	2022-01-29 23:46:06.125936+00
419	Caen_Livio Nabab_2010.csv	Livio Nabab	Caen	league	2010	2022-01-29 23:46:06.126374+00
420	Caen_Livio Nabab_2011.csv	Livio Nabab	Caen	league	2011	2022-01-29 23:46:06.126809+00
421	Caen_M'Baye Niang_2010.csv	M'Baye Niang	Caen	league	2010	2022-01-29 23:46:06.127273+00
422	Caen_M'Baye Niang_2011.csv	M'Baye Niang	Caen	league	2011	2022-01-29 23:46:06.127708+00
423	Caen_Molla Wagué_2011.csv	Molla Wagué	Caen	league	2011	2022-01-29 23:46:06.128163+00
424	Caen_Nicolas Seube_2010.csv	Nicolas Seube	Caen	league	2010	2022-01-29 23:46:06.128676+00
425	Caen_Nicolas Seube_2011.csv	Nicolas Seube	Caen	league	2011	2022-01-29 23:46:06.129209+00
426	Caen_Pablo Barzola_2010.csv	Pablo Barzola	Caen	league	2010	2022-01-29 23:46:06.129699+00
427	Caen_Pierre-Alain Frau_2011.csv	Pierre-Alain Frau	Caen	league	2011	2022-01-29 23:46:06.130161+00
428	Caen_Rajiv van La Parra_2010.csv	Rajiv van La Parra	Caen	league	2010	2022-01-29 23:46:06.130659+00
429	Caen_Romain Hamouma_2010.csv	Romain Hamouma	Caen	league	2010	2022-01-29 23:46:06.131217+00
430	Caen_Romain Hamouma_2011.csv	Romain Hamouma	Caen	league	2011	2022-01-29 23:46:06.1317+00
431	Caen_Romain Inez_2010.csv	Romain Inez	Caen	league	2010	2022-01-29 23:46:06.132165+00
432	Caen_Sambou Yatabaré_2010.csv	Sambou Yatabaré	Caen	league	2010	2022-01-29 23:46:06.132613+00
433	Caen_Thibault Moulin_2010.csv	Thibault Moulin	Caen	league	2010	2022-01-29 23:46:06.133055+00
434	Caen_Thomas Bosmel_2010.csv	Thomas Bosmel	Caen	league	2010	2022-01-29 23:46:06.133494+00
435	Caen_Thomas Heurtaux_2010.csv	Thomas Heurtaux	Caen	league	2010	2022-01-29 23:46:06.13393+00
436	Caen_Thomas Heurtaux_2011.csv	Thomas Heurtaux	Caen	league	2011	2022-01-29 23:46:06.134366+00
437	Caen_Yannick M'Boné_2011.csv	Yannick M'Boné	Caen	league	2011	2022-01-29 23:46:06.134809+00
438	Caen_Yohan Mollo_2010.csv	Yohan Mollo	Caen	league	2010	2022-01-29 23:46:06.135277+00
439	Caen_Youssef El-Arabi_2010.csv	Youssef El-Arabi	Caen	league	2010	2022-01-29 23:46:06.135711+00
440	Dijon_Abdoulaye Bamba_2011.csv	Abdoulaye Bamba	Dijon	league	2011	2022-01-29 23:46:06.136159+00
441	Dijon_Abdoulaye Méïté_2011.csv	Abdoulaye Méïté	Dijon	league	2011	2022-01-29 23:46:06.136661+00
442	Dijon_Baptiste Reynet_2011.csv	Baptiste Reynet	Dijon	league	2011	2022-01-29 23:46:06.137155+00
443	Dijon_Benjamin Corgnet_2011.csv	Benjamin Corgnet	Dijon	league	2011	2022-01-29 23:46:06.137745+00
444	Dijon_Bennard Kumordzi_2011.csv	Bennard Kumordzi	Dijon	league	2011	2022-01-29 23:46:06.138447+00
445	Dijon_Brice Jovial_2011.csv	Brice Jovial	Dijon	league	2011	2022-01-29 23:46:06.139056+00
446	Dijon_Cédric Varrault_2011.csv	Cédric Varrault	Dijon	league	2011	2022-01-29 23:46:06.139528+00
447	Dijon_Chaher Zarour_2011.csv	Chaher Zarour	Dijon	league	2011	2022-01-29 23:46:06.139997+00
448	Dijon_Christophe Mandanne_2011.csv	Christophe Mandanne	Dijon	league	2011	2022-01-29 23:46:06.140503+00
449	Dijon_Daisuke Matsui_2011.csv	Daisuke Matsui	Dijon	league	2011	2022-01-29 23:46:06.140972+00
450	Dijon_Damien Marcq_2011.csv	Damien Marcq	Dijon	league	2011	2022-01-29 23:46:06.141466+00
451	Dijon_Éric Bauthéac_2011.csv	Éric Bauthéac	Dijon	league	2011	2022-01-29 23:46:06.141958+00
452	Dijon_Florin Berenguer_2011.csv	Florin Berenguer	Dijon	league	2011	2022-01-29 23:46:06.142428+00
453	Dijon_Gaël Kakuta_2011.csv	Gaël Kakuta	Dijon	league	2011	2022-01-29 23:46:06.142927+00
454	Dijon_Grégory Thil_2011.csv	Grégory Thil	Dijon	league	2011	2022-01-29 23:46:06.143398+00
455	Dijon_Hakeem Achour_2011.csv	Hakeem Achour	Dijon	league	2011	2022-01-29 23:46:06.14385+00
456	Dijon_Jean-Daniel Padovani_2011.csv	Jean-Daniel Padovani	Dijon	league	2011	2022-01-29 23:46:06.144309+00
457	Dijon_Koro Koné_2011.csv	Koro Koné	Dijon	league	2011	2022-01-29 23:46:06.144752+00
458	Dijon_Lesly Malouda_2011.csv	Lesly Malouda	Dijon	league	2011	2022-01-29 23:46:06.145192+00
459	Dijon_Mehdi Courgnaud_2011.csv	Mehdi Courgnaud	Dijon	league	2011	2022-01-29 23:46:06.14564+00
460	Dijon_Raphaël Cacérès_2011.csv	Raphaël Cacérès	Dijon	league	2011	2022-01-29 23:46:06.146142+00
461	Dijon_Samuel Souprayen_2011.csv	Samuel Souprayen	Dijon	league	2011	2022-01-29 23:46:06.146619+00
462	Dijon_Sanaa Altama_2011.csv	Sanaa Altama	Dijon	league	2011	2022-01-29 23:46:06.147072+00
463	Dijon_Sekou Baradji_2011.csv	Sekou Baradji	Dijon	league	2011	2022-01-29 23:46:06.147514+00
464	Dijon_Steven Paulle_2011.csv	Steven Paulle	Dijon	league	2011	2022-01-29 23:46:06.147952+00
465	Dijon_Thomas Guerbert_2011.csv	Thomas Guerbert	Dijon	league	2011	2022-01-29 23:46:06.148397+00
466	Dijon_Younousse Sankharé_2011.csv	Younousse Sankharé	Dijon	league	2011	2022-01-29 23:46:06.148874+00
467	Dijon_Zakaria Diallo_2011.csv	Zakaria Diallo	Dijon	league	2011	2022-01-29 23:46:06.149374+00
468	Dijon_Zié Diabaté_2011.csv	Zié Diabaté	Dijon	league	2011	2022-01-29 23:46:06.149844+00
469	Evian_Adrien Thomasson_2011.csv	Adrien Thomasson	Evian	league	2011	2022-01-29 23:46:06.150298+00
470	Evian_Aldo Angoula_2011.csv	Aldo Angoula	Evian	league	2011	2022-01-29 23:46:06.150742+00
471	Evian_Aldo Angoula_2012.csv	Aldo Angoula	Evian	league	2012	2022-01-29 23:46:06.151181+00
472	Evian_Ali M'Madi_2011.csv	Ali M'Madi	Evian	league	2011	2022-01-29 23:46:06.151637+00
473	Evian_Ali M'Madi_2012.csv	Ali M'Madi	Evian	league	2012	2022-01-29 23:46:06.152115+00
474	Evian_Bertrand Laquait_2011.csv	Bertrand Laquait	Evian	league	2011	2022-01-29 23:46:06.152601+00
475	Evian_Bertrand Laquait_2012.csv	Bertrand Laquait	Evian	league	2012	2022-01-29 23:46:06.153105+00
476	Evian_Betão_2012.csv	Betão	Evian	league	2012	2022-01-29 23:46:06.153601+00
477	Evian_Brice Dja Djédjé_2011.csv	Brice Dja Djédjé	Evian	league	2011	2022-01-29 23:46:06.154139+00
478	Evian_Brice Dja Djédjé_2012.csv	Brice Dja Djédjé	Evian	league	2012	2022-01-29 23:46:06.155504+00
479	Evian_Cédric Barbosa_2011.csv	Cédric Barbosa	Evian	league	2011	2022-01-29 23:46:06.156165+00
480	Evian_Cédric Barbosa_2012.csv	Cédric Barbosa	Evian	league	2012	2022-01-29 23:46:06.156683+00
481	Evian_Cédric Cambon_2011.csv	Cédric Cambon	Evian	league	2011	2022-01-29 23:46:06.157153+00
482	Evian_Cédric Cambon_2012.csv	Cédric Cambon	Evian	league	2012	2022-01-29 23:46:06.157605+00
483	Evian_Cédric Mongongu_2011.csv	Cédric Mongongu	Evian	league	2011	2022-01-29 23:46:06.158063+00
484	Evian_Cédric Mongongu_2012.csv	Cédric Mongongu	Evian	league	2012	2022-01-29 23:46:06.158565+00
485	Evian_Christian Poulsen_2011.csv	Christian Poulsen	Evian	league	2011	2022-01-29 23:46:06.15904+00
486	Evian_Clarck N'Sikulu_2012.csv	Clarck N'Sikulu	Evian	league	2012	2022-01-29 23:46:06.159491+00
487	Evian_Daniel Wass_2011.csv	Daniel Wass	Evian	league	2011	2022-01-29 23:46:06.159967+00
488	Evian_Daniel Wass_2012.csv	Daniel Wass	Evian	league	2012	2022-01-29 23:46:06.160435+00
489	Evian_David Jarolím_2012.csv	David Jarolím	Evian	league	2012	2022-01-29 23:46:06.160875+00
490	Evian_Diogo Campos Gomes_2012.csv	Diogo Campos Gomes	Evian	league	2012	2022-01-29 23:46:06.161316+00
491	Evian_Djakaridja Koné_2012.csv	Djakaridja Koné	Evian	league	2012	2022-01-29 23:46:06.161752+00
492	Evian_Éric Tié Bi_2011.csv	Éric Tié Bi	Evian	league	2011	2022-01-29 23:46:06.162194+00
493	Evian_Éric Tié Bi_2012.csv	Éric Tié Bi	Evian	league	2012	2022-01-29 23:46:06.162639+00
494	Evian_Fabrice Ehret_2011.csv	Fabrice Ehret	Evian	league	2011	2022-01-29 23:46:06.163335+00
495	Evian_Fabrice Ehret_2012.csv	Fabrice Ehret	Evian	league	2012	2022-01-29 23:46:06.164034+00
496	Evian_Felipe Saad_2011.csv	Felipe Saad	Evian	league	2011	2022-01-29 23:46:06.164713+00
497	Evian_Guillaume Lacour_2011.csv	Guillaume Lacour	Evian	league	2011	2022-01-29 23:46:06.165249+00
498	Evian_Guillaume Lacour_2012.csv	Guillaume Lacour	Evian	league	2012	2022-01-29 23:46:06.165716+00
499	Evian_Guillaume Rippert_2011.csv	Guillaume Rippert	Evian	league	2011	2022-01-29 23:46:06.166165+00
500	Evian_Iheb Mbarki_2012.csv	Iheb Mbarki	Evian	league	2012	2022-01-29 23:46:06.16661+00
501	Evian_Jérôme Leroy_2011.csv	Jérôme Leroy	Evian	league	2011	2022-01-29 23:46:06.167081+00
502	Evian_Johann Durand_2012.csv	Johann Durand	Evian	league	2012	2022-01-29 23:46:06.167658+00
503	Evian_Jonathan Mensah_2011.csv	Jonathan Mensah	Evian	league	2011	2022-01-29 23:46:06.168322+00
504	Evian_Jonathan Mensah_2012.csv	Jonathan Mensah	Evian	league	2012	2022-01-29 23:46:06.168818+00
505	Evian_Kévin Bérigaud_2011.csv	Kévin Bérigaud	Evian	league	2011	2022-01-29 23:46:06.169281+00
506	Evian_Kévin Bérigaud_2012.csv	Kévin Bérigaud	Evian	league	2012	2022-01-29 23:46:06.169732+00
507	Evian_Miloš Ninković_2012.csv	Miloš Ninković	Evian	league	2012	2022-01-29 23:46:06.170191+00
508	Evian_Mohammed Rabiu_2011.csv	Mohammed Rabiu	Evian	league	2011	2022-01-29 23:46:06.1707+00
509	Evian_Mohammed Rabiu_2012.csv	Mohammed Rabiu	Evian	league	2012	2022-01-29 23:46:06.171284+00
510	Evian_Nadjib Baouia_2012.csv	Nadjib Baouia	Evian	league	2012	2022-01-29 23:46:06.172009+00
511	Evian_Nicolas Farina_2011.csv	Nicolas Farina	Evian	league	2011	2022-01-29 23:46:06.172559+00
512	Evian_Olivier Sorlin_2011.csv	Olivier Sorlin	Evian	league	2011	2022-01-29 23:46:06.173075+00
513	Evian_Olivier Sorlin_2012.csv	Olivier Sorlin	Evian	league	2012	2022-01-29 23:46:06.173638+00
514	Evian_Quentin Westberg_2011.csv	Quentin Westberg	Evian	league	2011	2022-01-29 23:46:06.174162+00
515	Evian_Saber Khalifa_2011.csv	Saber Khalifa	Evian	league	2011	2022-01-29 23:46:06.174669+00
516	Evian_Saber Khalifa_2012.csv	Saber Khalifa	Evian	league	2012	2022-01-29 23:46:06.175159+00
517	Evian_Sidney Govou_2011.csv	Sidney Govou	Evian	league	2011	2022-01-29 23:46:06.175695+00
518	Evian_Sidney Govou_2012.csv	Sidney Govou	Evian	league	2012	2022-01-29 23:46:06.176305+00
519	Evian_Stephan Andersen_2011.csv	Stephan Andersen	Evian	league	2011	2022-01-29 23:46:06.176791+00
594	Lens_Adil Hermach_2010.csv	Adil Hermach	Lens	league	2010	2022-01-29 23:46:06.233709+00
520	Evian_Stephan Andersen_2012.csv	Stephan Andersen	Evian	league	2012	2022-01-29 23:46:06.177259+00
521	Evian_Thomas Kahlenberg_2011.csv	Thomas Kahlenberg	Evian	league	2011	2022-01-29 23:46:06.17784+00
522	Evian_Yannick Sagbo_2011.csv	Yannick Sagbo	Evian	league	2011	2022-01-29 23:46:06.17832+00
523	Evian_Yannick Sagbo_2012.csv	Yannick Sagbo	Evian	league	2012	2022-01-29 23:46:06.178776+00
524	Evian_Youssef Adnane_2011.csv	Youssef Adnane	Evian	league	2011	2022-01-29 23:46:06.179363+00
525	Evian_Youssef Adnane_2012.csv	Youssef Adnane	Evian	league	2012	2022-01-29 23:46:06.179829+00
526	Evian_Zouheir Dhaouadi_2012.csv	Zouheir Dhaouadi	Evian	league	2012	2022-01-29 23:46:06.18032+00
527	Grenoble_Alaixys Romao_2009.csv	Alaixys Romao	Grenoble	league	2009	2022-01-29 23:46:06.180788+00
528	Grenoble_Boštjan Cesar_2009.csv	Boštjan Cesar	Grenoble	league	2009	2022-01-29 23:46:06.181298+00
529	Grenoble_Brice Maubleu_2009.csv	Brice Maubleu	Grenoble	league	2009	2022-01-29 23:46:06.181893+00
530	Grenoble_Daisuke Matsui_2009.csv	Daisuke Matsui	Grenoble	league	2009	2022-01-29 23:46:06.18252+00
531	Grenoble_Danijel Ljuboja_2009.csv	Danijel Ljuboja	Grenoble	league	2009	2022-01-29 23:46:06.183036+00
532	Grenoble_David Jemmali_2009.csv	David Jemmali	Grenoble	league	2009	2022-01-29 23:46:06.183537+00
533	Grenoble_David Sauget_2009.csv	David Sauget	Grenoble	league	2009	2022-01-29 23:46:06.184084+00
534	Grenoble_François Marque_2009.csv	François Marque	Grenoble	league	2009	2022-01-29 23:46:06.18474+00
535	Grenoble_Hugo Cianci_2009.csv	Hugo Cianci	Grenoble	league	2009	2022-01-29 23:46:06.18529+00
536	Grenoble_Jean Calvé_2009.csv	Jean Calvé	Grenoble	league	2009	2022-01-29 23:46:06.185779+00
537	Grenoble_Jimmy Juan_2009.csv	Jimmy Juan	Grenoble	league	2009	2022-01-29 23:46:06.186253+00
538	Grenoble_Jimmy Mainfroi_2009.csv	Jimmy Mainfroi	Grenoble	league	2009	2022-01-29 23:46:06.186766+00
539	Grenoble_Jody Viviani_2009.csv	Jody Viviani	Grenoble	league	2009	2022-01-29 23:46:06.187249+00
540	Grenoble_Jonathan Tinhan_2009.csv	Jonathan Tinhan	Grenoble	league	2009	2022-01-29 23:46:06.187839+00
541	Grenoble_Josip Tadić_2009.csv	Josip Tadić	Grenoble	league	2009	2022-01-29 23:46:06.189284+00
542	Grenoble_Laurent Batlles_2009.csv	Laurent Batlles	Grenoble	league	2009	2022-01-29 23:46:06.190931+00
543	Grenoble_Laurent Courtois_2009.csv	Laurent Courtois	Grenoble	league	2009	2022-01-29 23:46:06.191991+00
544	Grenoble_Laurent Macquet_2009.csv	Laurent Macquet	Grenoble	league	2009	2022-01-29 23:46:06.192758+00
545	Grenoble_Martial Robin_2009.csv	Martial Robin	Grenoble	league	2009	2022-01-29 23:46:06.19345+00
546	Grenoble_Mehdi Bourabia_2009.csv	Mehdi Bourabia	Grenoble	league	2009	2022-01-29 23:46:06.194307+00
547	Grenoble_Milivoje Vitakić_2009.csv	Milivoje Vitakić	Grenoble	league	2009	2022-01-29 23:46:06.195671+00
548	Grenoble_Mustafa Kučuković_2009.csv	Mustafa Kučuković	Grenoble	league	2009	2022-01-29 23:46:06.196711+00
549	Grenoble_Nassim Akrour_2009.csv	Nassim Akrour	Grenoble	league	2009	2022-01-29 23:46:06.197535+00
550	Grenoble_Nicolas Dieuze_2009.csv	Nicolas Dieuze	Grenoble	league	2009	2022-01-29 23:46:06.198334+00
551	Grenoble_Pierre Boya_2009.csv	Pierre Boya	Grenoble	league	2009	2022-01-29 23:46:06.199303+00
552	Grenoble_Ronan Le Crom_2009.csv	Ronan Le Crom	Grenoble	league	2009	2022-01-29 23:46:06.200163+00
553	Grenoble_Sandy Paillot_2009.csv	Sandy Paillot	Grenoble	league	2009	2022-01-29 23:46:06.200949+00
554	Grenoble_Saphir Taïder_2009.csv	Saphir Taïder	Grenoble	league	2009	2022-01-29 23:46:06.201937+00
555	Grenoble_Sho Ito_2009.csv	Sho Ito	Grenoble	league	2009	2022-01-29 23:46:06.20293+00
556	Grenoble_Sofiane Feghouli_2009.csv	Sofiane Feghouli	Grenoble	league	2009	2022-01-29 23:46:06.203909+00
557	Grenoble_Yoric Ravet_2009.csv	Yoric Ravet	Grenoble	league	2009	2022-01-29 23:46:06.205184+00
558	Grenoble_Zoran Rendulić_2009.csv	Zoran Rendulić	Grenoble	league	2009	2022-01-29 23:46:06.206104+00
559	Le Mans_Almen Abdi_2009.csv	Almen Abdi	Le Mans	league	2009	2022-01-29 23:46:06.206997+00
560	Le Mans_Alphousseyni Keita_2009.csv	Alphousseyni Keita	Le Mans	league	2009	2022-01-29 23:46:06.207922+00
561	Le Mans_Anthony Le Tallec_2009.csv	Anthony Le Tallec	Le Mans	league	2009	2022-01-29 23:46:06.208717+00
562	Le Mans_Badara Sène_2009.csv	Badara Sène	Le Mans	league	2009	2022-01-29 23:46:06.209396+00
563	Le Mans_Cyriaque Louvion_2009.csv	Cyriaque Louvion	Le Mans	league	2009	2022-01-29 23:46:06.210111+00
564	Le Mans_Didier Ovono_2009.csv	Didier Ovono	Le Mans	league	2009	2022-01-29 23:46:06.210812+00
565	Le Mans_Fousseyni Cissé_2009.csv	Fousseyni Cissé	Le Mans	league	2009	2022-01-29 23:46:06.211484+00
566	Le Mans_Fredrik Strømstad_2009.csv	Fredrik Strømstad	Le Mans	league	2009	2022-01-29 23:46:06.212187+00
567	Le Mans_Frédéric Thomas_2009.csv	Frédéric Thomas	Le Mans	league	2009	2022-01-29 23:46:06.212894+00
568	Le Mans_Géder_2009.csv	Géder	Le Mans	league	2009	2022-01-29 23:46:06.213663+00
569	Le Mans_Giorgi Makaridze_2009.csv	Giorgi Makaridze	Le Mans	league	2009	2022-01-29 23:46:06.214381+00
570	Le Mans_Grégory Cerdan_2009.csv	Grégory Cerdan	Le Mans	league	2009	2022-01-29 23:46:06.215106+00
571	Le Mans_Guillaume Loriot_2009.csv	Guillaume Loriot	Le Mans	league	2009	2022-01-29 23:46:06.215825+00
572	Le Mans_Guy-Michel Landel_2009.csv	Guy-Michel Landel	Le Mans	league	2009	2022-01-29 23:46:06.2168+00
573	Le Mans_Hérold Goulon_2009.csv	Hérold Goulon	Le Mans	league	2009	2022-01-29 23:46:06.217516+00
574	Le Mans_Ibrahima Camara_2009.csv	Ibrahima Camara	Le Mans	league	2009	2022-01-29 23:46:06.218215+00
575	Le Mans_Idir Ouali_2009.csv	Idir Ouali	Le Mans	league	2009	2022-01-29 23:46:06.21897+00
576	Le Mans_João Paulo_2009.csv	João Paulo	Le Mans	league	2009	2022-01-29 23:46:06.219728+00
577	Le Mans_Ludovic Baal_2009.csv	Ludovic Baal	Le Mans	league	2009	2022-01-29 23:46:06.220429+00
578	Le Mans_Mamadou Wague_2009.csv	Mamadou Wague	Le Mans	league	2009	2022-01-29 23:46:06.221936+00
579	Le Mans_Marcelo Estigarribia_2009.csv	Marcelo Estigarribia	Le Mans	league	2009	2022-01-29 23:46:06.22278+00
580	Le Mans_Mathieu Coutadeur_2009.csv	Mathieu Coutadeur	Le Mans	league	2009	2022-01-29 23:46:06.223519+00
581	Le Mans_Mathieu Dossevi_2009.csv	Mathieu Dossevi	Le Mans	league	2009	2022-01-29 23:46:06.224286+00
582	Le Mans_Modibo Maïga_2009.csv	Modibo Maïga	Le Mans	league	2009	2022-01-29 23:46:06.22503+00
583	Le Mans_Moussa Narry_2009.csv	Moussa Narry	Le Mans	league	2009	2022-01-29 23:46:06.225759+00
584	Le Mans_Olivier Thomert_2009.csv	Olivier Thomert	Le Mans	league	2009	2022-01-29 23:46:06.226465+00
585	Le Mans_Pierre Gibaud_2009.csv	Pierre Gibaud	Le Mans	league	2009	2022-01-29 23:46:06.227165+00
586	Le Mans_Rodolphe Roche_2009.csv	Rodolphe Roche	Le Mans	league	2009	2022-01-29 23:46:06.227866+00
587	Le Mans_Roland Lamah_2009.csv	Roland Lamah	Le Mans	league	2009	2022-01-29 23:46:06.22852+00
588	Le Mans_Saber Ben Frej_2009.csv	Saber Ben Frej	Le Mans	league	2009	2022-01-29 23:46:06.229201+00
589	Le Mans_Samuel Bouhours_2009.csv	Samuel Bouhours	Le Mans	league	2009	2022-01-29 23:46:06.229862+00
590	Le Mans_Sébastien Corchia_2009.csv	Sébastien Corchia	Le Mans	league	2009	2022-01-29 23:46:06.230574+00
591	Le Mans_Thorstein Helstad_2009.csv	Thorstein Helstad	Le Mans	league	2009	2022-01-29 23:46:06.231188+00
592	Lens_Abdelhakim Omrani_2010.csv	Abdelhakim Omrani	Lens	league	2010	2022-01-29 23:46:06.232082+00
593	Lens_Adil Hermach_2009.csv	Adil Hermach	Lens	league	2009	2022-01-29 23:46:06.232931+00
595	Lens_Alaeddine Yahia_2009.csv	Alaeddine Yahia	Lens	league	2009	2022-01-29 23:46:06.234357+00
596	Lens_Alaeddine Yahia_2010.csv	Alaeddine Yahia	Lens	league	2010	2022-01-29 23:46:06.235394+00
597	Lens_Alassane Touré_2009.csv	Alassane Touré	Lens	league	2009	2022-01-29 23:46:06.236108+00
598	Lens_Alassane Touré_2010.csv	Alassane Touré	Lens	league	2010	2022-01-29 23:46:06.236812+00
599	Lens_Alexandre Coeff_2010.csv	Alexandre Coeff	Lens	league	2010	2022-01-29 23:46:06.237773+00
600	Lens_Darnel Situ_2010.csv	Darnel Situ	Lens	league	2010	2022-01-29 23:46:06.23869+00
601	Lens_David Pollet_2010.csv	David Pollet	Lens	league	2010	2022-01-29 23:46:06.239479+00
602	Lens_Dejan Milovanović_2009.csv	Dejan Milovanović	Lens	league	2009	2022-01-29 23:46:06.240258+00
603	Lens_Eduardo dos Santos_2009.csv	Eduardo dos Santos	Lens	league	2009	2022-01-29 23:46:06.241012+00
604	Lens_Eduardo dos Santos_2010.csv	Eduardo dos Santos	Lens	league	2010	2022-01-29 23:46:06.241724+00
605	Lens_Éric Chelle_2009.csv	Éric Chelle	Lens	league	2009	2022-01-29 23:46:06.242589+00
606	Lens_Éric Chelle_2010.csv	Éric Chelle	Lens	league	2010	2022-01-29 23:46:06.24356+00
607	Lens_Fabien Laurenti_2009.csv	Fabien Laurenti	Lens	league	2009	2022-01-29 23:46:06.244459+00
608	Lens_Franck Queudrue_2010.csv	Franck Queudrue	Lens	league	2010	2022-01-29 23:46:06.245522+00
609	Lens_Geoffrey Kondogbia_2010.csv	Geoffrey Kondogbia	Lens	league	2010	2022-01-29 23:46:06.24658+00
610	Lens_Grégory Sertic_2010.csv	Grégory Sertic	Lens	league	2010	2022-01-29 23:46:06.247588+00
611	Lens_Hamdi Kasraoui_2009.csv	Hamdi Kasraoui	Lens	league	2009	2022-01-29 23:46:06.248388+00
612	Lens_Hamdi Kasraoui_2010.csv	Hamdi Kasraoui	Lens	league	2010	2022-01-29 23:46:06.249097+00
613	Lens_Henri Bedimo_2009.csv	Henri Bedimo	Lens	league	2009	2022-01-29 23:46:06.249811+00
614	Lens_Henri Bedimo_2010.csv	Henri Bedimo	Lens	league	2010	2022-01-29 23:46:06.250451+00
615	Lens_Issam Jemâa_2009.csv	Issam Jemâa	Lens	league	2009	2022-01-29 23:46:06.251109+00
616	Lens_Issam Jemâa_2010.csv	Issam Jemâa	Lens	league	2010	2022-01-29 23:46:06.251715+00
617	Lens_Kanga Akalé_2009.csv	Kanga Akalé	Lens	league	2009	2022-01-29 23:46:06.252363+00
618	Lens_Kanga Akalé_2010.csv	Kanga Akalé	Lens	league	2010	2022-01-29 23:46:06.253008+00
619	Lens_Kévin Monnet-Paquet_2009.csv	Kévin Monnet-Paquet	Lens	league	2009	2022-01-29 23:46:06.253641+00
620	Lens_Kévin Monnet-Paquet_2010.csv	Kévin Monnet-Paquet	Lens	league	2010	2022-01-29 23:46:06.254275+00
621	Lens_Marco Ramos_2009.csv	Marco Ramos	Lens	league	2009	2022-01-29 23:46:06.255113+00
622	Lens_Marco Ramos_2010.csv	Marco Ramos	Lens	league	2010	2022-01-29 23:46:06.255932+00
623	Lens_Nenad Kovačević_2009.csv	Nenad Kovačević	Lens	league	2009	2022-01-29 23:46:06.257022+00
624	Lens_Nenad Kovačević_2010.csv	Nenad Kovačević	Lens	league	2010	2022-01-29 23:46:06.257752+00
625	Lens_Raphaël Varane_2010.csv	Raphaël Varane	Lens	league	2010	2022-01-29 23:46:06.258417+00
626	Lens_Razak Boukari_2009.csv	Razak Boukari	Lens	league	2009	2022-01-29 23:46:06.259093+00
627	Lens_Razak Boukari_2010.csv	Razak Boukari	Lens	league	2010	2022-01-29 23:46:06.25978+00
628	Lens_Romain Sartre_2009.csv	Romain Sartre	Lens	league	2009	2022-01-29 23:46:06.26046+00
629	Lens_Romain Sartre_2010.csv	Romain Sartre	Lens	league	2010	2022-01-29 23:46:06.261112+00
630	Lens_Samba Sow_2009.csv	Samba Sow	Lens	league	2009	2022-01-29 23:46:06.261788+00
631	Lens_Samba Sow_2010.csv	Samba Sow	Lens	league	2010	2022-01-29 23:46:06.262528+00
632	Lens_Serge Aurier_2009.csv	Serge Aurier	Lens	league	2009	2022-01-29 23:46:06.263179+00
633	Lens_Serge Aurier_2010.csv	Serge Aurier	Lens	league	2010	2022-01-29 23:46:06.263923+00
634	Lens_Sébastien Roudet_2009.csv	Sébastien Roudet	Lens	league	2009	2022-01-29 23:46:06.264677+00
635	Lens_Sébastien Roudet_2010.csv	Sébastien Roudet	Lens	league	2010	2022-01-29 23:46:06.265516+00
636	Lens_Sidi Yaya Keita_2010.csv	Sidi Yaya Keita	Lens	league	2010	2022-01-29 23:46:06.266275+00
637	Lens_Steeven Joseph-Monrose_2009.csv	Steeven Joseph-Monrose	Lens	league	2009	2022-01-29 23:46:06.266957+00
638	Lens_Steeven Joseph-Monrose_2010.csv	Steeven Joseph-Monrose	Lens	league	2010	2022-01-29 23:46:06.267638+00
639	Lens_Toifilou Maoulida_2009.csv	Toifilou Maoulida	Lens	league	2009	2022-01-29 23:46:06.26825+00
640	Lens_Toifilou Maoulida_2010.csv	Toifilou Maoulida	Lens	league	2010	2022-01-29 23:46:06.26886+00
641	Lens_Vedran Runje_2009.csv	Vedran Runje	Lens	league	2009	2022-01-29 23:46:06.26941+00
642	Lens_Vedran Runje_2010.csv	Vedran Runje	Lens	league	2010	2022-01-29 23:46:06.270037+00
643	Lens_Yohan Demont_2009.csv	Yohan Demont	Lens	league	2009	2022-01-29 23:46:06.270633+00
644	Lens_Yohan Demont_2010.csv	Yohan Demont	Lens	league	2010	2022-01-29 23:46:06.271325+00
645	Lens_Zakarya Bergdich_2010.csv	Zakarya Bergdich	Lens	league	2010	2022-01-29 23:46:06.272208+00
646	Lille_Adil Rami_2009.csv	Adil Rami	Lille	league	2009	2022-01-29 23:46:06.272807+00
647	Lille_Adil Rami_2010.csv	Adil Rami	Lille	league	2010	2022-01-29 23:46:06.273475+00
648	Lille_Arnaud Souquet_2009.csv	Arnaud Souquet	Lille	league	2009	2022-01-29 23:46:06.27415+00
649	Lille_Aurélien Chedjou_2009.csv	Aurélien Chedjou	Lille	league	2009	2022-01-29 23:46:06.274844+00
650	Lille_Aurélien Chedjou_2010.csv	Aurélien Chedjou	Lille	league	2010	2022-01-29 23:46:06.275478+00
651	Lille_Aurélien Chedjou_2011.csv	Aurélien Chedjou	Lille	league	2011	2022-01-29 23:46:06.276107+00
652	Lille_Aurélien Chedjou_2012.csv	Aurélien Chedjou	Lille	league	2012	2022-01-29 23:46:06.276762+00
653	Lille_Barel Mouko_2012.csv	Barel Mouko	Lille	league	2012	2022-01-29 23:46:06.277321+00
654	Lille_Benoît Pedretti_2011.csv	Benoît Pedretti	Lille	league	2011	2022-01-29 23:46:06.277973+00
655	Lille_Benoît Pedretti_2012.csv	Benoît Pedretti	Lille	league	2012	2022-01-29 23:46:06.278637+00
656	Lille_David Rozehnal_2010.csv	David Rozehnal	Lille	league	2010	2022-01-29 23:46:06.279308+00
657	Lille_David Rozehnal_2011.csv	David Rozehnal	Lille	league	2011	2022-01-29 23:46:06.280151+00
658	Lille_David Rozehnal_2012.csv	David Rozehnal	Lille	league	2012	2022-01-29 23:46:06.281008+00
659	Lille_Dimitri Payet_2011.csv	Dimitri Payet	Lille	league	2011	2022-01-29 23:46:06.281682+00
660	Lille_Dimitri Payet_2012.csv	Dimitri Payet	Lille	league	2012	2022-01-29 23:46:06.282304+00
661	Lille_Divock Origi_2012.csv	Divock Origi	Lille	league	2012	2022-01-29 23:46:06.282944+00
662	Lille_Djibril Sidibé_2012.csv	Djibril Sidibé	Lille	league	2012	2022-01-29 23:46:06.283644+00
663	Lille_Eden Hazard_2009.csv	Eden Hazard	Lille	league	2009	2022-01-29 23:46:06.284268+00
664	Lille_Eden Hazard_2010.csv	Eden Hazard	Lille	league	2010	2022-01-29 23:46:06.284921+00
665	Lille_Eden Hazard_2011.csv	Eden Hazard	Lille	league	2011	2022-01-29 23:46:06.285587+00
666	Lille_Emerson_2009.csv	Emerson	Lille	league	2009	2022-01-29 23:46:06.286212+00
667	Lille_Emerson_2010.csv	Emerson	Lille	league	2010	2022-01-29 23:46:06.286867+00
668	Lille_Emil Lyng_2010.csv	Emil Lyng	Lille	league	2010	2022-01-29 23:46:06.287448+00
669	Lille_Florent Balmont_2009.csv	Florent Balmont	Lille	league	2009	2022-01-29 23:46:06.288394+00
670	Lille_Florent Balmont_2010.csv	Florent Balmont	Lille	league	2010	2022-01-29 23:46:06.28927+00
671	Lille_Florent Balmont_2011.csv	Florent Balmont	Lille	league	2011	2022-01-29 23:46:06.290212+00
672	Lille_Florent Balmont_2012.csv	Florent Balmont	Lille	league	2012	2022-01-29 23:46:06.290925+00
673	Lille_Franck Béria_2009.csv	Franck Béria	Lille	league	2009	2022-01-29 23:46:06.291948+00
674	Lille_Franck Béria_2010.csv	Franck Béria	Lille	league	2010	2022-01-29 23:46:06.293205+00
675	Lille_Franck Béria_2011.csv	Franck Béria	Lille	league	2011	2022-01-29 23:46:06.294027+00
676	Lille_Franck Béria_2012.csv	Franck Béria	Lille	league	2012	2022-01-29 23:46:06.294648+00
677	Lille_Gervinho_2009.csv	Gervinho	Lille	league	2009	2022-01-29 23:46:06.295267+00
678	Lille_Gervinho_2010.csv	Gervinho	Lille	league	2010	2022-01-29 23:46:06.295927+00
679	Lille_Gianni Bruno_2011.csv	Gianni Bruno	Lille	league	2011	2022-01-29 23:46:06.297042+00
680	Lille_Gianni Bruno_2012.csv	Gianni Bruno	Lille	league	2012	2022-01-29 23:46:06.297755+00
681	Lille_Idrissa Gana Gueye_2010.csv	Idrissa Gana Gueye	Lille	league	2010	2022-01-29 23:46:06.298589+00
682	Lille_Idrissa Gana Gueye_2011.csv	Idrissa Gana Gueye	Lille	league	2011	2022-01-29 23:46:06.299454+00
683	Lille_Idrissa Gana Gueye_2012.csv	Idrissa Gana Gueye	Lille	league	2012	2022-01-29 23:46:06.300142+00
684	Lille_Ireneusz Jeleń_2011.csv	Ireneusz Jeleń	Lille	league	2011	2022-01-29 23:46:06.300721+00
685	Lille_Jerry Vandam_2009.csv	Jerry Vandam	Lille	league	2009	2022-01-29 23:46:06.301287+00
686	Lille_Jerry Vandam_2010.csv	Jerry Vandam	Lille	league	2010	2022-01-29 23:46:06.301922+00
687	Lille_Joe Cole_2011.csv	Joe Cole	Lille	league	2011	2022-01-29 23:46:06.30248+00
688	Lille_Larsen Touré_2009.csv	Larsen Touré	Lille	league	2009	2022-01-29 23:46:06.302974+00
689	Lille_Laurent Bonnart_2011.csv	Laurent Bonnart	Lille	league	2011	2022-01-29 23:46:06.303571+00
690	Lille_Laurent Bonnart_2012.csv	Laurent Bonnart	Lille	league	2012	2022-01-29 23:46:06.304392+00
691	Lille_Lucas Digne_2011.csv	Lucas Digne	Lille	league	2011	2022-01-29 23:46:06.305253+00
692	Lille_Lucas Digne_2012.csv	Lucas Digne	Lille	league	2012	2022-01-29 23:46:06.306084+00
693	Lille_Ludovic Butelle_2009.csv	Ludovic Butelle	Lille	league	2009	2022-01-29 23:46:06.306809+00
694	Lille_Ludovic Obraniak_2009.csv	Ludovic Obraniak	Lille	league	2009	2022-01-29 23:46:06.307488+00
695	Lille_Ludovic Obraniak_2010.csv	Ludovic Obraniak	Lille	league	2010	2022-01-29 23:46:06.308104+00
696	Lille_Ludovic Obraniak_2011.csv	Ludovic Obraniak	Lille	league	2011	2022-01-29 23:46:06.30869+00
697	Lille_Marko Baša_2011.csv	Marko Baša	Lille	league	2011	2022-01-29 23:46:06.30925+00
698	Lille_Marko Baša_2012.csv	Marko Baša	Lille	league	2012	2022-01-29 23:46:06.309819+00
699	Lille_Marvin Martin_2012.csv	Marvin Martin	Lille	league	2012	2022-01-29 23:46:06.310357+00
700	Lille_Mathieu Debuchy_2009.csv	Mathieu Debuchy	Lille	league	2009	2022-01-29 23:46:06.310902+00
701	Lille_Mathieu Debuchy_2010.csv	Mathieu Debuchy	Lille	league	2010	2022-01-29 23:46:06.311476+00
702	Lille_Mathieu Debuchy_2011.csv	Mathieu Debuchy	Lille	league	2011	2022-01-29 23:46:06.312289+00
703	Lille_Mathieu Debuchy_2012.csv	Mathieu Debuchy	Lille	league	2012	2022-01-29 23:46:06.31308+00
704	Lille_Mauro Cetto_2011.csv	Mauro Cetto	Lille	league	2011	2022-01-29 23:46:06.313676+00
705	Lille_Mickaël Landreau_2009.csv	Mickaël Landreau	Lille	league	2009	2022-01-29 23:46:06.314231+00
706	Lille_Mickaël Landreau_2010.csv	Mickaël Landreau	Lille	league	2010	2022-01-29 23:46:06.314735+00
707	Lille_Mickaël Landreau_2011.csv	Mickaël Landreau	Lille	league	2011	2022-01-29 23:46:06.315265+00
708	Lille_Mickaël Landreau_2012.csv	Mickaël Landreau	Lille	league	2012	2022-01-29 23:46:06.315778+00
709	Lille_Moussa Sow_2010.csv	Moussa Sow	Lille	league	2010	2022-01-29 23:46:06.31624+00
710	Lille_Moussa Sow_2011.csv	Moussa Sow	Lille	league	2011	2022-01-29 23:46:06.316689+00
711	Lille_Nicolas Plestan_2009.csv	Nicolas Plestan	Lille	league	2009	2022-01-29 23:46:06.317131+00
712	Lille_Nolan Roux_2011.csv	Nolan Roux	Lille	league	2011	2022-01-29 23:46:06.31758+00
713	Lille_Nolan Roux_2012.csv	Nolan Roux	Lille	league	2012	2022-01-29 23:46:06.31805+00
714	Lille_Omar Wade_2010.csv	Omar Wade	Lille	league	2010	2022-01-29 23:46:06.318551+00
715	Lille_Pape Souaré_2010.csv	Pape Souaré	Lille	league	2010	2022-01-29 23:46:06.319055+00
716	Lille_Pape Souaré_2011.csv	Pape Souaré	Lille	league	2011	2022-01-29 23:46:06.319745+00
717	Lille_Pierre-Alain Frau_2009.csv	Pierre-Alain Frau	Lille	league	2009	2022-01-29 23:46:06.320499+00
718	Lille_Pierre-Alain Frau_2010.csv	Pierre-Alain Frau	Lille	league	2010	2022-01-29 23:46:06.321061+00
719	Lille_Pierre-Emerick Aubameyang_2009.csv	Pierre-Emerick Aubameyang	Lille	league	2009	2022-01-29 23:46:06.321547+00
720	Lille_Ricardo Costa_2009.csv	Ricardo Costa	Lille	league	2009	2022-01-29 23:46:06.322143+00
721	Lille_Rio Mavuba_2009.csv	Rio Mavuba	Lille	league	2009	2022-01-29 23:46:06.32336+00
722	Lille_Rio Mavuba_2010.csv	Rio Mavuba	Lille	league	2010	2022-01-29 23:46:06.324366+00
723	Lille_Rio Mavuba_2011.csv	Rio Mavuba	Lille	league	2011	2022-01-29 23:46:06.32529+00
724	Lille_Rio Mavuba_2012.csv	Rio Mavuba	Lille	league	2012	2022-01-29 23:46:06.325931+00
725	Lille_Ronny Rodelin_2011.csv	Ronny Rodelin	Lille	league	2011	2022-01-29 23:46:06.326453+00
726	Lille_Ronny Rodelin_2012.csv	Ronny Rodelin	Lille	league	2012	2022-01-29 23:46:06.32697+00
727	Lille_Róbert Vittek_2009.csv	Róbert Vittek	Lille	league	2009	2022-01-29 23:46:06.32763+00
728	Lille_Ryan Mendes_2012.csv	Ryan Mendes	Lille	league	2012	2022-01-29 23:46:06.328385+00
729	Lille_Salomon Kalou_2012.csv	Salomon Kalou	Lille	league	2012	2022-01-29 23:46:06.328977+00
730	Lille_Steeve Elana_2012.csv	Steeve Elana	Lille	league	2012	2022-01-29 23:46:06.329488+00
731	Lille_Stéphane Dumont_2009.csv	Stéphane Dumont	Lille	league	2009	2022-01-29 23:46:06.330001+00
732	Lille_Stéphane Dumont_2010.csv	Stéphane Dumont	Lille	league	2010	2022-01-29 23:46:06.330495+00
733	Lille_Túlio de Melo_2009.csv	Túlio de Melo	Lille	league	2009	2022-01-29 23:46:06.331008+00
734	Lille_Túlio de Melo_2010.csv	Túlio de Melo	Lille	league	2010	2022-01-29 23:46:06.331632+00
735	Lille_Túlio de Melo_2011.csv	Túlio de Melo	Lille	league	2011	2022-01-29 23:46:06.332371+00
736	Lille_Túlio de Melo_2012.csv	Túlio de Melo	Lille	league	2012	2022-01-29 23:46:06.332923+00
737	Lille_Viktor Klonaridis_2012.csv	Viktor Klonaridis	Lille	league	2012	2022-01-29 23:46:06.333472+00
738	Lille_Yohan Cabaye_2009.csv	Yohan Cabaye	Lille	league	2009	2022-01-29 23:46:06.333994+00
739	Lille_Yohan Cabaye_2010.csv	Yohan Cabaye	Lille	league	2010	2022-01-29 23:46:06.334503+00
740	Lorient_Alain Traoré_2012.csv	Alain Traoré	Lorient	league	2012	2022-01-29 23:46:06.335063+00
741	Lorient_Alaixys Romao_2010.csv	Alaixys Romao	Lorient	league	2010	2022-01-29 23:46:06.335748+00
742	Lorient_Alaixys Romao_2011.csv	Alaixys Romao	Lorient	league	2011	2022-01-29 23:46:06.336517+00
743	Lorient_Alaixys Romao_2012.csv	Alaixys Romao	Lorient	league	2012	2022-01-29 23:46:06.337046+00
744	Lorient_Arnaud Le Lan_2009.csv	Arnaud Le Lan	Lorient	league	2009	2022-01-29 23:46:06.337598+00
745	Lorient_Arnaud Le Lan_2010.csv	Arnaud Le Lan	Lorient	league	2010	2022-01-29 23:46:06.338285+00
746	Lorient_Arnaud Le Lan_2011.csv	Arnaud Le Lan	Lorient	league	2011	2022-01-29 23:46:06.338997+00
747	Lorient_Arnaud Le Lan_2012.csv	Arnaud Le Lan	Lorient	league	2012	2022-01-29 23:46:06.339746+00
748	Lorient_Arnold Mvuemba_2009.csv	Arnold Mvuemba	Lorient	league	2009	2022-01-29 23:46:06.340321+00
749	Lorient_Arnold Mvuemba_2010.csv	Arnold Mvuemba	Lorient	league	2010	2022-01-29 23:46:06.340795+00
750	Lorient_Arnold Mvuemba_2011.csv	Arnold Mvuemba	Lorient	league	2011	2022-01-29 23:46:06.341269+00
751	Lorient_Arnold Mvuemba_2012.csv	Arnold Mvuemba	Lorient	league	2012	2022-01-29 23:46:06.342517+00
752	Lorient_Benjamin Corgnet_2012.csv	Benjamin Corgnet	Lorient	league	2012	2022-01-29 23:46:06.343085+00
753	Lorient_Benjamin Genton_2009.csv	Benjamin Genton	Lorient	league	2009	2022-01-29 23:46:06.343773+00
754	Lorient_Benjamin Lecomte_2010.csv	Benjamin Lecomte	Lorient	league	2010	2022-01-29 23:46:06.344612+00
755	Lorient_Benjamin Lecomte_2011.csv	Benjamin Lecomte	Lorient	league	2011	2022-01-29 23:46:06.345219+00
756	Lorient_Benjamin Lecomte_2012.csv	Benjamin Lecomte	Lorient	league	2012	2022-01-29 23:46:06.345737+00
757	Lorient_Bruno Ecuele Manga_2010.csv	Bruno Ecuele Manga	Lorient	league	2010	2022-01-29 23:46:06.346202+00
758	Lorient_Bruno Ecuele Manga_2011.csv	Bruno Ecuele Manga	Lorient	league	2011	2022-01-29 23:46:06.346662+00
759	Lorient_Bruno Ecuele Manga_2012.csv	Bruno Ecuele Manga	Lorient	league	2012	2022-01-29 23:46:06.347252+00
760	Lorient_Cheick Doukouré_2010.csv	Cheick Doukouré	Lorient	league	2010	2022-01-29 23:46:06.347736+00
761	Lorient_Enzo Reale_2012.csv	Enzo Reale	Lorient	league	2012	2022-01-29 23:46:06.348202+00
762	Lorient_Fabien Audard_2009.csv	Fabien Audard	Lorient	league	2009	2022-01-29 23:46:06.348663+00
763	Lorient_Fabien Audard_2010.csv	Fabien Audard	Lorient	league	2010	2022-01-29 23:46:06.349171+00
764	Lorient_Fabien Audard_2011.csv	Fabien Audard	Lorient	league	2011	2022-01-29 23:46:06.349664+00
765	Lorient_Fabien Audard_2012.csv	Fabien Audard	Lorient	league	2012	2022-01-29 23:46:06.350154+00
766	Lorient_Fabien Robert_2010.csv	Fabien Robert	Lorient	league	2010	2022-01-29 23:46:06.350629+00
767	Lorient_Fabien Robert_2011.csv	Fabien Robert	Lorient	league	2011	2022-01-29 23:46:06.35123+00
768	Lorient_Fabien Robert_2012.csv	Fabien Robert	Lorient	league	2012	2022-01-29 23:46:06.351927+00
769	Lorient_Florent Chaigneau_2011.csv	Florent Chaigneau	Lorient	league	2011	2022-01-29 23:46:06.352709+00
770	Lorient_Francis Coquelin_2010.csv	Francis Coquelin	Lorient	league	2010	2022-01-29 23:46:06.353244+00
771	Lorient_Franco Sosa_2009.csv	Franco Sosa	Lorient	league	2009	2022-01-29 23:46:06.353761+00
772	Lorient_Franco Sosa_2010.csv	Franco Sosa	Lorient	league	2010	2022-01-29 23:46:06.354249+00
773	Lorient_Gabriel Peñalba_2009.csv	Gabriel Peñalba	Lorient	league	2009	2022-01-29 23:46:06.354777+00
774	Lorient_Gabriel Peñalba_2011.csv	Gabriel Peñalba	Lorient	league	2011	2022-01-29 23:46:06.355778+00
775	Lorient_Gilles Sunu_2010.csv	Gilles Sunu	Lorient	league	2010	2022-01-29 23:46:06.356864+00
776	Lorient_Gilles Sunu_2011.csv	Gilles Sunu	Lorient	league	2011	2022-01-29 23:46:06.357843+00
777	Lorient_Gilles Sunu_2012.csv	Gilles Sunu	Lorient	league	2012	2022-01-29 23:46:06.358483+00
778	Lorient_Grégory Bourillon_2009.csv	Grégory Bourillon	Lorient	league	2009	2022-01-29 23:46:06.359054+00
779	Lorient_Grégory Bourillon_2010.csv	Grégory Bourillon	Lorient	league	2010	2022-01-29 23:46:06.359774+00
780	Lorient_Grégory Bourillon_2011.csv	Grégory Bourillon	Lorient	league	2011	2022-01-29 23:46:06.360576+00
781	Lorient_Grégory Bourillon_2012.csv	Grégory Bourillon	Lorient	league	2012	2022-01-29 23:46:06.361252+00
782	Lorient_Innocent Emeghara_2011.csv	Innocent Emeghara	Lorient	league	2011	2022-01-29 23:46:06.361841+00
783	Lorient_Innocent Emeghara_2012.csv	Innocent Emeghara	Lorient	league	2012	2022-01-29 23:46:06.362404+00
784	Lorient_James Fanchone_2009.csv	James Fanchone	Lorient	league	2009	2022-01-29 23:46:06.362927+00
785	Lorient_James Fanchone_2010.csv	James Fanchone	Lorient	league	2010	2022-01-29 23:46:06.363447+00
786	Lorient_Jérémie Aliadière_2011.csv	Jérémie Aliadière	Lorient	league	2011	2022-01-29 23:46:06.363945+00
787	Lorient_Jérémie Aliadière_2012.csv	Jérémie Aliadière	Lorient	league	2012	2022-01-29 23:46:06.364496+00
788	Lorient_Jérémie Janot_2011.csv	Jérémie Janot	Lorient	league	2011	2022-01-29 23:46:06.365191+00
789	Lorient_Jérémy Morel_2009.csv	Jérémy Morel	Lorient	league	2009	2022-01-29 23:46:06.365957+00
790	Lorient_Jérémy Morel_2010.csv	Jérémy Morel	Lorient	league	2010	2022-01-29 23:46:06.366508+00
791	Lorient_Joel Campbell_2011.csv	Joel Campbell	Lorient	league	2011	2022-01-29 23:46:06.367048+00
792	Lorient_Jonas Sakuwaha_2009.csv	Jonas Sakuwaha	Lorient	league	2009	2022-01-29 23:46:06.367735+00
793	Lorient_Julien Quercia_2011.csv	Julien Quercia	Lorient	league	2011	2022-01-29 23:46:06.368493+00
794	Lorient_Julien Quercia_2012.csv	Julien Quercia	Lorient	league	2012	2022-01-29 23:46:06.369048+00
795	Lorient_Kévin Gameiro_2009.csv	Kévin Gameiro	Lorient	league	2009	2022-01-29 23:46:06.369517+00
796	Lorient_Kévin Gameiro_2010.csv	Kévin Gameiro	Lorient	league	2010	2022-01-29 23:46:06.36997+00
797	Lorient_Kévin Monnet-Paquet_2010.csv	Kévin Monnet-Paquet	Lorient	league	2010	2022-01-29 23:46:06.370422+00
798	Lorient_Kévin Monnet-Paquet_2011.csv	Kévin Monnet-Paquet	Lorient	league	2011	2022-01-29 23:46:06.370987+00
799	Lorient_Kévin Monnet-Paquet_2012.csv	Kévin Monnet-Paquet	Lorient	league	2012	2022-01-29 23:46:06.371644+00
800	Lorient_Ladislas Douniama_2011.csv	Ladislas Douniama	Lorient	league	2011	2022-01-29 23:46:06.372149+00
801	Lorient_Lamine Gassama_2011.csv	Lamine Gassama	Lorient	league	2011	2022-01-29 23:46:06.372621+00
802	Lorient_Lamine Gassama_2012.csv	Lamine Gassama	Lorient	league	2012	2022-01-29 23:46:06.373535+00
803	Lorient_Lamine Koné_2010.csv	Lamine Koné	Lorient	league	2010	2022-01-29 23:46:06.374158+00
804	Lorient_Lamine Koné_2011.csv	Lamine Koné	Lorient	league	2011	2022-01-29 23:46:06.374685+00
805	Lorient_Lamine Koné_2012.csv	Lamine Koné	Lorient	league	2012	2022-01-29 23:46:06.375288+00
806	Lorient_Laurent Koscielny_2009.csv	Laurent Koscielny	Lorient	league	2009	2022-01-29 23:46:06.37631+00
807	Lorient_Lionel Cappone_2009.csv	Lionel Cappone	Lorient	league	2009	2022-01-29 23:46:06.377013+00
808	Lorient_Lionel Cappone_2010.csv	Lionel Cappone	Lorient	league	2010	2022-01-29 23:46:06.377547+00
809	Lorient_Lucas Mareque_2011.csv	Lucas Mareque	Lorient	league	2011	2022-01-29 23:46:06.378023+00
810	Lorient_Lucas Mareque_2012.csv	Lucas Mareque	Lorient	league	2012	2022-01-29 23:46:06.378503+00
811	Lorient_Ludovic Giuly_2012.csv	Ludovic Giuly	Lorient	league	2012	2022-01-29 23:46:06.379012+00
812	Lorient_Lynel Kitambala_2010.csv	Lynel Kitambala	Lorient	league	2010	2022-01-29 23:46:06.379504+00
813	Lorient_Lynel Kitambala_2011.csv	Lynel Kitambala	Lorient	league	2011	2022-01-29 23:46:06.380004+00
814	Lorient_Marama Vahirua_2009.csv	Marama Vahirua	Lorient	league	2009	2022-01-29 23:46:06.380572+00
815	Lorient_Mario Lemina_2012.csv	Mario Lemina	Lorient	league	2012	2022-01-29 23:46:06.381056+00
816	Lorient_Mathias Autret_2010.csv	Mathias Autret	Lorient	league	2010	2022-01-29 23:46:06.381553+00
817	Lorient_Mathias Autret_2011.csv	Mathias Autret	Lorient	league	2011	2022-01-29 23:46:06.382029+00
818	Lorient_Mathias Autret_2012.csv	Mathias Autret	Lorient	league	2012	2022-01-29 23:46:06.382487+00
819	Lorient_Mathieu Coutadeur_2011.csv	Mathieu Coutadeur	Lorient	league	2011	2022-01-29 23:46:06.382957+00
820	Lorient_Mathieu Coutadeur_2012.csv	Mathieu Coutadeur	Lorient	league	2012	2022-01-29 23:46:06.383548+00
821	Lorient_Maxime Baca_2009.csv	Maxime Baca	Lorient	league	2009	2022-01-29 23:46:06.384344+00
822	Lorient_Maxime Baca_2010.csv	Maxime Baca	Lorient	league	2010	2022-01-29 23:46:06.384941+00
823	Lorient_Maxime Baca_2011.csv	Maxime Baca	Lorient	league	2011	2022-01-29 23:46:06.385474+00
824	Lorient_Maxime Baca_2012.csv	Maxime Baca	Lorient	league	2012	2022-01-29 23:46:06.386028+00
825	Lorient_Maxime Barthelmé_2009.csv	Maxime Barthelmé	Lorient	league	2009	2022-01-29 23:46:06.386534+00
826	Lorient_Maxime Barthelmé_2011.csv	Maxime Barthelmé	Lorient	league	2011	2022-01-29 23:46:06.387072+00
827	Lorient_Maxime Barthelmé_2012.csv	Maxime Barthelmé	Lorient	league	2012	2022-01-29 23:46:06.387712+00
828	Lorient_Mohammed Abu_2012.csv	Mohammed Abu	Lorient	league	2012	2022-01-29 23:46:06.38836+00
829	Lorient_Morgan Amalfitano_2009.csv	Morgan Amalfitano	Lorient	league	2009	2022-01-29 23:46:06.389104+00
830	Lorient_Morgan Amalfitano_2010.csv	Morgan Amalfitano	Lorient	league	2010	2022-01-29 23:46:06.390181+00
831	Lorient_Olivier Monterrubio_2009.csv	Olivier Monterrubio	Lorient	league	2009	2022-01-29 23:46:06.391176+00
832	Lorient_Olivier Monterrubio_2010.csv	Olivier Monterrubio	Lorient	league	2010	2022-01-29 23:46:06.392199+00
833	Lorient_Pedrinho_2011.csv	Pedrinho	Lorient	league	2011	2022-01-29 23:46:06.392989+00
834	Lorient_Pedrinho_2012.csv	Pedrinho	Lorient	league	2012	2022-01-29 23:46:06.393882+00
835	Lorient_Pierre Ducasse_2009.csv	Pierre Ducasse	Lorient	league	2009	2022-01-29 23:46:06.394723+00
836	Lorient_Rémi Mulumba_2010.csv	Rémi Mulumba	Lorient	league	2010	2022-01-29 23:46:06.395577+00
837	Lorient_Rémi Mulumba_2011.csv	Rémi Mulumba	Lorient	league	2011	2022-01-29 23:46:06.396652+00
838	Lorient_Rémi Mulumba_2012.csv	Rémi Mulumba	Lorient	league	2012	2022-01-29 23:46:06.397749+00
839	Lorient_Sebastián Dubarbier_2009.csv	Sebastián Dubarbier	Lorient	league	2009	2022-01-29 23:46:06.398658+00
840	Lorient_Sebastián Dubarbier_2010.csv	Sebastián Dubarbier	Lorient	league	2010	2022-01-29 23:46:06.399674+00
841	Lorient_Sebastián Dubarbier_2011.csv	Sebastián Dubarbier	Lorient	league	2011	2022-01-29 23:46:06.400707+00
842	Lorient_Sigamary Diarra_2009.csv	Sigamary Diarra	Lorient	league	2009	2022-01-29 23:46:06.401704+00
843	Lorient_Sigamary Diarra_2010.csv	Sigamary Diarra	Lorient	league	2010	2022-01-29 23:46:06.402788+00
844	Lorient_Sigamary Diarra_2011.csv	Sigamary Diarra	Lorient	league	2011	2022-01-29 23:46:06.403844+00
845	Lorient_Simon Falette_2011.csv	Simon Falette	Lorient	league	2011	2022-01-29 23:46:06.404934+00
846	Lorient_Sylvain Marchal_2009.csv	Sylvain Marchal	Lorient	league	2009	2022-01-29 23:46:06.405763+00
847	Lorient_Wesley Lautoa_2011.csv	Wesley Lautoa	Lorient	league	2011	2022-01-29 23:46:06.406787+00
848	Lorient_Wesley Lautoa_2012.csv	Wesley Lautoa	Lorient	league	2012	2022-01-29 23:46:06.407547+00
849	Lorient_Yann Jouffre_2009.csv	Yann Jouffre	Lorient	league	2009	2022-01-29 23:46:06.408707+00
850	Lorient_Yann Jouffre_2010.csv	Yann Jouffre	Lorient	league	2010	2022-01-29 23:46:06.409472+00
851	Lorient_Yann Jouffre_2011.csv	Yann Jouffre	Lorient	league	2011	2022-01-29 23:46:06.410243+00
852	Lorient_Yann Jouffre_2012.csv	Yann Jouffre	Lorient	league	2012	2022-01-29 23:46:06.411042+00
853	Lorient_Yazid Mansouri_2009.csv	Yazid Mansouri	Lorient	league	2009	2022-01-29 23:46:06.411789+00
854	Lyon_Alassane Pléa_2012.csv	Alassane Pléa	Lyon	league	2012	2022-01-29 23:46:06.412506+00
855	Lyon_Alexandre Lacazette_2009.csv	Alexandre Lacazette	Lyon	league	2009	2022-01-29 23:46:06.413236+00
856	Lyon_Alexandre Lacazette_2010.csv	Alexandre Lacazette	Lyon	league	2010	2022-01-29 23:46:06.41403+00
857	Lyon_Alexandre Lacazette_2011.csv	Alexandre Lacazette	Lyon	league	2011	2022-01-29 23:46:06.414676+00
858	Lyon_Alexandre Lacazette_2012.csv	Alexandre Lacazette	Lyon	league	2012	2022-01-29 23:46:06.415341+00
859	Lyon_Aly Cissokho_2009.csv	Aly Cissokho	Lyon	league	2009	2022-01-29 23:46:06.416221+00
860	Lyon_Aly Cissokho_2010.csv	Aly Cissokho	Lyon	league	2010	2022-01-29 23:46:06.416934+00
861	Lyon_Aly Cissokho_2011.csv	Aly Cissokho	Lyon	league	2011	2022-01-29 23:46:06.417581+00
862	Lyon_Aly Cissokho_2012.csv	Aly Cissokho	Lyon	league	2012	2022-01-29 23:46:06.418222+00
863	Lyon_Anthony Lopes_2012.csv	Anthony Lopes	Lyon	league	2012	2022-01-29 23:46:06.418878+00
864	Lyon_Anthony Martial_2012.csv	Anthony Martial	Lyon	league	2012	2022-01-29 23:46:06.41955+00
865	Lyon_Anthony Mounier_2009.csv	Anthony Mounier	Lyon	league	2009	2022-01-29 23:46:06.420224+00
866	Lyon_Anthony Réveillère_2009.csv	Anthony Réveillère	Lyon	league	2009	2022-01-29 23:46:06.42083+00
867	Lyon_Anthony Réveillère_2010.csv	Anthony Réveillère	Lyon	league	2010	2022-01-29 23:46:06.421457+00
868	Lyon_Anthony Réveillère_2011.csv	Anthony Réveillère	Lyon	league	2011	2022-01-29 23:46:06.422176+00
869	Lyon_Anthony Réveillère_2012.csv	Anthony Réveillère	Lyon	league	2012	2022-01-29 23:46:06.423606+00
870	Lyon_Arnold Mvuemba_2012.csv	Arnold Mvuemba	Lyon	league	2012	2022-01-29 23:46:06.424761+00
871	Lyon_Bafétimbi Gomis_2009.csv	Bafétimbi Gomis	Lyon	league	2009	2022-01-29 23:46:06.426003+00
872	Lyon_Bafétimbi Gomis_2010.csv	Bafétimbi Gomis	Lyon	league	2010	2022-01-29 23:46:06.426726+00
873	Lyon_Bafétimbi Gomis_2011.csv	Bafétimbi Gomis	Lyon	league	2011	2022-01-29 23:46:06.42754+00
874	Lyon_Bafétimbi Gomis_2012.csv	Bafétimbi Gomis	Lyon	league	2012	2022-01-29 23:46:06.428402+00
875	Lyon_Bakary Koné_2011.csv	Bakary Koné	Lyon	league	2011	2022-01-29 23:46:06.429135+00
876	Lyon_Bakary Koné_2012.csv	Bakary Koné	Lyon	league	2012	2022-01-29 23:46:06.429812+00
877	Lyon_César Delgado_2009.csv	César Delgado	Lyon	league	2009	2022-01-29 23:46:06.430515+00
878	Lyon_César Delgado_2010.csv	César Delgado	Lyon	league	2010	2022-01-29 23:46:06.431379+00
879	Lyon_Clément Grenier_2009.csv	Clément Grenier	Lyon	league	2009	2022-01-29 23:46:06.432381+00
880	Lyon_Clément Grenier_2010.csv	Clément Grenier	Lyon	league	2010	2022-01-29 23:46:06.43329+00
881	Lyon_Clément Grenier_2011.csv	Clément Grenier	Lyon	league	2011	2022-01-29 23:46:06.433968+00
882	Lyon_Clément Grenier_2012.csv	Clément Grenier	Lyon	league	2012	2022-01-29 23:46:06.434885+00
883	Lyon_Clinton N'Jie_2012.csv	Clinton N'Jie	Lyon	league	2012	2022-01-29 23:46:06.435773+00
884	Lyon_Cris_2009.csv	Cris	Lyon	league	2009	2022-01-29 23:46:06.436554+00
885	Lyon_Cris_2010.csv	Cris	Lyon	league	2010	2022-01-29 23:46:06.437426+00
886	Lyon_Cris_2011.csv	Cris	Lyon	league	2011	2022-01-29 23:46:06.438342+00
887	Lyon_Cris_2012.csv	Cris	Lyon	league	2012	2022-01-29 23:46:06.480565+00
888	Lyon_Dejan Lovren_2009.csv	Dejan Lovren	Lyon	league	2009	2022-01-29 23:46:06.483594+00
889	Lyon_Dejan Lovren_2010.csv	Dejan Lovren	Lyon	league	2010	2022-01-29 23:46:06.485016+00
890	Lyon_Dejan Lovren_2011.csv	Dejan Lovren	Lyon	league	2011	2022-01-29 23:46:06.48631+00
891	Lyon_Dejan Lovren_2012.csv	Dejan Lovren	Lyon	league	2012	2022-01-29 23:46:06.487725+00
892	Lyon_Ederson_2009.csv	Ederson	Lyon	league	2009	2022-01-29 23:46:06.489058+00
893	Lyon_Ederson_2010.csv	Ederson	Lyon	league	2010	2022-01-29 23:46:06.490589+00
894	Lyon_Ederson_2011.csv	Ederson	Lyon	league	2011	2022-01-29 23:46:06.49159+00
895	Lyon_Enzo Reale_2010.csv	Enzo Reale	Lyon	league	2010	2022-01-29 23:46:06.492404+00
896	Lyon_Fabián Monzón_2012.csv	Fabián Monzón	Lyon	league	2012	2022-01-29 23:46:06.493341+00
897	Lyon_Fabio Grosso_2009.csv	Fabio Grosso	Lyon	league	2009	2022-01-29 23:46:06.494712+00
898	Lyon_Farès Bahlouli_2012.csv	Farès Bahlouli	Lyon	league	2012	2022-01-29 23:46:06.495811+00
899	Lyon_François Clerc_2009.csv	François Clerc	Lyon	league	2009	2022-01-29 23:46:06.496931+00
900	Lyon_Gueïda Fofana_2011.csv	Gueïda Fofana	Lyon	league	2011	2022-01-29 23:46:06.498419+00
901	Lyon_Gueïda Fofana_2012.csv	Gueïda Fofana	Lyon	league	2012	2022-01-29 23:46:06.500104+00
902	Lyon_Harry Novillo_2010.csv	Harry Novillo	Lyon	league	2010	2022-01-29 23:46:06.500932+00
903	Lyon_Harry Novillo_2011.csv	Harry Novillo	Lyon	league	2011	2022-01-29 23:46:06.501562+00
904	Lyon_Hugo Lloris_2009.csv	Hugo Lloris	Lyon	league	2009	2022-01-29 23:46:06.502323+00
905	Lyon_Hugo Lloris_2010.csv	Hugo Lloris	Lyon	league	2010	2022-01-29 23:46:06.503064+00
906	Lyon_Hugo Lloris_2011.csv	Hugo Lloris	Lyon	league	2011	2022-01-29 23:46:06.503782+00
907	Lyon_Hugo Lloris_2012.csv	Hugo Lloris	Lyon	league	2012	2022-01-29 23:46:06.504801+00
908	Lyon_Ishak Belfodil_2009.csv	Ishak Belfodil	Lyon	league	2009	2022-01-29 23:46:06.505797+00
909	Lyon_Ishak Belfodil_2011.csv	Ishak Belfodil	Lyon	league	2011	2022-01-29 23:46:06.506867+00
910	Lyon_Jean Makoun_2009.csv	Jean Makoun	Lyon	league	2009	2022-01-29 23:46:06.507677+00
911	Lyon_Jean Makoun_2010.csv	Jean Makoun	Lyon	league	2010	2022-01-29 23:46:06.508298+00
912	Lyon_Jean-Alain Boumsong_2009.csv	Jean-Alain Boumsong	Lyon	league	2009	2022-01-29 23:46:06.508978+00
913	Lyon_Jérémy Pied_2010.csv	Jérémy Pied	Lyon	league	2010	2022-01-29 23:46:06.509866+00
914	Lyon_Jérémy Pied_2011.csv	Jérémy Pied	Lyon	league	2011	2022-01-29 23:46:06.510687+00
915	Lyon_Jérémy Pied_2012.csv	Jérémy Pied	Lyon	league	2012	2022-01-29 23:46:06.511433+00
916	Lyon_Jérémy Toulalan_2009.csv	Jérémy Toulalan	Lyon	league	2009	2022-01-29 23:46:06.512139+00
917	Lyon_Jérémy Toulalan_2010.csv	Jérémy Toulalan	Lyon	league	2010	2022-01-29 23:46:06.512853+00
918	Lyon_Jimmy Briand_2010.csv	Jimmy Briand	Lyon	league	2010	2022-01-29 23:46:06.513667+00
919	Lyon_Jimmy Briand_2011.csv	Jimmy Briand	Lyon	league	2011	2022-01-29 23:46:06.51446+00
920	Lyon_Jimmy Briand_2012.csv	Jimmy Briand	Lyon	league	2012	2022-01-29 23:46:06.515338+00
921	Lyon_John Mensah_2011.csv	John Mensah	Lyon	league	2011	2022-01-29 23:46:06.516238+00
922	Lyon_Jordan Ferri_2012.csv	Jordan Ferri	Lyon	league	2012	2022-01-29 23:46:06.516966+00
923	Lyon_Kim Källström_2009.csv	Kim Källström	Lyon	league	2009	2022-01-29 23:46:06.517658+00
924	Lyon_Kim Källström_2010.csv	Kim Källström	Lyon	league	2010	2022-01-29 23:46:06.518474+00
925	Lyon_Kim Källström_2011.csv	Kim Källström	Lyon	league	2011	2022-01-29 23:46:06.519443+00
926	Lyon_Lamine Gassama_2009.csv	Lamine Gassama	Lyon	league	2009	2022-01-29 23:46:06.52038+00
927	Lyon_Lamine Gassama_2010.csv	Lamine Gassama	Lyon	league	2010	2022-01-29 23:46:06.521155+00
928	Lyon_Lisandro López_2009.csv	Lisandro López	Lyon	league	2009	2022-01-29 23:46:06.52211+00
929	Lyon_Lisandro López_2010.csv	Lisandro López	Lyon	league	2010	2022-01-29 23:46:06.522877+00
930	Lyon_Lisandro López_2011.csv	Lisandro López	Lyon	league	2011	2022-01-29 23:46:06.523735+00
931	Lyon_Lisandro López_2012.csv	Lisandro López	Lyon	league	2012	2022-01-29 23:46:06.524714+00
932	Lyon_Mathieu Bodmer_2009.csv	Mathieu Bodmer	Lyon	league	2009	2022-01-29 23:46:06.525948+00
933	Lyon_Maxime Gonalons_2009.csv	Maxime Gonalons	Lyon	league	2009	2022-01-29 23:46:06.526855+00
934	Lyon_Maxime Gonalons_2010.csv	Maxime Gonalons	Lyon	league	2010	2022-01-29 23:46:06.527878+00
935	Lyon_Maxime Gonalons_2011.csv	Maxime Gonalons	Lyon	league	2011	2022-01-29 23:46:06.528994+00
936	Lyon_Maxime Gonalons_2012.csv	Maxime Gonalons	Lyon	league	2012	2022-01-29 23:46:06.530146+00
937	Lyon_Michel Bastos_2009.csv	Michel Bastos	Lyon	league	2009	2022-01-29 23:46:06.531265+00
938	Lyon_Michel Bastos_2010.csv	Michel Bastos	Lyon	league	2010	2022-01-29 23:46:06.532375+00
939	Lyon_Michel Bastos_2011.csv	Michel Bastos	Lyon	league	2011	2022-01-29 23:46:06.533517+00
940	Lyon_Michel Bastos_2012.csv	Michel Bastos	Lyon	league	2012	2022-01-29 23:46:06.53461+00
941	Lyon_Milan Biševac_2012.csv	Milan Biševac	Lyon	league	2012	2022-01-29 23:46:06.535694+00
942	Lyon_Miralem Pjanić_2009.csv	Miralem Pjanić	Lyon	league	2009	2022-01-29 23:46:06.536825+00
943	Lyon_Miralem Pjanić_2010.csv	Miralem Pjanić	Lyon	league	2010	2022-01-29 23:46:06.538086+00
944	Lyon_Miralem Pjanić_2011.csv	Miralem Pjanić	Lyon	league	2011	2022-01-29 23:46:06.538951+00
945	Lyon_Mouhamadou Dabo_2011.csv	Mouhamadou Dabo	Lyon	league	2011	2022-01-29 23:46:06.540112+00
946	Lyon_Mouhamadou Dabo_2012.csv	Mouhamadou Dabo	Lyon	league	2012	2022-01-29 23:46:06.54123+00
947	Lyon_Pape Diakhaté_2010.csv	Pape Diakhaté	Lyon	league	2010	2022-01-29 23:46:06.541883+00
948	Lyon_Rachid Ghezzal_2012.csv	Rachid Ghezzal	Lyon	league	2012	2022-01-29 23:46:06.542615+00
949	Lyon_Rémy Vercoutre_2009.csv	Rémy Vercoutre	Lyon	league	2009	2022-01-29 23:46:06.543317+00
950	Lyon_Rémy Vercoutre_2010.csv	Rémy Vercoutre	Lyon	league	2010	2022-01-29 23:46:06.544017+00
951	Lyon_Rémy Vercoutre_2011.csv	Rémy Vercoutre	Lyon	league	2011	2022-01-29 23:46:06.544694+00
952	Lyon_Rémy Vercoutre_2012.csv	Rémy Vercoutre	Lyon	league	2012	2022-01-29 23:46:06.545362+00
953	Lyon_Samuel Umtiti_2011.csv	Samuel Umtiti	Lyon	league	2011	2022-01-29 23:46:06.54604+00
954	Lyon_Samuel Umtiti_2012.csv	Samuel Umtiti	Lyon	league	2012	2022-01-29 23:46:06.546711+00
955	Lyon_Sidney Govou_2009.csv	Sidney Govou	Lyon	league	2009	2022-01-29 23:46:06.547487+00
956	Lyon_Sidy Koné_2011.csv	Sidy Koné	Lyon	league	2011	2022-01-29 23:46:06.548283+00
957	Lyon_Steed Malbranque_2012.csv	Steed Malbranque	Lyon	league	2012	2022-01-29 23:46:06.549311+00
958	Lyon_Timothée Kolodziejczak_2009.csv	Timothée Kolodziejczak	Lyon	league	2009	2022-01-29 23:46:06.550264+00
959	Lyon_Timothée Kolodziejczak_2010.csv	Timothée Kolodziejczak	Lyon	league	2010	2022-01-29 23:46:06.550998+00
960	Lyon_Timothée Kolodziejczak_2011.csv	Timothée Kolodziejczak	Lyon	league	2011	2022-01-29 23:46:06.551676+00
961	Lyon_Yannis Tafer_2009.csv	Yannis Tafer	Lyon	league	2009	2022-01-29 23:46:06.5523+00
962	Lyon_Yassine Benzia_2011.csv	Yassine Benzia	Lyon	league	2011	2022-01-29 23:46:06.552985+00
963	Lyon_Yassine Benzia_2012.csv	Yassine Benzia	Lyon	league	2012	2022-01-29 23:46:06.553643+00
964	Lyon_Yoann Gourcuff_2010.csv	Yoann Gourcuff	Lyon	league	2010	2022-01-29 23:46:06.554342+00
965	Lyon_Yoann Gourcuff_2011.csv	Yoann Gourcuff	Lyon	league	2011	2022-01-29 23:46:06.555191+00
966	Lyon_Yoann Gourcuff_2012.csv	Yoann Gourcuff	Lyon	league	2012	2022-01-29 23:46:06.556023+00
967	Marseille_Alaixys Romao_2012.csv	Alaixys Romao	Marseille	league	2012	2022-01-29 23:46:06.55676+00
968	Marseille_Alou Diarra_2011.csv	Alou Diarra	Marseille	league	2011	2022-01-29 23:46:06.557404+00
969	Marseille_André Ayew_2010.csv	André Ayew	Marseille	league	2010	2022-01-29 23:46:06.558056+00
970	Marseille_André Ayew_2011.csv	André Ayew	Marseille	league	2011	2022-01-29 23:46:06.558707+00
971	Marseille_André Ayew_2012.csv	André Ayew	Marseille	league	2012	2022-01-29 23:46:06.559315+00
972	Marseille_André-Pierre Gignac_2010.csv	André-Pierre Gignac	Marseille	league	2010	2022-01-29 23:46:06.559947+00
973	Marseille_André-Pierre Gignac_2011.csv	André-Pierre Gignac	Marseille	league	2011	2022-01-29 23:46:06.560537+00
974	Marseille_André-Pierre Gignac_2012.csv	André-Pierre Gignac	Marseille	league	2012	2022-01-29 23:46:06.561142+00
1335	Nancy_Ziri Hammar_2012.csv	Ziri Hammar	Nancy	league	2012	2022-01-29 23:46:06.81309+00
975	Marseille_Bakari Koné_2009.csv	Bakari Koné	Marseille	league	2009	2022-01-29 23:46:06.56171+00
976	Marseille_Benoît Cheyrou_2009.csv	Benoît Cheyrou	Marseille	league	2009	2022-01-29 23:46:06.562619+00
977	Marseille_Benoît Cheyrou_2010.csv	Benoît Cheyrou	Marseille	league	2010	2022-01-29 23:46:06.563225+00
978	Marseille_Benoît Cheyrou_2011.csv	Benoît Cheyrou	Marseille	league	2011	2022-01-29 23:46:06.56381+00
979	Marseille_Benoît Cheyrou_2012.csv	Benoît Cheyrou	Marseille	league	2012	2022-01-29 23:46:06.564427+00
980	Marseille_Billel Omrani_2011.csv	Billel Omrani	Marseille	league	2011	2022-01-29 23:46:06.564998+00
981	Marseille_Billel Omrani_2012.csv	Billel Omrani	Marseille	league	2012	2022-01-29 23:46:06.565546+00
982	Marseille_Brandão_2009.csv	Brandão	Marseille	league	2009	2022-01-29 23:46:06.566069+00
983	Marseille_Brandão_2010.csv	Brandão	Marseille	league	2010	2022-01-29 23:46:06.566677+00
984	Marseille_Brandão_2011.csv	Brandão	Marseille	league	2011	2022-01-29 23:46:06.567216+00
985	Marseille_César Azpilicueta_2010.csv	César Azpilicueta	Marseille	league	2010	2022-01-29 23:46:06.567742+00
986	Marseille_César Azpilicueta_2011.csv	César Azpilicueta	Marseille	league	2011	2022-01-29 23:46:06.568362+00
987	Marseille_César Azpilicueta_2012.csv	César Azpilicueta	Marseille	league	2012	2022-01-29 23:46:06.568977+00
988	Marseille_Charles Kaboré_2009.csv	Charles Kaboré	Marseille	league	2009	2022-01-29 23:46:06.569587+00
989	Marseille_Charles Kaboré_2010.csv	Charles Kaboré	Marseille	league	2010	2022-01-29 23:46:06.570216+00
990	Marseille_Charles Kaboré_2011.csv	Charles Kaboré	Marseille	league	2011	2022-01-29 23:46:06.570763+00
991	Marseille_Charles Kaboré_2012.csv	Charles Kaboré	Marseille	league	2012	2022-01-29 23:46:06.571477+00
992	Marseille_Chris Gadi_2011.csv	Chris Gadi	Marseille	league	2011	2022-01-29 23:46:06.572338+00
993	Marseille_Cyril Rool_2009.csv	Cyril Rool	Marseille	league	2009	2022-01-29 23:46:06.57319+00
994	Marseille_Djimi Traoré_2011.csv	Djimi Traoré	Marseille	league	2011	2022-01-29 23:46:06.57426+00
995	Marseille_Elinton Andrade_2009.csv	Elinton Andrade	Marseille	league	2009	2022-01-29 23:46:06.57507+00
996	Marseille_Édouard Cissé_2009.csv	Édouard Cissé	Marseille	league	2009	2022-01-29 23:46:06.575814+00
997	Marseille_Édouard Cissé_2010.csv	Édouard Cissé	Marseille	league	2010	2022-01-29 23:46:06.576532+00
998	Marseille_Fabrice Abriel_2009.csv	Fabrice Abriel	Marseille	league	2009	2022-01-29 23:46:06.577293+00
999	Marseille_Fabrice Abriel_2010.csv	Fabrice Abriel	Marseille	league	2010	2022-01-29 23:46:06.578015+00
1000	Marseille_Fabrice Apruzesse_2012.csv	Fabrice Apruzesse	Marseille	league	2012	2022-01-29 23:46:06.578845+00
1001	Marseille_Fernando Morientes_2009.csv	Fernando Morientes	Marseille	league	2009	2022-01-29 23:46:06.579786+00
1002	Marseille_Florian Raspentino_2012.csv	Florian Raspentino	Marseille	league	2012	2022-01-29 23:46:06.580566+00
1003	Marseille_Foued Kadir_2012.csv	Foued Kadir	Marseille	league	2012	2022-01-29 23:46:06.581396+00
1004	Marseille_Gabriel Heinze_2009.csv	Gabriel Heinze	Marseille	league	2009	2022-01-29 23:46:06.582325+00
1005	Marseille_Gabriel Heinze_2010.csv	Gabriel Heinze	Marseille	league	2010	2022-01-29 23:46:06.583439+00
1006	Marseille_Garry Bocaly_2009.csv	Garry Bocaly	Marseille	league	2009	2022-01-29 23:46:06.584329+00
1007	Marseille_Guy Gnabouyou_2010.csv	Guy Gnabouyou	Marseille	league	2010	2022-01-29 23:46:06.585327+00
1008	Marseille_Hatem Ben Arfa_2009.csv	Hatem Ben Arfa	Marseille	league	2009	2022-01-29 23:46:06.586546+00
1009	Marseille_Hatem Ben Arfa_2010.csv	Hatem Ben Arfa	Marseille	league	2010	2022-01-29 23:46:06.587692+00
1010	Marseille_Jean-Philippe Sabo_2011.csv	Jean-Philippe Sabo	Marseille	league	2011	2022-01-29 23:46:06.589156+00
1011	Marseille_Jérémy Morel_2011.csv	Jérémy Morel	Marseille	league	2011	2022-01-29 23:46:06.590202+00
1012	Marseille_Jérémy Morel_2012.csv	Jérémy Morel	Marseille	league	2012	2022-01-29 23:46:06.591147+00
1013	Marseille_Joey Barton_2012.csv	Joey Barton	Marseille	league	2012	2022-01-29 23:46:06.592012+00
1014	Marseille_Jordan Ayew_2009.csv	Jordan Ayew	Marseille	league	2009	2022-01-29 23:46:06.592964+00
1015	Marseille_Jordan Ayew_2010.csv	Jordan Ayew	Marseille	league	2010	2022-01-29 23:46:06.594051+00
1016	Marseille_Jordan Ayew_2011.csv	Jordan Ayew	Marseille	league	2011	2022-01-29 23:46:06.595132+00
1017	Marseille_Jordan Ayew_2012.csv	Jordan Ayew	Marseille	league	2012	2022-01-29 23:46:06.596263+00
1018	Marseille_Kassim Abdallah_2012.csv	Kassim Abdallah	Marseille	league	2012	2022-01-29 23:46:06.597384+00
1019	Marseille_Laurent Bonnart_2009.csv	Laurent Bonnart	Marseille	league	2009	2022-01-29 23:46:06.598273+00
1020	Marseille_Leyti N'Diaye_2010.csv	Leyti N'Diaye	Marseille	league	2010	2022-01-29 23:46:06.598994+00
1021	Marseille_Loïc Rémy_2010.csv	Loïc Rémy	Marseille	league	2010	2022-01-29 23:46:06.599714+00
1022	Marseille_Loïc Rémy_2011.csv	Loïc Rémy	Marseille	league	2011	2022-01-29 23:46:06.600446+00
1023	Marseille_Loïc Rémy_2012.csv	Loïc Rémy	Marseille	league	2012	2022-01-29 23:46:06.60119+00
1024	Marseille_Lucas Mendes_2012.csv	Lucas Mendes	Marseille	league	2012	2022-01-29 23:46:06.601869+00
1025	Marseille_Lucho González_2009.csv	Lucho González	Marseille	league	2009	2022-01-29 23:46:06.602566+00
1026	Marseille_Lucho González_2010.csv	Lucho González	Marseille	league	2010	2022-01-29 23:46:06.603221+00
1027	Marseille_Lucho González_2011.csv	Lucho González	Marseille	league	2011	2022-01-29 23:46:06.604022+00
1028	Marseille_Mamadou Niang_2009.csv	Mamadou Niang	Marseille	league	2009	2022-01-29 23:46:06.605714+00
1029	Marseille_Mamadou Niang_2010.csv	Mamadou Niang	Marseille	league	2010	2022-01-29 23:46:06.606912+00
1030	Marseille_Mamadou Samassa_2010.csv	Mamadou Samassa	Marseille	league	2010	2022-01-29 23:46:06.607913+00
1031	Marseille_Mathieu Valbuena_2009.csv	Mathieu Valbuena	Marseille	league	2009	2022-01-29 23:46:06.608744+00
1032	Marseille_Mathieu Valbuena_2010.csv	Mathieu Valbuena	Marseille	league	2010	2022-01-29 23:46:06.609547+00
1033	Marseille_Mathieu Valbuena_2011.csv	Mathieu Valbuena	Marseille	league	2011	2022-01-29 23:46:06.610338+00
1034	Marseille_Mathieu Valbuena_2012.csv	Mathieu Valbuena	Marseille	league	2012	2022-01-29 23:46:06.611215+00
1035	Marseille_Modou Sougou_2012.csv	Modou Sougou	Marseille	league	2012	2022-01-29 23:46:06.611988+00
1036	Marseille_Momar Bangoura_2011.csv	Momar Bangoura	Marseille	league	2011	2022-01-29 23:46:06.612653+00
1037	Marseille_Morgan Amalfitano_2011.csv	Morgan Amalfitano	Marseille	league	2011	2022-01-29 23:46:06.613335+00
1038	Marseille_Morgan Amalfitano_2012.csv	Morgan Amalfitano	Marseille	league	2012	2022-01-29 23:46:06.613964+00
1039	Marseille_Nicolas Nkoulou_2011.csv	Nicolas Nkoulou	Marseille	league	2011	2022-01-29 23:46:06.61456+00
1040	Marseille_Nicolas Nkoulou_2012.csv	Nicolas Nkoulou	Marseille	league	2012	2022-01-29 23:46:06.615183+00
1041	Marseille_Pape M'Bow_2009.csv	Pape M'Bow	Marseille	league	2009	2022-01-29 23:46:06.615881+00
1042	Marseille_Rafidine Abdullah_2012.csv	Rafidine Abdullah	Marseille	league	2012	2022-01-29 23:46:06.616788+00
1043	Marseille_Rod Fanni_2010.csv	Rod Fanni	Marseille	league	2010	2022-01-29 23:46:06.617722+00
1044	Marseille_Rod Fanni_2011.csv	Rod Fanni	Marseille	league	2011	2022-01-29 23:46:06.618416+00
1045	Marseille_Rod Fanni_2012.csv	Rod Fanni	Marseille	league	2012	2022-01-29 23:46:06.619085+00
1046	Marseille_Souleymane Diawara_2009.csv	Souleymane Diawara	Marseille	league	2009	2022-01-29 23:46:06.619699+00
1047	Marseille_Souleymane Diawara_2010.csv	Souleymane Diawara	Marseille	league	2010	2022-01-29 23:46:06.620347+00
1048	Marseille_Souleymane Diawara_2011.csv	Souleymane Diawara	Marseille	league	2011	2022-01-29 23:46:06.621075+00
1049	Marseille_Souleymane Diawara_2012.csv	Souleymane Diawara	Marseille	league	2012	2022-01-29 23:46:06.622089+00
1050	Marseille_Steve Mandanda_2009.csv	Steve Mandanda	Marseille	league	2009	2022-01-29 23:46:06.62288+00
1051	Marseille_Steve Mandanda_2010.csv	Steve Mandanda	Marseille	league	2010	2022-01-29 23:46:06.623624+00
1052	Marseille_Steve Mandanda_2011.csv	Steve Mandanda	Marseille	league	2011	2022-01-29 23:46:06.624291+00
1053	Marseille_Steve Mandanda_2012.csv	Steve Mandanda	Marseille	league	2012	2022-01-29 23:46:06.624937+00
1054	Marseille_Stéphane Mbia_2009.csv	Stéphane Mbia	Marseille	league	2009	2022-01-29 23:46:06.625597+00
1055	Marseille_Stéphane Mbia_2010.csv	Stéphane Mbia	Marseille	league	2010	2022-01-29 23:46:06.626271+00
1056	Marseille_Stéphane Mbia_2011.csv	Stéphane Mbia	Marseille	league	2011	2022-01-29 23:46:06.626888+00
1057	Marseille_Stéphane Mbia_2012.csv	Stéphane Mbia	Marseille	league	2012	2022-01-29 23:46:06.627508+00
1058	Marseille_Taye Taiwo_2009.csv	Taye Taiwo	Marseille	league	2009	2022-01-29 23:46:06.628083+00
1059	Marseille_Taye Taiwo_2010.csv	Taye Taiwo	Marseille	league	2010	2022-01-29 23:46:06.628659+00
1060	Marseille_Vitorino Hilton_2009.csv	Vitorino Hilton	Marseille	league	2009	2022-01-29 23:46:06.629232+00
1061	Marseille_Vitorino Hilton_2010.csv	Vitorino Hilton	Marseille	league	2010	2022-01-29 23:46:06.629813+00
1062	Marseille_Wesley Jobello_2011.csv	Wesley Jobello	Marseille	league	2011	2022-01-29 23:46:06.630449+00
1063	Monaco_Adriano_2009.csv	Adriano	Monaco	league	2009	2022-01-29 23:46:06.630948+00
1064	Monaco_Adriano_2010.csv	Adriano	Monaco	league	2010	2022-01-29 23:46:06.631409+00
1065	Monaco_Alejandro Alonso_2009.csv	Alejandro Alonso	Monaco	league	2009	2022-01-29 23:46:06.632058+00
1066	Monaco_Alejandro Alonso_2010.csv	Alejandro Alonso	Monaco	league	2010	2022-01-29 23:46:06.632619+00
1067	Monaco_Benjamin Moukandjo_2010.csv	Benjamin Moukandjo	Monaco	league	2010	2022-01-29 23:46:06.633139+00
1068	Monaco_Cédric Mongongu_2009.csv	Cédric Mongongu	Monaco	league	2009	2022-01-29 23:46:06.633641+00
1069	Monaco_Cédric Mongongu_2010.csv	Cédric Mongongu	Monaco	league	2010	2022-01-29 23:46:06.634113+00
1070	Monaco_Chris Malonga_2010.csv	Chris Malonga	Monaco	league	2010	2022-01-29 23:46:06.634584+00
1071	Monaco_Daniel Niculae_2010.csv	Daniel Niculae	Monaco	league	2010	2022-01-29 23:46:06.635082+00
1072	Monaco_Diego Pérez_2009.csv	Diego Pérez	Monaco	league	2009	2022-01-29 23:46:06.635557+00
1073	Monaco_Dieumerci Mbokani_2010.csv	Dieumerci Mbokani	Monaco	league	2010	2022-01-29 23:46:06.636028+00
1074	Monaco_Djamel Bakar_2009.csv	Djamel Bakar	Monaco	league	2009	2022-01-29 23:46:06.636524+00
1075	Monaco_Djimi Traoré_2009.csv	Djimi Traoré	Monaco	league	2009	2022-01-29 23:46:06.636998+00
1076	Monaco_Djimi Traoré_2010.csv	Djimi Traoré	Monaco	league	2010	2022-01-29 23:46:06.637644+00
1077	Monaco_Eduardo Costa_2009.csv	Eduardo Costa	Monaco	league	2009	2022-01-29 23:46:06.638349+00
1078	Monaco_Eiður Guðjohnsen_2009.csv	Eiður Guðjohnsen	Monaco	league	2009	2022-01-29 23:46:06.638929+00
1079	Monaco_François Modesto_2009.csv	François Modesto	Monaco	league	2009	2022-01-29 23:46:06.639507+00
1080	Monaco_Frédéric Bulot_2010.csv	Frédéric Bulot	Monaco	league	2010	2022-01-29 23:46:06.6404+00
1081	Monaco_Frédéric Nimani_2009.csv	Frédéric Nimani	Monaco	league	2009	2022-01-29 23:46:06.641175+00
1082	Monaco_Georgie Welcome_2010.csv	Georgie Welcome	Monaco	league	2010	2022-01-29 23:46:06.641726+00
1083	Monaco_Grégory Lacombe_2010.csv	Grégory Lacombe	Monaco	league	2010	2022-01-29 23:46:06.642243+00
1084	Monaco_Igor Lolo_2009.csv	Igor Lolo	Monaco	league	2009	2022-01-29 23:46:06.642834+00
1085	Monaco_Igor Lolo_2010.csv	Igor Lolo	Monaco	league	2010	2022-01-29 23:46:06.643398+00
1086	Monaco_Jean-Jacques Gosso_2009.csv	Jean-Jacques Gosso	Monaco	league	2009	2022-01-29 23:46:06.643893+00
1087	Monaco_Jean-Jacques Gosso_2010.csv	Jean-Jacques Gosso	Monaco	league	2010	2022-01-29 23:46:06.644356+00
1088	Monaco_Jerko Leko_2009.csv	Jerko Leko	Monaco	league	2009	2022-01-29 23:46:06.644801+00
1089	Monaco_Juan Pablo Pino_2009.csv	Juan Pablo Pino	Monaco	league	2009	2022-01-29 23:46:06.645242+00
1090	Monaco_Kévin Malcuit_2010.csv	Kévin Malcuit	Monaco	league	2010	2022-01-29 23:46:06.645697+00
1091	Monaco_Laurent Bonnart_2010.csv	Laurent Bonnart	Monaco	league	2010	2022-01-29 23:46:06.646201+00
1092	Monaco_Layvin Kurzawa_2010.csv	Layvin Kurzawa	Monaco	league	2010	2022-01-29 23:46:06.646673+00
1093	Monaco_Lukman Haruna_2009.csv	Lukman Haruna	Monaco	league	2009	2022-01-29 23:46:06.647123+00
1094	Monaco_Lukman Haruna_2010.csv	Lukman Haruna	Monaco	league	2010	2022-01-29 23:46:06.647574+00
1095	Monaco_Mahamadou Diarra_2010.csv	Mahamadou Diarra	Monaco	league	2010	2022-01-29 23:46:06.648055+00
1096	Monaco_Mathieu Coutadeur_2009.csv	Mathieu Coutadeur	Monaco	league	2009	2022-01-29 23:46:06.648555+00
1097	Monaco_Mathieu Coutadeur_2010.csv	Mathieu Coutadeur	Monaco	league	2010	2022-01-29 23:46:06.64912+00
1098	Monaco_Moussa Maâzou_2009.csv	Moussa Maâzou	Monaco	league	2009	2022-01-29 23:46:06.649843+00
1099	Monaco_Moussa Maâzou_2010.csv	Moussa Maâzou	Monaco	league	2010	2022-01-29 23:46:06.650675+00
1100	Monaco_Nampalys Mendy_2010.csv	Nampalys Mendy	Monaco	league	2010	2022-01-29 23:46:06.65123+00
1101	Monaco_Nenê_2009.csv	Nenê	Monaco	league	2009	2022-01-29 23:46:06.651712+00
1102	Monaco_Nicolas Nkoulou_2009.csv	Nicolas Nkoulou	Monaco	league	2009	2022-01-29 23:46:06.65221+00
1103	Monaco_Nicolas Nkoulou_2010.csv	Nicolas Nkoulou	Monaco	league	2010	2022-01-29 23:46:06.652816+00
1104	Monaco_Park Chu-young_2009.csv	Park Chu-young	Monaco	league	2009	2022-01-29 23:46:06.653881+00
1105	Monaco_Park Chu-young_2010.csv	Park Chu-young	Monaco	league	2010	2022-01-29 23:46:06.655092+00
1106	Monaco_Pascal Feindouno_2010.csv	Pascal Feindouno	Monaco	league	2010	2022-01-29 23:46:06.656152+00
1107	Monaco_Petter Hansson_2010.csv	Petter Hansson	Monaco	league	2010	2022-01-29 23:46:06.657173+00
1108	Monaco_Pierre-Emerick Aubameyang_2010.csv	Pierre-Emerick Aubameyang	Monaco	league	2010	2022-01-29 23:46:06.658178+00
1109	Monaco_Serge Gakpé_2009.csv	Serge Gakpé	Monaco	league	2009	2022-01-29 23:46:06.659297+00
1110	Monaco_Serge Gakpé_2010.csv	Serge Gakpé	Monaco	league	2010	2022-01-29 23:46:06.6604+00
1111	Monaco_Sébastien Chabbert_2010.csv	Sébastien Chabbert	Monaco	league	2010	2022-01-29 23:46:06.661567+00
1112	Monaco_Sébastien Puygrenier_2009.csv	Sébastien Puygrenier	Monaco	league	2009	2022-01-29 23:46:06.662703+00
1113	Monaco_Sébastien Puygrenier_2010.csv	Sébastien Puygrenier	Monaco	league	2010	2022-01-29 23:46:06.663762+00
1114	Monaco_Stéphane Ruffier_2009.csv	Stéphane Ruffier	Monaco	league	2009	2022-01-29 23:46:06.665015+00
1115	Monaco_Stéphane Ruffier_2010.csv	Stéphane Ruffier	Monaco	league	2010	2022-01-29 23:46:06.665912+00
1116	Monaco_Thomas Mangani_2009.csv	Thomas Mangani	Monaco	league	2009	2022-01-29 23:46:06.666712+00
1117	Monaco_Thomas Mangani_2010.csv	Thomas Mangani	Monaco	league	2010	2022-01-29 23:46:06.667599+00
1118	Monaco_Valère Germain_2010.csv	Valère Germain	Monaco	league	2010	2022-01-29 23:46:06.668595+00
1119	Monaco_Vincent Muratori_2009.csv	Vincent Muratori	Monaco	league	2009	2022-01-29 23:46:06.669842+00
1120	Monaco_Vincent Muratori_2010.csv	Vincent Muratori	Monaco	league	2010	2022-01-29 23:46:06.671048+00
1121	Monaco_Yannick Sagbo_2009.csv	Yannick Sagbo	Monaco	league	2009	2022-01-29 23:46:06.672083+00
1122	Monaco_Yannick Sagbo_2010.csv	Yannick Sagbo	Monaco	league	2010	2022-01-29 23:46:06.672997+00
1123	Monaco_Yohan Mollo_2009.csv	Yohan Mollo	Monaco	league	2009	2022-01-29 23:46:06.673862+00
1124	Monaco_Yohann Thuram-Ulien_2009.csv	Yohann Thuram-Ulien	Monaco	league	2009	2022-01-29 23:46:06.675196+00
1125	Montpellier_Abdelhamid El Kaoutari_2009.csv	Abdelhamid El Kaoutari	Montpellier	league	2009	2022-01-29 23:46:06.676077+00
1126	Montpellier_Abdelhamid El Kaoutari_2010.csv	Abdelhamid El Kaoutari	Montpellier	league	2010	2022-01-29 23:46:06.676742+00
1127	Montpellier_Abdelhamid El Kaoutari_2011.csv	Abdelhamid El Kaoutari	Montpellier	league	2011	2022-01-29 23:46:06.677407+00
1128	Montpellier_Abdelhamid El Kaoutari_2012.csv	Abdelhamid El Kaoutari	Montpellier	league	2012	2022-01-29 23:46:06.678078+00
1129	Montpellier_Anthony Mounier_2012.csv	Anthony Mounier	Montpellier	league	2012	2022-01-29 23:46:06.678997+00
1130	Montpellier_Bengali-Fodé Koita_2009.csv	Bengali-Fodé Koita	Montpellier	league	2009	2022-01-29 23:46:06.679718+00
1131	Montpellier_Bengali-Fodé Koita_2010.csv	Bengali-Fodé Koita	Montpellier	league	2010	2022-01-29 23:46:06.680358+00
1132	Montpellier_Bengali-Fodé Koita_2011.csv	Bengali-Fodé Koita	Montpellier	league	2011	2022-01-29 23:46:06.681018+00
1133	Montpellier_Benjamin Stambouli_2010.csv	Benjamin Stambouli	Montpellier	league	2010	2022-01-29 23:46:06.681677+00
1134	Montpellier_Benjamin Stambouli_2011.csv	Benjamin Stambouli	Montpellier	league	2011	2022-01-29 23:46:06.682538+00
1135	Montpellier_Benjamin Stambouli_2012.csv	Benjamin Stambouli	Montpellier	league	2012	2022-01-29 23:46:06.683817+00
1136	Montpellier_Bryan Dabo_2009.csv	Bryan Dabo	Montpellier	league	2009	2022-01-29 23:46:06.685448+00
1137	Montpellier_Bryan Dabo_2012.csv	Bryan Dabo	Montpellier	league	2012	2022-01-29 23:46:06.68656+00
1138	Montpellier_Cyril Jeunechamp_2009.csv	Cyril Jeunechamp	Montpellier	league	2009	2022-01-29 23:46:06.687702+00
1139	Montpellier_Cyril Jeunechamp_2010.csv	Cyril Jeunechamp	Montpellier	league	2010	2022-01-29 23:46:06.688773+00
1140	Montpellier_Cyril Jeunechamp_2011.csv	Cyril Jeunechamp	Montpellier	league	2011	2022-01-29 23:46:06.689779+00
1141	Montpellier_Cyril Jeunechamp_2012.csv	Cyril Jeunechamp	Montpellier	league	2012	2022-01-29 23:46:06.691454+00
1142	Montpellier_Daniel Congré_2012.csv	Daniel Congré	Montpellier	league	2012	2022-01-29 23:46:06.692483+00
1143	Montpellier_Emanuel Herrera_2012.csv	Emanuel Herrera	Montpellier	league	2012	2022-01-29 23:46:06.693243+00
1144	Montpellier_Emir Spahić_2009.csv	Emir Spahić	Montpellier	league	2009	2022-01-29 23:46:06.693931+00
1145	Montpellier_Emir Spahić_2010.csv	Emir Spahić	Montpellier	league	2010	2022-01-29 23:46:06.694878+00
1146	Montpellier_Gaëtan Charbonnier_2012.csv	Gaëtan Charbonnier	Montpellier	league	2012	2022-01-29 23:46:06.695839+00
1147	Montpellier_Garry Bocaly_2009.csv	Garry Bocaly	Montpellier	league	2009	2022-01-29 23:46:06.696934+00
1148	Montpellier_Garry Bocaly_2010.csv	Garry Bocaly	Montpellier	league	2010	2022-01-29 23:46:06.697984+00
1149	Montpellier_Garry Bocaly_2011.csv	Garry Bocaly	Montpellier	league	2011	2022-01-29 23:46:06.69908+00
1150	Montpellier_Garry Bocaly_2012.csv	Garry Bocaly	Montpellier	league	2012	2022-01-29 23:46:06.699721+00
1151	Montpellier_Geoffrey Dernis_2009.csv	Geoffrey Dernis	Montpellier	league	2009	2022-01-29 23:46:06.70029+00
1152	Montpellier_Geoffrey Dernis_2010.csv	Geoffrey Dernis	Montpellier	league	2010	2022-01-29 23:46:06.700986+00
1153	Montpellier_Geoffrey Dernis_2011.csv	Geoffrey Dernis	Montpellier	league	2011	2022-01-29 23:46:06.701607+00
1154	Montpellier_Geoffrey Jourdren_2009.csv	Geoffrey Jourdren	Montpellier	league	2009	2022-01-29 23:46:06.702234+00
1155	Montpellier_Geoffrey Jourdren_2010.csv	Geoffrey Jourdren	Montpellier	league	2010	2022-01-29 23:46:06.702897+00
1156	Montpellier_Geoffrey Jourdren_2011.csv	Geoffrey Jourdren	Montpellier	league	2011	2022-01-29 23:46:06.703534+00
1157	Montpellier_Geoffrey Jourdren_2012.csv	Geoffrey Jourdren	Montpellier	league	2012	2022-01-29 23:46:06.704145+00
1158	Montpellier_Grégory Lacombe_2009.csv	Grégory Lacombe	Montpellier	league	2009	2022-01-29 23:46:06.704747+00
1159	Montpellier_Grégory Lacombe_2010.csv	Grégory Lacombe	Montpellier	league	2010	2022-01-29 23:46:06.70541+00
1160	Montpellier_Hasan Kabze_2010.csv	Hasan Kabze	Montpellier	league	2010	2022-01-29 23:46:06.706099+00
1161	Montpellier_Hasan Kabze_2011.csv	Hasan Kabze	Montpellier	league	2011	2022-01-29 23:46:06.706943+00
1162	Montpellier_Henri Bedimo_2011.csv	Henri Bedimo	Montpellier	league	2011	2022-01-29 23:46:06.707923+00
1163	Montpellier_Henri Bedimo_2012.csv	Henri Bedimo	Montpellier	league	2012	2022-01-29 23:46:06.709144+00
1164	Montpellier_Jamel Saihi_2009.csv	Jamel Saihi	Montpellier	league	2009	2022-01-29 23:46:06.710102+00
1165	Montpellier_Jamel Saihi_2010.csv	Jamel Saihi	Montpellier	league	2010	2022-01-29 23:46:06.71075+00
1166	Montpellier_Jamel Saihi_2011.csv	Jamel Saihi	Montpellier	league	2011	2022-01-29 23:46:06.711412+00
1167	Montpellier_Jamel Saihi_2012.csv	Jamel Saihi	Montpellier	league	2012	2022-01-29 23:46:06.712078+00
1168	Montpellier_John Utaka_2010.csv	John Utaka	Montpellier	league	2010	2022-01-29 23:46:06.712699+00
1169	Montpellier_John Utaka_2011.csv	John Utaka	Montpellier	league	2011	2022-01-29 23:46:06.713306+00
1170	Montpellier_John Utaka_2012.csv	John Utaka	Montpellier	league	2012	2022-01-29 23:46:06.713886+00
1171	Montpellier_Jonas Martin_2010.csv	Jonas Martin	Montpellier	league	2010	2022-01-29 23:46:06.714487+00
1172	Montpellier_Jonas Martin_2012.csv	Jonas Martin	Montpellier	league	2012	2022-01-29 23:46:06.715103+00
1173	Montpellier_Jonathan Ligali_2012.csv	Jonathan Ligali	Montpellier	league	2012	2022-01-29 23:46:06.715738+00
1174	Montpellier_Jonathan Tinhan_2011.csv	Jonathan Tinhan	Montpellier	league	2011	2022-01-29 23:46:06.716506+00
1175	Montpellier_Jonathan Tinhan_2012.csv	Jonathan Tinhan	Montpellier	league	2012	2022-01-29 23:46:06.717482+00
1176	Montpellier_Joris Marveaux_2009.csv	Joris Marveaux	Montpellier	league	2009	2022-01-29 23:46:06.718285+00
1177	Montpellier_Joris Marveaux_2010.csv	Joris Marveaux	Montpellier	league	2010	2022-01-29 23:46:06.718882+00
1178	Montpellier_Joris Marveaux_2011.csv	Joris Marveaux	Montpellier	league	2011	2022-01-29 23:46:06.719488+00
1179	Montpellier_Joris Marveaux_2012.csv	Joris Marveaux	Montpellier	league	2012	2022-01-29 23:46:06.720105+00
1180	Montpellier_Karim Aït-Fana_2009.csv	Karim Aït-Fana	Montpellier	league	2009	2022-01-29 23:46:06.72067+00
1181	Montpellier_Karim Aït-Fana_2010.csv	Karim Aït-Fana	Montpellier	league	2010	2022-01-29 23:46:06.721451+00
1182	Montpellier_Karim Aït-Fana_2011.csv	Karim Aït-Fana	Montpellier	league	2011	2022-01-29 23:46:06.722093+00
1183	Montpellier_Karim Aït-Fana_2012.csv	Karim Aït-Fana	Montpellier	league	2012	2022-01-29 23:46:06.722684+00
1184	Montpellier_Laurent Pionnier_2010.csv	Laurent Pionnier	Montpellier	league	2010	2022-01-29 23:46:06.723294+00
1185	Montpellier_Laurent Pionnier_2011.csv	Laurent Pionnier	Montpellier	league	2011	2022-01-29 23:46:06.723975+00
1186	Montpellier_Laurent Pionnier_2012.csv	Laurent Pionnier	Montpellier	league	2012	2022-01-29 23:46:06.724609+00
1187	Montpellier_Lilian Compan_2009.csv	Lilian Compan	Montpellier	league	2009	2022-01-29 23:46:06.725197+00
1336	Nice_Abdou Traoré_2010.csv	Abdou Traoré	Nice	league	2010	2022-01-29 23:46:06.813825+00
1188	Montpellier_Mapou Yanga-Mbiwa_2009.csv	Mapou Yanga-Mbiwa	Montpellier	league	2009	2022-01-29 23:46:06.725821+00
1189	Montpellier_Mapou Yanga-Mbiwa_2010.csv	Mapou Yanga-Mbiwa	Montpellier	league	2010	2022-01-29 23:46:06.72698+00
1190	Montpellier_Mapou Yanga-Mbiwa_2011.csv	Mapou Yanga-Mbiwa	Montpellier	league	2011	2022-01-29 23:46:06.727585+00
1191	Montpellier_Mapou Yanga-Mbiwa_2012.csv	Mapou Yanga-Mbiwa	Montpellier	league	2012	2022-01-29 23:46:06.728152+00
1192	Montpellier_Marco Estrada_2010.csv	Marco Estrada	Montpellier	league	2010	2022-01-29 23:46:06.728746+00
1193	Montpellier_Marco Estrada_2011.csv	Marco Estrada	Montpellier	league	2011	2022-01-29 23:46:06.729316+00
1194	Montpellier_Marco Estrada_2012.csv	Marco Estrada	Montpellier	league	2012	2022-01-29 23:46:06.729845+00
1195	Montpellier_Mathieu Deplagne_2012.csv	Mathieu Deplagne	Montpellier	league	2012	2022-01-29 23:46:06.730342+00
1196	Montpellier_Mourad Benhamida_2009.csv	Mourad Benhamida	Montpellier	league	2009	2022-01-29 23:46:06.730848+00
1197	Montpellier_Nenad Džodić_2009.csv	Nenad Džodić	Montpellier	league	2009	2022-01-29 23:46:06.73132+00
1198	Montpellier_Nenad Džodić_2010.csv	Nenad Džodić	Montpellier	league	2010	2022-01-29 23:46:06.7319+00
1199	Montpellier_Olivier Giroud_2010.csv	Olivier Giroud	Montpellier	league	2010	2022-01-29 23:46:06.732393+00
1200	Montpellier_Olivier Giroud_2011.csv	Olivier Giroud	Montpellier	league	2011	2022-01-29 23:46:06.732852+00
1201	Montpellier_Philippe Delaye_2009.csv	Philippe Delaye	Montpellier	league	2009	2022-01-29 23:46:06.733308+00
1202	Montpellier_Rémy Cabella_2011.csv	Rémy Cabella	Montpellier	league	2011	2022-01-29 23:46:06.733893+00
1203	Montpellier_Rémy Cabella_2012.csv	Rémy Cabella	Montpellier	league	2012	2022-01-29 23:46:06.73443+00
1204	Montpellier_Romain Armand_2010.csv	Romain Armand	Montpellier	league	2010	2022-01-29 23:46:06.734916+00
1205	Montpellier_Romain Pitau_2009.csv	Romain Pitau	Montpellier	league	2009	2022-01-29 23:46:06.735435+00
1206	Montpellier_Romain Pitau_2010.csv	Romain Pitau	Montpellier	league	2010	2022-01-29 23:46:06.735917+00
1207	Montpellier_Romain Pitau_2011.csv	Romain Pitau	Montpellier	league	2011	2022-01-29 23:46:06.73637+00
1208	Montpellier_Romain Pitau_2012.csv	Romain Pitau	Montpellier	league	2012	2022-01-29 23:46:06.736814+00
1209	Montpellier_Souleymane Camara_2009.csv	Souleymane Camara	Montpellier	league	2009	2022-01-29 23:46:06.737408+00
1210	Montpellier_Souleymane Camara_2010.csv	Souleymane Camara	Montpellier	league	2010	2022-01-29 23:46:06.738007+00
1211	Montpellier_Souleymane Camara_2011.csv	Souleymane Camara	Montpellier	league	2011	2022-01-29 23:46:06.738501+00
1212	Montpellier_Souleymane Camara_2012.csv	Souleymane Camara	Montpellier	league	2012	2022-01-29 23:46:06.739029+00
1213	Montpellier_Teddy Mézague_2012.csv	Teddy Mézague	Montpellier	league	2012	2022-01-29 23:46:06.739508+00
1214	Montpellier_Tino Costa_2009.csv	Tino Costa	Montpellier	league	2009	2022-01-29 23:46:06.740031+00
1215	Montpellier_Vitorino Hilton_2011.csv	Vitorino Hilton	Montpellier	league	2011	2022-01-29 23:46:06.740827+00
1216	Montpellier_Vitorino Hilton_2012.csv	Vitorino Hilton	Montpellier	league	2012	2022-01-29 23:46:06.741589+00
1217	Montpellier_Víctor Montaño_2009.csv	Víctor Montaño	Montpellier	league	2009	2022-01-29 23:46:06.742282+00
1218	Montpellier_Xavier Collin_2009.csv	Xavier Collin	Montpellier	league	2009	2022-01-29 23:46:06.742887+00
1219	Montpellier_Xavier Collin_2010.csv	Xavier Collin	Montpellier	league	2010	2022-01-29 23:46:06.743412+00
1220	Montpellier_Younès Belhanda_2009.csv	Younès Belhanda	Montpellier	league	2009	2022-01-29 23:46:06.743882+00
1221	Montpellier_Younès Belhanda_2010.csv	Younès Belhanda	Montpellier	league	2010	2022-01-29 23:46:06.744351+00
1222	Montpellier_Younès Belhanda_2011.csv	Younès Belhanda	Montpellier	league	2011	2022-01-29 23:46:06.744857+00
1223	Montpellier_Younès Belhanda_2012.csv	Younès Belhanda	Montpellier	league	2012	2022-01-29 23:46:06.745335+00
1224	Nancy_Aatif Chahechouhe_2009.csv	Aatif Chahechouhe	Nancy	league	2009	2022-01-29 23:46:06.745799+00
1225	Nancy_Aatif Chahechouhe_2010.csv	Aatif Chahechouhe	Nancy	league	2010	2022-01-29 23:46:06.746297+00
1226	Nancy_Abdeslam Ouaddou_2009.csv	Abdeslam Ouaddou	Nancy	league	2009	2022-01-29 23:46:06.746768+00
1227	Nancy_Alexandre Cuvillier_2010.csv	Alexandre Cuvillier	Nancy	league	2010	2022-01-29 23:46:06.747227+00
1228	Nancy_Alexandre Cuvillier_2011.csv	Alexandre Cuvillier	Nancy	league	2011	2022-01-29 23:46:06.747715+00
1229	Nancy_Alfred N'Diaye_2009.csv	Alfred N'Diaye	Nancy	league	2009	2022-01-29 23:46:06.74818+00
1230	Nancy_Alfred N'Diaye_2010.csv	Alfred N'Diaye	Nancy	league	2010	2022-01-29 23:46:06.748642+00
1231	Nancy_André Luiz_2009.csv	André Luiz	Nancy	league	2009	2022-01-29 23:46:06.749203+00
1232	Nancy_André Luiz_2010.csv	André Luiz	Nancy	league	2010	2022-01-29 23:46:06.750024+00
1233	Nancy_André Luiz_2011.csv	André Luiz	Nancy	league	2011	2022-01-29 23:46:06.750728+00
1234	Nancy_André Luiz_2012.csv	André Luiz	Nancy	league	2012	2022-01-29 23:46:06.751225+00
1235	Nancy_Bakaye Traoré_2009.csv	Bakaye Traoré	Nancy	league	2009	2022-01-29 23:46:06.7517+00
1236	Nancy_Bakaye Traoré_2010.csv	Bakaye Traoré	Nancy	league	2010	2022-01-29 23:46:06.752218+00
1237	Nancy_Bakaye Traoré_2011.csv	Bakaye Traoré	Nancy	league	2011	2022-01-29 23:46:06.752694+00
1238	Nancy_Benjamin Gavanon_2009.csv	Benjamin Gavanon	Nancy	league	2009	2022-01-29 23:46:06.753163+00
1239	Nancy_Benjamin Gavanon_2010.csv	Benjamin Gavanon	Nancy	league	2010	2022-01-29 23:46:06.75361+00
1240	Nancy_Benjamin Jeannot_2010.csv	Benjamin Jeannot	Nancy	league	2010	2022-01-29 23:46:06.754197+00
1241	Nancy_Benjamin Jeannot_2011.csv	Benjamin Jeannot	Nancy	league	2011	2022-01-29 23:46:06.754835+00
1242	Nancy_Benjamin Moukandjo_2011.csv	Benjamin Moukandjo	Nancy	league	2011	2022-01-29 23:46:06.755328+00
1243	Nancy_Benjamin Moukandjo_2012.csv	Benjamin Moukandjo	Nancy	league	2012	2022-01-29 23:46:06.755783+00
1244	Nancy_Bocundji Ca_2009.csv	Bocundji Ca	Nancy	league	2009	2022-01-29 23:46:06.756253+00
1245	Nancy_Cheick Diabaté_2009.csv	Cheick Diabaté	Nancy	league	2009	2022-01-29 23:46:06.756745+00
1246	Nancy_Chris Malonga_2009.csv	Chris Malonga	Nancy	league	2009	2022-01-29 23:46:06.757263+00
1247	Nancy_Chris Malonga_2010.csv	Chris Malonga	Nancy	league	2010	2022-01-29 23:46:06.757839+00
1248	Nancy_Damián Macaluso_2009.csv	Damián Macaluso	Nancy	league	2009	2022-01-29 23:46:06.758333+00
1249	Nancy_Damien Gregorini_2009.csv	Damien Gregorini	Nancy	league	2009	2022-01-29 23:46:06.758796+00
1250	Nancy_Damien Gregorini_2010.csv	Damien Gregorini	Nancy	league	2010	2022-01-29 23:46:06.759267+00
1251	Nancy_Damien Gregorini_2011.csv	Damien Gregorini	Nancy	league	2011	2022-01-29 23:46:06.759746+00
1252	Nancy_Damien Gregorini_2012.csv	Damien Gregorini	Nancy	league	2012	2022-01-29 23:46:06.760298+00
1253	Nancy_Daniel Niculae_2011.csv	Daniel Niculae	Nancy	league	2011	2022-01-29 23:46:06.760794+00
1254	Nancy_Distel Zola_2011.csv	Distel Zola	Nancy	league	2011	2022-01-29 23:46:06.761262+00
1255	Nancy_Djamel Bakar_2009.csv	Djamel Bakar	Nancy	league	2009	2022-01-29 23:46:06.761714+00
1256	Nancy_Djamel Bakar_2010.csv	Djamel Bakar	Nancy	league	2010	2022-01-29 23:46:06.762154+00
1257	Nancy_Djamel Bakar_2011.csv	Djamel Bakar	Nancy	league	2011	2022-01-29 23:46:06.762639+00
1258	Nancy_Djamel Bakar_2012.csv	Djamel Bakar	Nancy	league	2012	2022-01-29 23:46:06.763138+00
1259	Nancy_Florent Zitte_2012.csv	Florent Zitte	Nancy	league	2012	2022-01-29 23:46:06.76364+00
1260	Nancy_Florian Marange_2009.csv	Florian Marange	Nancy	league	2009	2022-01-29 23:46:06.764127+00
1261	Nancy_Floyd Ayité_2009.csv	Floyd Ayité	Nancy	league	2009	2022-01-29 23:46:06.764824+00
1262	Nancy_Fouad Rachid_2010.csv	Fouad Rachid	Nancy	league	2010	2022-01-29 23:46:06.765422+00
1263	Nancy_Fouad Rachid_2011.csv	Fouad Rachid	Nancy	league	2011	2022-01-29 23:46:06.765936+00
1264	Nancy_Fouad Rachid_2012.csv	Fouad Rachid	Nancy	league	2012	2022-01-29 23:46:06.76644+00
1265	Nancy_Gennaro Bracigliano_2009.csv	Gennaro Bracigliano	Nancy	league	2009	2022-01-29 23:46:06.766939+00
1266	Nancy_Gennaro Bracigliano_2010.csv	Gennaro Bracigliano	Nancy	league	2010	2022-01-29 23:46:06.767432+00
1267	Nancy_Guy N'dy Assembé_2011.csv	Guy N'dy Assembé	Nancy	league	2011	2022-01-29 23:46:06.767921+00
1268	Nancy_Guy N'dy Assembé_2012.csv	Guy N'dy Assembé	Nancy	league	2012	2022-01-29 23:46:06.768406+00
1269	Nancy_Hélder Maurílio_2011.csv	Hélder Maurílio	Nancy	league	2011	2022-01-29 23:46:06.768863+00
1270	Nancy_Hélder Maurílio_2012.csv	Hélder Maurílio	Nancy	league	2012	2022-01-29 23:46:06.769342+00
1271	Nancy_Ibrahim Amadou_2012.csv	Ibrahim Amadou	Nancy	league	2012	2022-01-29 23:46:06.769834+00
1272	Nancy_Issiar Dia_2009.csv	Issiar Dia	Nancy	league	2009	2022-01-29 23:46:06.770289+00
1273	Nancy_Jean Calvé_2011.csv	Jean Calvé	Nancy	league	2011	2022-01-29 23:46:06.771119+00
1274	Nancy_Jean-Landry Bassilekin_2012.csv	Jean-Landry Bassilekin	Nancy	league	2012	2022-01-29 23:46:06.771733+00
1275	Nancy_Jean-Michel Joachim_2012.csv	Jean-Michel Joachim	Nancy	league	2012	2022-01-29 23:46:06.772237+00
1276	Nancy_Jeff Louis_2012.csv	Jeff Louis	Nancy	league	2012	2022-01-29 23:46:06.772696+00
1277	Nancy_Joël Sami_2009.csv	Joël Sami	Nancy	league	2009	2022-01-29 23:46:06.773142+00
1278	Nancy_Joël Sami_2010.csv	Joël Sami	Nancy	league	2010	2022-01-29 23:46:06.773618+00
1279	Nancy_Joël Sami_2011.csv	Joël Sami	Nancy	league	2011	2022-01-29 23:46:06.774335+00
1280	Nancy_Joël Sami_2012.csv	Joël Sami	Nancy	league	2012	2022-01-29 23:46:06.775132+00
1281	Nancy_Jonathan Brison_2009.csv	Jonathan Brison	Nancy	league	2009	2022-01-29 23:46:06.775694+00
1282	Nancy_Jonathan Brison_2010.csv	Jonathan Brison	Nancy	league	2010	2022-01-29 23:46:06.776216+00
1283	Nancy_Jonathan Brison_2011.csv	Jonathan Brison	Nancy	league	2011	2022-01-29 23:46:06.776695+00
1284	Nancy_Jordan Lotiès_2009.csv	Jordan Lotiès	Nancy	league	2009	2022-01-29 23:46:06.77715+00
1285	Nancy_Jordan Lotiès_2010.csv	Jordan Lotiès	Nancy	league	2010	2022-01-29 23:46:06.777605+00
1286	Nancy_Jordan Lotiès_2011.csv	Jordan Lotiès	Nancy	league	2011	2022-01-29 23:46:06.778098+00
1287	Nancy_Jordan Lotiès_2012.csv	Jordan Lotiès	Nancy	league	2012	2022-01-29 23:46:06.778567+00
1288	Nancy_Julian Jeanvier_2012.csv	Julian Jeanvier	Nancy	league	2012	2022-01-29 23:46:06.779018+00
1289	Nancy_Julien Féret_2009.csv	Julien Féret	Nancy	league	2009	2022-01-29 23:46:06.779462+00
1290	Nancy_Julien Féret_2010.csv	Julien Féret	Nancy	league	2010	2022-01-29 23:46:06.7799+00
1291	Nancy_Jung Jo-gook_2011.csv	Jung Jo-gook	Nancy	league	2011	2022-01-29 23:46:06.780356+00
1292	Nancy_Karim Coulibaly_2012.csv	Karim Coulibaly	Nancy	league	2012	2022-01-29 23:46:06.780876+00
1293	Nancy_Landry N'Guémo_2010.csv	Landry N'Guémo	Nancy	league	2010	2022-01-29 23:46:06.78137+00
1294	Nancy_Lossémy Karaboué_2011.csv	Lossémy Karaboué	Nancy	league	2011	2022-01-29 23:46:06.782101+00
1295	Nancy_Lossémy Karaboué_2012.csv	Lossémy Karaboué	Nancy	league	2012	2022-01-29 23:46:06.782756+00
1296	Nancy_Marama Vahirua_2010.csv	Marama Vahirua	Nancy	league	2010	2022-01-29 23:46:06.783599+00
1297	Nancy_Massadio Haïdara_2010.csv	Massadio Haïdara	Nancy	league	2010	2022-01-29 23:46:06.784604+00
1298	Nancy_Massadio Haïdara_2011.csv	Massadio Haïdara	Nancy	league	2011	2022-01-29 23:46:06.785231+00
1299	Nancy_Massadio Haïdara_2012.csv	Massadio Haïdara	Nancy	league	2012	2022-01-29 23:46:06.785757+00
1300	Nancy_Michaël Chrétien_2009.csv	Michaël Chrétien	Nancy	league	2009	2022-01-29 23:46:06.786268+00
1301	Nancy_Michaël Chrétien_2010.csv	Michaël Chrétien	Nancy	league	2010	2022-01-29 23:46:06.786782+00
1302	Nancy_Michaël Chrétien_2011.csv	Michaël Chrétien	Nancy	league	2011	2022-01-29 23:46:06.787331+00
1303	Nancy_Moustapha Bayal Sall_2011.csv	Moustapha Bayal Sall	Nancy	league	2011	2022-01-29 23:46:06.78802+00
1304	Nancy_Pascal Berenguer_2009.csv	Pascal Berenguer	Nancy	league	2009	2022-01-29 23:46:06.788542+00
1305	Nancy_Pascal Berenguer_2010.csv	Pascal Berenguer	Nancy	league	2010	2022-01-29 23:46:06.789063+00
1306	Nancy_Pascal Berenguer_2011.csv	Pascal Berenguer	Nancy	league	2011	2022-01-29 23:46:06.789556+00
1307	Nancy_Paul Alo'o_2009.csv	Paul Alo'o	Nancy	league	2009	2022-01-29 23:46:06.790376+00
1308	Nancy_Paul Alo'o_2010.csv	Paul Alo'o	Nancy	league	2010	2022-01-29 23:46:06.791094+00
1309	Nancy_Paul Alo'o_2011.csv	Paul Alo'o	Nancy	league	2011	2022-01-29 23:46:06.792179+00
1310	Nancy_Paul Alo'o_2012.csv	Paul Alo'o	Nancy	league	2012	2022-01-29 23:46:06.792965+00
1311	Nancy_Reynald Lemaître_2009.csv	Reynald Lemaître	Nancy	league	2009	2022-01-29 23:46:06.793531+00
1312	Nancy_Reynald Lemaître_2010.csv	Reynald Lemaître	Nancy	league	2010	2022-01-29 23:46:06.794203+00
1313	Nancy_Reynald Lemaître_2011.csv	Reynald Lemaître	Nancy	league	2011	2022-01-29 23:46:06.794892+00
1314	Nancy_Romain Grange_2012.csv	Romain Grange	Nancy	league	2012	2022-01-29 23:46:06.795674+00
1315	Nancy_Salif Sané_2011.csv	Salif Sané	Nancy	league	2011	2022-01-29 23:46:06.796634+00
1316	Nancy_Salif Sané_2012.csv	Salif Sané	Nancy	league	2012	2022-01-29 23:46:06.797585+00
1317	Nancy_Samba Diakité_2009.csv	Samba Diakité	Nancy	league	2009	2022-01-29 23:46:06.798547+00
1318	Nancy_Samba Diakité_2010.csv	Samba Diakité	Nancy	league	2010	2022-01-29 23:46:06.799528+00
1319	Nancy_Samba Diakité_2011.csv	Samba Diakité	Nancy	league	2011	2022-01-29 23:46:06.800354+00
1320	Nancy_Sébastien Puygrenier_2011.csv	Sébastien Puygrenier	Nancy	league	2011	2022-01-29 23:46:06.801149+00
1321	Nancy_Sébastien Puygrenier_2012.csv	Sébastien Puygrenier	Nancy	league	2012	2022-01-29 23:46:06.801827+00
1322	Nancy_Simon Zenke_2012.csv	Simon Zenke	Nancy	league	2012	2022-01-29 23:46:06.802488+00
1323	Nancy_Thomas Ayasse_2012.csv	Thomas Ayasse	Nancy	league	2012	2022-01-29 23:46:06.803163+00
1324	Nancy_Thomas Mangani_2011.csv	Thomas Mangani	Nancy	league	2011	2022-01-29 23:46:06.803926+00
1325	Nancy_Thomas Mangani_2012.csv	Thomas Mangani	Nancy	league	2012	2022-01-29 23:46:06.804787+00
1326	Nancy_Vincent Muratori_2012.csv	Vincent Muratori	Nancy	league	2012	2022-01-29 23:46:06.805449+00
1327	Nancy_Yassine Jebbour_2012.csv	Yassine Jebbour	Nancy	league	2012	2022-01-29 23:46:06.806192+00
1328	Nancy_Yohan Mollo_2011.csv	Yohan Mollo	Nancy	league	2011	2022-01-29 23:46:06.807147+00
1329	Nancy_Yohan Mollo_2012.csv	Yohan Mollo	Nancy	league	2012	2022-01-29 23:46:06.808433+00
1330	Nancy_Youssouf Hadji_2009.csv	Youssouf Hadji	Nancy	league	2009	2022-01-29 23:46:06.809541+00
1331	Nancy_Youssouf Hadji_2010.csv	Youssouf Hadji	Nancy	league	2010	2022-01-29 23:46:06.810443+00
1332	Nancy_Youssouf Hadji_2011.csv	Youssouf Hadji	Nancy	league	2011	2022-01-29 23:46:06.811159+00
1333	Nancy_Ziri Hammar_2010.csv	Ziri Hammar	Nancy	league	2010	2022-01-29 23:46:06.811808+00
1334	Nancy_Ziri Hammar_2011.csv	Ziri Hammar	Nancy	league	2011	2022-01-29 23:46:06.812435+00
1337	Nice_Abeiku Quansah_2009.csv	Abeiku Quansah	Nice	league	2009	2022-01-29 23:46:06.814769+00
1338	Nice_Abeiku Quansah_2010.csv	Abeiku Quansah	Nice	league	2010	2022-01-29 23:46:06.815906+00
1339	Nice_Abraham Gneki Guié_2011.csv	Abraham Gneki Guié	Nice	league	2011	2022-01-29 23:46:06.816745+00
1340	Nice_Abraham Gneki Guié_2012.csv	Abraham Gneki Guié	Nice	league	2012	2022-01-29 23:46:06.817749+00
1341	Nice_Adeílson_2010.csv	Adeílson	Nice	league	2010	2022-01-29 23:46:06.818579+00
1342	Nice_Alain Cantareil_2009.csv	Alain Cantareil	Nice	league	2009	2022-01-29 23:46:06.81926+00
1343	Nice_Alain Cantareil_2010.csv	Alain Cantareil	Nice	league	2010	2022-01-29 23:46:06.819858+00
1344	Nice_Albert Rafetraniaina_2012.csv	Albert Rafetraniaina	Nice	league	2012	2022-01-29 23:46:06.82051+00
1345	Nice_Alexy Bosetti_2011.csv	Alexy Bosetti	Nice	league	2011	2022-01-29 23:46:06.82135+00
1346	Nice_Alexy Bosetti_2012.csv	Alexy Bosetti	Nice	league	2012	2022-01-29 23:46:06.822386+00
1347	Nice_Anthony Mounier_2009.csv	Anthony Mounier	Nice	league	2009	2022-01-29 23:46:06.823548+00
1348	Nice_Anthony Mounier_2010.csv	Anthony Mounier	Nice	league	2010	2022-01-29 23:46:06.824483+00
1349	Nice_Anthony Mounier_2011.csv	Anthony Mounier	Nice	league	2011	2022-01-29 23:46:06.825407+00
1350	Nice_Camel Meriem_2011.csv	Camel Meriem	Nice	league	2011	2022-01-29 23:46:06.826142+00
1351	Nice_Camel Meriem_2012.csv	Camel Meriem	Nice	league	2012	2022-01-29 23:46:06.826788+00
1352	Nice_Chaouki Ben Saada_2009.csv	Chaouki Ben Saada	Nice	league	2009	2022-01-29 23:46:06.827457+00
1353	Nice_Chaouki Ben Saada_2010.csv	Chaouki Ben Saada	Nice	league	2010	2022-01-29 23:46:06.828138+00
1354	Nice_Cyril Hennion_2010.csv	Cyril Hennion	Nice	league	2010	2022-01-29 23:46:06.828806+00
1355	Nice_Cyril Hennion_2011.csv	Cyril Hennion	Nice	league	2011	2022-01-29 23:46:06.829412+00
1356	Nice_Danijel Ljuboja_2010.csv	Danijel Ljuboja	Nice	league	2010	2022-01-29 23:46:06.830145+00
1357	Nice_Darío Cvitanich_2012.csv	Darío Cvitanich	Nice	league	2012	2022-01-29 23:46:06.830993+00
1358	Nice_David Bellion_2010.csv	David Bellion	Nice	league	2010	2022-01-29 23:46:06.831683+00
1359	Nice_David Hellebuyck_2009.csv	David Hellebuyck	Nice	league	2009	2022-01-29 23:46:06.832337+00
1360	Nice_David Hellebuyck_2010.csv	David Hellebuyck	Nice	league	2010	2022-01-29 23:46:06.83301+00
1361	Nice_David Hellebuyck_2011.csv	David Hellebuyck	Nice	league	2011	2022-01-29 23:46:06.833639+00
1362	Nice_David Ospina_2009.csv	David Ospina	Nice	league	2009	2022-01-29 23:46:06.834276+00
1363	Nice_David Ospina_2010.csv	David Ospina	Nice	league	2010	2022-01-29 23:46:06.834884+00
1364	Nice_David Ospina_2011.csv	David Ospina	Nice	league	2011	2022-01-29 23:46:06.835551+00
1365	Nice_David Ospina_2012.csv	David Ospina	Nice	league	2012	2022-01-29 23:46:06.836188+00
1366	Nice_Diacko Fofana_2011.csv	Diacko Fofana	Nice	league	2011	2022-01-29 23:46:06.836768+00
1367	Nice_Diacko Fofana_2012.csv	Diacko Fofana	Nice	league	2012	2022-01-29 23:46:06.838062+00
1368	Nice_Didier Digard_2009.csv	Didier Digard	Nice	league	2009	2022-01-29 23:46:06.838945+00
1369	Nice_Didier Digard_2010.csv	Didier Digard	Nice	league	2010	2022-01-29 23:46:06.839633+00
1370	Nice_Didier Digard_2011.csv	Didier Digard	Nice	league	2011	2022-01-29 23:46:06.840324+00
1371	Nice_Didier Digard_2012.csv	Didier Digard	Nice	league	2012	2022-01-29 23:46:06.84135+00
1372	Nice_Drissa Diakité_2009.csv	Drissa Diakité	Nice	league	2009	2022-01-29 23:46:06.842235+00
1373	Nice_Drissa Diakité_2010.csv	Drissa Diakité	Nice	league	2010	2022-01-29 23:46:06.842929+00
1374	Nice_Drissa Diakité_2011.csv	Drissa Diakité	Nice	league	2011	2022-01-29 23:46:06.843596+00
1375	Nice_Elliot Grandin_2011.csv	Elliot Grandin	Nice	league	2011	2022-01-29 23:46:06.844255+00
1376	Nice_Emerse Faé_2009.csv	Emerse Faé	Nice	league	2009	2022-01-29 23:46:06.844879+00
1377	Nice_Emerse Faé_2010.csv	Emerse Faé	Nice	league	2010	2022-01-29 23:46:06.845713+00
1378	Nice_Emerse Faé_2011.csv	Emerse Faé	Nice	league	2011	2022-01-29 23:46:06.846668+00
1379	Nice_Esmaël Gonçalves_2010.csv	Esmaël Gonçalves	Nice	league	2010	2022-01-29 23:46:06.847419+00
1380	Nice_Esmaël Gonçalves_2011.csv	Esmaël Gonçalves	Nice	league	2011	2022-01-29 23:46:06.848102+00
1381	Nice_Éric Bauthéac_2012.csv	Éric Bauthéac	Nice	league	2012	2022-01-29 23:46:06.848798+00
1382	Nice_Éric Mouloungui_2009.csv	Éric Mouloungui	Nice	league	2009	2022-01-29 23:46:06.849516+00
1383	Nice_Éric Mouloungui_2010.csv	Éric Mouloungui	Nice	league	2010	2022-01-29 23:46:06.850396+00
1384	Nice_Éric Mouloungui_2011.csv	Éric Mouloungui	Nice	league	2011	2022-01-29 23:46:06.851124+00
1385	Nice_Fabián Monzón_2011.csv	Fabián Monzón	Nice	league	2011	2022-01-29 23:46:06.851744+00
1386	Nice_Fabián Monzón_2012.csv	Fabián Monzón	Nice	league	2012	2022-01-29 23:46:06.852372+00
1387	Nice_Fabien Dao Castellana_2012.csv	Fabien Dao Castellana	Nice	league	2012	2022-01-29 23:46:06.852993+00
1388	Nice_Fabrice Abriel_2011.csv	Fabrice Abriel	Nice	league	2011	2022-01-29 23:46:06.853697+00
1389	Nice_Fabrice Abriel_2012.csv	Fabrice Abriel	Nice	league	2012	2022-01-29 23:46:06.854596+00
1390	Nice_Franck Dja Djédjé_2011.csv	Franck Dja Djédjé	Nice	league	2011	2022-01-29 23:46:06.855431+00
1391	Nice_Franck Dja Djédjé_2012.csv	Franck Dja Djédjé	Nice	league	2012	2022-01-29 23:46:06.85608+00
1392	Nice_François Clerc_2010.csv	François Clerc	Nice	league	2010	2022-01-29 23:46:06.856917+00
1393	Nice_François Clerc_2011.csv	François Clerc	Nice	league	2011	2022-01-29 23:46:06.857885+00
1394	Nice_Gérald Cid_2009.csv	Gérald Cid	Nice	league	2009	2022-01-29 23:46:06.858671+00
1395	Nice_Grégoire Puel_2012.csv	Grégoire Puel	Nice	league	2012	2022-01-29 23:46:06.859243+00
1396	Nice_Grégory Paisley_2009.csv	Grégory Paisley	Nice	league	2009	2022-01-29 23:46:06.859831+00
1397	Nice_Grégory Paisley_2010.csv	Grégory Paisley	Nice	league	2010	2022-01-29 23:46:06.860402+00
1398	Nice_Habib Bamogo_2009.csv	Habib Bamogo	Nice	league	2009	2022-01-29 23:46:06.860959+00
1399	Nice_Habib Bamogo_2010.csv	Habib Bamogo	Nice	league	2010	2022-01-29 23:46:06.861501+00
1400	Nice_Ismaël Gace_2009.csv	Ismaël Gace	Nice	league	2009	2022-01-29 23:46:06.862245+00
1401	Nice_Ismaël Gace_2010.csv	Ismaël Gace	Nice	league	2010	2022-01-29 23:46:06.863102+00
1402	Nice_Jérémy Pied_2012.csv	Jérémy Pied	Nice	league	2012	2022-01-29 23:46:06.863749+00
1403	Nice_Joris Delle_2012.csv	Joris Delle	Nice	league	2012	2022-01-29 23:46:06.864301+00
1404	Nice_Julien Berthomier_2009.csv	Julien Berthomier	Nice	league	2009	2022-01-29 23:46:06.864873+00
1405	Nice_Julien Sablé_2009.csv	Julien Sablé	Nice	league	2009	2022-01-29 23:46:06.865485+00
1406	Nice_Julien Sablé_2010.csv	Julien Sablé	Nice	league	2010	2022-01-29 23:46:06.866023+00
1407	Nice_Julien Sablé_2011.csv	Julien Sablé	Nice	league	2011	2022-01-29 23:46:06.866561+00
1408	Nice_Kafoumba Coulibaly_2009.csv	Kafoumba Coulibaly	Nice	league	2009	2022-01-29 23:46:06.867122+00
1409	Nice_Kafoumba Coulibaly_2010.csv	Kafoumba Coulibaly	Nice	league	2010	2022-01-29 23:46:06.867627+00
1410	Nice_Kafoumba Coulibaly_2011.csv	Kafoumba Coulibaly	Nice	league	2011	2022-01-29 23:46:06.86809+00
1411	Nice_Kafoumba Coulibaly_2012.csv	Kafoumba Coulibaly	Nice	league	2012	2022-01-29 23:46:06.868537+00
1412	Nice_Kévin Anin_2011.csv	Kévin Anin	Nice	league	2011	2022-01-29 23:46:06.869012+00
1413	Nice_Kévin Anin_2012.csv	Kévin Anin	Nice	league	2012	2022-01-29 23:46:06.86957+00
1414	Nice_Kévin Diaz_2012.csv	Kévin Diaz	Nice	league	2012	2022-01-29 23:46:06.870441+00
1415	Nice_Kévin Gomis_2011.csv	Kévin Gomis	Nice	league	2011	2022-01-29 23:46:06.871149+00
1416	Nice_Kévin Gomis_2012.csv	Kévin Gomis	Nice	league	2012	2022-01-29 23:46:06.871861+00
1417	Nice_Kévin Malaga_2010.csv	Kévin Malaga	Nice	league	2010	2022-01-29 23:46:06.872397+00
1418	Nice_Kévin Malaga_2011.csv	Kévin Malaga	Nice	league	2011	2022-01-29 23:46:06.87292+00
1419	Nice_Larrys Mabiala_2009.csv	Larrys Mabiala	Nice	league	2009	2022-01-29 23:46:06.873391+00
1420	Nice_Larrys Mabiala_2010.csv	Larrys Mabiala	Nice	league	2010	2022-01-29 23:46:06.874112+00
1421	Nice_Larrys Mabiala_2011.csv	Larrys Mabiala	Nice	league	2011	2022-01-29 23:46:06.875196+00
1422	Nice_Lionel Letizi_2009.csv	Lionel Letizi	Nice	league	2009	2022-01-29 23:46:06.875974+00
1423	Nice_Lionel Letizi_2010.csv	Lionel Letizi	Nice	league	2010	2022-01-29 23:46:06.876501+00
1424	Nice_Lloyd Palun_2010.csv	Lloyd Palun	Nice	league	2010	2022-01-29 23:46:06.877003+00
1425	Nice_Lloyd Palun_2011.csv	Lloyd Palun	Nice	league	2011	2022-01-29 23:46:06.877709+00
1426	Nice_Lloyd Palun_2012.csv	Lloyd Palun	Nice	league	2012	2022-01-29 23:46:06.878563+00
1427	Nice_Loïc Rémy_2009.csv	Loïc Rémy	Nice	league	2009	2022-01-29 23:46:06.879181+00
1428	Nice_Loïc Rémy_2010.csv	Loïc Rémy	Nice	league	2010	2022-01-29 23:46:06.879697+00
1429	Nice_Lucas Rougeaux_2012.csv	Lucas Rougeaux	Nice	league	2012	2022-01-29 23:46:06.880173+00
1430	Nice_Luigi Bruins_2012.csv	Luigi Bruins	Nice	league	2012	2022-01-29 23:46:06.880619+00
1431	Nice_Mahamane Traoré_2009.csv	Mahamane Traoré	Nice	league	2009	2022-01-29 23:46:06.881062+00
1432	Nice_Mahamane Traoré_2012.csv	Mahamane Traoré	Nice	league	2012	2022-01-29 23:46:06.881508+00
1433	Nice_Mamadou Bagayoko_2009.csv	Mamadou Bagayoko	Nice	league	2009	2022-01-29 23:46:06.881953+00
1434	Nice_Mamadou Bagayoko_2010.csv	Mamadou Bagayoko	Nice	league	2010	2022-01-29 23:46:06.882496+00
1435	Nice_Mickaël Poté_2009.csv	Mickaël Poté	Nice	league	2009	2022-01-29 23:46:06.883157+00
1436	Nice_Mickaël Poté_2010.csv	Mickaël Poté	Nice	league	2010	2022-01-29 23:46:06.883838+00
1437	Nice_Mickaël Poté_2011.csv	Mickaël Poté	Nice	league	2011	2022-01-29 23:46:06.884377+00
1438	Nice_Neal Maupay_2012.csv	Neal Maupay	Nice	league	2012	2022-01-29 23:46:06.88492+00
1439	Nice_Nemanja Pejčinović_2010.csv	Nemanja Pejčinović	Nice	league	2010	2022-01-29 23:46:06.885529+00
1440	Nice_Nemanja Pejčinović_2011.csv	Nemanja Pejčinović	Nice	league	2011	2022-01-29 23:46:06.886346+00
1441	Nice_Nemanja Pejčinović_2012.csv	Nemanja Pejčinović	Nice	league	2012	2022-01-29 23:46:06.886968+00
1442	Nice_Olivier Echouafni_2009.csv	Olivier Echouafni	Nice	league	2009	2022-01-29 23:46:06.887489+00
1443	Nice_Onyekachi Apam_2009.csv	Onyekachi Apam	Nice	league	2009	2022-01-29 23:46:06.888092+00
1444	Nice_Raúl Fernández_2011.csv	Raúl Fernández	Nice	league	2011	2022-01-29 23:46:06.888784+00
1445	Nice_Renato Civelli_2009.csv	Renato Civelli	Nice	league	2009	2022-01-29 23:46:06.889322+00
1446	Nice_Renato Civelli_2010.csv	Renato Civelli	Nice	league	2010	2022-01-29 23:46:06.889789+00
1447	Nice_Renato Civelli_2011.csv	Renato Civelli	Nice	league	2011	2022-01-29 23:46:06.890641+00
1448	Nice_Renato Civelli_2012.csv	Renato Civelli	Nice	league	2012	2022-01-29 23:46:06.891312+00
1449	Nice_Romain Genevois_2012.csv	Romain Genevois	Nice	league	2012	2022-01-29 23:46:06.891812+00
1450	Nice_Stéphane Bahoken_2010.csv	Stéphane Bahoken	Nice	league	2010	2022-01-29 23:46:06.892271+00
1451	Nice_Stéphane Bahoken_2011.csv	Stéphane Bahoken	Nice	league	2011	2022-01-29 23:46:06.892718+00
1452	Nice_Stéphane Bahoken_2012.csv	Stéphane Bahoken	Nice	league	2012	2022-01-29 23:46:06.893304+00
1453	Nice_Timothée Kolodziejczak_2012.csv	Timothée Kolodziejczak	Nice	league	2012	2022-01-29 23:46:06.894083+00
1454	Nice_Valentin Eysseric_2012.csv	Valentin Eysseric	Nice	league	2012	2022-01-29 23:46:06.894866+00
1455	Nice_Xavier Pentecôte_2011.csv	Xavier Pentecôte	Nice	league	2011	2022-01-29 23:46:06.895383+00
1456	Nice_Xavier Pentecôte_2012.csv	Xavier Pentecôte	Nice	league	2012	2022-01-29 23:46:06.895843+00
1457	Paris S-G_Adrien Rabiot_2012.csv	Adrien Rabiot	Paris S-G	league	2012	2022-01-29 23:46:06.896289+00
1458	Paris S-G_Alex_2011.csv	Alex	Paris S-G	league	2011	2022-01-29 23:46:06.896735+00
1459	Paris S-G_Alex_2012.csv	Alex	Paris S-G	league	2012	2022-01-29 23:46:06.897174+00
1460	Paris S-G_Alphonse Areola_2012.csv	Alphonse Areola	Paris S-G	league	2012	2022-01-29 23:46:06.89764+00
1461	Paris S-G_Antoine Conte_2012.csv	Antoine Conte	Paris S-G	league	2012	2022-01-29 23:46:06.898073+00
1462	Paris S-G_Apoula Edel_2009.csv	Apoula Edel	Paris S-G	league	2009	2022-01-29 23:46:06.898704+00
1463	Paris S-G_Apoula Edel_2010.csv	Apoula Edel	Paris S-G	league	2010	2022-01-29 23:46:06.899211+00
1464	Paris S-G_Blaise Matuidi_2011.csv	Blaise Matuidi	Paris S-G	league	2011	2022-01-29 23:46:06.899699+00
1465	Paris S-G_Blaise Matuidi_2012.csv	Blaise Matuidi	Paris S-G	league	2012	2022-01-29 23:46:06.900151+00
1466	Paris S-G_Ceará_2009.csv	Ceará	Paris S-G	league	2009	2022-01-29 23:46:06.900594+00
1467	Paris S-G_Ceará_2010.csv	Ceará	Paris S-G	league	2010	2022-01-29 23:46:06.901111+00
1468	Paris S-G_Ceará_2011.csv	Ceará	Paris S-G	league	2011	2022-01-29 23:46:06.901678+00
1469	Paris S-G_Christophe Jallet_2009.csv	Christophe Jallet	Paris S-G	league	2009	2022-01-29 23:46:06.902476+00
1470	Paris S-G_Christophe Jallet_2010.csv	Christophe Jallet	Paris S-G	league	2010	2022-01-29 23:46:06.903066+00
1471	Paris S-G_Christophe Jallet_2011.csv	Christophe Jallet	Paris S-G	league	2011	2022-01-29 23:46:06.903564+00
1472	Paris S-G_Christophe Jallet_2012.csv	Christophe Jallet	Paris S-G	league	2012	2022-01-29 23:46:06.90406+00
1473	Paris S-G_Claude Makélélé_2009.csv	Claude Makélélé	Paris S-G	league	2009	2022-01-29 23:46:06.904566+00
1474	Paris S-G_Claude Makélélé_2010.csv	Claude Makélélé	Paris S-G	league	2010	2022-01-29 23:46:06.905173+00
1475	Paris S-G_Clément Chantôme_2009.csv	Clément Chantôme	Paris S-G	league	2009	2022-01-29 23:46:06.905746+00
1476	Paris S-G_Clément Chantôme_2010.csv	Clément Chantôme	Paris S-G	league	2010	2022-01-29 23:46:06.906248+00
1477	Paris S-G_Clément Chantôme_2011.csv	Clément Chantôme	Paris S-G	league	2011	2022-01-29 23:46:06.906779+00
1478	Paris S-G_Clément Chantôme_2012.csv	Clément Chantôme	Paris S-G	league	2012	2022-01-29 23:46:06.907524+00
1479	Paris S-G_David Beckham_2012.csv	David Beckham	Paris S-G	league	2012	2022-01-29 23:46:06.908026+00
1480	Paris S-G_Diego Lugano_2011.csv	Diego Lugano	Paris S-G	league	2011	2022-01-29 23:46:06.908494+00
1481	Paris S-G_Ezequiel Lavezzi_2012.csv	Ezequiel Lavezzi	Paris S-G	league	2012	2022-01-29 23:46:06.90904+00
1482	Paris S-G_Granddi Ngoyi_2009.csv	Granddi Ngoyi	Paris S-G	league	2009	2022-01-29 23:46:06.909785+00
1483	Paris S-G_Gregory van der Wiel_2012.csv	Gregory van der Wiel	Paris S-G	league	2012	2022-01-29 23:46:06.910821+00
1484	Paris S-G_Grégory Bourillon_2009.csv	Grégory Bourillon	Paris S-G	league	2009	2022-01-29 23:46:06.91171+00
1485	Paris S-G_Grégory Coupet_2009.csv	Grégory Coupet	Paris S-G	league	2009	2022-01-29 23:46:06.91225+00
1486	Paris S-G_Grégory Coupet_2010.csv	Grégory Coupet	Paris S-G	league	2010	2022-01-29 23:46:06.912731+00
1487	Paris S-G_Guillaume Hoarau_2009.csv	Guillaume Hoarau	Paris S-G	league	2009	2022-01-29 23:46:06.91318+00
1488	Paris S-G_Guillaume Hoarau_2010.csv	Guillaume Hoarau	Paris S-G	league	2010	2022-01-29 23:46:06.913682+00
1489	Paris S-G_Guillaume Hoarau_2011.csv	Guillaume Hoarau	Paris S-G	league	2011	2022-01-29 23:46:06.914151+00
1490	Paris S-G_Guillaume Hoarau_2012.csv	Guillaume Hoarau	Paris S-G	league	2012	2022-01-29 23:46:06.91498+00
1491	Paris S-G_Javier Pastore_2011.csv	Javier Pastore	Paris S-G	league	2011	2022-01-29 23:46:06.915461+00
1492	Paris S-G_Javier Pastore_2012.csv	Javier Pastore	Paris S-G	league	2012	2022-01-29 23:46:06.915923+00
1493	Paris S-G_Jean-Christophe Bahebeck_2010.csv	Jean-Christophe Bahebeck	Paris S-G	league	2010	2022-01-29 23:46:06.916417+00
1494	Paris S-G_Jean-Christophe Bahebeck_2011.csv	Jean-Christophe Bahebeck	Paris S-G	league	2011	2022-01-29 23:46:06.916917+00
1495	Paris S-G_Jean-Eudes Maurice_2009.csv	Jean-Eudes Maurice	Paris S-G	league	2009	2022-01-29 23:46:06.917611+00
1496	Paris S-G_Jean-Eudes Maurice_2010.csv	Jean-Eudes Maurice	Paris S-G	league	2010	2022-01-29 23:46:06.918388+00
1497	Paris S-G_Jean-Eudes Maurice_2011.csv	Jean-Eudes Maurice	Paris S-G	league	2011	2022-01-29 23:46:06.918937+00
1498	Paris S-G_Jérémy Clément_2009.csv	Jérémy Clément	Paris S-G	league	2009	2022-01-29 23:46:06.919431+00
1499	Paris S-G_Jérémy Clément_2010.csv	Jérémy Clément	Paris S-G	league	2010	2022-01-29 23:46:06.919939+00
1500	Paris S-G_Jérémy Ménez_2011.csv	Jérémy Ménez	Paris S-G	league	2011	2022-01-29 23:46:06.920461+00
1501	Paris S-G_Jérémy Ménez_2012.csv	Jérémy Ménez	Paris S-G	league	2012	2022-01-29 23:46:06.920946+00
1502	Paris S-G_Kévin Gameiro_2011.csv	Kévin Gameiro	Paris S-G	league	2011	2022-01-29 23:46:06.921574+00
1503	Paris S-G_Kévin Gameiro_2012.csv	Kévin Gameiro	Paris S-G	league	2012	2022-01-29 23:46:06.922233+00
1504	Paris S-G_Kingsley Coman_2012.csv	Kingsley Coman	Paris S-G	league	2012	2022-01-29 23:46:06.922765+00
1505	Paris S-G_Loïck Landre_2010.csv	Loïck Landre	Paris S-G	league	2010	2022-01-29 23:46:06.923222+00
1506	Paris S-G_Lucas Moura_2012.csv	Lucas Moura	Paris S-G	league	2012	2022-01-29 23:46:06.923717+00
1507	Paris S-G_Ludovic Giuly_2009.csv	Ludovic Giuly	Paris S-G	league	2009	2022-01-29 23:46:06.9254+00
1508	Paris S-G_Ludovic Giuly_2010.csv	Ludovic Giuly	Paris S-G	league	2010	2022-01-29 23:46:06.926474+00
1509	Paris S-G_Mamadou Sakho_2009.csv	Mamadou Sakho	Paris S-G	league	2009	2022-01-29 23:46:06.92727+00
1510	Paris S-G_Mamadou Sakho_2010.csv	Mamadou Sakho	Paris S-G	league	2010	2022-01-29 23:46:06.928147+00
1511	Paris S-G_Mamadou Sakho_2011.csv	Mamadou Sakho	Paris S-G	league	2011	2022-01-29 23:46:06.929202+00
1512	Paris S-G_Mamadou Sakho_2012.csv	Mamadou Sakho	Paris S-G	league	2012	2022-01-29 23:46:06.930097+00
1513	Paris S-G_Marco Verratti_2012.csv	Marco Verratti	Paris S-G	league	2012	2022-01-29 23:46:06.930901+00
1514	Paris S-G_Mateja Kežman_2009.csv	Mateja Kežman	Paris S-G	league	2009	2022-01-29 23:46:06.931639+00
1515	Paris S-G_Mateja Kežman_2010.csv	Mateja Kežman	Paris S-G	league	2010	2022-01-29 23:46:06.932514+00
1516	Paris S-G_Mathieu Bodmer_2010.csv	Mathieu Bodmer	Paris S-G	league	2010	2022-01-29 23:46:06.933552+00
1517	Paris S-G_Mathieu Bodmer_2011.csv	Mathieu Bodmer	Paris S-G	league	2011	2022-01-29 23:46:06.934607+00
1518	Paris S-G_Mathieu Bodmer_2012.csv	Mathieu Bodmer	Paris S-G	league	2012	2022-01-29 23:46:06.935446+00
1519	Paris S-G_Maxwell_2011.csv	Maxwell	Paris S-G	league	2011	2022-01-29 23:46:06.936514+00
1520	Paris S-G_Maxwell_2012.csv	Maxwell	Paris S-G	league	2012	2022-01-29 23:46:06.937509+00
1521	Paris S-G_Mevlüt Erdinç_2009.csv	Mevlüt Erdinç	Paris S-G	league	2009	2022-01-29 23:46:06.938505+00
1522	Paris S-G_Mevlüt Erdinç_2010.csv	Mevlüt Erdinç	Paris S-G	league	2010	2022-01-29 23:46:06.939394+00
1523	Paris S-G_Mevlüt Erdinç_2011.csv	Mevlüt Erdinç	Paris S-G	league	2011	2022-01-29 23:46:06.940597+00
1524	Paris S-G_Milan Biševac_2011.csv	Milan Biševac	Paris S-G	league	2011	2022-01-29 23:46:06.942328+00
1525	Paris S-G_Mohamed Sissoko_2011.csv	Mohamed Sissoko	Paris S-G	league	2011	2022-01-29 23:46:06.943218+00
1526	Paris S-G_Mohamed Sissoko_2012.csv	Mohamed Sissoko	Paris S-G	league	2012	2022-01-29 23:46:06.944109+00
1527	Paris S-G_Neeskens Kebano_2010.csv	Neeskens Kebano	Paris S-G	league	2010	2022-01-29 23:46:06.944942+00
1528	Paris S-G_Nenê_2010.csv	Nenê	Paris S-G	league	2010	2022-01-29 23:46:06.945824+00
1529	Paris S-G_Nenê_2011.csv	Nenê	Paris S-G	league	2011	2022-01-29 23:46:06.946897+00
1530	Paris S-G_Nenê_2012.csv	Nenê	Paris S-G	league	2012	2022-01-29 23:46:06.947855+00
1531	Paris S-G_Nicolas Douchez_2012.csv	Nicolas Douchez	Paris S-G	league	2012	2022-01-29 23:46:06.948864+00
1532	Paris S-G_Péguy Luyindula_2009.csv	Péguy Luyindula	Paris S-G	league	2009	2022-01-29 23:46:06.949691+00
1533	Paris S-G_Péguy Luyindula_2010.csv	Péguy Luyindula	Paris S-G	league	2010	2022-01-29 23:46:06.950635+00
1534	Paris S-G_Ronan Le Crom_2012.csv	Ronan Le Crom	Paris S-G	league	2012	2022-01-29 23:46:06.951359+00
1535	Paris S-G_Salvatore Sirigu_2011.csv	Salvatore Sirigu	Paris S-G	league	2011	2022-01-29 23:46:06.951985+00
1536	Paris S-G_Salvatore Sirigu_2012.csv	Salvatore Sirigu	Paris S-G	league	2012	2022-01-29 23:46:06.952691+00
1537	Paris S-G_Sammy Traoré_2009.csv	Sammy Traoré	Paris S-G	league	2009	2022-01-29 23:46:06.953401+00
1538	Paris S-G_Sammy Traoré_2010.csv	Sammy Traoré	Paris S-G	league	2010	2022-01-29 23:46:06.95414+00
1539	Paris S-G_Siaka Tiéné_2010.csv	Siaka Tiéné	Paris S-G	league	2010	2022-01-29 23:46:06.955007+00
1540	Paris S-G_Siaka Tiéné_2011.csv	Siaka Tiéné	Paris S-G	league	2011	2022-01-29 23:46:06.95572+00
1541	Paris S-G_Siaka Tiéné_2012.csv	Siaka Tiéné	Paris S-G	league	2012	2022-01-29 23:46:06.956363+00
1542	Paris S-G_Stéphane Sessègnon_2009.csv	Stéphane Sessègnon	Paris S-G	league	2009	2022-01-29 23:46:06.958091+00
1543	Paris S-G_Stéphane Sessègnon_2010.csv	Stéphane Sessègnon	Paris S-G	league	2010	2022-01-29 23:46:06.959574+00
1544	Paris S-G_Sylvain Armand_2009.csv	Sylvain Armand	Paris S-G	league	2009	2022-01-29 23:46:06.960433+00
1545	Paris S-G_Sylvain Armand_2010.csv	Sylvain Armand	Paris S-G	league	2010	2022-01-29 23:46:06.961218+00
1546	Paris S-G_Sylvain Armand_2011.csv	Sylvain Armand	Paris S-G	league	2011	2022-01-29 23:46:06.961882+00
1547	Paris S-G_Sylvain Armand_2012.csv	Sylvain Armand	Paris S-G	league	2012	2022-01-29 23:46:06.962504+00
1548	Paris S-G_Thiago Motta_2011.csv	Thiago Motta	Paris S-G	league	2011	2022-01-29 23:46:06.963114+00
1549	Paris S-G_Thiago Motta_2012.csv	Thiago Motta	Paris S-G	league	2012	2022-01-29 23:46:06.963733+00
1550	Paris S-G_Thiago Silva_2012.csv	Thiago Silva	Paris S-G	league	2012	2022-01-29 23:46:06.964345+00
1551	Paris S-G_Tripy Makonda_2009.csv	Tripy Makonda	Paris S-G	league	2009	2022-01-29 23:46:06.965124+00
1552	Paris S-G_Tripy Makonda_2010.csv	Tripy Makonda	Paris S-G	league	2010	2022-01-29 23:46:06.966003+00
1553	Paris S-G_Younousse Sankharé_2009.csv	Younousse Sankharé	Paris S-G	league	2009	2022-01-29 23:46:06.966951+00
1554	Paris S-G_Zlatan Ibrahimović_2012.csv	Zlatan Ibrahimović	Paris S-G	league	2012	2022-01-29 23:46:06.967881+00
1555	Paris S-G_Zoumana Camara_2009.csv	Zoumana Camara	Paris S-G	league	2009	2022-01-29 23:46:06.968898+00
1556	Paris S-G_Zoumana Camara_2010.csv	Zoumana Camara	Paris S-G	league	2010	2022-01-29 23:46:06.969665+00
1557	Paris S-G_Zoumana Camara_2011.csv	Zoumana Camara	Paris S-G	league	2011	2022-01-29 23:46:06.970356+00
1558	Paris S-G_Zoumana Camara_2012.csv	Zoumana Camara	Paris S-G	league	2012	2022-01-29 23:46:06.97102+00
1559	Reims_Aïssa Mandi_2012.csv	Aïssa Mandi	Reims	league	2012	2022-01-29 23:46:06.971803+00
1560	Reims_Alexi Peuget_2012.csv	Alexi Peuget	Reims	league	2012	2022-01-29 23:46:06.972573+00
1561	Reims_Anthony Weber_2012.csv	Anthony Weber	Reims	league	2012	2022-01-29 23:46:06.973277+00
1562	Reims_Antoine Devaux_2012.csv	Antoine Devaux	Reims	league	2012	2022-01-29 23:46:06.974537+00
1563	Reims_Bilal Ouali_2012.csv	Bilal Ouali	Reims	league	2012	2022-01-29 23:46:06.975499+00
1564	Reims_Bocundji Ca_2012.csv	Bocundji Ca	Reims	league	2012	2022-01-29 23:46:06.976135+00
1565	Reims_Christopher Glombard_2012.csv	Christopher Glombard	Reims	league	2012	2022-01-29 23:46:06.976756+00
1566	Reims_Diego_2012.csv	Diego	Reims	league	2012	2022-01-29 23:46:06.977327+00
1567	Reims_Florent Ghisolfi_2012.csv	Florent Ghisolfi	Reims	league	2012	2022-01-29 23:46:06.977934+00
1568	Reims_Floyd Ayité_2012.csv	Floyd Ayité	Reims	league	2012	2022-01-29 23:46:06.978528+00
1569	Reims_Franck Signorino_2012.csv	Franck Signorino	Reims	league	2012	2022-01-29 23:46:06.979109+00
1570	Reims_Gaëtan Courtet_2012.csv	Gaëtan Courtet	Reims	league	2012	2022-01-29 23:46:06.979684+00
1571	Reims_Grzegorz Krychowiak_2012.csv	Grzegorz Krychowiak	Reims	league	2012	2022-01-29 23:46:06.980263+00
1572	Reims_Johan Liébus_2012.csv	Johan Liébus	Reims	league	2012	2022-01-29 23:46:06.980772+00
1573	Reims_Johann Ramaré_2012.csv	Johann Ramaré	Reims	league	2012	2022-01-29 23:46:06.981371+00
1574	Reims_Johny Placide_2012.csv	Johny Placide	Reims	league	2012	2022-01-29 23:46:06.982354+00
1575	Reims_Julien Toudic_2012.csv	Julien Toudic	Reims	league	2012	2022-01-29 23:46:06.983061+00
1576	Reims_Kamel Ghilas_2012.csv	Kamel Ghilas	Reims	league	2012	2022-01-29 23:46:06.983625+00
1577	Reims_Khalid Sekkat_2012.csv	Khalid Sekkat	Reims	league	2012	2022-01-29 23:46:06.984152+00
1578	Reims_Kossi Agassa_2012.csv	Kossi Agassa	Reims	league	2012	2022-01-29 23:46:06.984679+00
1579	Reims_Mickaël Tacalfred_2012.csv	Mickaël Tacalfred	Reims	league	2012	2022-01-29 23:46:06.985152+00
1580	Reims_Mohamed Fofana_2012.csv	Mohamed Fofana	Reims	league	2012	2022-01-29 23:46:06.985605+00
1581	Reims_Nicolas Fauvergue_2012.csv	Nicolas Fauvergue	Reims	league	2012	2022-01-29 23:46:06.986045+00
1582	Reims_Nicolas de Préville_2012.csv	Nicolas de Préville	Reims	league	2012	2022-01-29 23:46:06.986481+00
1583	Reims_Odaïr Fortes_2012.csv	Odaïr Fortes	Reims	league	2012	2022-01-29 23:46:06.98692+00
1584	Reims_Pape Souaré_2012.csv	Pape Souaré	Reims	league	2012	2022-01-29 23:46:06.987386+00
1585	Rennes_Abdoul Camara_2010.csv	Abdoul Camara	Rennes	league	2010	2022-01-29 23:46:06.988032+00
1586	Rennes_Abdoul Camara_2011.csv	Abdoul Camara	Rennes	league	2011	2022-01-29 23:46:06.988693+00
1587	Rennes_Abdoulaye Diallo_2009.csv	Abdoulaye Diallo	Rennes	league	2009	2022-01-29 23:46:06.989482+00
1588	Rennes_Abdoulaye Diallo_2011.csv	Abdoulaye Diallo	Rennes	league	2011	2022-01-29 23:46:06.990426+00
1589	Rennes_Abdoulaye Doucouré_2012.csv	Abdoulaye Doucouré	Rennes	league	2012	2022-01-29 23:46:06.991489+00
1590	Rennes_Abdoulaye Sané_2012.csv	Abdoulaye Sané	Rennes	league	2012	2022-01-29 23:46:06.99251+00
1591	Rennes_Alexander Tettey_2009.csv	Alexander Tettey	Rennes	league	2009	2022-01-29 23:46:06.993312+00
1592	Rennes_Alexander Tettey_2010.csv	Alexander Tettey	Rennes	league	2010	2022-01-29 23:46:06.994201+00
1593	Rennes_Alexander Tettey_2011.csv	Alexander Tettey	Rennes	league	2011	2022-01-29 23:46:06.994903+00
1594	Rennes_Alou Diarra_2012.csv	Alou Diarra	Rennes	league	2012	2022-01-29 23:46:06.995573+00
1595	Rennes_Anders Konradsen_2012.csv	Anders Konradsen	Rennes	league	2012	2022-01-29 23:46:06.996427+00
1596	Rennes_Asamoah Gyan_2009.csv	Asamoah Gyan	Rennes	league	2009	2022-01-29 23:46:06.997395+00
1597	Rennes_Asamoah Gyan_2010.csv	Asamoah Gyan	Rennes	league	2010	2022-01-29 23:46:06.998317+00
1598	Rennes_Axel Ngando_2012.csv	Axel Ngando	Rennes	league	2012	2022-01-29 23:46:06.999035+00
1599	Rennes_Benoît Costil_2011.csv	Benoît Costil	Rennes	league	2011	2022-01-29 23:46:06.999853+00
1600	Rennes_Benoît Costil_2012.csv	Benoît Costil	Rennes	league	2012	2022-01-29 23:46:07.000832+00
1601	Rennes_Bruno Cheyrou_2009.csv	Bruno Cheyrou	Rennes	league	2009	2022-01-29 23:46:07.00171+00
1602	Rennes_Carlos Bocanegra_2009.csv	Carlos Bocanegra	Rennes	league	2009	2022-01-29 23:46:07.00265+00
1603	Rennes_Cheick Fantamady Diarra_2011.csv	Cheick Fantamady Diarra	Rennes	league	2011	2022-01-29 23:46:07.003487+00
1604	Rennes_Cheick Fantamady Diarra_2012.csv	Cheick Fantamady Diarra	Rennes	league	2012	2022-01-29 23:46:07.004576+00
1605	Rennes_Cheick N'Diaye_2012.csv	Cheick N'Diaye	Rennes	league	2012	2022-01-29 23:46:07.006206+00
1606	Rennes_Chris Mavinga_2011.csv	Chris Mavinga	Rennes	league	2011	2022-01-29 23:46:07.007263+00
1607	Rennes_Chris Mavinga_2012.csv	Chris Mavinga	Rennes	league	2012	2022-01-29 23:46:07.008228+00
1608	Rennes_Dimitri Foulquier_2011.csv	Dimitri Foulquier	Rennes	league	2011	2022-01-29 23:46:07.008992+00
1609	Rennes_Dimitri Foulquier_2012.csv	Dimitri Foulquier	Rennes	league	2012	2022-01-29 23:46:07.009856+00
1610	Rennes_Ejike Uzoenyi_2012.csv	Ejike Uzoenyi	Rennes	league	2012	2022-01-29 23:46:07.01091+00
1611	Rennes_Fabien Lemoine_2009.csv	Fabien Lemoine	Rennes	league	2009	2022-01-29 23:46:07.01185+00
1612	Rennes_Fabien Lemoine_2010.csv	Fabien Lemoine	Rennes	league	2010	2022-01-29 23:46:07.012844+00
1613	Rennes_Franck Julienne_2010.csv	Franck Julienne	Rennes	league	2010	2022-01-29 23:46:07.013678+00
1614	Rennes_Georges Mandjeck_2010.csv	Georges Mandjeck	Rennes	league	2010	2022-01-29 23:46:07.014357+00
1615	Rennes_Georges Mandjeck_2011.csv	Georges Mandjeck	Rennes	league	2011	2022-01-29 23:46:07.014984+00
1616	Rennes_Hérita Ilunga_2012.csv	Hérita Ilunga	Rennes	league	2012	2022-01-29 23:46:07.015989+00
1617	Rennes_Ismaël Bangoura_2009.csv	Ismaël Bangoura	Rennes	league	2009	2022-01-29 23:46:07.017554+00
1618	Rennes_Ismaël Bangoura_2010.csv	Ismaël Bangoura	Rennes	league	2010	2022-01-29 23:46:07.018686+00
1619	Rennes_Jean Makoun_2012.csv	Jean Makoun	Rennes	league	2012	2022-01-29 23:46:07.019868+00
1620	Rennes_Jean-Armel Kana-Biyik_2010.csv	Jean-Armel Kana-Biyik	Rennes	league	2010	2022-01-29 23:46:07.020792+00
1621	Rennes_Jean-Armel Kana-Biyik_2011.csv	Jean-Armel Kana-Biyik	Rennes	league	2011	2022-01-29 23:46:07.023073+00
1622	Rennes_Jean-Armel Kana-Biyik_2012.csv	Jean-Armel Kana-Biyik	Rennes	league	2012	2022-01-29 23:46:07.024148+00
1623	Rennes_Jérôme Leroy_2009.csv	Jérôme Leroy	Rennes	league	2009	2022-01-29 23:46:07.025364+00
1624	Rennes_Jérôme Leroy_2010.csv	Jérôme Leroy	Rennes	league	2010	2022-01-29 23:46:07.026154+00
1625	Rennes_Jimmy Briand_2009.csv	Jimmy Briand	Rennes	league	2009	2022-01-29 23:46:07.026863+00
1626	Rennes_Jirès Kembo Ekoko_2009.csv	Jirès Kembo Ekoko	Rennes	league	2009	2022-01-29 23:46:07.027588+00
1627	Rennes_Jirès Kembo Ekoko_2010.csv	Jirès Kembo Ekoko	Rennes	league	2010	2022-01-29 23:46:07.02844+00
1628	Rennes_Jirès Kembo Ekoko_2011.csv	Jirès Kembo Ekoko	Rennes	league	2011	2022-01-29 23:46:07.029502+00
1629	Rennes_Jirès Kembo Ekoko_2012.csv	Jirès Kembo Ekoko	Rennes	league	2012	2022-01-29 23:46:07.030544+00
1630	Rennes_Johann Carrasso_2010.csv	Johann Carrasso	Rennes	league	2010	2022-01-29 23:46:07.031575+00
1631	Rennes_John Boye_2010.csv	John Boye	Rennes	league	2010	2022-01-29 23:46:07.032452+00
1632	Rennes_John Boye_2011.csv	John Boye	Rennes	league	2011	2022-01-29 23:46:07.033154+00
1633	Rennes_John Boye_2012.csv	John Boye	Rennes	league	2012	2022-01-29 23:46:07.033997+00
1634	Rennes_John Mensah_2012.csv	John Mensah	Rennes	league	2012	2022-01-29 23:46:07.035009+00
1635	Rennes_John Verhoek_2010.csv	John Verhoek	Rennes	league	2010	2022-01-29 23:46:07.036254+00
1636	Rennes_Jonathan Pitroipa_2011.csv	Jonathan Pitroipa	Rennes	league	2011	2022-01-29 23:46:07.036976+00
1637	Rennes_Jonathan Pitroipa_2012.csv	Jonathan Pitroipa	Rennes	league	2012	2022-01-29 23:46:07.037745+00
1638	Rennes_Julien Féret_2011.csv	Julien Féret	Rennes	league	2011	2022-01-29 23:46:07.038709+00
1639	Rennes_Julien Féret_2012.csv	Julien Féret	Rennes	league	2012	2022-01-29 23:46:07.039604+00
1640	Rennes_Junichi Inamoto_2009.csv	Junichi Inamoto	Rennes	league	2009	2022-01-29 23:46:07.04088+00
1641	Rennes_Kader Mangane_2009.csv	Kader Mangane	Rennes	league	2009	2022-01-29 23:46:07.041825+00
1642	Rennes_Kader Mangane_2010.csv	Kader Mangane	Rennes	league	2010	2022-01-29 23:46:07.042732+00
1643	Rennes_Kader Mangane_2011.csv	Kader Mangane	Rennes	league	2011	2022-01-29 23:46:07.043523+00
1644	Rennes_Kévin Beauverger_2012.csv	Kévin Beauverger	Rennes	league	2012	2022-01-29 23:46:07.044443+00
1645	Rennes_Kévin Théophile-Catherine_2009.csv	Kévin Théophile-Catherine	Rennes	league	2009	2022-01-29 23:46:07.045339+00
1646	Rennes_Kévin Théophile-Catherine_2010.csv	Kévin Théophile-Catherine	Rennes	league	2010	2022-01-29 23:46:07.046411+00
1647	Rennes_Kévin Théophile-Catherine_2011.csv	Kévin Théophile-Catherine	Rennes	league	2011	2022-01-29 23:46:07.047382+00
1648	Rennes_Kévin Théophile-Catherine_2012.csv	Kévin Théophile-Catherine	Rennes	league	2012	2022-01-29 23:46:07.048391+00
1649	Rennes_Lucien Aubey_2009.csv	Lucien Aubey	Rennes	league	2009	2022-01-29 23:46:07.049287+00
1650	Rennes_Mevlüt Erdinç_2011.csv	Mevlüt Erdinç	Rennes	league	2011	2022-01-29 23:46:07.050117+00
1651	Rennes_Mevlüt Erdinç_2012.csv	Mevlüt Erdinç	Rennes	league	2012	2022-01-29 23:46:07.050988+00
1652	Rennes_Mickaël Pagis_2009.csv	Mickaël Pagis	Rennes	league	2009	2022-01-29 23:46:07.051765+00
1653	Rennes_Moussa Sow_2009.csv	Moussa Sow	Rennes	league	2009	2022-01-29 23:46:07.052559+00
1654	Rennes_Nicolas Douchez_2009.csv	Nicolas Douchez	Rennes	league	2009	2022-01-29 23:46:07.053435+00
1655	Rennes_Nicolas Douchez_2010.csv	Nicolas Douchez	Rennes	league	2010	2022-01-29 23:46:07.054273+00
1656	Rennes_Olivier Thomert_2009.csv	Olivier Thomert	Rennes	league	2009	2022-01-29 23:46:07.055198+00
1657	Rennes_Onyekachi Apam_2011.csv	Onyekachi Apam	Rennes	league	2011	2022-01-29 23:46:07.056083+00
1658	Rennes_Onyekachi Apam_2012.csv	Onyekachi Apam	Rennes	league	2012	2022-01-29 23:46:07.057011+00
1659	Rennes_Petter Hansson_2009.csv	Petter Hansson	Rennes	league	2009	2022-01-29 23:46:07.058154+00
1660	Rennes_Razak Boukari_2010.csv	Razak Boukari	Rennes	league	2010	2022-01-29 23:46:07.059411+00
1661	Rennes_Razak Boukari_2011.csv	Razak Boukari	Rennes	league	2011	2022-01-29 23:46:07.060287+00
1662	Rennes_Rod Fanni_2009.csv	Rod Fanni	Rennes	league	2009	2022-01-29 23:46:07.061023+00
1663	Rennes_Rod Fanni_2010.csv	Rod Fanni	Rennes	league	2010	2022-01-29 23:46:07.06174+00
1664	Rennes_Romain Alessandrini_2012.csv	Romain Alessandrini	Rennes	league	2012	2022-01-29 23:46:07.062554+00
1665	Rennes_Romain Danzé_2009.csv	Romain Danzé	Rennes	league	2009	2022-01-29 23:46:07.063674+00
1666	Rennes_Romain Danzé_2010.csv	Romain Danzé	Rennes	league	2010	2022-01-29 23:46:07.064624+00
1667	Rennes_Romain Danzé_2011.csv	Romain Danzé	Rennes	league	2011	2022-01-29 23:46:07.065586+00
1668	Rennes_Romain Danzé_2012.csv	Romain Danzé	Rennes	league	2012	2022-01-29 23:46:07.066473+00
1669	Rennes_Sadio Diallo_2012.csv	Sadio Diallo	Rennes	league	2012	2022-01-29 23:46:07.067448+00
1670	Rennes_Samuel Souprayen_2010.csv	Samuel Souprayen	Rennes	league	2010	2022-01-29 23:46:07.068503+00
1671	Rennes_Steven Moreira_2012.csv	Steven Moreira	Rennes	league	2012	2022-01-29 23:46:07.069547+00
1672	Rennes_Stéphane Dalmat_2010.csv	Stéphane Dalmat	Rennes	league	2010	2022-01-29 23:46:07.070583+00
1673	Rennes_Stéphane Dalmat_2011.csv	Stéphane Dalmat	Rennes	league	2011	2022-01-29 23:46:07.071247+00
1674	Rennes_Sylvain Marveaux_2009.csv	Sylvain Marveaux	Rennes	league	2009	2022-01-29 23:46:07.071981+00
1675	Rennes_Sylvain Marveaux_2010.csv	Sylvain Marveaux	Rennes	league	2010	2022-01-29 23:46:07.072654+00
1676	Rennes_Tongo Doumbia_2009.csv	Tongo Doumbia	Rennes	league	2009	2022-01-29 23:46:07.073277+00
1677	Rennes_Tongo Doumbia_2010.csv	Tongo Doumbia	Rennes	league	2010	2022-01-29 23:46:07.073882+00
1678	Rennes_Tongo Doumbia_2011.csv	Tongo Doumbia	Rennes	league	2011	2022-01-29 23:46:07.075106+00
1679	Rennes_Vincent Pajot_2011.csv	Vincent Pajot	Rennes	league	2011	2022-01-29 23:46:07.075743+00
1680	Rennes_Vincent Pajot_2012.csv	Vincent Pajot	Rennes	league	2012	2022-01-29 23:46:07.076347+00
1681	Rennes_Víctor Montaño_2010.csv	Víctor Montaño	Rennes	league	2010	2022-01-29 23:46:07.077028+00
1682	Rennes_Víctor Montaño_2011.csv	Víctor Montaño	Rennes	league	2011	2022-01-29 23:46:07.077711+00
1683	Rennes_Víctor Montaño_2012.csv	Víctor Montaño	Rennes	league	2012	2022-01-29 23:46:07.078334+00
1684	Rennes_Yacine Brahimi_2010.csv	Yacine Brahimi	Rennes	league	2010	2022-01-29 23:46:07.078949+00
1685	Rennes_Yacine Brahimi_2011.csv	Yacine Brahimi	Rennes	league	2011	2022-01-29 23:46:07.079576+00
1686	Rennes_Yann M'Vila_2009.csv	Yann M'Vila	Rennes	league	2009	2022-01-29 23:46:07.080163+00
1687	Rennes_Yann M'Vila_2010.csv	Yann M'Vila	Rennes	league	2010	2022-01-29 23:46:07.080737+00
1688	Rennes_Yann M'Vila_2011.csv	Yann M'Vila	Rennes	league	2011	2022-01-29 23:46:07.08135+00
1689	Rennes_Yann M'Vila_2012.csv	Yann M'Vila	Rennes	league	2012	2022-01-29 23:46:07.082139+00
1690	Rennes_Yassine Jebbour_2010.csv	Yassine Jebbour	Rennes	league	2010	2022-01-29 23:46:07.082761+00
1691	Rennes_Yassine Jebbour_2011.csv	Yassine Jebbour	Rennes	league	2011	2022-01-29 23:46:07.083431+00
1692	Rennes_Yassine Jebbour_2012.csv	Yassine Jebbour	Rennes	league	2012	2022-01-29 23:46:07.084134+00
1693	Rennes_Youssouf Hadji_2011.csv	Youssouf Hadji	Rennes	league	2011	2022-01-29 23:46:07.084953+00
1694	Saint-Étienne_Albin Ebondo_2010.csv	Albin Ebondo	Saint-Étienne	league	2010	2022-01-29 23:46:07.086222+00
1695	Saint-Étienne_Albin Ebondo_2011.csv	Albin Ebondo	Saint-Étienne	league	2011	2022-01-29 23:46:07.086979+00
1696	Saint-Étienne_Alejandro Alonso_2010.csv	Alejandro Alonso	Saint-Étienne	league	2010	2022-01-29 23:46:07.088525+00
1697	Saint-Étienne_Alejandro Alonso_2011.csv	Alejandro Alonso	Saint-Étienne	league	2011	2022-01-29 23:46:07.08955+00
1698	Saint-Étienne_Alejandro Alonso_2012.csv	Alejandro Alonso	Saint-Étienne	league	2012	2022-01-29 23:46:07.091282+00
1699	Saint-Étienne_Augusto Fernández_2009.csv	Augusto Fernández	Saint-Étienne	league	2009	2022-01-29 23:46:07.092556+00
1700	Saint-Étienne_Bakary Sako_2009.csv	Bakary Sako	Saint-Étienne	league	2009	2022-01-29 23:46:07.093498+00
1701	Saint-Étienne_Bakary Sako_2010.csv	Bakary Sako	Saint-Étienne	league	2010	2022-01-29 23:46:07.094436+00
1702	Saint-Étienne_Bakary Sako_2011.csv	Bakary Sako	Saint-Étienne	league	2011	2022-01-29 23:46:07.09531+00
1703	Saint-Étienne_Bakary Sako_2012.csv	Bakary Sako	Saint-Étienne	league	2012	2022-01-29 23:46:07.096344+00
1704	Saint-Étienne_Bănel Nicoliță_2011.csv	Bănel Nicoliță	Saint-Étienne	league	2011	2022-01-29 23:46:07.097323+00
1705	Saint-Étienne_Bănel Nicoliță_2012.csv	Bănel Nicoliță	Saint-Étienne	league	2012	2022-01-29 23:46:07.09827+00
1706	Saint-Étienne_Blaise Matuidi_2009.csv	Blaise Matuidi	Saint-Étienne	league	2009	2022-01-29 23:46:07.099198+00
1707	Saint-Étienne_Blaise Matuidi_2010.csv	Blaise Matuidi	Saint-Étienne	league	2010	2022-01-29 23:46:07.100827+00
1708	Saint-Étienne_Boubacar Mansaly_2009.csv	Boubacar Mansaly	Saint-Étienne	league	2009	2022-01-29 23:46:07.102067+00
1709	Saint-Étienne_Boubacar Sanogo_2009.csv	Boubacar Sanogo	Saint-Étienne	league	2009	2022-01-29 23:46:07.103342+00
1710	Saint-Étienne_Boubacar Sanogo_2010.csv	Boubacar Sanogo	Saint-Étienne	league	2010	2022-01-29 23:46:07.104215+00
1711	Saint-Étienne_Brandão_2012.csv	Brandão	Saint-Étienne	league	2012	2022-01-29 23:46:07.105223+00
1712	Saint-Étienne_Carlos Bocanegra_2010.csv	Carlos Bocanegra	Saint-Étienne	league	2010	2022-01-29 23:46:07.106097+00
1713	Saint-Étienne_Carlos Bocanegra_2011.csv	Carlos Bocanegra	Saint-Étienne	league	2011	2022-01-29 23:46:07.107079+00
1714	Saint-Étienne_Cédric Varrault_2009.csv	Cédric Varrault	Saint-Étienne	league	2009	2022-01-29 23:46:07.107978+00
1715	Saint-Étienne_Christophe Landrin_2009.csv	Christophe Landrin	Saint-Étienne	league	2009	2022-01-29 23:46:07.108764+00
1716	Saint-Étienne_Christophe Landrin_2010.csv	Christophe Landrin	Saint-Étienne	league	2010	2022-01-29 23:46:07.109512+00
1717	Saint-Étienne_Danijel Aleksić_2011.csv	Danijel Aleksić	Saint-Étienne	league	2011	2022-01-29 23:46:07.110187+00
1718	Saint-Étienne_Danijel Aleksić_2012.csv	Danijel Aleksić	Saint-Étienne	league	2012	2022-01-29 23:46:07.110897+00
1719	Saint-Étienne_David Gigliotti_2009.csv	David Gigliotti	Saint-Étienne	league	2009	2022-01-29 23:46:07.111567+00
1720	Saint-Étienne_Dimitri Payet_2009.csv	Dimitri Payet	Saint-Étienne	league	2009	2022-01-29 23:46:07.112175+00
1721	Saint-Étienne_Dimitri Payet_2010.csv	Dimitri Payet	Saint-Étienne	league	2010	2022-01-29 23:46:07.112838+00
1722	Saint-Étienne_Emmanuel Rivière_2009.csv	Emmanuel Rivière	Saint-Étienne	league	2009	2022-01-29 23:46:07.113475+00
1723	Saint-Étienne_Emmanuel Rivière_2010.csv	Emmanuel Rivière	Saint-Étienne	league	2010	2022-01-29 23:46:07.114107+00
1724	Saint-Étienne_Fabien Lemoine_2011.csv	Fabien Lemoine	Saint-Étienne	league	2011	2022-01-29 23:46:07.114745+00
1725	Saint-Étienne_Fabien Lemoine_2012.csv	Fabien Lemoine	Saint-Étienne	league	2012	2022-01-29 23:46:07.115572+00
1726	Saint-Étienne_Faouzi Ghoulam_2010.csv	Faouzi Ghoulam	Saint-Étienne	league	2010	2022-01-29 23:46:07.116262+00
1727	Saint-Étienne_Faouzi Ghoulam_2011.csv	Faouzi Ghoulam	Saint-Étienne	league	2011	2022-01-29 23:46:07.117228+00
1728	Saint-Étienne_Faouzi Ghoulam_2012.csv	Faouzi Ghoulam	Saint-Étienne	league	2012	2022-01-29 23:46:07.118358+00
1729	Saint-Étienne_Florent Sinama Pongolle_2011.csv	Florent Sinama Pongolle	Saint-Étienne	league	2011	2022-01-29 23:46:07.119073+00
1730	Saint-Étienne_François Clerc_2012.csv	François Clerc	Saint-Étienne	league	2012	2022-01-29 23:46:07.119719+00
1731	Saint-Étienne_Gelson Fernandes_2009.csv	Gelson Fernandes	Saint-Étienne	league	2009	2022-01-29 23:46:07.120356+00
1732	Saint-Étienne_Gonzalo Bergessio_2009.csv	Gonzalo Bergessio	Saint-Étienne	league	2009	2022-01-29 23:46:07.121574+00
1733	Saint-Étienne_Gonzalo Bergessio_2010.csv	Gonzalo Bergessio	Saint-Étienne	league	2010	2022-01-29 23:46:07.122258+00
1734	Saint-Étienne_Gonzalo Bergessio_2011.csv	Gonzalo Bergessio	Saint-Étienne	league	2011	2022-01-29 23:46:07.123178+00
1735	Saint-Étienne_Guirane N'Daw_2009.csv	Guirane N'Daw	Saint-Étienne	league	2009	2022-01-29 23:46:07.126021+00
1736	Saint-Étienne_Guirane N'Daw_2010.csv	Guirane N'Daw	Saint-Étienne	league	2010	2022-01-29 23:46:07.127197+00
1737	Saint-Étienne_Helton Dos Reis_2009.csv	Helton Dos Reis	Saint-Étienne	league	2009	2022-01-29 23:46:07.127978+00
1738	Saint-Étienne_Idriss Saadi_2010.csv	Idriss Saadi	Saint-Étienne	league	2010	2022-01-29 23:46:07.128629+00
1739	Saint-Étienne_Idriss Saadi_2011.csv	Idriss Saadi	Saint-Étienne	league	2011	2022-01-29 23:46:07.129247+00
1740	Saint-Étienne_Idriss Saadi_2012.csv	Idriss Saadi	Saint-Étienne	league	2012	2022-01-29 23:46:07.129874+00
1741	Saint-Étienne_Ilan_2009.csv	Ilan	Saint-Étienne	league	2009	2022-01-29 23:46:07.130495+00
1742	Saint-Étienne_Ismaël Diomandé_2011.csv	Ismaël Diomandé	Saint-Étienne	league	2011	2022-01-29 23:46:07.131137+00
1743	Saint-Étienne_Ismaël Diomandé_2012.csv	Ismaël Diomandé	Saint-Étienne	league	2012	2022-01-29 23:46:07.131924+00
1744	Saint-Étienne_Jean-Pascal Mignot_2011.csv	Jean-Pascal Mignot	Saint-Étienne	league	2011	2022-01-29 23:46:07.133188+00
1745	Saint-Étienne_Jean-Pascal Mignot_2012.csv	Jean-Pascal Mignot	Saint-Étienne	league	2012	2022-01-29 23:46:07.134118+00
1746	Saint-Étienne_Jessy Moulin_2010.csv	Jessy Moulin	Saint-Étienne	league	2010	2022-01-29 23:46:07.135198+00
1747	Saint-Étienne_Jérémie Janot_2009.csv	Jérémie Janot	Saint-Étienne	league	2009	2022-01-29 23:46:07.13592+00
1748	Saint-Étienne_Jérémie Janot_2010.csv	Jérémie Janot	Saint-Étienne	league	2010	2022-01-29 23:46:07.136568+00
1749	Saint-Étienne_Jérémy Clément_2011.csv	Jérémy Clément	Saint-Étienne	league	2011	2022-01-29 23:46:07.137204+00
1750	Saint-Étienne_Jérémy Clément_2012.csv	Jérémy Clément	Saint-Étienne	league	2012	2022-01-29 23:46:07.138444+00
1751	Saint-Étienne_Jonathan Brison_2011.csv	Jonathan Brison	Saint-Étienne	league	2011	2022-01-29 23:46:07.139149+00
1752	Saint-Étienne_Jonathan Brison_2012.csv	Jonathan Brison	Saint-Étienne	league	2012	2022-01-29 23:46:07.139799+00
1753	Saint-Étienne_Josuha Guilavogui_2009.csv	Josuha Guilavogui	Saint-Étienne	league	2009	2022-01-29 23:46:07.141355+00
1754	Saint-Étienne_Josuha Guilavogui_2010.csv	Josuha Guilavogui	Saint-Étienne	league	2010	2022-01-29 23:46:07.142304+00
1755	Saint-Étienne_Josuha Guilavogui_2011.csv	Josuha Guilavogui	Saint-Étienne	league	2011	2022-01-29 23:46:07.143057+00
1756	Saint-Étienne_Josuha Guilavogui_2012.csv	Josuha Guilavogui	Saint-Étienne	league	2012	2022-01-29 23:46:07.14382+00
1757	Saint-Étienne_Kevin Mirallas_2009.csv	Kevin Mirallas	Saint-Étienne	league	2009	2022-01-29 23:46:07.144759+00
1758	Saint-Étienne_Kévin Mayi_2011.csv	Kévin Mayi	Saint-Étienne	league	2011	2022-01-29 23:46:07.145818+00
1759	Saint-Étienne_Kévin Mayi_2012.csv	Kévin Mayi	Saint-Étienne	league	2012	2022-01-29 23:46:07.146769+00
1760	Saint-Étienne_Kurt Zouma_2011.csv	Kurt Zouma	Saint-Étienne	league	2011	2022-01-29 23:46:07.147686+00
1761	Saint-Étienne_Kurt Zouma_2012.csv	Kurt Zouma	Saint-Étienne	league	2012	2022-01-29 23:46:07.148622+00
1762	Saint-Étienne_Laurent Batlles_2010.csv	Laurent Batlles	Saint-Étienne	league	2010	2022-01-29 23:46:07.14952+00
1763	Saint-Étienne_Laurent Batlles_2011.csv	Laurent Batlles	Saint-Étienne	league	2011	2022-01-29 23:46:07.150235+00
1764	Saint-Étienne_Loïc Perrin_2009.csv	Loïc Perrin	Saint-Étienne	league	2009	2022-01-29 23:46:07.150921+00
1765	Saint-Étienne_Loïc Perrin_2010.csv	Loïc Perrin	Saint-Étienne	league	2010	2022-01-29 23:46:07.151853+00
1766	Saint-Étienne_Loïc Perrin_2011.csv	Loïc Perrin	Saint-Étienne	league	2011	2022-01-29 23:46:07.152748+00
1767	Saint-Étienne_Loïc Perrin_2012.csv	Loïc Perrin	Saint-Étienne	league	2012	2022-01-29 23:46:07.153702+00
1768	Saint-Étienne_Loris Néry_2010.csv	Loris Néry	Saint-Étienne	league	2010	2022-01-29 23:46:07.154758+00
1769	Saint-Étienne_Loris Néry_2011.csv	Loris Néry	Saint-Étienne	league	2011	2022-01-29 23:46:07.155905+00
1770	Saint-Étienne_Lynel Kitambala_2011.csv	Lynel Kitambala	Saint-Étienne	league	2011	2022-01-29 23:46:07.156988+00
1771	Saint-Étienne_Maodomalick Faye_2009.csv	Maodomalick Faye	Saint-Étienne	league	2009	2022-01-29 23:46:07.158207+00
1772	Saint-Étienne_Mathieu Bodmer_2012.csv	Mathieu Bodmer	Saint-Étienne	league	2012	2022-01-29 23:46:07.159231+00
1773	Saint-Étienne_Max Gradel_2011.csv	Max Gradel	Saint-Étienne	league	2011	2022-01-29 23:46:07.159971+00
1774	Saint-Étienne_Max Gradel_2012.csv	Max Gradel	Saint-Étienne	league	2012	2022-01-29 23:46:07.160609+00
1775	Saint-Étienne_Mouhamadou Dabo_2009.csv	Mouhamadou Dabo	Saint-Étienne	league	2009	2022-01-29 23:46:07.161354+00
1776	Saint-Étienne_Moustapha Bayal Sall_2009.csv	Moustapha Bayal Sall	Saint-Étienne	league	2009	2022-01-29 23:46:07.162073+00
1777	Saint-Étienne_Moustapha Bayal Sall_2010.csv	Moustapha Bayal Sall	Saint-Étienne	league	2010	2022-01-29 23:46:07.162806+00
1778	Saint-Étienne_Moustapha Bayal Sall_2012.csv	Moustapha Bayal Sall	Saint-Étienne	league	2012	2022-01-29 23:46:07.163618+00
1779	Saint-Étienne_Pape Diakhaté_2009.csv	Pape Diakhaté	Saint-Étienne	league	2009	2022-01-29 23:46:07.164349+00
1780	Saint-Étienne_Paulão_2011.csv	Paulão	Saint-Étienne	league	2011	2022-01-29 23:46:07.165292+00
1781	Saint-Étienne_Pierre-Emerick Aubameyang_2010.csv	Pierre-Emerick Aubameyang	Saint-Étienne	league	2010	2022-01-29 23:46:07.166233+00
1782	Saint-Étienne_Pierre-Emerick Aubameyang_2011.csv	Pierre-Emerick Aubameyang	Saint-Étienne	league	2011	2022-01-29 23:46:07.16718+00
1783	Saint-Étienne_Pierre-Emerick Aubameyang_2012.csv	Pierre-Emerick Aubameyang	Saint-Étienne	league	2012	2022-01-29 23:46:07.168008+00
1784	Saint-Étienne_Pierrick Cros_2011.csv	Pierrick Cros	Saint-Étienne	league	2011	2022-01-29 23:46:07.16902+00
1785	Saint-Étienne_Renaud Cohade_2012.csv	Renaud Cohade	Saint-Étienne	league	2012	2022-01-29 23:46:07.170077+00
1786	Saint-Étienne_Romain Hamouma_2012.csv	Romain Hamouma	Saint-Étienne	league	2012	2022-01-29 23:46:07.171061+00
1787	Saint-Étienne_Stathis Tavlaridis_2009.csv	Stathis Tavlaridis	Saint-Étienne	league	2009	2022-01-29 23:46:07.172+00
1788	Saint-Étienne_Steed Malbranque_2011.csv	Steed Malbranque	Saint-Étienne	league	2011	2022-01-29 23:46:07.172934+00
1789	Saint-Étienne_Stéphane Ruffier_2011.csv	Stéphane Ruffier	Saint-Étienne	league	2011	2022-01-29 23:46:07.174011+00
1790	Saint-Étienne_Stéphane Ruffier_2012.csv	Stéphane Ruffier	Saint-Étienne	league	2012	2022-01-29 23:46:07.174935+00
1791	Saint-Étienne_Sylvain Marchal_2010.csv	Sylvain Marchal	Saint-Étienne	league	2010	2022-01-29 23:46:07.175752+00
1792	Saint-Étienne_Sylvain Marchal_2011.csv	Sylvain Marchal	Saint-Étienne	league	2011	2022-01-29 23:46:07.176573+00
1793	Saint-Étienne_Sylvain Monsoreau_2009.csv	Sylvain Monsoreau	Saint-Étienne	league	2009	2022-01-29 23:46:07.177344+00
1794	Saint-Étienne_Sylvain Monsoreau_2010.csv	Sylvain Monsoreau	Saint-Étienne	league	2010	2022-01-29 23:46:07.178066+00
1795	Saint-Étienne_Yoann Andreu_2009.csv	Yoann Andreu	Saint-Étienne	league	2009	2022-01-29 23:46:07.178793+00
1796	Saint-Étienne_Yoann Andreu_2010.csv	Yoann Andreu	Saint-Étienne	league	2010	2022-01-29 23:46:07.179562+00
1797	Saint-Étienne_Yohan Benalouane_2009.csv	Yohan Benalouane	Saint-Étienne	league	2009	2022-01-29 23:46:07.180379+00
1798	Saint-Étienne_Yohan Benalouane_2010.csv	Yohan Benalouane	Saint-Étienne	league	2010	2022-01-29 23:46:07.181451+00
1799	Saint-Étienne_Yohan Hautcœur_2009.csv	Yohan Hautcœur	Saint-Étienne	league	2009	2022-01-29 23:46:07.182516+00
1800	Saint-Étienne_Yohan Mollo_2012.csv	Yohan Mollo	Saint-Étienne	league	2012	2022-01-29 23:46:07.183318+00
1801	Saint-Étienne_Yoric Ravet_2010.csv	Yoric Ravet	Saint-Étienne	league	2010	2022-01-29 23:46:07.184168+00
1802	Saint-Étienne_Yoric Ravet_2011.csv	Yoric Ravet	Saint-Étienne	league	2011	2022-01-29 23:46:07.185131+00
1803	Sochaux_Abdoul Camara_2011.csv	Abdoul Camara	Sochaux	league	2011	2022-01-29 23:46:07.186123+00
1804	Sochaux_Abdoul Camara_2012.csv	Abdoul Camara	Sochaux	league	2012	2022-01-29 23:46:07.187081+00
1805	Sochaux_Banana Yaya_2011.csv	Banana Yaya	Sochaux	league	2011	2022-01-29 23:46:07.187995+00
1806	Sochaux_Banana Yaya_2012.csv	Banana Yaya	Sochaux	league	2012	2022-01-29 23:46:07.189898+00
1807	Sochaux_Benjamin Gavanon_2009.csv	Benjamin Gavanon	Sochaux	league	2009	2022-01-29 23:46:07.192809+00
1808	Sochaux_Bojan Jokić_2009.csv	Bojan Jokić	Sochaux	league	2009	2022-01-29 23:46:07.193526+00
1809	Sochaux_Boukary Dramé_2009.csv	Boukary Dramé	Sochaux	league	2009	2022-01-29 23:46:07.194217+00
1810	Sochaux_Boukary Dramé_2010.csv	Boukary Dramé	Sochaux	league	2010	2022-01-29 23:46:07.195604+00
1811	Sochaux_Brown Ideye_2009.csv	Brown Ideye	Sochaux	league	2009	2022-01-29 23:46:07.196669+00
1812	Sochaux_Brown Ideye_2010.csv	Brown Ideye	Sochaux	league	2010	2022-01-29 23:46:07.197512+00
1813	Sochaux_Carlão_2009.csv	Carlão	Sochaux	league	2009	2022-01-29 23:46:07.198301+00
1814	Sochaux_Carlão_2010.csv	Carlão	Sochaux	league	2010	2022-01-29 23:46:07.199145+00
1815	Sochaux_Carlão_2011.csv	Carlão	Sochaux	league	2011	2022-01-29 23:46:07.199967+00
1816	Sochaux_Carlão_2012.csv	Carlão	Sochaux	league	2012	2022-01-29 23:46:07.200751+00
1817	Sochaux_Cédric Bakambu_2010.csv	Cédric Bakambu	Sochaux	league	2010	2022-01-29 23:46:07.201629+00
1818	Sochaux_Cédric Bakambu_2011.csv	Cédric Bakambu	Sochaux	league	2011	2022-01-29 23:46:07.202418+00
1819	Sochaux_Cédric Bakambu_2012.csv	Cédric Bakambu	Sochaux	league	2012	2022-01-29 23:46:07.20333+00
1820	Sochaux_Cédric Kanté_2012.csv	Cédric Kanté	Sochaux	league	2012	2022-01-29 23:46:07.204497+00
1821	Sochaux_Charlie Davies_2009.csv	Charlie Davies	Sochaux	league	2009	2022-01-29 23:46:07.205954+00
1822	Sochaux_Charlie Davies_2011.csv	Charlie Davies	Sochaux	league	2011	2022-01-29 23:46:07.207004+00
1823	Sochaux_Damien Perquis_2009.csv	Damien Perquis	Sochaux	league	2009	2022-01-29 23:46:07.208199+00
1824	Sochaux_Damien Perquis_2010.csv	Damien Perquis	Sochaux	league	2010	2022-01-29 23:46:07.208923+00
1825	Sochaux_Damien Perquis_2011.csv	Damien Perquis	Sochaux	league	2011	2022-01-29 23:46:07.209547+00
1826	Sochaux_David Sauget_2010.csv	David Sauget	Sochaux	league	2010	2022-01-29 23:46:07.210168+00
1827	Sochaux_David Sauget_2011.csv	David Sauget	Sochaux	league	2011	2022-01-29 23:46:07.210829+00
1828	Sochaux_David Sauget_2012.csv	David Sauget	Sochaux	league	2012	2022-01-29 23:46:07.21144+00
1829	Sochaux_Édouard Butin_2009.csv	Édouard Butin	Sochaux	league	2009	2022-01-29 23:46:07.212042+00
1830	Sochaux_Édouard Butin_2010.csv	Édouard Butin	Sochaux	league	2010	2022-01-29 23:46:07.212675+00
1831	Sochaux_Édouard Butin_2011.csv	Édouard Butin	Sochaux	league	2011	2022-01-29 23:46:07.213663+00
1832	Sochaux_Édouard Butin_2012.csv	Édouard Butin	Sochaux	league	2012	2022-01-29 23:46:07.214396+00
1833	Sochaux_Frédéric Duplus_2009.csv	Frédéric Duplus	Sochaux	league	2009	2022-01-29 23:46:07.215097+00
1834	Sochaux_Geoffrey Tulasne_2009.csv	Geoffrey Tulasne	Sochaux	league	2009	2022-01-29 23:46:07.215745+00
1835	Sochaux_Geoffrey Tulasne_2010.csv	Geoffrey Tulasne	Sochaux	league	2010	2022-01-29 23:46:07.216319+00
1836	Sochaux_Giovanni Sio_2012.csv	Giovanni Sio	Sochaux	league	2012	2022-01-29 23:46:07.216913+00
1837	Sochaux_Ishmael Yartey_2012.csv	Ishmael Yartey	Sochaux	league	2012	2022-01-29 23:46:07.217462+00
1838	Sochaux_Ivan Stevanović_2009.csv	Ivan Stevanović	Sochaux	league	2009	2022-01-29 23:46:07.217983+00
1839	Sochaux_Jacques Faty_2009.csv	Jacques Faty	Sochaux	league	2009	2022-01-29 23:46:07.218552+00
1840	Sochaux_Jacques Faty_2010.csv	Jacques Faty	Sochaux	league	2010	2022-01-29 23:46:07.219659+00
1841	Sochaux_Jérémie Bréchet_2009.csv	Jérémie Bréchet	Sochaux	league	2009	2022-01-29 23:46:07.221489+00
1842	Sochaux_Jérémie Bréchet_2010.csv	Jérémie Bréchet	Sochaux	league	2010	2022-01-29 23:46:07.222442+00
1843	Sochaux_Jérémie Bréchet_2011.csv	Jérémie Bréchet	Sochaux	league	2011	2022-01-29 23:46:07.223324+00
1844	Sochaux_Jérôme Roussillon_2011.csv	Jérôme Roussillon	Sochaux	league	2011	2022-01-29 23:46:07.224439+00
1845	Sochaux_Jérôme Roussillon_2012.csv	Jérôme Roussillon	Sochaux	league	2012	2022-01-29 23:46:07.226018+00
1846	Sochaux_Joseph Lopy_2011.csv	Joseph Lopy	Sochaux	league	2011	2022-01-29 23:46:07.226999+00
1847	Sochaux_Joseph Lopy_2012.csv	Joseph Lopy	Sochaux	league	2012	2022-01-29 23:46:07.227995+00
1848	Sochaux_Kalilou Traoré_2012.csv	Kalilou Traoré	Sochaux	league	2012	2022-01-29 23:46:07.228956+00
1849	Sochaux_Kévin Anin_2010.csv	Kévin Anin	Sochaux	league	2010	2022-01-29 23:46:07.229949+00
1850	Sochaux_Kévin Anin_2011.csv	Kévin Anin	Sochaux	league	2011	2022-01-29 23:46:07.230872+00
1851	Sochaux_Lionel Zouma_2011.csv	Lionel Zouma	Sochaux	league	2011	2022-01-29 23:46:07.231756+00
1852	Sochaux_Lionel Zouma_2012.csv	Lionel Zouma	Sochaux	league	2012	2022-01-29 23:46:07.232448+00
1853	Sochaux_Loïc Poujol_2009.csv	Loïc Poujol	Sochaux	league	2009	2022-01-29 23:46:07.2333+00
1854	Sochaux_Loïc Poujol_2010.csv	Loïc Poujol	Sochaux	league	2010	2022-01-29 23:46:07.234352+00
1855	Sochaux_Loïc Poujol_2011.csv	Loïc Poujol	Sochaux	league	2011	2022-01-29 23:46:07.235163+00
1856	Sochaux_Loïc Poujol_2012.csv	Loïc Poujol	Sochaux	league	2012	2022-01-29 23:46:07.236126+00
1857	Sochaux_Marvin Martin_2009.csv	Marvin Martin	Sochaux	league	2009	2022-01-29 23:46:07.237217+00
1858	Sochaux_Marvin Martin_2010.csv	Marvin Martin	Sochaux	league	2010	2022-01-29 23:46:07.238161+00
1859	Sochaux_Marvin Martin_2011.csv	Marvin Martin	Sochaux	league	2011	2022-01-29 23:46:07.239041+00
1860	Sochaux_Mathieu Peybernes_2009.csv	Mathieu Peybernes	Sochaux	league	2009	2022-01-29 23:46:07.240117+00
1861	Sochaux_Mathieu Peybernes_2010.csv	Mathieu Peybernes	Sochaux	league	2010	2022-01-29 23:46:07.241495+00
1862	Sochaux_Mathieu Peybernes_2011.csv	Mathieu Peybernes	Sochaux	league	2011	2022-01-29 23:46:07.242358+00
1863	Sochaux_Mathieu Peybernes_2012.csv	Mathieu Peybernes	Sochaux	league	2012	2022-01-29 23:46:07.243157+00
1864	Sochaux_Matthieu Dreyer_2009.csv	Matthieu Dreyer	Sochaux	league	2009	2022-01-29 23:46:07.244106+00
1865	Sochaux_Matthieu Dreyer_2010.csv	Matthieu Dreyer	Sochaux	league	2010	2022-01-29 23:46:07.245171+00
1866	Sochaux_Maxime Josse_2009.csv	Maxime Josse	Sochaux	league	2009	2022-01-29 23:46:07.246136+00
1867	Sochaux_Maxime Josse_2010.csv	Maxime Josse	Sochaux	league	2010	2022-01-29 23:46:07.247117+00
1868	Sochaux_Modibo Maïga_2010.csv	Modibo Maïga	Sochaux	league	2010	2022-01-29 23:46:07.248245+00
1869	Sochaux_Modibo Maïga_2011.csv	Modibo Maïga	Sochaux	league	2011	2022-01-29 23:46:07.249083+00
1870	Sochaux_Nicolas Maurice-Belay_2009.csv	Nicolas Maurice-Belay	Sochaux	league	2009	2022-01-29 23:46:07.249808+00
1871	Sochaux_Nicolas Maurice-Belay_2010.csv	Nicolas Maurice-Belay	Sochaux	league	2010	2022-01-29 23:46:07.250461+00
1872	Sochaux_Omar Daf_2012.csv	Omar Daf	Sochaux	league	2012	2022-01-29 23:46:07.251203+00
1873	Sochaux_Papa Demba Camara_2011.csv	Papa Demba Camara	Sochaux	league	2011	2022-01-29 23:46:07.252449+00
1874	Sochaux_Petrus Boumal_2011.csv	Petrus Boumal	Sochaux	league	2011	2022-01-29 23:46:07.253392+00
1875	Sochaux_Pierrick Cros_2010.csv	Pierrick Cros	Sochaux	league	2010	2022-01-29 23:46:07.254131+00
1876	Sochaux_Pierrick Cros_2011.csv	Pierrick Cros	Sochaux	league	2011	2022-01-29 23:46:07.254884+00
1877	Sochaux_Pierrick Cros_2012.csv	Pierrick Cros	Sochaux	league	2012	2022-01-29 23:46:07.255647+00
1878	Sochaux_Rafaël Dias_2009.csv	Rafaël Dias	Sochaux	league	2009	2022-01-29 23:46:07.256287+00
1879	Sochaux_Rafaël Dias_2010.csv	Rafaël Dias	Sochaux	league	2010	2022-01-29 23:46:07.257103+00
1880	Sochaux_Rafaël Dias_2011.csv	Rafaël Dias	Sochaux	league	2011	2022-01-29 23:46:07.257896+00
1881	Sochaux_Rafaël Dias_2012.csv	Rafaël Dias	Sochaux	league	2012	2022-01-29 23:46:07.258615+00
1882	Sochaux_Roy Contout_2012.csv	Roy Contout	Sochaux	league	2012	2022-01-29 23:46:07.259271+00
1883	Sochaux_Ryad Boudebouz_2009.csv	Ryad Boudebouz	Sochaux	league	2009	2022-01-29 23:46:07.260186+00
1884	Sochaux_Ryad Boudebouz_2010.csv	Ryad Boudebouz	Sochaux	league	2010	2022-01-29 23:46:07.260981+00
1885	Sochaux_Ryad Boudebouz_2011.csv	Ryad Boudebouz	Sochaux	league	2011	2022-01-29 23:46:07.261985+00
1886	Sochaux_Ryad Boudebouz_2012.csv	Ryad Boudebouz	Sochaux	league	2012	2022-01-29 23:46:07.262803+00
1887	Sochaux_Serdar Gürler_2009.csv	Serdar Gürler	Sochaux	league	2009	2022-01-29 23:46:07.263683+00
1888	Sochaux_Serdar Gürler_2011.csv	Serdar Gürler	Sochaux	league	2011	2022-01-29 23:46:07.264675+00
1889	Sochaux_Sébastien Corchia_2011.csv	Sébastien Corchia	Sochaux	league	2011	2022-01-29 23:46:07.265601+00
1890	Sochaux_Sébastien Corchia_2012.csv	Sébastien Corchia	Sochaux	league	2012	2022-01-29 23:46:07.266548+00
1891	Sochaux_Sébastien Roudet_2011.csv	Sébastien Roudet	Sochaux	league	2011	2022-01-29 23:46:07.267521+00
1892	Sochaux_Sébastien Roudet_2012.csv	Sébastien Roudet	Sochaux	league	2012	2022-01-29 23:46:07.268687+00
1893	Sochaux_Simon Pouplin_2012.csv	Simon Pouplin	Sochaux	league	2012	2022-01-29 23:46:07.26975+00
1894	Sochaux_Sloan Privat_2009.csv	Sloan Privat	Sochaux	league	2009	2022-01-29 23:46:07.270486+00
1895	Sochaux_Sloan Privat_2011.csv	Sloan Privat	Sochaux	league	2011	2022-01-29 23:46:07.271138+00
1896	Sochaux_Sloan Privat_2012.csv	Sloan Privat	Sochaux	league	2012	2022-01-29 23:46:07.271905+00
1897	Sochaux_Steven Mouyokolo_2011.csv	Steven Mouyokolo	Sochaux	league	2011	2022-01-29 23:46:07.272674+00
1898	Sochaux_Stéphane Dalmat_2009.csv	Stéphane Dalmat	Sochaux	league	2009	2022-01-29 23:46:07.273507+00
1899	Sochaux_Teddy Richert_2009.csv	Teddy Richert	Sochaux	league	2009	2022-01-29 23:46:07.274559+00
1900	Sochaux_Teddy Richert_2010.csv	Teddy Richert	Sochaux	league	2010	2022-01-29 23:46:07.275714+00
1901	Sochaux_Teddy Richert_2011.csv	Teddy Richert	Sochaux	league	2011	2022-01-29 23:46:07.276666+00
1902	Sochaux_Thierry Doubai_2011.csv	Thierry Doubai	Sochaux	league	2011	2022-01-29 23:46:07.277708+00
1903	Sochaux_Thierry Doubai_2012.csv	Thierry Doubai	Sochaux	league	2012	2022-01-29 23:46:07.27844+00
1904	Sochaux_Václav Svěrkoš_2009.csv	Václav Svěrkoš	Sochaux	league	2009	2022-01-29 23:46:07.279116+00
1905	Sochaux_Václav Svěrkoš_2010.csv	Václav Svěrkoš	Sochaux	league	2010	2022-01-29 23:46:07.279889+00
1906	Sochaux_Vincent Nogueira_2009.csv	Vincent Nogueira	Sochaux	league	2009	2022-01-29 23:46:07.280662+00
1907	Sochaux_Vincent Nogueira_2010.csv	Vincent Nogueira	Sochaux	league	2010	2022-01-29 23:46:07.281525+00
1908	Sochaux_Vincent Nogueira_2011.csv	Vincent Nogueira	Sochaux	league	2011	2022-01-29 23:46:07.282359+00
1909	Sochaux_Vincent Nogueira_2012.csv	Vincent Nogueira	Sochaux	league	2012	2022-01-29 23:46:07.283255+00
1910	Sochaux_Yassin Mikari_2009.csv	Yassin Mikari	Sochaux	league	2009	2022-01-29 23:46:07.284341+00
1911	Sochaux_Yassin Mikari_2010.csv	Yassin Mikari	Sochaux	league	2010	2022-01-29 23:46:07.285074+00
1912	Sochaux_Yassin Mikari_2011.csv	Yassin Mikari	Sochaux	league	2011	2022-01-29 23:46:07.285686+00
1913	Sochaux_Yassin Mikari_2012.csv	Yassin Mikari	Sochaux	league	2012	2022-01-29 23:46:07.286791+00
1914	Toulouse_Adil Hermach_2012.csv	Adil Hermach	Toulouse	league	2012	2022-01-29 23:46:07.287413+00
1915	Toulouse_Adrián Gunino_2010.csv	Adrián Gunino	Toulouse	league	2010	2022-01-29 23:46:07.288069+00
1916	Toulouse_Adrien Rabiot_2012.csv	Adrien Rabiot	Toulouse	league	2012	2022-01-29 23:46:07.288828+00
1917	Toulouse_Adrien Regattin_2009.csv	Adrien Regattin	Toulouse	league	2009	2022-01-29 23:46:07.289447+00
1918	Toulouse_Adrien Regattin_2010.csv	Adrien Regattin	Toulouse	league	2010	2022-01-29 23:46:07.290078+00
1919	Toulouse_Adrien Regattin_2011.csv	Adrien Regattin	Toulouse	league	2011	2022-01-29 23:46:07.290946+00
1920	Toulouse_Adrien Regattin_2012.csv	Adrien Regattin	Toulouse	league	2012	2022-01-29 23:46:07.291807+00
1921	Toulouse_Ahmed Soukouna_2009.csv	Ahmed Soukouna	Toulouse	league	2009	2022-01-29 23:46:07.292604+00
1922	Toulouse_Ahmed Soukouna_2010.csv	Ahmed Soukouna	Toulouse	league	2010	2022-01-29 23:46:07.293568+00
1923	Toulouse_Ahmed Soukouna_2011.csv	Ahmed Soukouna	Toulouse	league	2011	2022-01-29 23:46:07.294421+00
1924	Toulouse_Albin Ebondo_2009.csv	Albin Ebondo	Toulouse	league	2009	2022-01-29 23:46:07.29522+00
1925	Toulouse_Alexandre N'Gadi_2009.csv	Alexandre N'Gadi	Toulouse	league	2009	2022-01-29 23:46:07.296034+00
1926	Toulouse_Ali Ahamada_2010.csv	Ali Ahamada	Toulouse	league	2010	2022-01-29 23:46:07.296889+00
1927	Toulouse_Ali Ahamada_2011.csv	Ali Ahamada	Toulouse	league	2011	2022-01-29 23:46:07.297732+00
1928	Toulouse_Ali Ahamada_2012.csv	Ali Ahamada	Toulouse	league	2012	2022-01-29 23:46:07.29862+00
1929	Toulouse_Amadou Soukouna_2011.csv	Amadou Soukouna	Toulouse	league	2011	2022-01-29 23:46:07.299444+00
1930	Toulouse_André-Pierre Gignac_2009.csv	André-Pierre Gignac	Toulouse	league	2009	2022-01-29 23:46:07.300327+00
1931	Toulouse_André-Pierre Gignac_2010.csv	André-Pierre Gignac	Toulouse	league	2010	2022-01-29 23:46:07.30118+00
1932	Toulouse_Anthony Loustallot_2009.csv	Anthony Loustallot	Toulouse	league	2009	2022-01-29 23:46:07.302014+00
1933	Toulouse_Antoine Devaux_2009.csv	Antoine Devaux	Toulouse	league	2009	2022-01-29 23:46:07.30302+00
1934	Toulouse_Antoine Devaux_2010.csv	Antoine Devaux	Toulouse	league	2010	2022-01-29 23:46:07.303865+00
1935	Toulouse_Antoine Devaux_2011.csv	Antoine Devaux	Toulouse	league	2011	2022-01-29 23:46:07.304815+00
1936	Toulouse_Aymen Abdennour_2011.csv	Aymen Abdennour	Toulouse	league	2011	2022-01-29 23:46:07.305769+00
1937	Toulouse_Aymen Abdennour_2012.csv	Aymen Abdennour	Toulouse	league	2012	2022-01-29 23:46:07.306695+00
1938	Toulouse_Cheikh M'Bengue_2009.csv	Cheikh M'Bengue	Toulouse	league	2009	2022-01-29 23:46:07.308075+00
1939	Toulouse_Cheikh M'Bengue_2010.csv	Cheikh M'Bengue	Toulouse	league	2010	2022-01-29 23:46:07.309008+00
1940	Toulouse_Cheikh M'Bengue_2011.csv	Cheikh M'Bengue	Toulouse	league	2011	2022-01-29 23:46:07.309894+00
1941	Toulouse_Cheikh M'Bengue_2012.csv	Cheikh M'Bengue	Toulouse	league	2012	2022-01-29 23:46:07.310754+00
1942	Toulouse_Colin Kazim-Richards_2009.csv	Colin Kazim-Richards	Toulouse	league	2009	2022-01-29 23:46:07.31165+00
1943	Toulouse_Daniel Braaten_2009.csv	Daniel Braaten	Toulouse	league	2009	2022-01-29 23:46:07.31254+00
1944	Toulouse_Daniel Braaten_2010.csv	Daniel Braaten	Toulouse	league	2010	2022-01-29 23:46:07.313421+00
1945	Toulouse_Daniel Braaten_2011.csv	Daniel Braaten	Toulouse	league	2011	2022-01-29 23:46:07.314414+00
1946	Toulouse_Daniel Braaten_2012.csv	Daniel Braaten	Toulouse	league	2012	2022-01-29 23:46:07.315584+00
1947	Toulouse_Daniel Congré_2009.csv	Daniel Congré	Toulouse	league	2009	2022-01-29 23:46:07.316509+00
1948	Toulouse_Daniel Congré_2010.csv	Daniel Congré	Toulouse	league	2010	2022-01-29 23:46:07.317503+00
1949	Toulouse_Daniel Congré_2011.csv	Daniel Congré	Toulouse	league	2011	2022-01-29 23:46:07.318437+00
1950	Toulouse_Dany Nounkeu_2009.csv	Dany Nounkeu	Toulouse	league	2009	2022-01-29 23:46:07.319342+00
1951	Toulouse_Dany Nounkeu_2010.csv	Dany Nounkeu	Toulouse	league	2010	2022-01-29 23:46:07.32023+00
1952	Toulouse_Eden Ben Basat_2012.csv	Eden Ben Basat	Toulouse	league	2012	2022-01-29 23:46:07.321092+00
1953	Toulouse_Emmanuel Rivière_2011.csv	Emmanuel Rivière	Toulouse	league	2011	2022-01-29 23:46:07.321922+00
1954	Toulouse_Emmanuel Rivière_2012.csv	Emmanuel Rivière	Toulouse	league	2012	2022-01-29 23:46:07.322786+00
1955	Toulouse_Étienne Capoue_2009.csv	Étienne Capoue	Toulouse	league	2009	2022-01-29 23:46:07.323551+00
1956	Toulouse_Étienne Capoue_2010.csv	Étienne Capoue	Toulouse	league	2010	2022-01-29 23:46:07.324479+00
1957	Toulouse_Étienne Capoue_2011.csv	Étienne Capoue	Toulouse	league	2011	2022-01-29 23:46:07.325497+00
1958	Toulouse_Étienne Capoue_2012.csv	Étienne Capoue	Toulouse	league	2012	2022-01-29 23:46:07.326488+00
1959	Toulouse_Étienne Didot_2009.csv	Étienne Didot	Toulouse	league	2009	2022-01-29 23:46:07.327712+00
1960	Toulouse_Étienne Didot_2010.csv	Étienne Didot	Toulouse	league	2010	2022-01-29 23:46:07.329073+00
1961	Toulouse_Étienne Didot_2011.csv	Étienne Didot	Toulouse	league	2011	2022-01-29 23:46:07.330112+00
1962	Toulouse_Étienne Didot_2012.csv	Étienne Didot	Toulouse	league	2012	2022-01-29 23:46:07.331082+00
1963	Toulouse_Federico Santander_2010.csv	Federico Santander	Toulouse	league	2010	2022-01-29 23:46:07.332057+00
1964	Toulouse_Fodé Mansaré_2009.csv	Fodé Mansaré	Toulouse	league	2009	2022-01-29 23:46:07.332952+00
1965	Toulouse_Fodé Mansaré_2010.csv	Fodé Mansaré	Toulouse	league	2010	2022-01-29 23:46:07.333797+00
1966	Toulouse_Franck Tabanou_2009.csv	Franck Tabanou	Toulouse	league	2009	2022-01-29 23:46:07.334922+00
1967	Toulouse_Franck Tabanou_2010.csv	Franck Tabanou	Toulouse	league	2010	2022-01-29 23:46:07.335835+00
1968	Toulouse_Franck Tabanou_2011.csv	Franck Tabanou	Toulouse	league	2011	2022-01-29 23:46:07.336897+00
1969	Toulouse_Franck Tabanou_2012.csv	Franck Tabanou	Toulouse	league	2012	2022-01-29 23:46:07.337741+00
1970	Toulouse_Issiaga Sylla_2012.csv	Issiaga Sylla	Toulouse	league	2012	2022-01-29 23:46:07.33864+00
1971	Toulouse_Jean-Daniel Akpa-Akpro_2011.csv	Jean-Daniel Akpa-Akpro	Toulouse	league	2011	2022-01-29 23:46:07.339615+00
1972	Toulouse_Jean-Daniel Akpa-Akpro_2012.csv	Jean-Daniel Akpa-Akpro	Toulouse	league	2012	2022-01-29 23:46:07.340512+00
1973	Toulouse_Jean-Joël Perrier-Doumbé_2009.csv	Jean-Joël Perrier-Doumbé	Toulouse	league	2009	2022-01-29 23:46:07.341439+00
1974	Toulouse_Jonathan Zebina_2012.csv	Jonathan Zebina	Toulouse	league	2012	2022-01-29 23:46:07.342327+00
1975	Toulouse_Kévin Dupuis_2009.csv	Kévin Dupuis	Toulouse	league	2009	2022-01-29 23:46:07.343226+00
1976	Toulouse_Kévin Rodrigues_2011.csv	Kévin Rodrigues	Toulouse	league	2011	2022-01-29 23:46:07.344204+00
1977	Toulouse_Kévin Rodrigues_2012.csv	Kévin Rodrigues	Toulouse	league	2012	2022-01-29 23:46:07.345154+00
1978	Toulouse_Luan_2009.csv	Luan	Toulouse	league	2009	2022-01-29 23:46:07.346273+00
1979	Toulouse_Marc Vidal_2009.csv	Marc Vidal	Toulouse	league	2009	2022-01-29 23:46:07.347389+00
1980	Toulouse_Marc Vidal_2010.csv	Marc Vidal	Toulouse	league	2010	2022-01-29 23:46:07.348313+00
1981	Toulouse_Mathieu Berson_2009.csv	Mathieu Berson	Toulouse	league	2009	2022-01-29 23:46:07.349189+00
1982	Toulouse_Mathieu Valverde_2009.csv	Mathieu Valverde	Toulouse	league	2009	2022-01-29 23:46:07.3501+00
1983	Toulouse_Mathieu Valverde_2010.csv	Mathieu Valverde	Toulouse	league	2010	2022-01-29 23:46:07.351192+00
1984	Toulouse_Mauro Cetto_2009.csv	Mauro Cetto	Toulouse	league	2009	2022-01-29 23:46:07.352176+00
1985	Toulouse_Mauro Cetto_2010.csv	Mauro Cetto	Toulouse	league	2010	2022-01-29 23:46:07.35409+00
1986	Toulouse_Mickaël Firmin_2011.csv	Mickaël Firmin	Toulouse	league	2011	2022-01-29 23:46:07.355307+00
1987	Toulouse_Mohamed Fofana_2009.csv	Mohamed Fofana	Toulouse	league	2009	2022-01-29 23:46:07.356259+00
1988	Toulouse_Mohamed Fofana_2010.csv	Mohamed Fofana	Toulouse	league	2010	2022-01-29 23:46:07.357138+00
1989	Toulouse_Mohamed Fofana_2011.csv	Mohamed Fofana	Toulouse	league	2011	2022-01-29 23:46:07.358146+00
1990	Toulouse_Moussa Sissoko_2009.csv	Moussa Sissoko	Toulouse	league	2009	2022-01-29 23:46:07.359179+00
1991	Toulouse_Moussa Sissoko_2010.csv	Moussa Sissoko	Toulouse	league	2010	2022-01-29 23:46:07.360081+00
1992	Toulouse_Moussa Sissoko_2011.csv	Moussa Sissoko	Toulouse	league	2011	2022-01-29 23:46:07.361277+00
1993	Toulouse_Moussa Sissoko_2012.csv	Moussa Sissoko	Toulouse	league	2012	2022-01-29 23:46:07.362216+00
1994	Toulouse_Olivier Blondel_2009.csv	Olivier Blondel	Toulouse	league	2009	2022-01-29 23:46:07.363189+00
1995	Toulouse_Olivier Blondel_2012.csv	Olivier Blondel	Toulouse	league	2012	2022-01-29 23:46:07.364105+00
1996	Toulouse_Pantxi Sirieix_2009.csv	Pantxi Sirieix	Toulouse	league	2009	2022-01-29 23:46:07.365084+00
1997	Toulouse_Pantxi Sirieix_2010.csv	Pantxi Sirieix	Toulouse	league	2010	2022-01-29 23:46:07.365984+00
1998	Toulouse_Pantxi Sirieix_2011.csv	Pantxi Sirieix	Toulouse	league	2011	2022-01-29 23:46:07.36692+00
1999	Toulouse_Pantxi Sirieix_2012.csv	Pantxi Sirieix	Toulouse	league	2012	2022-01-29 23:46:07.368061+00
2000	Toulouse_Paulo Machado_2009.csv	Paulo Machado	Toulouse	league	2009	2022-01-29 23:46:07.368992+00
2001	Toulouse_Paulo Machado_2010.csv	Paulo Machado	Toulouse	league	2010	2022-01-29 23:46:07.36982+00
2002	Toulouse_Paulo Machado_2011.csv	Paulo Machado	Toulouse	league	2011	2022-01-29 23:46:07.370741+00
2003	Toulouse_Pavle Ninkov_2011.csv	Pavle Ninkov	Toulouse	league	2011	2022-01-29 23:46:07.371633+00
2004	Toulouse_Pavle Ninkov_2012.csv	Pavle Ninkov	Toulouse	league	2012	2022-01-29 23:46:07.372523+00
2005	Toulouse_Serge Aurier_2011.csv	Serge Aurier	Toulouse	league	2011	2022-01-29 23:46:07.373333+00
2006	Toulouse_Serge Aurier_2012.csv	Serge Aurier	Toulouse	league	2012	2022-01-29 23:46:07.374201+00
2007	Toulouse_Steeve Yago_2012.csv	Steeve Yago	Toulouse	league	2012	2022-01-29 23:46:07.375367+00
2008	Toulouse_Søren Larsen_2010.csv	Søren Larsen	Toulouse	league	2010	2022-01-29 23:46:07.376309+00
2009	Toulouse_Umut Bulut_2011.csv	Umut Bulut	Toulouse	league	2011	2022-01-29 23:46:07.377313+00
2010	Toulouse_Wissam Ben Yedder_2010.csv	Wissam Ben Yedder	Toulouse	league	2010	2022-01-29 23:46:07.378179+00
2011	Toulouse_Wissam Ben Yedder_2011.csv	Wissam Ben Yedder	Toulouse	league	2011	2022-01-29 23:46:07.379071+00
2012	Toulouse_Wissam Ben Yedder_2012.csv	Wissam Ben Yedder	Toulouse	league	2012	2022-01-29 23:46:07.379978+00
2013	Toulouse_Xavier Pentecôte_2009.csv	Xavier Pentecôte	Toulouse	league	2009	2022-01-29 23:46:07.380777+00
2014	Toulouse_Xavier Pentecôte_2010.csv	Xavier Pentecôte	Toulouse	league	2010	2022-01-29 23:46:07.38164+00
2015	Toulouse_Xavier Pentecôte_2011.csv	Xavier Pentecôte	Toulouse	league	2011	2022-01-29 23:46:07.382469+00
2016	Toulouse_Yannick Aguemon_2011.csv	Yannick Aguemon	Toulouse	league	2011	2022-01-29 23:46:07.383402+00
2017	Toulouse_Yannick Djaló_2012.csv	Yannick Djaló	Toulouse	league	2012	2022-01-29 23:46:07.38447+00
2018	Toulouse_Yannis Tafer_2010.csv	Yannis Tafer	Toulouse	league	2010	2022-01-29 23:46:07.385416+00
2019	Toulouse_Yohann Pelé_2009.csv	Yohann Pelé	Toulouse	league	2009	2022-01-29 23:46:07.386304+00
2020	Troyes_Benjamin Nivet_2012.csv	Benjamin Nivet	Troyes	league	2012	2022-01-29 23:46:07.387192+00
2021	Troyes_Fabien Camus_2012.csv	Fabien Camus	Troyes	league	2012	2022-01-29 23:46:07.388096+00
2022	Troyes_Fabrice N'Sakala_2012.csv	Fabrice N'Sakala	Troyes	league	2012	2022-01-29 23:46:07.389+00
2023	Troyes_Florian Jarjat_2012.csv	Florian Jarjat	Troyes	league	2012	2022-01-29 23:46:07.390072+00
2024	Troyes_Granddi Ngoyi_2012.csv	Granddi Ngoyi	Troyes	league	2012	2022-01-29 23:46:07.390929+00
2025	Troyes_Jean-Christophe Bahebeck_2012.csv	Jean-Christophe Bahebeck	Troyes	league	2012	2022-01-29 23:46:07.391755+00
2026	Troyes_Jérémie Bréchet_2012.csv	Jérémie Bréchet	Troyes	league	2012	2022-01-29 23:46:07.392637+00
2027	Troyes_Julien Faussurier_2012.csv	Julien Faussurier	Troyes	league	2012	2022-01-29 23:46:07.393503+00
2028	Troyes_Maxime Colin_2012.csv	Maxime Colin	Troyes	league	2012	2022-01-29 23:46:07.39446+00
2029	Troyes_Mounir Obbadi_2012.csv	Mounir Obbadi	Troyes	league	2012	2022-01-29 23:46:07.395405+00
2030	Troyes_Quentin Othon_2012.csv	Quentin Othon	Troyes	league	2012	2022-01-29 23:46:07.396268+00
2031	Troyes_Stéphane Darbion_2012.csv	Stéphane Darbion	Troyes	league	2012	2022-01-29 23:46:07.397108+00
2032	Troyes_Thiago Xavier_2012.csv	Thiago Xavier	Troyes	league	2012	2022-01-29 23:46:07.397917+00
2033	Troyes_Yohann Thuram-Ulien_2012.csv	Yohann Thuram-Ulien	Troyes	league	2012	2022-01-29 23:46:07.398949+00
2034	Valenciennes_Anthony Le Tallec_2012.csv	Anthony Le Tallec	Valenciennes	league	2012	2022-01-29 23:46:07.399814+00
2035	Valenciennes_Benjamin Angoua_2009.csv	Benjamin Angoua	Valenciennes	league	2009	2022-01-29 23:46:07.40073+00
2036	Valenciennes_Benjamin Angoua_2010.csv	Benjamin Angoua	Valenciennes	league	2010	2022-01-29 23:46:07.401741+00
2037	Valenciennes_Benjamin Angoua_2011.csv	Benjamin Angoua	Valenciennes	league	2011	2022-01-29 23:46:07.402676+00
2038	Valenciennes_Benjamin Angoua_2012.csv	Benjamin Angoua	Valenciennes	league	2012	2022-01-29 23:46:07.403586+00
2039	Valenciennes_Bobo Baldé_2009.csv	Bobo Baldé	Valenciennes	league	2009	2022-01-29 23:46:07.404494+00
2040	Valenciennes_Bobo Baldé_2010.csv	Bobo Baldé	Valenciennes	league	2010	2022-01-29 23:46:07.405483+00
2041	Valenciennes_Carlos Sánchez_2009.csv	Carlos Sánchez	Valenciennes	league	2009	2022-01-29 23:46:07.406466+00
2042	Valenciennes_Carlos Sánchez_2010.csv	Carlos Sánchez	Valenciennes	league	2010	2022-01-29 23:46:07.407372+00
2043	Valenciennes_Carlos Sánchez_2011.csv	Carlos Sánchez	Valenciennes	league	2011	2022-01-29 23:46:07.408357+00
2044	Valenciennes_Carlos Sánchez_2012.csv	Carlos Sánchez	Valenciennes	league	2012	2022-01-29 23:46:07.409422+00
2045	Valenciennes_David Ducourtioux_2009.csv	David Ducourtioux	Valenciennes	league	2009	2022-01-29 23:46:07.410399+00
2046	Valenciennes_David Ducourtioux_2010.csv	David Ducourtioux	Valenciennes	league	2010	2022-01-29 23:46:07.411697+00
2047	Valenciennes_David Ducourtioux_2011.csv	David Ducourtioux	Valenciennes	league	2011	2022-01-29 23:46:07.412594+00
2048	Valenciennes_David Ducourtioux_2012.csv	David Ducourtioux	Valenciennes	league	2012	2022-01-29 23:46:07.413427+00
2049	Valenciennes_Dusan Djurić_2011.csv	Dusan Djurić	Valenciennes	league	2011	2022-01-29 23:46:07.414252+00
2050	Valenciennes_Fahid Ben Khalfallah_2009.csv	Fahid Ben Khalfallah	Valenciennes	league	2009	2022-01-29 23:46:07.415161+00
2051	Valenciennes_Fahid Ben Khalfallah_2010.csv	Fahid Ben Khalfallah	Valenciennes	league	2010	2022-01-29 23:46:07.416325+00
2052	Valenciennes_Filip Šebo_2009.csv	Filip Šebo	Valenciennes	league	2009	2022-01-29 23:46:07.417267+00
2053	Valenciennes_Foued Kadir_2009.csv	Foued Kadir	Valenciennes	league	2009	2022-01-29 23:46:07.41818+00
2054	Valenciennes_Foued Kadir_2010.csv	Foued Kadir	Valenciennes	league	2010	2022-01-29 23:46:07.419062+00
2055	Valenciennes_Foued Kadir_2011.csv	Foued Kadir	Valenciennes	league	2011	2022-01-29 23:46:07.420109+00
2056	Valenciennes_Foued Kadir_2012.csv	Foued Kadir	Valenciennes	league	2012	2022-01-29 23:46:07.421157+00
2057	Valenciennes_Gaël Danic_2009.csv	Gaël Danic	Valenciennes	league	2009	2022-01-29 23:46:07.42211+00
2058	Valenciennes_Gaël Danic_2010.csv	Gaël Danic	Valenciennes	league	2010	2022-01-29 23:46:07.423061+00
2059	Valenciennes_Gaël Danic_2011.csv	Gaël Danic	Valenciennes	league	2011	2022-01-29 23:46:07.424143+00
2060	Valenciennes_Gaël Danic_2012.csv	Gaël Danic	Valenciennes	league	2012	2022-01-29 23:46:07.425422+00
2061	Valenciennes_Gaëtan Bong_2009.csv	Gaëtan Bong	Valenciennes	league	2009	2022-01-29 23:46:07.426365+00
2062	Valenciennes_Gaëtan Bong_2010.csv	Gaëtan Bong	Valenciennes	league	2010	2022-01-29 23:46:07.427186+00
2063	Valenciennes_Gaëtan Bong_2011.csv	Gaëtan Bong	Valenciennes	league	2011	2022-01-29 23:46:07.428+00
2064	Valenciennes_Gaëtan Bong_2012.csv	Gaëtan Bong	Valenciennes	league	2012	2022-01-29 23:46:07.428867+00
2065	Valenciennes_Gil_2011.csv	Gil	Valenciennes	league	2011	2022-01-29 23:46:07.429874+00
2066	Valenciennes_Gil_2012.csv	Gil	Valenciennes	league	2012	2022-01-29 23:46:07.430879+00
2067	Valenciennes_Grégory Pujol_2009.csv	Grégory Pujol	Valenciennes	league	2009	2022-01-29 23:46:07.431809+00
2068	Valenciennes_Grégory Pujol_2010.csv	Grégory Pujol	Valenciennes	league	2010	2022-01-29 23:46:07.432967+00
2069	Valenciennes_Grégory Pujol_2011.csv	Grégory Pujol	Valenciennes	league	2011	2022-01-29 23:46:07.43399+00
2070	Valenciennes_Grégory Pujol_2012.csv	Grégory Pujol	Valenciennes	league	2012	2022-01-29 23:46:07.435047+00
2071	Valenciennes_Grégory Wimbée_2009.csv	Grégory Wimbée	Valenciennes	league	2009	2022-01-29 23:46:07.435986+00
2072	Valenciennes_Guillaume Loriot_2010.csv	Guillaume Loriot	Valenciennes	league	2010	2022-01-29 23:46:07.436941+00
2073	Valenciennes_Guillaume Loriot_2011.csv	Guillaume Loriot	Valenciennes	league	2011	2022-01-29 23:46:07.438115+00
2074	Valenciennes_Guy N'dy Assembé_2009.csv	Guy N'dy Assembé	Valenciennes	league	2009	2022-01-29 23:46:07.439229+00
2075	Valenciennes_Jacques Abardonado_2009.csv	Jacques Abardonado	Valenciennes	league	2009	2022-01-29 23:46:07.440172+00
2076	Valenciennes_Jean-Louis Leca_2009.csv	Jean-Louis Leca	Valenciennes	league	2009	2022-01-29 23:46:07.441188+00
2077	Valenciennes_Johan Audel_2009.csv	Johan Audel	Valenciennes	league	2009	2022-01-29 23:46:07.442074+00
2078	Valenciennes_José Saez_2009.csv	José Saez	Valenciennes	league	2009	2022-01-29 23:46:07.443036+00
2079	Valenciennes_José Saez_2010.csv	José Saez	Valenciennes	league	2010	2022-01-29 23:46:07.443925+00
2080	Valenciennes_José Saez_2011.csv	José Saez	Valenciennes	league	2011	2022-01-29 23:46:07.444913+00
2081	Valenciennes_José Saez_2012.csv	José Saez	Valenciennes	league	2012	2022-01-29 23:46:07.446045+00
2082	Valenciennes_Kama Massampu_2010.csv	Kama Massampu	Valenciennes	league	2010	2022-01-29 23:46:07.446985+00
2083	Valenciennes_Kama Massampu_2011.csv	Kama Massampu	Valenciennes	league	2011	2022-01-29 23:46:07.447875+00
2084	Valenciennes_Karba Bangoura_2009.csv	Karba Bangoura	Valenciennes	league	2009	2022-01-29 23:46:07.448892+00
2085	Valenciennes_Kenny Lala_2011.csv	Kenny Lala	Valenciennes	league	2011	2022-01-29 23:46:07.449896+00
2086	Valenciennes_Kenny Lala_2012.csv	Kenny Lala	Valenciennes	league	2012	2022-01-29 23:46:07.450869+00
2087	Valenciennes_Lilian Bochet_2010.csv	Lilian Bochet	Valenciennes	league	2010	2022-01-29 23:46:07.452007+00
2088	Valenciennes_Lindsay Rose_2012.csv	Lindsay Rose	Valenciennes	league	2012	2022-01-29 23:46:07.452919+00
2089	Valenciennes_Loris Néry_2012.csv	Loris Néry	Valenciennes	league	2012	2022-01-29 23:46:07.454127+00
2090	Valenciennes_Luigi Pieroni_2009.csv	Luigi Pieroni	Valenciennes	league	2009	2022-01-29 23:46:07.45522+00
2091	Valenciennes_Mamadou Samassa_2009.csv	Mamadou Samassa	Valenciennes	league	2009	2022-01-29 23:46:07.45624+00
2092	Valenciennes_Mamadou Samassa_2010.csv	Mamadou Samassa	Valenciennes	league	2010	2022-01-29 23:46:07.457221+00
2093	Valenciennes_Mamadou Samassa_2011.csv	Mamadou Samassa	Valenciennes	league	2011	2022-01-29 23:46:07.458196+00
2094	Valenciennes_Mamadou Samassa_2012.csv	Mamadou Samassa	Valenciennes	league	2012	2022-01-29 23:46:07.459072+00
2095	Valenciennes_Maor Melikson_2012.csv	Maor Melikson	Valenciennes	league	2012	2022-01-29 23:46:07.460016+00
2096	Valenciennes_Marco da Silva_2011.csv	Marco da Silva	Valenciennes	league	2011	2022-01-29 23:46:07.461092+00
2097	Valenciennes_Marco da Silva_2012.csv	Marco da Silva	Valenciennes	league	2012	2022-01-29 23:46:07.461941+00
2098	Valenciennes_Mathieu Dossevi_2010.csv	Mathieu Dossevi	Valenciennes	league	2010	2022-01-29 23:46:07.462984+00
2099	Valenciennes_Mathieu Dossevi_2011.csv	Mathieu Dossevi	Valenciennes	league	2011	2022-01-29 23:46:07.463898+00
2100	Valenciennes_Mathieu Dossevi_2012.csv	Mathieu Dossevi	Valenciennes	league	2012	2022-01-29 23:46:07.464884+00
2101	Valenciennes_Milan Biševac_2009.csv	Milan Biševac	Valenciennes	league	2009	2022-01-29 23:46:07.465769+00
2102	Valenciennes_Milan Biševac_2010.csv	Milan Biševac	Valenciennes	league	2010	2022-01-29 23:46:07.466823+00
2103	Valenciennes_Mody Traoré_2011.csv	Mody Traoré	Valenciennes	league	2011	2022-01-29 23:46:07.467714+00
2104	Valenciennes_Mody Traoré_2012.csv	Mody Traoré	Valenciennes	league	2012	2022-01-29 23:46:07.468674+00
2105	Valenciennes_Nam Tae-hee_2009.csv	Nam Tae-hee	Valenciennes	league	2009	2022-01-29 23:46:07.469742+00
2106	Valenciennes_Nam Tae-hee_2010.csv	Nam Tae-hee	Valenciennes	league	2010	2022-01-29 23:46:07.470818+00
2107	Valenciennes_Nam Tae-hee_2011.csv	Nam Tae-hee	Valenciennes	league	2011	2022-01-29 23:46:07.471951+00
2108	Valenciennes_Nicolas Isimat-Mirin_2010.csv	Nicolas Isimat-Mirin	Valenciennes	league	2010	2022-01-29 23:46:07.472785+00
2109	Valenciennes_Nicolas Isimat-Mirin_2011.csv	Nicolas Isimat-Mirin	Valenciennes	league	2011	2022-01-29 23:46:07.473544+00
2110	Valenciennes_Nicolas Isimat-Mirin_2012.csv	Nicolas Isimat-Mirin	Valenciennes	league	2012	2022-01-29 23:46:07.474586+00
2111	Valenciennes_Nicolas Pallois_2010.csv	Nicolas Pallois	Valenciennes	league	2010	2022-01-29 23:46:07.475947+00
2112	Valenciennes_Nicolas Penneteau_2009.csv	Nicolas Penneteau	Valenciennes	league	2009	2022-01-29 23:46:07.477045+00
2113	Valenciennes_Nicolas Penneteau_2010.csv	Nicolas Penneteau	Valenciennes	league	2010	2022-01-29 23:46:07.477925+00
2114	Valenciennes_Nicolas Penneteau_2011.csv	Nicolas Penneteau	Valenciennes	league	2011	2022-01-29 23:46:07.478773+00
2115	Valenciennes_Nicolas Penneteau_2012.csv	Nicolas Penneteau	Valenciennes	league	2012	2022-01-29 23:46:07.479648+00
2116	Valenciennes_Opa Nguette_2012.csv	Opa Nguette	Valenciennes	league	2012	2022-01-29 23:46:07.480682+00
2117	Valenciennes_Pape Abdou Camara_2011.csv	Pape Abdou Camara	Valenciennes	league	2011	2022-01-29 23:46:07.481591+00
2118	Valenciennes_Pape Abdou Camara_2012.csv	Pape Abdou Camara	Valenciennes	league	2012	2022-01-29 23:46:07.482479+00
2119	Valenciennes_Rafael Schmitz_2009.csv	Rafael Schmitz	Valenciennes	league	2009	2022-01-29 23:46:07.483345+00
2120	Valenciennes_Rafael Schmitz_2010.csv	Rafael Schmitz	Valenciennes	league	2010	2022-01-29 23:46:07.484244+00
2121	Valenciennes_Rafael Schmitz_2011.csv	Rafael Schmitz	Valenciennes	league	2011	2022-01-29 23:46:07.485434+00
2122	Valenciennes_Renaud Cohade_2009.csv	Renaud Cohade	Valenciennes	league	2009	2022-01-29 23:46:07.486449+00
2123	Valenciennes_Renaud Cohade_2010.csv	Renaud Cohade	Valenciennes	league	2010	2022-01-29 23:46:07.487316+00
2124	Valenciennes_Renaud Cohade_2011.csv	Renaud Cohade	Valenciennes	league	2011	2022-01-29 23:46:07.488763+00
2125	Valenciennes_Rémi Gomis_2009.csv	Rémi Gomis	Valenciennes	league	2009	2022-01-29 23:46:07.489792+00
2126	Valenciennes_Rémi Gomis_2010.csv	Rémi Gomis	Valenciennes	league	2010	2022-01-29 23:46:07.490816+00
2127	Valenciennes_Rémi Gomis_2011.csv	Rémi Gomis	Valenciennes	league	2011	2022-01-29 23:46:07.491815+00
2128	Valenciennes_Rémi Gomis_2012.csv	Rémi Gomis	Valenciennes	league	2012	2022-01-29 23:46:07.49268+00
2129	Valenciennes_Rudy Mater_2009.csv	Rudy Mater	Valenciennes	league	2009	2022-01-29 23:46:07.493548+00
2130	Valenciennes_Rudy Mater_2010.csv	Rudy Mater	Valenciennes	league	2010	2022-01-29 23:46:07.494518+00
2131	Valenciennes_Rudy Mater_2011.csv	Rudy Mater	Valenciennes	league	2011	2022-01-29 23:46:07.495605+00
2132	Valenciennes_Rudy Mater_2012.csv	Rudy Mater	Valenciennes	league	2012	2022-01-29 23:46:07.496786+00
2133	Valenciennes_Siaka Tiéné_2009.csv	Siaka Tiéné	Valenciennes	league	2009	2022-01-29 23:46:07.497728+00
2134	Valenciennes_Steeven Langil_2010.csv	Steeven Langil	Valenciennes	league	2010	2022-01-29 23:46:07.498753+00
2135	Valenciennes_Vincent Aboubakar_2010.csv	Vincent Aboubakar	Valenciennes	league	2010	2022-01-29 23:46:07.499673+00
2136	Valenciennes_Vincent Aboubakar_2011.csv	Vincent Aboubakar	Valenciennes	league	2011	2022-01-29 23:46:07.500595+00
2137	Valenciennes_Vincent Aboubakar_2012.csv	Vincent Aboubakar	Valenciennes	league	2012	2022-01-29 23:46:07.501615+00
2138	Valenciennes_Younousse Sankharé_2012.csv	Younousse Sankharé	Valenciennes	league	2012	2022-01-29 23:46:07.502703+00
\.


--
-- Data for Name: run_script_scrapper_active_links; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.run_script_scrapper_active_links (id, scrapper_id, link, league, season) FROM stdin;
46	2	https://fbref.com/fr/comps/13/468/Stats-2010-2011-Ligue-1	Ligue 1	2010
47	2	https://fbref.com/fr/comps/13/401/Stats-2009-2010-Ligue-1	Ligue 1	2009
\.


--
-- Data for Name: run_script_scrapperlogs; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.run_script_scrapperlogs (id, scrapper_id, type, text, date) FROM stdin;
1	2	error	[Errno 2] No such file or directory: '/files/players_csv/Manchester Utd_Nemanja Vidić_2010.csv'	2022-01-10 21:20:34.584268+00
2	2	info	Done player Nemanja Vidić | team Manchester Utd | 2010	2022-01-10 21:20:34.59893+00
3	2	error	[Errno 2] No such file or directory: '/files/players_csv/Manchester Utd_Patrice Evra_2010.csv'	2022-01-10 21:24:26.606011+00
4	2	info	Done player Patrice Evra | team Manchester Utd | 2010	2022-01-10 21:27:32.286266+00
5	2	info	Done player Edwin van der Sar | team Manchester Utd | 2010	2022-01-10 21:28:39.28363+00
6	2	error	Cannot find teams	2022-03-03 20:25:14.077397+00
7	2	error	Cannot find teams	2022-03-03 20:27:32.805272+00
8	2	error	Cannot find teams	2022-03-03 20:53:39.270396+00
9	2	error	Cannot find teams	2022-03-03 20:56:58.554523+00
10	2	error	Cannot find teams	2022-03-03 21:00:36.528443+00
11	2	error	Cannot find teams	2022-03-03 21:01:38.572178+00
12	2	error	Cannot find teams	2022-03-03 21:02:29.815623+00
\.


--
-- Data for Name: run_script_scrappers; Type: TABLE DATA; Schema: public; Owner: valentinm
--

COPY public.run_script_scrappers (id, name, path, in_execution, enable, current_pid, errors, last_execution, site) FROM stdin;
1	Fbref Get CSV	fbref_get_csv	f	t	0	OK	2022-02-16 23:53:07.353059+00	Fbref
2	Fbref Get Players CSV	fbref_get_player_csv	f	t	0	OK	2022-03-03 21:02:52.473809+00	Fbref
6	Test	test	f	t	0	OK	2022-03-03 20:15:15.435187+00	Fbref
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 3, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 34, true);


--
-- Name: run_script_exclude_player_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.run_script_exclude_player_links_id_seq', 17, true);


--
-- Name: run_script_exclude_team_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.run_script_exclude_team_links_id_seq', 18, true);


--
-- Name: run_script_fbreflinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.run_script_fbreflinks_id_seq', 65, true);


--
-- Name: run_script_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.run_script_files_id_seq', 2138, true);


--
-- Name: run_script_scrapper_active_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.run_script_scrapper_active_links_id_seq', 47, true);


--
-- Name: run_script_scrapperlogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.run_script_scrapperlogs_id_seq', 12, true);


--
-- Name: run_script_scrappers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: valentinm
--

SELECT pg_catalog.setval('public.run_script_scrappers_id_seq', 6, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: run_script_exclude_player_links run_script_exclude_player_links_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_exclude_player_links
    ADD CONSTRAINT run_script_exclude_player_links_pkey PRIMARY KEY (id);


--
-- Name: run_script_exclude_team_links run_script_exclude_team_links_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_exclude_team_links
    ADD CONSTRAINT run_script_exclude_team_links_pkey PRIMARY KEY (id);


--
-- Name: run_script_fbreflinks run_script_fbreflinks_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_fbreflinks
    ADD CONSTRAINT run_script_fbreflinks_pkey PRIMARY KEY (id);


--
-- Name: run_script_files run_script_files_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_files
    ADD CONSTRAINT run_script_files_pkey PRIMARY KEY (id);


--
-- Name: run_script_scrapper_active_links run_script_scrapper_active_links_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_scrapper_active_links
    ADD CONSTRAINT run_script_scrapper_active_links_pkey PRIMARY KEY (id);


--
-- Name: run_script_scrapperlogs run_script_scrapperlogs_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_scrapperlogs
    ADD CONSTRAINT run_script_scrapperlogs_pkey PRIMARY KEY (id);


--
-- Name: run_script_scrappers run_script_scrappers_pkey; Type: CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.run_script_scrappers
    ADD CONSTRAINT run_script_scrappers_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: valentinm
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: valentinm
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

