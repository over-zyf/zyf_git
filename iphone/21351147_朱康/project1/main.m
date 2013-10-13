//
//  main.m
//  Calendar
//
//  Created by apple on 13-10-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#include"calendar.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        calendar *calen=[[calendar alloc]init];
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags=NSYearCalendarUnit | NSMonthCalendarUnit ;
        NSDateComponents *dd = [cal components:unitFlags fromDate:now];
        int y = [dd year];
        int m = [dd month];
        if(argc==1){
            
            [calen calendarwithmonth:y month:m];
          }
        else if(argc==2){
            if(atoi(argv[1])>=1&&atoi(argv[1])<=9999)
                [calen calendar:atoi(argv[1])];
            else   printf("cal: year %s not in range 1..9999\n",argv[1]);
        }
        else if(argc==3){
            if(strcmp("-m", argv[1])==0){
                if(atoi(argv[2])>=1&&atoi(argv[2])<=12)
                   [calen calendarwithmonth:y month:atoi(argv[2])];
                else printf("cal: %s is neither a month number (1..12) nor a name\n",argv[2]);
            }
            else {
                if(atoi(argv[2])>=1&&atoi(argv[2])<=9999&&atoi(argv[1])>=1&&atoi(argv[1])<=12)
                    [calen calendarwithmonth:atoi(argv[2]) month:atoi(argv[1])];
                else if(atoi(argv[2])>=1&&atoi(argv[2])<=9999)
                printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                else printf("cal: year %s not in range 1..9999\n",argv[2]);
            }
            
        }
    }
    return 0;
}

