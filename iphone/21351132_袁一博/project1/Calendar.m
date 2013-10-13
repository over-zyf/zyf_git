//
//  Calendar.m
//  Calendar
//
//  Created by yyb on 13-10-9.
//  Copyright (c) 2013年 yyb. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

@synthesize year, month, day, week;


-(void)printSoloMonthCal{
    int nDays[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int i, j;
    char *szWeek[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
    for (j = 0; j < 7; j++) printf("%4s", szWeek[j]);
    printf("\n");
    for (j = 0; j < 7; j++) printf("%s", "----");
    printf("\n");
    //获取当前月份
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date1 = [NSDate date];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    components = [calendar components:unitFlags fromDate:date1];
    
    NSInteger nowMonth = [components month];
    //获取当前月第一天为星期几
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:nowMonth];
    [comps setYear:2013];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger weekday_x = [weekdayComponents weekday]-1;
    
    for (j = 0; j < weekday_x; j++) printf("%4s", " "); //空出当月1号之前的空间
    for (j = 1; j <= nDays[9]; j++)
    {
        printf("%4d", j);
        if (++weekday_x == 7)//计算下一天为星期几，如果为周日则换行
        {
            weekday_x = 0;
            printf("\n");
        }
    }
    if (weekday_x > 0) printf("\n"); //如果当月最后一天不是周六则换行
}
-(void) printCal:(int )year1 //输出该年的日历
{
    char *szMonth[] = {"Jan.", "Feb.", "Mar.", "Apr.", "May", "June", "July", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."};
    char *szWeek[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
    int nDays[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int i, j;
    int nDay = (year1 + (year1 - 1) / 4 - (year1 - 1) / 100 + (year1 - 1) / 400) % 7;//用于记录当天为星期几
    if ((year1 % 4 == 0 && year1 % 100 > 0) || year1 % 400 == 0) nDays[1] = 29;//修改闰年中二月的天数
    for (i = 0; i < 12; i++)
    {
        printf("**%s**\n", szMonth[i]);
        for (j = 0; j < 7; j++) printf("%4s", szWeek[j]);
        printf("\n");
        for (j = 0; j < 7; j++) printf("%s", "----");
        printf("\n");
        for (j = 0; j < nDay; j++) printf("%4s", " "); //空出当月1号之前的空间
        for (j = 1; j <= nDays[i]; j++)
        {
            printf("%4d", j);
            if (++nDay == 7)//计算下一天为星期几，如果为周日则换行
            {
                nDay = 0;
                printf("\n");
            }
        }
        if (nDay > 0) printf("\n"); //如果当月最后一天不是周六则换行
    }
}
@end
