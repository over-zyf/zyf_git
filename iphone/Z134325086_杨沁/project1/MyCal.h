//
//  mycal.h
//  cal
//
//  Created by cstlab on 13-10-10.
//  Copyright (c) 2013年 cstlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCal : NSObject

-(NSMutableArray *) myCalendaryear:(NSInteger) year andMonth:(NSInteger) month;
-(void) printCalyear:(NSInteger) year andMonth:(NSInteger) month;
-(void) printCalyear:(NSInteger) year;
-(void) WrongTime;
-(NSInteger) maxa:(NSInteger) a andb:(NSInteger) b andc:(NSInteger) c;

@end
