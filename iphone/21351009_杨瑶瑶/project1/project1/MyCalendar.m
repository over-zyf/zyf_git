//
//  MyCalendar.m
//  project1
//
//  Created by yyy on 13-10-12.
//  Copyright (c) 2013年 yyy. All rights reserved.
//

#import "MyCalendar.h"

@implementation MyCalendar
//输出某年某月
-(void) printCalendarWithYear:(int)year AndMonth:(int)month
{
    int matrix[6][7];
    printf("\t\t\t%d月",month);
    printf("\t%d年\n",year);
    printf("\t日\t一\t二\t三\t四\t五\t六\n");
    
    [self getCalendarMatrixWithYear:year AndMonth:month AndRes:matrix];
    
    
    int i,j;
    for (i=0;i<6;i++)
    {
        for (j=0;j<7;j++)
        {
            if (matrix[i][j]==0)
            {
                printf("\t");
            }
            else
            {
                printf("\t%d",matrix[i][j]);
            }
        }
        printf("\n");
    }
}
//输出某年
-(void) printCalendarWithYear:(int)year;
{
    int matrix[12][6][7];
    int i,j,k;
    for(i=0;i<12;i++)
    {
        [self getCalendarMatrixWithYear:year AndMonth:i+1 AndRes:matrix[i]];
    }
    printf("\t\t\t\t\t\t\t\t\t\t\t\t%d年\n",year);
    for (i=1; i<=10; i=i+3)
    {
        printf("\t\t\t\t%d月\t\t\t\t",i);
        printf("\t\t\t\t%d月\t\t\t\t",i+1);
        printf("\t\t\t\t%d月\t\t\t\n",i+2);
        printf("\t日\t一\t二\t三\t四\t五\t六\t");
        printf("\t日\t一\t二\t三\t四\t五\t六\t");
        printf("\t日\t一\t二\t三\t四\t五\t六\n");
        for(j=0;j<6;j++)
        {
            for(k=0;k<7;k++)
            {
                printf("\t");
                if (matrix[i-1][j][k]!=0)
                {
                    printf("%d",matrix[i-1][j][k]);
                }
            }
            printf("\t");
            for(k=0;k<7;k++)
            {
                printf("\t");
                if (matrix[i][j][k]!=0)
                {
                    printf("%d",matrix[i][j][k]);
                }
            }
            printf("\t");
            for(k=0;k<7;k++)
            {
                printf("\t");
                if (matrix[i+1][j][k]!=0)
                {
                    printf("%d",matrix[i+1][j][k]);
                }
            }
            printf("\n");
        }
        printf("\n");
    }
}
//获取某年某月数组
-(void) getCalendarMatrixWithYear:(int)year AndMonth:(int)month AndRes:(int[6][7])matrix
{
    int weekday = [self judegWithYear:year AndMonth:month];
    int max = [self getMaxDay:year AndMonth:month];//该月份的最大天数
    int i,j;
    for (i=0;i<6;i++)
    {
        for (j=0;j<7;j++)
        {
            matrix[i][j]=0;
        }
    }
    for (i=0,j=1;j<=max;i++)
    {
        if (weekday>1)
        {
            weekday--;
        }
        else
        {
            matrix[i/7][i%7]=j;
            j++;
        }
    }
}
//判断某年某月份的1号是星期几
-(int) judegWithYear:(int)year AndMonth:(int)month
{
    //    NSString *currentDateString = @"2012-05-01 12:0:0";
    NSString *currentDateString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d-%d-01 12:0:0",year,month]];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormater dateFromString:currentDateString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    
    comps =[calendar components:(NSWeekCalendarUnit|NSWeekdayCalendarUnit|NSWeekdayOrdinalCalendarUnit) fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。
    
    return (int)weekday;
}
//该月份的最大天数
-(int) getMaxDay:(int)year AndMonth:(int)month
{
    if (month == 2)
    {
        if((year%4==0 && year%100!=0) || year%400==0) //闰年
        {
            return 29;
        }
        else
        {
            return 28;
        }
    }
    else if (month==1||month==3||month==5||month==7||month==8||month==10||month==12)
    {
        return 31;
    }
    else
    {
        return 30;
    }
}

@end
