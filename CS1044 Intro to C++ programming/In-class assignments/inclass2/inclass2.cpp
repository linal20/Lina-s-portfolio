#define _USE_MATH_DEFINES // for C++
#include <cmath>
#include <iostream>
#include <iomanip>

using namespace std;

int main()
{   /** declare variables*/
    double radius,
           diameter,
           circumference,
           circArea,
           sphArea,
           sphVolume;
    /** prompt and read input*/
    cout << "Enter the radius of a circle: ";
    cin >> radius;
//
/* This is a //*// First Rate Program //*//
**// This is a //**// First Rate Program //**//
    /** perform calculation*/
    diameter = 2 * radius;
    circumference= 2 * M_PI * radius;
    circArea = M_PI * radius * radius;
    sphArea = 4 * M_PI * pow(radius, 2);
    sphVolume = 4/3.0 * M_PI * pow(radius, 3);

    /**output stuff*/

    cout << fixed <<  setprecision(3);
    cout << "The diameter of the circle is "<< diameter <<"."<< endl;
    cout << "The circumference of the circle is "<< circumference <<"."<< endl;
    cout << "The area of the circle is " << circArea <<"."<< endl;
    cout << "The surface area of the sphere is " << sphArea <<"."<< endl;
    cout << "The volume of the sphere is " << sphVolume <<"."<< endl;

    return 0;
}
