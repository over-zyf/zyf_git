//
//  MyCal.m
//  MyCal
//
//  Created by jasonross on 13-9-26.
//  Copyright (c) 2013年  jasonross.me All rights reserved.
//

#import "MyCal.h"

@implementation MyCal

+(int)	daysofMonth:(int)month ofYear:(int)year
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];

    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit: NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    int numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

+(int)	weekdayofDay:(int)day ofMonth:(int)month ofYear:(int)year
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
    return weekday-1;
}

+(void) printOfMonth:(int) month ofYear:(int) year
{
    printf("     %d 年%d月\t\n",year,month);  
    for(int i=-1;i<6;i++)
    {
        [MyCal printOfWeek:i OfMonth:month ofYear:year];
        printf("\n");
    }
}

+(void) printOfWeek:(int) week OfMonth:(int) month ofYear:(int) year
{
    int weekday=[MyCal weekdayofDay:1 ofMonth:month ofYear:year];
    switch (week) 
    {
        case -2:
            printf("\t%d月\t     ",month);  
            break;
        case -1:
            printf("日 一 二 三 四 五 六 "); 
            break; 
        case 0:
            for(int i=0;i<weekday;i++)
                printf("   ");
            for(int i=1;i<8-weekday;i++)
            {
                if(i<10)
                    printf(" %d ",i);
                else 
                {
                    printf("%d ",i);
                }
            }
            break;
        default:
            {
                int days=[MyCal daysofMonth:month ofYear:year];
                int first=(week-1)*7+8-weekday;
                for(int i=0;i<7;i++)
                {
                    if((first+i)>days)
                        printf("   ");
                    else
                    {
                        if(first+i<10)
                            printf(" %d ",first+i);
                        else 
                        {
                            printf("%d ",first+i);
                        }
                    }
                }
            }
            break;
    }
}

+(void) printofYear:(int)year
{
    printf("\t\t\t       %d年\n\n",year);
    for(int i=0;i<4;i++)
    {
        
            for(int m=-2;m<6;m++)
            {
                for(int j=0;j<3;j++)
                {
                    [MyCal printOfWeek:m OfMonth:i*3+j+1 ofYear:year];
                    printf("\t");

                }
                printf("\n");
            }
        

    }
}
@end        
