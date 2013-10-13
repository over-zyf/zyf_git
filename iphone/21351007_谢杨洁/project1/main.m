//
//  main.m
//  project1
//
//  Created by xyj on 13-10-11.
//  Copyright (c) 2013年 xyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCalendar.h"
#import "CmdAnalyzer.h"

int nMonthDay[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};


void printWeekDay()
{
    printf("\t日\t一\t二\t三\t四\t五\t六");
}

/*********************************************
 
 打印指定指令的日历
 先将日历保存，再逐一打印
 *********************************************/
void printCmdCal(int nYear, int nMonth)
{

    if((nYear%4==0 && nYear%100) || (nYear%400==0))
        nMonthDay[2] = 29;
    else
        nMonthDay[2] = 28;
    
    int nWeekDay ;
    
    if(nMonth)//cal xx xx
    {
        MyCalendar *pCal = [[MyCalendar alloc]init: nYear AndMonth: nMonth];
        nWeekDay = [pCal getWeekOfFirstDay];
       
        printf("\t\t\t%d月 %d\n",nMonth,nYear);
        printWeekDay();
        printf("\n");
        
        for(int i=0; i<nWeekDay%7; i++)
            printf("\t");
        for(int i=1; i<=nMonthDay[nMonth]; i++)
        {
            if(nYear == 1752 && nMonth == 9 && i== 3)
                i = 14;
            printf("\t%d",i);
            nWeekDay = (nWeekDay + 1)%7 ;
            if(nWeekDay == 0)printf("\n");
        }
        if(nWeekDay != 0)printf("\n");
    }
    else//cal xx
    {
        int nYearCal[13][3]={0};
        for(int i = 1;i <= 12; i++)
        {
            MyCalendar *pCal = [[MyCalendar alloc]init: nYear AndMonth: i];
            [pCal GetMonthCal: nYearCal[i] ];
        }
        for(int i=0;i<4;i++)
        {
            for(int j=0;j<3;j++)
            {
                printf("\t\t\t\t%d月\t\t\t\t",i*3+j+1);
            }
            printf("\n");
            for(int j=0;j<3;j++)
            {
                printWeekDay();
                printf("\t");
            }
            printf("\n");
            
            for(int nIndex = 0,j=0;nIndex<35 ;nIndex++)
            {
                if(nIndex%7==0 && j)printf("\t");
                
                int nShowMonth =i*3 + j + 1;
                if(nIndex >= nYearCal[nShowMonth][0] && nIndex-nYearCal[nShowMonth][0] < nYearCal[nShowMonth][1])
                    printf("\t%d",nIndex - nYearCal[nShowMonth][0] +1);
                else printf("\t");
                
                if(nIndex%7 == 6)nIndex -= 7, j++;
                if(j==3) j=0, nIndex +=7, printf("\n");
                if(nIndex == 35) break;
            }
            printf("\n");
        }
    }
}
int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        char strCmd[100];
        int nCmdYear, nCmdMonth;
        while ( gets(strCmd)) {
            CmdAnalyzer *pCmd = [[CmdAnalyzer alloc]init: strCmd];
            [pCmd change2NormalCmd];
            
            if(![pCmd getYearAndMonth:&nCmdYear AndMonth: &nCmdMonth])
                NSLog(@"WRONG COMMAND");
            else
                printCmdCal(nCmdYear, nCmdMonth);
        }
        //NSLog(@"Hello, World!");
        
    }
    return 0;
}

