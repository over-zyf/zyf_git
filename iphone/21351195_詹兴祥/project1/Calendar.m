//
//  Calendar.m
//  calendar
//
//  Created by zsingsong on 13-10-5.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar
+(int)getDays:(int)y ByMonth:(int)m
{
int month[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
    if(LeapYear(y))
    month[2]=29;
    return month[m];
}
+(int)getDaysByYear:(int)y
{
int t=365;  
    t+=LeapYear(y); 
    return t;
}
+(int)weekByYear:(int)y andMonth:(int)m
{
int year=1900,week=1,i; //定义万年历是从1900年开始
    long sum=0;
    for(i=year;i<y;i++)
        sum+=[self getDaysByYear:i];
    
    for(i=1;i<m;i++)
        sum+=[self getDays:y ByMonth:i];
    i=sum%7;
    week=(week+i)%7;
    return week;
}
@end
