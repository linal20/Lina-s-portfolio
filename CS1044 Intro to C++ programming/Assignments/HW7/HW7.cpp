/**
* @file HW7.cpp *

* @author Lina Lee
* @date   October 25th, 2020
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

#include <iostream>
#include <iomanip>
#include <cmath>
#include <string>

using namespace std;


bool sorted(int a, int b, int c);
double calcTerm (double a, double b );
string concatString(string a, string b);
int lowcaseNum(string a);
long multiplyDigits (int val);

int main()
{
    int  c, digits;
    double a,b;
    double s;
    bool result;
    string stra, strb;

    // function 1
    cout << "Enter 3 ints to see if they are sorted: ";
    cin >> a >> b >> c ;
    result = sorted(a,b,c);
    cout << "Sorted? " << boolalpha << result <<endl;
    cout << endl;

    cout << boolalpha << fixed << setprecision(2);
    // function 2
    cout <<"Enter 2 numbers you want to calculate: ";
    cin >> a >> b ;
    s=calcTerm(a,b);
    cout << "The result is: " << s <<endl;
    cout << endl;

    cout << "Enter the first string: ";
    cin >> stra;
    cout << "Enter the second string: ";
    cin >> strb;
    cout << "The result string is: " << concatString(stra,strb) <<endl;
    cout << endl;

    cout << "Enter the string you want to count: ";
    cin >> stra;
    cout << "The number of lower case letters in this string is: " << lowcaseNum(stra)<< endl;
    cout << endl;

    cout <<"Enter int value to multiply digits: ";
    cin >> digits;
    cout <<"Multiplied digits equals: " << multiplyDigits (digits);


    return 0;
}

bool sorted(int val1, int val2, int val3){
    bool result;
        if(val1 <= val2 && val2<=val3)
        {
            result=true;
        }
        else
        {
            result=false;
        }
    return result;
}

double calcTerm (double vala, double valb ){
    double num1,num2, s;
    num1= pow(vala,2)-valb;
    num2= pow(valb,2)-vala;

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
string concatString(string vala, string valb){
    string ab;
    ab=vala+" "+valb;
    return ab;
}

int lowcaseNum(string str){
    int i;
    int lower=0;
    for (unsigned i=0; i<str.length(); ++i){
        if(str.at(i)>='a' && str.at(i)<='z'){
            lower++;
        }
    }
    return lower;
}

long multiplyDigits (int val){
    int product = 1;

    while (val != 0)
    {
        product = product * (val % 10);
        val = val / 10;
    }

    return product;
}
