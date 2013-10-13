//
//  CalenderClass.m
//  Calender
//
//  Created by guest on 13-9-28.
//  Copyright (c) 2013年 guest. All rights reserved.
//

#import "CalenderClass.h"
extern int monthd[12];
extern char *moname[12];
bool f[3];
int n[3]={1,1,1};
@implementation CalenderClass
@synthesize month=_month,year=_year;
-(id)init
{
    if (self=[super init]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now=[NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
        comps = [calendar components:unitFlags fromDate:now];
        _year=(int)[comps year];
        _month=(int)[comps month];
    }
    return self;
}
-(id)initWithyear:(int)year andmonth:(int)month
{
    if (self=[super init]) {
        _year=year;
        _month=month;
    }
    return self;
}
-(int)returnfistdayweak
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year=_year;
    comps.day=1;
    comps.month=_month;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int firstweekday=(int)[weekdayComponents weekday];
    return firstweekday-1;
}
-(void)printcal:(int)firstday
{
    printf("[me@linuxbox ~]$ cal\n");
    int knum=(20-(int)strlen(moname[_month-1])-5)/2;
    printf("%*s%s %d\n",knum,"",moname[_month-1],_year);
    printf("Su Mo Tu We Th Fr Sa\n");
    for (int j=0; j<firstday; j++) {
        printf("   ");
    }
    int day=monthd[_month-1];
    if (_month==2) {
        if((_year%4==0&&_year%100!=0)||_year%400==0)
            day=monthd[1]+1;
    }
    for (int i=1; i<=day; i++) {
        if (i<10) {
            printf(" %d",i);
        }
        else
            printf("%d",i);
        if ((i+firstday-1)%7==6) {
            printf("\n");
        }
        else
            printf(" ");
    }
    printf("\n");
}
-(void)printrouand:(int)firstday andnowday:(int)now andnowmonth:(int)month andturn:(int)t
{
    if (now==1) {
    for (int j=0; j<firstday; j++) {
        printf("   ");
    }
    }
    int day=monthd[month-1];
    if (now>=day&&f[t]) {
        printf("                    ");
    }
    if (month==2) {
        if((_year%4==0&&_year%100!=0)||_year%400==0)
            day=monthd[1]+1;
    }
    int i;
    for (i=now; i<=day; i++) {
        if (i<10) {
            printf(" %d",i);
        }
        else
            printf("%d",i);
        if ((i+firstday-1)%7==6) {
            i++;
            break;
        }
        else
            printf(" ");
    }
    n[t]=i;
    if (i>day&&!f[t]){
        while ((i+firstday-2)%7!=6) {
            printf("   ");
            i++;
        }
        f[t]=TRUE;
    }
}
-(void)printfcalforyear
{
    printf("[me@linuxbox ~]$ cal\t[me@linuxbox ~]$ cal\t[me@linuxbox ~]$ cal\n");
    int knum=(20-(int)strlen(moname[_month-1])-9);
    printf("    %s %d%*s\t",moname[_month-1],_year,knum,"");
    int knum2=(20-(int)strlen(moname[_month])-9);
    printf("    %s %d%*s\t",moname[_month],_year,knum2,"");
    int knum3=(20-(int)strlen(moname[_month+1])-9);
    printf("    %s %d%*s",moname[_month+1],_year,knum3,"");
    printf("\n");
    printf("Su Mo Tu We Th Fr Sa\tSu Mo Tu We Th Fr Sa\tSu Mo Tu We Th Fr Sa\n");
    int first[3];
    int month[3];
    month[0]=_month;
    first[0]=[self returnfistdayweak];
    _month++;
    month[1]=_month;
    first[1]=[self returnfistdayweak];
    _month++;
    month[2]=_month;
    first[2]=[self returnfistdayweak];
    n[0]=1;n[1]=1;n[2]=1;
    f[0]=false;f[1]=false;f[2]=false;
    while (!f[0]||!f[1]||!f[2]) {
        [self printrouand:first[0] andnowday:n[0] andnowmonth:month[0] andturn:0];
        printf("\t");
        [self printrouand:first[1] andnowday:n[1] andnowmonth:month[1] andturn:1];
        printf("\t");
        [self printrouand:first[2] andnowday:n[2] andnowmonth:month[2] andturn:2];
        printf("\n");
    }
    printf("\n");
    

}
@end
