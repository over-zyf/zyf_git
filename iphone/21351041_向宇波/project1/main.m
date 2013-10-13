#import <Foundation/Foundation.h>
@interface Calenda : NSObject
{
@private
    int     mondat[2][12];
    NSString * week[7];
    NSString * months[12];
    NSMutableString * fill[8];
    NSMutableString * pad[8];//第一个是头，第二个是星期，后面是当月的日期
}
- (id) init;
- (BOOL) isLeapYear: (int) year;
- (int)	exchangeData: (int) year;
- (int) exchangeData: (int) year Month: (int) month;
- (void) Print;
- (void) Print: (int) year;
- (void) Print: (int) year Month: (int) month;
- (void) fillPad: (int) year Month: (int) month Title: (NSString *) title;
@end// Calenda

@implementation Calenda
- (id) init
{
    if(self = [super init])
    {
        mondat[0][0] = 31; mondat[0][1] = 28; mondat[0][2] = 31; mondat[0][3] = 30; mondat[0][4] = 31;
        mondat[0][5] = 30; mondat[0][6] = 31; mondat[0][7] = 31; mondat[0][8] = 30; mondat[0][9] = 31;
        mondat[0][10] = 30; mondat[0][11] = 31;
        mondat[1][0] = 31; mondat[1][1] = 29; mondat[1][2] = 31; mondat[1][3] = 30; mondat[1][4] = 31;
        mondat[1][5] = 30; mondat[1][6] = 31; mondat[1][7] = 31; mondat[1][8] = 30; mondat[1][9] = 31;
        mondat[1][10] = 30; mondat[1][11] = 31;
        months[0] = [NSString stringWithFormat:@"一月"]; months[1] = [NSString stringWithFormat:@"二月"];
        months[2] = [NSString stringWithFormat:@"三月"]; months[3] = [NSString stringWithFormat:@"四月"];
        months[4] = [NSString stringWithFormat:@"五月"]; months[5] = [NSString stringWithFormat:@"六月"];
        months[6] = [NSString stringWithFormat:@"七月"]; months[7] = [NSString stringWithFormat:@"八月"];
        months[8] = [NSString stringWithFormat:@"九月"]; months[9] = [NSString stringWithFormat:@"十月"];
        months[10] = [NSString stringWithFormat:@"十一月"]; months[11] = [NSString stringWithFormat:@"十二月"];
        week[0] = [NSString stringWithFormat:@"日"]; week[1] = [NSString stringWithFormat:@"一"];
        week[2] = [NSString stringWithFormat:@"二"]; week[3] = [NSString stringWithFormat:@"三"];
        week[4] = [NSString stringWithFormat:@"四"]; week[5] = [NSString stringWithFormat:@"五"];
        week[6] = [NSString stringWithFormat:@"六"];
        for(int i = 0; i < 8; i++)
        {
            fill[i] = [NSMutableString stringWithCapacity: 20];
            pad[i] = [NSMutableString stringWithCapacity: 60];
        }
    }
    return self;
}//init

- (BOOL) isLeapYear: (int) year
{
    if((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))
        return YES;
    else
        return NO;
}//isLeapYear

- (int) exchangeData: (int) year
{
    int     data = 0;
    for(int i = 0; i < year; i++)
    {
        if([self isLeapYear: i] == NO)
            data += 365;
        else
            data += 366;
    }
    return data;
}//exchangeData: (int) year

- (int) exchangeData: (int) year Month: (int) month
{
    int     data = [self exchangeData: year];
    BOOL    tag = [self isLeapYear: year];
    int     j = tag == NO ? 0 : 1;
    
    for(int i = 1; i < month; i++)
    {
        data += mondat[j][i - 1];
    }
    return data;
}//exchangeData: (int) year Month: (int) month

