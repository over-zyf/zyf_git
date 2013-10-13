//
//  main.m
//  Calendar
//
//  Created by zht2013sg on 13-10-10.
//  Copyright (c) 2013年 zht2013sg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        if (argc == 1) {
            Calendar *cal = [[Calendar alloc] init];
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
            components = [calendar components:unitFlags fromDate:date];
            cal.nYear = [components year];
            cal.nMonth = [components month];
            [cal printmonth];
        }
        else if (argc == 2){
            int nYear = atoi(argv[1]);
            Calendar *cal = [[Calendar alloc] init];
            cal.nYear = nYear;
            if (nYear >=1 && nYear <= 9999) {
                [cal printyear];
            }
            else {
                NSLog(@" 年的范围为1～9999\n");
            }
        }
        else if (argc == 3){
            int nYear,nMonth;
            Calendar *cal = [[Calendar alloc] init];
            if (strcmp("-m", argv[1])==0) {
                NSDate *date = [NSDate date];
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *components = [[NSDateComponents alloc] init];
                NSInteger unitFlags = NSYearCalendarUnit;
                components = [calendar components:unitFlags fromDate:date];
                nYear = (int)[components year];
                nMonth = atoi(argv[2]);
            }
            else{
                 nYear = atoi(argv[2]);
                 nMonth = atoi(argv[1]);
            }
            if (nYear >= 1 && nYear <= 9999 && nMonth >= 1 && nMonth <= 12) {
                cal.nYear = nYear;
                cal.nMonth = nMonth;
                [cal printmonth];
            }
            if (nYear < 1 || nYear > 9999) {
                NSLog(@" 年的范围为1～9999\n");
            }
            if (nMonth < 1 || nMonth > 12) {
                NSLog(@" 月的范围为1～12\n");
            }
        }
        else{
            NSLog(@" 参数个数错误\n");
        }
    }
    return 0;
}

