//
//  Calendar.h
//  calendar
//
//  Created by zsingsong on 13-10-5.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LeapYear(x) (x%4==0 && x%100!=0||x%400==0)?1:0

@interface Calendar : NSObject
+(int)getDays:(int)y ByMonth:(int)m;
+(int)getDaysByYear:(int)y;
+(int)weekByYear:(int)y andMonth:(int)m;
@end
