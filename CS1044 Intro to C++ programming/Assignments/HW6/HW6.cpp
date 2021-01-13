/**
* @file HW6.cpp *

* @author Lina Lee
* @date   October 18th, 2020
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

using namespace std;

int main()
{   int i,j,k,l,c,int1;

    cout << "Enter an odd number width: ";
    cin >> int1;


//    for(i=1;i<=int1;i+=1)
//    {
//        for(j=1;j<=i && i%2!=0  ;j+=1)
//            {
//            }
//            cout<< endl;
//    }
//
//    for(i=1; i<=int1 && i%2!=0; i++)
//    {
//        cout<<"*"<<endl;
//    }
//
//    cout<< endl;
    cout<< "Hill:" <<endl;
    for(i=1; i<=int1; i+=2)
    {
      for(k=1; k<=i; k++)
        {
          cout<<"*";
        }
      cout<<"\n";
    }
   cout<<"\n";


   cout<<"Triangle:"<<endl;
        for(i=1; i<=int1; i+=2)
    {
      for(j=int1-1; j>=i; j-=2)
        {
          cout<<" ";
        }
      for(k=1; k<=i; k++)
        {
          cout<<"*";
        }
      cout<<"\n";
    }

   cout<<"\n";
   cout<<"Diamond:"<<endl;

    for(i=1; i<=int1; i+=2)
    {
      for(j=int1-1; j>=i; j-=2)
        {
          cout<<" ";
        }
      for(k=1; k<=i; k++)
        {
          cout<<"*";
        }
      cout<<"\n";
    }

    for(i=3; i<=int1; i+=2)
    {
      for(k=2; k<=i; k+=2)
        {
          cout<<" ";
        }
      for(j=int1; j>=i; j-=1)
        {
          cout<<"*";
        }

      cout<<"\n";
    }

////  int space = 1;
////
////  for (k = 1; k<= int1 - 2; k++)
////  {
////    for (c = 1; c< space; c++)
////      cout<<" ";
////
////    space++;
////
////    for (c = 1 ; c<= 2*(int1-k-1)-1; c++)
////      cout<<"*";
////
////    cout<<"\n";
////  }

    return 0;
}
