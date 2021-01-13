libname day19 "M:\Course\2018-2019\402502\lectures\week08\week08data";
data divingn;
set day19.divingn;
run;

proc report data=divingn;
column name country score2 score2=mean_score2;
define name/group;
define country/group;

define score2/analysis sum "Total" format=5.3;
define mean_score2/analysis mean "Mean of Score" format=6.3;
run;

/*RETAIN*/
/*(1) How RETAIN works in SAS*/
data ex_without;
put "Before the INPUT statement:" _all_;
input x @@;
put "After the INPUT statement:" _all_/;

datalines;
2 1 7 3 . 9
;
run;


data ex_with;
put "Before the INPUT statement:" _all_;
/*retain x;*/
input x @@;
put "After the INPUT statement:" _all_/;
retain x;
datalines;
2 1 7 3 . 9
;
run;
/*It doesn't matter where we place the RETAIN statement in the DATA step
the effect is the same.*/

/*(2)Task: If there's a missing value for x, use the value from the */
/*previous observation.*/

data ex_with2;
put "Before the INPUT statement:" _all_;
input x @@;
put "After the INPUT statement:" _all_;
retain prex;

if x ne . then prex=x;
else x=prex;
put "after the LOGIC statement:" _all_/;

datalines;
2 1 7 3 . 9
;
run;


/*(3)Get a counter to indicate which observation it is. 
Syntax: RETAIN variable-list initial_value*/
data ex_count;
retain countnum 0;

put "Before the INPUT statement:" _all_;
input x @@;
countnum=countnum+1;
put "After the INPUT statement:" _all_/;
datalines;
2 1 7 3 . 9
;
run;


data diving_count;
set divingn;
by name;
retain divecount;

if first.name then do;
divecount=0;
end;

divecount=divecount+1;

run;


/*(4) Calculate the accumalive sum of the observations*/
data ex_sum;
retain total 0;

put "Before the INPUT statement:" _all_;
input x @@;
total=total+x;
put "After the INPUT statement:" _all_/;
datalines;
2 1 7 3 . 9
;
run;
