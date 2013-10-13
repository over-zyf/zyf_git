//
//  dateHelper.h
//  
//
//  Created by XadillaX on 13-10-10.
//
//

#import <Foundation/Foundation.h>

@interface dateHelper : NSObject
{
@private
    NSDate* date;
}

+ (dateHelper*) newDate: (NSDate*) date;
+ (dateHelper*) newDateWithYear: (int) year month: (int) month andDay: (int) day;
+ (dateHelper*) newDateWithString: (NSString*) dateString;

- (id) initDate: (NSDate*) _date;
- (id) initDateWithYear: (int) year month: (int) month andDay: (int) day;
- (id) initDateWithString: (NSString*) _dateString;

- (int) getYear;
- (int) getMonth;
- (int) getDay;
- (int) getWeek;
@end
