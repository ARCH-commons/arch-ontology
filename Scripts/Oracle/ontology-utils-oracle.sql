-- Ontology utilities for Oracle
-- Only the concept dimension updater has been translated, and it is an old version. 
-- Would someone please port the rest of the utilities?
-- Jeffrey Klann, PhD

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- Procedure to update concept dimension for Oracle 
-- Note that Modifier Dimension is not finished but should be an easy project
-- Jeffrey Klann, PhD, 8/18/15
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- Updated with lower() functions to ensure proper name matching
-- Matthew Joss, 8/3/2016
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- INSTRUCTIONS: Change the schema name in the first line to match the schema that you are working in. 
-- Then run this script to load the procedure into the database. Run the loaded prodeucre by running the 
-- following command in a separate query:
-- BEGIN PCORNET_REFRESH_CDIM; END; /
-----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "PCORNET"."PCORNET_REFRESH_CDIM" is
sqltext VARCHAR(2000);
cursor getsql is
select 'insert into concept_dimension select c_dimcode AS concept_path, c_basecode AS concept_cd, c_name AS name_char, null AS concept_blob, update_date AS update_date, download_date as download_date, import_date as import_date, sourcesystem_cd as sourcesystem_cd, 1 as upload_id from '
||c_table_name||' where m_applied_path=''@'' and lower(c_tablename)=''concept_dimension'' and lower(c_columnname)=''concept_path'' and (lower(c_columndatatype)=''t'' or lower(c_columndatatype)=''n'') and lower(c_synonym_cd) = ''n'' and m_exclusion_cd is null and c_basecode is not null'
from TABLE_ACCESS where c_visualattributes like '%A%'
;
begin 
delete from concept_dimension;
OPEN getsql;
LOOP
    FETCH getsql INTO sqltext;
    EXIT WHEN getsql%NOTFOUND;
    dbms_output.put_line (sqltext);
	EXECUTE IMMEDIATE sqltext;
END LOOP;
end pcornet_refresh_cdim;