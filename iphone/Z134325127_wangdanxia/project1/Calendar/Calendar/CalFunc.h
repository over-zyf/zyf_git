//
//  CalFunc.h
//  Calendar
//
//  Created by dv on 13-10-11.
//  Copyright (c) 2013年 wangdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalFunc : NSObject

-(void) outputWeek;
//trasfer year and month to date which format is yyyyMMdd
-(int) outputDaysInWeek_setYear:(int)transyear setMonth:(int)transmonth;
-(NSInteger) daysInMonth:(int)month;
-(Boolean) isLeapYear:(int)y;
-(Boolean) isYearInRange:(int)y;
-(void) outputIllagalInput;
-(Boolean) isMonthInRange:(int)m;
@end
