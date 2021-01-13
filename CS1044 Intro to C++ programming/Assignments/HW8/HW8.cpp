/**
 * @file HW8.cpp

 * this project takes user input and generates a random computer value
 * in order to play rock paper scissors in a simple program
 *
 * @author Lina Lee
 * @date   November 3th, 2020
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
 *
 * Lina Lee
 */

//these are my includes
#include <fstream>
#include <iostream>
#include <iomanip>
#include <cmath>
#include <cfloat>

using namespace std;

//these are the function prototypes for the various functions used
bool gotRoots(double , double , double , double &, double &);
int openAndReadNums(string , ifstream & , double &,double &,double &);

/**
 * this is my main function to find the largest root from all of the calls to
gotRoots(), reading 3 numbers at a time from a file. In more detail, read 3 numbers at a time
using openAndReadNums(), call gotRoots() using the 3 numbers for a, b, and c; and then
compare the 2 roots returned to find the largest root of all returned from all the calls to
gotRoots().
 * @return 0 indicates a successful completion
 */
int main()
{
    //variable declaration
    string filename;
    int ret1, ret2;
    ifstream fn;
    double num1, num2,num3,r1,r2, largest2;
    double largest = -DBL_MAX;

    // prompt filename
    cout << "Enter a filename to read from: ";
    cin>> filename;

    // call this function to open file and read three numbers in the file.
    ret1=openAndReadNums(filename, fn, num1, num2, num3);


    filename="";
    if ( ret1 )
    {
    while (fn)
    {// while file still reading OK

    // execute function to calculate root
	if (gotRoots(num1,num2,num3,r1,r2)==true)
    {
        // get the largest one among two roots
        largest2 = max(r1,r2);
        // get the largest one among all the roots
        largest = max(largest,largest2);
    }
        //  open a file with filename,and read 3 numbers at a time from a file. In more detail, read 3 numbers at a time
        ret2=openAndReadNums(filename, fn, num1, num2, num3);

    }
    cout << fixed << setprecision(2);
    cout<<"Largest root: "<<largest<<endl;
    }
    else
    {
        cout<<"Error opening file!";
    }
    return 0;
}

/** This function is to open a file with filename, using fn, and read 3 double numbers
   @param filename: file name you want to open
   @param n1-n3: three numbers you read from the file.
   @return 2 if function completed successfully
*/
int openAndReadNums(string filename, ifstream& fn, double&n1,double &n2, double &n3)
{


     if (filename == "")
     {
        fn>> n1 >> n2 >> n3;
        if(!fn)
        {
            cout<<"EOF reached!"<<endl;
            return 1;
        }

     }
     else
    {
        fn.open(filename.c_str());
        fn>> n1 >> n2 >> n3;
    }
    return 2;
}



/**
    This is my function that is called to calculate the roots for given numbers for a,b,and c.
   @param a-c:three numbers you read from the file.
   @param r1,r2: roots of the quadratic equation calculated with given numbers a,b,and c.
   @return true when there are real-valued roots, false when there are no real-valued roots.
*/

bool gotRoots(double a, double b, double c, double &r1, double &r2)
{
    double temp;
    temp = b * b - 4.0 * a * c;
    if(temp>0)
    {
        r1 =(-b + sqrt(temp)) /(2.0 * a);
        r2 =(-b - sqrt(temp)) /(2.0 * a);
        a = b = c = 0;
        return true;
    }
    else
    {
        return false;
    }
}
