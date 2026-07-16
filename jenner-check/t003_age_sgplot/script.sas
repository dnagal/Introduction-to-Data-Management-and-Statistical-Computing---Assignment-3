/* Adapted from Homework3.sas (exercise 1a): the age_at_first_hired /
   age_dth derivations, the "stack two measures into one variable" pattern
   used to feed PROC SGPLOT's vbox, and both PROC SGPLOT calls, unmodified
   from the original other than sourcing MDFACW from a small inline sample.
   Reads bdate/hiredate/ddate via separate INFORMAT statements (one per
   variable) rather than repeating mmddyy10. inline on each INPUT token --
   the same INFORMAT-statement idiom the original Homework3.sas itself
   uses in its own MDFACW DATA step (lines 16-20 there). */

data MDFACW;
	informat bdate mmddyy10.;
	informat hiredate mmddyy10.;
	informat ddate mmddyy10.;
	format bdate hiredate ddate mmddyy10.;
	input orauid $ bdate hiredate ddate;
	datalines;
A0001 03/12/1930 06/01/1955 08/20/2010
A0002 07/22/1935 04/10/1958 .
A0003 11/03/1928 01/15/1950 .
A0004 05/09/1940 02/20/1965 03/10/2015
A0005 01/01/1999 06/15/2005 .
A0006 09/30/1932 03/01/1952 07/04/2005
A0007 12/25/1938 08/12/1960 .
A0008 04/17/1929 05/05/1949 01/01/1944
A0009 06/06/1936 07/07/1958 .
A0010 10/10/1927 09/09/1948 09/09/2001
A0011 02/14/1941 03/15/1966 .
A0012 08/08/1933 10/10/1955 .
;
run;

data MDFACW;
	SET MDFACW;
	age_at_first_hired = hiredate/365.25 - bdate/365.25;
run;

/*1a */
data MDFACW;
	SET MDFACW;
	age_dth = (ddate - bdate)/365;
	Label age_dth = "Age of death"
		  age_at_first_hired = "Age at first hired";
run;

proc sgplot DATA=MDFACW;
histogram age_dth;
histogram age_at_first_hired;
run;

data agebox;
	SET MDFACW;
	measure = "age"; value = age_at_first_hired; output;
	measure = "dth"; value = age_dth; output;
run;

proc sgplot data=agebox;
	title "Box plot of age at first hired and age at death";
	vbox value / category=measure;
run;
