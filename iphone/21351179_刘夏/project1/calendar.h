//
//  calendar.h
//  calendar
//
//  Created by Charlotte on 13年10月4日.
//  Copyright (c) 2013年 Charlotte. All rights reserved.
//

#import "calendar.h"

@interface calendar : NSObject
@property int year,month;

-(int) getMonDayWithYear:(int) y withMonth:(int)m;
-(int) getFirstDateWithYear:(int)y withMonth:(int)m;

-(void) showCalWithYear:(int)y withMonth:(int) m;

//分行打印整个月份：打印星期，打印天数。

-(void) showCalMonWithYear:(int) y withMonth:(int)m;
-(void) showCalWeekdayWithYear:(int) y withMonth:(int)m;
-(void) showCalDayWithYear;
-(void) showCalRestDaysWithYear:(int) y withMonth:(int)m;

-(void)printMYear:(int)y andMonth:(int)m;

@end
