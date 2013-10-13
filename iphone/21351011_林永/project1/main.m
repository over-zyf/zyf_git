//
//  main.m
//  Calendar
//
//  Created by LinYong on 13-10-9.
//  Copyright (c) 2013年 LinYong. All rights reserved.
//

#import <Foundation/Foundation.h>

//蔡勒公式，根据年月日，计算星期,1582.10.4之后的计算代码
NSUInteger zeller(NSUInteger year, NSUInteger month, NSUInteger day)
{
    NSInteger week;
    if(month==1||month==2)//判断month是否为1或2
    {
        year--;
        month+=12;
    }
    NSInteger c=year/100;
    NSInteger y=year-c*100;
    
    if (year < 1582 && month < 10 && day <= 4) {
        week = year + (y/4) + (c/4) - 2*c + 13*(month+1)/5 + day + 2;
    }
    else
        week = (c/4)-2*c+(y+y/4)+(13*(month+1)/5)+day-1;
    while(week < 0){
        week+=7;
    }
    week%=7;
    return week;
}
//计算该月有多少天
NSUInteger daysOfMonth(NSUInteger year, NSUInteger mon)
{
    NSUInteger days = 0;
    if(mon == 1 || mon == 3 || mon == 5 || mon == 7 ||mon == 8 || mon == 10 ||mon == 12){
        days = 31;
    }
    else if(mon == 2){
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            days = 29;
        }
        else
            days = 28;
    }
    else
        days = 30;
    
    return days;
}
//把数字月份转成汉字
NSString *numberToChineseMonth(NSUInteger month)
{
    NSString *monS;
    switch (month) {
        case 1:
            monS = @"一月";
            break;
        case 2:
            monS = @"二月";
            break;
        case 3:
            monS = @"三月";
            break;
        case 4:
            monS = @"四月";
            break;
        case 5:
            monS = @"五月";
            break;
        case 6:
            monS = @"六月";
            break;
        case 7:
            monS = @"七月";
            break;
        case 8:
            monS = @"八月";
            break;
        case 9:
            monS = @"九月";
            break;
        case 10:
            monS = @"十月";
            break;
        case 11:
            monS = @"十一月";
            break;
        case 12:
            monS = @"十二月";
            break;
        default:
            break;
    }

    return monS;
}

char *numberToChinese(NSUInteger month)
{
    char *monS = NULL;
    switch (month) {
        case 1:
            monS = "一";
            break;
        case 2:
            monS = "二";
            break;
        case 3:
            monS = "三";
            break;
        case 4:
            monS = "四";
            break;
        case 5:
            monS = "五";
            break;
        case 6:
            monS = "六";
            break;
        case 7:
            monS = "七";
            break;
        case 8:
            monS = "八";
            break;
        case 9:
            monS = "九";
            break;
        case 10:
            monS = "十";
            break;
        case 11:
            monS = "十一";
            break;
        case 12:
            monS = "十二";
            break;
        default:
            break;
    }
    
    return monS;
}

NSUInteger thisYear(){
    //解决相差八个小时问题，准确获取当前时间
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    //NSLog(@"\nlocalDate%@", localeDate);
    
    //分别获取年份，月份，日期，
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //实例化一个NSCalendar对象
    NSDateComponents *comps = [[NSDateComponents alloc] init]; //实例化一个NSDateComponents对象
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit;//二进制的日期元素
    comps = [calendar components:unitFlags fromDate:localeDate]; //调用components方法，返回NSDateComponents对象
    //NSInteger hour = [comps hour]; //获取小时存到hour里
    NSInteger year = [comps year]; //获取年份存到year里
    //NSInteger month = [comps month]; //获取月份存到month里
    //NSInteger day = [comps day]; //获取天数存到day里
    
    return year;
}

NSUInteger thisMonth(){
    //解决相差八个小时问题，准确获取当前时间
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    //NSLog(@"\nlocalDate%@", localeDate);
    
    //分别获取年份，月份，日期，
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //实例化一个NSCalendar对象
    NSDateComponents *comps = [[NSDateComponents alloc] init]; //实例化一个NSDateComponents对象
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit;//二进制的日期元素
    comps = [calendar components:unitFlags fromDate:localeDate]; //调用components方法，返回NSDateComponents对象
    //NSInteger hour = [comps hour]; //获取小时存到hour里
    //NSInteger year = [comps year]; //获取年份存到year里
    NSInteger month = [comps month]; //获取月份存到month里
    //NSInteger day = [comps day]; //获取天数存到day里
    
    return month;

}

