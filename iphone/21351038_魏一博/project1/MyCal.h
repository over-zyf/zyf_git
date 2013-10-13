#import <Foundation/Foundation.h>

@interface MyCal : NSObject
{
	int myMonth;
	int myYear;
}

- (void) setMyMonth:(int)myMonth;
- (void) setMyYear:(int)myYear;
- (void) printUsage;//打印用法
- (void) printIncorrectMonthInfo:(const char *)m;//打印错误的月份信息
- (void) printIncorrectYearInfo:(const char *)y;//打印错误的年份信息
- (void) printIncorrectParameterInfo:(const char *)p;//打印错误的参数信息
- (void) printCalOfMonth:(const char *)m andYear:(const char *)y;//打印某一个特定年月的日历
- (void) printCalOfCurrentMonth;//打印当月的日历
- (void) printMonthOfCurrentYear:(const char *)m withParameter:(const char *)p;//打印当年的某月日历
- (void) printCalOfYear:(const char *)y;//打印某年的日历
@end
