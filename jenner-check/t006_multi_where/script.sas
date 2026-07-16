/* Adapted from Homework3.sas (exercises 2d-2e): combining WHERE clauses
   across an OR of two different condition groups, then contrasting an OR
   vs. an AND across two SAS date-literal comparisons on the same pair of
   fields. Unmodified other than sourcing MDFACWnew from a small inline
   sample instead of the course's INFILE-derived data.
   Reads the date fields via separate INFORMAT statements (one per
   variable) rather than repeating mmddyy10. inline on each INPUT token --
   the same INFORMAT-statement idiom the original Homework3.sas itself
   uses in its own MDFACW DATA step (lines 16-20 there). */

data MDFACWnew;
	informat bdate mmddyy10.;
	informat hiredate mmddyy10.;
	informat termdate mmddyy10.;
	informat ddate mmddyy10.;
	format bdate hiredate termdate ddate mmddyy10.;
	input orauid $ bdate hiredate termdate ddate age_at_first_hired age_dth diff_date;
	datalines;
A0001 03/12/1930 09/15/1999 09/20/1999 08/20/2010 25.2 80.4 0
A0002 07/22/1935 04/10/1958 . . 22.7 . -14766
A0003 07/01/1999 09/15/1999 09/16/1999 . 0.2 . 0
A0004 05/09/1940 02/20/1965 12/31/1998 03/10/2015 24.8 74.8 -12625
A0005 01/01/1999 06/15/2005 . . 6.5 . 2100
A0006 09/30/1932 03/01/1952 09/15/1999 07/04/2005 19.4 72.7 -17364
A0007 12/25/1938 08/12/1960 10/05/1985 . 21.6 . -14283
A0008 04/17/1929 05/05/1949 09/15/1999 01/01/1944 20.1 -85.3 -18395
A0009 06/06/1936 07/07/1958 11/11/1990 . 22.1 . -14954
A0010 10/10/1927 09/09/1948 09/15/1999 09/09/2001 20.9 73.9 -18632
A0011 02/14/1941 03/15/1966 . . 25.1 . .
A0012 08/08/1933 10/10/1955 09/15/1999 . 22.2 . -16045
;
run;

/*2d */
proc print DATA=MDFACWnew;
where (hiredate - termdate > 0) or (age_dth < 0 and ddate ne .);
var orauid bdate hiredate termdate ddate age_at_first_hired;
run;

/* 2e */
/* using "or" */
proc means DATA=MDFACWnew N mean stddev median min max;
where hiredate = "15SEP1999"d or bdate = "01JUL1999"d;
var age_at_first_hired age_dth;
run;

proc print DATA=MDFACWnew;
	var orauid bdate hiredate termdate ddate
	age_at_first_hired diff_date;
	where hiredate = "15SEP1999"d or bdate = "01JUL1999"d;
run;

/* using "and" */
proc means DATA=MDFACWnew N mean stddev median min max;
where hiredate = "15SEP1999"d and bdate = "01JUL1999"d;
var age_at_first_hired age_dth;
run;

proc print DATA=MDFACWnew;
	var orauid bdate hiredate termdate ddate
	age_at_first_hired diff_date;
	where hiredate = "15SEP1999"d and bdate = "01JUL1999"d;
run;
