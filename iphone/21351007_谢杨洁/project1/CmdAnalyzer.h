//
//  CmdAnalyzer.h
//  project1
//
//  Created by xyj on 13-10-11.
//  Copyright (c) 2013年 xyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CmdAnalyzer : NSObject
{
@private
    char* strSource;
}
//去处多余的空格,将大写均变为小写
-(id) init: (char*)str;
-(void) change2NormalCmd;
-(int) countSpaces: (int *)pSecondSpace;
-(int) convertFromStr2Int;
-(bool) getYearAndMonth: (int *)pYear AndMonth: (int *)pMonth;
@end
