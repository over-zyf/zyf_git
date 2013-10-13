//
//  Calender.h
//  calender
//
//  Created by SZH on 13-10-2.
//  Copyright (c) 2013年 SZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calender : NSObject
{
@private
    int m_days;//距离元年元月元日的天数
    int m_weekday;//周几
    int m_year;
    int m_month;
    int m_day;
}

-(id)initYear:(int)year Month:(int)month Day:(int)day;
-(int)daysCountYear:(int)year Month:(int)month;
-(int)weekday_days:(int)days;
//setter geter
-(int) Year;
-(void)setYear:(int)year;
-(int)Month;
-(void)setMonth:(int)month;
-(int)Day;
-(void)setDay:(int)day;
-(int)Days;
-(int)Weekday;
@end
