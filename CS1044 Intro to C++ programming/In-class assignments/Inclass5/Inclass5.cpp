/**
* @file inclass5.cpp * this project takes user input and generates a random computer value
* in order to play rock paper scissors in a simple program
*
* @author Lina Lee
* @date   September 24th, 2020
*
* Virginia Tech Honor Code Pledge
* On my honor:
*
* - I have not discussed the C++ language code in my program with
* anyone other than my instructor or the teaching assistants
* assigned to this course.
* - I have not used C++ language code obtained from another student,
* or any other unauthorized source, either modified or unmodified.
* - If any C++ language code or documentation used in my program
* was obtained from another source, such as a text book of coarse
* notes, that has been clearly noted with oa proper citation in *
 the comments of my program.
* - I have not designed this program in such a way as to defeat or
* interfere with the normal operation of the Web-Cat Server. *
* Lina Lee
*/

#include <iostream>
#include "consts.h"
#include <iomanip>

using namespace std;

int main()
{
    char status;
    int income;
    double tax;

    cout << "Please enter your filing status" << endl;
    cout << "Enter S for Single filers," << endl;
    cout << "      J for married filing Jointly," << endl;
    cout << "      F for married Filing separately, or" << endl;
    cout << "      H for head of household" << endl;


    cout << "Status: ";
    cin >> status;
    cout << "Please enter your income: "<< endl;
    cin >> income;


    if(status == 'S'){
        income = income - STD_DEDS;
        if(income <=0)
            ;
        else if(income <= SINGLE10)
        {
            tax = income*PER10;
        }
        else if(income<= SINGLE15)
        {
            tax = (SINGLE10 * PER10)+(income - SINGLE10) * PER15;
        }
        else if(income <= SINGLE25)
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15 + (income - SINGLE15) * PER25;
        }
        else if(income <= SINGLE28)
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10)* PER15 + (SINGLE25 - SINGLE15) * PER25
            + (income - SINGLE25) * PER28;
        }
         else if(income <= SINGLE33)
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10)*PER15 + (SINGLE25 - SINGLE15) * PER25 + (SINGLE28 - SINGLE25) * PER28
            +(income-SINGLE28)*PER33;
        }
         else if(income<= SINGLE35)
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15+ (SINGLE25 - SINGLE15) * PER25 + (SINGLE28 - SINGLE25) * PER28
            +(SINGLE33 - SINGLE28) * PER33 + (income - SINGLE33) * PER35;
        }
        else
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15 + (SINGLE25 - SINGLE15) * PER25 + (SINGLE28 - SINGLE25) * PER28
            +(SINGLE33 - SINGLE28) * PER33 + (SINGLE35 - SINGLE33) * PER35 + (income - SINGLE35) * PER39_6;

        }
    }
    else if(status == 'J')
    {
        income = income - STD_DEDJ;
        if(income <=0)
            ;
        else if(income <= JOINTLY10)
        {
            tax = income*PER10;
        }
        else if(income<= JOINTLY15)
        {
            tax = (JOINTLY10 * PER10)+(income - JOINTLY10) * PER15;
        }
        else if(income <= SINGLE25)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15 + (income - JOINTLY15) * PER25;
        }
        else if(income <= SINGLE28)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10)* PER15 + (JOINTLY25 - JOINTLY15) * PER25
            + (income - JOINTLY25) * PER28;
        }
         else if(income <= JOINTLY33)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10)*PER15 + (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            +(income-JOINTLY28)*PER33;
        }
         else if(income<= JOINTLY35)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15+ (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            +(JOINTLY33 - JOINTLY28) * PER33 + (income - JOINTLY33) * PER35;
        }
        else
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15 + (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            +(JOINTLY33 - JOINTLY28) * PER33 + (JOINTLY35 - JOINTLY33) * PER35 + (income - JOINTLY35) * PER39_6;

        }
    }
    else if(status == 'J')
    {
        income = income - STD_DEDJ;
        if(income <=0)
            ;
        else if(income <= JOINTLY10)
        {
            tax = income*PER10;
        }
        else if(income<= JOINTLY15)
        {
            tax = (JOINTLY10 * PER10)+(income - JOINTLY10) * PER15;
        }
        else if(income <= SINGLE25)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15 + (income - JOINTLY15) * PER25;
        }
        else if(income <= SINGLE28)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10)* PER15 + (JOINTLY25 - JOINTLY15) * PER25
            + (income - JOINTLY25) * PER28;
        }
         else if(income <= JOINTLY33)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10)*PER15 + (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            +(income-JOINTLY28)*PER33;
        }
         else if(income<= JOINTLY35)
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15+ (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            +(JOINTLY33 - JOINTLY28) * PER33 + (income - JOINTLY33) * PER35;
        }
        else
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15 + (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            +(JOINTLY33 - JOINTLY28) * PER33 + (JOINTLY35 - JOINTLY33) * PER35 + (income - JOINTLY35) * PER39_6;

        }
    }

    cout << fixed << setprecision(2);
    cout << "Your tax is $"<< tax << "." << endl;
    return 0;
}
