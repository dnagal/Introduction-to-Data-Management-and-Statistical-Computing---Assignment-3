/* start of homework 2 */
/* exercise 1 */
libname Homework "/home/u64352307/HomeworkAssignments/";
run;

proc import OUT=Homework.MDFACW
    DATAFILE= "/home/u64352307/HomeworkAssignments/MDFACW02_d1.csv" 
    DBMS=CSV 
    REPLACE;
    GETNAMES=Yes;
    DATAROW=2; 
run;

data MDFACW (label="Working personnel file for Mound Plant");
 	INFILE "/home/u64352307/HomeworkAssignments/MDFACW02_d1.csv"  DSD firstobs=2;
  	informat orauid $8. ;
  	informat bdate MMDDYY10.;
  	informat sex $4.;
  	informat educ 4.;
  	informat hiredate MMDDYY10.;
  	informat termdate MMDDYY10.;
  	informat ddate MMDDYY10.;
  	informat icda8 $4. ;
  	informat autopsy $4.;
  	informat dsex $4.;
  	informat drace $4.;
  	informat dcity $20.;
  	informat dstate $3.;
  	informat dcounty $20.;
  	informat race $2.;
  	informat dmvflag $2.;
  	informat dmvdate MMDDYY10.;
  	informat cvs $2.;
  	informat ssa861 $2.;
  	informat dla MMDDYY10.;
 	informat seq_no  4. ;
 	format orauid $8. ;
 	format bdate MMDDYY10.;
 	format sex $4.;
 	format educ 4.;
  	format hiredate MMDDYY10.;
  	format termdate MMDDYY10.;
  	format ddate MMDDYY10.;
  	format icda8 $4. ;
  	format autopsy $4.;
  	format dsex $4.;
  	format drace $4.;
  	format dcity $20.;
  	format dstate $3.;
  	format dcounty $20.;
  	format race $2.;
  	format dmvflag $2.;
  	format dmvdate MMDDYY10.;
  	format cvs $2.;
  	format ssa861 $2.;
  	format dla MMDDYY10.;
 	format seq_no 4.;
 	INPUT orauid bdate sex educ hiredate termdate ddate icda8 $ autopsy dsex drace $ dcity $ dstate $ dcounty $ race $ dmvflag $ dmvdate cvs $ ssa861 $ dla seq_no;
 	label orauid = "Oak Ridge assigned id number";
 	label bdate = "Date of birth";
 	label sex = "Sex";
 	label educ = "Education";
	label hiredate = "Date of first hire at Mound";
	label termdate = "Date of last termination from Mound";
	label ddate = "Date of death";
	label icda8 = "Cause of death - ICDA 8th revision";
	label autopsy =	"Autopsy";
	label dsex = "Sex on death certificate";
	label drace = "Race on death certificate";
	label dcity = "The city of death";
	label dstate = "The state of death";
	label dcounty = "The county of death";
	label race = "Race of worker";
	label dmvflag = "Submitted to Ohio DMV in 1988";
	label dmvdate = "Activity date returned by DMV";
	label cvs = "Vital status EOS 1983";
	label ssa861 = "Results of a 1986 SSA submission";
	label dla = "Date last alive";
	label seq_no = "Sequence Number of Row";
run; 

/* exercise 2 */
proc means DATA=MDFACW N MEAN STDDEV MEDIAN MIN MAX;
	var ddate dla seq_no;
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

/* exercise 5 */
data MDFACW;
	SET MDFACW;
	age_at_first_hired = hiredate/365.25 - bdate/365.25;
run;

proc means DATA=MDFACW N MEAN STDDEV MEDIAN MIN MAX;
	TITLE "Age at first hired at Mound";
	var age_at_first_hired;
	class educ;
	FORMAT educ educformat.;
run;

/* exercise 6 */
proc format;
VALUE $CAUTO.
		' ' = "Not applicable"
		'0' = "No autopsy"
		'1' = "Autopsy performed"
		'N' = "No autospy performed"
		'U' = "Unknown"
		"Y" = "Autopsy performed";
VALUE $CCVS.
		'A' = "Alive"
		'D' = "Dead"
		'U' = "Unknown";
VALUE $CDMV.
		'N' = "Not found"
		'Y' = "Found";
