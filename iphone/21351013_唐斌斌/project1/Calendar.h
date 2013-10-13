//
//  Calendar.h
//  calendar
//
//  Created by 唐斌斌 on 13-10-9.
//  Copyright (c) 2013年 唐斌斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
{
    char *Chmonth[12];
    int yeartable[20][10][10];
    char *Chweek[7];
}

@property (nonatomic) int year;
@property (nonatomic) BOOL isRunNian;

//init the year
-(id)initWithYear:(int)_year;

//output the chinese week'name
-(void)showWeek;

//compute the table for show year
-(void)caltable;


-(void)ShowYear;


-(void)ShowMonth:(int) Month;

//显示当前年某个月   Month==-1 时  显示当前月
-(void)ShowNowMonth:(int)Month;

//return weekday of xx year xx month xx day
-(int)WeekOfDay:(int)_year andmonth:(int)_month andday:(int)_day;

// return the sum of days of month
-(int)DayOfMonth:(int) month;

@end
