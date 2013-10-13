//
//  YearCal.h
//  Calendar
//
//  Created by dv on 13-10-10.
//  Copyright (c) 2013年 wangdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YearCal : NSObject

-(void) setYear:(int)y;
-(void) output;

-(void) outputMonth:(int)m;
-(void) outputMonthBlank:(int)monthBlank;
-(void) outputEnter;
-(void) outputMonthStartBlank:(int)daysInWeek;
-(void) outputMonthEndBlank:(int)dayInWeek;
-(void) outputOneDay:(int)now;

@end
