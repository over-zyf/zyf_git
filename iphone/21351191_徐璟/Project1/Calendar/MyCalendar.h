//
//  MyCalendar.h
//  cal
//
//  Created by Jim-VM on 13-10-10.
//  Copyright (c) 2013年 Jim-VM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCalendar : NSObject
{
@private
    NSCalendar *calendar;
    NSDateComponents *dateComponents;
    NSDate *date;
}

- (void) setYear: (NSUInteger) inputyear;

- (NSUInteger) getYear;

- (void) setMonth: (NSUInteger) inputMonth;

- (NSUInteger) getMonth;

- (void) setDay: (NSUInteger) inputDay;

- (NSUInteger) getDay;

- (NSUInteger) getWeek;

- (void) setYear: (NSUInteger) inputYear Month: (NSUInteger) inputMonth Day: (NSUInteger) inputDay;

- (id) init;

- (id) initWithYear: (NSUInteger) inputYear Month: (NSUInteger) inputMonth Day: (NSInteger) inputDay;

- (id) initWithYear: (NSUInteger) inputYear Month: (NSUInteger) inputMonth;

- (id) initWithYear: (NSUInteger) inputYear;

- (BOOL) isLeapYear: (NSUInteger) inputYear;

- (NSString *) setBodyStr;

- (NSString *) setSingleLine: (NSUInteger) lineNumber;

- (NSString *) getSingleDayString: (NSUInteger) day End: (NSString *) end;

- (NSString *) setHeadStr;

- (NSString *) setMonthStr;

- (NSString *) setWeekStr;

- (BOOL) validateYear: (NSUInteger) year Month: (NSUInteger) month Day: (NSUInteger) day;

- (BOOL) isValidDate;

- (NSString *) getFinalString;

- (NSUInteger) getDaysInFirstWeek;

- (NSUInteger) getWeeksOfMonth;

@end

