ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW11\problem1-1" bodytitle style=journal;
/*header
Purpose:  Write a MACRO program that will input four macro variables 
The MACRO will then produce a scatterplot with overlayed regression line using PROC SGPLOT from dataset DS with corresponding X and
Y with a proper TITLE. 
Input: study_gpa..sas7bdat/
*/


libname HW11 "C:\Users\linal\Desktop\2018\STA502";

data study_gpa;
set HW11.study_gpa;
run;

%macro plotreg(DS=,title=, xvar=,yvar=,xlabel=,ylabel=);
proc sgplot data=&DS;
title &title;
scatter y=&yvar x=&xvar;
reg y=&yvar x=&xvar;
xaxis label=&xlabel; 
yaxis label=&ylabel; 
keylegend/location=inside position=bottomright ;
run;
%mend plotreg;

%plotreg(DS=study_gpa,title="Regression the term GPA on the average time studied", xvar=AveTime
,yvar=GPA,xlabel="the average time studied",ylabel="the term GPA")



%plotreg(DS=study_gpa,title="Regression  the term GPA on the number of units enrolled", xvar=Units
,yvar=GPA,xlabel="the number of units enrolled",ylabel="the term GPA")

ods rtf close;
