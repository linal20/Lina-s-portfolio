/**
* @file inclass6.cpp * this project takes user input and generates a random computer value
* in order to practice while loop

* @author Lina Lee
* @date   October 8th, 2020
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
    int num1, num2, num3, num4, loop1, counter, counter2, sum1, sum2;
    double num, num5, total1, total2;
    char answer = 'y';
    cout << fixed <<  setprecision(4);

    /** prompt and read file name to read data from*/


    //loop1
    cout << "Enter the number to add the even numbers up to: "<< endl;
    cin >> num1;
    loop1=0;
    sum1=0;
    while (loop1 <= num1)
          {
                if (loop1%2==0)
                {
                   sum1 = sum1 + loop1;
                   loop1 = loop1+2;
                }
          }

    cout << "LOOP1 total = " << sum1 << endl;

    //loop2
    cout << "Enter a lower and upper number to sum: "<< endl;
    cin >> num2 >> num3;
    sum2=0;
    int x=num2;
    while (x<=num3)
        {

         sum2 += x;
         x++;
        }

    cout << "LOOP2 total = " << sum2 << endl;

    //loop3
    do
    {
    cout << "Enter a file name to read from: "<< endl;
    cin >> filename;


    myInfile.open(filename.c_str());

	if ( ! myInfile) // the ! means myInfile is non 0, indicating it is OK
	{
		cout << "error opening file!\n\n";
		break;
	}

	myInfile >> num;    // priming read

        // myInfile here means the file is open and ready for reading
	   //   Specifically, none of the stream's error flags (eofbit, failbit and badbit) are set
	counter2=0;
	total1=0;
	while ( myInfile )
	{
	    total1 = total1 + num;
         counter2++;
		myInfile >> num;
	}
	myInfile.close();		  // Close the file(s)



    cout << "LOOP3 total = " << total1 << endl;
    cout << "Do you want to do all of this again? ";
    cin >> answer;
    } while (answer == 'y' || answer == 'Y');




    //loop4
    cout << "Enter another file name to add 5 numbers from: "<< endl;
    cin >> filename;


    myInfile.open (filename.c_str()) ;

	if ( ! myInfile) // the ! means myInfile is non 0, indicating it is OK
	{
		cout << "error opening file!\n\n";
		return 1;
	}

    myInfile >> num5;// priming read

	counter=0;
    total2=0;
	while ( counter<5 )
	{
	    total2 = total2 + num5;
         counter++;
		myInfile >> num5;
		if(counter==2)
            {
                cout << "number3 = " << num5 <<endl;
            }
	}
	myInfile.close();		  // Close the file(s)



    cout << "LOOP4 total = " << total2 << endl;



    cout << "End of Program!";

    return 0;
}
