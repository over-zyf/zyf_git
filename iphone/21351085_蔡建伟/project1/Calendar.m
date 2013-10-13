//
//  Calendar.m
//  Calendar
//
//  Created by ShenPF on 13-10-1.
//  Copyright (c) 2013年 Eric. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Calendar.h"
char monthString[15][20] = {"", "一月", "二月", "三月", "四月",
    "五月", "六月", "七月", "八月",
    "九月", "十月", "十一月", "十二月"};

char dayString[8][20] = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六",};
int daysOfMonth[15] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};


@implementation Calendar
- (bool) isLeapYear: (int) tYear {
    return (tYear % 4 == 0 &&  tYear % 100 != 0) || tYear % 400 == 0;
}

- (int) computeDayOfWeek : (int)tDay wiht: (int)tMonth wiht: (int)tYear{
	int ret = -1;
	if(tMonth == 1 || tMonth == 2) {
		tMonth += 12;
		tYear--;
	}
	int c = tYear / 100, y = tYear % 100;
    if(tYear > 1582 || (tYear == 1582 && tMonth > 10) || (tYear == 1582 && tMonth == 10 && tDay >=15))
    	ret = ((y + y / 4 + c / 4 - 2 * c + 26 * (tMonth + 1) / 10 + tDay - 1) % 7 + 7) % 7;
    if(tYear < 1582 || (tYear == 1582 && tMonth < 10) || (tYear == 1582 && tMonth == 10 && tDay <= 4))
    	ret =  ((y + y / 4 - c + 26 * (tMonth + 1) / 10 + tDay + 4) % 7 + 7) % 7;
    return ret;
}

- (void) printDay: (int) tDay wiht: (int) tMonth wiht: (int) tYear {
    year = tYear; month = tMonth; day = tDay;
	int dayOfWeek = [self computeDayOfWeek:day wiht:month wiht:year];
	printf ("今天是%s\n", dayString[dayOfWeek]);
}

- (int) printEveryMonth: (int)firstDay wiht: (int)tMonth wiht: (int)tYear{
    bool isLeap = [self isLeapYear:tYear];
    printf(" 日 一 二 三 四 五 六\n");
    for(int i = 0; i < firstDay; i++)
        printf("   ");
    int curDay = 1, totalDay = daysOfMonth[tMonth];
    if(2 == tMonth){
        if(isLeap)
            totalDay++;
    }
    for(int i = firstDay; i < 7; i++)
        printf("%3d", curDay++);
    printf("\n");
    int flag = 0;
    for(int i = curDay; i <= totalDay; i++){
        printf("%3d", curDay++);
        flag++;
        if(flag == 7){
            printf("\n");
            flag = 0;
        }
    }
    if(0 != flag)
        printf("\n");
    return flag;
}

- (void) printMonth: (int) tMonth wiht: (int) tYear {
    day = 1; month = tMonth; year = tYear;
    int firstDay = [self computeDayOfWeek:day wiht:month wiht:year];
	printf("       %s %4d\n", monthString[month], year);
    int tmp = [self printEveryMonth: firstDay wiht:month wiht:year];
}

- (void) printYear: (int) tYear {
    printf("                             %4d\n\n", tYear);
    bool isLeap = [self isLeapYear:tYear];
    for(int i = 1; i <= 4; i ++){
        int monthArray[3];
        monthArray[0] =(i - 1) * 3 + 1;
        monthArray[1] =(i - 1) * 3 + 2;
        monthArray[2] =(i - 1) * 3 + 3;
        printf("         %s          ", monthString[monthArray[0]]);
        printf("       %-9s          ", monthString[monthArray[1]]);
        printf("       %-9s\n", monthString[monthArray[2]]);
        printf(" 日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        int firstDay[3], curDay[3] = {1, 1, 1}, totalDay[3];
        for(int j = 0; j < 3; j++) {
            firstDay[j] = [self computeDayOfWeek:1 wiht:monthArray[j] wiht:tYear];
            totalDay[j] = daysOfMonth[monthArray[j]];
            if(2 == monthArray[j]){
                if(isLeap){
                    totalDay[j]++;
                }
            }
            for(int i = 0; i < firstDay[j]; i++)
                printf("   ");
            for(int k = firstDay[j]; k < 7; k++)
                printf("%3d", curDay[j]++);
            printf(" ");
        }
        printf("\n");
        for(int row = 0; row < 5; row++){
            for(int j = 0; j < 3; j++){
                for(int k = 0; k < 7; k++){
                    if(curDay[j] <= totalDay[j])
                        printf("%3d", curDay[j]++);
                    else //if(6 != k)
                        printf("   ");
                    //else
                      //  printf("  ");
                }
                printf(" ");
            }
            printf("\n");
        }
    }
}

- (void) printCurrentMonth {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    //NSInteger day = [components day];
    NSInteger tMonth= [components month];
    NSInteger tYear= [components year];
    [self printMonth:(int)tMonth wiht:(int)tYear];
}

@end //Calendar


