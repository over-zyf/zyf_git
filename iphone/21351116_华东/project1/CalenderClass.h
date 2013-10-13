//
//  CalenderClass.h
//  Calender
//
//  Created by guest on 13-9-28.
//  Copyright (c) 2013年 guest. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CalenderClass : NSObject
{
    int _year;
    int _month;
}
@property int year,month;
-(id)init;
-(id)initWithyear:(int)year andmonth:(int)month;
-(int)returnfistdayweak;
-(void)printcal:(int)firstday;
-(void)printfcalforyear;
@end
