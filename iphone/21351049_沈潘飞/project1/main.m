//
//  main.m
//  MyCalendar
//
//  Created by ShenPF on 13-10-1.
//  Copyright (c) 2013年 Eric. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "myCalendar.h"
int number(const char *ns){
    int number=0;
    for (int i =0; i<strlen(ns); i++) {
        number=number*10+ns[i]-'0';
    }
    return number;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        myCalendar *mc=[myCalendar new];
        if(argc==1){
            NSDateComponents *components = [[NSCalendar currentCalendar] components: NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
            [mc getCalendar:[components year] atMonth: [components month]];
        }else if(argc==2){
            [mc getCalendar:number(argv[1])];
        }else if(argc==3){
            [mc getCalendar:number(argv[1]) atMonth: number(argv[2])];
        }
        
    }
    return 0;
}

