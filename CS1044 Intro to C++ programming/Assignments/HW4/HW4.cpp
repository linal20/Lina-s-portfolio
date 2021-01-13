/**
* @file HW4.cpp * this project takes user input and calculate tax depending on user's status and income.
* it applies different tax rate depending on user's status and income.

* @author Lina Lee
* @date   September 29th, 2020
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

//these are my includes
#include <iostream>
#include "consts.h"
#include <iomanip>

using namespace std;

/**
 * this is my main function that calculate depending on your status and income.
    it applies different tax rate and calculate your tax.
 * @param income – the income the user implements
 * @char status – the inputted filing status of the user
 * @return 0 indicates a successful completion
 */

int main()
{
    //variable declaration
    char status;
    int income;
    double tax;

    //prompts for and takes the user's input
    cout << "Please enter your filing status" << endl;
    cout << "Enter S for Single filers," << endl;
    cout << "      J for married filing Jointly," << endl;
    cout << "      F for married Filing separately, or" << endl;
    cout << "      H for head of household" << endl;

    cout << "Status: ";
    cin >> status;
    cout << "Please enter your income: "<< endl;
    cin >> income;


     // This is if statement to calculate your tax.
     //determines what user's income was and calculate your tax

    if(status == 'S') // if your status is single
        {
        income = income - STD_DEDS; // deduct the standard deduction
        if(income <= 0)
            ;
        else if(income <= SINGLE10) // if your income is Up to $9,275, your tax will be calculated
        {
            tax = income * PER10;
        }
        else if(income <= SINGLE15) // if your income is $9,276 - $37,650,
        {
            tax = (SINGLE10 * PER10) + (income - SINGLE10) * PER15;
        }
        else if(income <= SINGLE25) // if your income is $37,651 - $91,150,
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15 + (income - SINGLE15) * PER25;
        }
        else if(income <= SINGLE28) // if your income is $91,151 - $190,150,
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15 + (SINGLE25 - SINGLE15) * PER25
            + (income - SINGLE25) * PER28;
        }
         else if(income <= SINGLE33) // if your income is $190,151 - $413,350,
         {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15 + (SINGLE25 - SINGLE15) * PER25 + (SINGLE28 - SINGLE25) * PER28
            +(income - SINGLE28) * PER33;
         }
         else if(income <= SINGLE35) // if your income is $413,351 - $415,050,
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15+ (SINGLE25 - SINGLE15) * PER25 + (SINGLE28 - SINGLE25) * PER28
            +(SINGLE33 - SINGLE28) * PER33 + (income - SINGLE33) * PER35;
        }
        else // if your income is $415,051 or more,
        {
            tax = (SINGLE10 * PER10) + (SINGLE15 - SINGLE10) * PER15 + (SINGLE25 - SINGLE15) * PER25 + (SINGLE28 - SINGLE25) * PER28
            + (SINGLE33 - SINGLE28) * PER33 + (SINGLE35 - SINGLE33) * PER35 + (income - SINGLE35) * PER39_6;
        }
    }
    else if(status == 'J') // if your status is married Filing Jointly or qualified widow(er)
    {
        income = income - STD_DEDJ; // deduct the standard deduction
        if(income <= 0)
            ;
        else if(income <= JOINTLY10) // if your income is Up to $18,550,  your tax will be calculated
        {
            tax = income * PER10;
        }
        else if(income <= JOINTLY15) // if your income is $18,551 - $75,300,
        {
            tax = (JOINTLY10 * PER10) + (income - JOINTLY10) * PER15;
        }
        else if(income <= JOINTLY25) // if your income is $75,301 - $151,900,
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15 + (income - JOINTLY15) * PER25;
        }
        else if(income <= JOINTLY28) // if your income is $151,901 - $231,450,
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10)* PER15 + (JOINTLY25 - JOINTLY15) * PER25
            + (income - JOINTLY25) * PER28;
        }
         else if(income <= JOINTLY33) // if your income is $231,451 - $413,350,
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10)*PER15 + (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            + (income - JOINTLY28) * PER33;
        }
         else if(income <= JOINTLY35) // if your income is $413,351 - $466,950,
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15+ (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            + (JOINTLY33 - JOINTLY28) * PER33 + (income - JOINTLY33) * PER35;
        }
        else // if your income is $466,951 or more,
        {
            tax = (JOINTLY10 * PER10) + (JOINTLY15 - JOINTLY10) * PER15 + (JOINTLY25 - JOINTLY15) * PER25 + (JOINTLY28 - JOINTLY25) * PER28
            +(JOINTLY33 - JOINTLY28) * PER33 + (JOINTLY35 - JOINTLY33) * PER35 + (income - JOINTLY35) * PER39_6;
        }
    }
    else if(status == 'F') // married Filing separately
    {
        income = income - STD_DEDF; // deduct the standard deduction
        if(income <= 0)
            ;
        else if(income <= FILING10) // if your income is Up to 9,275,  your tax will be calculated
        {
            tax = income * PER10;
        }
        else if(income <= FILING15) // if your income is $9,276—$37,650,
        {
            tax = (FILING10 * PER10)+(income - FILING10) * PER15;
        }
        else if(income <= FILING25) // if your income is $37,651—$75,950,
        {
            tax = (FILING10 * PER10) + (FILING15 - FILING10) * PER15 + (income - FILING15) * PER25;
        }
        else if(income <= FILING28) // if your income is $75,951—$115,725,
        {
            tax = (FILING10 * PER10) + (FILING15 - FILING10) * PER15 + (FILING25 - FILING15) * PER25
            + (income - FILING25) * PER28;
        }
         else if(income <= FILING33) // if your income is $115,726—$206,675,
        {
            tax = (FILING10 * PER10) + (FILING15 - FILING10) * PER15 + (FILING25 - FILING15) * PER25 + (FILING28 - FILING25) * PER28
            + (income - FILING28) * PER33;
        }
         else if(income <= FILING35) // if your income is $206,676—$233,475,
        {
            tax = (FILING10 * PER10) + (FILING15 - FILING10) * PER15 + (FILING25 - FILING15) * PER25 + (FILING28 - FILING25) * PER28
            + (FILING33 - FILING28) * PER33 + (income - FILING33) * PER35;
        }
        else // if your income is $233,476 or more,
        {
            tax = (FILING10 * PER10) + (FILING15 - FILING10) * PER15 + (FILING25 - FILING15) * PER25 + (FILING28 - FILING25) * PER28
            + (FILING33 - FILING28) * PER33 + (FILING35 - FILING33) * PER35 + (income - FILING35) * PER39_6;
        }
    }
    else // if your status is Head of Household
    {
        income = income - STD_DEDH; // deduct the standard deduction
        if(income <=0)
            ;
        else if(income <= HEAD10) // if your income is Up to $13,250, your tax will be calculated
        {
            tax = income * PER10;
        }
        else if(income <= HEAD15) // if your income is $13,251 - $50,400,
        {
            tax = (HEAD10 * PER10) + (income - HEAD10) * PER15;
        }
        else if(income <= HEAD25) // if your income is $50,401 - $130,150,
        {
            tax = (HEAD10 * PER10) + (HEAD15 - HEAD10) * PER15 + (income - HEAD15) * PER25;
        }
        else if(income <= HEAD28) // if your income is $130,151—$210,800,
        {
            tax = (HEAD10 * PER10) + (HEAD15 - HEAD10) * PER15 + (HEAD25 - HEAD15) * PER25
            + (income - HEAD25) * PER28;
        }
         else if(income <= HEAD33) // if your income is $210,801—$413,350,
        {
            tax = (HEAD10 * PER10) + (HEAD15 - HEAD10) * PER15 + (HEAD25 - HEAD15) * PER25 + (HEAD28 - HEAD25) * PER28
            + (income - HEAD28) * PER33;
        }
         else if(income <= HEAD35) // if your income is $413,351—$441,000,
        {
            tax = (HEAD10 * PER10) + (HEAD15 - HEAD10) * PER15 + (HEAD25 - HEAD15) * PER25 + (HEAD28 - HEAD25) * PER28
            + (HEAD33 - HEAD28) * PER33 + (income - HEAD33) * PER35;
        }
        else // if your income is $441,001 or more,
        {
            tax = (HEAD10 * PER10) + (HEAD15 - HEAD10) * PER15 + (HEAD25 - HEAD15) * PER25 + (HEAD28 - HEAD25) * PER28
            + (HEAD33 - HEAD28) * PER33 + (HEAD35 - HEAD33) * PER35 + (income - HEAD35) * PER39_6;

        }
    }

    //setprecision(2) control the number of digits (as 2) of an output stream display of a floating- point value.
    cout << fixed << setprecision(2);

    //print the calculated tax
    cout << "Your tax is $" << tax << "." << endl;
    //returns 0, indicating a successul completion
    return 0;
}

