//
//  main.m
//  Calendar2
//
//  Created by liuyang on 13-10-10.
//  Copyright (c) 2013年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        if (argc == 1) {                                       //输出当月日历
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
            components = [calendar components:unitFlags fromDate:date];
            NSInteger year  = [components year];
            NSInteger month = [components month];
            NSInteger week  = [components weekday];
            NSInteger day   = [components day];
           [Calendar printCalendarWithYear:year withMonth:month withWeek:week withDay:day];
            printf("\n");
        } else if(argc == 2) {                                 //输出指定年份日历
            int year_x = atoi(argv[1]);
            [Calendar printCalendarOfYear:year_x];
        } else if(argc == 3) {
            if (argv[1][0] == '-' && argv[1][1] == 'm') {      //输出今年某月日历
                int month_x = atoi(argv[2]);
                if (month_x < 1 || month_x > 12)
                    printf("cal: %d is neither a month number (1..12) nor a name\n", month_x);
                else {
                    NSDate *date = [NSDate date];
                    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    NSDateComponents *components = [[NSDateComponents alloc] init];
                    unsigned unitFlags = NSYearCalendarUnit;
                    components = [calendar components:unitFlags fromDate:date];
                    NSInteger year_x  = [components year];
                    NSInteger weekday_x = [Calendar getFirstWeekOfMonth:month_x inYear:year_x];
                    [Calendar printCalendarWithYear:year_x withMonth:month_x withWeek:weekday_x withDay:1];
                    printf("\n");
                }

            } else {                                          //输出某年某月日历
                int month_x = atoi(argv[1]);
                int year_x = atoi(argv[2]);
                if (year_x <= 0 || year_x > 9999)
                    printf("cal: year %d not in range 1..9999\n", year_x);
                else if (month_x < 1 || month_x > 12)
                    printf("cal: %d is neither a month number (1..12) nor a name\n", month_x);
                else {
                    NSInteger weekday_x = [Calendar getFirstWeekOfMonth:month_x inYear:year_x];
                    [Calendar printCalendarWithYear:(NSInteger)year_x withMonth:(NSInteger)month_x withWeek:weekday_x withDay:1];
                    printf("\n");
                }
            }
        }
    }
    return 0;
}

