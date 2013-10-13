//
//  main.m
//  cal
//
//  Created by cstlab on 13-10-10.
//  Copyright (c) 2013年 cstlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCal.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        MyCal *mycal = [[MyCal alloc] init];
        
        if (2<=argc<=4) {
            
            NSString *time1 = [NSString stringWithUTF8String:argv[1]];  //输入cal
            
            if ([time1 isEqualToString:@"cal"]) {
                
                NSDate *date = [NSDate date];   //获取当前时间
                NSDateComponents *comps;
                NSCalendar *calendar = [NSCalendar currentCalendar];
                comps = [calendar components:(NSYearCalendarUnit) fromDate:date];   //获取当前年份
                NSInteger calYear = [comps year];
                comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];  //获取当前月份
                NSInteger calMonth = [comps month];
                
                if (argc == 2) {    //输出当月月历
                    [mycal printCalyear:calYear andMonth:calMonth];
                }
                else if (argc == 3) {    //输出指定年份月历
                    NSString *time2 = [NSString stringWithUTF8String:argv[2]];
                    if (1<=[time2 integerValue]&&[time2 integerValue]<=9999)
                        [mycal printCalyear:[time2 integerValue]];
                    else
                        [mycal WrongTime];
                }
                else if (argc == 4) {
                    NSString *time2 = [NSString stringWithUTF8String:argv[2]];
                    NSString *time3 = [NSString stringWithUTF8String:argv[3]];
                    if([time2 isEqualToString:@"-m"]) { //输出当年某月月历
                        [mycal printCalyear:calYear andMonth:[time3 integerValue]];
                    } else if (1<=[time2 intValue]&&[time2 intValue]<=12) {   //输出指定年份指定月份月历
                        if (1<=[time3 integerValue]&&[time3 integerValue]<=9999)
                            [mycal printCalyear:[time3 integerValue] andMonth:[time2 integerValue]];
                        else
                            [mycal WrongTime];
                    } else
                        [mycal WrongTime];
                }
                
            } else
                [mycal WrongTime];
        } else
            [mycal WrongTime];
        
    }
    return 0;
}

