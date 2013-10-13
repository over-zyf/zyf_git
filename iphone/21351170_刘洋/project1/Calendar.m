//
//  Calendar.m
//  Calendar2
//
//  Created by liuyang on 13-10-10.
//  Copyright (c) 2013年 cn. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

char *ch_month[12]= {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"};

/*
 *函数名：printCalendarWithYearwithMonthwithWeekwithDay
 *参数：年 月 星期 日（星期与日对应）
 *功能：输出指定年月日历
 */
+(void) printCalendarWithYear:(NSInteger)year_x withMonth:(NSInteger)month_x withWeek:(NSInteger)week_x withDay:(NSInteger)day_x {
    NSArray *ch_week = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil];
    printf("    %s月 %ld\n", ch_month[month_x - 1] , year_x);
    printf("日 一 二 三 四 五 六\n");
    
    int totalDay = [self computeTotalDayOfMonth:month_x withYear:year_x];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSInteger j = 7;
    for (NSInteger i = day_x; i >= 1; i--) {
        [dic setObject:ch_week[(week_x - 1 + j)%7] forKey:[NSNumber numberWithInteger:i]];
        j --;
        if (j == 0) {
            j = 7;
        }
    }
    j = 1;
    for (NSInteger i = day_x + 1; i <= totalDay; i++) {
        [dic setObject:ch_week[(week_x - 1 + j)%7] forKey:[NSNumber numberWithInteger:i]];
        j ++;
        if (j == 7) {
            j = 0;
        }
    }
    NSInteger firstDay = week_x;
    for (NSInteger i = day_x; i >= 1; i--) {
        if (firstDay == 0) {
            firstDay = 7;
        }
        firstDay--;
    }
    for (int i = 1; i <= firstDay; i++)
        printf("   ");
    for (int i = 1; i <= totalDay; i++) {
        if (i < 10)
            printf(" %d", i);
        else
            printf("%d", i);
        id week = [dic objectForKey:[NSNumber numberWithInteger:i]];
        if ([(NSString *)week isEqualToString:@"六"])
            printf("\n");
        else if(i != totalDay)
            printf(" ");
    }

}
/*
 *函数名：computeTotalDayOfMonthwithYear
 *参数：月 年
 *功能：返回指定年份某月共有多少天
 */
+(int) computeTotalDayOfMonth:(NSInteger)month_x withYear:(NSInteger)year_x {
    int monthDay[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if ((year_x % 4 == 0 && year_x % 100 != 0)||year_x % 400 == 0) {          //判断是否为闰年
        monthDay[2-1] = 29;
    }
    return monthDay[month_x - 1];
}
/*
 *函数名：getFirstWeekOfMonthinYear
 *参数：月 年
 *功能：返回指定年份某月月初第一天是星期几
 */
+(NSInteger) getFirstWeekOfMonth:(int)i inYear:(int)year_x {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setYear:year_x];
    [comps setMonth:i];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    return [weekdayComponents weekday];
}
/*
 *函数名：printCalendarOfYear
 *参数：年
 *功能：打印指定年份12个月日历
 */
+(void) printCalendarOfYear:(int)year_x
{
    static int day[13][60];
    for (int i = 1; i <= 12; i++) {
        NSInteger m = [self getFirstWeekOfMonth:i inYear:year_x];
        int totalDay = [self computeTotalDayOfMonth:i withYear:year_x];
        int x = 1;
        int k = m;
        for (int j = 0; j < 6; j++) {
            while(k <= 7) {
				day[i][j * 10 + k] = x++;
				if(x > totalDay)
					break;
				k++;
			}
			k = 1;
			if(x > totalDay)
				break;
        }
    }
    printf("                            %d\n\n", year_x);
	for(int i = 1; i <= 4; i++)
	{
        if (i != 4)
            printf("        %s月                  %s月                  %s月\n",ch_month[(i - 1)*3],ch_month[1 + (i - 1)*3],ch_month[2 + (i - 1)*3]);
        else
            printf("        %s月                  %s月                %s月\n",ch_month[(i - 1)*3],ch_month[1 + (i - 1)*3],ch_month[2 + (i - 1)*3]);
		printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
		for(int j = 0; j < 6; j++)
		{
			for(int u = 1; u <= 3; u++)
			{
				for(int k = 1; k <= 7; k++)
				{
					if(day[(i - 1) * 3 + u][j*10 + k] == 0)
						printf("   ");
					else if(day[(i - 1) * 3 + u][j*10 + k] < 10)
						printf(" %d ", day[(i - 1) * 3 + u][j*10 + k]);
					else
						printf("%d ", day[(i - 1) * 3 + u][j*10 + k]);
				}
				printf(" ");
			}
			printf("\n");
		}
	}
    
}

@end
