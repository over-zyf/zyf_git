//
//  Calendar.m
//  Calendar
//
//  Created by zht2013sg on 13-10-10.
//  Copyright (c) 2013年 zht2013sg. All rights reserved.
//

#import "Calendar.h"
#import <stdio.h>
#define NWEEK 7
#define NMONTH 12

const char* month[] = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};

@implementation Calendar

@synthesize nYear,nMonth;

-(NSInteger) firstdayofWeek:(int)year_n withmonth:(int)month_n{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month_n];
    [comps setYear:year_n];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger nDayofWeek = [weekdayComponents weekday];
    return nDayofWeek - 1;
}

-(int) daysofMonth:(int)year_n withmonth:(int)month_n{
    nYear = year_n;
    nMonth = month_n;
    if (nMonth == 1 || nMonth == 3 || nMonth == 5 || nMonth == 7 ||nMonth == 8 || nMonth == 10 || nMonth == 12) {
        return 1;
    }
    else if (nMonth == 2)
    {
        if (nYear % 400 == 0 || (nYear % 4 == 0 && nYear % 100 != 0))
            return 2;
        else return 3;
    }
    else return 4;
}

-(void) printmonth{
    printf("     %s %d\n",month[nMonth-1],nYear);
    printf("日 一 二 三 四 五 六\n");
    int firstday = (int)[self firstdayofWeek:nYear withmonth:nMonth];
    int nK;
    for (nK = 0; nK < firstday; nK++) {
        printf("   ");
    }
    int nTemp = [self daysofMonth:nYear withmonth:nMonth];
    int nLine = 1;
    for (nK = 1; nK < 32; nK++) {
        printf("%2d ", nK);
        if (nTemp == 1 && nK == 31) {
            break;
        }
        else if (nTemp == 2 && nK == 29) {
            break;
        }
        else if (nTemp == 3 && nK == 28){
            break;
        }
        else if (nTemp == 4 && nK == 30){
            break;
        }
        if ((firstday + nK) % 7 == 0) {
            printf("\n");
            nLine++;
        }
    }
    while (nLine <= 6) {
        printf("\n");
        nLine++;
    }
}

-(int) printLine:(int)year_n withmonth:(int) month_n withdays:(int)day_n withfirstday:(int)firstday_n{
    int nTemp,firstday,nK;
    nTemp = [self daysofMonth:year_n withmonth:month_n];
    firstday =  firstday_n;
    nK = day_n;
    for (; nK < 32; nK++) {
        printf("%2d ", nK);
        if ((firstday + nK) % 7 == 0) {
            break;
        }
        if (nTemp == 1 && nK == 31) {
            break;
        }
        else if (nTemp == 2 && nK == 29) {
            break;
        }
        else if (nTemp == 3 && nK == 28){
            break;
        }
        else if (nTemp == 4 && nK == 30){
            break;
        }
    }
    printf(" ");
    return  nK;
}

-(bool) endofMonth:(int)year_n withmonth:(int)month__n withdays:(int)day_n{
    int nTemp,nK;
    nTemp = [self daysofMonth:year_n withmonth:month__n];
    nK = day_n;
    if (nTemp == 1 && nK == 31) {
        return true;
    }
    else if (nTemp == 2 && nK == 29){
        return true;
    }
    else if (nTemp == 3 && nK == 28){
        return true;
    }
    else if (nTemp == 4 && nK == 30){
        return true;
    }
    else {
        return false;
    }
}

