//
//  MyCal.h
//  MyCal
//
//  Created by jasonross on 13-9-26.
//  Copyright (c) 2013年  jasonross.me All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCal : NSObject
+(int)	daysofMonth:(int)month ofYear:(int)year ;
+(int)	weekdayofDay:(int)day ofMonth:(int)month ofYear:(int)year;
+(void) printOfWeek:(int) week OfMonth:(int) month ofYear:(int) year;
+(void) printOfMonth:(int) month ofYear:(int) year;
+(void) printofYear:(int)year;
@end
