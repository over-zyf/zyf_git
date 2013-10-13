//
//  MyCal.h
//  mycal
//
//  Created by 宇超 黄 on 13-10-8.
//  Copyright (c) 2013年 宇超 黄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCal : NSObject
{
@private
    char *months[12];
    NSInteger dayOfMonth[2][13];
    NSInteger year;
    NSInteger month;
    NSInteger leap;
}
-(id)init;
-(void)setYear:(NSInteger)year;
-(void)setMonth:(NSInteger)month;
-(void)isLeapYear;
-(NSInteger)fisrtOfYear;
-(NSInteger)firstDayOfMonth;
-(void)printYear;
-(void)printMonth;
@end

