%let data_folder=C:\Users\linal\Desktop\2018\STA502\HW5;
/*read data meat.txt file*/
data meat;
infile "&data_folder\meat.txt";
input v1$ v2 v3 $ v4 v5 $ v6;
run;

/*calculate mean and standard deviation*/
data meat_stat;
set meat;
array myarray{*} _numeric_;
mean=mean(of myarray[*]);
std=std(of myarray[*]);
run;

data _null_;
set statistics;
file "&data_folder\output.txt";
put v1 v2 v3 v4 v5 v6;
run;

/*make a report including standard deviation and mean*/
data _null_;
set meat_stat;
file "&data_folder\meat2.txt";
if v1="Plastic" then do;
put "Packaging condition=Plastic" //;
put @2 "data" @33 "Mean" @46 "Std.Dev"/;
put @2 28*"-" @33  8*"-" @46 8*"-"/;
put @2 v2 4.2 @8 v4 4.2 @14 v6 4.2 @33 mean 4.2 @46 std 4.2/;
end;
if v1="Vacuum" then do;
put "Packaging condition=Vacuum"//;
put @2 "data" @33 "Mean" @46 "Std.Dev"/;
put @2 28*"-" @33  8*"-" @46 8*"-"/;
put @2 v2 4.2 @8 v4 4.2 @14 v6 4.2 @33 mean 4.2 @46 std 4.2/;
end;
if v1="Mixed" then do;
put "Packaging condition=Mixed"//;
put @2 "data" @33 "Mean" @46 "Std.Dev"/;
put @2 28*"-" @33  8*"-" @46 8*"-"/;
put @2 v2 4.2 @8 v4 4.2 @14 v6 4.2 @33 mean 4.2 @46 std 4.2/;
end;
if v1="Co2" then do;
put "Packaging condition=Co2" //;
put @2 "data" @33 "Mean" @46 "Std.Dev"/;
put @2 28*"-" @33  8*"-" @46 8*"-"/;
put @2 v2 4.2 @8 v4 4.2 @14 v6 4.2 @33 mean 4.2 @46 std 4.2/;
end;
run;

