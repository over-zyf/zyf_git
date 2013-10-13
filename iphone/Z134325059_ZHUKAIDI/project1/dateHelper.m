//
//  dateHelper.m
//  
//
//  Created by XadillaX on 13-10-10.
//
//

#import "dateHelper.h"

@implementation dateHelper
+ (dateHelper*) newDate: (NSDate*) date
{
    dateHelper* helper = [[dateHelper alloc] initDate: date];
    return helper;
}

+ (dateHelper*) newDateWithYear: (int) year month: (int) month andDay: (int) day
{
    dateHelper* helper = [[dateHelper alloc] initDateWithYear: year month: month andDay: day];
    return helper;
}

+ (dateHelper*) newDateWithString: (NSString*) dateString
{
    dateHelper* helper = [[dateHelper alloc] initDateWithString: dateString];
    return helper;
}

- (id) initDate: (NSDate*) _date { if(self == [super init]) date = _date; return self; }

- (id) initDateWithString: (NSString*) dateString
{
    if(self == [super init])
    {
        date = [[NSDate alloc] initWithString: dateString];
    }
    return self;
}

- (id) initDateWithYear: (int) year month: (int) month andDay: (int) day
{
    if(self == [super init])
    {
        NSString* str = [NSString stringWithFormat: @"%d-%d-%d 00:00:00 +0000", year, month, day];
        [self initDateWithString: str];
    }
    return self;
}

- (int) getYear
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy";
    NSString* year = [df stringFromDate: date];
    return [year intValue];
}

- (int) getMonth
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"M";
    NSString* month = [df stringFromDate: date];
    return [month intValue];
}

- (int) getDay
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"d";
    NSString* day = [df stringFromDate: date];
    return [day intValue];
}

- (int) getWeek
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"e";
    NSString* week = [df stringFromDate: date];
    return [week intValue];
}
@end
