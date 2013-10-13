//
//  Calendar.m
//  Calendar
//
//  Created by guest on 13-10-6.
//  Copyright (c) 2013年 zhaoshihao. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

@synthesize Year,Month,Week,Day;

-(void)printCalendarOfYear:(int) year month:(int) month week:(int)week day:(int)day
{
    int curWeek = week;
    int tmp =  curWeek - 1;
    char *months_name[12] = {"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    
    
    printf("     %s %d \n",months_name[month - 1],year);
    printf("日 一 二 三 四 五 六\n");

    
    for(int i = curWeek - 1; i > 0; i--)
        printf("   ");
    
    int months[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if((year % 4 == 0 && year % 100 != 0)||(year % 400 == 0))
        months[1] = 29;
    
    for(int i = 1;i <= months[month - 1];i++){
        if((i + curWeek - 2) % 7 == 0)
        {
            if(i == 1)
                printf("%2d ",i);
            else{
                printf("\n");
                printf("%2d ",i);
            }
        }
        else printf("%2d ",i);
    }
    printf("\n");
}

-(void) printCalendarOfYear:(int)year month:(int)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    [comps release];
    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    int curWeek = [weekdayComponents weekday];
    
    char *months_name[12] = {"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    
    printf("     %s %d \n",months_name[month - 1],year);
    printf("日 一 二 三 四 五 六\n");
    
    for(int i = curWeek - 1; i > 0; i--)
        printf("   ");
    
    int months[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if((year % 4 == 0 && year % 100 != 0)||(year % 400 == 0))
        months[1] = 29;
    
    for(int i = 1;i <= months[month - 1];i++){
        if((i + curWeek - 2) % 7 == 0)
        {
            if(i == 1)
                printf("%2d ",i);
            else{
                printf("\n");
                printf("%2d ",i);
            }
        }
        else printf("%2d ",i);
    }
    printf("\n");
    
    
}

-(int)getEveryWeekOfMonth:(int)month year:(int) year
{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    [comps release];
    
    NSDateComponents *components_week =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    int curWeek = [components_week weekday];
    int temp = curWeek - 1;
    return temp;
}


-(void)printCalendar:(int)year
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:1];
    [comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    [comps release];
    
    NSDateComponents *components_week =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    int firstday[12]={0};
    int day_array[4][6][23] = {0};
    int months[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if((year % 4 == 0 && year % 100 != 0)||(year % 400 == 0))
        months[1] = 29;

    char *month_name[12] = {"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    
    for(int i = 0; i < 12 ;i++)
        firstday[i] = [self getEveryWeekOfMonth:i+1 year:year];
        
    
    printf("                                %ld\n\n", year);
    for(int i = 0; i < 4; i++)
    {
        if( i != 3)
        {
            printf("        %s                  %s                  %s\n", month_name[i * 3], month_name[i * 3 + 1], month_name[i * 3 + 2]);

        }
        else if(i == 3)
        {
            printf("        %s                 %s                %s\n", month_name[i * 3], month_name[i * 3 + 1], month_name[i * 3 + 2]);
        }
            printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        
        int firstday_months[3] = {1,1,1};
        
        for(int j = 0; j< 6 ;j++)
        {
            if(j == 0)
            {
                for(int m = firstday[3 * i]; m < 7; m++)
                {
                    day_array[i][j][m] = firstday_months[0];
                    firstday_months[0]++;
                }
                for(int n = firstday[3 * i + 1] + 8; n < 15; n++)
                {
                    day_array[i][j][n] = firstday_months[1];
                    firstday_months[1]++;
                }
                for(int k = firstday[3 * i + 2] + 16; k < 23; k++)
                {
                    day_array[i][j][k] = firstday_months[2];
                    firstday_months[2]++;
                }
            }
            else
            {
                for(int m = 0; m < 7 && firstday_months[0] <= months[3 * i]; m++)
                {
                    day_array[i][j][m] = firstday_months[0];
                    firstday_months[0]++;
                }
                for(int n = 8; n < 15 && firstday_months[1] <= months[3 * i + 1]; n++)
                {
                    day_array[i][j][n] = firstday_months[1];
                    firstday_months[1]++;
                }
                for(int k = 16; k < 23 && firstday_months[2] <= months[3 * i + 2]; k++)
                {
                    day_array[i][j][k] = firstday_months[2];
                    firstday_months[2]++;
                }
            }
            for(int m = 0; m < 23; m++)
            {
                if(day_array[i][j][m] == 0)
                {
                    if(m == 7 || m == 15)
                        printf(" ");
                    else printf("   ");
                }
                else
                {
                    printf("%2d ", day_array[i][j][m]);
                }
            }
            printf("\n");
        }
        
    }
}



@end

