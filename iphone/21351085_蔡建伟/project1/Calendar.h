//
//  Calendar.h
//  Calendar
//
//  Created by ShenPF on 13-10-1.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
{
@private
    int day, month, year;
}

- (bool) isLeapYear: (int) tYear;
- (int) computeDayOfWeek: (int)tDay wiht: (int)tMonth wiht: (int)tYear;
- (void) printDay: (int) tDay wiht: (int) tMonth wiht: (int) tYear;
- (int) printEveryMonth: (int)firstDay wiht: (int)tMonth wiht: (int)tYear;
- (void) printMonth: (int) tMonth wiht: (int) tYear;
- (void) printYear: (int) tYear;
- (void) printCurrentMonth;
@end