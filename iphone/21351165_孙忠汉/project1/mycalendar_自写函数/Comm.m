//
//  Comm.m
//  calender
//
//  Created by SZH on 13-10-2.
//  Copyright (c) 2013年 SZH. All rights reserved.
//

#import "Comm.h"

bool is_leapyear(int year)
{
    //if((y%4==0 && y%100!=0) || y%400==0)
    // return 1;
    bool is_leap=NO;
    if (year<1752) {
        if (year%4==0) {
            is_leap=YES;
        }
    }else
    {
        if((year%4==0 && year%100!=0)||year%400==0)
            is_leap=YES;
    }
    return is_leap;
    
}

void printCalerdar(int year,int month,int weekday)
{
    
    
    printf("       %d月 %d\n",month,year);
    printf("日 一 二 三 四 五 六\n");
    int i=0,flag=0,count=1,end=0;
    bool leap=is_leapyear(year);
    int scop=leap?daysInMonth_leap[month-1]:daysInMonth_noLeap[month-1];
    if(year==1752 && month==9)
    {
        printf("       1  2 14 15 16\n");
        printf("17 18 19 20 21 22 23\n");
        printf("24 25 26 27 28 29 30\n");
        return;
    }
    while (end==0) {
        for (i=1; i<=7; i++) {
            if (flag==0) {
                if(weekday==i)
                {
                    printf("%2d ",count++);
                    flag=1;
                }
                else{printf("   ");}
                
            }
            else {
                printf("%2d ",count++);
                
                if (count-1>=scop) {
                    end=1;
                    break;
                }
            }
        }
        printf("\n");
    }
}
int daysCount(int year,int month,int day)
{
    int days=0;
    int i_count=0;
    
    //  int daysInMonth_leap[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    //  int daysInMonth_noLeap[12]={31,29,31,30,31,30,31,31,30,31,30,31};
    for (i_count=1; i_count<year; i_count++) {
        if(is_leapyear(i_count)){
            days+=366;
        }
        else{
            days+=365;
        }
    }
    for (i_count=1; i_count<month; i_count++) {
        if (is_leapyear(year)) {
            days+=daysInMonth_leap[i_count-1];
        }else {
            days+=daysInMonth_noLeap[i_count-1];
        }
    }
    days+=(day-1);//
    if(year>1752 ||(year==1752 && month>9))days-=11;
    return days;
}

int weekday_days(int days)
{
    int base=6,weekday=0;
    weekday=(days%7+base)%7;
    return weekday+1;
}