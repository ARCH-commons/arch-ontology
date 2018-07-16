
-- Set to whatever schema you're using
SET schema 'i2b2demodata' 
/
--------------------------------------------------------
--  DDL for Table pcornet_med
--------------------------------------------------------
create table pcornet_med  ( 
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(100)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null,
	"pcori_ndc"		varchar(12) null,
	"pcori_cui"		varchar(8) null
	)
/
CREATE INDEX META_FULLNAME_pcornet_med_IDX ON pcornet_med(C_FULLNAME)
/
CREATE INDEX META_APPLIED_PATH_pcornet_med_IDX ON pcornet_med(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLUSION_pcornet_med_IDX ON pcornet_med(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_pcornet_med_IDX ON pcornet_med(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_pcornet_med_IDX ON pcornet_med(C_SYNONYM_CD)
/

--------------------------------------------------------
--  DDL for Table PCORNET_DEMO
--------------------------------------------------------

create table pcornet_demo (
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(100)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null
)
/
CREATE INDEX META_FULLNAME_PCORNET_DEMO_IDX ON PCORNET_DEMO(C_FULLNAME)
/
CREATE INDEX META_APPLIED_PATH_PCORNET_DEMO_IDX ON PCORNET_DEMO(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLUSION_PCORNET_DEMO_IDX ON PCORNET_DEMO(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_PCORNET_DEMO_IDX ON PCORNET_DEMO(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_PCORNET_DEMO_IDX ON PCORNET_DEMO(C_SYNONYM_CD)
/

--------------------------------------------------------
--  DDL for Table PCORNET_DIAG
--------------------------------------------------------

create table pcornet_diag (
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(100)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null
)
/
CREATE INDEX META_FULLNAME_PCORNET_DIAG_IDX ON PCORNET_DIAG(C_FULLNAME)
/
CREATE INDEX META_APPLIED_PATH_PCORNET_DIAG_IDX ON PCORNET_DIAG(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLUSION_PCORNET_DIAG_IDX ON PCORNET_DIAG(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_PCORNET_DIAG_IDX ON PCORNET_DIAG(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_PCORNET_DIAG_IDX ON PCORNET_DIAG(C_SYNONYM_CD)
/

--------------------------------------------------------
--  DDL for Table PCORNET_ENC
--------------------------------------------------------

create table pcornet_enc (
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(100)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null
)
/
CREATE INDEX META_FULLNAME_PCORNET_ENC_IDX ON PCORNET_ENC(C_FULLNAME)
/
CREATE INDEX META_APPLIED_PATH_PCORNET_ENC_IDX ON PCORNET_ENC(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLUSION_PCORNET_ENC_IDX ON PCORNET_ENC(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_PCORNET_ENC_IDX ON PCORNET_ENC(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_PCORNET_ENC_IDX ON PCORNET_ENC(C_SYNONYM_CD)
/


--------------------------------------------------------
--  DDL for Table PCORNET_ENROLL
--------------------------------------------------------

create table pcornet_enroll (
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(100)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null
)
/
CREATE INDEX META_FULLNAME_PCORNET_ENROLL_IDX ON PCORNET_ENROLL(C_FULLNAME)
/
CREATE INDEX META_APPLIED_PATH_PCORNET_ENROLL_IDX ON PCORNET_ENROLL(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLUSION_PCORNET_ENROLL_IDX ON PCORNET_ENROLL(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_PCORNET_ENROLL_IDX ON PCORNET_ENROLL(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_PCORNET_ENROLL_IDX ON PCORNET_ENROLL(C_SYNONYM_CD)
/


--------------------------------------------------------
--  DDL for Table PCORNET_PROC
--------------------------------------------------------

create table pcornet_proc (
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(100)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null
)
/
CREATE INDEX META_FULLNAME_PCORNET_PROC_IDX ON PCORNET_PROC(C_FULLNAME)
/
CREATE INDEX META_APPLIED_PATH_PCORNET_PROC_IDX ON PCORNET_PROC(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLUSION_PCORNET_PROC_IDX ON PCORNET_PROC(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_PCORNET_PROC_IDX ON PCORNET_PROC(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_PCORNET_PROC_IDX ON PCORNET_PROC(C_SYNONYM_CD)
/

--------------------------------------------------------
--  DDL for Table PCORNET_LAB
--------------------------------------------------------

create table pcornet_lab (
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(450)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null,
	"pcori_specimen_source"		varchar(50) null
)
/
CREATE INDEX META_FULLNAME_PCORNET_LAB_IDX ON PCORNET_LAB(C_FULLNAME)
/
CREATE INDEX META_APP_PATH_PCORNET_LAB_IDX ON PCORNET_LAB(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLU_PCORNET_LAB_IDX ON PCORNET_LAB(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_PCORNET_LAB_IDX ON PCORNET_LAB(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_PCORNET_LAB_IDX ON PCORNET_LAB(C_SYNONYM_CD)
/

--------------------------------------------------------
--  DDL for Table PCORNET_VITAL
--------------------------------------------------------

create table pcornet_vital (
	"c_hlevel"			int	not null, 
	"c_fullname"			varchar(900)	not null, 
	"c_name"			varchar(2000)	not null, 
	"c_synonym_cd"			char(1)	not null, 
	"c_visualattributes"		char(3)	not null, 
	"c_totalnum"			int	null, 
	"c_basecode"			varchar(100)	null, 
	"c_metadataxml"			text	null, 
	"c_facttablecolumn"		varchar(50)	not null, 
	"c_tablename"			varchar(50)	not null, 
	"c_columnname"			varchar(50)	not null, 
	"c_columndatatype"		varchar(50)	not null, 
	"c_operator"			varchar(10)	not null, 
	"c_dimcode"			varchar(700)	not null, 
	"c_comment"			text	null, 
	"c_tooltip"			varchar(900)	null, 
	"m_applied_path"		varchar(700)	not null, 
	"update_date"			date	not null, 
	"download_date"			date	null, 
	"import_date"			date	null, 
	"sourcesystem_cd"		varchar(50)	null, 
	"valuetype_cd"			varchar(50)	null,
	"m_exclusion_cd"		varchar(25) null,
	"c_path"			varchar(700)   null,
	"c_symbol"			varchar(50)	null,
	"pcori_basecode"		varchar(50) null
)
/
CREATE INDEX META_FULLNAME_PCORNET_VITAL_IDX ON PCORNET_VITAL(C_FULLNAME)
/
CREATE INDEX META_APPLIED_PATH_PCORNET_VITAL_IDX ON PCORNET_VITAL(M_APPLIED_PATH)
/
CREATE INDEX META_EXCLUSION_PCORNET_VITAL_IDX ON PCORNET_VITAL(M_EXCLUSION_CD)
/
CREATE INDEX META_HLEVEL_PCORNET_VITAL_IDX ON PCORNET_VITAL(C_HLEVEL)
/
CREATE INDEX META_SYNONYM_PCORNET_VITAL_IDX ON PCORNET_VITAL(C_SYNONYM_CD)
/