-(void) printyear{
     printf("                             %d\n\n",nYear);
    int nSpace,nI,nJ,nLastdayofMonth;
    int nFirstday[12] = {0};
    int nK[12] = {1,1,1,1,1,1,1,1,1,1,1,1};
    bool bFlag[12] = {0};
    for (nI = 0; nI < 4; nI++) {
        if (nI < 3) {
            printf("        %s                  %s                  %s\n", month[nI*3], month[nI*3+1], month[nI*3+2]);
        }
        else{
            printf("        %s                 %s                %s\n", month[nI*3], month[nI*3+1], month[nI*3+2]);
        }
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        
        for (nJ = 0; nJ < 3; nJ++) {
            nFirstday[nI*3+nJ] = (int)[self firstdayofWeek:nYear withmonth:nI*3+nJ+1];
        }
        
        for (nJ = 0; nJ < 6; nJ++) {
            if (nJ == 0) {
                for (nSpace = 0; nSpace < nFirstday[nI*3]; nSpace++) {
                    printf("   ");
                }
                nK[nI*3] = [self printLine:nYear withmonth:nI*3+1 withdays:nK[nI*3] withfirstday:nFirstday[nI*3]] + 1;
                
                for (nSpace = 0; nSpace < nFirstday[nI*3+1]; nSpace++) {
                    printf("   ");
                }
                nK[nI*3+1] = [self printLine:nYear withmonth:nI*3+2 withdays:nK[nI*3+1] withfirstday:nFirstday[nI*3+1]] + 1;
                
                for (nSpace = 0; nSpace < nFirstday[nI*3+2]; nSpace++) {
                    printf("   ");
                }
                nK[nI*3+2] = [self printLine:nYear withmonth:nI*3+3 withdays:nK[nI*3+2] withfirstday:nFirstday[nI*3+2]] + 1;
            }
            else if (nJ < 4){
                nK[nI*3] = [self printLine:nYear withmonth:nI*3+1 withdays:nK[nI*3] withfirstday:nFirstday[nI*3]] + 1;
                nK[nI*3+1] = [self printLine:nYear withmonth:nI*3+2 withdays:nK[nI*3+1] withfirstday:nFirstday[nI*3+1]] + 1;
                nK[nI*3+2] = [self printLine:nYear withmonth:nI*3+3 withdays:nK[nI*3+2] withfirstday:nFirstday[nI*3+2]] + 1;
            }
            else{
                bFlag[nI*3] = [self endofMonth:nYear withmonth:nI*3+1 withdays:nK[nI*3]-1];
                if (bFlag[nI*3]) {
                    printf("                      ");
                }
                else{
                    nK[nI*3] = [self printLine:nYear withmonth:nI*3+1 withdays:nK[nI*3] withfirstday:nFirstday[nI*3]];
                    nLastdayofMonth = (nFirstday[nI*3] + nK[nI*3] - 1) % 7;
                    while (nLastdayofMonth < 6) {
                        printf("   ");
                        nLastdayofMonth++;
                    }
                    nK[nI*3]++;
                }
                
                bFlag[nI*3+1] = [self endofMonth:nYear withmonth:nI*3+2 withdays:nK[nI*3+1]-1];
                if (bFlag[nI*3+1]) {
                    printf("                      ");
                }
                else {
                    nK[nI*3+1] = [self printLine:nYear withmonth:nI*3+2 withdays:nK[nI*3+1] withfirstday:nFirstday[nI*3+1]];
                    nLastdayofMonth = (nFirstday[nI*3+1] + nK[nI*3+1] - 1) % 7;
                    while (nLastdayofMonth < 6) {
                        printf("   ");
                        nLastdayofMonth++;
                    }
                    nK[nI*3+1]++;
                }
                
                bFlag[nI*3+2] = [self endofMonth:nYear withmonth:nI*3+3 withdays:nK[nI*3+2]-1];
                if (bFlag[nI*3+2]) {
                    printf("                      ");
                }
                else {
                    nK[nI*3+2] = [self printLine:nYear withmonth:nI*3+3 withdays:nK[nI*3+2] withfirstday:nFirstday[nI*3+2]];
                    nLastdayofMonth = (nFirstday[nI*3+2] + nK[nI*3+2] - 1) % 7;
                    while (nLastdayofMonth < 6) {
                        printf("   ");
                        nLastdayofMonth++;
                    }
                    nK[nI*3+2]++;
                }
            }
            printf("\n");
        }
    }
    
}

@end
