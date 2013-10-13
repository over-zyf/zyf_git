//
//  Calendar.h
//  Calendar
//
//  Created by guest on 13-10-6.
//  Copyright (c) 2013年 zhaoshihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
{
    int Year;
    int Month;
    int Week;
    int Day;
}
@property int Year, Month, Week, Day;

-(void)printCalendar:(int) year;
-(void)printCalendarOfYear:(int) year month:(int) month week:(int)week day:(int)day;
-(void)printCalendarOfYear:(int) year month:(int) month;
@end
