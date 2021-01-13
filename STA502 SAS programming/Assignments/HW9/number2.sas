ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW9\problem23" bodytitle style=journal;
title "Summary of cases reported on the first day of July";


/*header
Purpose: Summary for  loan appllication 
Input: loanapp.sas7bdat/

/*header
Purpose: Summary of cases reported on the first day of July and August
Input: sff.sas7bdat/


/*header
Purpose: Combine the two SAS data sets so that the district rating is properly
assigned to each teacher
Input: Teachers.sas7bdat, district.sas7bdat*/

proc sql;
create table casedata as
select continent as conti label="Continent",
count(country) as countrynb label="Number of countries",
sum(July) as Julynb label="Sum of cumulative cases reported on the first day of the month for July" 
from sff
group by continent; 
quit;
proc print data=casedata label;

title "Summary of cases reported on the first day of August";
proc sql;
select continent as conti label="Continent",
sum(
  case 
    when aug =. then 1
    else 0 
  end
)
as nocase label="Number of countries reported no cases", 
sum(
  case 
    when aug > 0 then 1
    else 0 
  end
)
as cases label="Number of countreis reported cases",
sum(
  case 
    when aug > 0 then aug 
    else 0 
  end
)
as augcumsum label="Sum of cumulative cases reported on the first day of August"
from sff
group by continent;
quit;

title "The district rating for 10 elementary teachers";
proc sql;
select Teachers.teacher,District.*
from Teachers as a,district as b
where a.teacherscore=b.TS
and a.CurriculumGrd=b.CG
order by a.teacher;
quit;
ods rtf close;
