ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW6\problem3" bodytitle style=journal;
%let data_folder=C:\Users\linal\Desktop\2018\STA502WHW6;
/*number3*/
data pizza;
set tmp1.pizzaratings;
run;
/*(a) Create a format to be used on the Rating variable*/
proc format;
value Rating .="n/a"
                   1="never"
                   2="might"
                   3="at least once"
                   4="occasionally"
                   5="often";
run;

data pizza2;
set pizza;
format rating Rating.;
run;

/*For each topping type, count the number of observations for each type of response*/
proc freq data=pizza2;
table topping*rating / missprint;
run;
/*Calculate the average rating for each topping*/
proc means data=pizza2 maxdec=2;
class topping;
var rating;
run;

ods rtf close;
