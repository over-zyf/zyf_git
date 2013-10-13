//
//  main.m
//  project1
//
//  Created by yyy on 13-10-12.
//  Copyright (c) 2013年 yyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCalendar.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        MyCalendar *myCalendar = [[MyCalendar alloc] init];
        
        char buffer[200];     //使用一个缓冲区
        memset(buffer, 0, sizeof(buffer));
        gets(buffer);
        NSString *nstring = [NSString stringWithUTF8String:buffer];
        NSArray *array = [nstring componentsSeparatedByString:@" "];
        
        if ([array count]==1)//不带参数
        {
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents*comps;
            
            // 年月日获得
            comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                               fromDate:date];
            NSInteger year = [comps year];
            NSInteger month = [comps month];
            
            [myCalendar printCalendarWithYear:year AndMonth:month];
        }
        else if ([array count]==2)//带一个参数
        {
            int year = [[array objectAtIndex:1] intValue];
            [myCalendar printCalendarWithYear:year];
        }
        else if ([array count]==3)//带二个参数
        {
            int month = [[array objectAtIndex:1] intValue];
            int year = [[array objectAtIndex:2] intValue];
            [myCalendar printCalendarWithYear:year AndMonth:month];
        }

    }
    return 0;
}

