//
//  main.m
//
//
//  Created by XadillaX on 13-10-7.
//
//

#import <Foundation/Foundation.h>
#import "calObject.h"
#import "monthObject.h"
#import "dateHelper.h"

void showUsage()
{
	printf("usage: ./mycal [[month] year]\n");
    printf("       ./mycal [-m month]\n");
}

void outputMonth(int year, int month)
{
	monthObject* _month = [monthObject new];
	[_month initMonth: month andYear: year];
    
	const char* str = [[_month description] UTF8String];
	printf("%s", str);
}

void outputYear(int year)
{
    calObject* cal = [calObject new];
    [cal setYear: year];

    const char* str = [[cal description] UTF8String];
    printf("%s", str);
}

int main(int argc, const char* argv[])
{
	calObject* cal = [calObject new];

	// 输出月
	if(1 == argc)
	{
		dateHelper* helper = [dateHelper newDate: [NSDate date]];
		
		int year = [helper getYear];
		int month = [helper getMonth];
        outputMonth(year, month);

		return 0;
	}
    else
    if(2 == argc && strcmp("--help", argv[1]) == 0)
    {
        showUsage();
        return 0;
    }
    else
    // 输出年
    if(2 == argc)
    {
        NSString* yearString = [[NSString alloc] initWithCString: argv[1] encoding: NSUTF8StringEncoding];
        int year = [yearString intValue];
        if(year < 1 || year > 9999)
        {
            printf("\033[31;1m[Error]\033[0m Invalid year \"%s\". (year should between 1 and 9999)\n", [yearString UTF8String]);
            return 0;
        }
    
        outputYear(year);
        
        return 0;
    }
    // 输出今年月
    else
    if(3 == argc && strcmp("-m", argv[1]) == 0)
    {
        NSString* monString = [[NSString alloc] initWithCString: argv[2] encoding: NSUTF8StringEncoding];
        int month = [monString intValue];
        if(month < 1 || month > 12)
        {
            printf("\033[31;1m[Error]\033[0m Invalid month \"%s\". (month should between 1 and 12)\n", [monString UTF8String]);
            return 0;
        }
        
        dateHelper* helper = [dateHelper newDate: [NSDate date]];
        int year = [helper getYear];
        outputMonth(year, month);
        
        return 0;
    }
    // 输出某年月
    else
    if(3 == argc)
    {
        NSString* yearString = [[NSString alloc] initWithCString: argv[2] encoding: NSUTF8StringEncoding];
        int year = [yearString intValue];
        if(year < 1 || year > 9999)
        {
            printf("\033[31;1m[Error]\033[0m Invalid year \"%s\". (year should between 1 and 9999)\n", [yearString UTF8String]);
            return 0;
        }
        
        NSString* monString = [[NSString alloc] initWithCString: argv[1] encoding: NSUTF8StringEncoding];
        int month = [monString intValue];
        if(month < 1 || month > 12)
        {
            printf("\033[31;1m[Error]\033[0m Invalid month \"%s\". (month should between 1 and 12)\n", [monString UTF8String]);
            return 0;
        }
        
        outputMonth(year, month);
        
        return 0;
    }
    else showUsage();

	return 0;
}

