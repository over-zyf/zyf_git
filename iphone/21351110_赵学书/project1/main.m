//
//  main.m
//  PrintCalender
//
//  Created by xueshuMac on 13-9-27.
//  Copyright (c) 2013年 xueshuMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeCalender.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        //无效参数给出合理的解释
        //cal  -m  2;输出当年某月饿日历
    
        
        TypeCalender *calender=[[TypeCalender alloc]init];
        NSString *   newString;
        NSDate * date = [NSCalendarDate date];//获取本地时间。
        NSCalendarDate * cDate = [date dateWithCalendarFormat:@"%d %b %Y" timeZone:[NSTimeZone localTimeZone]];
        int month=   (int)[cDate monthOfYear];
        int year=   (int)[cDate yearOfCommonEra];
   ///判断参数个数分别处理
        if (argc==1) {
            [calender setYear:year];
            [calender setMonth:month];
        }
        else if(argc==2)
        {
            newString=[NSString stringWithFormat:@"%s",argv[1]];
            year = [newString intValue];
            if(year <= 0)
            {
                printf("year 0 not in range 1753..9999\n");
                return 0;
            }else if (year < 1753||year > 9999)
            {
                printf("year %s not in range 1753..9999\n",argv[1]);
                return 0;
            }
            else{
                [calender setYear:[newString intValue]];
                [calender setMonth:0];
            }
        }
        else if(argc==3)
        {
          newString=[NSString stringWithFormat:@"%s",argv[1]];
            if([newString isEqualToString:@"-m"])
            {
                [calender setYear:year];
                  newString = [NSString stringWithFormat:@"%s",argv[2]];
                month = [newString intValue];
                if (month <= 0 ||month > 12) {
                    printf("%s is neither a month number (1..12) nor a name\n",argv[2]);
                    return 0;
                } else {
                    [calender setMonth:[newString intValue]];
                }
            }
            else{
                month = [newString intValue];
                if (month <= 0 ||month > 12) {
                    printf("%s is neither a month number (1..12) nor a name\n",argv[1]);
                    return 0;
                } else {
                    [calender setMonth:[newString intValue]];
                }

               // [calender setMonth:[newString intValue]];
                newString = [NSString stringWithFormat:@"%s",argv[2]];
                year = [newString intValue];
                if(year <= 0)
                {
                    printf("year 0 not in range 1753..9999\n");
                    return 0;
                }else if (year < 1753||year > 9999)
                {
                    printf("year %s not in range 1753..9999\n",argv[2]);
                    return 0;
                }
                else{
                [calender setYear:[newString intValue]];
            }
          //  newString = [NSString stringWithFormat:@"%s",argv[1]];
            }}
        else{
            printf("usage:[-jy] [[month] year]\n\t[-j] [-m month] [year]\n\t[-Jjpwy] [-s country_code] [[month] year]\n\t [-Jeo] [year]\n");
            return 0;
        }
              [calender print];
   
    }
    return (0);
}

