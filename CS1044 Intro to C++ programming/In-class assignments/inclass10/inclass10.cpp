#include <iostream>
#include <fstream>
using namespace std;

int main()
{
    string filename;
    ifstream in, fn;
    int arr[100];
    int arr2[100];
    int i,j, int1,int2;
    for(i=0;i<100;i++)
    {
        arr[i]=i*i;
        cout << "array[" << i << "] = "<<arr[i] << endl;
    }

    cout << "Input File Name B: ";
    cin>> filename;

    in.open(filename.c_str());

     for(i=0;i<100;i++)
    {
        in>>int1;
        arr[i]=int1;
    }
    cout << "array[10] = "<<arr[10] << endl;
    cout << "array[20] = "<<arr[20] << endl;
    cout << "array[30] = "<<arr[30] << endl;
    cout << "array[40] = "<<arr[40] << endl;
    cout << "array[50] = "<<arr[50] << endl;

    cout << "Input File Name C: ";
    cin>> filename;
    fn.open(filename.c_str());

    for(j=0;j<100 && !fn.eof();j++)
    {
//       if()
//        {
            fn>>int2;
            arr2[j]=int2;
//        }
    }

     cout << arr2[j-1]<< endl;


    return 0;
}
