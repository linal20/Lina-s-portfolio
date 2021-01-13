/**
* @file consts.h * this is the headers including constants for project HW4, tax calculation.
* @author Lina Lee
* @date   September 29th, 2020
*/

//these are my constants
// STD_DEDS is the Standard Deduction
// SINGLE means your status is single
// SINGLE10 means the upper bound of income for 10 percent of tax rate

const int STD_DEDS = 6300;
const int SINGLE10 = 9275;
const int SINGLE15 = 37650;
const int SINGLE25 = 91150;
const int SINGLE28 = 190150;
const int SINGLE33 = 413350;
const int SINGLE35 = 415050;

// there are constants for tax rates
const double PER10 = .1;
const double PER15 = .15;
const double PER25 = .25;
const double PER28 = .28;
const double PER33 = .33;
const double PER35 = .35;
const double PER39_6 = .396;

// JOINTLY means your status is married Filing Jointly or qualified widow(er)
// JOINTLY10 means means the upper bound of income for 10 percent of tax rate
const int STD_DEDJ = 12600;
const int JOINTLY10 = 18550;
const int JOINTLY15 = 75300;
const int JOINTLY25 = 151900;
const int JOINTLY28 = 231450;
const int JOINTLY33 = 413350;
const int JOINTLY35 = 466950;

// FILING means user's status is married Filing separately
// FILING10 means the upper bound of income for 10 percent of tax rate
const int STD_DEDF = 6300;
const int FILING10 =9275 ;
const int FILING15 =37650;
const int FILING25 =75950;
const int FILING28 =115725;
const int FILING33 =206675;
const int FILING35 =233475;

// HEAD means user's status is Head of Household
// HEAD10 means the upper bound of income for 10 percent of tax rate
const int STD_DEDH = 9300;
const int HEAD10 =13250;
const int HEAD15 =50400;
const int HEAD25 =130150;
const int HEAD28 =210800;
const int HEAD33 =413350;
const int HEAD35 =441000;
