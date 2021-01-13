
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW5\problem3" bodytitle style=journal;
/*change variable names and sort by teacher scores and curriculum */
data new (keep=TS CG Teacher);
set Teachers;
TS=TeacherScore;
CG=CurriculumGrd;
run;
proc sort data=new;by TS CG;run;
proc sort data=district;by TS CG;run;

/*merge new data made from dataset "Teacher" with dataset "District" */
data merge1;
merge new District;
by TS CG;
run;
/*print the merged dataset*/
proc print data=merge1;
run;
/*create a new dataset that eliminate any observation that does not match to a teacher*/
data mergenew;
set merge1;
if Teacher=" " then delete;
run;
/*Sort the observations by teacher name*/
proc sort data=mergenew; 
by teacher;
run;

/*Print the new dataset*/
proc print data=mergenew;
run;
ods rtf close;
