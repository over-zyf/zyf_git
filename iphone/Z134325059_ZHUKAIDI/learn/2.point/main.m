#import "mypoint.h"

int main()
{
    mypoint* point = [mypoint alloc];

    point = [point init];

    [point print];
    
    [point setX : 8];
    [point setY : 7];

    [point print];

    [point release];

    return 0;
}

