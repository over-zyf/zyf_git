//
//  brain.h
//  cal3
//
//  Created by ZhaoXM on 13-10-3.
//  Copyright (c) 2013年 ZhaoXM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface brain : NSObject
{

    NSMutableArray *_store1;
    NSMutableArray *_store2;
    NSMutableArray *_store3;
    NSMutableString *_temString;

}

@property(nonatomic)NSInteger year,month;
@property(nonatomic)NSMutableArray *store1,*store2,*store3;
@property(nonatomic)NSString *temString;

-(void)printCalendarYear:(NSInteger)year andMonth:(NSInteger)month;
-(void)printTotalCalendarYear:(NSInteger)year andMonth:(NSInteger)month;
@end