- (void) fillPad: (int) year Month: (int) month Title: (NSString*) title //固定只填充一个月的，标准是 8*20 的矩阵块
{
    int     i, j, k;
    BOOL    tag = [self isLeapYear: year];
    int     data = [self exchangeData: year Month: month] - [self exchangeData: 2013 Month: 9]; //2013年9月1号是星期日
    
    for(i = 0; i < 8; i++)
    {
        [fill[i] deleteCharactersInRange: NSMakeRange(0, [fill[i] length])];
    } //将 fill 矩阵块清空
    
    k = (20 - [title length]) / 2;
    for(i = 0; i < k - 1; i++)
    {
        [fill[0] appendString:@" "];
    }
    [fill[0] appendString: title]; //填充第零行的title(月份 或者 年份+月份
    
    for(i = 0; i < 7; i ++)
    {
        if(i == 0)
            [fill[1] appendFormat:@"%@", week[i]];
        else
            [fill[1] appendFormat:@" %@", week[i]];
    } //填充第一行的星期
    
    data = data >= 0 ? data % 7 : (data % 7 + 7) % 7;
    for(i = 0; i < data; i++)
    {
        if(i == 0)
            [fill[2] appendString:@"  "];
        else
            [fill[2] appendString:@"   "];
    } //填充第二行本月第一天非星期日开始的空格
    
    for(j = (tag == NO) ? 0 : 1, k = 2, i = 1; i <= mondat[j][month - 1]; i++)
    {
        if(data == 0)
            [fill[k] appendFormat:@"%2d", i];
        else
            [fill[k] appendFormat:@"%3d", i];
        data++;
        if((data %= 7) == 0) //判断是否到星期日换行
            k++;
    }
    
    for(i = 0; i < 8; i++)
    {
        if(i == 1)
            continue;
        k = [fill[i] length];
        if(i == 0)
        {
            if(month >= 11)
                k += 3;
            else
                k += 2;
        }
        for(; k < 20; k++)
        {
            [fill[i] appendFormat:@" "];
        }
    } // 将 8*20 的方块填充完全
}//fillPad: (int) year Month: (int) month

- (void) Print: (int) year Month: (int) month
{
    char  * ans;
    NSString * title = [NSString stringWithFormat:@"%@ %d", months[month - 1], year];
    
    [self fillPad: year Month: month Title: title];
    for(int i = 0; [fill[i] length] != 0; i++)
    {
        ans = [fill[i] UTF8String];
        printf("%s\n", ans);
    }
}//Print: (int) year Month: (int) month

- (void) Print: (int) year
{
    int 		i, j;
    char *  ans;
    NSMutableString * title;
    
    for(i = 0; i < 8; i++)
    {
        [pad[i] deleteCharactersInRange: NSMakeRange(0, [pad[j] length])];
    } //清空 pad 矩阵块
    
    printf("%34d\n", year); //输出年份
    printf("\n");
    for(i = 1; i <= 12; i++)
    {
        title = [NSString stringWithFormat:@"%@", months[i - 1]]; //构建月份title
        [self fillPad: year Month: i Title: title]; //构建 fill 矩阵块
        for(j = 0; j < 8; j++)
        {
            [pad[j] appendFormat: @"%@  ",fill[j]];
        } //将 fill 连续的横接在 pad 后面
        
        if(i % 3 == 0)
        {
            for(j = 0; j < 8; j++)
            {
                ans = [pad[j] UTF8String];
                printf("%s\n", ans);
                [pad[j] deleteCharactersInRange: NSMakeRange(0, [pad[j] length])];
            }
        } //每三个月份并排输出一次，然后清空 pad
    }
}//Print: (int) year

- (void) Print
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    NSInteger month= [components month];
    int m = month;
    NSInteger year= [components year];
    int y = year;
    
    [self Print: y Month: m];
}//Print
@end

int toNum(char a[])
{
    int     ans, tag, pos;

    if(a[0] == '-')
    {
        tag = -1;
        pos = 1;
    }
    else if('0' <= a[0] && a[0] <= '9')
    {
        tag = 1;
        pos = 0;
    }
    else
        return 0;
    ans = 0;
    for(int i = pos; a[i] != '\0'; i++)
    {
        ans *= 10;
        ans += a[i] - '0';
    }
    return ans * tag;
}

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        Calenda *  cal;
        cal = [Calenda new];
        int     year, month;
        
        if(argc == 1)
        {
            [cal Print];
        }
        else if(argc == 2)
        {
            year = toNum(argv[1]);
            if(year <= 0 || year > 9999)
            {
                printf("cal: year %d not in range 1..9999\n", year);
                return 0;
            }
            [cal Print: year];
        }
        else
        {
            year = toNum(argv[1]);
            if(year <= 0 || year > 9999)
            {
                printf("cal: year %d not in range 1..9999\n", year);
                return 0;
            }
            month = toNum(argv[2]);
            if(month < 1 || month > 12)
            {
                printf("cal: month %d not in range 1..12\n", month);
                return 0;
            }
            [cal Print: year Month: month];
        }
    }
    return 0;
}