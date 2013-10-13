//
//  Cal.m
//  Cal
//
//  Created by 谭卫卫 on 13-10-6.
//  Copyright (c) 2013年 谭卫卫. All rights reserved.
//

#import "Cal.h"

@implementation Cal

@synthesize year, month, day;
int allMonths[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};
char monthname[13][20] = {" ", "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "Noverber", "December"};

+(BOOL) isLeapYear:(int) y
{
    if ((y%4 == 0 && y%100 != 0) || y%400 == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void) setDate:(int)y andMonth:(int)m
{
    time_t timep;
    struct tm *p;
    time(&timep);
    p = localtime(&timep);
    if (y == 0 && m == 0) {
        year = 1900 + p->tm_year;
        month = 1 + p->tm_mon;
    }
    else if (y == 0 && m != 0)
    {
        year = 1900 + p->tm_year;
        month = m;
    }
    else if (y != 0 && m != 0)
    {
        year = y;
        month = m;
    }
}

-(void) strToLower:(char *)str
{
    char *tmpStr = str;
    
    for (int i = 0; i < strlen(str); i++) {
        if (str[i] >= 'A' && str[i] <= 'Z') {
            tmpStr[i] = tmpStr[i] + 32;
        }
    }
}


-(int) calWkd: (int) y andMonth: (int) m
{
    int total=0,tmp,spaceWeek;
    int dayofMonth[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
    
    if ([Cal isLeapYear:y] != NO)
    {
        dayofMonth[2] = 29;
    }
    
    for (int i=1; i<m; i++)
    {
        total += dayofMonth[i];
    }
    
    total += 1;
    tmp = y-1+(int)((y-1)/4)-(int)((y-1)/100)+(int)((y-1)/400)+total;
    spaceWeek = tmp % 7;
    
    return spaceWeek;
}

+(int) widthOfYear:(int)y
{
    int width;
    if (y >= 1000) {
        width = 4;
    }
    else if (y >= 100)
    {
        width = 3;
    }
    else if (y >= 10)
    {
        width = 2;
    }
    else
    {
        width = 1;
    }
    return width;
}

-(int) showYearCalendar
{
    char yearCalendar[32][64] = {' '};
    int widthA = [Cal widthOfYear: year];
    int widthB = (64 - widthA) / 2;
    
    while (widthB--) {
        printf("%c", ' ');
    }
    printf("%d\n\n", year);
    
    if ([Cal isLeapYear: year] != NO)
    {
        allMonths[2] = 29;
    }
    
    int mtd,spaceWeek;
    mtd = allMonths[month];
    spaceWeek = [self calWkd: year andMonth:month];
    int td = 1;
    int i = 0;
    int j = 0;

//    int titleA = strlen(monthname[month]);
//    //    printf("%s %d\n", monthname[month], year);
    
    printf("Su Mo Tu We Th Fr Sa\n");
    
    for (i=0; i<spaceWeek; i++)
    {
        printf("   ");
        j++;
    }
    while (j != 7)
    {
        printf("%2d",td);
        if (j < 6)
        {
            printf(" ");
        }
        else
        {
            printf("\n");
        }
        
        td++;
        j++;
    }
    while (1)
    {
        for (j=0; j<7; j++)
        {
            printf("%2d",td);
            if (j != 6)
            {
                printf(" ");
            }
            else
            {
                printf("\n");
            }
            
            if (td != mtd)
            {
                td++;
            }
            else
            {
                return 0;
            }
        }
    }
    printf("\n");
    return 0;
}


-(int) showCalendar
{
    if ([Cal isLeapYear: year] != NO)
    {
        allMonths[2] = 29;
    }
    
    int titleA = strlen(monthname[month]);
    int titleB = [Cal widthOfYear: year];
    
    int titleX = (20 - titleA - titleB - 1) / 2;
    while (titleX--) {
        printf(" ");
    }
    printf("%s %d\n", monthname[month], year);
    
    int mtd,spaceWeek;
    mtd = allMonths[month];
    spaceWeek = [self calWkd: year andMonth:month];
    int td = 1;
    int i = 0;
    int j = 0;
    
    printf("Su Mo Tu We Th Fr Sa\n");
    
    for (i=0; i<spaceWeek; i++)
    {
        printf("   ");
        j++;
    }
    while (j != 7)
    {
        printf("%2d",td);
        if (j < 6)
        {
            printf(" ");
        }
        else
        {
            printf("\n");
        }
        
        td++;
        j++;
    }
    while (1)
    {
        for (j=0; j<7; j++)
        {
            printf("%2d",td);
            if (j != 6)
            {
                printf(" ");
            }
            else
            {
                printf("\n");
            }
            
            if (td != mtd)
            {
                td++;
            }
            else
            {
                return 0;
            }
        }
    }
    printf("\n");
    
    return 0;
}

@end
