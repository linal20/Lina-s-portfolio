ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW6\problem1" bodytitle style=journal;
/*Create three new variables corresponding to the scheduled follow up visit dates for the patients, 
and display according to the four format*/
data visits;
set day16.visits;
followup1=VisitDt+30;
followup2=VisitDt+60;
followup3=VisitDt+90;

format VisitDt DATE9.;
format followup1 DDMMYY.;
format  followup2 WEEKDATE.;
format  followup3 YYMMDDD10.;

run;
/*print the first 5 observations from the dataset*/
proc print data=visits(obs=5);
run;

ods rtf close;
