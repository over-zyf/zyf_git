//
//  liuhuiCalendar.h
//  liuhui calendar
//
//  Created by leo on 13-10-13.
//  Copyright (c) 2013年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface liuhuiCalendar : NSObject
{
    int Year;
    int Month;
    int Week;
    int Day;
}
@property int Year, Month, Week, Day;


-(void)ShowCurrentMonth:(int) year month:(int) month week:(int)week day:(int)day;
-(void)ShowOneMonth:(int) year month:(int) month;
-(void)ShowOneYear:(int) year;
-(int)DaysOfMonth:(NSInteger)month withYear:(NSInteger)year;
-(NSInteger)getFirstWeekOfMonth:(int)i inYear:(int)year;

@end