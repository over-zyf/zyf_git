//
//  MyCalendar.h
//  project1
//
//  Created by yyy on 13-10-12.
//  Copyright (c) 2013年 yyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCalendar : NSObject
-(void) printCalendarWithYear:(int)year AndMonth:(int)month;
-(void) printCalendarWithYear:(int)year;
-(int) judegWithYear:(int)year AndMonth:(int)month;
-(int) getMaxDay:(int)year AndMonth:(int)month;
-(void) getCalendarMatrixWithYear:(int)year AndMonth:(int)month AndRes:(int[6][7])matrix;
@end
