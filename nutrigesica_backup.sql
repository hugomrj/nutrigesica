--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)

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
-- Name: consultas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultas (
    id_consulta integer NOT NULL,
    paciente_id integer NOT NULL,
    fecha date DEFAULT CURRENT_DATE NOT NULL,
    motivo_consulta text,
    observaciones_generales text,
    antecedentes_salud text,
    antecedentes_familiares text,
    estilo_vida text,
    indicadores_dieteticos text,
    dieta_habitual text,
    peso_actual numeric(5,2),
    talla numeric(3,2),
    imc numeric(4,2),
    presion_arterial character varying(20)
);


ALTER TABLE public.consultas OWNER TO postgres;

--
-- Name: consultas_id_consulta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultas_id_consulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consultas_id_consulta_seq OWNER TO postgres;

--
-- Name: consultas_id_consulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultas_id_consulta_seq OWNED BY public.consultas.id_consulta;


--
-- Name: controles_peso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.controles_peso (
    id_control integer NOT NULL,
    paciente_id integer NOT NULL,
    fecha date DEFAULT CURRENT_DATE NOT NULL,
    peso numeric(5,2) NOT NULL,
    indicaciones text
);


ALTER TABLE public.controles_peso OWNER TO postgres;

--
-- Name: controles_peso_id_control_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.controles_peso_id_control_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.controles_peso_id_control_seq OWNER TO postgres;

--
-- Name: controles_peso_id_control_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.controles_peso_id_control_seq OWNED BY public.controles_peso.id_control;


