//
//  MyCal.m
//  cal OC2
//
//  Created by apple on 13-10-9.
//  Copyright (c) 2013年 GH. All rights reserved.
//

#import "MyCal.h"

@implementation Mycal

-(int)year
{
    return year;
}
-(void)setYear:(int)g_year
{
    year=g_year;
}
-(void) getWeekdays
{
    
    weekdays=(35+year+year/4-year/100+year/400)%7;
}

-(int)weekdays
{
    return weekdays;
}
-(void)setWeekdays:(int)weekday
{
    weekdays=weekday;
}

-(int)days
{
    return days;
}
-(void)setDays:(int)g_days;
{
    days=g_days;
}
-(int) getDays:(int)g_month
{
    
    int dayofmonth[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    
    if((year%4==0&&year%100!=0)||(year%400==0))
    {
        dayofmonth[1]++;
    }
    return dayofmonth[g_month-1];
    
}


@end

