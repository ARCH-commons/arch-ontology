-- Prepare PCORI Mapping tables.
-- To be run after data installation of the PCORI Mapping tool at:
--   https://community.i2b2.org/wiki/display/NCBO/PCORI+Mapping+Tools+version+1.0
-- SQL Server version (but written to be as portable as possible)
-- Jeff Klann, PhD (jeff.klann AT mgh DOT harvard DOT edu)

-- 1. Run this once to add needed columns to the PCORI mapping tables
ALTER TABLE "dbo"."INTEGRATION"
	ADD "PCORI_SPECIMEN_SOURCE" varchar(50) NULL
GO
ALTER TABLE "dbo"."i2b2_map"
	ADD "PCORI_SPECIMEN_SOURCE" varchar(50) NULL
GO

-- 2. Run this to reset the mapping tables for a new mapping
-- WARNING: Destroys your existing mapping!
-- NOTE: Change 'pcornet_lab' to the table you want to map to.
delete from i2b2_map
GO
insert into i2b2_map
SELECT "C_HLEVEL", "C_FULLNAME", "C_NAME", "C_SYNONYM_CD", "C_VISUALATTRIBUTES", "C_TOTALNUM", "C_BASECODE", "C_METADATAXML", "C_FACTTABLECOLUMN", "C_TABLENAME", "C_COLUMNNAME", "C_COLUMNDATATYPE", "C_OPERATOR", "C_DIMCODE", "C_COMMENT", "C_TOOLTIP", "M_APPLIED_PATH", "UPDATE_DATE", "DOWNLOAD_DATE", "IMPORT_DATE", "SOURCESYSTEM_CD", "VALUETYPE_CD", "M_EXCLUSION_CD", "C_PATH", "C_SYMBOL", "PCORI_BASECODE","PCORI_SPECIMEN_SOURCE"
	FROM pcornet_lab
GO
update i2b2_map set c_visualattributes=replace(C_VISUALATTRIBUTES,'L','F')
GO
UPDATE MAP_TABLE_ACCESS
SET C_FULLNAME='\PCORI\LAB_RESULT_CM\LAB_NAME\', c_name='LOINC'
WHERE C_TABLE_CD='MAP_TO' AND C_TABLE_NAME='I2B2_MAP' 
GO
delete from integration
GO
insert into integration
SELECT "C_HLEVEL", "C_FULLNAME", "C_NAME", "C_SYNONYM_CD", "C_VISUALATTRIBUTES", "C_TOTALNUM", "C_BASECODE", "C_METADATAXML", "C_FACTTABLECOLUMN", "C_TABLENAME", "C_COLUMNNAME", "C_COLUMNDATATYPE", "C_OPERATOR", "C_DIMCODE", "C_COMMENT", "C_TOOLTIP", "M_APPLIED_PATH", "UPDATE_DATE", "DOWNLOAD_DATE", "IMPORT_DATE", "SOURCESYSTEM_CD", "VALUETYPE_CD", "M_EXCLUSION_CD", "C_PATH", "C_SYMBOL", "PCORI_BASECODE","PCORI_SPECIMEN_SOURCE"
	FROM pcornet_lab
GO

-- 3. The last step is to populate your project_ont_mapping table with your source terms from your local i2b2 ontology
-- WARNING: Destroys your existing mapping!
-- NOTE: Replace the c_fullname of your local codes with the c_fullname of your lab tree
delete from project_ont_mapping
GO
insert into PROJECT_ONT_MAPPING (SOURCE_BASECODE, SOURCE_NAME, SOURCE_CODING_SYSTEM, SOURCE_FULLNAME, SOURCE_TOOLTIP, SOURCE_SYMBOL, DESTINATION_FULLNAME, DESTINATION_BASECODE, DESTINATION_NAME, DESTINATION_CODING_SYSTEM, MAPPING_SOURCE, FLAG, VAR_FLAG, STATUS_CD, UPDATE_DATE, C_TOTALNUM, SOURCE_PLAIN_CODE, DESTINATION_PLAIN_CODE, SOURCE_PATH, SOURCE_PATH_BASECODE)
select c_basecode as source_basecode,c_name as source_name,sourcesystem_cd as source_coding_system, c_fullname as source_fullname,
  c_tooltip as source_tooltip,null as SOURCE_SYMBOL, null as DESTINATION_FULLNAME, null as DESTINATION_BASECODE, null as DESTINATION_NAME, 
  null as DESTINATION_CODING_SYSTEM, null as MAPPING_SOURCE, null as FLAG, null as VAR_FLAG, null as STATUS_CD,
  update_date as UPDATE_DATE, null as C_TOTALNUM, null as SOURCE_PLAIN_CODE, null as DESTINATION_PLAIN_CODE, 
  null as SOURCE_PATH,null as SOURCE_PATH_BASECODE 
 from i2b2metadata where c_fullname like '\i2b2metadata\LabTests\%' and c_visualattributes like 'LA%'
GO

-- 4. Optional - if you have a partial mapping to the destination terms, this script will add it to project_ont_mapping
-- NOTE: Replace 'RPDR_19..LabTests' with your local table name. The table is assumed to have at least two columns
--   c_basecode - corresponding to the local (non-LOINC) i2b2 c_basecode
--   c_loinc - corresponding to the LOINC code without scheme prefix, e.g., 2093-3 
-- Also assumed is that you have not changed the scheme prefix LOINC:
update o set destination_basecode=p.c_basecode,destination_coding_system='LOINC',destination_name=p.c_name,destination_fullname=p.C_FULLNAME
from project_ont_mapping o
inner join RPDR_19..LabTests l on l.c_basecode=o.source_basecode
inner join I2B2_MAP p on p.c_basecode='LOINC:'+l.c_loinc
  where p.C_SYNONYM_CD!='Y'

-- 5. This utility script will tell you how many of the ~78 lab categories have at least one mapped term.
--  (This gives a good glance at whether mapping has been adressed adequetely, assuming 
--    no terms exist in your local i2b2 as LOINC codes.)
select distinct labs.lab_cat, cnt from 
(select distinct p.c_name as lab_cat,l.c_fullname from pcornet_lab l inner join pcornet_lab p on l.c_path=p.c_fullname
  where l.C_VISUALATTRIBUTES like 'L%' and l.m_applied_path='@' and p.c_visualattributes like '%A%' and l.c_visualattributes like '%A%') labs
 left outer join
(select lab_cat, count(*) cnt from project_ont_mapping o inner join
(select distinct p.c_name as lab_cat,l.c_fullname from pcornet_lab l inner join pcornet_lab p on l.c_path=p.c_fullname
  where l.C_VISUALATTRIBUTES like 'L%' and l.m_applied_path='@' and p.c_visualattributes like '%A%' and l.c_visualattributes like '%A%') labs
 on labs.c_fullname=o.destination_fullname group by lab_cat) x on labs.lab_cat=x.lab_cat order by cnt asc

-- 6. After integration, run this to update the PCORI-specific fields in the integration table.
update integration set pcori_basecode = i2b2_map.PCORI_BASECODE, PCORI_SPECIMEN_SOURCE= i2b2_map.PCORI_SPECIMEN_SOURCE
from i2b2_map
where integration.pcori_basecode is null and integration.pcori_basecode is null
and integration.c_path = i2b2_map.C_FULLNAME

