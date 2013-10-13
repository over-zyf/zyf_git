//
//  YearCal.m
//  Calendar
//
//  Created by dv on 13-10-10.
//  Copyright (c) 2013年 wangdx. All rights reserved.
//

#import "YearCal.h"
#import "CalFunc.h"

@implementation YearCal
{
    int year;
}

-(void) setYear:(int)y
{
    CalFunc *calfunc = [[CalFunc alloc] init];
    if ([calfunc isYearInRange:y]==true) {
        year=y;
    }else
    {
        [calfunc outputIllagalInput];
        exit(0);
    }
}

-(void) output
{
    int row=4;
    int column=3;
    
    CalFunc *calfunc = [[CalFunc alloc] init];
    
    //output year
    for (int i=0; i<30; i++) {
        printf(" ");
    };
    printf("%i\n\n",year);
    
    for(int i=0;i<row;i++)
    {
        //output month
        for (int j=0; j<column; j++) {
            [self outputMonth:i*3+j+1];
        };
        [self outputEnter];
        
        //output week
        for (int j=0; j<column; j++) {
            [calfunc outputWeek];
            printf("  ");
        };
        [self outputEnter];
        
        
        //output days
        //        NSMutableArray *now = [[NSMutableArray alloc]init];
        //        NSMutableArray *daysInWeek = [[NSMutableArray alloc]init];
        //        NSMutableArray *numDays = [[NSMutableArray alloc]init];
        //
        //        for(int j=0;j<column;j++)
        //        {
        //            [now addObject:@"1"];
        //            int month = 3*i+j+1;
        //            [daysInWeek addObject:[NSNumber numberWithInt: [calfunc outputDaysInWeek_setYear:year setMonth:month]]];
        //            [numDays addObject:[NSNumber numberWithInt: [calfunc daysInMonth:month]]];
        //        };
        int first=1;
        int second=1;
        int third=1;
        
        int month=i*3+1;
        int firstDaysInWeek = [calfunc outputDaysInWeek_setYear:year setMonth:month];
        NSInteger firstNumDays = [calfunc daysInMonth:month];
        if ([calfunc isLeapYear:year]==true && month==2) {
            firstNumDays++;
        };
        
        month=i*3+2;
        int secondDaysInWeek = [calfunc outputDaysInWeek_setYear:year setMonth:month];
        NSInteger secondNumDays = [calfunc daysInMonth:month];
        if ([calfunc isLeapYear:year]==true && month==2) {
            secondNumDays++;
        };
        
        month=i*3+3;
        int thirdDaysInWeek = [calfunc outputDaysInWeek_setYear:year setMonth:month];
        NSInteger thirdNumDays = [calfunc daysInMonth:month];
        if ([calfunc isLeapYear:year]==true && month==2) {
            thirdNumDays++;
        };
        
        while(first<=firstNumDays || second<=secondNumDays || third<=thirdNumDays)
        {
            int finalEnter=0;
            //column first
            [self outputMonthStartBlank:firstDaysInWeek];
            int firsttemp=(int)firstDaysInWeek-1;
            while (first<firstNumDays+1 && firsttemp<7)
            {
                [self outputOneDay:first];
                first++;
                firsttemp++;
            };
            if(first>=firstNumDays+1 )
            {
                if(firsttemp<7)
                {
                    [self outputMonthEndBlank:firsttemp];
                }else
                {
                    finalEnter=1;
                }
            };
            printf(" ");
            firstDaysInWeek=1;
            
            //column second
            [self outputMonthStartBlank:secondDaysInWeek];
            int secondtemp=(int)secondDaysInWeek-1;
            while (second<secondNumDays+1 && secondtemp<7)
            {
                [self outputOneDay:second];
                second++;
                secondtemp++;
            };
            if(second>=secondNumDays+1 )
            {
                if(secondtemp<7)
                {
                    [self outputMonthEndBlank:secondtemp];
                }else
                {
                    finalEnter=1;
                }
            };
            printf(" ");
            secondDaysInWeek=1;
            
            //column third
            [self outputMonthStartBlank:thirdDaysInWeek];
            int thirdtemp=(int)thirdDaysInWeek-1;
            while (third<thirdNumDays+1 && thirdtemp<7)
            {
                [self outputOneDay:third];
                third++;
                thirdtemp++;
            };
            
            //next line
            [self outputEnter];
            if(finalEnter==1)
            {
                [self outputEnter];
            }
            thirdDaysInWeek=1;
        }
        
    }
}

-(void) outputMonth:(int)m
{
    NSArray *arrMonth = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil];
    
    NSString *strMonth = [arrMonth objectAtIndex:m-1];
    NSInteger monthBlank = 20 - [strMonth length];
    monthBlank = monthBlank/2;
    [self outputMonthBlank:(int)monthBlank];
    printf("%s",[strMonth UTF8String]);
    [self outputMonthBlank:(int)monthBlank];
    printf("  ");
    
}

-(void) outputMonthBlank:(int)monthBlank
{
    for (NSInteger i=0; i<monthBlank; i++)
    {
        printf(" ");
    };
}

-(void) outputEnter
{
    printf("\n");
}

-(void) outputMonthStartBlank:(int)daysInWeek
{
    if (daysInWeek!=1) {
        for(int k=0;k<daysInWeek-1;k++)
        {
            printf("   ");
        };
    };
}

-(void) outputOneDay:(int)now
{
    if (now<10)
    {
        printf(" %i ",now);
    } else
    {
        printf("%i ",now);
    }
}

-(void) outputMonthEndBlank:(int)dayInWeek
{
    for(int n=0;n<(7-dayInWeek)*3;n++)
    {
        printf(" ");
    }
}


@end
