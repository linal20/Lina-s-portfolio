#include <fstream>
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;


double MaxNumbers(double num1, double num2);
int calcCubeSizes(double edgeLen, double &area, double &volume );
int splitNumber(double number, int &integ, double &decimal );
int openAndReadNums(string filename, ifstream&fn, double& f, double& s);

int main()
{
    int ret2;
    double ret1, num1, num2, number, area, volume, edgeLen;
    double f, s, third;
    int integ;
    double decimal;
    string filename;
    ifstream file;



    cout<< "Enter 2 numbers to find the max one: ";
    cin>> num1 >> num2;
    //function call #1 You add the call.
    ret1 = MaxNumbers(num1, num2);

    cout<< fixed <<setprecision(2) << "The max one is: " << ret1 << endl;


    cout<< "\nEnter a edgeLen: ";
    cin >> edgeLen;
    // function #2 You add the call, using surface and area as some of the parameters.
    ret2 = calcCubeSizes(edgeLen, area, volume)               ;

    cout << "Surface Area: " << area <<endl;
    cout << "Volume: " <<volume<<endl;


    cout << "\nEnter a number: ";
    cin >> number;
    // function #3 You add the call, using number,
    //         num1 as the integral and num2 as the decimal parameters.
    ret2 =  splitNumber( number, integ, decimal);                  ;
    cout << "The integral part: " << integ <<endl;
    cout << "The decimal part: " << decimal <<endl;
    cout << endl;

    cout<< "Enter a filename to read from: ";
    cin>> filename;

//     function #4 You add the call, using file, num1, and num2 as some of the parameters.
    ret2 =   openAndReadNums(filename, file, f, s )   ;
    if ( ! ret2 )
    {
        // This variable file ifstream is the param returned by openAndReadNums().
        //      This statement reads and then print a third number.
        //      You can read from file inside the function AND here because you
        //      are passing it as a reference parameter.
        file >> third;
        cout<< "first=" << f << " second=" << s << " third=" << third <<endl;
    }
    else
        cout<< "File did not open or Read failed\n\n";
    return 0;
}

double MaxNumbers(double num1 , double num2 )
{
    double s;
    if(num1>num2)
    {
        s=num1;
    }
    else
    {
        s=num2;
    }
    return s;
}

int calcCubeSizes(double edgeLen, double&surfaceArea, double& volume)
{
    surfaceArea = 6*pow(edgeLen,2);
    volume = pow(edgeLen,3);
    edgeLen=0;
//    if (surfaceArea>0 && volume>0)
//    {
//        return 0;
//    }
//    else
//    {
//        return -1;
//    }
    return 1;
}

int splitNumber(double number, int& integral, double& digital)
{
    integral=number/1;
    digital=number-integral;
    return 0;
}

int openAndReadNums(string filename, ifstream&fn, double&f, double &s)
{
    fn.open(filename.c_str());
    if(!fn)
    {
        cout<<"Error!";
        return 1;
    }

    fn>> f >> s ;
     if(!fn)
    {
        cout<<"Error Reading!";
        return 1;
    }
    return 0;
}
