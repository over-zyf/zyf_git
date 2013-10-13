//
//  Comm.h
//  calender
//
//  Created by SZH on 13-10-2.
//  Copyright (c) 2013年 SZH. All rights reserved.
//

#import <Foundation/Foundation.h>


static int daysInMonth_leap[12]={31,29,31,30,31,30,31,31,30,31,30,31};
static int daysInMonth_noLeap[12]={31,28,31,30,31,30,31,31,30,31,30,31};
bool is_leapyear(int year);
int daysCount(int year,int month,int day);
void printCalerdar(int year,int month,int weekday);
int weekday_days(int days);