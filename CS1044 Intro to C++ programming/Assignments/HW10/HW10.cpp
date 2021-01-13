#include <iostream>
#include <fstream>

using namespace std;

// prototypes & constants
int readArray(ifstream& ifile, long arr[]);
void sortArray(long arr[], int numberInTheArray);

const int LG = 1000;  // You can change the value of LG while you are
                      //  developing your program to test smaller data files.

int main()
{
	//Declare variables
	string infile2; //user's inputed file name
	ifstream myInfile;
	long inputArray[LG];
	long ith; //user's inputed value to print ith value
	int number = 0;
	int i; //value that gets returned by readArray()

	//Prompts user for file
	cout << "Input File Name: ";
	cin >> infile2;

	//Open the input file
	myInfile.open(infile2.c_str());

	//Check to see if infile is okay
	if ( ! myInfile)
	{

        cout << "That file does not exist!" <<endl;
        return 1;
	}

//	myInfile>>inputArray[0];
//



	//Ask user which number they want to return
	cout << "Which number do you want to return? ";
	cin >> ith;

	//call readArray
	number = readArray(myInfile,inputArray);
//    cout << number <<endl;
	// Output after readArray but before sortArray
	     // Print first, last, etc.
       if (!number)
	{

        cout << "The file is empty!" <<endl;
        return 1;
	}

	if ( number < LG  )   // if there are less than LG numbers in the file
	{
		cout << "\nBefore Sort:" << endl;
		     // print first & last
              cout<<" First is {"<< inputArray[0]<<"}."<<endl;
		      cout<<" Last is {"<< inputArray[number-1]<<"}."<<endl;
		      // print warning message
              cout<<" WARNING: Only "<< number <<" numbers were read into the array!"<<endl;
        // print "Value XXX is" OR error message
		if (  number >=ith   )    // if number read is less than or = the ith value,
                           //      then you can print Value ith is { }
		{
		    cout<<" Value "<< ith <<" is {"<< inputArray[ith-1]<<"}."<<endl;
		}
		else // print 'not that many numbers'
		{
			cout << " There aren't that many numbers in the array!" <<endl;
		}

////		for(i=0;i<number;i++)
////        {
////            cout<< inputArray[i]<<endl;
////        }

		//call sortArray
        sortArray(inputArray, number);

//            for (i= 0; i  < number;  i++)
//        {
//            cout<< inputArray[i];
//
////        cout <<count << "  " << arr[count]<<endl;
//        }
		//Outputs after sortArray
		// Print min/first, max/last, and amount of numbers in the array AFTER the sort
		cout << "\nAfter Sort:" << endl;
		     // print first & last
              cout<<" Min is {"<< inputArray[0]<<"}."<<endl;
		      cout<<" Max is {"<< inputArray[number-1]<<"}."<<endl;
		     // print warning message
		     cout<<" WARNING: Only "<< number <<" numbers were read into the array!"<<endl;
		     // print "Value XXX is" OR error message
		if (   ith <= number   ) // same if/else as above to print Value
		{
            cout<<" Value "<< ith <<" is {"<< inputArray[ith-1]<<"}."<<endl;
		}
		else // print 'not that many numbers'
		{
			cout << " There aren't that many numbers in the array!" <<endl;
		}
	}
	//   --the array is full
     // if the amount of numbers in the file is larger than LG (the const array size)
	// data printed shows the min, max and value, but lets the user know the value is
	// larger than the constant value
	else
	{
		// Prints first & last
		cout << "\nBefore Sort:" << endl;
		     // print first & last
              cout<<" First is {"<< inputArray[0]<<"}."<<endl;
		      cout<<" Last is {"<< inputArray[number-1]<<"}."<<endl;
		if (ith <= number)   // print "Value XXX is" OR error message
		{
            cout<<" Value "<< ith <<" is {"<< inputArray[ith-1]<<"}."<<endl;
		}
		else
		{
            cout <<" " << ith <<" is bigger than 1000!" <<endl;
		}

		//call sortArray
        sortArray(inputArray, number);

		//Outputs after sortArray
		cout << "\nAfter Sort:" << endl;
                // print first & last
              cout<<" Min is {"<< inputArray[0]<<"}."<<endl;
		      cout<<" Max is {"<< inputArray[number-1]<<"}."<<endl;
		     // print min (which is first) and max wich is last

		if (ith <= number)  // print "Value XXX is" OR error message
		{
            cout<<" Value "<< ith <<" is {"<< inputArray[ith-1]<<"}."<<endl;
		}
		else //(ith > LG)
		{
            cout << " " << ith <<" is bigger than 1000!" <<endl;
		}
	}

	//Close the input file
	myInfile.close();

	return 0;
}  // end of main()


/** Reads the array from infile
 *
 * @param function takes the user choice as an ifstream (ifile)
 *@param function takes the user choice as a long (arr[])
 *
 */
int readArray(ifstream& ifile, long arr[])
{
	int count = 0;
   //  count  < LG && ifile
//           ifile >> arr[count];

        for (count = 0; count  < LG && ifile>>arr[count] ; count++)
    {


//        cout <<count << "  " << arr[count]<<endl;


    }
//    cout << count;
    return count;
}

/** Bubble sort the array
 *
 * @param function takes the user choice as a long (arr[])
 * @param function takes the user choice as an int(numberInTheArray)
 *
 */
void sortArray(long arr[], int numberInTheArray)
{
	//initialize variables
	int temp = 0;

	//for loop sorts array from 0 to numberInTheArray-1
	 for(int i = 0 ; i < numberInTheArray;i++)
    {
        for(int j = i+1 ; j< numberInTheArray;j++)
        {
            if(arr[i] > arr[j])
            {
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }
}
