//
//  myCalendar.h
//  MyCalendar
//
//  Created by ShenPF on 13-10-1.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface myCalendar : NSObject
- (id) init;
- (void) getCalendar: (int) year atMonth:(int) month;
- (void) getCalendar: (int) year;
- (void) computeDayWeekwith: (int) year with: (int) month;
- (BOOL) isLeap:(int) year;
@end
