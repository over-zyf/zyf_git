//
//  Print.m
//  cal01
//
//  Created by leexu on 13-10-3.
//  Copyright (c) 2013年 leexu. All rights reserved.
//

#import "Print.h"

@implementation Print

-(void) setYear: (int) _year
{
    year = _year;
}

-(void) setMonth: (int) _month
{
    month = _month;
}

//计算当月的天数
-(int) daysOfMonth
{
    if ( month ==2) {
        if (year <=1752) {
            if (year%4 ==0) {
                return 29;
            }
            else
            {
                return 28;
            }
        }
        else{
            if ((year%4 == 0&&year%100!=0)||year%400 ==0) {
                return 29;
            }
            else
            {
                return 28;
            }
            
        }
    }
    else
    {
        switch (month)
        {
            case 1 :
            case 3 :
            case 5 :
            case 7 :
            case 8 :
            case 10:
            case 12:
                return 31;
                break;
            default:
                return 30;
                break;
        }
    }

}

//计算当前月份的第一天是星期几
-(int) dayOfWeek
{
    int days1[12]={31,29,31,30,31,30,31,31,30,31,30,31};
    int days2[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    int countDay = 0;
    if(year<1752)
    {
        if (year%4 ==0) {
            int count = 0;
            for(int i =0;i<month-1;i++)
            {
                count = count+days1[i];
            }
            countDay = (year/4 -1)*366 + (year-year/4)*365+count;
        }
        else
        {
            int count = 0;
            for(int i =0;i<month-1;i++)
            {
                count = count+days2[i];
            }
            countDay = (year/4)*366 + (year-1-year/4)*365;
        }
        return (countDay%7+6)%7;
    }
    else if(year>1752)
    {
        int sum = 0;
        for (int i=1752; i<=year; i++) {
            if ((i%4 == 0&&i%100!=0)||i%400 ==0)
                sum++;
        }
        if ((year%4 == 0&&year%100!=0)||year%400 ==0) {
            int count = 0;
            for(int i =0;i<month-1;i++)
            {
                count = count+days1[i];
            }
            countDay = (sum -1)*366 + (year-1752-sum+1)*365+count-11+(1752/4)*366 + (1752-1-1752/4)*365;
        }
        else
        {
            int count = 0;
            for(int i =0;i<month-1;i++)
            {
                count = count+days2[i];
            }
            countDay = sum*366 + (year-1752-sum)*365+count-11+(1752/4)*366 + (1752-1-1752/4)*365;
        }
        return ((countDay%7+6)%7-1);
    }
    else
    {
        if (month<9) {
            int count = 0;
            for(int i =0;i<month-1;i++){
                count = count+days2[i];
            }
            countDay = count +(1752-1-1752/4)*365;
        }
        else
        {
            int count = 0;
            for(int i =0;i<month-1;i++){
                count = count+days2[i];
            }
            countDay = count +(1752-1-1752/4)*365-11;
        }
        return ((countDay%7+6)%7-1);
    }
}

-(void) printOfMonth
{
    if(year == 1752 &&month ==9)
    {
        printf("\t\t%d  月 %d \n",month,year);
        printf("日\t一\t二\t三\t四\t五\t六\n");
        printf("\t\t1\t 2\t14\t15\t16\n");
        printf("17\t18\t19\t20\t21\t22\t23\n");
        printf("24\t25\t26\t27\t28\t29\t30\n");
    }
    else
    {
        printf("\t\t%d  月 %d \n",month,year);
        printf("日\t一\t二\t三\t四\t五\t六\n");
        
        int weekday = [self dayOfWeek];
        for(int i=0;i<weekday;i++)
        {
            printf("\t");
        }
        
        int days=[self daysOfMonth];
        for(int i=1;i<=days;i++)
        {
            if(i<10)
                printf(" %d",i);
            else {
                printf("%d",i);
            }
            if((i-1+weekday)%7==6)
            {
                printf("\n");
            }
            else {
                printf("\t");
            }
        }
        if((days-1+weekday)%7!=6)
            printf("\n");
        printf("\n");
        
    }
}
@end
