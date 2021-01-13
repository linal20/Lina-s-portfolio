/*header
author:Lina Lee
purpose: analysis of the data of UFO sightings reports
input: complete.csv*/

ods rtf file="C:\Users\linal\Desktop\2018\STA502\project\progress1-4" bodytitle style=journal;
/*reading csv data into sas*/
proc import datafile ="C:\Users\linal\Desktop\2018\STA502\project\complete.csv"
 out = UFO
 dbms = CSV
 ;
run;
/*generate group by latitude and longitude*/

data ufo_group;
set ufo;
if latitude<-23 then latclass=1;
else if -23=<latitude<0 then latclass=2;
else if 0=<latitude<23 then latclass=3;
else if 23=<latitude<46 then latclass=4;
else if 46=<latitude then latclass=5;

if 150=<longitude<180 then loclass=1;
else if 120=<longitude<150 then loclass=2;
else if 90=<longitude<120 then loclass=3;
else if 60=<longitude<90 then loclass=4;
else if 30=<longitude<60 then loclass=5;
else if 0=<longtidude<30 then loclass=6;
else if -30=<longitude<0 then loclass=7;
else if -60=<longitude<-30 then loclass=8;
else if -90=<longitude<-60 then loclass=9;
else if -120=<longitude<-90 then loclass=10;
else if -150=<longitude<-120then loclass=11;
else if -180=<longtidude<-150 then loclass=12;
else if loclass=0;

if country="us" then countrynb=1;
else if country="au" then countrynb=2;
else if country="ca" then countrynb=3;
else if country="gb" then countrynb=4;
else if country="de" then countrynb=5;
else if country=" " then countrynb=6;
run;




proc sort data=UFO_group;
by latclass;
run;
/*create a table grouped by latitude*/
proc sql;
create table latitude as
select 
case
	   when latclass=1 then " latitude<-23" else
case 
       when latclass=2 then "-23=<latitude<0 " else
case 
       when latclass=3 then " 0=<latitude<23 " else
case 
       when latclass=4 then "23=<latitude<46" 
       else " 46=<latitude"
	   end
	   end
	   end 
	   end
	   as latclass label="groups by latitude", count(dateposted) as count label="number of reports of UFO" 
from ufo_group
group by latclass;
quit;

title "Table1: the number of reports by group of latitude";
proc print data=latitude label;
run;

/*generate a scatter plot of the number of report by group of latitude*/
proc sgplot data=latitude;
title "Plot 1: Scatter Plot of the number of reports by group of latitude";
scatter y=count x=latclass;
run;

/*create a table grouped by longiitude*/

proc sort data=UFO_group;
by loclass;
run;


proc sql;
create table longitude as
select 
case 
	   when loclass=1 then "150=<longitude<180" else
case 
       when loclass=2 then "120=<longitude<150 " else
case 
       when loclass=3 then "90=<longitude<120" else
case 
       when loclass=4 then "60=<longitude<90" else
case
	   when loclass=5 then " 30=<longitude<60" else
case 
       when loclass=6 then "0=<longitude<30 " else
case 
       when loclass=7 then " -30=<longitude<0" else
case 
       when loclass=8 then "-60=<longitude<-30" else
case
	   when loclass=9 then " -90=<longitude<-60" else
case 
       when loclass=10 then "-120=<longitude<-90 " else
case 
       when loclass=11 then " -150=<longitude<-120" 
else  "-180=<longitude<-150"
	   end
	   end
	   end 
	   end
	   end
	   end
	   end
	   end
       end
       end
       end
as loclass label="groups by longitude", count(dateposted) as count label="The number of report of UFO" 
from ufo_group
group by loclass;
quit;

title "Table2: Scatter Plot of the number of reports by group of longtitude";
proc print data=longitude label;
run;

/*generate a scatter plot of the number of report by group of longittude*/
proc sgplot data=longitude;
title "Plot2: Scatter Plot of the number of reports by group of longtitude";
scatter y=count x=loclass;
run;

/*analysis of the number of reports of UFO sightings, latitude, longtidue, and duration by each country*/
/*generate a macro */
%macro ufo_analysis(var1=,var2=,var3=,country=, countrynb=);
title "(a) Summary of &var1 for country "&country" ";
proc sql;
select  count(dateposted) as count label="The number of UFO reports" ,
avg(&var1) as v1 format=14.2  label="The mean of &var1 ",
min(&var1) as v3 format=14.2 label="The minimum of &var1",
median(&var1) as v2 format=14.2 label="The median of &var1",
max(&var1) as v4 format=14.2 label="The maximum of &var1"
from ufo_group
where countrynb=&countrynb;
quit;

title "(b) Summary of &var2 for country "&country" ";
proc sql;
select  avg(&var2) as b1 format=14.2  label="The mean  of &var2 ",
min(&var2) as b3 format=14.2 label="The minimum of &var2",
median(&var2) as b2 format=14.2 label="The median of &var2",
max(&var2) as b4 format=14.2 label="The maximum of &var2"
from ufo_group
where countrynb=&countrynb;
quit;

title "(c) Summary of &var3 for country "&country" ";
proc sql;
select  avg(&var3) as b1 format=14.2  label="The mean  of &var3 ",
min(&var3) as b3 format=14.2 label="The minimum of &var3",
median(&var3) as b2 format=14.2 label="The median of &var3",
max(&var3) as b4 format=14.2 label="The maximum of &var3"
from ufo_group
where countrynb=&countrynb;
quit;

%mend;

/*implement the above macro for each country*/
%UFO_analysis(var1=latitude,var2=longitude, var3=durationsec,countrynb=1,country="us");
%UFO_analysis(var1=latitude,var2=longitude, var3=durationsec,countrynb=2,country="au");
%UFO_analysis(var1=latitude,var2=longitude, var3=durationsec,countrynb=3,country="ca");
%UFO_analysis(var1=latitude,var2=longitude, var3=durationsec,countrynb=4,country="gb");

/*test difference of mean of duration between each country */
title "test difference of mean of duration between some countries";
proc glm data=ufo;
class country;
model durationsec=country/solution;
means country;
contrast "H0:mu_ca=mu_us" country 0 1 0 0 -1;
contrast "H0:mu_EU=mu_America" country 0 1 -1 -1 1;
run;
quit;


ods rtf close;
