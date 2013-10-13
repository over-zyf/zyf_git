//
//  main.m
//  Calendar
//
//  Created by dv on 13-10-10.
//  Copyright (c) 2013年 wangdx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearCal.h"
#import "MonthCal.h"
#import "CalFunc.h"

void outputUsage()
{
    CalFunc *calfunc = [[CalFunc alloc]init];
    [calfunc outputIllagalInput];
};

void printMonthCal(NSInteger year,NSInteger month)
{
    MonthCal *monthCal = [[MonthCal alloc] init];
    [monthCal setYear:(int)year];
    [monthCal setMonth:(int)month];
    [monthCal output];
}

void printYearCal(NSInteger year)
{
    YearCal *yearCal = [[YearCal alloc] init];
    [yearCal setYear:(int)year];
    [yearCal output];
};

int nowYear()
{
    @autoreleasepool {
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
        NSInteger year = [comps year];
        return (int)year;
    }
};

int nowMonth()
{
    @autoreleasepool {
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
        NSInteger month = [comps month];
        return (int)month;
    }
}

bool isMonthIllegal(int month)
{
    CalFunc *calfunc = [[CalFunc alloc]init];
    return [calfunc isMonthInRange:month];
}

bool isYearIllegal(int y)
{
    CalFunc *calfunc = [[CalFunc alloc]init];
    return [calfunc isYearInRange:y];
}
int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        if (argc>1 && argc<5)
        {
            int year=-1;
            int month=-1;
            
            NSString *strCal = [[NSString stringWithUTF8String:argv[1]] lowercaseString];
            BOOL isMatch = [strCal isEqualToString:@"cal"];
            if (isMatch)
            {
                if (argc==2)//cal
                {
                    year = nowYear();
                    month = nowMonth();
                    printMonthCal(year,month);
                }else if(argc==3)
                {
                    year = [[NSString stringWithUTF8String:argv[2]] intValue];
                    if ( isYearIllegal(year)==true)//cal 2013
                    {
                        printYearCal(year);
                    } else
                    {
                        printf("this?");
                        outputUsage();
                    };
                }else if(argc==4)
                {
                    strCal = [[NSString stringWithUTF8String:argv[2]]lowercaseString];
                    isMatch = [strCal isEqualToString:@"-m"];
                    if (isMatch)
                    {
                        year = nowYear();
                        month = [[NSString stringWithUTF8String:argv[3]]intValue];
                        if (isMonthIllegal(month)==true)//cal -m 10
                        {
                            printMonthCal(year, month);
                        } else
                        {
                            outputUsage();
                        };
                    }else//cal 10 2013
                    {
                        year = [[NSString stringWithUTF8String:argv[3]] intValue];
                        month = [[NSString stringWithUTF8String:argv[2]] intValue];
                        printMonthCal(year, month);
                    }
                }
            } else
            {
                outputUsage();
            }
        } else
        {
            outputUsage();
        }
    }
    return 0;
}

