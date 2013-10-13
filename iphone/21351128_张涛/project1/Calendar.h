//
//  Calendar.h
//  Calendar
//
//  Created by zht2013sg on 13-10-10.
//  Copyright (c) 2013年 zht2013sg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
{
    @private
    int nYear;
    int nMonth;
}
@property int nYear,nMonth;

-(void) printmonth;
-(NSInteger) firstdayofWeek:(int)year_n withmonth:(int)month_n;
-(int) daysofMonth:(int)year_n withmonth:(int)month_n;
-(void) printyear;
-(int) printLine:(int)year_n withmonth:(int)month_n withdays:(int)day_n withfirstday:(int)firstday_n;
-(bool) endofMonth:(int)year_n withmonth:(int)month__n withdays:(int)day_n;

@end
