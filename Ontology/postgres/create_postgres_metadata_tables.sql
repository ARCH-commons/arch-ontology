--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3.8
-- Dumped by pg_dump version 9.5.2

--
-- Name: i2b2metadata; Type: SCHEMA; Schema:  
--

SET search_path = i2b2metadata;


--
-- Name: pcornet_diag; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE pcornet_diag (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50)
);


--
-- Name: pcornet_lab; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE pcornet_lab (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50),
    pcori_specimen_source character varying(50)
);


--
-- Name: pcornet_med; Type: TABLE; Schema: i2b2metadata;
--

CREATE TABLE pcornet_med (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50),
    pcori_cui character varying(10),
    pcori_ndc character varying(12)
);


--
-- Name: pcornet_proc; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE pcornet_proc (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50)
);


--
-- Name: pcornet_vital; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE pcornet_vital (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50)
);


--
-- Name: pcornet_demo; Type: TABLE; Schema: i2b2metadata;
--

CREATE TABLE pcornet_demo (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50)
);


--
-- Name: pcornet_enc; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE pcornet_enc (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(2000) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50)
);


--
-- Name: pcornet_enroll; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE pcornet_enroll (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    pcori_basecode character varying(50)
);


--
-- Name: pcornet_master_vw; Type: VIEW; Schema: i2b2metadata; Owner: postgres
--

CREATE VIEW pcornet_master_vw AS
 SELECT pcornet_enroll.c_hlevel,
    pcornet_enroll.c_fullname,
    pcornet_enroll.c_name,
    pcornet_enroll.c_synonym_cd,
    pcornet_enroll.c_visualattributes,
    pcornet_enroll.c_totalnum,
    pcornet_enroll.c_basecode,
    pcornet_enroll.c_metadataxml,
    pcornet_enroll.c_facttablecolumn,
    pcornet_enroll.c_tablename,
    pcornet_enroll.c_columnname,
    pcornet_enroll.c_columndatatype,
    pcornet_enroll.c_operator,
    pcornet_enroll.c_dimcode,
    pcornet_enroll.c_comment,
    pcornet_enroll.c_tooltip,
    pcornet_enroll.m_applied_path,
    pcornet_enroll.update_date,
    pcornet_enroll.download_date,
    pcornet_enroll.import_date,
    pcornet_enroll.sourcesystem_cd,
    pcornet_enroll.valuetype_cd,
    pcornet_enroll.m_exclusion_cd,
    pcornet_enroll.c_path,
    pcornet_enroll.c_symbol,
    pcornet_enroll.pcori_basecode
   FROM pcornet_enroll
UNION ALL
 SELECT pcornet_enc.c_hlevel,
    pcornet_enc.c_fullname,
    pcornet_enc.c_name,
    pcornet_enc.c_synonym_cd,
    pcornet_enc.c_visualattributes,
    pcornet_enc.c_totalnum,
    pcornet_enc.c_basecode,
    pcornet_enc.c_metadataxml,
    pcornet_enc.c_facttablecolumn,
    pcornet_enc.c_tablename,
    pcornet_enc.c_columnname,
    pcornet_enc.c_columndatatype,
    pcornet_enc.c_operator,
    pcornet_enc.c_dimcode,
    pcornet_enc.c_comment,
    pcornet_enc.c_tooltip,
    pcornet_enc.m_applied_path,
    pcornet_enc.update_date,
    pcornet_enc.download_date,
    pcornet_enc.import_date,
    pcornet_enc.sourcesystem_cd,
    pcornet_enc.valuetype_cd,
    pcornet_enc.m_exclusion_cd,
    pcornet_enc.c_path,
    pcornet_enc.c_symbol,
    pcornet_enc.pcori_basecode
   FROM pcornet_enc
UNION ALL
 SELECT pcornet_proc.c_hlevel,
    pcornet_proc.c_fullname,
    pcornet_proc.c_name,
    pcornet_proc.c_synonym_cd,
    pcornet_proc.c_visualattributes,
    pcornet_proc.c_totalnum,
    pcornet_proc.c_basecode,
    pcornet_proc.c_metadataxml,
    pcornet_proc.c_facttablecolumn,
    pcornet_proc.c_tablename,
    pcornet_proc.c_columnname,
    pcornet_proc.c_columndatatype,
    pcornet_proc.c_operator,
    pcornet_proc.c_dimcode,
    pcornet_proc.c_comment,
    pcornet_proc.c_tooltip,
    pcornet_proc.m_applied_path,
    pcornet_proc.update_date,
    pcornet_proc.download_date,
    pcornet_proc.import_date,
    pcornet_proc.sourcesystem_cd,
    pcornet_proc.valuetype_cd,
    pcornet_proc.m_exclusion_cd,
    pcornet_proc.c_path,
    pcornet_proc.c_symbol,
    pcornet_proc.pcori_basecode
   FROM pcornet_proc
