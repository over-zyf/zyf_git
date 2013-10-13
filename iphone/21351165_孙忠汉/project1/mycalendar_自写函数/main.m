//
//  main.m
//  calender
//
//  Created by SZH on 13-10-2.
//  Copyright (c) 2013年 SZH. All rights reserved.
//
//公元1年1月1日 周六
#import <Foundation/Foundation.h>
#import "Comm.h"
#import "Calender.h"
int main(int argc, const char * argv[])
{
    @autoreleasepool {
        int year=0,month=0;
        if(argc==1)
        {
            NSDate *today = [NSDate date];
            NSCalendar *currentCalendar = [NSCalendar currentCalendar];
            NSDateComponents *now=[currentCalendar components:( NSMonthCalendarUnit |NSYearCalendarUnit) fromDate:today];
            year=(int)[now year];
            month=(int)[now  month];
            [now setDay:1];//将now设定成本月的1号
            NSDate *targetDate=[currentCalendar dateFromComponents:now];
            NSDateComponents *targetCom=[currentCalendar components:( NSMonthCalendarUnit |NSYearCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit) fromDate:targetDate];
            NSInteger  weekday=[targetCom weekday];
            printCalerdar((int)year,(int)month,(int)weekday);

        }//没有指定年月是默认输出当前的日历
        else if(argc==2)
        {
            NSString *g_year=[[NSString alloc] initWithUTF8String:argv[1]];
            year=[g_year intValue];
            int i=0;
            for (i=1; i<=12; i++) {
                Calender *cal=[Calender new];
                [cal setYear:year];
                [cal setMonth:i];
                [cal setDay:1];
                int p_week=(int)[cal Weekday];
                printCalerdar(year, i, p_week);
            }
        }//输出args[1]指定年份的月历
        else if(argc==3)
        {
           // NSString *g_year=argv[2];
            NSString *g_yaer = [[NSString alloc] initWithUTF8String:argv[2]];
            NSString *g_month=[[NSString alloc] initWithUTF8String:argv[1]];
              year=[g_yaer intValue];
              month=[g_month intValue];
           // NSLog(@"%d %d ",year,month);
            Calender *cal=[Calender new];
            [cal setYear:year];
            [cal setMonth:month];
            [cal setDay:1];
       //     NSLog(@"%d年%d月%d日",[cal Year],[cal Month],[cal Day]);
           // int p_day=(int)[cal Days];
            int p_week=(int)[cal Weekday];
           printCalerdar(year, month, p_week);
           // printCalerdar(1, 1, p_week);
           // NSLog(@"间隔天数：%d %d",p_day,p_week);
        }//args[2]年arg［1］月的日历
    }
    return 0;
}

