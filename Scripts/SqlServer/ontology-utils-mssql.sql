-- Ontology utilities
-- Typical usage is to update totalnum, concept_dim, and modifier_dim after an ontology upgrade or data refresh:
--    exec dbo.RunTotalNum  -- Note the totalnum scripts must be loaded also, see below..
--    exec dbo.FixModifierDim
--    exec dbo.FixConceptDim
-- Jeffrey Klann, PhD

-----------------------------------------------------------------------------------------------------------------
-- Procedure to set the version of the ontology file, used by upgrade scripts
-- Updates existing version concept
-- @table - table to update
-- @ver -- version string, to come after 'Version '
-- Jeffrey Klann, PhD - 4/21/16
-----------------------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SetVersion') AND type in (N'P', N'PC'))
DROP PROCEDURE SetVersion
GO

create procedure dbo.SetVersion (@table varchar(50),@ver varchar(10)) as 

BEGIN 

DECLARE @sqlstr nvarchar(1000);

-- Reup the dimcodes after changes
SET @sqlstr = 'update '+ @table+ ' set c_name=''zz Version '+@ver+''', c_totalnum=(select count(*) from '+@table+'),c_tooltip=''Version '+@ver+'; see count value for total rows''  where c_fullname like ''%\VERSION\'''
;
print @sqlstr
execute sp_executesql @sqlstr

END

-----------------------------------------------------------------------------------------------------------------
-- Procedure to update concept dimension
-- Jeffrey Klann, PhD - 4/21/16
-- BUGFIX from previous version - did not properly exclude inactives and include hiddens
-----------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FixConceptDim') AND type in (N'P', N'PC'))
DROP PROCEDURE FixConceptDim
GO

create procedure dbo.FixConceptDim as 

-- New code to update concept_dim
-- select c_dimcode AS modifier_path, c_basecode AS modifier_cd, c_name AS name_char, c_comment AS modifier_blob, update_date, download_date, import_date, sourcesystem_cd, 1 upload_id into modifier_dimension from PCORNET where m_applied_path!='@' and c_tablename='MODIFIER_DIMENSION' and c_columnname='modifier_path' and (c_columndatatype='T' or c_columndatatype='N') and c_synonym_cd = N and m_exclusion_cd is null and and c_basecode is not null;
DECLARE @sqltext NVARCHAR(4000);
declare getsql cursor local for
select 'insert into concept_dimension select c_dimcode AS concept_path, c_basecode AS concept_cd, c_name AS name_char, null AS concept_blob, update_date AS update_date, download_date as download_date, import_date as import_date, sourcesystem_cd as sourcesystem_cd, 1 as upload_id from '
+c_table_name+' where m_applied_path=''@'' and c_tablename=''CONCEPT_DIMENSION'' and c_columnname=''concept_path'' and c_visualattributes not like ''%I%'' and (c_columndatatype=''T'' or c_columndatatype=''N'') and c_synonym_cd = ''N'' and (m_exclusion_cd is null or m_exclusion_cd='''') and c_basecode is not null and c_basecode!='''''
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

-----------------------------------------------------------------------------------------------------------------
-- Procedure to update modifier dimension
-- Jeffrey Klann, PhD - 4/21/16
-----------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FixModifierDim') AND type in (N'P', N'PC'))
DROP PROCEDURE FixModifierDim
GO

create procedure dbo.FixModifierDim as 

-- New code to update concept_dim
-- select c_dimcode AS modifier_path, c_basecode AS modifier_cd, c_name AS name_char, c_comment AS modifier_blob, update_date, download_date, import_date, sourcesystem_cd, 1 upload_id into modifier_dimension from PCORNET where m_applied_path!='@' and c_tablename='MODIFIER_DIMENSION' and c_columnname='modifier_path' and (c_columndatatype='T' or c_columndatatype='N') and c_synonym_cd = N and m_exclusion_cd is null and and c_basecode is not null;
DECLARE @sqltext NVARCHAR(4000);
declare getsql cursor local for
select 'insert into modifier_dimension ([modifier_path], [modifier_cd], [name_char], [modifier_blob], [update_date], [download_date], [import_date], [sourcesystem_cd], [upload_id]) 
  select c_dimcode AS modifier_path, c_basecode AS modifier_cd, c_name AS name_char, c_comment AS modifier_blob, update_date, download_date, import_date, sourcesystem_cd, 1 upload_id from '
+c_table_name+'  where m_applied_path!=''@'' and c_tablename=''MODIFIER_DIMENSION'' and c_columnname=''modifier_path'' and (c_columndatatype=''T'' or c_columndatatype=''N'') and c_synonym_cd = ''N'' and (m_exclusion_cd is null or m_exclusion_cd='''') and c_basecode is not null'
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

-----------------------------------------------------------------------------------------------------------------
-- Procedure to run totalnum counts on all tables in table_access that have a key like PCORI_
-- Jeffrey Klann, PhD - 4/21/16
-- DEPENDENCY on totalnum scripts, which must be separately run. https://github.com/SCILHS/SCILHS-utils/tree/master/totalnum
-----------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'RunTotalnum') AND type in (N'P', N'PC'))
DROP PROCEDURE RunTotalnum
GO

create procedure dbo.RunTotalnum as 

DECLARE @sqltext NVARCHAR(4000);
declare getsql cursor local for
select 'exec run_all_counts '+c_table_name
from TABLE_ACCESS where c_visualattributes like '%A%' and c_table_cd like 'PCORI%'

begin
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