VALUE $CDRACE. 
		'W' = "White"
		'O' = "Oriental"
		'B' = "Black"
		' ' = "Unknown";
VALUE $CDSEX.
		0 = "Male"
		1 = "Female";
VALUE $CEDUC.
		1 = "Grade School"
		2 = "Some High School"
		3 = "High School Graduate"
		4 = "Associate Degree"
		5 = "College graduate"
		6 = "Advanced Degree"
		9 = "Unknown";
VALUE $CRACE. 
		' ' = "Unknown"
		'W' = "White"
		'O' = "Oriental"
		'B' = "Black";
VALUE $CSEX.
		1 = "Male"
		2 = "Female"
		9 = "Unknown";
VALUE $CSSA.
		'A' = "Alive"
		'D' = "Dead"
		'I' = "Impossible SSN"
		'N' = "Non-match"
		'U' = "Unknown"
		"X" = "Duplicate";
run;
		
data newMDFACW;        
set MDFACW;        
format autopsy $CAUTO.
		CVS $CCVS. 
		dmvflag $CDMV.
		drace $CDRACE.
		dsex $CDSEX.
		educ CEDUC.
		race $CRACE.
		sex $CSEX.
		ssa861 $CSSA.; 
label	oruaid	= "Oak Ridge Assigned ID Number"
		bdate	= "Date of Birth"
		ddate	= "Date of Death"
		hiredate = "Date of first hire att Mound"
		termdate = "Date of Last Termination from Mound"
		dla		= "Date last alive"
		dmvdate = "Activity date returned by DMV"
		seq_no	= "Sequence Number of Row"
		sex		= "Sex"
		educ	= "Education"
		icda8	= "Cause of death -ICDA8th revision"
		autopsy	= "Autopsy"
		dsex	= "Sex on death certificate"
		drace	= "Race on death certificate"
		dcity 	= "The city of Death"
		dcounty	= "The county of death"
		race	= "Race of worker"
		dmvflag	= "Submitted to Ohio DMV in 1988"
		cvs		= "Vital status EOS 1983"
		ssa861	= "Results of a 1986 SSA Submission";	
run;

proc contents data=newMDFACW order=varnum; 
run;

/* extra code */
proc print data=MDFACW (obs=5) label;
run;

/* start of homework 3 */
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

proc means data=agebox n mean std median min max maxdec=2;
	class measure;
	var = age;
run;

proc sgplot data=agebox;
	title "Box plot of age at first hired and age at death";
	vbox value / category=measure;
run;
    
/* 1b */
proc means DATA=MDFACW N MEAN STD noobs maxdec=2;
where age_dth < 15;
var age_at_first_hired age_dth;
run;

/* 1c */
proc means DATA=MDFACW N MEAN STD noobs maxdec=2;
where age_dth ne . and age_dth < 15;
var age_at_first_hired age_dth;
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

/*2a */
proc means DATA=MDFACW N MEAN STD noobs maxdec=2;
where hiredate - termdate > 0;
var age_at_first_hired age_dth;
run;

proc print DATA=MDFACW;
where hiredate - termdate > 0;
var orauid bdate hiredate termdate ddate age_at_first_hired;
run;

/*2b */
data MDFACWnew;
set MDFACW;
date09151999="09/15/1999";
date09151999n=input(date09151999 ,MMDDYY10.);
diff_date= hiredate - date09151999n;
drop date09151999;
rename date0915199n= date0915199;
run;

proc means DATA=MDFACWnew N;
where hiredate = "15SEP1999"d;
var age_at_first_hired age_dth; 
run; 

proc print DATA=MDFACWnew;
	var orauid bdate hiredate termdate ddate
	age_at_first_hired diff_date;
	where hiredate = "15SEP1999"d;
run; 

/*2c */
proc means DATA=MDFACWnew N noobs maxdec=2;
where age_dth < 0 and ddate ne .;
var age_at_first_hired age_dth;
run;


proc print DATA=MDFACWnew;
where age_dth < 0 and ddate ne .;
var orauid bdate hiredate termdate ddate age_at_first_hired diff_date;
run;

/*2d */
proc print DATA=MDFACWnew;
where (hiredate - termdate > 0) or (age_dth < 0 and ddate ne .);
var orauid bdate hiredate termdate ddate age_at_first_hired;
run;
/* note: 6271 was in both conditions, thus 17 observations flagged */

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

