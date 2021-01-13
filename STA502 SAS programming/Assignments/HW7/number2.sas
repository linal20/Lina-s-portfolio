%let data_folder=C:\Users\linal\Desktop\2018\STA502WHW7;
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW7\problem3" bodytitle style=journal;
/*header
Purpose: practice using RETAIN with data in countries across the world regarding the outbreak of swine u cases and deaths
in 2009.
Input: sff.sas*/

/* Name:Country, length:30 Name:Continent, length:13*/

/*(b)*/
data sff_1 ;
set sff;
retain cum_sum;
cum_sum=sum (cum_sum,Oct_d);
run;

data sff2;
set sff_1;
keep cum_sum Oct_d;
run;

proc print data=sff_1(keep=Oct_d Continent cum_sum FIRSTOBS=75 obs=80) ;
title " the cumulative sum of the number of cumulative deaths reported on the first day of the month 
for Oc-tober across all countries";
run;

/*c*/
proc sort data=sff;
by continent;
run;

data sff_count;
set sff;
by Continent;
retain ctycount;

if first.Continent then do;
ctycount=0;
end;

ctycount=ctycount+1;

if last.continent then output;
run;


proc print data=sff_count(keep=Continent ctycount) ;
title "the number of countries within each continent";
run;

/*d*/
data sff_report;
set sff;
if  FirstDeath ne . and  FirstCase =.  then report=1;
run;

data sff_report2 (keep=Continent country  FirstCase Latest  FirstDeath ) ;
set sff_report;
if report ne 1 than delete;
run;

proc print data=sff_report2;
run;

/*(e)*/
data sff_nocase;
set sff;
if aug ne . then delete;
run;

proc sort data=sff_nocase;
by continent;
run;

data sff_count_nocase(keep=continent ctycount_aug_no);
set sff_nocase;
by Continent;
retain ctycount_aug_no;

if first.Continent then do;
ctycount_aug_no=0;
end;

ctycount_aug_no=ctycount_aug_no+1;

if last.continent then output;
label ctycount_aug_no="Number of countries reported no cases";
run;

data sff_acase;
set sff;
if aug=. then delete;
run;

proc sort data=sff_acase;
by continent;
run;

data sff_count_acase(keep=continent ctycount_aug);
set sff_acase;
by Continent;
retain ctycount_aug;

if first.Continent then do;
ctycount_aug=0;
end;

ctycount_aug=ctycount_aug+1;

if last.continent then output;
label ctycount_aug="Number of countries reported cases";
run;

proc sort data=sff;
by continent;
run;
data sff_cum(keep=continent cum_sum);
set sff;
by continent;
retain cum_sum;
if first.Continent then do;
cum_sum=0;
end;
cum_sum=sum (cum_sum,aug);
if last.continent then output;
label cum_sum="the summation of cumulative cases per continent";
run;

data merge1;
merge sff_count_acase sff_count_nocase sff_cum;
by continent;
run;

proc print data=merge1 label;
run;

ods rtf close;
/*
data sfftest;
set sff;
if continent ne "Asia" then delete;
run;

data sfftest2 (keep=continent cum_sum aug);
set sfftest;
label cum_sum="the summation of cumulative cases per continent"
retain cum_sum;
cum_sum=sum (cum_sum,aug);
run;


/*

data sff_e_1;
set sff;
if Aug=. and continent='Africa' then noreport=1;
if Aug=. and continent='Asia' then noreport=2;
if Aug=. and continent='Australia' then noreport=3;
if Aug=. and continent='Europe' then noreport=4;
if Aug=. and continent='North America' then noreport=5;
if Aug=. and continent='South America' then noreport=6;
run;

proc sort data=sff_e_1;
by noreport;
run;

data sff_e_2;
set sff_e_1;
by noreport;
retain ctycount_aug_no;


if first.noreport then do;
ctycount_aug_no=0;
end;

ctycount_aug_no=ctycount_aug_no+1;

if last.noreport then ctyaug_no=ctycount_aug_no;
if noreport=. then ctyaug_no=.;
run;

data sff_e_onecase;
set sff_e_2;
if Aug ne . and continent='Africa' then report=1;
if Aug ne . and continent='Asia' then report=2;
if Aug ne . and continent='Australia' then report=3;
if Aug ne . and continent='Europe' then report=4;
if Aug ne . and continent='North America' then report=5;
if Aug ne . and continent='South America' then report=6;
run;

proc sort data=sff_e_onecase;
by report;
run;

data sff_e_onecase2;
set sff_e_onecase;
by report;
retain ctycount_aug;


if first.report then do;
ctycount_aug=0;
end;

ctycount_aug=ctycount_aug+1;

if last.report then ctyaug=ctycount_aug;
if report=. then ctyaug=.;
run;





proc print data=sff_count(keep=Continent ctycount) ;run;
