//
//  myCal.h
//  myCal
//
//  Created by fallen on 13-10-9.
//  Copyright (c) 2013年 fallen. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface calendar : NSObject
{
    /**用于保存每个月1号的星期**/
    NSInteger weekdays[13];
}
/**取得指定月份1号的星期**/
-(NSInteger)getWeekday:(NSInteger)year month:(NSInteger)month;
/**打印指定月份**/
-(void)printMonth:(NSInteger)year month:(NSInteger)month;
/**打印指定年份**/
-(void)printYear:(NSInteger)year;
@end