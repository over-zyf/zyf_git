//
//  Cal.h
//  Cal
//
//  Created by 谭卫卫 on 13-10-6.
//  Copyright (c) 2013年 谭卫卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject
{
    int year;
    int month;
    int day;
}

@property int year, month, day;

+(BOOL) isLeapYear: (int) y;
-(void) setDate: (int) y andMonth: (int) m;
-(void) strToLower: (char *) str;
-(int) calWkd: (int) y andMonth: (int) m;
-(int) showYearCalendar;
-(int) showCalendar;
+(int) widthOfYear: (int)y;

@end
