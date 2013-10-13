#import "MyCal.h"

@implementation MyCal

- (void) setMyMonth:(int)m
{
	myMonth = m;
}

- (void) setMyYear:(int)y
{
	myYear = y;
}

- (void) printUsage
{
	printf("usage: cal [[month] year]\n");
	printf("       cal [-m month]\n");
}

- (void) printIncorrectMonthInfo:(const char *)m
{
	printf("MyCal: %s is neither a month number (1..12) nor a name\n", m);
}

- (void) printIncorrectYearInfo:(const char *)y
{
	printf("MyCal: %s is not a valid number or out of range (1..9999)\n", y);
}

-(void) printIncorrectParameterInfo:(const char *)p
{
	printf("MyCal: illegal option -- %s\n", p);
	[self printUsage];
}

- (void) printCalOfMonth:(const char *)m andYear:(const char *)y
{
	[self setMyMonth:atoi(m)];
	[self setMyYear:atoi(y)];

	//判断输入参数的有效性
	if(myMonth < 1 || myMonth > 12){
		[self printIncorrectMonthInfo:m];
		return;
	}

	else if(myYear < 1 || myYear > 9999){
		[self printIncorrectYearInfo:y];
		return;
	}
	
	int i;
	int charCount;
	int thisDay = 0;
	int enterCount;
	NSDictionary *dictMonth = [NSDictionary dictionaryWithObjectsAndKeys:
					@"January",@"1",@"February",@"2",@"March",@"3",@"April",@"4",@"May",@"5",@"June",@"6",
					@"July",@"7",@"August",@"8",@"September",@"9",@"October",@"10",@"November",@"11",@"December",@"12",
					nil];//月份名称与月份数字的对应字典
	
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setDay:1];
	[comps setMonth:myMonth];
	[comps setYear:myYear];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *date = [gregorian dateFromComponents:comps];
	NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
	int weekday = [weekdayComponents weekday];//获取当月第一天为一周的第几天
	NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
	int numberOfDaysInMonth = range.length;//获取当月的天数
	
	NSString *title = [[NSString alloc] initWithFormat:@"%s %d", [[dictMonth objectForKey:
				[[NSString alloc] initWithFormat:@"%d", myMonth]] UTF8String], myYear];
	
	//打印标题行	
	for(i = 0; i < (20 - [title length]) / 2; i++)
	{
		printf(" ");
	
	}
	printf("%s\n", [title UTF8String]);
	
	//打印星期行
	printf("Su Mo Tu We Th Fr Sa\n");
	
	//格式化按行输出打印日历
	for(i = 0; i < weekday - 1; i++)
	{
		printf("   ");
		charCount += 3;
	
	}
	for(enterCount = 0; enterCount < 6;){
		while(thisDay < numberOfDaysInMonth){
			thisDay ++;
			printf("%2d ", thisDay);
			charCount += 3;
			if(charCount % 21 == 0){
				printf("\n");
				enterCount ++;
			}
	
	}
		printf("\n");
		enterCount ++;
	}
}


- (void) printCalOfCurrentMonth
{
	NSDate *date = [NSDate date];//获取当前日期时间
	NSTimeZone *zone = [NSTimeZone systemTimeZone];
	NSInteger interval = [zone secondsFromGMTForDate: date];
	NSDate *localDate = [date  dateByAddingTimeInterval: interval];//调整时区获取本地日期时间
	NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM"];
	NSString *month = [dateFormatter stringFromDate:localDate];//获取当前日期的月份
	[dateFormatter setDateFormat:@"YYYY"];
	NSString *year = [dateFormatter stringFromDate:localDate];//获取当前日期的年份
	[self printCalOfMonth:[month UTF8String] andYear:[year UTF8String]];//调用打印某一特定年月的日历
}