//根据某个月第一天的星期以及该月的天数输出日历
void printCalendarAccordingFirstWeekAndDays(NSUInteger week, NSUInteger days)
{
    NSUInteger firstRowCount = 7 - week;
    for (int i = 0; i < week; i ++) {
        printf("   ");//首先输出第一行前面的空格，每次循环输出三个空格
    }
    
    NSUInteger d, rowEnd = firstRowCount;

    NSUInteger lastRowEnd = 0;
    while (rowEnd <= days) {
        if (rowEnd == firstRowCount) {//输出第一行
            for (d = 1; d < rowEnd; d ++) {//首先输出第一行除最后一个数值
                if (d < 10) {//如果数值小于10
                    printf(" %lu ", d);
                }
                else{//如果数值大于等于10
                    printf("%lu ", d);
                }
            }//输出第一行最后一个数值
            if (d < 10){
                printf(" %lu ", d);
            }
            else{
                printf("%lu ", d);
            }
            printf("\n");//换行
        }
        else{//输出非第一行日历
            for (d = lastRowEnd + 1; d < rowEnd; d ++) {
                if (d < 10) {//如果数值小于10
                    printf(" %lu ", d);
                }
                else{//如果数值大于等于10
                    printf("%lu ", d);
                }
            }
            if (d < 10){//输出该行最后一个数值
                printf(" %lu ", d);
            }
            else{
                printf("%lu ", d);
            }
            printf("\n");//换行
        }
        lastRowEnd = rowEnd;
        rowEnd = rowEnd + 7;
    }
    
    //输出剩余的天数，即最后一行的日历
    if (lastRowEnd < days) {
        for (d = lastRowEnd + 1; d < days; d ++) {
            if (d < 10) {//如果数值小于10
                printf(" %lu ", d);
            }
            else{//如果数值大于等于10
                printf("%lu ", d);
            }
        }
        if (d < 10){//输出该行最后一个数值
            printf(" %lu ", d);
        }
        else{
            printf("%lu ", d);
        }
        printf("\n");
    }

}

//输出现在的月份日历
void printThisMonthCal()
{
    NSUInteger year = thisYear(); //获取年份存到year里
    NSUInteger month = thisMonth(); //获取月份存到month里
    NSString *monS = numberToChineseMonth(month);//把数字月份转换成中文月份
    NSUInteger firstDayWeek = zeller(year, month, 1);//根据zeller()函数得到这个月第一天的星期
    NSUInteger days = daysOfMonth(year, month);//得到该年这个月的天数
    
    NSLog(@"\n     %@ %ld\n日 一 二 三 四 五 六",monS, (long)year);
    //根据firstDayWeek和days数值，按照固定格式打印出日历
    printCalendarAccordingFirstWeekAndDays(firstDayWeek, days);
}

