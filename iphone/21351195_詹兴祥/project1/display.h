//
//  display.h
//  calendar
//
//  Created by zsingsong on 13-10-5.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface display : NSObject

+(void) spaceNotation:(int)n;
+(void) displayYear:(int)y Month:(int)m ;
+(void) displayYear:(int)y;
+(void) displayfun:(int)y Month:(int)m ;
+(NSString*) generateSpace:(int)n;
+(NSArray*)arrayFun1:(NSMutableString*)element week:(int)week n:(int)n;
+(NSArray*)arrayFun:(NSMutableString*)element week:(int)week nextweek:(int)nextweek n:(int)n;
@end
