#import <Foundation/Foundation.h>

@interface mypoint : NSObject
{
@private
	int _x;
    int _y;
}

- (void) setX: (int) aX;
- (int) getX;

- (void) setY: (int) aY;
- (int) getY;

- (void) print;

@end

