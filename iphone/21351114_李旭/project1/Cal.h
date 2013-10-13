//
//  Cal.h
//  mycal
//
//  Created by leexu on 13-10-12.
//  Copyright (c) 2013年 leexu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject
{
    int year;
    int month;
}

-(void) setYear: (int) _year;
-(void) setMonth: (int) _month;
-(int) daysOfMonth;
-(int) dayOfWeek;
-(void) printOfMonth;
@end