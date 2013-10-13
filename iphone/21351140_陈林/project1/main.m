//
//  main.m
//  myCal
//
//  Created by fallen on 13-10-9.
//  Copyright (c) 2013年 fallen. All rights reserved.
//
#include "myCal.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        calendar *cal=[[calendar alloc ]init];
        if(argc == 1)
        {
            NSDate *date = [NSDate date];
            NSCalendar *calender = [NSCalendar currentCalendar];
            NSDateComponents *comps = [calender components:(NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
            [cal printMonth:[comps year] month:[comps month]];
        }
        else if (argc==2)
        {
            int year=atoi(argv[1]);
            if(year<=0 || year>9999)
            {
                printf("cal: year %d not in range 1..9999\n",year);
                return -1;
            }
            [cal printYear:year];
        }
        else if (argc==3)
        {
            if (!strcmp(argv[1],"-m")) {
                int month=atoi(argv[2]);
                if(month<=0 || month>12)
                {
                    printf("cal: %d is neither a month number (1..12) nor a name\n",month);
                    return -1;
                }
                NSDate *date = [NSDate date];
                NSCalendar *calender = [NSCalendar currentCalendar];
                NSDateComponents *comps = [calender components:(NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
                [cal printMonth:[comps year] month:month];
            }
            else
            {
                int month=atoi(argv[1]);
                int year=atoi(argv[2]);
                if(month<=0 || month>12)
                {
                    printf("cal: %d is neither a month number (1..12) nor a name\n",month);
                    return -1;
                }
                if(year<=0 || year>9999)
                {
                    printf("cal: year %d not in range 1..9999\n",year);
                    return -1;
                }
                [cal printMonth:year month:month];
            }
        }
        [cal release];
    }
    return 0;
}

