//
//  main.m
//  mycal
//
//  Created by leexu on 13-10-12.
//  Copyright (c) 2013年 leexu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"


int main(int argc, const char * argv[]){
    
    
    @autoreleasepool {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
        NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
        NSInteger year1 = [components year];
        NSInteger month1 = [components month];
        
        if (argc == 1) {
            int year = (int)(year1);
            int month = (int)(month1);
            Cal *cal = [[Cal alloc] init];
            [cal setYear:year];
            [cal setMonth:month];
            [cal printOfMonth];
        }
        else if (argc == 2) {
            int year = atoi(argv[1]);
            if( year < 1 || year > 9999) {
                printf("year %d not in range 1..9999\n",year);
                return -1;
            }
            else {
                for(int i = 1;i <= 12;i++) {
                    Cal *cal = [[Cal alloc] init];
                    [cal setYear:year];
                    [cal setMonth:i];
                    [cal printOfMonth];
                }
            }
        }
        else if (argc == 3) {
            if (strcmp(argv[1],"-m") == 0) {
                int month = atoi(argv[2]);
                if (month < 1||month > 12) {
                    printf("%d is neither a month number (1..12) nor a name\n",month);
                    return -1;
                }
                int year = (int)(year1);
                Cal *cal = [[Cal alloc] init];
                [cal setYear:year];
                [cal setMonth:month];
                [cal printOfMonth];
                
            }
            else {
                int month = atoi(argv[1]);
                int year = atoi(argv[2]);
                
                if( year < 1 || year > 9999){
                    printf("year %d not in range 1..9999\n",year);
                    return -1;
                }
                else {
                    if( month < 1 || month > 12){
                        printf("%d is neither a month number (1..12) nor a name\n",month);
                        return -1;
                    }
                    else{
                        Cal *cal = [[Cal alloc] init];
                        [cal setYear:year];
                        [cal setMonth:month];
                        [cal printOfMonth];
                    }
                }
            }
            
        }
        else{
            printf("usage:  ./mycal [year]\n");
            printf("        ./mycal [month] [year]\n");
            printf("        ./mycal -m [month]\n");
        }
        
        return 0;
    }
}



