//
//  main.m
//  mycal
//
//  Created by 宇超 黄 on 13-10-7.
//  Copyright (c) 2013年 宇超 黄. All rights reserved.
//
#import "MyCal.h"

int main(int argc, const char * argv[])
{
    NSDate *now=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSDateComponents *comp=[[NSDateComponents alloc] init];
    NSInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    comp=[cal components:unitFlags fromDate:now];
    NSInteger year;
    NSInteger month;
    MyCal *mycal;
    mycal=[MyCal new];
    if(argc==1)
        printf("Error input.\n");
    else if(argc==2)
    {
        if(!strcmp(argv[1],"cal"))
        {
            year=[comp year];
            month=[comp month];
            [mycal setYear:year];
            [mycal setMonth:month];
            [mycal printMonth];
        }
        else
            printf("Error input.\n");
    }
    else if(argc==3)
    {
        int y=atoi(argv[2]);
        if(!strcmp(argv[1],"cal") && (y>=1 && y<=9999))
        {
            year=y;
            [mycal setYear:year];
            [mycal printYear];
        }
        else if(!(y>=1 && y<=9999))
        {
            printf("cal: year %d not in range 1..9999\n",y);
        }
        else
            printf("Error input.\n");
    }
    else if(argc==4)
    {
        if(strcmp(argv[2], "-m"))
        {
            int m=atoi(argv[2]);
            int y=atoi(argv[3]);
            if(!strcmp(argv[1],"cal") &&  (m>=1 && m<=12) && (y>=1 && y<=9999))
            {
                year=y;
                month=m;
                [mycal setYear:year];
                [mycal setMonth:month];
                [mycal printMonth];
            }else if (!(y>=1 && y<=9999))
            {
                printf("cal: year %d not in range 1..9999\n",y);
            }
            else if(!(m>=1 && m<=12))
            {
                printf("cal: %d is neither a month number (1..12) nor a name\n",m);
            }
            else
               printf("Error input.\n");
        }
        else{
            int m=atoi(argv[3]);
            NSInteger y=[comp year];
            year=y;
            if(!strcmp(argv[1],"cal") &&  (m>=1 && m<=12) && (y>=1 && y<=9999))
            {
                year=y;
                month=m;
                [mycal setYear:year];
                [mycal setMonth:month];
                [mycal printMonth];
            }else if (!(m>=1 && m<=12))
            {
                 printf("cal: %d is neither a month number (1..12) nor a name\n",m);
            }
        }
    }
    return 0;
}

