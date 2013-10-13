#import "mypoint.h"

@implementation mypoint

- (void) print
{
    NSLog(@"(%i, %i)", _x, _y);
}

- (void) setX : (int) aX
{
    _x = aX;
}

- (int) getX
{
    return _x;
}

- (void) setY : (int) aY
{
    _y = aY;
}

- (int) getY
{
    return _y;
}

@end

