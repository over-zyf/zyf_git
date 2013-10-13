//
//  monthObject.h
//
//
//  Created by XadillaX on 13-10-7.
//
//

#import <Foundation/Foundation.h>

@interface monthObject : NSObject
{
@private
	int year;
	int month;

	int dayCount;
	int weekDayOfFirstDay;

	NSString* lines[6];
	NSString* monthName;
}

+ (int) GB2312Length: (NSString*) str;
+ (NSString*) header;

- (bool) initMonth: (int) _month andYear: (int) _year;
- (NSString*) monthName;
- (NSString*) lineAt: (int) index;

- (NSString*) monthNameHeader;
- (NSString*) monthNameHeaderWithYear;
@end

