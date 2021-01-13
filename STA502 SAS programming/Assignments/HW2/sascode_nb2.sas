
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW2\problem2" bodytitle style=journal;
title "EX2 weight loss in males";
/*2-(a) make a bar chart of the responses to the first survey question from visit two*/
proc sgplot data=hw2.Wls;
 title "a bar chart of responses to the first survey question from visit2";
	vbar Q7 /missing;
	xaxis label="responses to the first survey question from visit2";
	yaxis label="Number of people who respond to the first survey question from visit2";
run;


/*2-(b) make a box plot of bmi against the responses to the last survey*/ 

proc  sgplot data=hw2.Wls;
 title "a box plot of bmi against the responses to the last survey";
  vbox  bmi /category=Q30 missing;
  xaxis label="responses to the last survey";
run;

/*2-(c) make a graph of the regression line on top of the scatter plot (predictor:weight, response: bmi)*/
proc sgplot data=hw2.Wls;
 title " a graph of the regression line on top of the scatter plot (predictor:weight, response: bmi)";
	reg x=weight y=bmi/nomarkers;
	scatter x=weight y=bmi;

run;

/*2-(d) */

proc sgplot data=hw2.Wls;
title "Avrage BMI by response to question 1 in visit2";
vbar Q7 /response=bmi stat=mean missing;
	xaxis label=" responses to the first survey question from visit2";
	yaxis label="Avrage Body Max Index";
run;
ods rtf close;
