

#import <Foundation/Foundation.h>


static int daysInMonth_leap[12]={31,29,31,30,31,30,31,31,30,31,30,31};
static int daysInMonth_noLeap[12]={31,28,31,30,31,30,31,31,30,31,30,31};

int get_weekday(int year,int month);
void printCalerdar(int year,int month,int weekday);
bool is_leapyear(int year);
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        int year=0,month=0;
        if (argc==1) {
            
        NSDate *today = [NSDate date];
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        NSDateComponents *now=[currentCalendar components:( NSMonthCalendarUnit |NSYearCalendarUnit) fromDate:today];
        year=(int)[now year];
        month=(int)[now  month];
        [now setDay:1];//将now设定成本月的1号
        NSDate *targetDate=[currentCalendar dateFromComponents:now];
        NSDateComponents *targetCom=[currentCalendar components:( NSMonthCalendarUnit |NSYearCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit) fromDate:targetDate];
        int  weekday=(int)[targetCom weekday];
        printCalerdar(year,month,weekday);
        }else if (argc==2)
        {
           NSString *target_year=[[NSString alloc] initWithUTF8String:argv[1]];
            int year=[target_year intValue];
            for (int i=1; i<=12; i++) {
                printCalerdar(year, i, get_weekday(year, i));
            }
        }
        else if(argc==3)
        {
            NSString *target_year=[[NSString alloc] initWithUTF8String:argv[2]];
            NSString *target_month=[[NSString alloc] initWithUTF8String:argv[1]];
            int year=(int)[target_year intValue];
            int month=(int)[target_month intValue];
            printCalerdar(year, month, get_weekday(year, month));
        }
        else
        {
            NSLog(@"参数不正确！");
        }
    }
    return 0;
}
int get_weekday(int year,int month)
{
    NSDate *today = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *now=[currentCalendar components:( NSMonthCalendarUnit |NSYearCalendarUnit) fromDate:today];
    [now setYear:year];
    [now setMonth:month];
    [now setDay:1];//将now设定成本月的1号
    NSDate *targetDate=[currentCalendar dateFromComponents:now];
    NSDateComponents *targetCom=[currentCalendar components:( NSMonthCalendarUnit |NSYearCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit) fromDate:targetDate];
    return  (int)[targetCom weekday];
}

bool is_leapyear(int year)
{
 
    bool is_leap=NO;
    if (year<1752) {
        if (year%4==0) {
            is_leap=YES;
        }
    }else
    {
        if((year%4==0 && year%100!=0)||year%400==0)
            is_leap=YES;
    }
    return is_leap;
    
}
void printCalerdar(int year,int month,int weekday)
{
    
    
    printf("       %d月 %d\n",month,year);
    printf("日 一 二 三 四 五 六\n");
    int i=0,flag=0,count=1,end=0;
    bool leap=is_leapyear(year);
    int scop=leap?daysInMonth_leap[month-1]:daysInMonth_noLeap[month-1];
    //int scop;
    if(year==1752 && month==9)
    {
        printf("       1  2 14 15 16\n");
        printf("17 18 19 20 21 22 23\n");
        printf("24 25 26 27 28 29 30\n");
        return;
    }
    while (end==0) {
        for (i=1; i<=7; i++) {
            if (flag==0) {
                if(weekday==i)
                {
                    printf("%2d ",count++);
                    flag=1;
                }
                else{printf("   ");}
                
            }
            else {
                printf("%2d ",count++);
                
                if (count-1>=scop) {
                    end=1;
                    break;
                }
            }
        }
        printf("\n");
    }
}
