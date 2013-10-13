//
//  TypeCalender.h
//  PrintCalender
//
//  Created by xueshuMac on 13-9-27.
//  Copyright (c) 2013年 xueshuMac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TypeCalender : NSObject
{
    int year;
    int month;
    int week;
}

@property (strong,nonatomic) NSArray *mounthNames;

-(void) setYear:(int)_year;
-(void) setMonth:(int)_month;
-(int) weekInMonth:(int) _month;
-(int) daysOfMonth:(int) _month;
-(void)printQuarter:(int) month;
-(void)printOneMonth;
-(void) printOneYear;
-(void)printTitle;
-(void)print;
@end
