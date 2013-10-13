//
//  main.m
//  Calendar
//
//  Created by ShenPF on 13-10-1.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"
#import "stdio.h"

int string2int(const char* str){
    int ret = 0;
    for(int i = 0; str[i]; i++)
        ret = ret * 10 + str[i] - '0';
    return ret;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        // insert code here...
        Calendar *cal;
        cal = [Calendar new];
        if(argc == 1){
            [cal printCurrentMonth];
        }
        else if(argc == 2){
            [cal printYear:string2int(argv[1])];
        }
        else if(argc == 3){
            [cal printMonth:string2int(argv[1]) wiht:string2int(argv[2])];
        }
        else if(argc == 4){
            [cal printDay:string2int(argv[1]) wiht:string2int(argv[2]) wiht:string2int(argv[3])];
        }
        else{
            NSLog(@"error:no parameter like this");
        }
        //[cal printDay:1 wiht:10 wiht:2013];
        //[cal printYear:2013];
        //[cal printMonth:10 wiht:2013];
    }
    return 0;
}

