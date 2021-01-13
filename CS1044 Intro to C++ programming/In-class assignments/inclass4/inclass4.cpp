/**
* @file inclass4.cpp * this project takes user input and generates a random computer value
* in order to play rock paper scissors in a simple program
*
* @author Lina Lee
* @date   September 16th, 2020
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
* notes, that has been clearly noted with a proper citation in *
 the comments of my program.
* - I have not designed this program in such a way as to defeat or
* interfere with the normal operation of the Web-Cat Server. *
* Lina Lee
*/
#include <fstream>
#include <iostream>
#include <iomanip>
#define _USES_MATH_DEFINES //for C++
#include <cmath>

using namespace std;

int main()
{
    double area, diameter, radius;
    int nslice, Bill, Joe, Sue;


    cout << "Enter diameter of the pizza: ";
    cin >> diameter;
    radius = diameter/2.0;
    area=M_PI*pow(radius,2);
    nslice=area/19.625;
    Bill=nslice/4;
    Joe=nslice/2;
    Sue=nslice/3;

/*    cout  << diameter << endl;
    cout  << radius << endl;
    cout << area << endl;**/

    cout << "\n\nThis pizza is cut into " << nslice << " slices." <<endl;
    cout << "It would serve " << Bill <<" Bills or " << Joe << " Joes or " << Sue <<" Sues.";



    return 0;
}
