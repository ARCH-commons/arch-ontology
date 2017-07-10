-- Ontology utilities
-- Typical usage is to update totalnum, concept_dim, and modifier_dim after an ontology upgrade or data refresh:
--    exec dbo.RunTotalNum  -- Note the totalnum scripts must be loaded also, see below..
--    exec dbo.FixModifierDim
--    exec dbo.FixConceptDim
-- Other utilities required by other scripts also included here.
-- Updated 5/6/16
-- Jeffrey Klann, PhD


-----------------------------------------------------------------------------------------------------------------
-- Procedure to get a string part between two delimeters (i.e. a /)
-- E.g., replace(m.C_FULLNAME,dbo.stringpart(m.c_fullname,'\',m.C_HLEVEL)+'\','')
-- Jeff Klann, PhD 5/6/16
-----------------------------------------------------------------------------------------------------------------
drop function dbo.stringpart
GO
CREATE FUNCTION dbo.stringpart ( @stringToSplit VARCHAR(MAX),@delimiter char(1),@el int )
RETURNS varchar(max) 
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT
 DECLARE @num INT

 SET @num=-2
 WHILE @num!=@el and CHARINDEX(@delimiter, @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(@delimiter, @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
  SET @num=@num+1
 END

 RETURN @name
END
GO
-----------------------------------------------------------------------------------------------------------------
-- Procedure and table to strip blacklist characters from a string. Configured to remove LIKE wildcards.
-- Adapted from Rob Garrison on Stack Overflow
-- Jeff Klann, PhD 5/6/16
-----------------------------------------------------------------------------------------------------------------
-- ============================================
-- Create a table of blacklist characters
-- ============================================
IF EXISTS (SELECT * FROM sys.tables WHERE [object_id] = OBJECT_ID('dbo.CharacterBlacklist'))
  DROP TABLE dbo.CharacterBlacklist
GO
CREATE TABLE dbo.CharacterBlacklist (
    CharID              int         IDENTITY,
    DisallowedCharacter nchar(1)    NOT NULL
)
GO
INSERT INTO dbo.CharacterBlacklist (DisallowedCharacter) VALUES ('%')
INSERT INTO dbo.CharacterBlacklist (DisallowedCharacter) VALUES ('_')
INSERT INTO dbo.CharacterBlacklist (DisallowedCharacter) VALUES ('[')
INSERT INTO dbo.CharacterBlacklist (DisallowedCharacter) VALUES (']')

GO
IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID('dbo.StripBlacklistCharacters'))
  DROP FUNCTION dbo.StripBlacklistCharacters
GO
CREATE FUNCTION dbo.StripBlacklistCharacters (
    @String nvarchar(900)
)
RETURNS varchar(900)
AS BEGIN
  DECLARE @blacklistCt  int
  DECLARE @ct           int
  DECLARE @c            nchar(1)

  SELECT @blacklistCt = COUNT(*) FROM dbo.CharacterBlacklist

  SET @ct = 0
  WHILE @ct < @blacklistCt BEGIN
    SET @ct = @ct + 1

    SELECT @String = REPLACE(@String, DisallowedCharacter, '')
    FROM dbo.CharacterBlacklist
    WHERE CharID = @ct
  END

  RETURN (@String)
END
GO

-----------------------------------------------------------------------------------------------------------------
-- Run arbitrary SQL on all rows in each table listed in TABLE ACCESS with a key like 'PCORI%'
-- Jeff Klann, PhD 5/6/16
-- @Prepend, @Postpend - arguments to construct SQL e.g. @PREPEND TABLE_NAME @POSTPEND
-----------------------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'RunUpdatePCORI') AND type in (N'P', N'PC'))
DROP PROCEDURE RunUpdatePCORI
GO

create procedure dbo.RunUpdatePCORI(@Prepend varchar(max),@Postpend varchar(max)) as 

DECLARE @sqltext NVARCHAR(4000);

declare getsql cursor local for
select @Prepend+' '+c_table_name+' '+@Postpend
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
-- 6/1/17 UPDATE: Ignores ICD-9 dimcodes in I9-in-I10 tree if you've un-inactivated them
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
+c_table_name+' where m_applied_path=''@'' and c_tablename=''CONCEPT_DIMENSION'' and c_columnname=''concept_path'' and c_visualattributes not like ''%I%'' and (c_columndatatype=''T'' or c_columndatatype=''N'') and c_synonym_cd = ''N'' and (m_exclusion_cd is null or m_exclusion_cd='''') and c_basecode is not null and c_basecode!='''' and sourcesystem_cd not like ''%(I9inI10)%'''
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
-- 5/8/17 - Update to support sourcesystem_cd mappings
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
  select c_dimcode AS modifier_path, c_basecode AS modifier_cd, c_name AS name_char, c_comment AS modifier_blob, update_date, download_date, import_date, 
  CASE WHEN c_facttablecolumn=''sourcesystem_cd'' THEN c_basecode ELSE sourcesystem_cd END, 1 upload_id from '
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


-----------------------------------------------------------------------------------------------------------------
-- Procedure to fix ontology dimcodes, paths, and symbols
-- Should not cause harm to table unless you've done something non-standard
-- @table - table to update
-- Jeffrey Klann, PhD - 4/21/16
-- 6/1/17 UPDATE: Mirrors ICD-9 dimcodes in I9-in-I10 tree
-----------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FixOntologyDPS') AND type in (N'P', N'PC'))
DROP PROCEDURE FixOntologyDPS
GO

create procedure dbo.FixOntologyDPS (@table varchar(50)) as 

BEGIN 

DECLARE @sqlstr nvarchar(1000);

-- Reup the dimcodes after changes
SET @sqlstr = 'update '+ @table+ ' set c_dimcode=c_fullname where c_operator=''LIKE'''
;
execute sp_executesql @sqlstr
;

-- Set the I9-in-I10 dimcodes to be equivalent to ICD-9
SET @sqlstr = 'update ten set c_dimcode=nine.c_dimcode from ' + @table + ' ten ' +
 'inner join '+@table+' nine on ten.pcori_basecode=nine.pcori_basecode where nine.sourcesystem_cd like ''NCBO%'' and ten.sourcesystem_cd like ''RPDR%'' '+
 'and ten.c_fullname like ''\PCORI\DIAGNOSIS\10\%'' and nine.c_fullname like ''\PCORI\DIAGNOSIS\09\%'' '
;
execute sp_executesql @sqlstr
;

-- Path and symbol updater
-- Update c_path to match the required format
SET @sqlstr = 'update  ' +@table+ '  set c_path=substring(c_fullname,0,len(c_fullname)-charindex(''\'',reverse(substring(c_fullname,1,len(C_FULLNAME)-1)))+1)'
; execute sp_executesql @sqlstr ;
-- SET @sqlstr = 'update c_symbol 
SET @sqlstr = 'update  ' +@table+ '  set c_symbol=substring(c_fullname,len(c_fullname)-charindex(''\'',reverse(substring(c_fullname,1,len(C_FULLNAME)-1)))+1,50)'
; execute sp_executesql @sqlstr ;
SET @sqlstr = 'update  ' +@table+ '  set c_symbol=substring(c_symbol,1,len(C_SYMBOL)-1)'
; execute sp_executesql @sqlstr ;


END
GO


