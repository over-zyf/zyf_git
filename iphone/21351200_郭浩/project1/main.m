//
//  main.m
//  cal OC2
//
//  Created by apple on 13-10-9.
//  Copyright (c) 2013年 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mycal.h"


int main (int argc, const char * argv[])
{
    Mycal *weekdays1 =[[Mycal alloc]init];
  
    int i = 0,j,k,l,m,year;
    NSLog(@"请输入年份:");
    scanf("%d",&year);
    char month[12][10]={"January","February","March","April","May","June","July","August","September","October","November","December"};
    [weekdays1 setYear:year];
    [weekdays1 getWeekdays];
    l=[weekdays1 weekdays];
    // [days1 setDays:days];
    // [days1 getDays];
    // m=[days1 days];
    //  m=[weekdays1 getDays:<#(int)#>];
    NSLog(@"%d",l);
    for(i=0;i<12;i++)
    {
        m=[weekdays1 getDays:i+1];
        printf("\n%s %d\n",month[i],year);
        printf("Sun Mon Tue Wed Thu Fri Sat\n");
        for(k=0;k<l;k++) printf("    ");
        
        for(j=1;j<=m;j++)
        {
            printf("%3d ",j);
            if(++l>=7)
            {
                printf("\n");
                l=l%7;
            }
        }
        printf("\n");
    }
    return (0);
}