//输出当前输入年份的所以月份的日历
void printAllMonthOfGivenYear(NSUInteger year)
{
    //比较复杂
    //建立7*12的整型数组，存储12个月的信息，第一行存储每个月的第一天的星期，第二行存储每个月的总天数，接下来每行分别是日历上第二，三，四，五，六行的起始日期
    NSUInteger inf[7][12];

    for (int i = 0; i < 12; i++) {
        inf[0][i] = zeller(year, i+1 , 1);//起始星期
        inf[1][i] = daysOfMonth(year, i+1);//总天数
        NSUInteger firstRowEnd = 7 - inf[0][i];
        inf[2][i] = firstRowEnd + 1;//日历上第二行起始日期

        inf[3][i] = inf[2][i] + 7;//日历上第三行起始日期
        inf[4][i] = inf[3][i] + 7;//日历上第四行起始日期
        
        if (inf[4][i] + 7 <= inf[1][i]) {
            inf[5][i] = inf[4][i] + 7;//日历上第五行起始日期
            if (inf[5][i] + 7 <= inf[1][i]) {
                inf[6][i] = inf[5][i] + 7;//日历上第六行起始日期，日历上不可能会有第七行
            }
            else{
                inf[6][i] = 0;
            }
        }
        else{
            inf[5][i] = 0;//日历上第五行起始日期
            inf[6][i] = 0;//日历上第六行起始日期
        }
    }
/*
    for (int i = 0 ; i < 7; i ++) {
        for (int j =0; j < 12; j ++) {
            printf("%lu   ", inf[i][j]);
        }
        printf("\n");
    }
*/
    //输出年份
    printf("\n                               %lu\n", year);
    printf("\n");
    NSUInteger bigRow, bigColumn, i, j ,d;
    for (bigRow = 0; bigRow < 4; bigRow ++) {
        for (bigColumn = 0; bigColumn < 3; bigColumn ++) {//首先输出首行月份信息
            if (bigRow * 3 + bigColumn +1 <= 10) {
                printf("        %s月          ", numberToChinese(bigRow * 3 + bigColumn +1));
            }
            else
                printf("        %s月        ", numberToChinese(bigRow * 3 + bigColumn +1));
            
        }
        printf("\n");
        
        //输出星期部分
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        
        //输出日历部分
        //显示第一行
        for (i = bigRow * 3; i < bigRow * 3 + 3; i ++) {
            for (j = 0; j < inf[0][i]; j ++) {//输出第一行最前面的空格
                printf("   ");
            }
            for (d = 1; d < inf[2][i] - 1; d ++) {//输出除每月第一行最后一个日期的日历
                if (d < 10) {//考虑到空格问题，针对1-9（单字符），以及10-31（双字符）的不同输出情况
                    printf(" %lu ", d);
                }
                else
                    printf("%lu ", d);
            }
            if (inf[2][i] - 1 < 10) {//输出每月第一行最后一个日期
                printf(" %lu", inf[2][i] - 1);
            }
            else
                printf("%lu", inf[2][i] - 1);
            
            printf("  ");
        }//end of for
        
        printf("\n");
        
        //显示第二行
        for (i = bigRow * 3; i < bigRow * 3 + 3; i ++) {
            for (d = inf[2][i]; d < inf[3][i] -1; d ++) {
                if (d < 10) {
                    printf(" %lu ", (unsigned long)d);
                }
                else
                    printf("%lu ", (unsigned long)d);
            }
            if (inf[3][i] -1 < 10) {
                printf(" %lu", inf[3][i] -1);
            }
            else
                printf("%lu", inf[3][i] -1);
            
            printf("  ");
        }
        
        printf("\n");
        
        //显示第三行
        for (i = bigRow * 3; i < bigRow * 3 + 3; i ++) {
            for (d = inf[3][i]; d < inf[4][i] -1; d ++) {
                if (d < 10) {
                    printf(" %lu ", (unsigned long)d);
                }
                else
                    printf("%lu ", (unsigned long)d);
            }
            if (inf[4][i] -1 < 10) {
                printf(" %lu", inf[4][i] -1);
            }
            else
                printf("%lu", inf[4][i] -1);
            
            printf("  ");
        }
        
        printf("\n");

        //显示第四行
        for (i = bigRow * 3; i < bigRow * 3 + 3; i ++) {
            if (inf[5][i] == 0) {//如果只有四行，那么只能是28天的情况，则输出到月末
                for (d = inf[4][i]; d < inf[1][i]; d ++) {
                    printf("%lu ", (unsigned long)d);
                }
                printf("%lu", inf[1][i]);
            }
            
            else{//如果不止四行
                for (d = inf[4][i]; d < inf[5][i] - 1; d ++) {
                    printf("%lu ", d);
                }
                printf("%lu", inf[5][i] - 1);
            }
            
            printf("  ");
        }
        
        printf("\n");

        //显示第五行
        for (i = bigRow * 3; i < bigRow * 3 + 3; i ++) {
            if (inf[5][i] == 0) {//如果第五行为空，则输出20个空格
                printf("                    ");
            }
            else{//第五行不为空
                if (inf[6][i] == 0) {//再判断第六行是否为空,如果第六行为空，则第五行输出剩余天数，还需注意后面是否需要输出空格
                    if (i < 11) {//再1-11月份中
                        if (inf[0][i + 1] == 0) {//下个月初为星期日
                            for (d = inf[5][i]; d < inf[1][i]; d ++) {
                                printf("%lu ", d);
                            }
                            printf("%lu", inf[1][i]);
                        }
                        else{//下个月初不为星期日，则要注意输出后面的空格
                            for (d = inf[5][i]; d <= inf[1][i]; d ++) {
                                printf("%lu ", d);
                            }
                            //输出空格
                            for (NSUInteger las = 7 - inf[0][i + 1]; las > 1 ; las --) {
                                printf("   ");
                            }
                            printf("  ");
                        }
                    }
                    else{
                        for (d = inf[5][i]; d <= inf[1][i]; d ++) {
                            printf("%lu ", d);
                        }
                    }
                }
                else{//如果第六行不为空
                    for (d = inf[5][i]; d < inf[6][i] -1; d ++) {
                        printf("%lu ", d);
                    }
                    printf("%lu", inf[6][i] -1);
                }
            }
            printf("  ");
        }
        
        printf("\n");
        

        //输出第六行
        for (i = bigRow * 3; i < bigRow * 3 + 3; i ++) {
            if (inf[6][i] == 0) {//如果第六行为空
                printf("                    ");
            }
            
            else {//第六行不为空
                if (i < 11) {//再1-11月份中
                    for (d = inf[6][i]; d <= inf[1][i]; d ++) {//输出日期
                        printf("%lu ", d);
                    }
                    //输出空格
                    for (NSUInteger las = 7 - inf[0][i + 1]; las > 1; las --) {
                        printf("   ");
                    }
                    printf("  ");
                }
                else{//输出12月份最后一行日历
                    for (d = inf[6][i]; d <= inf[1][i]; d ++) {
                        printf("%lu ", d);
                    }
                }
            }
            
            printf("  ");
        }//end of for
 
        printf("\n");

        
    }//end of for
    
    
}

