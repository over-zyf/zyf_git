//
//  main.m
//  Calendar
//
//  Created by Jim-VM on 13-9-26.
//  Copyright (c) 2013年 Jim-VM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCalendar.h"
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

NSUInteger Max(NSUInteger num1, NSUInteger num2, NSUInteger num3)
{
    NSUInteger num=num1;
    if (num2>num) {
        num=num2;
    }
    if (num3>num) {
        num=num3;
    }
    return num;
}

NSString *printYear(NSUInteger year)
{
    MyCalendar *cal1=[[MyCalendar alloc] initWithYear:year];
    MyCalendar *cal2=[[MyCalendar alloc] initWithYear:year];
    MyCalendar *cal3=[[MyCalendar alloc] initWithYear:year];
//    NSUInteger months[12]={1,2,3,4,5,6,7,8,9,10,11,12};
    NSString *result=@"";
    if(year<100){
        result=[result stringByAppendingFormat:@"                               %d\n", (int)year];
    }else{
        result=[result stringByAppendingFormat:@"                              %d\n", (int)year];
    }
    for (int i = 1; i <= 12;) {
        [cal1 setMonth:i];
        [cal2 setMonth:i+1];
        [cal3 setMonth:i+2];
        result=[result stringByAppendingString:[cal1 setMonthStr]];
        result=[result stringByAppendingFormat:@"  %@", [cal2 setMonthStr]];
        result=[result stringByAppendingFormat:@"  %@\n", [cal3 setMonthStr]];
        result=[result stringByAppendingString:[cal1 setWeekStr]];
        result=[result stringByAppendingFormat:@"  %@", [cal2 setWeekStr]];
        result=[result stringByAppendingFormat:@"  %@\n", [cal3 setWeekStr]];
        NSUInteger maxWeekOfMonths=Max([cal1 getWeeksOfMonth],[cal2 getWeeksOfMonth], [cal3 getWeeksOfMonth]);
        for (int j = 1; j <= maxWeekOfMonths; j++) {
            result=[result stringByAppendingString:[cal1 setSingleLine:j]];
            result=[result stringByAppendingFormat:@"  %@", [cal2 setSingleLine:j]];
            result=[result stringByAppendingFormat:@"  %@\n", [cal3 setSingleLine:j]];
        }
        i = i + 3;
    }
    return result;
}

int main(int argc, const char * argv[])
{
    MyCalendar *cal;
    NSString *arg1;
    NSString *arg2;
    switch (argc) {
        case 1: //输入没有参数时 cal
            cal=[[MyCalendar alloc] init];
            NSLog([cal getFinalString],nil);
            break;
        case 2: //输入一个参数时 cal 2010
            arg1=[[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding];
//            cal=[[MyCalendar alloc] initWithYear:[arg1 intValue]];
//            for (NSUInteger i=1; i<=12; i++) {
//                [cal setMonth:i];
//                NSLog(@"%@\n",[cal getFinalString]);
//            }
            NSLog(printYear([arg1 intValue]),nil);
            break;
        case 3: //输入两个参数时
            arg1=[[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding];
            arg2=[[NSString alloc] initWithCString:argv[2] encoding:NSUTF8StringEncoding];
            if ([arg1 isEqualToString:@"-m"]) {
                //cal -m 3
                cal=[[MyCalendar alloc] init];
                [cal setMonth:[arg2 intValue]];
                if ([cal isValidDate]) {
                    NSLog([cal getFinalString],nil);
                }
                else
                {
                    NSLog(@"请输入正确的日期");
                }
            }
            else
            {
                //cal 10 2010
                @try {
                    int month=[arg1 intValue];
                    int year=[arg2 intValue];
                    cal=[[MyCalendar alloc] initWithYear:year Month:month];
                    NSLog([cal getFinalString],nil);
                }
                @catch (NSException *exception) {
                    NSLog(@"请输入正确的命令");
                }
            }
            break;
        default:
            NSLog(@"请输入正确的命令");
            return (0);
    }
    //test
//    cal=[[MyCalendar alloc]initWithYear:2010 Month:7 Day:2];
//    NSLog(@"%@ End",[cal setMonthStr]);
//    NSLog(@"%@ End",[cal setWeekStr]);
//    NSLog(@"%@ End",[cal setSingleLine:1]);
//    NSLog(@"%@ End",[cal setSingleLine:2]);
//    NSLog(@"%@ End",[cal setSingleLine:3]);
//    NSLog(@"%@ End",[cal setSingleLine:4]);
//    NSLog(@"%@ End",[cal setSingleLine:5]);
//    NSLog(@"%@ End",[cal setSingleLine:6]);
//    NSLog(@"%@ End",[cal setSingleLine:7]);
    //
    return (0);
}


