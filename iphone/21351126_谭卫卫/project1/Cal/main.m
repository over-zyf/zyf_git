//
//  main.m
//  Cal
//
//  Created by 谭卫卫 on 13-10-6.
//  Copyright (c) 2013年 谭卫卫. All rights reserved.
//

#include <libgen.h>
#include <string.h>
#import "Cal.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Cal *myCalender = [[Cal alloc] init];
    
//        int mtd,spaceWeek;
        int temp;
        
        char *proName = basename(argv[0]);
        [myCalender strToLower:proName];
        
        if (strcmp(proName, "cal") == 0)
        {
            if(argc == 1){
                [myCalender setDate:0 andMonth:0];
                [myCalender showCalendar];
            }
            else if(argc == 2)
            {
                if(atoi(argv[1]) >= 1 && atoi(argv[1]) <= 9999)
                {
                    temp = atoi(argv[1]);
                    myCalender.year = temp;
                    myCalender.month = 1;
                    myCalender.day = 1;
                    [myCalender showYearCalendar];
                }
                else
                {
                    printf("cal: option requires an argument %s", argv[1]);
                    printf("\nThis is a illegal command.");
                    return 0;
                }
                
            }
            else if (argc == 3)
            {
                if (strcmp(argv[1], "-m") == 0){
                    int tmpMonth = atoi(argv[2]);
                    if (tmpMonth < 1 || tmpMonth > 12) {
                        printf("cal: %d is neither a month number (1..12) nor a name", tmpMonth);
                        return 0;
                    }
                    [myCalender setDate:0 andMonth:tmpMonth];
                    [myCalender showCalendar];
                }
                else if (atoi(argv[1]) >= 1 && atoi(argv[1]) <= 12)
                {
                    myCalender.month = atoi(argv[1]);
                    int tmpMonth = atoi(argv[1]);
                    int tmpYear = atoi(argv[2]);
                    if (tmpYear < 0 || tmpYear > 10000) {
                        printf("cal: year %d not in range 1..9999", tmpYear);
                        return 0;
                    }
                    [myCalender setDate:tmpYear andMonth:tmpMonth];
                    [myCalender showCalendar];
                }
                else
                {
                    printf("cal %s %s is illegal command", argv[1], argv[2]);
                    printf("\nDo you mean cal -m month?");
                    return 0;
                }
            }
            else
            {
                printf("usage:cal -m month");
                printf("\n      cal month year");
                return 0;
            }
        }
        else
        {
            printf("Please input the right command!");
            return 0;
        }
    }
    return 0;
}

