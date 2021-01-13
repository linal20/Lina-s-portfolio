
/*header: Exercise Number 1 
Author: Lina Lee
Purpose: read the CSV dataset into SAS as a SAS dataset creates a new SAS data set for which each observation consists of the mean, median and standard deviation of the absolute
values of all numeric variables, and PROC PRINT to show the 3567-3570's observations of the re-sulting dataset from a new SAS data set
input: data_set_ALL_AML_independent.csv
*/

/*EX1 (a) read the dataset into SAS as a SAS
dataset*/
proc import data_set_ALL_AML_independent.csv
datafile="C:\Users\linal\Desktop\2018\STA502\HW4\data_set_ALL_AML_independent.csv"
out=work.allaml
;
/*EX1-(b) creates a new SAS data set for which each observation consists of the mean, median and standard deviation of the absolute
values of all numeric variables*/
data absolute;
set allaml;
array myarray _numeric_;
do over myarray;
if myarray<0 then myarray=abs(myarray);
end;
run;

data statistics;
set absolute;
array myarray{*} _numeric_;
mean1=mean(of myarray[*]);
median1=median(of myarray[*]);
stv1=std(of myarray[*]);
keep mean1 median1 stv1;
run;

ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW4\results1-1" bodytitle style=journal;
/*EX1-(c) PROC PRINT to show the 3567-3570's observations of the re-sulting dataset from (a)*/
proc print data=statistics (firstobs=3567 obs=3570);
title "the 3567-3570's observations";
run;
ods rtf close;
