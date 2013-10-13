//
//  main.m
//  calendar
//
//  Created by 唐斌斌 on 13-10-9.
//  Copyright (c) 2013年 唐斌斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        if(argc == 1)
        {
            Calendar *cal = [[Calendar alloc]initWithYear:-1];
            
            [cal ShowNowMonth:-1];
        }
        else if(argc == 2)
        {
            int yy = atoi(argv[1]);
            if(yy<1||yy>9999)
            {
                NSLog(@"year is between(1~9999)"); return 0;
            }
            Calendar *cal = [[Calendar alloc]initWithYear:yy];
            [cal ShowYear];
        }
        else if(argc == 3)
        {
                
            if(strcmp(argv[1],"-m") == 0)
            {
                int mm = atoi(argv[2]);
                if(mm<1 || mm>12)
                {
                    NSLog(@"month is between(1~12)"); return 0;
                }
                Calendar *cal = [[Calendar alloc]initWithYear:-1];
                [cal ShowNowMonth:mm];
                return 0;
                
            }
            int mm = atoi(argv[1]);
            int yy = atoi(argv[2]);
            if(mm<1 || mm>12)
            {
                NSLog(@"month is between(1~12)"); return 0;
            }
            if(yy<1||yy>9999)
            {
                NSLog(@"year is between(1~9999)"); return 0;
            }
            Calendar *cal = [[Calendar alloc]initWithYear:yy];
            [cal ShowMonth:mm];
        }
        //[cal ShowYear];
        //[cal ShowMonth:9];
        //[cal ShowNowMonth];
        return 0;
    }
}
