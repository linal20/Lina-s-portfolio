/*header
Purpose:  Statistics on the number of flights and passengers leaving
12 major airports in the United States.
Input: airtraffic.sas7bdat/
*/

libname HW10 "C:\Users\linal\Desktop\2018\STA502";
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW10\problem1a" bodytitle style=journal;

data airtraffic;
set HW10.airtraffic;
run;

proc sort data=airtraffic;
by airline year quarter;
run;

%let year=1991;
proc report data=airtraffic out=airdata; where year=&year;
column airline year quarter BOSFlights BOSPassengers;
define airline/group;
define year/group;
define quarter/group;
define BOSFlights/analysis sum "The number of flight";;
define BOSPassengers/analysis sum"the number of passengers";
run;
title "The sum of the flights and the sum of the passengers for each year and quarter per airline in 1991";
proc print data=airdata(firstobs=18 obs=25);
run;


proc sql;
create table a as
select airline, year, quarter, divide(BOSPassengers,BOSFlights) as ratio1, round(divide(BOSPassengers,BOSFlights)) as ratio
from airdata;quit;

proc sql;
create table b as
select airline,  year,quarter, ratio from a
group by quarter
having ratio=max(ratio);
quit;

title "the airline with the highest number of passengers per flight for each quarters of year 1991 ";
proc print data=b;
run;
ods rtf close;

%MACRO air_analysis(flights=,passengers=,year=,yearto=);
%do year=&year %to &yearto;
proc report data=tmp1.airtraffic out=airdata; where year=&year;
column airline year quarter &Flights &Passengers;
define airline/group;
define year/group;
define quarter/group;
define &Flights/analysis sum "The number of flight";;
define &Passengers/analysis sum"the number of passengers";
run;

proc sql;
create table a as
select airline, year, quarter,round(divide(&Passengers,&Flights)) as ratio
from airdata;quit;

proc sql;
create table data&year as
select airline, year, quarter, ratio from a
group by quarter
having ratio=max(ratio);
quit;


%end;
%MEND air_analysis;

%air_analysis(Flights=ORDFlights,Passengers=ORDPassengers,year=2000,yearto=2010);


proc sql;
   title 'the airlines of highest passengers per flight for each quarters of year 1991';
   create table combined as
      select * from data2000
      union all
      select * from data2001
   union all
     select * from data2002
     union all
      select * from data2003
   union all
     select * from data2004
	 union all
      select * from data2005
   union all
     select * from data2006
     union all
      select * from data2007
   union all
     select * from data2008
	 union all
      select * from data2009
   union all
     select * from data2010;	  
	  quit;

ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW10\problem1-c" bodytitle style=journal;
title "the airline of the highest number of passenger for each quarter for year from 2000 to 2010 for the Chicago airport";
	  proc print data=combined;
	  run;
	  ods rtf close;
/*
data airdata2;
set airdata;
ratio=divide(&Passengers,&Flights);
run;

proc sort data=airdata2; 
by year quarter descending ratio;
run;

data outdata&yearto;
set airdata2;
by quarter;
retain count;
if first.quarter then do;
count=0;
end;
count=count+1;
if count >1 then delete;
drop _break_ count;
run;
%end;
%MEND air_analysis;

%air_analysis(Flights=ORDFlights,Passengers=ORDPassengers,year=2000,yearto=2002);



