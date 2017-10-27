-- Ontology utilities
-- Original MS SQL version prepared by Jeffrey Klann, PhD 5/6/16

-- Modified for Postgres by Brian Romine and Connie Zabarovskaya, Center for Biomedical Informatics, Washington University in St. Louis
-- 6/22/2016
-- Typical usage is to update totalnum, concept_dim, and modifier_dim after an ontology upgrade or data refresh:
--    SELECT i2b2metadata.runtotalnum  -- Note the totalnum scripts must be loaded also, see below..
--    SELECT i2b2metadata.fixmodifierdim
--    SELECT i2b2metadata.fixconceptdim
-- Other utilities required by other scripts also included here.

-- DISCLAIMER for PostgreSQL:
-- It's assumed that all functions and related tables created below will be in i2b2metadata schema, 
-- and that pcornet tables are also in i2b2metadata schema. Please adjust if necessary.
-----------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------
-- Procedure to get a string part between two delimiters (i.e. a /)
-- E.g., replace(m.C_FULLNAME,dbo.stringpart(m.c_fullname,'\',m.C_HLEVEL)+'\','')
-- Postgres Note: the function will "break up" the string using delimiter into portions and will return the el+1'th portion of the string 
-----------------------------------------------------------------------------------------------------------------

-- Postgres note: stringToSplit needs either the largest varchar or text as datatype, which would be more appropriate for varchar(max) in MS SQL
CREATE OR REPLACE FUNCTION i2b2metadata.stringpart( stringtosplit varchar(2000), delimiter char(1), el int )
RETURNS varchar(2000) 
AS $$

DECLARE 
	name varchar(255);
	pos INTEGER;
	num INTEGER; 

BEGIN 
	num := -2;
	WHILE num!=el and POSITION(delimiter in stringtosplit) > 0 
	LOOP
	pos := POSITION(delimiter in stringtosplit); 
	name := SUBSTR(stringtosplit, 1, pos-1);
	stringtosplit := SUBSTR(stringtosplit, pos+1, length(stringtosplit)-pos);
	num := num+1;
END LOOP;
RETURN name;
END
$$
LANGUAGE plpgsql VOLATILE;



-----------------------------------------------------------------------------------------------------------------
-- Procedure and table to strip blacklist characters from a string. Configured to remove LIKE wildcards.
-- Adapted from Rob Garrison on Stack Overflow
-----------------------------------------------------------------------------------------------------------------
-- ============================================
-- Create a table of blacklist characters
-- ============================================

DROP TABLE if exists i2b2metadata.characterblacklist;

CREATE TABLE i2b2metadata.characterblacklist (
    charid              SERIAL,
    disallowedcharacter char(1)	NOT NULL
);

INSERT INTO i2b2metadata.characterblacklist (disallowedcharacter) VALUES ('%');
INSERT INTO i2b2metadata.characterblacklist (disallowedcharacter) VALUES ('_');
INSERT INTO i2b2metadata.characterblacklist (disallowedcharacter) VALUES ('[');
INSERT INTO i2b2metadata.characterblacklist (disallowedcharacter) VALUES (']');


CREATE OR REPLACE FUNCTION i2b2metadata.stripblacklistcharacters (
    string varchar(900)
)
RETURNS varchar(900)
AS $$

DECLARE 
  blacklistct INTEGER;
  ct		  INTEGER;
  c			  char(1);
  
BEGIN
  ct := 0;
  blacklistct := (SELECT COUNT(*) FROM i2b2metadata.characterblacklist);
  WHILE ct < blacklistct 
	LOOP
    ct := ct + 1;
    string := (SELECT REPLACE(string, disallowedcharacter, '')
		FROM i2b2metadata.characterblacklist
		WHERE charid = ct);
END LOOP;
  RETURN string;
END;
$$
LANGUAGE plpgsql VOLATILE;
 
    
  
-----------------------------------------------------------------------------------------------------------------
-- Run arbitrary SQL on all rows in each table listed in TABLE ACCESS with a key like 'PCORI%'
-- @Prepend, @Postpend - arguments to construct SQL e.g. @PREPEND TABLE_NAME @POSTPEND
-----------------------------------------------------------------------------------------------------------------  
CREATE OR REPLACE FUNCTION i2b2metadata.runupdatepcori(prepend varchar(500),postpend varchar(500)) RETURNS VOID as 
$$
DECLARE	
	sqltext VARCHAR(4000);
	getsql cursor for
		select prepend||' i2b2metadata.'||c_table_name||' '||postpend
		from i2b2metadata.TABLE_ACCESS where c_visualattributes like '%A%' and c_table_cd like 'PCORI%';
BEGIN
OPEN getsql;
FETCH NEXT FROM getsql INTO sqltext;
LOOP
	EXECUTE sqltext;
	FETCH NEXT FROM getsql INTO sqltext;	
	IF not found THEN EXIT;
	END IF;
END LOOP;
CLOSE getsql;
END;
$$
LANGUAGE plpgsql VOLATILE;  

  
  -----------------------------------------------------------------------------------------------------------------
-- Procedure to set the version of the ontology file, used by upgrade scripts
-- Updates existing version concept
-- @tablename - table to update (in Postgres table is a reserved keyword)
-- @ver -- version string, to come after 'Version '
-----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION i2b2metadata.setversion(tablename varchar(50),ver varchar(10)) RETURNS VOID as
$$

DECLARE 
	sqlstr VARCHAR(1000);
	-- Reup the dimcodes after changes
BEGIN
	sqlstr := 'update i2b2metadata.'||tablename|| ' set c_name=''zz Version '||ver||''', c_totalnum=(select count(*) from i2b2metadata.'||tablename||'),c_tooltip=''Version '||ver||'; see count value for total rows''  where c_fullname like ''%\\VERSION\\''';
	raise info '%',sqlstr;
	execute sqlstr;
END;
$$
LANGUAGE plpgsql VOLATILE; 

-----------------------------------------------------------------------------------------------------------------
-- Procedure to update concept dimension
-- BUGFIX from previous version - did not properly exclude inactives and include hiddens
-----------------------------------------------------------------------------------------------------------------
  
CREATE OR REPLACE FUNCTION i2b2metadata.fixconceptdim() RETURNS VOID as
$$ 

-- New code to update concept_dim
-- select c_dimcode AS modifier_path, c_basecode AS modifier_cd, c_name AS name_char, c_comment AS modifier_blob, update_date, download_date, import_date, sourcesystem_cd, 1 upload_id into modifier_dimension from PCORNET where m_applied_path!='@' and c_tablename='MODIFIER_DIMENSION' and c_columnname='modifier_path' and (c_columndatatype='T' or c_columndatatype='N') and c_synonym_cd = 'N' and m_exclusion_cd is null and and c_basecode is not null;

DECLARE 
	sqltext VARCHAR(4000);
	getsql cursor for
		select 'insert into i2b2demodata.concept_dimension 
		select distinct c_dimcode AS concept_path, 
		c_basecode AS concept_cd, 
		c_name AS name_char, 
		null AS concept_blob, 
		update_date AS update_date, 
		download_date as download_date, 
		import_date as import_date, 
		sourcesystem_cd as sourcesystem_cd, 
		1 as upload_id 
		from i2b2metadata.'||c_table_name||' 
		where m_applied_path=''@'' 
		and lower(c_tablename)=''concept_dimension'' 
		and lower(c_columnname)=''concept_path''
		and c_visualattributes not like ''%I%'' 
		and (c_columndatatype=''T'' or c_columndatatype=''N'') 
		and c_synonym_cd = ''N'' 
		and (m_exclusion_cd is null or m_exclusion_cd='''') 
		and c_basecode is not null and c_basecode!=''''
		and coalesce(sourcesystem_cd,'''') not like ''%(I9inI10)%''' 
		from i2b2metadata.TABLE_ACCESS 
		where c_visualattributes like '%A%';

BEGIN
DELETE FROM i2b2demodata.concept_dimension;
OPEN getsql;
FETCH NEXT FROM getsql INTO sqltext;

LOOP
	EXECUTE sqltext;
	FETCH NEXT FROM getsql INTO sqltext;
	IF not found THEN EXIT;
	END IF;
END LOOP;
CLOSE getsql;
END;
$$
LANGUAGE plpgsql VOLATILE;

-----------------------------------------------------------------------------------------------------------------
-- Procedure to update modifier dimension
-----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION i2b2metadata.fixmodifierdim() RETURNS VOID as
$$ 

-- New code to update modifier_dim
-- select c_dimcode AS modifier_path, c_basecode AS modifier_cd, c_name AS name_char, c_comment AS modifier_blob, update_date, download_date, import_date, sourcesystem_cd, 1 upload_id into modifier_dimension from PCORNET where m_applied_path!='@' and c_tablename='MODIFIER_DIMENSION' and c_columnname='modifier_path' and (c_columndatatype='T' or c_columndatatype='N') and c_synonym_cd = N and m_exclusion_cd is null and and c_basecode is not null;

DECLARE 
	sqltext VARCHAR(4000);
	getsql cursor for
		select 'insert into i2b2demodata.modifier_dimension 
		(modifier_path, modifier_cd, name_char, modifier_blob, update_date, download_date, import_date, sourcesystem_cd, upload_id) 
		select distinct c_dimcode AS modifier_path, 
		c_basecode AS modifier_cd, 
		c_name AS name_char, 
		c_comment AS modifier_blob, 
		update_date, 
		download_date, 
		import_date, 
		sourcesystem_cd, 
		1 upload_id from i2b2metadata.'||c_table_name||'  
		where m_applied_path!=''@'' 
		and lower(c_tablename)=''modifier_dimension'' 
		and lower(c_columnname)=''modifier_path'' 
		and (c_columndatatype=''T'' or c_columndatatype=''N'') 
		and c_synonym_cd = ''N'' 
		and (m_exclusion_cd is null or m_exclusion_cd='''') 
		and c_basecode is not null'
		from i2b2metadata.TABLE_ACCESS 
		where c_visualattributes like '%A%';

BEGIN
DELETE FROM i2b2demodata.modifier_dimension;
OPEN getsql;
FETCH NEXT FROM getsql INTO sqltext;
LOOP
	EXECUTE sqltext;
	FETCH NEXT FROM getsql INTO sqltext;
	IF not found THEN EXIT;
	END IF;
END LOOP;
CLOSE getsql;
END;
$$
LANGUAGE plpgsql VOLATILE;


-----------------------------------------------------------------------------------------------------------------
-- Procedure to run totalnum counts on all tables in table_access that have a key like PCORI_
-- DEPENDENCY on totalnum scripts, which must be separately run. https://github.com/SCILHS/SCILHS-utils/tree/master/totalnum
-----------------------------------------------------------------------------------------------------------------

-- PostgreSQL Note: see the scripts separately.

-----------------------------------------------------------------------------------------------------------------
-- Procedure to fix ontology dimcodes, paths, and symbols
-- Should not cause harm to table unless you've done something non-standard
-- @table - table to update
-----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION i2b2metadata.fixontologydps(tablename character varying)
  RETURNS void AS
$BODY$
DECLARE 
	sqlstr varchar(1000);
BEGIN
	-- Reup the dimcodes after changes
	sqlstr := 'update i2b2metadata.'||tablename||' set c_dimcode=c_fullname where c_operator=''LIKE''';
	execute sqlstr;
	-- Set the I9-in-I10 dimcodes to be equivalent to ICD-9
	sqlstr :=  'do $$
	declare
	r RECORD;
	begin
		for r in 
			select distinct ten.*,nine.c_dimcode as c_dimcode_touse from i2b2metadata.'||tablename||' ten 
				inner join i2b2metadata.'||tablename||' nine on ten.pcori_basecode=nine.pcori_basecode 
				where nine.sourcesystem_cd like ''NCBO%'' 
				and ten.c_fullname like ''\\PCORI\\DIAGNOSIS\\10\\%'' 
				and nine.c_fullname like ''\\PCORI\\DIAGNOSIS\\09\\%'' 
				and ten.c_dimcode!=nine.c_dimcode 
				and ten.sourcesystem_cd = ''RPDR_2015 (I9inI10)''
			loop
				UPDATE i2b2metadata.'||tablename||' dest
					SET c_dimcode=r.c_dimcode_touse 
					WHERE dest.c_fullname = r.c_fullname 
					and dest.c_name = r.c_name 
					and dest.c_basecode = r.c_basecode
					and dest.pcori_basecode = r.pcori_basecode
					and dest.sourcesystem_cd = r.sourcesystem_cd;       
			end loop;
	end;
	$$ language plpgsql;';
	execute sqlstr;
	-- Path and symbol updater
	-- Update c_path to match the required format
	sqlstr := 'update  i2b2metadata.' ||tablename||' set c_path=substr(c_fullname,0,length(c_fullname)- position(''\'' in REVERSE(substring(c_fullname,1,length(C_FULLNAME)-1)))+1)'	;
	execute sqlstr ;
	sqlstr := 'update  i2b2metadata.' ||tablename||' set c_symbol=substr((substr(c_fullname,length(c_fullname)-position(''\'' IN reverse(substring(c_fullname,1,length(C_FULLNAME)-1)))+1,50)),1,length(substr(c_fullname,length(c_fullname)-position(''\'' IN reverse(substring(c_fullname,1,length(C_FULLNAME)-1)))+1,50))-1)'	; 
	execute sqlstr ;
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE

