//
//  main.m
//  Calendar
//
//  Created by yyb on 13-10-9.
//  Copyright (c) 2013年 yyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"
int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        printf("1:查询本月日历\n");
        printf("2:查询年份日历\n");
        printf("3:退出程序\n");
        printf("\n");
        printf("请输入选择序号：");
        int select;
        scanf("%d", &select);
        while (3 != select) {
            Calendar *day = [[Calendar alloc] init];
            switch (select) {
                case 1:
                    [day printSoloMonthCal];
                    break;
                case 2:
                    printf("请输入年份：");
                    int y;
                    scanf("%d",&y);
                    [day printCal:y];
                    break;
            }
            printf("\n请输入选择序号：");
            scanf("%d", &select);
        }
    }
    return 0;
}
