
-----------------------------------------------------------------------------------------------------------------
-- Procedures to update concept and modifier dimensions - SQLServer
-- Jeffrey Klann, PhD 8/18/15
-----------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FixConceptDim') AND type in (N'P', N'PC'))
DROP PROCEDURE FixConceptDim
GO

create procedure dbo.FixConceptDim (@table varchar(50)) as 

-- New code to update concept_dim
DECLARE @sqltext NVARCHAR(4000);
declare getsql cursor local for
select 'insert into concept_dimension select c_dimcode AS concept_path, c_basecode AS concept_cd, c_name AS name_char, null AS concept_blob, update_date AS update_date, download_date as download_date, import_date as import_date, sourcesystem_cd as sourcesystem_cd, 1 as upload_id from '
+c_table_name+' where m_applied_path=''@'' and c_tablename=''CONCEPT_DIMENSION'' and c_columnname=''concept_path'' and (c_columndatatype=''T'' or c_columndatatype=''N'') and c_synonym_cd = ''N'' and m_exclusion_cd is null and c_basecode is not null and c_basecode!='''''
from TABLE_ACCESS where c_visualattributes like '%A%'

begin
delete from concept_dimension;
OPEN getsql;
FETCH NEXT FROM getsql INTO @sqltext;
WHILE @@FETCH_STATUS = 0
BEGIN
	print @sqltext
	exec sp_executesql @sqltext
	FETCH NEXT FROM getsql INTO @sqltext;	
END

CLOSE getsql;
DEALLOCATE getsql;
end

------- MODIFIER_DIMENSION -----------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FixModifierDim') AND type in (N'P', N'PC'))
DROP PROCEDURE FixModifierDim
GO

create procedure dbo.FixModifierDim as 

-- New code to update concept_dim
DECLARE @sqltext NVARCHAR(4000);
declare getsql cursor local for
select 'insert into modifier_dimension ([modifier_path], [modifier_cd], [name_char], [modifier_blob], [update_date], [download_date], [import_date], [sourcesystem_cd], [upload_id]) 
  select c_dimcode AS modifier_path, c_basecode AS modifier_cd, c_name AS name_char, c_comment AS modifier_blob, update_date, download_date, import_date, sourcesystem_cd, 1 upload_id from '
+c_table_name+'  where m_applied_path!=''@'' and c_tablename=''MODIFIER_DIMENSION'' and c_columnname=''modifier_path'' and (c_columndatatype=''T'' or c_columndatatype=''N'') and c_synonym_cd = ''N'' and m_exclusion_cd is null and c_basecode is not null'
from TABLE_ACCESS where c_visualattributes like '%A%'

begin
delete from modifier_dimension;
OPEN getsql;
FETCH NEXT FROM getsql INTO @sqltext;
WHILE @@FETCH_STATUS = 0
BEGIN
	print @sqltext
	exec sp_executesql @sqltext
	FETCH NEXT FROM getsql INTO @sqltext;	
END

CLOSE getsql;
DEALLOCATE getsql;
end
