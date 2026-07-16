/* Adapted from Homework3.sas (exercises 1b-1e): the WHERE-filtered PROC
   PRINT pair that compares handling age_dth < 15 with and without an
   explicit "ne ." missing-value guard, plus the educformat PROC FORMAT
   used on the PRINT listing. Unmodified other than sourcing MDFACW from
   a small inline sample instead of the course's INFILE path.
   Reads the date fields via separate INFORMAT statements (one per
   variable) rather than repeating mmddyy10. inline on each INPUT token --
   the same INFORMAT-statement idiom the original Homework3.sas itself
   uses in its own MDFACW DATA step (lines 16-20 there).
   Note: the original exercises 1b/1c PROC MEANS statements use a bare
   NOOBS option, which is a PROC PRINT option, not a valid PROC MEANS
   option (PROC MEANS' equivalent is NONOBS) -- SAS 9.4 rejects it too,
   so those two statements are left out of this bundle rather than
   "corrected" into code the author didn't write. */

data MDFACW;
	informat bdate mmddyy10.;
	informat hiredate mmddyy10.;
	informat termdate mmddyy10.;
	informat ddate mmddyy10.;
	format bdate hiredate termdate ddate mmddyy10.;
	input orauid $ bdate sex $ educ hiredate termdate ddate age_at_first_hired age_dth;
	datalines;
A0001 03/12/1930 M 3 06/01/1955 09/15/1999 08/20/2010 25.2 80.4
A0002 07/22/1935 F 2 04/10/1958 . . 22.7 .
A0003 11/03/1928 M 4 01/15/1950 09/15/1999 . 21.2 .
A0004 05/09/1940 F 9 02/20/1965 12/31/1998 03/10/2015 24.8 74.8
A0005 01/01/1999 M 1 06/15/2005 . . 6.5 .
A0006 09/30/1932 F 3 03/01/1952 09/15/1999 07/04/2005 19.4 72.7
A0007 12/25/1938 M 2 08/12/1960 10/05/1985 . 21.6 .
A0008 04/17/1929 F 4 05/05/1949 09/15/1999 01/01/1944 20.1 -85.3
A0009 06/06/1936 M 3 07/07/1958 11/11/1990 . 22.1 .
A0010 10/10/1927 F 9 09/09/1948 09/15/1999 09/09/2001 20.9 73.9
A0011 02/14/1941 M 1 03/15/1966 . . 25.1 .
A0012 08/08/1933 F 2 10/10/1955 09/15/1999 . 22.2 .
;
run;

proc format;
    VALUE educformat
        1 = 'Grade school'
        2 = 'Some high school'
        3 = 'High school graduate'
        4 = 'Associates Degree'
        9 = 'Unknown';
run;

/* 1d */
proc print DATA=MDFACW;
where age_at_first_hired < 15 and bdate ne . and hiredate ne .;
var orauid bdate sex educ hiredate termdate ddate age_at_first_hired;
format educ educformat.;
run;

/* 1e */
proc print DATA=MDFACW;
where age_at_first_hired < 15 or age_at_first_hired > 80 and bdate ne . and hiredate ne .;
var orauid bdate sex educ hiredate termdate ddate age_at_first_hired;
format educ educformat.;
run;
