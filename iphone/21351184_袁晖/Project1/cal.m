#import "cal.h"
@implementation Calendar
-(void) displayUsage
{
    printf("Usage:cal [-m] [[month] year]\n");
    printf("      where month should between 1 and 12\n");
    printf("      and year should greatter then 1\n");
}

-(void) displayCalendarFromYear:(int)startYear andMonth:(int)startMonth toYear:(int)endYear andMonth:(int)endMonth
{
    int daysOfMonth[12+1]= {0,31,28,31,30,31,30,31,31,30,31,30,31};
    //使用蔡勒公式计算第一个月第一天是星期几
    int tempYear=startYear,m=startMonth;
    if (m<=2) --tempYear,m+=12;
    int c=tempYear/100,y=tempYear%100,d=1,weekday;
    if (startYear<=1572&&startMonth<=10)//1582年10月4日或之前
    {
        weekday=(y+y/4+c/4-2*c+26*(m+1)/10+d-1+7)%7;
    }
    else//1582年10月4日之后
    {
        weekday=(c/4-2*c+y+y/4+13*(m+1)/5+d-1+7)%7;
    }
    for (int nowYear=startYear; nowYear<=endYear; ++nowYear)
    {
        for (int nowMonth=(nowYear==startYear?startMonth:1); nowMonth<=(nowYear==endYear?endMonth:12); ++nowMonth)
        {
            //显示表头
            printf("Year:%d  Month:%d\n",nowYear,nowMonth);
            printf("Su Mo Tu We Th Fr Sa\n");
            //根据是否闰年判断是否需要2月份改变天数
            daysOfMonth[2]=(((nowYear%400==0)||(nowYear%4==0&&nowYear%100!=0))?29:28);
            //显示月历内容
            for (int space=0; space<weekday; ++space) printf("   ");
            for (int day=1; day<=daysOfMonth[nowMonth]; ++day)
            {
                printf("%2d ",day);
                if (weekday==6) printf("\n");
                ++weekday;
                weekday%=7;
            }
            printf("\n");
            printf("\n");
        }
    }
}

int main(int argc,const char * argv[])
{
    BOOL displayOneMonth=NO;
    if (!(1<=argc&&argc<=4))
    {
        [Calendar displayUsage];
        return -1;
    }
    int currentArgCount;
    for (currentArgCount=1; currentArgCount<argc&&argv[currentArgCount][0]=='-'; ++currentArgCount)
    {
        if (argv[currentArgCount][1]=='m')//cal -m ...
        {
            displayOneMonth=YES;
        }
        else
        {
            [Calendar displayUsage];
            return -1;
        }
    }
    //获取当前年份、月份
    NSDate *now=[NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
                          NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [calendar components:unitFlags fromDate:now];
    int currentYear=[comps year],currentMonth=[comps month]+1;
    
    if (argc-currentArgCount==0)//cal
    {
        [Calendar displayCalendarFromYear:currentYear andMonth:currentMonth toYear:currentYear andMonth:currentMonth];
    }
    else if (argc-currentArgCount==1)//cal month or year
    {
        if (displayOneMonth)
        {
            int inputMonth=atoi(argv[currentArgCount]);
            if (!(1<=inputMonth&&inputMonth<=12))//月份不对
            {
                [Calendar displayUsage];
                return -1;
            }
            [Calendar displayCalendarFromYear:currentYear andMonth:inputMonth toYear:currentYear andMonth:inputMonth];
        }
        else
        {
            int inputYear=atoi(argv[currentArgCount]);
            if (inputYear==0)//atoi转换失败
            {
                [Calendar displayUsage];
                return -1;
            }
            [Calendar displayCalendarFromYear:inputYear andMonth:1 toYear:inputYear andMonth:12];
        }
    }
    else if (argc-currentArgCount==2)//cal month year
    {
        int inputMonth=atoi(argv[currentArgCount]);
        int inputYear=atoi(argv[currentArgCount+1]);
        if (!(1<=inputMonth&&inputMonth<=12)||(inputYear==0))//月份不对或atoi转换失败
        {
            [Calendar displayUsage];
            return -1;
        }
        [Calendar displayCalendarFromYear:inputYear andMonth:inputMonth toYear:inputYear andMonth:inputMonth];
    }
    else
    {
        [Calendar displayUsage];
        return -1;
    }
    return 0;
}
@end
