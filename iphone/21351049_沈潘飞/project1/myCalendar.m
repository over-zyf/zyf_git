//
//  myCalendar.m
//  MyCalendar
//
//  Created by ShenPF on 13-10-1.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import "myCalendar.h"
static NSArray *monthArray;
static NSArray *daysOfMonth;
@implementation myCalendar{
    int daysOfThisMonth;
    int weekOfFirstDay;
}

- (id) init{
    monthArray=@[@" ",@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    daysOfMonth=[NSArray arrayWithObjects: @0,@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31,nil];
    return (self);
}
- (BOOL) isLeap:(int)year{
    if((year%4==0&&year%100!=0)||year%400==0){
       return YES;
    }
    return NO;
}
- (void) computeDayWeekwith:(int)year with:(int)month{
    BOOL bigger= year>=1990? YES:NO;
    int days=0;
    if(bigger==YES){
        for (int startYear=1990; startYear<year; startYear++) {
            if([self isLeap:startYear])days+=366;
            else days+=365;
        }
        for (int startMonth=1; startMonth<month; startMonth++) {
            if([self isLeap:year]&&startMonth==2)days+=29;
            else days+=[daysOfMonth[startMonth] intValue];
        }
        weekOfFirstDay=days%7+1;
    }else{
        for (int startYear=year; startYear<1899; startYear++) {
            if([self isLeap:startYear])days+=366;
            else days+=365;
        }
        for (int startMonth=month; startMonth<=12; startMonth++) {
            if([self isLeap:year]&&startMonth==2)days+=29;
            else days+=[daysOfMonth[startMonth] intValue];
        }
        weekOfFirstDay=(1-days)%7+7;
    }
    
    if([self isLeap:year]&&month==2)daysOfThisMonth=29;
    else daysOfThisMonth=[daysOfMonth[month] intValue];
}

-(void) getCalendar:(int)year atMonth:(int)month{
    [self computeDayWeekwith:year with:month];
    printf("    %4s %6d\n",[monthArray[month] UTF8String],year);
    printf("日 一 二 三 四 五 六\n");
    NSMutableArray *weekArray =[NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,nil];
    int week=weekOfFirstDay%7;
    int day=1;
    while (day<=daysOfThisMonth) {
        while (week!=7&&day<=daysOfThisMonth) {
            weekArray[week]=[NSNumber numberWithInt:day];
            day++;
            week++;
        }
        for (int i=0; i<7; i++) {
            if(![weekArray[i] isEqual:@0]){
                printf("%2d ",[weekArray[i] intValue]);
            }else{
                printf("   ");
            }
        }
        printf("\n");
        for (int i=0; i<7; i++) {
            weekArray[i]=@0;
        }
        week=week%7;
    }
}
- (void) getCalendar:(int)year{
    printf("                               %d                                   \n",year);
    for(int i=1;i<=4;i++){
    printf("        %s                   %s                     %s\n",[monthArray[3*i-2] UTF8String],[monthArray[3*i-1] UTF8String],[monthArray[i*3] UTF8String]);
    printf("日 一 二 三 四 五 六    日 一 二 三 四 五 六    日 一 二 三 四 五 六\n");
    int firstDay,firstWeek,secondDay,secondWeek,thirdDay,thirdWeek;
    [self computeDayWeekwith:year with:3*i-2];
    int firstMonth_days=daysOfThisMonth;
    int firstMonth_week=weekOfFirstDay;
    [self computeDayWeekwith:year with:3*i-1];
    int secondMonth_days=daysOfThisMonth;
    int secondMonth_week=weekOfFirstDay;
    [self computeDayWeekwith:year with:3*i];
    int thirdMonth_days=daysOfThisMonth;
    int thirdMonth_week=weekOfFirstDay;
    firstDay=secondDay=thirdDay=1;
    firstWeek=firstMonth_week%7;
    secondWeek=secondMonth_week%7;
    thirdWeek=thirdMonth_week%7;
    NSMutableArray *firstWeekArray =[NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,nil];
    NSMutableArray *secondWeekArray =[NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,nil];
    NSMutableArray *thirdWeekArray =[NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,nil];
    for (int line=1; line<=6; line++) {
        while (firstWeek!=7&&firstDay<=firstMonth_days) {
            firstWeekArray[firstWeek]=[NSNumber numberWithInt:firstDay];
            firstDay++;
            firstWeek++;
        }
        for (int i=0; i<7; i++) {
            if(![firstWeekArray[i] isEqual:@0]){
                printf("%2d ",[firstWeekArray[i] intValue]);
            }else{
                printf("   ");
            }
        }
        printf("   ");
        while (secondWeek!=7&&secondDay<=secondMonth_days) {
            secondWeekArray[secondWeek]=[NSNumber numberWithInt:secondDay];
            secondDay++;
            secondWeek++;
        }
        for (int i=0; i<7; i++) {
            if(![secondWeekArray[i] isEqual:@0]){
                printf("%2d ",[secondWeekArray[i] intValue]);
            }else{
                printf("   ");
            }
        }
        printf("   ");
        while (thirdWeek!=7&&thirdDay<=thirdMonth_days) {
            thirdWeekArray[thirdWeek]=[NSNumber numberWithInt:thirdDay];
            thirdDay++;
            thirdWeek++;
        }
        for (int i=0; i<7; i++) {
            if(![thirdWeekArray[i] isEqual:@0]){
                printf("%2d ",[thirdWeekArray[i] intValue]);
            }else{
                printf("   ");
            }
        }
        printf("\n");
        for (int i=0; i<7; i++) {
            firstWeekArray[i]=@0;
            secondWeekArray[i]=@0;
            thirdWeekArray[i]=@0;
        }
        firstWeek=firstWeek%7;
        secondWeek=secondWeek%7;
        thirdWeek=thirdWeek%7;
    }
    }
}
@end
