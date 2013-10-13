//
//  main.m
//  liuhui calendar
//
//  Created by leo on 13-10-13.
//  Copyright (c) 2013年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include"liuhuiCalendar.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        liuhuiCalendar *calen=[[liuhuiCalendar alloc]init];
        
        
        
        
        //获取当前日期
        
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
        components = [calendar components:unitFlags fromDate:date];
        calen.Year = [components year];
        calen.Month = [components month];
        calen.Day = [components day];
        calen.Week = [components weekday];
        
        
        if(argc==2){
            if(!strcmp(argv[1],"cal")){
                
                
                [calen ShowCurrentMonth:calen.Year month:calen.Month week:calen.Week day:calen.Day ];
                
            }
            else NSLog(@"输入指令错误，请按如下方式输入：1.cal; 2.cal XXXX; 3.cal X XXXX;4.cal -m XX");
            
            
        }
        else if(argc==3){
            int year=atoi(argv[2]);
            if(year<0){NSLog(@"输入年份错误！请输入正整数。");return 0;}
            if(!strcmp(argv[1],"cal")){
                [calen ShowOneYear:year];
                printf("\n");
            }
            else NSLog(@"输入指令错误，请按如下方式输入：1.cal; 2.cal XXXX; 3.cal X XXXX;4.cal -m XX");
        }
        
        
        else if(argc==4){
            if(!strcmp(argv[2],"-m")){
                
                int month=atoi(argv[3]);
                if(month>12||month<1){NSLog(@"输入月份错误！请输入1-12的正整数。");return 0;};
                if(!strcmp(argv[1],"cal")){
                    [calen ShowOneMonth:calen.Year month:month];
                    printf("\n");
                }
                else NSLog(@"输入指令错误，请按如下方式输入：1.cal; 2.cal XXXX; 3.cal X XXXX;4.cal -m XX");
            }
            
            
            else { int year=atoi(argv[3]);
                int month=atoi(argv[2]);
                if(month>12||month<1){NSLog(@"输入月份错误！请输入1-12的正整数。");return 0;};
                if(year<0){NSLog(@"输入年份错误！请输入正整数。");return 0;}
                if(!strcmp(argv[1],"cal")){
                    [calen ShowOneMonth:year month:month];
                    printf("\n");
                }
                else NSLog(@"输入指令错误，请按如下方式输入：1.cal; 2.cal XXXX; 3.cal X XXXX;4.cal -m XX");
            }
        }
        
        else{
            NSLog(@"输入指令错误，请按如下方式输入：1.cal; 2.cal XXXX; 3.cal X XXXX;4.cal -m XX");
        }
        
        
    }
    
    return 0;
}




