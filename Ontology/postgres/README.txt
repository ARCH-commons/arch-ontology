10/27/2017
Institute for Informatics
Washington University in St. Louis
Team: Snehil Gupta, Connie Zabarouskaya
Contact: help@bmi.wustl.edu

PostgreSQL PCORNET Metadata Table Creation and Ontology

The shared PostgreSQL scripts for populating pcornet ontology tables have not been altered and contain customizations that have been made to the ontology to fit local data source. Please see the disclaimers for more details. 
You will need to adjust or remove those customizations to fit your environment.

Disclaimers:
Ontology for Demographics and Encounters has local BJC med codes mapped to PCORNET ontology using C_DIMCODE values.
Ontology for Vitals and Labs has local BJC med codes mapped to PCORNET codes in a child-to-parent manner.