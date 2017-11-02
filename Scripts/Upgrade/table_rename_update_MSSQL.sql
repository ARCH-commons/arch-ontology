--Written by Matthew Joss 2/8/17 
--update with correct table names
--change synonym table names 
--add more synonyms for old table names


sp_rename 'pmndeath_cause', 'pmndeath_condition';
go
sp_rename 'PMNPROCEDURE', 'PMNPROCEDURES';
go
sp_rename 'PMNLABRESULTS_CM', 'PMNLAB_RESULT_CM';
go


IF  EXISTS (SELECT * FROM sys.synonyms WHERE name = N'death_condition') DROP SYNONYM death_condition

IF  EXISTS (SELECT * FROM sys.synonyms WHERE name = N'pmndeath_cause') DROP SYNONYM pmndeath_cause --old form

IF  EXISTS (SELECT * FROM sys.synonyms WHERE name = N'PROCEDURES') DROP SYNONYM PROCEDURES

IF  EXISTS (SELECT * FROM sys.synonyms WHERE name = N'PMNPROCEDURE') DROP SYNONYM PMNPROCEDURE --old form

IF  EXISTS (SELECT * FROM sys.synonyms WHERE name = N'LAB_RESULT_CM') DROP SYNONYM LAB_RESULT_CM

IF  EXISTS (SELECT * FROM sys.synonyms WHERE name = N'PMNLABRESULTS_CM') DROP SYNONYM PMNLABRESULTS_CM --old form


create synonym death_condition for pmndeath_condition
GO
create synonym pmndeath_cause for pmndeath_condition --old table form
GO
create synonym PROCEDURES for PMNPROCEDURES
GO
create synonym PMNPROCEDURE for PMNPROCEDURES --old table form
GO
create synonym LAB_RESULT_CM for PMNLAB_RESULT_CM
GO
create synonym PMNLABRESULTS_CM for PMNLAB_RESULT_CM --old table form
GO
