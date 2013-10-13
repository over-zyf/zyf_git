//
//  main.m
//  project1
//
//  Created by 李 嘉俊 on 13-10-8.
//  Copyright (c) 2013年 李 嘉俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"
#define debug
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Calendar *cal = [[Calendar alloc] init];
        switch (argc) {
            case 1: //输出当前年月的日历
            {
                [cal printCurrentMonthCalendar];
                break;
            }
            case 2://输出指定年份的日历
            {
                NSString *argv1 = [[NSString alloc]initWithCString:argv[1] encoding:NSUTF8StringEncoding];
                int year = argv1.intValue;
                if(argv[1][0]=='-'){
                    NSLog(@"usage:   [[month] year]\n\t [-m month] [year]");
                }
		        else{
                    if(year<=0 || year>9999){
                        NSLog(@"Error: year %@ not in range 1..9999",argv1);
                    }
                    else{
                        [cal printCalendarByYear:year];
                        //NSLog(@"%d\n",year);
                    }
                }
                break;
            }
            case 3://输出指定年月的日历
            {
                NSString *argc1 = [[NSString alloc]initWithCString:argv[1] encoding:NSUTF8StringEncoding];
                NSString *argc2 = [[NSString alloc]initWithCString:argv[2] encoding:NSUTF8StringEncoding];
                if(argv[1][0]=='-'){
                    if (argv[1][1]=='m') {
                        //int year = cal.Year;
                        int month = argc2.intValue;
                        if(month<1 || month>12){
                            NSLog(@"Error: %@ is neither a month number (1..12) nor a name",argc2);
                        }
                        else{
                            [cal printCalendarByMonthYear:month year:-1];
                            //NSLog(@"%d\t%d\n",month,year);
                        }
                    }
                    else{
                       NSLog(@"usage:   [[month] year]\n\t [-m month] [year]");
                    }
                }
		        else{
                    int month = argc1.intValue;
                    int year = argc2.intValue;
                    if(year<=0 || year >9999){
                        NSLog(@"Error: year %@ not in range 1..9999",argc2);
                    }
                    else if(month<1 || month>12){
                        NSLog(@"Error: %@ is neither a month number (1..12) nor a name",argc1);
                    }
                    else{
                        [cal printCalendarByMonthYear:month year:year];
                        //NSLog(@"%d\t%d\n",month,year);
                    }
                }
                    break;
            }
            case 4:{
                NSString *argc1 = [[NSString alloc]initWithCString:argv[1] encoding:NSUTF8StringEncoding];
                NSString *argc2 = [[NSString alloc]initWithCString:argv[2] encoding:NSUTF8StringEncoding];
                NSString *argc3 = [[NSString alloc]initWithCString:argv[3] encoding:NSUTF8StringEncoding];
                if(argv[1][0]=='-'){
                    if (argv[1][1]=='m') {
                        int month = argc2.intValue;
                        int year = argc3.intValue;
                        if(year<=0 || year >9999){
                            NSLog(@"Error: year %@ not in range 1..9999",argc3);
                        }
                        else if(month<1 || month>12){
                            NSLog(@"Error: %@ is neither a month number (1..12) nor a name",argc2);
                        }
                        else{
                            [cal printCalendarByYear:year];
                            //NSLog(@"%d\t%d\n",month,year);
                        }
                    }
                    else{
                        NSLog(@"usage:   [[month] year]\n\t [-m month] [year]");
                    }
                }
                break;
            }
            default:{//其他情况是均提示用户正确的参数方式
                NSLog(@"usage:   [[month] year]\n\t [-m month] [year]");
                break;
            }
        }
        
    }
    return 0;
}

