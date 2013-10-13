//
//  main.m
//  Calendar
//
//  Created by Desideria's Apple on 13-10-7.
//  Copyright (c) 2013年 MadAlice's Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalPrint.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        
        CalPrint *cal = [CalPrint new];
        if (argc == 1)
        {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *date = [NSDate date];
            NSDateComponents *compt = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit) fromDate:date];
            NSInteger year = [compt year];
            NSInteger month = [compt month];
            [cal printMonth:month inYear:year];
        }else if (argc == 2)
        {
            int year = atoi(argv[1]);
            [cal printYear:year];
        }else if (argc == 3)
        {
            int month = atoi(argv[1]);
            int year = atoi(argv[2]);
            if(month<1||month>12)
            {
                printf("没有这个月份哟~！\n");
                return -1;
            }
            [cal printMonth:month inYear:year] ;
        }
        
    }
    return 0;
}

