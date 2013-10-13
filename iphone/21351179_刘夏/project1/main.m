//
//  main.m
//  calendar
//
//  Created by Charlotte on 13年10月4日.
//  Copyright (c) 2013年 Charlotte. All rights reserved.
//

#import "calendar.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        calendar *cal=[[calendar alloc]init];
        
        NSDate *today=[NSDate date];
        NSCalendar *gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        
        //获取当年和当月的时间
        NSDateComponents *comps=[gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:today];
        NSInteger _year = [comps year];
        NSInteger _month= [comps month];
        
        //输入cal时 ，打印当月。
        if (argc == 1) {

            [cal showCalWithYear:_year withMonth:_month];
        }
        
        //要求用户按照yyyy格式输入，否则提示出错。
        else if(argc == 2 ){
            
            int year= atoi(argv[1]);
            if (year>9999 || year<1) {
                NSLog(@"cal: %d is neither a year number (1..9999) nor a name",year);
            }else{
            [cal setYear:year];
            
            //打印年份
            for (int i=0; i<40; i++) {
                printf(" ");
            }
            printf("%d年年历\n\n",year);
            
            //打印其余部分
            int month = 1;
            
            for (int i=0; i<4; i++) {
                
                if (month<=12) {
                    [cal printMYear:year andMonth:month];
                    month+=3;
                    }
                }
            }
        }
        else if(argc == 3)
        {
            int month = 0;
            //情况一：cal M yyyy形式
            if (strlen(argv[2]) == 4) {
                
                int year=1000 * (argv[2][0] - '0') + 100 * (argv[2][1] - '0')
                + 10 * (argv[2][2] - '0') + (argv[2][3] - '0');
                
                switch (strlen(argv[1])) { 
                    case 1:
                        
                        month = argv[1][0]-'0';
                        
                        break;
                    case 2:
                        
                        month=10*(argv[1][0] -'0')+(argv[1][1] -'0');
                        
                    default:
                        break;
                    }
                
                if (month <= 12) { //判断月份
                    [cal setYear:year];
                    [cal setMonth:month];
                    
                    [cal showCalWithYear:year withMonth:month];
                    }else
                 NSLog(@"cal: %d is neither a month number (1..12) nor a name",month);
                
                }//end
            
            else if (argv[1][0]=='-' && argv[1][1]=='m') {
                
                switch (strlen(argv[2])) {
                    case 1:
                        
                        month = argv[2][0]-'0';
                        
                        break;
                    case 2:
                        
                        month=10*(argv[2][0] -'0')+(argv[2][1] -'0');
                        
                    default:
                        break;
                }

                
                if (month <=12) { //判断月份
                    [cal setYear:_year];
                    [cal setMonth:month];
                    
                    [cal showCalWithYear:_year withMonth:month];
                }else
                NSLog(@"cal: %d is neither a month number (1..12) nor a name",month);
                
                }
            }
        else
        {
        NSLog(@"\nusage of cal:\ncal\ncal year(number between 1 to 9999)\ncal month (number between 1 to 12) year\ncal -m month(number between 1 to 12)");
        }
    }
    return 0;
}