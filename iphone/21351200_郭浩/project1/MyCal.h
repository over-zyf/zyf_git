//
//  MyCal.h
//  cal OC2
//
//  Created by apple on 13-10-9.
//  Copyright (c) 2013年 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mycal : NSObject
{
    int year;
    int weekdays;
    int days,month;
}

-(int)year;
-(void)setYear:(int)g_year;

-(int) getDays:(int)g_month;
-(void)getWeekdays;

-(int)weekdays;
-(void)setWeekdays:(int)weekday;

-(int)days;
-(void)setDays:(int)g_day;

@end

