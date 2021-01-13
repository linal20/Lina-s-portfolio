ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW11\problem3" bodytitle style=journal;
/*header: 
Purpose:Fit a no intercept model to the manatee death and mortorboat. 
superimpose the fit of the no-intercept model and the fit of a model with both intercept and NBOATS on the scatter plot 
input: manatee_deaths (datalines)*/

data manatee_deaths;
input year nboats manatees @@;
datalines;
77  447  13  78  460  21  79  481  24  80  498  16
81  513  24  82  512  20  83  526  15  84  559  34
85  585  33  86  614  33  87  645  39  88  675  43
89  711  50  90  719  47
;
run;

ods graphics off;
proc reg data=manatee_deaths;
model manatees=nboats/  p r ;
run;


proc reg data=manatee_deaths;
model manatees=nboats/ noint p r;
   output out=manatee2 p=yhat r=residt;
run;

proc sgplot data=manatee2;
reg y=manatees x=nboats /legendlabel="no intercept model";
series y=yhat x=nboats/ legendlabel="intercept model" ;
run;

ods rtf close;
