//
//  liuhuiCalendar.m
//  liuhui calendar
//
//  Created by leo on 13-10-13.
//  Copyright (c) 2013年 leo. All rights reserved.
//

#import "liuhuiCalendar.h"

@implementation liuhuiCalendar

@synthesize Year,Month,Week,Day;

//显示当前月历方法实现
-(void)ShowCurrentMonth:(int) year month:(int) month week:(int)week day:(int)day
{
    //月历表头
    printf("\t\t%d年 %d月\n",year,month);
    printf("日\t一\t二\t三\t四\t五\t六\n");
    
    //获取本月第一天是星期几，输出对应的空格
    int weekday = week;
    int temp = weekday-1;
    while(temp--)
        printf("  \t");
    
    //每月天数数组，闰年2月设为29天
    int months[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if((year%4 == 0&&year%100 != 0)||(year%400 == 0))
        months[1] = 29;
    
    //输出月历
    for(int i = 1;i <= months[month-1];i++){
        if((i + weekday - 2)%7 == 0)
        {
            if(i == 1)
                printf("%d\t",i);
            else{
                printf("\n");
                printf("%d\t",i);
            }
        }
        else printf("%d\t",i);
    }
    printf("\n");
}



//显示某一年某一月的月历的实现方法

-(void) ShowOneMonth:(int)year month:(int)month
{
    printf("\t\t%d年 %d月\n",year,month);
    printf("日\t一\t二\t三\t四\t五\t六\n");
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    
    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    int weekday = [weekdayComponents weekday];
    int temp = weekday-1;
    while(temp--)
        printf("  \t");
    int months[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if((year%4 == 0&&year%100 != 0)||(year%400 == 0))
        months[1] = 29;
    
    for(int i = 1;i <= months[month-1];i++){
        if((i + weekday - 2)%7 == 0)
        {
            if(i == 1)
                printf("%d\t",i);
            else{
                printf("\n");
                printf("%d\t",i);
            }
        }
        else printf("%d\t",i);
    }
    printf("\n");
}




//返回指定年份某月共有多少天

-(int) DaysOfMonth:(NSInteger)month withYear:(NSInteger)year {
    int monthDay[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if ((year % 4 == 0 && year % 100 != 0)||year % 400 == 0) {          //判断是否为闰年
        monthDay[1] = 29;
    }
    return monthDay[month - 1];
}
//返回指定年份某月月初第一天是星期几

-(NSInteger) getFirstWeekOfMonth:(int)i inYear:(int)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setYear:year];
    [comps setMonth:i];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    return [weekdayComponents weekday];
}
//显示某一年所有月历的实现方法
-(void) ShowOneYear:(int)year
{
    char *month[12]= {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    static int day[13][60];
    for (int i = 1; i <= 12; i++) {
        NSInteger m = [self getFirstWeekOfMonth:i inYear:year];
        int totalDay = [self DaysOfMonth:i withYear:year];
        int x = 1;
        int n = m;
        for (int j = 0; j < 6; j++) {
            while(n <= 7) {
				day[i][j * 10 + n] = x++;
				if(x > totalDay)
					break;
				n++;
			}
			n= 1;
			if(x > totalDay)
				break;
        }
    }
    printf("                            %d年\n\n", year);
	for(int i = 1; i <= 4; i++)
	{
        if (i != 4)
            printf("        %s月                  %s月                  %s月\n",month[(i - 1)*3],month[1 + (i - 1)*3],month[2 + (i - 1)*3]);
        else
            printf("        %s月                  %s月                %s月\n",month[(i - 1)*3],month[1 + (i - 1)*3],month[2 + (i - 1)*3]);
		printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
		for(int j = 0; j < 6; j++)
		{
			for(int e = 1; e<= 3; e++)
			{
				for(int k= 1; k<= 7; k++)
				{
					if(day[(i - 1) * 3 + e][j*10 + k] == 0)
						printf("   ");
					else if(day[(i - 1) * 3 + e][j*10 + k] < 10)
						printf(" %d ", day[(i - 1) * 3 + e][j*10 + k]);
					else
						printf("%d ", day[(i - 1) * 3 + e][j*10 + k]);
				}
				printf(" ");
			}
			printf("\n");
		}
	}
    
}

@end