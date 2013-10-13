//
//  calendar.h
//  Calendar
//
//  Created by apple on 13-10-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calendar : NSObject
{@private
 int Year;
 int Month;
 int Week;
 int Day;
}
@property int Year;
@property int Month;
@property int Week;
@property int Day;
-(void)calendar:(int) year;
-(void)calendarwithmonth:(int) year month:(int) month;
-(int)calendarfistdaywithyear:(int) year month:(int) month;
+(void)calendarprintfformate:(int) year Fmonth:(int)f Smonth:(int)s Tmonth:(int)t;
@end
