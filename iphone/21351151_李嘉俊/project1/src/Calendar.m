//
//  Calendar.m
//  project1
//
//  Created by 李 嘉俊 on 13-10-8.
//  Copyright (c) 2013年 李 嘉俊. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

-(Calendar*)init{ //初始化构造函数，获取当前年月
    self = [super init];
    if(self){
        NSDateFormatter *curdateformatter = [[NSDateFormatter alloc] init];
        [curdateformatter setDateStyle:NSDateFormatterShortStyle];
        [curdateformatter setDateFormat:@"YYYY"];
        Year = [[curdateformatter stringFromDate:[NSDate date]] intValue];
        [curdateformatter setDateFormat:@"MM"];
        Month = [[curdateformatter stringFromDate:[NSDate date]] intValue];
    }
    return self;
}
-(NSString*)getCalendarByMonth:(int)month year:(int)year{ //取得指定年月的日历，并用NSString 返回
  
    NSString *cal = [[NSString alloc]init];
    cal = @"日 一 二 三 四 五 六 \n";
    int months[13] = {-1,31,28,31,30,31,30,31,31,30,31,30,31};
    if((year%4 == 0&&year%100 != 0)||(year%400 == 0))
        months[2
               ] = 29;
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
        cal = [NSString stringWithFormat:@"%@%@",cal,@"   "];
    
    for(int i = 1;i <= months[month];i++){
        if((i + weekday - 2)%7 == 0)
        {
            if(i == 1)
                cal = [NSString stringWithFormat:@"%@%2d ",cal,i];
            else{
                 cal = [NSString stringWithFormat:@"%@\n%2d ",cal,i];
            }
        }
        else  cal = [NSString stringWithFormat:@"%@%2d ",cal,i];;
        if(i==months[month]){
            for (int x = 0; x<6-(i + weekday - 2)%7; x++) {
                 cal = [NSString stringWithFormat:@"%@%@",cal,@"   "];
            }
        }

    }
    
    return cal;
}

-(void) printCurrentMonthCalendar{ //输出当前年月的日历
    [self printCalendarByMonthYear:Month year:Year];
}
-(void)printCalendarByMonthYear:(int)month year:(int)year{ //输出指定年月的日历
    if (year == -1) {
        year = Year;
    }
  NSArray *monthname = [[NSArray alloc]initWithObjects:@"     一月",@"     二月",@"     三月",@"     四月",@"     五月",@"     六月",@"     七月",@"     八月",@"     九月",@"     十月",@"    十一月",@"    十二月",@"",@" ",@"  ",nil];
    int sub= 12;
    if(month <= 10 && year<1000){
        sub =13;
    }
    else if(month>10){
        if(year<10){
            sub = 14;
        }
        else if(year>=10 && year<1000){
            sub = 13;
        }
    }
   // NSLog(@"\t\t%@\t%d\t\t\n",[monthname objectAtIndex:month-1],year);
    NSLog(@"%@%@ %d\n%@\n",[monthname objectAtIndex:sub],[monthname objectAtIndex:month-1],year,[self getCalendarByMonth:month year:year]);
}
-(void)printCalendarByYear:(int)year{ //输出指定年份的日历，一行输出3个月
    NSMutableString *res = [[NSMutableString alloc] init];
    if(year>=1000){
    	[res appendString:[NSString stringWithFormat:@"                  	     %d             	                 \n\n",year]];
    }
    else if(year<10){
    	[res appendString:[NSString stringWithFormat:@"                  	       %d             	                 \n\n",year]];

    }
    else{
	[res appendString:[NSString stringWithFormat:@"                  	      %-d             	                 \n\n",year]];
    }
          NSArray *monthname = [[NSArray alloc]initWithObjects:@"        一月        ",@"        二月        ",@"        三月",@"        四月        ",@"        五月        ",@"        六月",@"        七月        ",@"        八月        ",@"        九月",@"        十月        ",@"       十一月       ",@"       十二月",nil];
    NSArray *splitchr= [[NSArray alloc]initWithObjects:@"",@" ",@" ",nil];
    for (int i = 0; i<4; i++) {
        NSMutableArray *weeks = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",nil];
        [res appendString:[NSString stringWithFormat:@"%@  %@  %@",[monthname objectAtIndex:i*3],[monthname objectAtIndex:i*3+1],[monthname objectAtIndex:i*3+2]]];

      //  NSLog(@"\t         %@          \t       %@        \t        %@        ",[monthname objectAtIndex:i*3],[monthname objectAtIndex:i*3+1],[monthname objectAtIndex:i*3+2]);

        for (int j = 1 ; j <=3; j++) {
            NSArray *montharray = [[NSArray alloc] init];
            montharray = [[self getCalendarByMonth:i*3+j year:year] componentsSeparatedByString:@"\n"];
            for (int k = 0; k<7; k++) {
                if(k>=[montharray count]){
                    
                    NSString *tmp = [NSString stringWithFormat:@"%@%@%@",[weeks objectAtIndex:k],[splitchr objectAtIndex:j-1],@"                     "];
                    [weeks replaceObjectAtIndex:k withObject:tmp];
                }
                else{
                    NSString *tmp = [NSString stringWithFormat:@"%@%@%@",[weeks objectAtIndex:k],[splitchr objectAtIndex:j-1],[montharray objectAtIndex:k]];
                    [weeks replaceObjectAtIndex:k withObject:tmp];
                }
                
            }
        }
       // NSLog(@"\n");
        [res appendString:@"\n"];
        for (int j = 0; j< [weeks count]; j++) {
            if (j== [weeks count] -1 && i==3) {
                [res appendString:[NSString stringWithFormat:@"%@",[weeks objectAtIndex:j]]];
            }
            else
                [res appendString:[NSString stringWithFormat:@"%@\n",[weeks objectAtIndex:j]]];
            //NSLog(@"%@\n",[weeks objectAtIndex:j]);
        }
       }
 NSLog(@"%@",res);

}
@end
