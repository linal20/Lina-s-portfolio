/**
* @file inclass3.cpp * this project takes user input and generates a random computer value
* in order to play rock paper scissors in a simple program
*
* @author Lina Lee
* @date   September 9th, 2020
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
const double INCLASS3_PI = 3.14;

int main()
{
    string filename;
    ifstream in;
    const double PI=3.14;
    int int1, int2, result;
    double dbl1, dbl2, radius, area, semiCircleArea, fah, cel, fah1, fah2, numOfSides, lengthOfSides,
    radiusOfCircle,heightOfCone;


    /** prompt and read file name to read data from*/
    cout << fixed << setprecision(2);
    cout << "Name of input file: ";
    cin>> filename;

    in.open(filename.c_str());
    in>> int1 >> int2 >> dbl1 >> dbl2;
    result = int1 % int2;
    cout << "result = " << result << endl;
    result = int2 % int1;
    cout << "result = " << result << endl;
    result = int1/int2;
    cout << "result = " << result << endl;

    radius = dbl1;

    semiCircleArea = (1.0/2) * INCLASS3_PI * pow(radius,2);
    cout << "radius " << dbl1 << " ==> " << "area " << semiCircleArea << endl;

    cout << fixed << setprecision(4);
    cout << setw(12) << "p" << setw(12) << "e" << endl;
    cout << setw(12) << M_PI << setw(12) << M_E << endl;

    cout << fixed << setprecision(2);
    cel = dbl2;
    fah = (9.0 / 5.0) * cel + 32;

    cout << "celsius " << cel << " = " << "fahrenheit " << fah <<endl;


    fah1 = (double) (9 / 5) * cel + 32;
    fah2 = (double) 9 / 5 * cel + 32;
    cout << "fah1 " << fah1 << " ?==? " << "fah2 " << fah2 << endl;

    numOfSides=6;
    lengthOfSides=5;
    double dblVar = (1.0/4.0) * numOfSides * pow(lengthOfSides,2) * (1/tan(INCLASS3_PI/numOfSides));

    cout << "dblVar = " << dblVar << endl;

    radiusOfCircle = 5;
    heightOfCone = 10;
    dblVar = (1.0/3) * INCLASS3_PI * pow(radiusOfCircle,2) * heightOfCone;
    cout << "dblVar = " << dblVar << endl;

    dblVar = 15 % 4 * 11.0 / 5;
    cout << "dblVar = " << dblVar << endl;

    dblVar = 11.0/ 5 + 11 / 5;
    cout << "dblVar = " << dblVar << endl;


    return 0;
}
