-- SCILHS\i2p-transform\PopMedNet-i2b2 Transform Documentation.md > 'Preparing the PopMedNet database' section

-- ASSUMES:
-- SCILHS\i2p-transform/Oracle/PCORI_MEDS_SCHEMA_CHANGE_ora.sql > Do not run old version of this with ALTER TABLE commands!

-- 'CDM' is name of schema
alter session set current_schema=CDM;

-- 'cdm' is name of user who needs access to 'CDM' schema
grant all on PCORNET_DEMO to cdm;
grant all on PCORNET_DIAG to cdm;
grant all on PCORNET_MED to cdm;  
grant all on PCORNET_PROC to cdm;
grant all on PCORNET_ENROLL to cdm;
grant all on PCORNET_VITAL to cdm;
grant all on PCORNET_ENC to cdm;
