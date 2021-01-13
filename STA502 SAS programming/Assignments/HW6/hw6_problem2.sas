ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW6\problem2" bodytitle style=journal;
/* This program shows the difference between
	WHERE and  IF in subsetting the context of
	a data-set MERGE.
*/

data ds1;
input w x y;
datalines;
1 1 0
3 1 0
4 7 0
5 0 0
;
run;

data ds2;
input w x z;
datalines;
1 1 0
2 1 0
4 3 3
5 7 3
;
run;

data  ds_where;
merge ds1 ds2;
by w;
where x<7;
run;

data ds_if;
merge ds1 ds2;
by w;
if x<7;
run;



proc print data=ds1 noobs;
title "First dataset";
run;
proc print data=ds2 noobs;
title "Second dataset";
run;
proc print data=ds_where noobs;
title "Merged with WHERE";
run;
proc print data=ds_if noobs;
title "Merged with IF";
run;

/*(b) Use the same datasets ds1 and ds2, create a merged dataset by w,
which consists of observations only appeared in data ds2. Include
the printed dataset.*/
data in_1_alt;
merge ds1(in=indata1)
	  ds2(in=indata2);
by w;
if indata2=1;
run;

proc print data=in_1_alt;
run;


ods rtf close;
