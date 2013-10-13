//
//  myCal.m
//  myCal
//
//  Created by fallen on 13-10-9.
//  Copyright (c) 2013年 fallen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "myCal.h"
/**保存每月的天数**/
NSInteger daysOfMonth[12]={31,28,31,30,31,30,31,31,30,31,30,31};
/**用于保存每月月份名**/
const char *months[13]={" ","一月 ","二月 ","三月 ","四月 ","五月 ","六月 ","七月 ","八月 ","九月 ","十月 ","十一月","十二月"};
@implementation calendar
-(NSInteger)getWeekday:(NSInteger)year month:(NSInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    [comps release];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    [gregorian release];
    return [weekdayComponents weekday];
}
-(void)printMonth:(NSInteger)year month:(NSInteger)month
{
    /**取得制定月份1号的星期**/
    NSInteger weekday = [self getWeekday:year month:month];
    /**计算该月的天数**/
    NSInteger days;
    NSInteger i,j;
    if (month!=2)
        days=daysOfMonth[month-1];
    else if((year%4==0 && year%100!=0)||year%400==0)
        days=29;
    else
        days=28;
    /**用于遍历每月第几号**/
    int day=1;
    printf("     %s%d\n",months[month],year);
    printf("日 一 二 三 四 五 六\n");
    /*打印第1行日期*/
    for(i=1;i<weekday;i++)
        printf("   ");
    for(j=7-weekday;j>=0;j--)
        printf("%2d ",day++);
    printf("\n");
    /*打印第2-4行日期*/
    for(i=0;i<3;i++)
    {
        for(int j=0;j<7;j++)
            printf("%2d ",day++);
        printf("\n");
    }
    for(i=0; day<=days && i<7; day++,i++)
        printf("%2d ",day);
    printf("\n");
    while (day<=days)
        printf("%2d ",days++);
    printf("\n");
}
-(void)printYear:(NSInteger)year
{
    NSInteger i,j;
    /**计算指定年份每个月的1号的星期**/
    for(i=1;i<=12;i++)
        weekdays[i]=[self getWeekday:year month:i];
    /**判断是否为闰年来确定2月的数据**/
    if((year%4==0 && year%100!=0)||year%400==0)
        daysOfMonth[1]=29;
    else
        daysOfMonth[1]=28;
    
    printf("                              %d\n\n",year);
    /**三个月份同时输出**/
    for(NSInteger loop=0; loop<=3; loop++)
    {
        for (i=1; i<=3; i++)
        {
            if(i+loop*3>10)
                printf("\b");
            printf("        %3s         ",months[i+loop*3]);
        }
        printf("\n");
        for (i=0; i<3; i++)
            printf("日 一 二 三 四 五 六  ");
        printf("\n");
        
        /**用于遍历连续三个月的日期**/
        int day[3]={1,1,1};
        for(i=0; i<3; i++)
        {
            /**输出前面的空格来规范格式**/
            NSInteger month = i+1+loop*3;
            for(j=1; j<weekdays[month]; j++)
                printf("   ");
            /**输出第一行的日期**/
            for(j=7-weekdays[month]; j>=0; j--)
                printf("%2d ",day[i]++);
            printf(" ");
        }
        printf("\n");
        
        /**输出第2-4行日期**/
        for(i=0;i<3;i++)
        {
            for(j=0;j<3;j++)
            {
                for(NSInteger k=0;k<7;k++)
                    printf("%2d ",day[j]++);
                printf(" ");
            }
            printf("\n");
        }
        /**输出第5行日期**/
        for(i=0;i<3;i++)
        {
            j=0;
            while(day[i]<=daysOfMonth[i+loop*3] && j<7)
            {
                j++;
                printf("%2d ",day[i]++);
            }
            while (j++<7)
                printf("   ");
            printf(" ");
        }
        printf("\n");
        /*输出第6行日期*/
        for(i=0;i<3;i++)
        {
            for(j=0;day[i]<=daysOfMonth[i+loop*3];j++)
                printf("%2d ",day[i]++);
            while(j++<7)
                printf("   ");
            printf(" ");
        }
        printf("\n");
    }
}
@end
