//
//  main.m
//  Calender
//
//  Created by guest on 13-9-28.
//  Copyright (c) 2013年 guest. All rights reserved.
//

#import <Foundation/Foundation.h>
//#include <stdio.h>
#import "CalenderClass.h"
int monthd[12]={31,28,31,30,31,30,31,31,30,31,30,31};
char *moname[12]={"January","February","March","April","May","June","July","August","September","October","November","December"};
int main(int argc, const char * argv[])
{
        CalenderClass *cal=[[CalenderClass alloc] init];
        if (argc>1) {
            int yi,mi,day;
            yi=1000*(argv[1][0]-'0')+100*(argv[1][1]-'0')+10*(argv[1][2]-'0')+(argv[1][3]-'0');
            if(yi<1970||yi>2050)
            {
                printf("Error Year\n");
                return 0;
            }
            cal.year=yi;
            if (strlen(argv[1])-4>0) {
                mi=10*(argv[1][4]-'0')+(argv[1][5]-'0');
                if(mi>12||mi<=0)
                {
                    printf("Error Month\n");
                    return 0;
                }
                cal.month=mi;
                if (strlen(argv[1])-6>0&&(strlen(argv[1])<9)) {
                    day=10*(argv[1][6]-'0')+(argv[1][7]-'0');
                    int t=0;
                    if((yi%4==0&&yi%100!=0)||yi%400==0)
                        t++;
                    if(day>(monthd[mi-1]+t))
                    {
                        printf("Error Day\n");
                        return 0;
                    }
                }
                else if(strlen(argv[1])>=9)
                {
                    printf("Error Day\n");
                    return 0;
                }
            [cal printcal:[cal returnfistdayweak]];
            }
            else
            {
                for (int i=1; i<12; ) {
                    cal.month=i;
                    [cal printfcalforyear];
                    i+=3;
                }
            }
        }
        else
        {
            [cal printcal:[cal returnfistdayweak]];
        }
    [cal release];

    return 0;
}

