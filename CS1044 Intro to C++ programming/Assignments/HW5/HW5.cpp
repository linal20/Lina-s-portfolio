/**
* @file HW5.cpp * this project, you2 read in numbers from a file until the end-of-file, and
you add them up as you go. You also count the numbers so you can then print the average of the
numbers.

* @author Lina Lee
* @date   October 11th, 2020
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

using namespace std;


int main()
{
    string filename;
    ifstream myInfile;
    double num, sum, avg;
    int counter;

    cout << "Enter a file name: "<< endl;
    cin >> filename;

	myInfile.open(filename.c_str());

	if ( ! myInfile) // the ! means myInfile is non 0, indicating it is OK
	{
		cout <<  "ERROR!\n";
		return 1;
	}

//    myInfile >> num;

    counter=0;
    sum=0;
    cout << fixed << setprecision(2);

    while ( myInfile )
{
     // sum number
     sum = sum + num;
     counter++;
     avg = sum/counter;
     myInfile >> num;
     if ((counter % 10) == 0)
        cout << "With " << counter<< " numbers, the average is " << avg << "." << endl;

}
    avg = sum/counter;
    cout << "There are " << counter << " numbers in the file with an average of " << avg << ".";

    return 0;
}
