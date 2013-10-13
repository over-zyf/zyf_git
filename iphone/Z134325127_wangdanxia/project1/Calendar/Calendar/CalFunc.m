//
//  CalFunc.m
//  Calendar
//
//  Created by dv on 13-10-11.
//  Copyright (c) 2013年 wangdx. All rights reserved.
//

#import "CalFunc.h"

@implementation CalFunc

-(void) outputWeek
{
    NSString *strWeek = @"Su Mo Tu We Th Fr Sa";
    //    NSString *strWeek2 = @"日 一 二 三 四 五 六";
    printf("%s",[strWeek UTF8String]);
}

-(int) outputDaysInWeek_setYear:(int)transyear setMonth:(int)transmonth
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    NSString *strdate=[[NSString alloc] init];
    NSString *stryear = [NSString stringWithFormat:@"%i", transyear];
//    if ([self isYearInRange:transyear]==true)
//    {

        strdate = [strdate stringByAppendingString:stryear];
//        exit(0);
//    }
    NSString *strmonth = [NSString stringWithFormat:@"%i", transmonth];
//    if (transmonth<1 || transmonth>12)
//    {
//        printf("month %i not in range 1...12\n",transmonth);
//        exit(0);
//    } else
        if(transmonth<10)
    {
        strdate=[strdate stringByAppendingString:@"0"];
    }
    strdate = [strdate stringByAppendingString:strmonth];
    strdate = [strdate stringByAppendingString:@"01"];
    
    NSDate *date = [formatter dateFromString:strdate];
    NSUInteger dayInWeek =[[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
    //    printf("是星期%i\n", (int)dayInWeek-1);
    
    return (int)dayInWeek;
}

-(NSInteger) daysInMonth:(int)month
{
    NSArray *arrNumDays = [NSArray arrayWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
    return [[arrNumDays objectAtIndex:month-1] integerValue];
}

-(Boolean) isLeapYear:(int)y
{
    if ( y%400==0 || ( y%100!=0 && y%4==0 ))
    {
        return true;
    }else
    {
        return false;
    }
    
}


-(Boolean) isYearInRange:(int)y
{
    if( y>=1753 && y<=9999 )
    {
        return  true;
    }else
    {
        return false;
    }
}

-(void) outputIllagalInput
{
    printf("illegal input!\n");
    exit(0);
}

-(Boolean) isMonthInRange:(int)m
{
    if ( m>0 && m<13)
    {
        return true;
    } else
    {
        return false;
    };
}

@end
