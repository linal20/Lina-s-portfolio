/*header: Exercise Number 2 
Author: Lina Lee
Purpose: Calculate the diving score for each of the observations, create a
new variable containing this calculated score. create a .txt file containing all
the observations from the updated SAS dataset.
input Diving.sas7bdat
input variable: 
*/


%let data_folder=C:\Users\linal\Desktop\2018\STA502\HW4;
/* EX2-(a) */
data divingcal;
set tmp1.diving;
small1=smallest(1, of J1-J7) ;
small2=smallest(2, of J1-J7) ;
large1=largest(1, of J1-J7);
large2=largest(2, of J1-J7);
sumjudge=J1+J2+J3+J4+J5+J6+J7-small1-small2-large1-large2;
finalscore=sumjudge*DD;
run;

/* EX2-(b) */
data _null_;
set divingcal;
file "&data_folder\divingoutput4.txt";
put  @1 name @25 country @54  height 4.2 @59 weight 5.2   @65 dive  @67 finalscore 5.2;
run; 