- (void) printMonthOfCurrentYear:(const char *)m withParameter:(const char *)p
{
	//截取参数信息，去掉开头的‘-’字符
	char q[strlen(p) - 1];
	strncpy(q, p + 1, strlen(p) - 1);
	q[strlen(p) - 1] = '\0';

	//判断参数的有效性
	if(strcmp(q, "m") != 0){
		[self printIncorrectParameterInfo:q];
		return;
	}
	
	//获取当前日期的年份并打印本年该月的日历
	NSDate *date = [NSDate date];
	NSTimeZone *zone = [NSTimeZone systemTimeZone];
	NSInteger interval = [zone secondsFromGMTForDate: date];
	NSDate *localDate = [date  dateByAddingTimeInterval: interval];
	NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"YYYY"];
	NSString *year = [dateFormatter stringFromDate:localDate];
	[self printCalOfMonth:m andYear:[year UTF8String]];
}

- (void) printCalOfYear:(const char *)y
{
	
	[self setMyYear:atoi(y)];
	
	//判断参数的有效性
	if(myYear < 1 || myYear > 9999){
		[self printIncorrectYearInfo:y];
		return;
	}
	
	int i, j, k;
	int charCount;
	int thisDay[12] = {0,0,0,0,0,0,0,0,0,0,0,0};
	int enterCount = 0;
	int numberOfDaysInMonth[12];
	int weekday[12];
	NSMutableArray *titleOfMonth = [[NSMutableArray alloc] initWithCapacity:12];
	NSDictionary *dictMonth = [NSDictionary dictionaryWithObjectsAndKeys:
					@"January",@"1",@"February",@"2",@"March",@"3",@"April",@"4",@"May",@"5",@"June",@"6",
					@"July",@"7",@"August",@"8",@"September",@"9",@"October",@"10",@"November",@"11",@"December",@"12",
					nil];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	
	//获取1到12月的日历标题并格式化存储
	for(i = 0; i < 12; i++){
		[self setMyMonth:i + 1];
		[comps setDay:1];
		[comps setMonth:i + 1];
		[comps setYear:myYear];
		NSDate *date = [gregorian dateFromComponents:comps];
		NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
		weekday[i] = [weekdayComponents weekday];
		NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
		numberOfDaysInMonth[i] = range.length;
		NSString *title = [[NSString alloc] initWithFormat:@"%s", [[dictMonth objectForKey:
				[[NSString alloc] initWithFormat:@"%d", myMonth]] UTF8String]];
		j = [title length];
		NSMutableString *fullTitle = [[NSMutableString alloc] initWithCapacity:21];
		[fullTitle setString:title];
		for(k = 0; k < (20 - j) / 2; k++)
			[fullTitle insertString:@" " atIndex:0];
		for(k = 0; k < 20 - j - (20 - j) / 2; k++)
			[fullTitle appendString:@" "];
		[titleOfMonth addObject:fullTitle];
	}
	
	//打印年份
	for(i = 0; i < (64 - strlen(y)) / 2; i++)
		printf(" ");
	printf("%s\n\n",y);
	
	//格式化输出打印该年份的所有月的日历
	for(i = 0; i < 4; i++){
		for(j = 0; j < 3; j++)
			printf("%s  ", [[titleOfMonth objectAtIndex:3*i + j] UTF8String]);
		printf("\n");
		for(j = 0; j < 3; j++)
			printf("Su Mo Tu We Th Fr Sa  ");
		printf("\n");
		
		enterCount = 0;
		while(enterCount < 6){
			if(enterCount == 0){
				for(j = 0; j < 3; j++){
					charCount = 0;
					for(k = 0; k < weekday[3*i + j] - 1; k++){
						printf("   ");
						charCount += 3;
					}
					while(charCount < 21){
						thisDay[3*i + j] ++;
						printf("%2d ", thisDay[3*i + j]);
						charCount +=3;
					}
					printf(" ");
				}
			}
			else{
				for(j = 0; j < 3; j++){
					charCount = 0;
					while(charCount < 21 && thisDay[3*i + j] < numberOfDaysInMonth[3*i +j]){
						thisDay[3*i + j] ++;
						printf("%2d ", thisDay[3*i + j]);
						charCount +=3;
					}
					for(k = 0; k < (21 - charCount) / 3; k++)
						printf("   ");
					printf(" ");
				}
			}
			printf("\n");
			enterCount ++;
		}
	}
}

@end
