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
-- Data for Name: schemes; Type: TABLE DATA; Schema: i2b2metadata; 
--

INSERT INTO schemes VALUES ('ADMITTING_SOURCE:', 'ADMITTING_SOURCE', 'Should be populated for Inpatient Hospital Stay (IP) and Non-Acute Institutional Stay (IS) encounter');
INSERT INTO schemes VALUES ('BIOBANK_FLAG:', 'BIOBANK_FLAG', 'Flag to indicate that one or more biobanked specimens are stored and available for research use.');
INSERT INTO schemes VALUES ('CMSDRG:', 'CMSDRG', 'CMS-DRG (old version of DRG)');
INSERT INTO schemes VALUES ('CPT:', 'CPT', 'CPT-4');
INSERT INTO schemes VALUES ('DEM|AGE:', 'AGE', 'Age');
INSERT INTO schemes VALUES ('DISCHARGE_DISPOSITION:', 'DISCHARGE_DISPOSITION', 'Vital status at discharge.');
INSERT INTO schemes VALUES ('DISCHARGE_STATUS:', 'DISCHARGE_STATUS', 'Discharge status.');
INSERT INTO schemes VALUES ('ENCTYPE:', 'ENCTYPE', 'Encounter type.');
INSERT INTO schemes VALUES ('ENR_BASIS:', 'ENR_BASIS', 'When insurance information is not available but complete capture can be asserted some other way.');
INSERT INTO schemes VALUES ('ETHNICITY:', 'ETHNICITY', 'Ethnicity');
INSERT INTO schemes VALUES ('HCPCS:', 'HCPCS', 'HCPCS');
INSERT INTO schemes VALUES ('ICD10:', 'ICD10', 'ICD-10');
INSERT INTO schemes VALUES ('ICD9:', 'ICD9', 'ICD-9');
INSERT INTO schemes VALUES ('LOCATION_CODE:', 'LOCATION_CODE', 'Facility location code.');
INSERT INTO schemes VALUES ('MSDRG:', 'MSDRG', 'MS-DRG (current version of DRG)');
INSERT INTO schemes VALUES ('RACE:', 'RACE', 'One race value per patient.');
INSERT INTO schemes VALUES ('SEX:', 'SEX', 'Administrative Sex');
INSERT INTO schemes VALUES ('VITAL:', 'VITAL', 'Blood pressure (in mmHg). Only populated if measure was taken on this date.');


--
-- PostgreSQL database dump complete
--

