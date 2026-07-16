/* Adapted from Homework3.sas (exercises 1-2): reads the Mound Plant working
   personnel layout via INFORMAT/FORMAT/INPUT/LABEL (same field list and
   informats as the original), then summarizes with PROC MEANS. The
   original used INFILE against a hardcoded
   /home/u64352307/HomeworkAssignments/ path; this bundle feeds the same
   DATA step a small inline DATALINES sample instead, so the bundle needs
   no data file at run time. */

data MDFACW (label="Working personnel file for Mound Plant");
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
	INFILE DATALINES DSD;
	INPUT orauid bdate sex educ hiredate termdate ddate icda8 $ autopsy dsex drace $ dcity $ dstate $ dcounty $ race $ dmvflag $ dmvdate cvs $ ssa861 $ dla seq_no;
	label orauid = "Oak Ridge assigned id number";
	label bdate = "Date of birth";
	label sex = "Sex";
	label educ = "Education";
	label hiredate = "Date of first hire at Mound";
	label termdate = "Date of last termination from Mound";
	label ddate = "Date of death";
	label icda8 = "Cause of death - ICDA 8th revision";
	label autopsy = "Autopsy";
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
	DATALINES;
A0001,03/12/1930,M,3,06/01/1955,09/15/1999,08/20/2010,I250,Y,M,W,Dayton,OH,Montgomery,W,Y,01/01/1988,D,A,08/20/2010,1
A0002,07/22/1935,F,2,04/10/1958,,,,N,,,,,,W,N,,U,U,,2
A0003,11/03/1928,M,4,01/15/1950,09/15/1999,,,U,,,,,,B,Y,03/15/1988,A,A,03/01/2010,3
A0004,05/09/1940,F,9,02/20/1965,12/31/1998,03/10/2015,I219,N,F,O,Cincinnati,OH,Hamilton,O,N,,D,N,03/10/2015,4
A0005,01/01/1999,M,1,06/15/2005,,,,N,,,,,,W,Y,05/01/1988,U,U,,5
A0006,09/30/1932,F,3,03/01/1952,09/15/1999,07/04/2005,C349,Y,F,W,Columbus,OH,Franklin,W,Y,02/01/1988,D,A,07/04/2005,6
A0007,12/25/1938,M,2,08/12/1960,10/05/1985,,,U,,,,,,B,N,,A,U,,7
A0008,04/17/1929,F,4,05/05/1949,09/15/1999,01/01/1944,I500,N,F,W,Dayton,OH,Montgomery,W,Y,04/01/1988,D,A,01/01/1944,8
A0009,06/06/1936,M,3,07/07/1958,11/11/1990,,,U,,,,,,W,N,,A,U,,9
A0010,10/10/1927,F,9,09/09/1948,09/15/1999,09/09/2001,I619,Y,F,B,Toledo,OH,Lucas,B,Y,06/01/1988,D,A,09/09/2001,10
A0011,02/14/1941,M,1,03/15/1966,,,,N,,,,,,W,N,,U,U,,11
A0012,08/08/1933,F,2,10/10/1955,09/15/1999,,,U,,,,,,O,Y,07/01/1988,A,A,05/01/2012,12
;
run;

proc means DATA=MDFACW N MEAN STDDEV MEDIAN MIN MAX;
	var ddate dla seq_no;
run;

proc print data=MDFACW (obs=5) label;
run;
