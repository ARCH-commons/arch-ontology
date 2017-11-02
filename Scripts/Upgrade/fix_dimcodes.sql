---------------------------------------------------------------------------------------------------
-- Shorten dimcodes slightly and remove wildcard characters
-- This brings 2.1 ontology into compliance with 2.1a - MSSQL
---------------------------------------------------------------------------------------------------
-- Jeff Klann, PhD 
-- Version 1.0 - 2016-05-16
-- This upgrades an existing SCILHS ontology. You can instead simply import the new ontology files (when 2.1a becomes available)
----------------------------------------------------------------------------------------------------------------------------------------
--NOTE: This script alters data structures - it should be carefully reviewed before using
-- Instructions:
-- 1) Run ONTOLOGY-UTILS script to get updated stored procedures!
-- 2) BACKUP your ontologies and your concept/modifier dimension if you made any customizations
-- 3) Run this script to 'fix' your dimcodes and refresh your concept and modifier dimensions
--    Specifically:  Strip all LIKE dimcodes of literal _%[], replace \PCORI\TABLENAME\ with \PTAB\ 
--    (no need to modify hlevel since queries never happen at a higher level)
-- This is needed because of an obscure issue in SQLSERVER in which the query optimizer gets confused if escaped wildcard characters are used in LIKE statements
-- The query optimizer also chooses inefficient query plans if very similar long strings (i.e. deep dimcodes) are found. This shortening is a first pass at solving this,
-- but pragmatically it seems to work in the PCORI ontology.

-- Shorten the dimcodes of all PCORI tables 
-- Not speed optimized - might take 2-4min
dbo.RunUpdatePCORI 'update ', 'set c_dimcode=c_dimcode+''\'' where c_dimcode not like ''%\'' and c_operator=''LIKE''' -- Some records snuck in without the trailing slash!
GO
dbo.RunUpdatePCORI 'update ', 'set C_DIMCODE=''\P''+substring(dbo.stringpart(c_dimcode,''\'',1),1,3)+dbo.StripBlackListCharacters(substring(c_dimcode,charindex(''\'',c_dimcode,8),700)) where c_operator=''LIKE'''
GO
-- WARNING: Will delete your existing data. Do not run directly if you have customized your concept/modifier dimensions!
-- Rebuild the concept and modifier dimensions
exec FixConceptDim
GO
exec FixModifierDim
GO