//输出当年所输入月份的日历
void printGivenMonthOfThisYear(NSUInteger month)
{
    NSUInteger year = thisYear();
    NSUInteger firstWeek = zeller(year, month, 1);
    NSUInteger days = daysOfMonth(year, month);
    NSString *monS = numberToChineseMonth(month);//把数字月份转换成中文月份
    NSLog(@"\n     %@ %ld\n日 一 二 三 四 五 六",monS, (long)year);
    //根据firstDayWeek和days数值，按照固定格式打印出日历
    printCalendarAccordingFirstWeekAndDays(firstWeek, days);
}

//输出当前输入年份和月份的日历
void printGivenMonthOfGivenYear(NSUInteger month, NSUInteger year)
{
    NSUInteger firstWeek = zeller(year, month, 1);
    NSUInteger days = daysOfMonth(year, month);
    
    NSString *monS = numberToChineseMonth(month);//把数字月份转换成中文月份
    NSLog(@"\n     %@ %ld\n日 一 二 三 四 五 六",monS, (long)year);
    //根据firstDayWeek和days数值，按照固定格式打印出日历
    printCalendarAccordingFirstWeekAndDays(firstWeek, days);
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {

//终端命令行指令如下
//sudo /Users/linyong/Library/Developer/Xcode/DerivedData/Calendar-emdqpoyeocwatjdvvcvzhkisdowo/Build/Products/Debug/Calendar [参数1 参数2 参数3]
        
        NSString *cal, *firstNum, *secondNum;
        NSUInteger year, month, monthS;
        
        if (argc == 2) {
            cal= [[NSString alloc] initWithCString:(const char*)argv[1] encoding:NSASCIIStringEncoding];
            if ([cal isEqualToString:@"cal"]) {
                //输出当前月份日历
                //NSLog(@"输出现在的月份日历");//need to code
                printThisMonthCal();
            }
            else
                NSLog(@"\n%@: command not found",cal);
        }
        else if (argc == 3){
            cal= [[NSString alloc] initWithCString:(const char*)argv[1] encoding:NSASCIIStringEncoding];
            firstNum = [[NSString alloc] initWithCString:(const char*)argv[2] encoding:NSASCIIStringEncoding];
            //判断  cal: year 0 not in range 1..9999
            year = [firstNum intValue];
            if (year == 0 || year >9999) {
                NSLog(@"\ncal: year %lu not in range 1..9999",(unsigned long)year);
            }
            else{
                //NSLog(@"输出当前输入年份的所以月份的日历");//need to code
                printAllMonthOfGivenYear(year);
            }
        }
        //参数为4
        else if(argc == 4){
            cal= [[NSString alloc] initWithCString:(const char*)argv[1] encoding:NSASCIIStringEncoding];
            firstNum = [[NSString alloc] initWithCString:(const char*)argv[2] encoding:NSASCIIStringEncoding];
            secondNum = [[NSString alloc] initWithCString:(const char*)argv[3] encoding:NSASCIIStringEncoding];
            //判断 cal: [字符] is neither a month number (1..12) nor a name
            month = [firstNum intValue];
            year = [secondNum intValue];
            
            monthS = [secondNum intValue];
            
            if ([firstNum isEqualToString:@"-m"]) {//-m
                if (monthS == 0 || monthS > 12) {
                    NSLog(@"\ncal: %@ is neither a month number (1..12) nor a name",secondNum);
                }
                else{
                    //NSLog(@"输出当年所输入月份的日历");//need to code
                    printGivenMonthOfThisYear(monthS);
                }
            }
            else{
                if (month == 0 || month > 12) {
                    NSLog(@"\ncal: %@ is neither a month number (1..12) nor a name",firstNum);
                }
                else if(year == 0 || year > 9999){
                    NSLog(@"\ncal: year %lu not in range 1..9999",(unsigned long)year);
                }
                else{
                    //NSLog(@"输出当前输入年份和月份的日历");//need to code
                    printGivenMonthOfGivenYear(month, year);
                }
            }
        }
        else{
            NSLog(@"\nusage: cal [-jy] [[month] year]\n       cal [-j] [-m month] [year]\n       ncal [-Jjpwy] [-s country_code] [[month] year]\n       ncal [-Jeo] [year]");
        }
        
        return 0;
        
    }
}

