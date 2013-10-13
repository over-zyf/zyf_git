//
//  monthObject.m
//
//
//  Created by XadillaX on 13-10-7.
//
//

#import "monthObject.h"
#import "dateHelper.h"

int _monthDays[2][12] = {
	{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
	{ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
};
NSString* _monthName[12] = {
	@"一月", @"二月", @"三月", @"四月", @"五月", @"六月",
	@"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"
};

int isRun(int year)
{
	if(year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) return 1;
	return 0;
}

@implementation monthObject
+ (int) GB2312Length: (NSString*) str
{
	const char* s = [str UTF8String];
	int len = strlen(s);
	int r = 0;
	for(int i = 0; i < len; i++)
	{
		if(s[i] < 0)
		{
			i += 2;
			r += 2;
		}
		else r++;
	}

	return r;
}

- (NSString*) description
{
	NSString* str = [self monthNameHeaderWithYear];
	str = [str stringByAppendingString: @"\n"];
	str = [str stringByAppendingString: [monthObject header]];
	str = [str stringByAppendingString: @"\n"];
	for(int i = 0; i < 6; i++)
	{
		str = [str stringByAppendingString: [self lineAt: i]];
		str = [str stringByAppendingString: @"\n"];
	}
	return str;
}

+ (NSString*) header
{
	return @"日 一 二 三 四 五 六";
}

- (NSString*) monthName
{
    return monthName;
}

- (NSString*) lineAt: (int) index
{
    if(index >= 6)
    {
        return @"";
    }
    
    return lines[index];
}

- (NSString*) monthNameHeader
{
	int lineLength = [monthObject GB2312Length: [monthObject header]];
	int monthLength = [monthObject GB2312Length: monthName];
	int pre = (lineLength - monthLength) / 2, suf = pre;
	if((lineLength - monthLength) % 2) pre++;
	
	NSString* result = @"";
	for(int i = 0; i < pre; i++) result = [result stringByAppendingString: @" "];
	result = [result stringByAppendingString: monthName];
	for(int i = 0; i < suf; i++) result = [result stringByAppendingString: @" "];

	return result;
}

- (NSString*) monthNameHeaderWithYear
{
    int lineLength = [monthObject GB2312Length: [monthObject header]];
    
    NSString* yheader = monthName;
    yheader = [yheader stringByAppendingString: @"  "];
    yheader = [yheader stringByAppendingString: [[NSString alloc] initWithFormat: @"%d", year]];
    int monthLength = [monthObject GB2312Length: yheader];
    
    int pre = (lineLength - monthLength) / 2, suf = pre;
	if((lineLength - monthLength) % 2) pre++;
	
	NSString* result = @"";
	for(int i = 0; i < pre; i++) result = [result stringByAppendingString: @" "];
	result = [result stringByAppendingString: yheader];
	for(int i = 0; i < suf; i++) result = [result stringByAppendingString: @" "];
    
	return result;
}

- (bool) initMonth: (int) _month andYear: (int) _year
{
	if(_year < 1 || _year > 9999) return false;
	if(_month < 1 || _month > 12) return false;

	month = _month;
	year = _year;

	dateHelper* dhelper = [dateHelper newDateWithYear: year month: month andDay: 1];

    // 本月天数
	dayCount = _monthDays[isRun(year)][month - 1];
    
    // 得到星期几
    // 1 ~ 星期天 2 ~ 星期一 ... 7 ~ 星期六
    weekDayOfFirstDay = [dhelper getWeek];
    
    // 月名
    monthName = _monthName[[dhelper getMonth] - 1];

    // 每行信息
    int cur = 1;
    for(int i = 0; i < 6; i++)
    {
        lines[i] = @"";
        for(int j = 0; j < 7; j++)
        {
            if(j != 0) lines[i] = [lines[i] stringByAppendingString: @" "];
            if(i == 0 && j < weekDayOfFirstDay - 1)
            {
                lines[i] = [lines[i] stringByAppendingString: @"  "];
            }
            else
            if(cur > dayCount)
            {
                lines[i] = [lines[i] stringByAppendingString: @"  "];
            }
            else
            {
                NSString* tmp = [NSString stringWithFormat: @"%2d", cur];
                lines[i] = [lines[i] stringByAppendingString: tmp];
                cur++;
            }
        }
    }

	return true;
}
@end

