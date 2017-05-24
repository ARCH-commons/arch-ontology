# Change Log

## [v3.1](https://github.com/SCILHS/scilhs-ontology/tree/v3.1) (2017-05-24)
[Full Changelog](https://github.com/SCILHS/scilhs-ontology/compare/v2.0.2...v3.1)

**Implemented enhancements:**

- Add new CDMv3.1 elements [\#60](https://github.com/SCILHS/scilhs-ontology/issues/60)
- Move C4 and HC to CH [\#59](https://github.com/SCILHS/scilhs-ontology/issues/59)
- add basic support for loading ontology into Postgres [\#56](https://github.com/SCILHS/scilhs-ontology/issues/56)
- SCHEMES is out of date [\#53](https://github.com/SCILHS/scilhs-ontology/issues/53)
- Diagnosis: remove ICD-9 from ICD-10 tree? [\#49](https://github.com/SCILHS/scilhs-ontology/issues/49)
- Encounter: Add Age at Visit tree [\#33](https://github.com/SCILHS/scilhs-ontology/issues/33)
- Diagnosis ontology: ICD-10 tree upgrade [\#32](https://github.com/SCILHS/scilhs-ontology/issues/32)
- Update ICD-10 diagnoses to be a crosswalk ontology. [\#28](https://github.com/SCILHS/scilhs-ontology/issues/28)
- Update RxNorm ontology to newest version. [\#27](https://github.com/SCILHS/scilhs-ontology/issues/27)
- Labs: consider all LOINC codes listed by PCORI [\#24](https://github.com/SCILHS/scilhs-ontology/issues/24)
- Minor cleanup [\#23](https://github.com/SCILHS/scilhs-ontology/issues/23)
- Release new pcornet\_med ontology with pcori\_ndc and pcori\_rxnorm [\#14](https://github.com/SCILHS/scilhs-ontology/issues/14)
- Release new QT\_Breakdowns table [\#7](https://github.com/SCILHS/scilhs-ontology/issues/7)
- Enrollment-based encounters should reference visit\_dimension [\#4](https://github.com/SCILHS/scilhs-ontology/issues/4)
- Enviromental exposure might need to be smoking & non-smoking both [\#2](https://github.com/SCILHS/scilhs-ontology/issues/2)
- Age \>85 should not be queryable individually! [\#1](https://github.com/SCILHS/scilhs-ontology/issues/1)

**Fixed bugs:**

- VITALS breakdown is wrong [\#54](https://github.com/SCILHS/scilhs-ontology/issues/54)
- Medications 2.2: missing 78k NDC codes!  [\#43](https://github.com/SCILHS/scilhs-ontology/issues/43)
- About 1200 codes don't have pcori\_ndc or pcori\_rxnorm  [\#42](https://github.com/SCILHS/scilhs-ontology/issues/42)
- Diagnosis 2.1.2: wacky dimcodes [\#36](https://github.com/SCILHS/scilhs-ontology/issues/36)
- Concept dimension: inactives in the diagnoses/ICD-10 tree should be included [\#35](https://github.com/SCILHS/scilhs-ontology/issues/35)
- Demographics: large ages still queryable [\#34](https://github.com/SCILHS/scilhs-ontology/issues/34)
- dbo.stringpart function doesn't use @delimiter arg [\#31](https://github.com/SCILHS/scilhs-ontology/issues/31)
- Medications: several duplicates [\#30](https://github.com/SCILHS/scilhs-ontology/issues/30)
- Diagnosis ontology: ENCTYPE [\#29](https://github.com/SCILHS/scilhs-ontology/issues/29)
- concept\_dim updater skips hiddens but not inactives [\#25](https://github.com/SCILHS/scilhs-ontology/issues/25)
- Diagnosis ontology: PDX [\#21](https://github.com/SCILHS/scilhs-ontology/issues/21)
- meds and labs in scope now? README out of date? [\#20](https://github.com/SCILHS/scilhs-ontology/issues/20)
- ICD-10 needs PCS and c\_name fixes [\#18](https://github.com/SCILHS/scilhs-ontology/issues/18)
- Labs ontology: creatinine appears twice [\#16](https://github.com/SCILHS/scilhs-ontology/issues/16)
- Labs ontology: duplicate codes with same fullname [\#15](https://github.com/SCILHS/scilhs-ontology/issues/15)
- Ontology file import - literal "NULL" converted to actual null [\#13](https://github.com/SCILHS/scilhs-ontology/issues/13)
- PCORI\_BASECODE incorrect for some principal discharge diagnosis flags [\#11](https://github.com/SCILHS/scilhs-ontology/issues/11)
- Loading medication ontology with Oracle sqlldr results in error "column C\_TOOLTIP. second enclosure string not present" [\#10](https://github.com/SCILHS/scilhs-ontology/issues/10)
- Update schemes table [\#6](https://github.com/SCILHS/scilhs-ontology/issues/6)
- HIV RNA tests in labs should be hidden [\#5](https://github.com/SCILHS/scilhs-ontology/issues/5)
- Hispanic R refuse to answer missing from ontology [\#3](https://github.com/SCILHS/scilhs-ontology/issues/3)
- Age \\>85 should not be queryable individually! [\#1](https://github.com/SCILHS/scilhs-ontology/issues/1)

**Closed issues:**

- Medication ontology: SHRINE interop below ingredient level? [\#52](https://github.com/SCILHS/scilhs-ontology/issues/52)
- Age at visit does work in oracle  [\#51](https://github.com/SCILHS/scilhs-ontology/issues/51)
- need to correct metadata for non-hisppanic in demographics [\#50](https://github.com/SCILHS/scilhs-ontology/issues/50)
- SCILHS ontology meta data tables do not include indexes for labs [\#48](https://github.com/SCILHS/scilhs-ontology/issues/48)
- c\_fullname in pcornet\_lab fix. Connies issue \#3. [\#46](https://github.com/SCILHS/scilhs-ontology/issues/46)
- 'Hispanic' demographic fix. Connies issue \#2. [\#45](https://github.com/SCILHS/scilhs-ontology/issues/45)
- c\_tooltip in pcornet\_lab update. Connies Issue \#1. [\#44](https://github.com/SCILHS/scilhs-ontology/issues/44)
- c\_dimcode needs a fix for several more pcornet\_agetree.txt rows [\#39](https://github.com/SCILHS/scilhs-ontology/issues/39)
- How are the "D~s1uh" parts of Diagnosis paths computed? [\#38](https://github.com/SCILHS/scilhs-ontology/issues/38)
- pcornet\_agetree weird c\_dimcode for Age 24 [\#37](https://github.com/SCILHS/scilhs-ontology/issues/37)
- Same Dx and PX c\_basecodes [\#26](https://github.com/SCILHS/scilhs-ontology/issues/26)

## [v2.0.2](https://github.com/SCILHS/scilhs-ontology/tree/v2.0.2) (2015-12-16)
[Full Changelog](https://github.com/SCILHS/scilhs-ontology/compare/*CDM ontology, first major update*...v2.0.2)


# Manual Changelog
---------

*6/13/14* - initial release

## *CDM ontology, first major update*

*6/24/14* -

-   Changed export format (brackets no longer surround dates, null values are empty rather than “(null)”, file type is ASCII)

-   Set all update\_date fields to be non-null

-   Corrected foreign characters, long hyphens, and backquotes that were invalid (content changes were mostly in the ICD-10 tree, a few in ICD-9 and HCPCS, the rest were in tooltips)

-   Fixed invalid c\_path and c\_symbol entries (not required for querying, SHRINE, or SMART - used by some tools like Lori’s mapping validator).

*6/25/14* - Released TABLE\_ACCESS in same export format as main table.

*6/26/14* - Minor changes to ontology

-   BMI no longer greyed out

-   Only top-level folders are cases

-   Modifiers have been excluded from top-level folders (they are unqueryable anyway)

*7/10/14* -

-   ***7/1/14***

  -   Age buckets had some errors in basecode, trailing slashes, c\_path, and c\_symbol

  -   Some metadata XML was missing the XML header (but only for hidden elements)

  -   Line breaks removed from metadata XML (to ease importing)

-   ***7/7/14***

  -   Biobank flag = No is hidden now; this should not have been queryable

-   ***7/10/14***

  -   Made all terms editable

  -   Added version of tooltip column without linebreaks

## *Patch 7/14*

*7/22/14* - 399,921 rows

-   Added 129 ICD-9 codes that were retired by 2014AA but are still used.

-   Fixed an error in the dimcodes - they matched c\_path instead of c\_fullname

-   Added pcori\_basecode column.

-   Removed pipes (|) from C\_BASECODE.

*7/29/14* - LCP

-   Fixed the leaf to folder modification resulting from retired terms.

## *Ontology v1.4 (8/19/14)*

*8/4/14* -

-   Fixed three HCPCS synonyms

-   Remove linefeeds from tooltips

*8/7/14:*

-   Removed start date from Enollment/Encounter-based so it will work on all db platforms.

-   Split ontology release into six tables.

-   Made uncommon/unused terminologies inactive (SNOMED, LOINC, ICD-10).

*8/12:*

-   Removed duplicate ICD9:645 and ICD9:386.00 and renamed Sporting Injury from ICD9:E899 to ICD9:E889

*8/13:*

-   Inserted CPT\_2014AA from Bioportal into the procedures table

*8/15:*

-   Updated sourcesystem\_cd from ‘Integration\_tool’ to ‘Integration’

*8/18:*

-   Added schemes table

-   Version concepts added

-   Inactive visual attributes propagate to children

-   CPT procedure modifiers folders is now actually a modifier folder

-   Deleted basecodes from internal CMS-DRG groupings - it never appears in data

-   Fixed top-level DRG basecodes

-   Added schemes to scheme-less basecodes

-   Made dates non-null in ontology (if a date was null, it was set to the update date)

*8/19/14:*

-   Fixed errors in dimcodes on Diagnosis\\PDX and the version concepts.

-   Removed modifiers from the schemes table.

## *Vitals and enrollment tables v1.5 (10/3/14)*

*9/30/14:*

-   Modifiers had C\_FACTTABLECOLUMN=’concept\_cd’ instead of ‘modifier\_cd’.

-   chart:n is now a computed value that returns 0, and chart:y returns all patients

-   Enrollment table is fixed and reorganized - only encounter-based enrollment is now active and it is a computed value so no data needs to be entered

-   Vitals -&gt; Height had a bug and was partially set up as a modifier

-   Added vitals metadata\_xml for normal ranges and unit conversions.

-   Made NI inactive in vitals

## *Procedures table v1.5 (11/18/14)*

*11/16/14:*

-   Modifiers had C\_FACTTABLECOLUMN=’concept\_cd’ instead of ‘modifier\_cd’.

-   Made NI inactive - it is not computable

-   Merged in around 700 retired CPT codes

## *Encounters table v1.5 (12/1/14)*

*11/24/14:*

-   Made NI inactive - it is not computable

-   Added MS-DRG tree and modified the DRG tree to reflect the two coding systems

-   Changed all non-DRG queries to query the visit\_dimension

-   Changed top-level items to cases (containers)

-   Bugfixes on some encounter items, especially the null flavors

## *CDM ontology v1.5.1 (2/13/15)*

-   Diagnosis modifiers had C\_FACTTABLECOLUMN=’concept\_cd’ instead of ‘modifier\_cd’.

-   pcori\_basecode issues fixed (as defined by ontology\_fix\_script\_v5, released with the transform)

-   Made version concept appear at end of list

-   Changed C\_COLUMNDATATYPE=’T’ for BIOBANK\_FLAG:Y (queries do not run correctly if not) - this was part of a patch on 8/27/14.

-   Made NI inactive on all remaining tables.

-   Set HISPANIC yes and unknown to use dimcodes in the patient dimension by default.

-   Made changes to the pediatric age ontology per suggestions by Nate Apathy at Cerner Research:

    -   2 months: changed label from "2 months old" to "02 months old" for sorting order

    -   Changed "1 months" to "1 month" & "1 days" to "1 day"

    -   0/1/2 months: changed type to folder so days display under in hierarchy

    -   modified month ranges to be inclusive toward greater number vs. lesser number, to match format for years (e.g., “1 month old” means 0-1 months). This also fixed a bug in the Oracle version that caused months to not query properly.

    -   Note that days still follow the non-standard format (“1 day old” means 0-1 days), for backward compatibility.

## CDM ontology v1.5.2 (2/26/15)

-   More fixes to the pediatric age ontology. Now using all of Cerner Research’s modifications. Of note, “days old” now follows consistent format with other ages.

-   HCPCS tooltips (including modifiers) now follow the i2b2 standard tooltip format

-   HCPCS modifiers are now correctly placed under one modifiers tree (rather than several separate trees for different classes of modifiers)

-   The encounters .txt file mistakenly contained an unnecessary column with linefeeds in v1.5.1. This column has been removed.

-   In Encounters and Procedures, cleaned up the Data Source modifier - Unknown and Other are now hidden, and No Information is active and by default returns all records

-   In Demographics, cleaned up No Information - now always active and by default returns the count of patients with null in the specified column

-   Fixed Ethnicity: greyed-out Non-Hispanic, which is a negated term and thus doesn’t make sense in an i2b2 ontology; fixed an issue on Hispanic with c\_columnname in Oracle

-   Updated the schemes table

## CDM ontology v2.02 (8/17/15)

-   Labs 2.0: Developed initial labs tree based on CDM v2.0 specification and labs selected by SCILHS to meet PCORnet and other research requirements.

-   Meds 2.0.1: Developed initial meds tree based on CDM v3.0 specification.

-   *Developed refresh script for concept and modifier dimensions*

-   *Developed update script to add new CDM v3.0 fields to encounter, diagnosis, and vitals tables.*

-   *Added additional NDC codes to medications ontology.*

## CDM ontology v2.0.3 (12/18/15)

-   Added meds release 2.0.2a. There were some errors in the meds modifiers (incorrect type N, DI entry entirely wrong).

-   Added meds release 2.0.2b. Prevnar pediatric suspension had a null hlevel.

-   Lab modifiers had concept\_cd for facttable column (parallels meds fix in 202a).

-   Duplicates in labs table - removed

-   Modified tooltip of DX\_SOURCE:FI to explain that Final can mean ambulatory.


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*