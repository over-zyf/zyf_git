//
//  main.m
//  rili
//
//  Created by ceq on 13-10-9.
//  Copyright (c) 2013年 ceq. All rights reserved.
//

#import <Foundation/Foundation.h>
int nDays[] = {0,31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
void printCurMonth(NSInteger nowMonth,NSInteger weekday){
    NSInteger tempWeekday=weekday;
    printf("  Sun  Mon  Tue  Wed  Thu  Fri  Sat\n");
    for(int i=1;i<weekday;i++) printf("%5s"," ");
    for(int i=1;i<=nDays[nowMonth];i++){
        printf("%5d",i);
        if (tempWeekday++==7)
        {
            tempWeekday = 1;
            printf("\n");
        }
    }
}
int getWeekDay(NSInteger year,NSInteger month,NSInteger day){
    int days = 0;
    //1.1.1 星期1
    for(int i=1;i<year;i++)
        if((i%4==0&&i%100!=0)||i%400==0)
            days+=366;
        else
            days+=365;
    for(int i=1;i<month;i++)
        days+=nDays[i];
    days+=day-1;
    if(((year%4==0&&year%100!=0)||year%400==0)&&month>2) days++;
    days%=7;
    return (days+1)%7==0?7:(days+1)%7;
}
void printYearMonth(NSInteger year){
    for(int i=1;i<=12;i++){
        printf("Month:%d\n",i);
        printCurMonth(i, getWeekDay(year, i, 1));
        printf("\n");
    }
}
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //获取当前月份
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date1 = [NSDate date];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
        components = [calendar components:unitFlags fromDate:date1];
        NSLog(@"1.输出当前月份");
        NSLog(@"2.输出整年月份");
        int m;
        scanf("%d",&m);
        if(m==1){
            printCurMonth([components month],getWeekDay([components year], [components month], [components day]));
        }
        else if(m==2){
            printYearMonth([components year]);
        }
        
    }
    return 0;
}