--
-- Name: pacientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pacientes (
    id_paciente integer NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    edad integer,
    estado_civil character varying(50),
    ocupacion character varying(100),
    horario_laboral character varying(100),
    direccion text,
    ciudad character varying(100),
    barrio character varying(100),
    celular character varying(20),
    email character varying(150),
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.pacientes OWNER TO postgres;

--
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacientes_id_paciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pacientes_id_paciente_seq OWNER TO postgres;

--
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacientes_id_paciente_seq OWNED BY public.pacientes.id_paciente;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: consultas id_consulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas ALTER COLUMN id_consulta SET DEFAULT nextval('public.consultas_id_consulta_seq'::regclass);


--
-- Name: controles_peso id_control; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controles_peso ALTER COLUMN id_control SET DEFAULT nextval('public.controles_peso_id_control_seq'::regclass);


--
-- Name: pacientes id_paciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes ALTER COLUMN id_paciente SET DEFAULT nextval('public.pacientes_id_paciente_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultas (id_consulta, paciente_id, fecha, motivo_consulta, observaciones_generales, antecedentes_salud, antecedentes_familiares, estilo_vida, indicadores_dieteticos, dieta_habitual, peso_actual, talla, imc, presion_arterial) FROM stdin;
6	11	2026-02-25								\N	\N	\N	
7	11	2026-02-25								\N	\N	\N	
8	14	2026-02-25								\N	\N	\N	
\.


--
-- Data for Name: controles_peso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.controles_peso (id_control, paciente_id, fecha, peso, indicaciones) FROM stdin;
\.


--
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pacientes (id_paciente, nombres, apellidos, fecha_nacimiento, edad, estado_civil, ocupacion, horario_laboral, direccion, ciudad, barrio, celular, email, creado_en) FROM stdin;
1	uhuh	fsafsafa	2026-02-22	\N	\N	\N	\N	\N	\N	\N		hugomrj@gmail.com	2026-02-22 22:55:54.704648
3	kojas	fajf	2026-02-21	\N	\N	\N	\N	\N	\N	\N	444		2026-02-22 23:34:49.92474
4	kojas	ffafs	2026-02-20	\N	\N	\N	\N	\N	\N	\N		hugomrj@gmail.com1	2026-02-22 23:42:07.229874
5	Carlos Andrés	Gómez Martínez	1990-05-14	35	Soltero	Contador	08:00 - 17:00	Av. Mariscal López 1234	Asunción	Villa Morra	0981123456	carlos.gomez@example.com	2026-02-23 22:46:04.08055
6	María Fernanda	López Benítez	1985-09-22	40	Casada	Docente	07:00 - 13:00	Calle Palma 456	Asunción	Centro	0981765432	maria.lopez@example.com	2026-02-23 22:46:04.08055
7	José Luis	Ramírez Duarte	1978-12-03	47	Divorciado	Ingeniero Civil	08:00 - 18:00	Ruta 2 Km 10	San Lorenzo	Barcequillo	0971987654	jose.ramirez@example.com	2026-02-23 22:46:04.08055
8	Ana Carolina	Martínez Rojas	1995-03-30	30	Soltera	Diseñadora Gráfica	09:00 - 18:00	Av. España 789	Asunción	Recoleta	0981555777	ana.martinez@example.com	2026-02-23 22:46:04.08055
9	Ricardo Daniel	Ortiz Acosta	1982-07-11	43	Casado	Médico	Turnos rotativos	Av. Eusebio Ayala 2345	Fernando de la Mora	Zona Norte	0981999888	ricardo.ortiz@example.com	2026-02-23 22:46:04.08055
10	Ramón Ignacio	Galeano Duarte	1970-05-12	55	Casado	Contador	08:00 - 18:00	Av. Mariscal López 2240	Asunción	Recoleta	0981100200	ramon.galeano@example.com	2026-02-23 23:27:59.625807
11	María Estela	Ortiz Cardozo	1995-12-03	30	Soltera	Enfermera	Turno Rotativo	Calle Iturbe 455	Villarrica	Ybaroty	0971300400	maria.ortiz@example.com	2026-02-23 23:27:59.625807
12	Juan Bautista	Riquelme Meza	1985-03-25	40	Divorciado	Ingeniero Civil	07:00 - 16:00	Av. del Yacht 150	Lambaré	Mburucuyá	0983500600	juan.riquelme@example.com	2026-02-23 23:27:59.625807
13	Lourdes Milagros	Ayala Espínola	2001-09-14	24	Soltera	Diseñadora Gráfica	Freelance	Cerro Corá 980	San Lorenzo	Barcequillo	0991700800	lourdes.ayala@example.com	2026-02-23 23:27:59.625807
14	Gustavo Javier	Paredes Rojas	1968-07-20	57	Casado	Docente	07:00 - 12:00	Teniente Fariña 123	Caacupé	Centro	0975900100	gustavo.paredes@example.com	2026-02-23 23:27:59.625807
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password) FROM stdin;
1	demo	demo
\.


--
-- Name: consultas_id_consulta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultas_id_consulta_seq', 8, true);


--
-- Name: controles_peso_id_control_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.controles_peso_id_control_seq', 1, false);


--
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacientes_id_paciente_seq', 16, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: consultas consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas
    ADD CONSTRAINT consultas_pkey PRIMARY KEY (id_consulta);


--
-- Name: controles_peso controles_peso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controles_peso
    ADD CONSTRAINT controles_peso_pkey PRIMARY KEY (id_control);


--
-- Name: pacientes pacientes_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_email_key UNIQUE (email);


--
-- Name: pacientes pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id_paciente);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_consultas_paciente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_consultas_paciente_id ON public.consultas USING btree (paciente_id);


--
-- Name: idx_controles_peso_paciente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_controles_peso_paciente_id ON public.controles_peso USING btree (paciente_id);


--
-- Name: consultas fk_consultas_paciente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas
    ADD CONSTRAINT fk_consultas_paciente FOREIGN KEY (paciente_id) REFERENCES public.pacientes(id_paciente) ON DELETE CASCADE;


--
-- Name: controles_peso fk_controles_peso_paciente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controles_peso
    ADD CONSTRAINT fk_controles_peso_paciente FOREIGN KEY (paciente_id) REFERENCES public.pacientes(id_paciente) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

