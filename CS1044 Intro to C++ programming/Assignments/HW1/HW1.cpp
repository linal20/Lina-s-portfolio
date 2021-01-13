#define _USE_MATH_DEFINES // for C++
#include <cmath>
#include <iostream>
#include <iomanip>

/**
* @file HW1.cpp * this project takes user input and generates a random computer value
* in order to play rock paper scissors in a simple program
*
* @author Lina Lee
* @date   September 6th, 2020
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
* notes, that has been clearly noted with a proper citation in
* the comments of my program.
* - I have not designed this program in such a way as to defeat or
* interfere with the normal operation of the Web-Cat Server.
* Lina Lee
*/

using namespace std;

int main()
{
     /** declare variables*/
    double radius,
         coneHeight,
         cylHeight,
         coneVol,
         semisphVol,
         cylVol,
         totalVol;

    /** prompt and read input*/
    cout << "Please enter the radius of the tank: ";
    cin >> radius;
    cout << "Please enter the height of cone portion: ";
    cin >> coneHeight;
    cout << "Please enter the Height of cylinder portion: ";
    cin >> cylHeight;

    /** perform calculation*/
    coneVol = (1/3.0) * M_PI * pow(radius,2) * coneHeight;
    cylVol = M_PI * pow(radius,2) * cylHeight;
    semisphVol = (1/2.0)*(4/3.0)* M_PI * pow(radius,3);
    totalVol = coneVol + cylVol + semisphVol;

    /**output stuff*/

    cout << fixed <<  setprecision(4);
    cout << "The volume of the cone portion is " << coneVol <<"."<< endl;
    cout << "The volume of the cylinder portion is " << cylVol <<"."<< endl;
    cout << "The volume of the sphere portion is " << semisphVol <<"."<< endl;
    cout << "The total volume is " << totalVol <<"."<< endl;
    return 0;
}
