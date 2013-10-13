//
//  Calender.m
//  calender
//
//  Created by SZH on 13-10-2.
//  Copyright (c) 2013年 SZH. All rights reserved.
//

#import "Calender.h"
#import "Comm.h"

@implementation Calender

-(id)initYear:(int)year Month:(int)month Day:(int)day
{
    if(self== [super init])
    {
        m_days=0;
        m_weekday=0;
        m_year=year;
        m_month=month;
        m_day=day;
    }
    return self;
}


-(int) Year
{
    return m_year;
}
-(void)setYear:(int)year
{
    m_year=year;
}

-(int)Month
{
    return m_month;
}
-(void)setMonth:(int)month
{
    m_month=month;
}
-(int)Day
{
    return m_day;
}
-(void)setDay:(int)day
{
    m_day=day;
}

-(int)Days
{
    return daysCount(m_year, m_month,m_day);
}

-(int)Weekday
{
    m_days=daysCount(m_year, m_month,m_day);
    return weekday_days(m_days);
}
-(int)daysCountYear:(int)year Month:(int)month
{
    int days=0;
    int i_count=0;
    
  //  int daysInMonth_leap[12]={31,28,31,30,31,30,31,31,30,31,30,31};
  //  int daysInMonth_noLeap[12]={31,29,31,30,31,30,31,31,30,31,30,31};
    for (i_count=1; i_count<year; i_count++) {
        if(is_leapyear(i_count)){
            days+=365;
        }
        else{
            days+=366;
        }
    }
    for (i_count=1; i_count<month; i_count++) {
        if (is_leapyear(year)) {
            days+=daysInMonth_leap[i_count-1];
        }else {
            days+=daysInMonth_noLeap[i_count-1];
        }
    }
    return days;
}

-(int)weekday_days:(int)days
{
    int base=6,weekday=0;
    weekday=(days%7+base)%7;
    return weekday;
}//返回数字1-7


@end
