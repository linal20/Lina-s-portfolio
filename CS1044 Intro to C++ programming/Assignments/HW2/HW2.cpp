#define _USE_MATH_DEFINES // for C++
#include <cmath>
#include <iostream>
#include <iomanip>
#include <fstream>


/**
* @file HW2.cpp * this project takes user input and generates a random computer value
* in order to play rock paper scissors in a simple program
*
* @author Lina Lee
* @date   September 12th, 2020
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
* interfere with the
 normal operation of the Web-Cat Server.
* Lina Lee
*/

using namespace std;

int main()
{
    string filename;
    ifstream in;

     /** declare variables*/
    double radius,
         coneHeight,
         cylHeight,
         coneVol,
         semisphVol,
         cylVol,
         totalVol,
         coneSur,
         cylSur,
         sphSur,
         totalSur,
         int1,
         int2,
         dbl1;

    /** prompt and read input*/
    cout << "Name of input file: ";
    cin >> filename;

    /*cout << "Please enter the radius of the tank: ";
    cin >> radius;
    cout << "Please enter the height of cone portion: ";
    cin >> coneHeight;
    cout << "Please enter the Height of cylinder portion: ";
    cin >> cylHeight;*/

    in.open(filename.c_str());
    in>> int1 >> int2 >> dbl1;

    radius = int1;
    coneHeight = int2;
    cylHeight = dbl1;


    /** perform calculation*/
    coneVol = (1/3.0) * M_PI * pow(radius,2) * coneHeight;
    cylVol = M_PI * pow(radius,2) * cylHeight;
    semisphVol = (1/2.0)*(4/3.0)* M_PI * pow(radius,3);
    totalVol = coneVol + cylVol + semisphVol;

    coneSur = M_PI * radius * pow(pow(radius,2)+pow(coneHeight,2), 1/2.0);
    cylSur = 2 * M_PI * radius * cylHeight;
    sphSur = (1/2.0) * 4 * M_PI * pow(radius,2);
    totalSur = coneSur + cylSur + sphSur;

    /**output stuff*/

    cout << fixed <<  setprecision(3);
    cout << "The volume of the cone portion is " << coneVol <<"."<< endl;
    cout << "The volume of the cylinder portion is " << cylVol <<"."<< endl;
    cout << "The volume of the sphere portion is " << semisphVol <<"."<< endl;
    cout << "The combined volume is " << totalVol <<"."<< endl;

    cout << "\nThe surface area of the cone portion is " << coneSur <<"."<< endl;
    cout << "The surface area of the cylinder portion is " << cylSur <<"."<< endl;
    cout << "The surface area of the sphere portion is " << sphSur <<"."<< endl;
    cout << "The combined surface area is " << totalSur <<"."<< endl;
    return 0;
}
