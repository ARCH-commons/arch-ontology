-- Update SCILHS CDM Ontology 2.0.2 to 2.0.3
-- Jeff Klann, PhD ; 12/18/15

-- Med modifiers have incorrect c_columndatatype
-- Med modifier type DI is incorrect
-- Prevnar pediatric suspension had a null hlevel (in meds)
-- No script provided! - You must change these manually.
 
-- Fix med and lab modifier fact table column
update pcornet_lab set c_facttablecolumn='modifier_cd'
 where c_facttablecolumn='concept_cd' and m_applied_path!='@'
GO
update pcornet_med set c_facttablecolumn='modifier_cd'
 where c_facttablecolumn='concept_cd' and m_applied_path!='@'
GO

-- Delete duplicates in labs
WITH CTE AS(
   SELECT *,
       RN = ROW_NUMBER()OVER(PARTITION BY c_dimcode ORDER BY c_dimcode)
   FROM pcornet_lab where m_exclusion_cd is null and c_synonym_cd='N'
)
DELETE FROM CTE WHERE RN > 1

-- Update dx_source:final 
UPDATE [PCORI_Dev].[dbo].[pcornet_diag]
SET [C_TOOLTIP]='Final. Ambulatory encounters would generally be expected to have a source of Final.'
WHERE [C_HLEVEL]=3 AND [C_FULLNAME]='\PCORI_MOD\CONDITION_OR_DX\DX_SOURCE\FI\' AND [C_NAME]='Final' AND [C_SYNONYM_CD]='N' AND [C_BASECODE]='DX_SOURCE:FI'
GO

-- Update tooltip for tobacco status
UPDATE [PCORI_Dev].[dbo].[pcornet_vital]
SET [C_TOOLTIP]='In SCILHS, this field is for NON-SMOKED tobacco ONLY. The PCORnet spec uses this for any form of tobacco. This field is new to v2.0 with revised value set and field definition in v3.0.'
WHERE [C_HLEVEL]=3 AND [C_FULLNAME]='\PCORI\VITAL\TOBACCO\02\' AND [C_NAME]='Non-Smoked Tobacco Status' AND [C_SYNONYM_CD]='N' AND [C_VISUALATTRIBUTES]='CAE' AND [C_TOTALNUM] IS NULL AND [C_BASECODE]=''
GO
