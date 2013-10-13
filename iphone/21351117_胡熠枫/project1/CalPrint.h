//
//  CalPrint.h
//  Calendar
//
//  Created by Desideria's Apple on 13-10-8.
//  Copyright (c) 2013年 MadAlice's Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalPrint : NSObject
- (int) daysOfMonth: (int)month inYear: (int)year;
- (int) weekdayOfWeek: (int)month inYear: (int)year;
- (void) printMonth: (int)month inYear: (int)year;
- (void) printYear: (int)year;
@end
