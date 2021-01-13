
/*create a library*/
libname hw2 "C:\Users\linal\Desktop\2018\STA502\HW2";

/*EX1-(a) Import a data into SAS*/
proc import datafile="C:\Users\linal\Desktop\2018\STA502\HW2\Pizza.csv" 
out=Pizimport_excel
dbms=csv replace;
getnames=yes;
run;
/*save a dataset in permernant library*/
data hw2.topping;
set work.Pizimport_excel;
run;
/*EX1-(b) describes the contents of the data set*/
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW1\problem1" bodytitle style=journal;
title "EX1 Survey about Customer's Preferance for New Toppings";

proc contents data=hw2.topping;
run;

/*EX1-(a) select only last 4 observations*/

data topping2;
set hw2.topping nobs=__nobs;
  if _n_ gt __nobs-4;
run;
/*EX1-(a) print last 4 observations*/

proc print data=topping2;
run;
ods rtf close;

ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW1\problem1_" bodytitle style=journal;
title "EX1 Survey about Customer's Preferance for New Toppings";
data Pizza;
infile "C:\Users\linal\Desktop\2018\STA502\HW2\Pizza.csv" dsd missover firstobs=2  ;
	input SurveyNum:$4.  Arugula PineNut Squash Shrimp Eggplant;
run;

/*EX1-(e) describes the contents of the data set which is created by data steps*/
/*ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW1\problem1d" bodytitle style=journal;
title "EX1-(d) Pizza topping";*/
proc contents data=Pizza;
run;
/*EX1-(e) select only last 4 observations*/

data topping3;
set Pizza nobs=__nobs;
  if _n_ gt __nobs-4;
run;
/*EX1-(e) print last 4 observations*/

proc print data=topping3;
run;
ods rtf close;

