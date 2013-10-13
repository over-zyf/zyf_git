//
//  main.m
//  MyCal
//
//  Created by jasonross on 13-9-26.
//  Copyright (c) 2013年 jasonross.me All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCal.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool 
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];            
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;            
        NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
        int iCurYear = [components year];  //当前的年份
        int iCurMonth = [components month];  //当前的月份
        if(argc==1)
        {
            [MyCal printOfMonth:iCurMonth ofYear:iCurYear ] ;           
        }
        else 
        {
            if(argc==2)
            {
                int year=atoi(argv[1]);
                if(year<1||year>9999)
                {
                    printf("您输入的年份不在1到9999之间\n");
                }
                else
                {
                    /*for(int i=1;i<=12;i++)
                    {
                        [MyCal printOfMonth:i ofYear:year ] ;           
                    }*/
                    [MyCal printofYear:year];
                }
            }
            else
            {
                if(argc==3)
                {
                    if(strcmp(argv[1],"-m")==0)
                    {
                        int month=atoi(argv[2]);
                        if(month<1||month>12)
                        {
                            printf("您输入的月份不在1到12之间\n");
                            return -1;
                        }  
                        [MyCal printOfMonth:month ofYear:iCurYear] ;     
                    }
                    else 
                    {
                        int month=atoi(argv[1]);
                        int year=atoi(argv[2]);
                        if(month<1||month>12)
                        {
                            printf("您输入的月份不在1到12之间\n");
                            return -1;
                        }  
                        if(year<1||year>9999)
                        {
                            printf("您输入的年份不在1到9999之间\n");
                            return -1;
                        }
                        [MyCal printOfMonth:month ofYear:year ] ;  
                    }
                       
                    
                }
                else
                {
                    printf("使用方法:Mycal [month] [year] ;Mycal -m month\n举例如下:\n  Mycal:输出当前月份日历 \n  Mycal 2013:输出2013年所有月份日历\n  Mycal 9 2013:输出2013年9月日历\n  Mycal -m 9:输出当年9月日历\n");
                }
            }

        }               
    }
    return 0;
}
