/*1. Create simulated data*/
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW3\results3" bodytitle style=journal;


data random;
pi=constant("pi");
do i=0 to 20 by 0.1;
		x_val=i;
    y_val=rand("normal",1.2-3*x_val+0.2*x_val**2+sin(1/2*pi*x_val),4);  *mean, sd;
	output;
	end;
run;
/*1. create a scatter plot of the data with a superimposed regression line*/
proc sgplot data=random;
title "EX1 a scatter plot with a regression line ";
scatter x=x_val y=y_val;
reg x=x_val y=y_val;
run;
/*2-(a) Read the dataset into SAS*/
data BenandJerry;
infile "C:\Users\linal\Desktop\2018\STA502\HW3\BenAndJerrys.dat" dlm="," dsd missover encoding=wlatin1;
input   name:$30. size calories calfat fat satfat transfat chole sodium carbohydrate fiber sugars protein year_intro year_retired content
:$90. note:$20.;

run;
/*2-(b) keep only the avors that can be purchased at grocery store, and count observations*/ 
data Ben1;
set  BenandJerry;
if year_retired=" ";
if note="Scoop Shop Exclusive" then delete;
run;


/*Create a variable that calculates the calories in one tablespoon (TB)*/
data Ben2;
set Ben1;
caltablespoon=calories/size*15;

if caltablespoon<30 then criteria="low calories icecream";
run;
/*Keep only observations related with \low calories icecream, 
keep the flavor, calories,the content description and the calories in one TB*/
Data subset;
set Ben2;
if criteria="low calories icecream";
if caltablespoon=. then delete;
keep name calories content caltablespoon;
run;
/*Print a table containing the flavor, calories,the content description and the calories in one TB*/
proc print data=subset;
title "EX2 -(c) a table containing the flavor, calories,the content description and the calories in one TB"
run;
ods rtf close;
/*Sort the data you read from question (a), by calories (by de-
scending order), cholesterol (by descending order) and sodium
(by ascending order)*/
proc sort data=Benandjerry out=Sort;
by descending calories descending chole sodium;
run;
/*Print the flavor, calories, cholesterol and sodium information for the observations with calories value equal
to 280.*/
Data Sort2;
set Sort;
if calories=280;
keep name calories chole sodium;
run;

proc print data=sort2;
title "EX2-(d) a table with  flavor, calories, cholesterol and sodium information with calories value equal to 280";
run;

/*convert the measure of those six visits to the correct scale*/
data Wls2; 
set Tmp1.Wls;
array visit[*] Q7-Q12;
do i=1 to 6;
visit[i]=3-visit[i];
end; 
run; 
 
/*print ID,height, weight, BMI and the six questions in the second visit*/
proc print  data=Wls2 (obs=3);
title "EX3 a table with ID,height, weight, BMI and the six questions in the second visit";
var ID Height Weight BMI Q7-Q12;
run;


