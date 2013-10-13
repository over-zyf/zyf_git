//
//  Calen.h
//  Calen2
//
//  Created by huazi on 13-10-8.
//  Copyright (c) 2013年 huazi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calen : NSObject
+(int)daysOfMonth:month ofYear:(int)year;
+(int)weekdayOfDay:(int)day ofMonth:(int)month ofYear:(int)year;
+(void)printOfMonth:(int)CurMonth ofYear:(int)CurYear;
@end
