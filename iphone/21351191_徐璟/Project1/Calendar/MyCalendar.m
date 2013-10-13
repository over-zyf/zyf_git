//
//  MyCalendar.m
//  cal
//
//  Created by Jim-VM on 13-10-10.
//  Copyright (c) 2013年 Jim-VM. All rights reserved.
//

#import "MyCalendar.h"

@implementation MyCalendar
-(void) setYear:(NSUInteger)inputYear
{
    [dateComponents setYear:inputYear];
    date=[calendar dateFromComponents:dateComponents];
    dateComponents=[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
}

-(NSUInteger) getYear
{
    return dateComponents.year;
}

-(void) setMonth:(NSUInteger)inputMonth
{
    [dateComponents setMonth:inputMonth];
    date=[calendar dateFromComponents:dateComponents];
    dateComponents=[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
}

-(NSUInteger) getMonth
{
    return dateComponents.month;
}

-(void) setDay: (NSUInteger) inputDay
{
    [dateComponents setDay:inputDay];
    date=[calendar dateFromComponents:dateComponents];
    dateComponents=[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
}

-(NSUInteger) getDay
{
    return dateComponents.day;
}

-(NSUInteger) getWeek
{
    return dateComponents.weekday;
}

-(void) setYear: (NSUInteger) inputYear Month:(NSUInteger)inputMonth Day:(NSUInteger)inputDay
{
    [dateComponents setYear: inputYear];
    [dateComponents setMonth: inputMonth];
    [dateComponents setDay: inputDay];
    date=[calendar dateFromComponents:dateComponents];
    dateComponents=[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
}


-(id) init
{
    date=NSDate.date;
    calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    dateComponents=[[NSDateComponents alloc] init];
    dateComponents=[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    
    return self;
}

-(id) initWithYear:(NSUInteger)inputYear
{
    calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    dateComponents=[[NSDateComponents alloc] init];
    [self setYear:inputYear Month:1 Day:1];
    return self;
}

-(id) initWithYear:(NSUInteger)inputYear Month:(NSUInteger)inputMonth
{
    calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    dateComponents=[[NSDateComponents alloc] init];
    
    [self setYear:inputYear Month:inputMonth Day:1];
    return self;
}

-(id) initWithYear:(NSUInteger)inputYear Month:(NSUInteger)inputMonth Day:(NSInteger)inputDay
{
    calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    dateComponents=[[NSDateComponents alloc] init];
    [self setYear:inputYear Month:inputMonth Day:inputDay];
    return self;
}

-(BOOL)isLeapYear:(NSUInteger)inputYear
{
    return ((inputYear % 4 == 0 && inputYear % 100 != 0) || inputYear % 400 == 0);
}

-(BOOL)validateYear:(NSUInteger)year Month:(NSUInteger)month Day:(NSUInteger)day
{
    if (month < 1 || month > 12) {
        return NO;
    }
    if (day < 1 || day > 31) {
        return NO;
    }
    if (month == 4 || month == 6 || month == 9 || month == 11) {
        if (day > 30) {
            return NO;
        }
    } else {
        if (month == 2) {
            if (day > 29) {
                return NO;
            }
            if (![self isLeapYear:year]) {
                if (day > 28) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

-(BOOL)isValidDate
{
    return [self validateYear:dateComponents.year Month:dateComponents.month Day:dateComponents.day];
}

-(NSString *)setHeadStr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    NSString *head=[dateFormatter stringFromDate:date];
    NSUInteger tabs = (20 - head.length) / 2;
    for (int i = 0; i < tabs; i++) {
        head = [@" " stringByAppendingString:head];
    }
    head =[head stringByAppendingString:@"\nSu Mo Tu We Th Fr Sa"];
    return head;
}

-(NSString *)setBodyStr
{
    [self setDay:1];
//    dateComponents=[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    NSString *body;
    switch (dateComponents.weekday) {
		case 1:
            body = @"";
			break;
		case 2:
			body = @"   ";
			break;
		case 3:
			body = @"      ";
			break;
		case 4:
			body = @"         ";
			break;
		case 5:
			body = @"            ";
			break;
		case 6:
			body = @"               ";
			break;
		case 7:
			body = @"                  ";
			break;
		default:
			break;
    }
    NSUInteger daysOfTheMonth=[calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
    for (int i = 1; i <= daysOfTheMonth; i++) {
        if (i < 10) {
            body = [body stringByAppendingFormat:@" %d",i];
        } else {
            body = [body stringByAppendingFormat:@"%d", i];
        }
        
        if ((body.length + 1) % 21 == 0) {
            body = [body stringByAppendingString:@"\n" ];
        } else {
            body = [body stringByAppendingString:@" "];
        }
    }
    return body;
    
}

-(NSString *)setSingleLine:(NSUInteger)lineNumber
{
    [self setDay:1];
    NSUInteger daysInFirstWeek=[self getDaysInFirstWeek];
    NSUInteger daysOfTheMonth=[calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
    NSString *lineStr=@"";
    int i = 0;
    if (lineNumber==1) {
        for (i = 1; i <= 7 - daysInFirstWeek; i++) {
            lineStr=[lineStr stringByAppendingString:@"   "];
        }
        for (i = 1; i <= daysInFirstWeek-1; i++) {
//            lineStr=[lineStr stringByAppendingFormat:@" %d ", i];
            lineStr=[lineStr stringByAppendingString:[self getSingleDayString:i End:@" "]];
        }
//        lineStr=[lineStr stringByAppendingFormat:@" %d", i];
        lineStr=[lineStr stringByAppendingString:[self getSingleDayString:i End:@""]];
    }
    else
    {
        NSUInteger startDay=daysInFirstWeek+(lineNumber-2)*7+1;
        if (startDay+6<=daysOfTheMonth) {
            for (i = (int)startDay; i < startDay+6; i++) {
//                lineStr=[lineStr stringByAppendingFormat:@" %d ", i];
                lineStr=[lineStr stringByAppendingString:[self getSingleDayString:i End:@" "]];
            }
//            lineStr=[lineStr stringByAppendingFormat:@" %d", i];
            lineStr=[lineStr stringByAppendingString:[self getSingleDayString:i End:@""]];
        }
        else
        {
            for (i = (int)startDay; i <= daysOfTheMonth; i++) {
//                lineStr=[lineStr stringByAppendingFormat:@" %d ", i];
                lineStr=[lineStr stringByAppendingString:[self getSingleDayString:i End:@" "]];
            }
            for (i = 0; (i<6)&&(i<5-daysOfTheMonth+startDay); i++) {
                lineStr=[lineStr stringByAppendingString:@"   "];
            }
            lineStr=[lineStr stringByAppendingString:@"  "];
        }
    }
    return lineStr;
}

-(NSString *)getSingleDayString:(NSUInteger)day End:(NSString *)end
{
    if (day<10) {
        return [NSString stringWithFormat:@" %d%@", (int)day, end];
    }
    else{
        return [NSString stringWithFormat:@"%d%@", (int)day, end];
    }
}

-(NSUInteger)getDaysInFirstWeek
{
    if ([self getWeek]!=1) {
        [self setDay:1];
    }
    return 7-[self getWeek]+1;
}

-(NSString *)setMonthStr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    NSString *str=[dateFormatter stringFromDate:date];
    NSUInteger tabs1 = (20 - str.length) / 2;
    NSUInteger tabs2 = 20 - str.length - tabs1;
    for (int i = 0; i < tabs1; i++) {
        str = [@" " stringByAppendingString:str];
    }
    for (int i = 0; i < tabs2; i++) {
        str = [str stringByAppendingString:@" "];
    }
    return str;
}

-(NSString *)setWeekStr
{
    return @"Su Mo Tu We Th Fr Sa";
}

-(NSString *)getFinalString
{
    return [NSString stringWithFormat:@"%@\n%@",[self setHeadStr],[self setBodyStr]];
}

-(NSUInteger)getWeeksOfMonth
{
    NSUInteger daysOfTheMonth=[calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
    NSUInteger daysInFirstWeek=[self getDaysInFirstWeek];
    NSUInteger fullWeeks=(daysOfTheMonth-daysInFirstWeek)/7;
    NSUInteger remainDays=(daysOfTheMonth-daysInFirstWeek)%7;
    if (remainDays>0) {
        return fullWeeks+2;
    }
    else
    {
        return fullWeeks+1;
    }
}

@end
