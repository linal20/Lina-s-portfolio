#include <iostream>

/**
* @file inclass7.cpp * this project is to understand loops and when it is best to use a for loop and when to use a while loop.

* @author Lina Lee
* @date   October 15th, 2020
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

using namespace std;

int main()
{   int i,j,k,l,n, int1,int2, int3, int4, int5, int6, total,total2,total3;
    cout << "Hello world!" << endl;

    //loop2
    cout<<"#2:"<<endl;
    for(i=1; i<=10;i+=1)
        {
            cout << i<<endl;
        };

    //loop3
     cout<<"#3:"<<endl;
    for(j=0; j<=100;j+=1)
        {
            if(j%2==0){
                cout<<j<<endl;
            }

        };

     cout<<"#4:"<<endl;

    //loop4
     cout<<"Input a Number to print up to: ";
     cin>>n;

     if(n>0)
     {
           for(l=0;l>=0 && l<=n;l+=1)
         {
             cout<<l<<endl;
         }
    }

    //loop5
    cout<<"#5:"<<endl;

    cout << "How many numbers to add up: ";
    cin >> n;
    total=0;
    if(n>0)
    {
        for(l=1;l<=n;l+=1)
        {
            cin>>int6;
            total+=int6;
        }
        cout<< "total: " <<total <<endl;
    }

    //loop6

    cout<<"#6:"<<endl;
    total=0;

    cout << "Enter positive numbers to add up until a negative number is entered: ";
    cin>> int1;
    while(int1>0)
    {
     total+=int1;
     cin >> int1;
    }
    cout << "total: " <<total <<endl;


//    loop6
//    cin>>int2;
//    total2=int2;
//    int3=0;
//
//    do
//    {
//      total2+=int3;
//      cin>>int3;
//    }while(int3!=int2);
//    cout << total2 <<endl;

    //loop7
     cout<<"#7:"<<endl;

    cout << "Input a Sentinel Number: ";
    cin>>int4;

    total3=0;
    int5=0;
      if(int4>0)
      {
        do
        {
          total3+=int5;
          cin>>int5;
        }while(int5!=int4);

        cout << "total: " << total3 <<endl;

      }

    //loop8
    cout<<"#8:"<<endl;
    k=1;
    while(k<=5)
    {
        k+=1;
        cout << "*" <<endl;
    }

    //loop9
    cout<<"#9:"<<endl;
        k=1;
    while(k<=5)
    {
        k+=1;
        cout << "*" ;
    }
       cout<< ""<<endl;

    //loop10
    cout<<"#10:"<<endl;
        k=1;

    cout << "Input a Number: ";
    cin>> n;
    while(k<=n)
    {
        k+=1;
        cout << "*";
    }
    cout<<endl;
    //loop11
    cout<<"#11:"<<endl;

    cout << "Input a Number: ";
    cin >> n;

    for(i=1;i <=n ;i+=1)
    {
        for(j=1;j<=i;j+=1)
        {
            cout << "*" ;
        }
        cout<<"\n";
    }
    //loop12
    cout<<"#12:"<<endl;

    cout << "Input a Number: ";
    cin >> n ;
    for(i=n; i>0 ;i-=1)
    {
        for(j=1;j<=i;j+=1)
        {
            cout << "*" ;
        }
        cout<<"\n";
    }
    //loop13
    cout<<"#13:"<<endl;

    cout << "Input an ODD Number: ";
    cin>>n;
    for(i=1;i <=n ;i+=1)
    {
        for(j=1;j<=i;j+=1)
        {
            if(i%2!=0)
               cout << "*" ;
        }
        if(i%2!=0)
           cout<<"\n";
    }
  //loop14
    cout<<"#14:"<<endl;

    cout << "Input an ODD Number: ";
    cin>>n;

    for(i=n; i>0 ;i-=1)
    {
        for(j=1;j<=i;j+=1)
        {
            if(i%2!=0)
                cout << "*" ;
        }
        if(i%2!=0)
           cout<<"\n";
    }
    return 0;

}
