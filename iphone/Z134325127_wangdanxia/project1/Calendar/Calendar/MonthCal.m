//
//  MonthCal.m
//  Calendar
//
//  Created by dv on 13-10-10.
//  Copyright (c) 2013年 wangdx. All rights reserved.
//

#import "MonthCal.h"
#import "CalFunc.h"

@implementation MonthCal
{
    int year;
    int month;
}

-(void) setYear:(int)y
{
    CalFunc *calfunc = [[CalFunc alloc] init];
    if ([calfunc isYearInRange:y]==true) {
        year=y;
    }else
    {
        @autoreleasepool {
            [calfunc outputIllagalInput];
            exit(0);
        }
    }
}

-(void) setMonth:(int)m
{
    CalFunc *calfunc = [[CalFunc alloc]init];
    if([calfunc isMonthInRange:m]==true)
    {
        month=m;
    }else
    {
        @autoreleasepool {
            [[[CalFunc alloc]init] outputIllagalInput];
            exit(0);
        }
    }
    
}

-(void) output
{
    CalFunc *calfunc = [[CalFunc alloc] init];
    
    NSArray *arrMonth = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil];
    NSInteger firstBlank = 20 - [[arrMonth objectAtIndex:month-1] length] - 1 - 4;
    firstBlank = firstBlank/2;
    for (NSInteger i=0; i<firstBlank; i++)
    {
        printf(" ");
    };
    printf("%s %i\n",[[arrMonth objectAtIndex:month-1] UTF8String],year);
    [calfunc outputWeek];
    printf("\n");
    
    //output the others line
    int dayInWeek = [calfunc outputDaysInWeek_setYear:year setMonth:(int)month];
    NSInteger numdays = [calfunc daysInMonth:month];
    if ([calfunc isLeapYear:year]==true && month==2) {
        numdays++;
    };
    for(int i=1;i<dayInWeek;i++)
    {
        printf("   ");
    };
    int now=1;
    int temp=dayInWeek-1;
    while (now<numdays+1)
    {
        if (now<10)
        {
            printf(" %i ",now);
        } else
        {
            printf("%i ",now);
        }
        now++;
        temp++;
        if(temp>=7)
        {
            printf("\n");
            temp=0;
        };
    }
    printf("\n\n");
    
}


@end
