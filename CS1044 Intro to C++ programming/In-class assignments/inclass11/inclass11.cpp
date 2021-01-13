#include <iostream>
#include <iomanip>
#include <fstream>

using namespace std;

void readInts(string, int*, int *);
void readIntArray(ifstream &inStream, int iarr[], int l);
void printIntArray(int *, int);
void swapFirstLast(int [], int);
void swapFirstSecond(int []);
void swapInts(int*, int*);

int main()
{
// declare an int const LEN = 10
    int const LEN = 10;
// declare 2 double pointers dptr1 and dptr2
    double *dptr1, *dptr2;
// declare 2 double variables dnum1, and dnum2, initializing
//    them to 2.5 and 100.1
    double dnum1=2.5,
           dnum2=100;
// declare a double array called darr of length LEN, initializing
//    to 1.5 2.2 3.7 4.5 5 and LEN, with the rest of the elements 0
    ;double darr[LEN]={1.5, 2.2, 3.7, 4.5, 5, LEN,0,0,0,0}

// declare 2 int pointers iptr1 and iptr2
    int  *iptr1, *iptr2;
// declare 2 int variables
     int inum1, inum2;
// declare an int array called iarr of length LEN, initializing
//    to 42 23 43 71 and 101, with the rest of the elements 0
    iarr[LEN]={42, 23, 43, 71, 101,0,0,0,0,0};

    string filename;
    ifstream inStream;

// to dptr1 assign the adresss of dnum1
    dptr1=&dnum1;
    dptr2=&dnum2;
    cout << fixed << setprecision(4);
// print the value of dptr1 as an int and in hexadecimal
    cout << "doubles " << *dptr1 << "(long) = "
         << *dptr1 << "(hex)\n";
// print the addresses of dptr1 and  dptr2
    cout << "dptr addresses [" << (long)dptr1 << "]  ["
         << *dptr2 << "]\n";
// print the addresses of dnum1 and  dnum2
    cout << "dnum addresses [" << &dnum1 << "]  ["
         <<&dnum2 << "]\n";
// print the address of the beginning of darr
    cout << "darr address [" << darr << "]\n\n";

// print the addresses of iptr1 and iptr2
    cout << "ints\n" << "int ptrs [" << iptr1
         << "]  [" << iptr2 << "]\n";
// print the addresses of inum1 and inum2
    cout << "inum addresses [" << &inum1 << "]  ["
         <<
         inum2 << "]\n";
// print the address of the beginning of iarr
    cout << "iarr address [" << iarr<< "]\n\n";

    cout << "Values of the double variables:    ";
// print dnum1 and dnum2
    cout << dnum1 << "  " << dnum2 << endl;
// assign dptr1 the address of dnum1
    dptr1=&dnum1;

// make dptr2 point to the same thing as dptr1
    dptr2=dptr1;
// use * of dptr2 to set the VALUE of dnum1 to 3.14159
    *dptr2 = 3.14159;
    cout << "  Values of double variables again: ";
// print dnum1 and dnum2 again
    cout << dnum1 << "  " << dnum2 << endl;

// print the values of what dptr1 and dptr2 point at
    cout << "value pointed at by dptr1 & dptr2: "
         << *dptr1 << "  " << *dptr2 << endl;

    cout << "int array:\n";
// set iptr1 equal to the beginning address of iarr
    iptr1=iarr;
    for (int i=0; i < LEN ; i++)
    {
// use iptr1 to print each of the 10 numbers in the
//     int array and increment the pointer
        cout << "  " << *iptr1++ << endl;
    }

    cout << "==============\n\n";
    cout << "double array:\n";
// set dptr1 equal to the beginning address of darr
    ;
    for (int i=0; i < LEN ; i++)
    {
// use dptr1 to print each of the 10 numbers in the
//     double array and increment the pointer
        cout << "  " << *dptr1++ << endl;
    }

// set iptr2 to the address of inum2
   iptr2 = &inum2 ;
// call void readInts( string promptString, int* int1, int* int2)
//     - read values for inum1 and use iptr2 to read a value for inum2
    readInts("Enter 2 ints to return: ", &inum1, iptr2);
    cout << "ints read by readInts(): " << inum1 << ", "
// 2 different values can fill in this blank. You need to know both.
         << *iptr2 << endl << endl;

    cout << "enter a file name to read from: ";
    cin >> filename;
    inStream.open(filename.c_str());
    if ( !inStream )
    {
        cout << "Error!\n";
        return 1;
    }

// call void readIntArray(ifstream infile, int intArray[], int len)
    readIntArray(inStream, int iarr, LEN);
    cout << "PRINT int ARRAY 1:\n";
// call void printIntArray(int arr[], LEN)
    printIntArray(iarr, LEN);
    cout << "swap first and last elements in the array\n";
// call void swapFirstLast(int arrINTs[], LEN)
    swapFirstLast(iarr, LEN);
    cout << "PRINT int ARRAY 2:\n";
// call void printIntArray(int arr[], LEN)
    printIntArray(iarr, LEN) ;

    cout << "swap first and second elements of the array\n";
// call void swapFirstSecond(int arrints[])
    swapFirstSecond(iarr);
    cout << "PRINT int ARRAY 3:\n";
// call void printIntArray(int arr[], LEN)
    printIntArray(iarr, LEN);

    cout << "Point iptr1 to second and iptr2 to "
         << "third numbers in the iarr\n";
    iptr1 = &iarr[5];
    iptr2 = &iarr[6];
    cout << "Swap ints pointed at by iptr1 and 2.\n";
// call void swapInts(int *p1, int *p2)
    swapInts(&iarr[1],&iarr[2]);
    cout << "PRINT int ARRAY 4:\n";
// call void printIntArray(int arr[], LEN)
    printIntArray(iarr, LEN);;

    return 0;
}
readIntArray();
void readInts(string ,&inum1, iptr2)
{
    cout << prompt ;
    cin >> inum1 >> iptr2;
    return;
}

void readIntArray(&inStream, int iarr, LEN)
{

    for (int i = 0; i < l ; i++)
    {
        in >> iarr[i];
    }
    return;
}

void printIntArray(_____________________)
{
    int i;
    for ( i = 0; i < len-1 ; i++)
    {
        cout << __________________ << ", ";
    }
    cout << _________________ << endl << endl;
    return;
}

void swapFirstLast(____________________)
{
    int __________________;
    ;
    ;
    return;
}

void swapFirstSecond(__________________)
{
    int _______________;
    ;
    ;
    return;
}

void swapInts(____________________)
{
    int _____________;
    ;
    ;
    return;
}

