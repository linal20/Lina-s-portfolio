/*header
Purpose: Summary for  loan appllication using Macro 
Input: loanapp.sas7bdat/
*/

libname HW10 "C:\Users\linal\Desktop\2018\STA502";
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW10\problem2_3" bodytitle style=journal;

data loanapp;
set HW10.loanapp;
run;

%macro loan_analysis(type=,form=,des=,var1=,form1=,des1=,var2=,form2=,des2=,branchnb=);
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

proc format; 
value cname 1=Conventional
2=VA
3=FHA
4=Farmers Home Admin
5=Other
run;

title "Summary for Branch &branchnb";
proc sql;
select &type as type format=&form label=&des
,sum(loanapproved) as number "Number of loan approvals" ,
avg(&var1) as var1 format=&form1 label=&des1,
median(&var2) as var2 format=&form2 label=&des2
from loanapp
where loanapproved=1 AND branch=&branchnb
group by &type; 
quit;
%mend;



%loan_analysis(type=PropType,form=aname.,des="property type",var1=LoanAmt,form1=dollar14.2,des1="The mean loan amount "
,var2=PercentDown,form2=percent14.2,des2="The median down payment percentage",branchnb=1);


%loan_analysis(type=MortApp,form=cname.,des="Morgage type",var1=CreditScore,form1=14.,des1="The mean credit score "
,var2=Price,form2=dollar14.3,des2="The median purchase price",branchnb=3);

ods rtf close;
