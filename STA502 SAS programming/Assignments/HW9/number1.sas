libname loan="C:\Users\linal\Desktop\2018\STA502WHW7";
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW9\problem1" bodytitle style=journal;
data loan.loanapp;
set loanapp;
run;
title " Summary for Loan Applications with Less Than 5% Down";
proc sql;
select 
 case
	   when branch=1 then "LIV925" else
case 
       when branch=2 then "SV408" else
case 
       when branch=3 then "SLO805" else
case 
       when branch=4 then "GLN626" 
       else "COR760"
	   end
	   end
	   end 
	   end
	   as branchname label="Branch name",
sum(LoanApproved) as nbapproval label="Number of loans approvals",
count(FirstName) as loanapp label="Number of total loan applications",
(sum(LoanApproved)/count(FirstName)) as percet format=percent14.3 label="Percent of loan approvals"
from loanapp 
where PercentDown<0.05
group by branch;
quit;
/*dollar sign*/

title " Summary for approved loan: mean loan amount, mean home price, median creditscore";
proc sql;
select
case
	   when branch=1 then "LIV925" else
case 
       when branch=2 then "SV408" else
case 
       when branch=3 then "SLO805" else
case 
       when branch=4 then "GLN626" 
       else "COR760"
	   end
	   end
	   end 
	   end
	   as branchname label="Branch name",
count(FirstName) as loanapp label="Number of loan applications",
avg(LoanAmt) as avgamt format=dollar14.3  label="Mean loan amount",avg(Price) as avgprice format=dollar14.3 label="Mean home price",
median(creditscore) as credit label="Median credit score"
from loanapp
where LoanApproved=1
group by branch;
quit;

ods rtf close;
