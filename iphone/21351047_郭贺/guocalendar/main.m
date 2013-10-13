//
//  main.m
//  guocalendar
//
//  Created by guest on 13-10-9.
//  Copyright (c) 2013年 guohe. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        int year,month;
        printf("输入以下格式查询年月：2013 10\n");
        scanf("%d%d",&year, &month);
        printf("日\t一\t二\t三\t四\t五\t六\n");
        NSDateComponents  *datecom=[[NSDateComponents alloc]init];
        [datecom setDay:1];
        [datecom setMonth:month];
        [datecom setYear:year];
        
        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date = [gregorian dateFromComponents:datecom];
        //     [datecom release];
        
        NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
        
        int weekday = [weekdayComponents weekday];
        int temp = weekday-1;
        while(temp--)
            printf("  \t");
        
        int months[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
        if((year%4 == 0&&year%100 != 0)||(year%400 == 0))
            months[1] = 29;
        
        for(int i = 1;i <= months[month-1];i++){
            if((i + weekday - 2)%7 == 0)
            {
                if(i == 1)
                    printf("%d\t",i);
                else{
                    printf("\n");
                    printf("%d\t",i);
                }
            }
            else printf("%d\t",i);
        }
        printf("\n");
        
    }
    return 0;
}

