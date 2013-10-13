//
//  Calendar.h
//  project1
//
//  Created by 李 嘉俊 on 13-10-8.
//  Copyright (c) 2013年 李 嘉俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]) 

@interface Calendar : NSObject
{
    int Year;
    int Month;
}
@property int Year, Month;

-(Calendar *)init;
-(NSString*)getCalendarByMonth:(int) month year:(int) year;
-(void)printCurrentMonthCalendar;
-(void)printCalendarByMonthYear:(int) month year:(int) year;
-(void)printCalendarByYear:(int) year;

@end
