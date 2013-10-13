//
//  calendar.m
//  calendar
//
//  Created by Charlotte on 13年10月4日.
//  Copyright (c) 2013年 Charlotte. All rights reserved.
//

#import "calendar.h"

@implementation calendar
@synthesize year,month;

//每个月的天数
-(int) getMonDayWithYear:(int)y withMonth:(int)m
{
    int mday[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    
    if (( y % 4 == 0 && y % 100 != 0 ) || 0 == y % 400) {
        
        mday[1]=29;
    }
    
    return mday[m-1];
}

//每个月的第一天是星期几
-(int) getFirstDateWithYear:(int)y withMonth:(int)m
{
    int pastDays = 0;
    for (int i=1;i<m ; i++) {
        if(m<=12&&m>=1)
        pastDays+=[self getMonDayWithYear:y withMonth:i];
    }
    //算出今天是公元第几天，对7取模得到星期几
    int Date=( y + (y-1)/4 - (y-1)/100  + (y-1)/400  + pastDays )%7;
    
    return Date;
}


//格式化打印每个月，用C实现的。用于单独月份的输出
-(void)showCalWithYear:(int)y withMonth:(int)m
{
    const int calLen=28;
    
    char* months[]={"January","February","March","April","May","June","July","August","September","October","November","December"};
    
    //strlen 取得数组元素的长度。
    unsigned long n = calLen / 2 -(strlen(months[month])+5)/2-1;
                        
    for (int i=0; i<n; i++) {
        printf(" ");
    }
    
    printf("%s %4d\n",months[m-1],y);
    printf("Sun Mon Tue Wed Tur Fri Sat \n");
    
    //取模结果减一得到当月第一天是星期几。
    int d=[self getFirstDateWithYear:y withMonth:m];
    
    //d is the weekday,the position to start printing,very important!
    for (int i=0; i<d; i++) {
        printf("    ");
    }
    
    for (int i=1; i<=[self getMonDayWithYear:y withMonth:m]; i++) {
        
        //空一个，占3个字符，左对齐打印
        printf(" %-3d",i);
        
        d++;
        
        //换行条件
        if (d==7) {
            printf("\n");
            d=0;
        }
    }
    printf("\n\n");
}




//用于整年的输入
//打印月份
-(void)showCalMonWithYear:(int)y withMonth:(int)m
{
    
    const int calLen=28;
    
    char* months[]={"January","February","March","April","May","June","July","August","September","October","November","December"};
    
    //strlen 取得数组元素的长度。
    unsigned long n = calLen / 2 - strlen(months[m])/2;
    
    for (int i=0; i<n; i++) {
        printf(" ");
    }
    
    printf("%s",months[m-1]);
    
    for (int i=0; i<n; i++) {
        printf(" ");
    }
}

//打印星期
-(void)showCalWeekdayWithYear
{
    printf("Sun Mon Tue Wed Tur Fri Sat  ");
}


//打印day
-(void)showCalDayWithYear:(int) y withMonth:(int) m
{
    //取模结果减一得到当月第一天是星期几。
    //d is the weekday,the position to start printing,very important!
    //first row
    
    int count[3]={1,1,1};
    int countd[3];
    for (int j=0;j<3 ; j++) {
    
        int d=[self getFirstDateWithYear:y withMonth:m+j];
        countd[j]=d;
        
        for (int i=0; i<d; i++) {
            printf("    ");
        }
        
        int temp=d;
        for (; count[j]<=(7-temp); count[j]++) {
            //空一个，占3个字符，左对齐打印
            printf(" %-3d",count[j]);
        }
        
        printf(" ");
    }
    printf("\n");
    
    for (int k=0; k<=5; k++) {
        
        for (int j=0;j<3 ; j++) {
                    
            for (int i=0; i<7; i++) {
                //空一个，占3个字符，左对齐打印
                if (count[j]<=[self getMonDayWithYear:y withMonth:(m+j)]) {
                    printf(" %-3d",count[j]);
                    count[j]++;
                }else
                printf("    ");
            }
        
            printf(" ");
        }
        printf("\n");
    }
    
}



//打印年历
-(void)printMYear:(int)y andMonth:(int)m
{   //打印月份
    for (int i=0; i<3; i++) {
        
        [self showCalMonWithYear:y withMonth:m+i];
        
    }
    printf("\n");
    
    //打印星期
    for (int i=1; i<=3; i++) {
        
        [self showCalWeekdayWithYear];
    }
    printf("\n");
    
    //打印日期
    [self showCalDayWithYear:y withMonth:m];
    printf("\n");
    
}

@end
