//
//  Calendar.h
//  Calendar2
//
//  Created by liuyang on 13-10-10.
//  Copyright (c) 2013年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject {
}
+(void) printCalendarWithYear:(NSInteger)year_x withMonth:(NSInteger)month_x withWeek:(NSInteger)week_x withDay:(NSInteger)day_x;
+(int) computeTotalDayOfMonth:(NSInteger)month_x withYear:(NSInteger)year_x;
+(NSInteger) getFirstWeekOfMonth:(int)i inYear:(int)year_x;
+(void) printCalendarOfYear:(int)year_x;
@end
