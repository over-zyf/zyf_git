//
//  Calendar.h
//  Calendar
//
//  Created by yyb on 13-10-9.
//  Copyright (c) 2013年 yyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
@property int year, month, day, week;

-(void) printCal:(int)year1;

-(void)printSoloMonthCal;
@end
