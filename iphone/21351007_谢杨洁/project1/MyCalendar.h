//
//  MyCalendar.h
//  project1
//
//  Created by xyj on 13-10-11.
//  Copyright (c) 2013年 xyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCalendar : NSObject
{
@private
    int nYear;
    int nMonth;
    
}

-(id)init: (int)year AndMonth: (int)month;
-(int) getWeekOfFirstDay;
-(void) GetMonthCal: (int*)cal;

+(void) getCurrentTime: (int*)pYear AndMonth: (int*)pMonth ;


@end
