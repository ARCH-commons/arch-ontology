--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3.8
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = i2b2metadata, pg_catalog;

--
-- Data for Name: table_access; Type: TABLE DATA; Schema: i2b2metadata; 
--

INSERT INTO table_access VALUES ('PCORI_ENROLL', 'PCORNET_ENROLL', 'N', 1, '\PCORI\ENROLLMENT\', 'PCORnet Enrollment', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\ENROLLMENT\', 'Export', 'PCORI CDM Enrollment', NULL, NULL, NULL, NULL);
INSERT INTO table_access VALUES ('PCORI_VISIT', 'PCORNET_ENC', 'N', 1, '\PCORI\ENCOUNTER\', 'PCORnet Encounters', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\ENCOUNTER\', 'Export', 'PCORI CDM Encounters', NULL, NULL, NULL, NULL);
INSERT INTO table_access VALUES ('PCORI_PROC', 'PCORNET_PROC', 'N', 1, '\PCORI\PROCEDURE\', 'PCORnet Procedures', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\PROCEDURE\', 'Export', 'PCORI CDM Procedure', NULL, NULL, NULL, NULL);
INSERT INTO table_access VALUES ('PCORI_DIAG', 'PCORNET_DIAG', 'N', 1, '\PCORI\DIAGNOSIS\', 'PCORnet Diagnoses', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\DIAGNOSIS\', 'Export', 'PCORI CDM Diagnosis', NULL, NULL, NULL, NULL);
INSERT INTO table_access VALUES ('PCORI_DEMO', 'PCORNET_DEMO', 'N', 1, '\PCORI\DEMOGRAPHIC\', 'PCORnet Demographics', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\DEMOGRAPHIC\', 'Export', 'PCORI CDM Demographics', NULL, NULL, NULL, NULL);
INSERT INTO table_access VALUES ('PCORI_VITAL', 'PCORNET_VITAL', 'N', 1, '\PCORI\VITAL\', 'PCORnet Vital Signs', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\VITAL\', 'Export', 'PCORI CDM Vital', NULL, NULL, NULL, NULL);
INSERT INTO table_access VALUES ('PCORI_LAB', 'pcornet_lab', 'N', 1, '\PCORI\LAB_RESULT_CM\', 'PCORnet Labs', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\LAB_RESULT_CM\', 'Export', 'PCORI CDM Labs', NULL, NULL, NULL, NULL);
INSERT INTO table_access VALUES ('PCORI_MED', 'PCORNET_MED', 'N', 1, '\PCORI\MEDICATION\', 'PCORnet Medication', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\PCORI\MEDICATION\', 'Export', 'PCORI CDM Medications', NULL, NULL, NULL, NULL);


--
-- PostgreSQL database dump complete
--

