//
//  Calen.m
//  Calen2
//
//  Created by huazi on 13-10-8.
//  Copyright (c) 2013年 huazi. All rights reserved.
//

#import "Calen.h"

@implementation Calen
+(int)daysOfMonth:month ofYear:(int)year//得到每个月有多少天
{
    NSDateComponents *comps=[[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date=[gregorian dateFromComponents:comps];//获取日期
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSRange range =[calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    int numberOfDaysInMonth=range.length;
    return numberOfDaysInMonth;
    
}

+(int)weekdayOfDay:(int)day ofMonth:(int)month ofYear:(int)year
{//计算每个月的第一天是周几
    
    NSDateComponents *comps=[[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date=[gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents=[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday=[weekdayComponents weekday];
    return weekday-1;
    
}

+(void)printOfMonth:(int)curMonth ofYear:(int)curYear
{//打印出每个月的日历
    printf("\t\t%d 年 %d 月\n",curYear,curMonth);
    printf("日\t一\t二\t三\t四\t五\t六\n");
    
    int weekday=[Calen weekdayOfDay:1 ofMonth:curMonth ofYear:curYear];
    for(int i=0;i<weekday;i++){
        printf("\t");
    }
    
    int days=[Calen daysOfMonth:curMonth ofYear:curYear];
    
    for(int i=1;i<=days;i++){
        if(i<10){
            printf(" %d",i);
        }else{
            printf("%d",i);
        }
        if((i+weekday)%7==0){//7的倍数时，换行
            printf("\n");
        }else{
            printf("\t");
        }
    }
    if((days+weekday)%7!=0){
        printf("\n");//该月最后一天不是周六时，换行处理
    }
    printf("\n");
}
@end
