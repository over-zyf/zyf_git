//
//  Calendar.m
//  calendar
//
//  Created by 唐斌斌 on 13-10-9.
//  Copyright (c) 2013年 唐斌斌. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

@synthesize year;
@synthesize isRunNian;

-(id)initWithYear:(int) _year
{
    Chmonth[0] = "一月";
    Chmonth[1] = "二月";
    Chmonth[2] = "三月";
    Chmonth[3] = "四月";
    Chmonth[4] = "五月";
    Chmonth[5] = "六月";
    Chmonth[6] = "七月";
    Chmonth[7] = "八月";
    Chmonth[8] = "九月";
    Chmonth[9] = "十月";
    Chmonth[10] = "十一月";
    Chmonth[11] = "十二月";
    Chweek[0] = "日"; Chweek[1] = "一"; Chweek[2] = "二"; Chweek[3] = "三"; Chweek[4] = "四"; Chweek[5] = "五"; Chweek[6] = "六";
    
    self.year = _year;
    if(((_year%4==0)&&(_year%100!=0)) ||(_year%400==0) )
        self.isRunNian = true;
    else
        self.isRunNian = false;
    
    return self;
}
// get the everyday'info of year
-(void)caltable
{
    memset(yeartable, 0, sizeof(yeartable));
    
    for(int i=1; i<=12; i++)
    {
        int totaldayOfMonth = [self DayOfMonth:i];
        //w1 is the week of first day
        int w1 = [self WeekOfDay:self.year andmonth:i andday:1];
        
        for(int j=1; j<=totaldayOfMonth; j++)
        {
            int w = [self WeekOfDay:self.year andmonth:i andday:j];
            int line = (j+w1-1)/7;
            yeartable[i][line][w] = j;
        }
    }
         
}

-(void)showWeek
{
    for(int i=0; i<7; i++)
    {
        printf("%s ",Chweek[i]);
    }
    printf(" ");
}
-(void)ShowYear
{
 
    [self caltable];
    //NSLog(@"%d",self.year);
    //yeartable----month, line, week
    //-----------display-----
    printf("                                 %d\n\n",self.year);
    for(int ll = 0; ll<4; ll++)
    {
        for(int j=1; j<=3; j++)
        {    
            printf("         %s         ",Chmonth[j+ll*3-1]);
            
        }
        printf("\n");
        for(int j=1; j<=3; j++)
        {
            [self showWeek];
        }
        printf("\n");
        for(int j=0; j<6; j++)
        {
            for(int i=1; i<=3; i++)
            {
             int mm = i +ll*3;
            
                for(int k=0; k<7; k++)
                {
                    if(yeartable[mm][j][k] ==0)
                    {
                        printf("   "); continue;
                    }
                    else
                        printf("%2d ",yeartable[mm][j][k]);
                    
                }
                printf(" ");
               
            }
         printf("\n");
        }
    }
    //printf("\n");
    /* test
    for(int i=0; i<6; i++)
    {
        for(int j=0; j<6; j++)
        {
         printf("%2d ",yeartable[1][i][j]);
            
        }
        printf("\n");
    }
    */
    
}

-(void)ShowMonth:(int) Month
{
    
     printf("   %s %d\n",Chmonth[Month-1],self.year);
    [self caltable];
    [self showWeek];
    printf("\n");
    for(int i=0; i<6; i++)
    {
        for(int j=0; j<7; j++)
        {
            if(yeartable[Month][i][j] ==0)
            {
                printf("   "); continue;
            }
            else
                printf("%2d ",yeartable[Month][i][j]);
        }
        printf("\n");
    }
    
}

-(void)ShowNowMonth:(int)Month
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:date];
    int m = [comps month];
    int y = [comps year];
    
    if(self.year == -1)
    {
        self.year = y;
    }
    if(Month != -1)
    {
        m = Month;
    }
    [self ShowMonth:m];
   
}

//return 1~6 for mon~sat  0 is for sun
-(int)WeekOfDay:(int)_year andmonth:(int)_month andday:(int)_day
{
    
    int week;
   // NSLog(@"%d %d %d",_year,_month,_day);
    
    if(_month!=-1 && _month!=-1)
    {
        if (_month==1 || _month==2)
        {
            _month = _month + 12;
            _year--;
        }
        //基姆拉尔森计算公式
        week=(_day+2*_month+3*(_month+1)/5+_year+_year/4-_year/100+_year/400)%7+1;
        week = week%7;
    }
   // NSLog(@"%d==",week);
    return week;
}

-(int)DayOfMonth:(int)month
{
    if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
    {
        return 31;
    }
    
    if(month == 2)
    {
        if(self.isRunNian)
            return 29;
        else
            return 28;
    }
    else
        return 30;
}

@end

