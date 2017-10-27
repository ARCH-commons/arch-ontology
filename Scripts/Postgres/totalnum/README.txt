10/27/2017
Institute for Informatics
Washington University in St. Louis
Totalnum functions have been adapted for PostgreSQL by Dan Vianello.

Original MSSQL scripts were used from 
https://github.com/SCILHS/SCILHS-utils/tree/master/totalnum/MSSQL; 
id of GitHub commit: 7ab5cd8f679d6f32912e5f556be941a4ca428058

Instructions:
1) Load functions from totalnum_loader_postgres.sql

2) Load function runtotalnum() from runtotalnum_postgres.sql, which also will create the 
   master view with all counts for SCILHS reporting

3) Run runtotalnum() like this: select i2b2metadata.runtotalnum(); 
    