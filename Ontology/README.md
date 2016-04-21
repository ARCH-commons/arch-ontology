# SCILHS i2b2 PCORnet Common Data Model (CDM) 
## Version 2.1 - 4/2016
##Jeff Klann, PhD

# Included Files

All ontology files are now conveniently in this single directory. Note that there are separate files for demographics for Oracle vs. SqlServer.
All other files are the same across database platforms. The Scripts directory contains database-specific utilities, discussed below.

**TABLE_ACCESS.txt**: Table access entries for the ontology.

**SCHEMES.txt:** Schemes table for the ontology.

**PCORNET_*.txt:** Current SCILHS version of all tables in the PCORnet CDM v3 spec, except for tables related to death, PRO, and clinical trials.
Note that there is a version number embedded in each of these files. This reflects when the file was last updated, not part of what release it was packaged with.
All of the ontology files are in pipe-delimited format. These are to be imported into corresponding tables in the database. 
The largest files are zipped.

# Installation
The ontology itself is in this directory. See the [installation docs](../Documentation/INSTALL.md) for information
on installing it.

# Mapping and utilities
See the [Documentation folder](../Documentation) for additional information, including mapping guidance. The [scripts directory](../scripts) also contains essential ontology utilities.
