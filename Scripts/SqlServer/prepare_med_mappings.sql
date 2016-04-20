-- Prepare PCORI Mapping tables - for meds.
-- This is very similar to the prepare_lab_mappings.sql released previously.
-- To be run after data installation of the PCORI Mapping tool at:
--   https://community.i2b2.org/wiki/display/NCBO/Mapping+tools+version+1.1
-- SQL Server version (but written to be as portable as possible)
-- Jeff Klann, PhD (jeff.klann AT mgh DOT harvard DOT edu)

-- 2. Run this to reset the mapping tables for a new mapping
-- WARNING: Destroys your existing mapping!
-- NOTE: Change 'pcornet_med' to the table you want to map to.
-- NOTE: Makes an important change to sourcesystem_cd in the integration table!
delete from i2b2_map
GO
insert into i2b2_map
SELECT "C_HLEVEL", "C_FULLNAME", "C_NAME", "C_SYNONYM_CD", "C_VISUALATTRIBUTES", "C_TOTALNUM", "C_BASECODE", "C_METADATAXML", "C_FACTTABLECOLUMN", "C_TABLENAME", "C_COLUMNNAME", "C_COLUMNDATATYPE", "C_OPERATOR", "C_DIMCODE", "C_COMMENT", "C_TOOLTIP", "M_APPLIED_PATH", "UPDATE_DATE", "DOWNLOAD_DATE", "IMPORT_DATE", "SOURCESYSTEM_CD", "VALUETYPE_CD", "M_EXCLUSION_CD", "C_PATH", "C_SYMBOL", "PCORI_BASECODE"
	FROM pcornet_med
GO
update i2b2_map set c_visualattributes=replace(C_VISUALATTRIBUTES,'L','F')
GO
UPDATE MAP_TABLE_ACCESS
SET C_FULLNAME='\PCORI\MEDICATION\RXNORM_CUI\', c_name='RXNORM', c_dimcode='\PCORI\MEDICATION\RXNORM_CUI\'
WHERE C_TABLE_CD='MAP_TO' AND C_TABLE_NAME='I2B2_MAP' 
GO
delete from integration
GO
insert into integration
SELECT "C_HLEVEL", "C_FULLNAME", "C_NAME", "C_SYNONYM_CD", "C_VISUALATTRIBUTES", "C_TOTALNUM", "C_BASECODE", "C_METADATAXML", "C_FACTTABLECOLUMN", "C_TABLENAME", "C_COLUMNNAME", "C_COLUMNDATATYPE", "C_OPERATOR", "C_DIMCODE", "C_COMMENT", "C_TOOLTIP", "M_APPLIED_PATH", "UPDATE_DATE", "DOWNLOAD_DATE", "IMPORT_DATE", "SOURCESYSTEM_CD", "VALUETYPE_CD", "M_EXCLUSION_CD", "C_PATH", "C_SYMBOL", "PCORI_BASECODE"
	FROM pcornet_med
GO
update integration set SOURCESYSTEM_CD='INTEGRATION_NDC' where SOURCESYSTEM_CD='INTEGRATION_TOOL'
GO


-- 3. The last step is to populate your project_ont_mapping table with your source terms from your local i2b2 ontology
-- WARNING: Destroys your existing mapping!
-- NOTE: Replace the c_fullname of your local codes with the c_fullname of your lab tree
-- NOTE: Replace the tablename 'i2b2' with your local ontology table
delete from project_ont_mapping
GO
insert into PROJECT_ONT_MAPPING (SOURCE_BASECODE, SOURCE_NAME, SOURCE_CODING_SYSTEM, SOURCE_FULLNAME, SOURCE_TOOLTIP, SOURCE_SYMBOL, DESTINATION_FULLNAME, DESTINATION_BASECODE, DESTINATION_NAME, DESTINATION_CODING_SYSTEM, MAPPING_SOURCE, FLAG, VAR_FLAG, STATUS_CD, UPDATE_DATE, C_TOTALNUM, SOURCE_PLAIN_CODE, DESTINATION_PLAIN_CODE, SOURCE_PATH, SOURCE_PATH_BASECODE)
select c_basecode as source_basecode,c_name as source_name,sourcesystem_cd as source_coding_system, c_fullname as source_fullname,
  c_tooltip as source_tooltip,null as SOURCE_SYMBOL, null as DESTINATION_FULLNAME, null as DESTINATION_BASECODE, null as DESTINATION_NAME, 
  null as DESTINATION_CODING_SYSTEM, null as MAPPING_SOURCE, null as FLAG, null as VAR_FLAG, null as STATUS_CD,
  update_date as UPDATE_DATE, null as C_TOTALNUM, null as SOURCE_PLAIN_CODE, null as DESTINATION_PLAIN_CODE, 
  null as SOURCE_PATH,null as SOURCE_PATH_BASECODE 
 from PCORI_Mart..i2b2metadata where c_fullname like '\i2b2metadata\Medications\%' and c_visualattributes like 'LA%'
GO

-- 4. Optional - if you have a partial mapping to the destination terms, this script will add it to project_ont_mapping
-- * This script is written for mappings to NDC and will require minor modifications for RxNorm
-- NOTE: Replace 'MedMappings' with your local table name. The table is assumed to have at least two columns
--   c_basecode - corresponding to the local (non-LOINC) i2b2 c_basecode
--   c_ndc - corresponding to the normalized 11-digit NDC code without scheme prefix, e.g., NDC:00002322707 
-- (More info on NDC normalization found in section 6 here: http://www.nlm.nih.gov/research/umls/rxnorm/docs/2012/rxnorm_doco_full_2012-1.html)
-- Also assumed is that you have not changed the scheme prefix NDC:
update o set destination_basecode=p.c_basecode,destination_coding_system='NDC',destination_name=p.c_name,destination_fullname=p.C_FULLNAME
from project_ont_mapping o
inner join MedMappings l on l.c_basecode=o.source_basecode
left outer join I2B2_MAP p on p.c_basecode='NDC:'+l.c_ndc
  where (p.C_SYNONYM_CD!='Y' or p.c_synonym_cd is null)

-- 5. After integration, run this to update the PCORI-specific fields in the integration table.
update integration set pcori_basecode = i2b2_map.PCORI_BASECODE
from i2b2_map
where integration.pcori_basecode is null and integration.pcori_basecode is null
and integration.c_path = i2b2_map.C_FULLNAME