UNION ALL
 SELECT pcornet_diag.c_hlevel,
    pcornet_diag.c_fullname,
    pcornet_diag.c_name,
    pcornet_diag.c_synonym_cd,
    pcornet_diag.c_visualattributes,
    pcornet_diag.c_totalnum,
    pcornet_diag.c_basecode,
    pcornet_diag.c_metadataxml,
    pcornet_diag.c_facttablecolumn,
    pcornet_diag.c_tablename,
    pcornet_diag.c_columnname,
    pcornet_diag.c_columndatatype,
    pcornet_diag.c_operator,
    pcornet_diag.c_dimcode,
    pcornet_diag.c_comment,
    pcornet_diag.c_tooltip,
    pcornet_diag.m_applied_path,
    pcornet_diag.update_date,
    pcornet_diag.download_date,
    pcornet_diag.import_date,
    pcornet_diag.sourcesystem_cd,
    pcornet_diag.valuetype_cd,
    pcornet_diag.m_exclusion_cd,
    pcornet_diag.c_path,
    pcornet_diag.c_symbol,
    pcornet_diag.pcori_basecode
   FROM pcornet_diag
UNION ALL
 SELECT pcornet_demo.c_hlevel,
    pcornet_demo.c_fullname,
    pcornet_demo.c_name,
    pcornet_demo.c_synonym_cd,
    pcornet_demo.c_visualattributes,
    pcornet_demo.c_totalnum,
    pcornet_demo.c_basecode,
    pcornet_demo.c_metadataxml,
    pcornet_demo.c_facttablecolumn,
    pcornet_demo.c_tablename,
    pcornet_demo.c_columnname,
    pcornet_demo.c_columndatatype,
    pcornet_demo.c_operator,
    pcornet_demo.c_dimcode,
    pcornet_demo.c_comment,
    pcornet_demo.c_tooltip,
    pcornet_demo.m_applied_path,
    pcornet_demo.update_date,
    pcornet_demo.download_date,
    pcornet_demo.import_date,
    pcornet_demo.sourcesystem_cd,
    pcornet_demo.valuetype_cd,
    pcornet_demo.m_exclusion_cd,
    pcornet_demo.c_path,
    pcornet_demo.c_symbol,
    pcornet_demo.pcori_basecode
   FROM pcornet_demo
UNION ALL
 SELECT pcornet_vital.c_hlevel,
    pcornet_vital.c_fullname,
    pcornet_vital.c_name,
    pcornet_vital.c_synonym_cd,
    pcornet_vital.c_visualattributes,
    pcornet_vital.c_totalnum,
    pcornet_vital.c_basecode,
    pcornet_vital.c_metadataxml,
    pcornet_vital.c_facttablecolumn,
    pcornet_vital.c_tablename,
    pcornet_vital.c_columnname,
    pcornet_vital.c_columndatatype,
    pcornet_vital.c_operator,
    pcornet_vital.c_dimcode,
    pcornet_vital.c_comment,
    pcornet_vital.c_tooltip,
    pcornet_vital.m_applied_path,
    pcornet_vital.update_date,
    pcornet_vital.download_date,
    pcornet_vital.import_date,
    pcornet_vital.sourcesystem_cd,
    pcornet_vital.valuetype_cd,
    pcornet_vital.m_exclusion_cd,
    pcornet_vital.c_path,
    pcornet_vital.c_symbol,
    pcornet_vital.pcori_basecode
   FROM pcornet_vital
UNION ALL
 SELECT pcornet_lab.c_hlevel,
    pcornet_lab.c_fullname,
    pcornet_lab.c_name,
    pcornet_lab.c_synonym_cd,
    pcornet_lab.c_visualattributes,
    pcornet_lab.c_totalnum,
    pcornet_lab.c_basecode,
    pcornet_lab.c_metadataxml,
    pcornet_lab.c_facttablecolumn,
    pcornet_lab.c_tablename,
    pcornet_lab.c_columnname,
    pcornet_lab.c_columndatatype,
    pcornet_lab.c_operator,
    pcornet_lab.c_dimcode,
    pcornet_lab.c_comment,
    pcornet_lab.c_tooltip,
    pcornet_lab.m_applied_path,
    pcornet_lab.update_date,
    pcornet_lab.download_date,
    pcornet_lab.import_date,
    pcornet_lab.sourcesystem_cd,
    pcornet_lab.valuetype_cd,
    pcornet_lab.m_exclusion_cd,
    pcornet_lab.c_path,
    pcornet_lab.c_symbol,
    pcornet_lab.pcori_basecode
   FROM pcornet_lab
UNION ALL
 SELECT pcornet_med.c_hlevel,
    pcornet_med.c_fullname,
    pcornet_med.c_name,
    pcornet_med.c_synonym_cd,
    pcornet_med.c_visualattributes,
    pcornet_med.c_totalnum,
    pcornet_med.c_basecode,
    pcornet_med.c_metadataxml,
    pcornet_med.c_facttablecolumn,
    pcornet_med.c_tablename,
    pcornet_med.c_columnname,
    pcornet_med.c_columndatatype,
    pcornet_med.c_operator,
    pcornet_med.c_dimcode,
    pcornet_med.c_comment,
    pcornet_med.c_tooltip,
    pcornet_med.m_applied_path,
    pcornet_med.update_date,
    pcornet_med.download_date,
    pcornet_med.import_date,
    pcornet_med.sourcesystem_cd,
    pcornet_med.valuetype_cd,
    pcornet_med.m_exclusion_cd,
    pcornet_med.c_path,
    pcornet_med.c_symbol,
    pcornet_med.pcori_basecode
   FROM pcornet_med;


