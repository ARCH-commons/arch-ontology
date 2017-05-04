/*****************************************************
 Clean up pcori_basecode. Reset them to their original values
 and propagate them down the tree. Useful after adding local 
 mappings.
   By Jeff Klann, PhD 
   Implemented for: labs
   Last updated: 5-4-2017
********************************************************/

/*************************** LABS ***********************/

-- Clear out pcori_basecode for all LOINCS
update l set pcori_basecode=null from pcornet_lab l where c_fullname like '\PCORI\LAB_RESULT_CM\LAB_NAME\%'
GO
-- Fix all LOINC nodes
update l set l.pcori_basecode=l.c_symbol from pcornet_lab l where c_basecode like 'LOINC:%' 
GO
-- Recurse down the tree to update all child nodes
with basecode as 
( 
    select c_fullname,pcori_basecode,c_hlevel from pcornet_lab where c_basecode like 'LOINC:%' and c_basecode not like '%LP%'
   union all
    select l.c_fullname,basecode.pcori_basecode,l.c_hlevel from pcornet_lab l
    inner join basecode on basecode.c_fullname=l.c_path 
)
update l set l.pcori_basecode=basecode.pcori_basecode from pcornet_lab l inner join basecode on basecode.c_fullname=l.c_fullname
GO
-- Recurse down the tree to update all child nodes
with specimen as 
( 
    select c_fullname,pcori_specimen_source,c_hlevel from pcornet_lab where pcori_specimen_source is not null
   union all
    select l.c_fullname,specimen.pcori_specimen_source,l.c_hlevel from pcornet_lab l
    inner join specimen on specimen.c_fullname=l.c_path where l.pcori_specimen_source is null
)
update l set l.pcori_specimen_source=specimen.pcori_specimen_source from pcornet_lab l inner join specimen on specimen.c_fullname=l.c_fullname
GO