/*header
purpose: debugging the following SAS program that creates
a times table for any dimension specied, in this case 12 by 12.*/
ods rtf file="C:\Users\linal\Desktop\2018\STA502\HW11\problem1" bodytitle style=journal;

%MACRO tt(NumRows=,NumCols=);
DATA table (DROP = &NumRows &NumCols);
ARRAY col{&NumCols} col1 - col&NumCols;
DO i = 1 TO "&NumRows";
DO j = 1 TO "&NumCols";
col(j) = i * j;
END;
OUTPUT;
END;
RUN;
PROC PRINT DATA = TABLE;
TITLE1 'Times Table Printed for';
TITLE2 '&NumRows by &NumCols';
TITLE3 "Printed on &sysdate";
RUN;
%MEND tt;
%tt(NumRows = 12,NumCols = 12)


option mprint symbolgen;
%tt(NumRows = 12,NumCols = 12)







%MACRO tt  (NumRows=, NumCols=);
DATA table (DROP = i j);
ARRAY col(&NumCols) col1 - col&NumCols;
DO i = 1 TO &NumRows;
DO j = 1 TO &NumCols;
col(j) = i * j;
END;
OUTPUT;
END;
RUN;

PROC PRINT DATA = TABLE  label;
TITLE1 'Times Table Printed for';
TITLE2 ' &NumRows by &NumCols ';
TITLE3 "Printed on &sysdate";
%local i;
 %do i = 1 %to &NumCols;
label col&i = "&i";
 %end;
RUN;
%MEND tt;
%tt(NumRows = 12,NumCols = 12)

ods rtf close;
