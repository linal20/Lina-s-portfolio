%let data_folder=C:\Users\linal\Desktop\2018\STA502;
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW5\problem2" bodytitle style=journal;
libname YearTo "&data_folder";
/*Make permanant sas files */
data quarter1;
set yearto.quarter1;
run;
data quarter2;
set yearto.quarter2;
id = _N_; 
run;
data quarter3;
set yearto.quarter3;
run;
/*sort by variable "customer"*/
proc sort data=quarter1;by customer;run;
proc sort data=quarter2;by customer;run;
proc sort data=quarter3;by customer;run;

/*merge by the variable Customer into a new permanent SAS data set called YearToDate.*/
data yearto.YearToDate;
merge quarter1 quarter2 quarter3;
by customer;
run;

proc sort data=yearto.YearToDate;
by id;
run;

data yearto.YearToDate;
set yearto.YearToDate;
drop id;
run;

/*print data print the resulting permanent YearToDate data set*/
proc print data=yearto.YearToDate;
run;
ods rtf close;
