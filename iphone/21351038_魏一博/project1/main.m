#import "MyCal.h"

int main (int argc, const char * argv[])
{


	@autoreleasepool{
		MyCal *cal;
		cal = [MyCal new];
		
		//流程控制，通过判断给定的参数数量以及参数内容来实现程序的不同功能
		switch(argc){
			case 1:
				[cal printCalOfCurrentMonth];break;
			case 2:
				[cal printCalOfYear:argv[1]];break;
			case 3:
				if(*argv[1] == '-')
					[cal printMonthOfCurrentYear:argv[2] withParameter:argv[1]];
				else
					[cal printCalOfMonth:argv[1] andYear:argv[2]];
				break;
			default:
				printf("Too many arguments!\n");
				[cal printUsage];break;
		}		
    }
    return 0;
}
