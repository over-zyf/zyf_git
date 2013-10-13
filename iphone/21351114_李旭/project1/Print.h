//
//  Print.h
//  cal01
//
//  Created by leexu on 13-10-3.
//  Copyright (c) 2013年 leexu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Print : NSObject
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
