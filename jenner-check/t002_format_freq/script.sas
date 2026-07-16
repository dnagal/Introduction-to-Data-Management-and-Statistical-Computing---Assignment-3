/* Adapted from Homework3.sas (exercises 3-4): the two PROC FORMAT VALUE
   lists (educformat, $cvsformat) and the PROC FREQ calls that apply them,
   unmodified from the original other than sourcing MDFACW from a small
   inline sample instead of the course's INFILE path. */

data MDFACW;
	input orauid $ educ cvs $;
	datalines;
A0001 3 D
A0002 2 U
A0003 4 A
A0004 9 D
A0005 1 U
A0006 3 D
A0007 2 A
A0008 4 D
A0009 3 A
A0010 9 D
A0011 1 U
A0012 2 A
;
run;

proc format;
    VALUE educformat
        1 = 'Grade school'
        2 = 'Some high school'
        3 = 'High school graduate'
        4 = 'Associates Degree'
        9 = 'Unknown';
    VALUE $cvsformat
       'A' = 'Alive'
       'D' = 'Dead'
       'U' = 'Unknown';
run;

/* exercise 3 */
proc freq DATA=MDFACW;
	TABLE educ / NOCUM;
	FORMAT educ educformat.;
run;

/* exercise 4 */
proc freq DATA=MDFACW;
	TABLES cvs * educ / NOROW NOPERCENT;
	FORMAT educ educformat.
		   cvs $cvsformat.;
run;
