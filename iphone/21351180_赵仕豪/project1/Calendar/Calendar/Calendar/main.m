//
//  main.m
//  Calendar
//
//  Created by guest on 13-10-6.
//  Copyright (c) 2013年 zhaoshihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#include"calendar.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        Calendar *calen=[[Calendar alloc]init];
        if(argc == 1)
        {
               //获取当前月份年份
                Calendar *curDay = [[Calendar alloc] init];
                NSDate *date = [NSDate date];
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *components = [[NSDateComponents alloc] init];
                NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
                components = [calendar components:unitFlags fromDate:date];
                
                curDay.Year = [components year];
                curDay.Month = [components month];
                [components setDay:1];
                
                //获取当前年月的首天周几，减去1
                NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
                NSDate *date_week = [gregorian dateFromComponents:components];
                NSDateComponents *components_week = [gregorian components:NSWeekdayCalendarUnit fromDate:date_week];
                curDay.Week = [components_week weekday];
                //输出cal 指令，当前年月
                [curDay printCalendarOfYear:curDay.Year month:curDay.Month week:curDay.Week day:curDay.Day];
        }
        else if(argc == 2)
        {
            int year_x = atoi(argv[1]);
            if((year_x >= 0 && year_x <= 9999))
            {
                [calen printCalendar:year_x];
                printf("\n");
            }
            else if(year_x < 0 || year_x > 9999){
                printf("cal: year %d not in range 1..9999", year_x);
            }
            else if(strcmp(argv[1], "cal")){
                 printf("-bash: cald: command not found");
            }
        }
        else if(argc == 3)
        {
            if(strcmp(argv[1], "-m"))
            {
                int year_x = atoi(argv[2]);
                int month_x = atoi(argv[1]);
                if((year_x >= 0 && year_x <= 9999) && (month_x >= 0 && month_x <= 12))
                {
                    [calen printCalendarOfYear:year_x month:month_x];
                    printf("\n");
                }
                else if (month_x < 0 || month_x > 12) {
                    printf("cal: %d is neither a month number (1..12) nor a name", month_x);
                }
                else if (year_x < 0 || year_x > 9999){
                    printf("cal: year %d not in range 1..9999", year_x);
                }
            }
            else{
                //获取当前月份年份
                Calendar *curDay = [[Calendar alloc] init];
                NSDate *date = [NSDate date];
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *components = [[NSDateComponents alloc] init];
                NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSWeekdayCalendarUnit;
                components = [calendar components:unitFlags fromDate:date];
                   
                curDay.Year = [components year];
                curDay.Month = atoi(argv[2]);
                [components setDay:1];
                   
                //获取当前年月的首天周几，减去1
                NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
                NSDate *date_week = [gregorian dateFromComponents:components];
                NSDateComponents *components_week = [gregorian components:NSWeekdayCalendarUnit fromDate:date_week];
                curDay.Week = [components_week weekday];
                //输出cal 指令，当前年月
                //[curDay printCalendarOfYear:curDay.Year month:curDay.Month week:curDay.Week day:curDay.Day];
                if(!strcmp(argv[1],"-m") && (curDay.Month >= 0 && curDay.Month <= 12))
                {
                    [curDay printCalendarOfYear:curDay.Year month:curDay.Month week:curDay.Week day:curDay.Day];
                       
                }
                else if (curDay.Month < 0 || curDay.Month > 12) {
                    printf("cal: %d is neither a month number (1..12) nor a name", curDay.Month);
                }
                else if(strcmp(argv[1], "-m")){
                    printf("cal: illegal option -- t");
                    printf("usage: cal [-jy] [[month] year]");
                    printf("cal [-j] [-m month] [year]");
                    printf("ncal [-Jjpwy] [-s country_code] [[month] year]");
                    printf("ncal [-Jeo] [year]");
                }
            }
        }
    }
    return 0;
}





