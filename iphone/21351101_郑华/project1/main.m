//
//  main.m
//  Calen2
//
//  Created by huazi on 13-10-8.
//  Copyright (c) 2013年 huazi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calen.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        int num;//记录选择
        
        do{
        inputFormat();
        printf("请输入您的选择：\n");
                scanf("%d", &num);
        if(num==1){//输出当前的日历
            NSCalendar *calendar=[NSCalendar currentCalendar];
            unsigned unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
            NSDateComponents *components=[calendar components:unitFlags fromDate:[NSDate date]];
            int curYear=[components year];
            int curMonth=[components month];//获取当前的年月
            
            [Calen printOfMonth:curMonth ofYear:curYear];//调用打印方法
        }else{
            if(num==2){//指定年份的日历
                
                int year;
                printf("请输入您所需要查询的年份：");
                scanf("%d",&year);
                for(int i=1;i<=12;i++){
                    [Calen printOfMonth:i ofYear:year];
                }//循环打印月份
            }else{
                if (num==3) {
                    int year,month;
                    printf("请输入您所需要查询的年份：");
                    scanf("%d",&year);
                    printf("请输入您所需要查询的月份：");
                    scanf("%d",&month );
                    if(month<1||month>12){
                        printf("您输入的月份不在范围内，请输入正确的月份（1～12）！\n");
                        continue;
                    }
                    [Calen printOfMonth:month ofYear:year];
                }
            }
        }
    }while (num!=0);//选择为0时退出循环
    }
    return 0;
}
int inputFormat(){
    printf("使用方法：\n");
    printf("0 退出\n");
    printf("1 输出当前的日历\n");
    printf("2 输出特定年份日历\n");
    printf("3 输出某年某月的日历\n");
    return 0;
}//提示

