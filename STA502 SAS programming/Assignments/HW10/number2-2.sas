proc format;
value bname 1="LIV925"
                     2="SV408"
					 3="SL0805"
					 4="GLN626"
					 5="COR760"
run;


proc format;
value aname 1="Primary Residence"
                     2="Secondary Residence"
                     3="Investment or Rental" 
                     4="Commercial Property"
run;
proc sql;
create table work.loan as
select proptype as propertytype format=aname.
, sum(loanapproved) as number "Number of loan approvals" ,
avg(LoanAmt) as mean format=dollar14. label="The mean loan amount ",
median(PercentDown) as median format=percent10.2 label="The median down payment percentage"
from loanapp
where PercentDown<0.05  AND branch=1
group by proptype; 
quit;
/*
proc sql ;
 create table work.loan2 as
 select DISTINCT(propertytype), branch, number, mean, median 
 from loan
 group by propertytype
 having propertytype = MAX(propertytype);
quit;
