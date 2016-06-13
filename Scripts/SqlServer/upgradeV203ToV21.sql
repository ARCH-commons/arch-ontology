---------------------------------------------------------------------------------------------------
-- Upgrade ontology from 2.0.4 to 2.1 - MSSQL
---------------------------------------------------------------------------------------------------
-- Jeff Klann, PhD 
-- Version 1.0 - 2016-04-21
-- This upgrades an existing SCILHS ontology. You can instead simply import the new ontology files.
----------------------------------------------------------------------------------------------------------------------------------------
--NOTE: This script alters data structures - it should be carefully reviewed before using
--      and it is best if each statement is run separately
-- Instructions:
-- 1) Run PCORI_MEDS_SCHEMA_CHANGE if you haven't already (see the i2p-transform project on GitHub.)
-- 2) Run ONTOLOGY-UTILS-[platform].SQL to get updated stored procedures (in the same directory as this file on GitHub)
-- 3) BACKUP!
-- 4) Run the first line of the script to delete the old ICD-10 Procedures (note that you will have to reincorporate your mappings if you have mapped them)
-- 5) Import the ICD-10-PCS-SCILHS procedures file.
-- 6) Run the rest of this script, preferably a step at a time
-- 7) Update your concept dimension, via dbo.FixConceptDim

-- Clear out the old ICD-10-PCS
-- IMPORTANT: Import the new one manually!
delete from pcornet_proc where c_fullname like '\PCORI\PROCEDURE\10\%' 
GO

-- Fix PCORI Code for PDX in diagnosis
UPDATE [PCORI_Dev].[dbo].[pcornet_diag]
SET [C_SYMBOL]='P', [PCORI_BASECODE]='P'
WHERE [C_HLEVEL]=2 AND [C_FULLNAME]='\PCORI_MOD\PDX\P\' AND [C_NAME]='Principal' AND [C_BASECODE]='1'
GO
UPDATE [PCORI_Dev].[dbo].[pcornet_diag]
SET [C_SYMBOL]='S', [PCORI_BASECODE]='S'
WHERE [C_HLEVEL]=2 AND [C_FULLNAME]='\PCORI_MOD\PDX\S\' AND [C_NAME]='Secondary' AND [C_BASECODE]='2'
GO
UPDATE [PCORI_Dev].[dbo].[pcornet_diag]
SET [C_SYMBOL]='X', [PCORI_BASECODE]='X'
WHERE [C_HLEVEL]=2 AND [C_FULLNAME]='\PCORI_MOD\PDX\X\' AND [C_NAME]='Unable to classify' AND [C_BASECODE]='0'
GO

-- Remove the extra creatinine folder
update pcornet_lab set c_fullname=replace(c_fullname,'LP31398-8','LP19403-2') where c_fullname like '%LP31398-8\CREATININE\%' 
GO
delete from pcornet_lab where c_fullname like '%\CREATININE\%' and c_tooltip like '%Renal%' and c_visualattributes like 'F%'
GO
update pcornet_lab set c_tooltip=replace(c_fullname,'Renal Function','Electrolytes') where c_fullname like '%\CREATININE\%' 
GO

