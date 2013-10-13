//
//  calObject.h
//  
//
//  Created by XadillaX on 13-10-7.
//
//

#import <Foundation/Foundation.h>
#import "monthObject.h"

@interface calObject : NSObject
{
@private
    monthObject* month[12];
    
    int year;
}

- (bool) setYear: (int) _year;

@end
