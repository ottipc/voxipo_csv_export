--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

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
-- Name: voxipo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA voxipo;


ALTER SCHEMA voxipo OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: user; Type: TABLE; Schema: voxipo; Owner: postgres
--

CREATE TABLE voxipo."user" (
    id serial NOT NULL PRIMARY KEY,
    name character varying(128) NOT NULL,
    email character varying(128) NOT NULL
);


ALTER TABLE voxipo."user" OWNER TO postgres;

--
-- Name: user_vote; Type: TABLE; Schema: voxipo; Owner: postgres
--

CREATE TABLE voxipo.user_vote (
    id serial NOT NULL PRIMARY KEY,
    user_id bigint NOT NULL,
    vote_id bigint NOT NULL,
    answer boolean NOT NULL
);


ALTER TABLE voxipo.user_vote OWNER TO postgres;

--
-- Name: user_question_answer_id_seq; Type: SEQUENCE; Schema: voxipo; Owner: postgres
--

CREATE SEQUENCE IF NOT EXISTS voxipo.user_vote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE voxipo.user_vote_id_seq OWNER TO postgres;

--
-- Name: user_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: voxipo; Owner: postgres
--

ALTER SEQUENCE voxipo.user_vote_id_seq OWNED BY voxipo.user_vote.id;


--
-- Name: vote; Type: TABLE; Schema: voxipo; Owner: postgres
--

CREATE TABLE voxipo.vote (
    id integer NOT NULL PRIMARY KEY,
    continent character varying NOT NULL,
    sub_continent character varying NOT NULL,
    state character varying NOT NULL,
    ruling_party_leader character varying NOT NULL,
    political_position character varying NOT NULL,
    thumbnail character varying NOT NULL,
    picture_link character varying NOT NULL,
    question_text character varying(100) NOT NULL,
    question_details character varying NOT NULL
);


ALTER TABLE voxipo.vote OWNER TO postgres;

--
-- Name: vote_id_seq; Type: SEQUENCE; Schema: voxipo; Owner: postgres
--

CREATE SEQUENCE IF NOT EXISTS voxipo.vote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE voxipo.vote_id_seq OWNER TO postgres;

--
-- Name: vote_id_seq; Type: SEQUENCE OWNED BY; Schema: voxipo; Owner: postgres
--

ALTER SEQUENCE voxipo.vote_id_seq OWNED BY voxipo.vote.id;


--
-- Name: user_vote id; Type: DEFAULT; Schema: voxipo; Owner: postgres
--

ALTER TABLE ONLY voxipo.user_vote ALTER COLUMN id SET DEFAULT nextval('voxipo.user_vote_id_seq'::regclass);


--
-- Name: vote id; Type: DEFAULT; Schema: voxipo; Owner: postgres
--

ALTER TABLE ONLY voxipo.vote ALTER COLUMN id SET DEFAULT nextval('voxipo.vote_id_seq'::regclass);


SELECT pg_catalog.setval('voxipo.user_vote_id_seq', 84, true);


--
-- Name: vote_id_seq; Type: SEQUENCE SET; Schema: voxipo; Owner: postgres
--

SELECT pg_catalog.setval('voxipo.vote_id_seq', 1, false);


--
-- Name: user_vote fk_user_id; Type: FK CONSTRAINT; Schema: voxipo; Owner: postgres
--

ALTER TABLE ONLY voxipo.user_vote
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES voxipo."user"(id) NOT VALID;


ALTER TABLE ONLY voxipo.user_vote
    ADD CONSTRAINT fk_vote_id FOREIGN KEY (vote_id) REFERENCES voxipo."vote"(id) NOT VALID;


--
-- Name: SCHEMA voxipo; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA voxipo TO voxipo_user;


--
-- Name: TABLE "user"; Type: ACL; Schema: voxipo; Owner: postgres
--

GRANT SELECT ON TABLE voxipo."user" TO voxipo_user;


--
-- Name: TABLE user_vote; Type: ACL; Schema: voxipo; Owner: postgres
--

GRANT ALL ON TABLE voxipo.user_vote TO voxipo_user;
GRANT ALL ON TABLE voxipo.user_vote TO authenticator;


--
-- Name: SEQUENCE user_question_answer_id_seq; Type: ACL; Schema: voxipo; Owner: postgres
--

GRANT ALL ON SEQUENCE voxipo.user_vote_id_seq TO voxipo_user;


--
-- Name: TABLE vote; Type: ACL; Schema: voxipo; Owner: postgres
--

GRANT ALL ON TABLE voxipo.vote TO voxipo_user WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

