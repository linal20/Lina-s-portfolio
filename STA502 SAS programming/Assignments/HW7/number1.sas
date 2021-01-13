%let data_folder=C:\Users\linal\Desktop\2018\STA502WHW7;

ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW7\problem1" bodytitle style=journal;
/*(a) Label: U.S. average price of unleaded regular gasoline (per gallon) , variable type: numeric*/

proc means data=gas min max mean maxdec=2;
var GasPrice;
by year;
output out=gas2 min=gasmin max=gasmax mean=gasmean;
run;


proc report data=gas2;
title "the gasolin price statistics"; 
column year gasmin gasmax gasmean;
define gasmin/display "Minimum" format=4.2;
define gasmax/display "Maximum" format=4.2;
define gasmean/display "Mean" format=4.2;
run;

data gas3;
set gas;
do i=1to 3;
if month=i then quarter=1;
end;
do i=4 to 6;
if month=i then quarter=2;
end;
do i=7 to 9;
if month=i then quarter=3;
end;
do i=10 to 12;
if month=i  then quarter=4;
end;
run;

proc means data=gas3;
var GasPrice;
by year quarter ;
output out=gas4  mean=average std=stdv;
run;

proc report data=gas4;
title "the gasolin price statistics"; 
column year quarter average stdv;
define year /display order;
define quarter /display order;
define average/display "average of gasoline prices" format=dollar10.3;
define stdv/display "standard deviation of gasoline prices" format=10.3;
run;

ods rtf close;