-- Fix a problem with path and missing node for HepC AB
update pcornet_lab set c_fullname=replace(c_fullname,'LP43019-6','LP38332-0')
INSERT INTO [PCORI_Dev].[dbo].[pcornet_lab]([C_HLEVEL], [C_FULLNAME], [C_NAME], [C_SYNONYM_CD], [C_VISUALATTRIBUTES], [C_TOTALNUM], [C_BASECODE], [C_METADATAXML], [C_FACTTABLECOLUMN], [C_TABLENAME], [C_COLUMNNAME], [C_COLUMNDATATYPE], [C_OPERATOR], [C_DIMCODE], [C_COMMENT], [C_TOOLTIP], [M_APPLIED_PATH], [UPDATE_DATE], [DOWNLOAD_DATE], [IMPORT_DATE], [SOURCESYSTEM_CD], [VALUETYPE_CD], [M_EXCLUSION_CD], [C_PATH], [C_SYMBOL], [PCORI_SPECIMEN_SOURCE], [PCORI_BASECODE])
VALUES(6, '\PCORI\LAB_RESULT_CM\LAB_NAME\LP14855-8\LP14400-3\LP38332-0\LP43019-6\', 'Hepatitis C virus Ab [Presence] in Blood, Serum, or Plasma', 'N', 'LAE', 0, 'LOINC:43019-6', '<?xml version="1.0"?><ValueMetadata><Version>3.02</Version><CreationDateTime>12/11/2014 01:22:57</CreationDateTime><TestID>HepCAbIA</TestID><TestName>HepC Ab Immunoassay</TestName><DataType>Enum</DataType><CodeType>GRP</CodeType><Loinc>13955-0</Loinc><Flagstouse></Flagstouse><Oktousevalues>N</Oktousevalues><MaxStringLength></MaxStringLength><LowofLowValue></LowofLowValue><HighofLowValue></HighofLowValue><LowofHighValue></LowofHighValue><HighofHighValue></HighofHighValue><LowofToxicValue></LowofToxicValue><HighofToxicValue></HighofToxicValue><EnumValues><Val description="">PRESENT</Val><Val description="">ABSENT</Val><Val description="">INDETERMINATE</Val></EnumValues><CommentsDeterminingExclusion><Com></Com></CommentsDeterminingExclusion><UnitValues><NormalUnits></NormalUnits><EqualUnits></EqualUnits><ExcludingUnits></ExcludingUnits><ConvertingUnits><Units></Units><MultiplyingFactor></MultiplyingFactor></ConvertingUnits></UnitValues><Analysis><Enums /><Counts /><New /></Analysis></ValueMetadata>', 'concept_cd', 'CONCEPT_DIMENSION', 'concept_path', 'T', 'LIKE', '\PCORI\LAB_RESULT_CM\LAB_NAME\LP14855-8\LP14400-3\LP38332-0\LP43019-6\', '', 'Labs \ LOINC \ Virus \ Hepatitis C virus \ Hepatitis C virus Ab \ Hepatitis C virus Ab [Presence] in Blood, Serum, or Plasma \', '@', '20150527 17:32:53.610', '20150527 17:35:29.753', '20150527 17:35:29.790', 'SHRINE', NULL, NULL, '\PCORI\LAB_RESULT_CM\LAB_NAME\LP14855-8\LP14400-3\LP38332-0\', '43019-6', NULL, '43019-6')
GO

-- Fix literal NULL - set to ' NULL' for import tool compatibility
update pcornet_demo set c_dimcode=' NULL' where C_DIMCODE='NULL'
GO
update pcornet_enroll set c_dimcode=' NULL' where C_DIMCODE='NULL'
GO

-- Fix UNIX linefeeds in med tooltips
update  pcornet_med  set c_tooltip=replace(cast(c_tooltip as varchar(max)),char(13)+char(10),'') where c_tooltip is not null
GO
update  pcornet_med  set c_tooltip=replace(cast(c_tooltip as varchar(max)),char(10),'') where c_tooltip is not null
GO

-- Inactivate all HIV tests
update pcornet_lab set c_visualattributes=substring(c_visualattributes,1,1)+'IE' where c_fullname like '\PCORI\LAB_RESULT_CM\LAB_NAME\LP14855-8\LP17126-1\%' or c_fullname like '\PCORI\LAB_RESULT_CM\LAB_NAME\LP14855-8\LP14559-6\LP40638-6\%'
GO

-- Set encounter-based enrollment to use visit_dimension
UPDATE [PCORI_Dev].[dbo].[pcornet_enroll]
SET [C_TABLENAME]='VISIT_DIMENSION'
WHERE [C_FULLNAME]='\PCORI\ENROLLMENT\ENR_BASIS\E\' AND [C_NAME]='Encounter-based' AND [C_SYNONYM_CD]='N' AND [C_BASECODE]='ENR_BASIS:E' AND [M_EXCLUSION_CD] IS NULL
GO

-- Hispanic refuse to answer
INSERT INTO [PCORI_Dev].[dbo].[pcornet_demo]([C_HLEVEL], [C_FULLNAME], [C_NAME], [C_SYNONYM_CD], [C_VISUALATTRIBUTES], [C_TOTALNUM], [C_BASECODE], [C_METADATAXML], [C_FACTTABLECOLUMN], [C_TABLENAME], [C_COLUMNNAME], [C_COLUMNDATATYPE], [C_OPERATOR], [C_DIMCODE], [C_COMMENT], [C_TOOLTIP], [M_APPLIED_PATH], [UPDATE_DATE], [DOWNLOAD_DATE], [IMPORT_DATE], [SOURCESYSTEM_CD], [VALUETYPE_CD], [M_EXCLUSION_CD], [C_PATH], [C_SYMBOL], [PCORI_BASECODE])
VALUES(3, '\PCORI\DEMOGRAPHIC\HISPANIC\R\', 'Refuse to Answer', 'N', 'LAE', NULL, 'ETHNICITY:R', '', 'concept_cd', 'PATIENT_DIMENSION', 'RACE_CD', 'T', 'IN', '''07'',''r'',''refused''', '', 'Non-Hispanic', '@', '20140509 11:12:04.0', '20140509 11:12:04.0', '20140509 11:12:04.0', 'PCORNET_CDM', '', '', '\PCORI\DEMOGRAPHIC\HISPANIC\', 'R', 'R')
GO

-- Inactivate individual ages >85
update pcornet_demo set c_visualattributes=substring(c_visualattributes,1,1)+'IE' where c_fullname like '\PCORI\DEMOGRAPHIC\Age\>= 85 years old\%' and c_hlevel>3
GO

-- Activate ICD-10 diagnoses
update pcornet_diag set c_visualattributes=substring(c_visualattributes,1,1)+'AE' where c_fullname like '\PCORI\DIAGNOSIS\10\%' and c_visualattributes like '%I%'
GO

-- Passive/environment tobacco exposure in wrong place
UPDATE [PCORI_Dev].[dbo].[pcornet_vital]
SET [C_HLEVEL]=3, [C_FULLNAME]='\PCORI\VITAL\TOBACCO\04\', [C_DIMCODE]='\PCORI\VITAL\TOBACCO\04\', [C_PATH]='\PCORI\VITAL\TOBACCO\'
WHERE [C_FULLNAME]='\PCORI\VITAL\TOBACCO\02\04\' AND [C_NAME]='Passive Or Environmental Exposure' AND [C_BASECODE]='TOBACCO:04'
GO

-- Update dimcode, path, symbols for labs
dbo.FixOntologyDPS pcornet_lab
GO

-- Update version #s of affected tables
-- DO THIS AFTER ADDING ICD-10-PCS-2015AA
dbo.SetVersion 'pcornet_vital','2.1'
GO
dbo.SetVersion 'pcornet_diag','2.1'
GO
dbo.SetVersion 'pcornet_lab','2.1'
GO
dbo.SetVersion 'pcornet_med','2.1'
GO
dbo.SetVersion 'pcornet_enroll','2.1'
GO
dbo.SetVersion 'pcornet_demo','2.1'
GO
dbo.SetVersion 'pcornet_proc','2.1'
GO

