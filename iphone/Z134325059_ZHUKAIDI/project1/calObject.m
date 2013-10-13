//
//  calObject.m
//  
//
//  Created by XadillaX on 13-10-7.
//
//

#import "calObject.h"

@implementation calObject
- (id) init
{
    if(self == [super init])
    {
        year = 0;
    }
    
    return self;
}

- (bool) setYear: (int) _year
{
    if(_year < 1 || _year > 9999) return false;
    year = _year;
    for(int i = 0; i < 12; i++)
    {
        month[i] = [monthObject new];
        [month[i] initMonth: (i + 1) andYear: year];
    }
    
    return true;
}

- (NSString*) description
{
    if(year == 0) return @"";
    
    NSString* tmp = @"";
    for(int i = 0; i < 4; i++)
    {
        for(int k = 0; k < 8; k++)
        {
            for(int j = 0; j < 3; j++)
            {
                if(j != 0) tmp = [tmp stringByAppendingString: @"  "];
                    
                monthObject* cur = month[i * 3 + j];
                if(k == 0) tmp = [tmp stringByAppendingString: [cur monthNameHeader]];
                else
                if(k == 1) tmp = [tmp stringByAppendingString: [monthObject header]];
                else
                {
                    tmp = [tmp stringByAppendingString: [cur lineAt: k - 2]];
                }
            }
            
            tmp = [tmp stringByAppendingString: @"\n"];
        }
        
        //if(i != 3) tmp = [tmp stringByAppendingString: @"\n"];
    }
    
    return tmp;
}
@end
