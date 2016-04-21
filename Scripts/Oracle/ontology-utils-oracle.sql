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

CREATE OR REPLACE PROCEDURE "MEM61"."PCORNET_REFRESH_CDIM" is
sqltext VARCHAR(2000);
cursor getsql is
select 'insert into concept_dimension select c_dimcode AS concept_path, c_basecode AS concept_cd, c_name AS name_char, null AS concept_blob, update_date AS update_date, download_date as download_date, import_date as import_date, sourcesystem_cd as sourcesystem_cd, 1 as upload_id from '
||c_table_name||' where m_applied_path=''@'' and c_tablename=''CONCEPT_DIMENSION'' and c_columnname=''concept_path'' and (c_columndatatype=''T'' or c_columndatatype=''N'') and c_synonym_cd = ''N'' and m_exclusion_cd is null and c_basecode is not null'
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