--
-- Name: schemes; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE schemes (
    c_key character varying(50) NOT NULL,
    c_name character varying(50) NOT NULL,
    c_description character varying(100)
);

ALTER TABLE ONLY schemes
    ADD CONSTRAINT schemes_pk PRIMARY KEY (c_key);



--
-- Name: table_access; Type: TABLE; Schema: i2b2metadata; 
--

CREATE TABLE table_access (
    c_table_cd character varying(50) NOT NULL,
    c_table_name character varying(50) NOT NULL,
    c_protected_access character(1),
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_dimtablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    c_entry_date timestamp without time zone,
    c_change_date timestamp without time zone,
    c_status_cd character(1),
    valuetype_cd character varying(50)
);



--
-- Name: idx_pcornet_demo_basecode; Type: INDEX; Schema: i2b2metadata;
--

CREATE INDEX idx_pcornet_demo_basecode ON pcornet_demo USING btree (c_basecode);


--
-- Name: idx_pcornet_demo_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_demo_dimcode ON pcornet_demo USING btree (c_dimcode);


--
-- Name: idx_pcornet_demo_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_demo_fullname ON pcornet_demo USING btree (c_fullname);


--
-- Name: idx_pcornet_demo_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_demo_pcori_basecode ON pcornet_demo USING btree (pcori_basecode);


--
-- Name: idx_pcornet_diag_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_diag_basecode ON pcornet_diag USING btree (c_basecode);


--
-- Name: idx_pcornet_diag_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_diag_dimcode ON pcornet_diag USING btree (c_dimcode);


--
-- Name: idx_pcornet_diag_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_diag_fullname ON pcornet_diag USING btree (c_fullname);


--
-- Name: idx_pcornet_diag_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_diag_pcori_basecode ON pcornet_diag USING btree (pcori_basecode);


--
-- Name: idx_pcornet_enc_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enc_basecode ON pcornet_enc USING btree (c_basecode);


--
-- Name: idx_pcornet_enc_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enc_dimcode ON pcornet_enc USING btree (c_dimcode);


--
-- Name: idx_pcornet_enc_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enc_fullname ON pcornet_enc USING btree (c_fullname);


--
-- Name: idx_pcornet_enc_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enc_pcori_basecode ON pcornet_enc USING btree (pcori_basecode);


--
-- Name: idx_pcornet_enroll_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enroll_basecode ON pcornet_enroll USING btree (c_basecode);


--
-- Name: idx_pcornet_enroll_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enroll_dimcode ON pcornet_enroll USING btree (c_dimcode);


--
-- Name: idx_pcornet_enroll_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enroll_fullname ON pcornet_enroll USING btree (c_fullname);


--
-- Name: idx_pcornet_enroll_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_enroll_pcori_basecode ON pcornet_enroll USING btree (pcori_basecode);


--
-- Name: idx_pcornet_lab_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_lab_basecode ON pcornet_lab USING btree (c_basecode);


--
-- Name: idx_pcornet_lab_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_lab_dimcode ON pcornet_lab USING btree (c_dimcode);


--
-- Name: idx_pcornet_lab_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_lab_fullname ON pcornet_lab USING btree (c_fullname);


--
-- Name: idx_pcornet_lab_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_lab_pcori_basecode ON pcornet_lab USING btree (pcori_basecode);


--
-- Name: idx_pcornet_med_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_med_basecode ON pcornet_med USING btree (c_basecode);


--
-- Name: idx_pcornet_med_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_med_dimcode ON pcornet_med USING btree (c_dimcode);


--
-- Name: idx_pcornet_med_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_med_fullname ON pcornet_med USING btree (c_fullname);


--
-- Name: idx_pcornet_med_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_med_pcori_basecode ON pcornet_med USING btree (pcori_basecode);


--
-- Name: idx_pcornet_proc_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_proc_basecode ON pcornet_proc USING btree (c_basecode);


--
-- Name: idx_pcornet_proc_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_proc_dimcode ON pcornet_proc USING btree (c_dimcode);


--
-- Name: idx_pcornet_proc_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_proc_fullname ON pcornet_proc USING btree (c_fullname);


--
-- Name: idx_pcornet_proc_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_proc_pcori_basecode ON pcornet_proc USING btree (pcori_basecode);


--
-- Name: idx_pcornet_vital_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_vital_basecode ON pcornet_vital USING btree (c_basecode);


--
-- Name: idx_pcornet_vital_dimcode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_vital_dimcode ON pcornet_vital USING btree (c_dimcode);


--
-- Name: idx_pcornet_vital_fullname; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_vital_fullname ON pcornet_vital USING btree (c_fullname);


--
-- Name: idx_pcornet_vital_pcori_basecode; Type: INDEX; Schema: i2b2metadata; 
--

CREATE INDEX idx_pcornet_vital_pcori_basecode ON pcornet_vital USING btree (pcori_basecode);





