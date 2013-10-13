//
//  CalPrint.m
//  Calendar
//
//  Created by Desideria's Apple on 13-10-8.
//  Copyright (c) 2013年 MadAlice's Apple. All rights reserved.
//

#import "CalPrint.h"

@implementation CalPrint
- (int) daysOfMonth: (int)month inYear: (int)year
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit: NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    int numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}//daysOfMonth 计算某年某月有多少天

- (int) weekdayOfWeek: (int)month inYear: (int)year
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
    return weekday-1;
}//weekdayOfWeek 计算每月第一天为周几

- (void) printMonth: (int)month inYear: (int)year
{
    int weekday = [self weekdayOfWeek:month inYear:year];
    int daysofmonth = [self daysOfMonth:month inYear:year];
    printf("\t\t%d年%d月\n",year,month);
    printf("Sun\tMon\tTue\tWen\tThu\tFri\tSat\n");
    for(int i=0;i<weekday;i++)
        printf("\t");
    for(int i=1;i<=daysofmonth;i++)
    {
        printf("%2d",i);
        if((i-1+weekday)%7==6)
            printf("\n");
        else 
            printf("\t");
        
    }
    if((daysofmonth-1+weekday)%7!=6)
        printf("\n");
    printf("\n");
}//printMonth 打印月历

- (void) printYear: (int)year
{
    printf("\t\t\t\t\t%4d年\n",year);
    for (int i=1; i<=4; ++i) {
        
        int monthArray[3];
        int weekday[3];
        int daysofmonth[3];
        int curDay[3] = {1, 1, 1};
        
        monthArray[0] =(i - 1) * 3 + 1;
        monthArray[1] =(i - 1) * 3 + 2;
        monthArray[2] =(i - 1) * 3 + 3;
        
        printf("\t%2d月\t\t", monthArray[0]);
        printf("\t\t%2d月\t\t", monthArray[1]);
        printf("\t\t%2d月\n", monthArray[2]);
        printf("Sun Mon Tue Wen Thu Fri Sat\tSun Mon Tue Wen Thu Fri Sat\tSun Mon Tue Wen Thu Fri Sat\n");
        
        //输出三个月的第一行
        for (int j=0; j<3; ++j) {
            weekday[j] = [self weekdayOfWeek:monthArray[j] inYear:year];
            daysofmonth[j] = [self daysOfMonth:monthArray[j] inYear:year];
            for (int k=0; k<weekday[j]; ++k)
                printf("    ");
            for (int k=weekday[j]; k<7; ++k)
                printf("%2d  ", curDay[j]++);
            printf("\t");
        }
        printf("\n");
        //输出三个月的其他行
        for (int row=0; row<5; ++row) {
            for (int m=0; m<3; ++m) {
                for (int n=0; n<7; ++n) {
                    if (curDay[m]<=daysofmonth[m])
                        printf("%2d  ",curDay[m]++);
                    else
                        printf("    ");
                }
                printf("\t");
            }
            printf("\n");
        }
    }
}//printYear 打印年历
@end
