//
//  MyCalendar.m
//  project1
//
//  Created by xyj on 13-10-11.
//  Copyright (c) 2013年 xyj. All rights reserved.
//

#import "MyCalendar.h"
#import "MyCalendar.h"

@implementation MyCalendar
int nPerMonth[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};

-(id)init: (int)year AndMonth: (int)month
{
    if(self == [super init])
    {
        nYear = year;
        nMonth = month;
    }
    return self;
}

-(int) getWeekOfFirstDay
{
    if((nYear%4==0 && nYear%100) || (nYear%400==0))
        nPerMonth[2] = 29;
    else
        nPerMonth[2] = 28;
    
    int w,c,y,m;
    m=0;
    if (nMonth == 1 ||nMonth==2) {
        nYear--;
        m = 12;
    }
    c = nYear / 100;
    y = nYear % 100;
    m += nMonth;    //w=y+[y/4]+[c/4]-2c+[26(m+1）/10]+d-1
    w = y + y/4 + c/4 -2*c + 13*(m+1)/5 ;
    if(nYear > 1752 || (nYear == 1752 && nMonth > 9))
        return (w%7 + 7)%7;//防止负数
    else
        return ((w+4)%7 + 7)%7 ;
}
//cal初始化在调用前,cal[0]表示该月第一天是星期几，cal[1] 表示该月到几号结束
-(void) GetMonthCal: (int*)cal
{
    int nWeekDay = [self getWeekOfFirstDay];
    
    cal[0] = nWeekDay;
    cal[1] = nPerMonth[nMonth];
    if (nYear == 1752 && nMonth == 9)
        cal[1] -= 11;
}


+(void) getCurrentTime: (int*)pYear AndMonth: (int*)pMonth
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init]; //实例化一个NSDateComponents对象
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | //二进制的日期元素
    NSHourCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date]; //调用components方法，返回NSDateComponents对象
    *pYear = [comps year]; //获取年份存到year里
    *pMonth = [comps month]; //获取月份存到month里
}

@end
