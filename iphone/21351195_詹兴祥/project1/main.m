//
//  main.m
//  calendar
//
//  Created by zsingsong on 13-10-5.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "display.h"
#import "Calendar.h"

int main(int argc, const char * argv[])
{
      @autoreleasepool {
          switch (argc) {
                 case 1:
                NSLog(@"\nno data!pelease input data!!");
                  break;
                case 2:
              {
                  NSString *cal=[NSString stringWithUTF8String:argv[1]];
                  if ([cal isEqualToString:@"cal"]) {
                      NSDate *now=[NSDate date];
                      NSCalendar *calendar=[NSCalendar currentCalendar];
                      NSDateComponents *compt=[calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:now];
                      [display displayYear:(int)[compt year] Month:(int)[compt month]];
                  }
                  else
                  {
                      NSLog(@"data you input isn't variable!");
                      return -1;
                  }
                  break;
              }
                  case 3:
              {int year=[[NSString stringWithUTF8String:argv[2]] intValue];
                  if(year<=0 || year>=9999){
                      NSLog(@"\n'%s' you input isn't right!\n",argv[2]);
                  }
                  else{
                      [display displayYear:year];}
                  break;
              }
                  case 4:
              {
                  int month=[[NSString stringWithUTF8String:argv[2] ]intValue];
                  int year1=[[NSString stringWithUTF8String:argv[3] ]intValue];
                  if(year1<=0 || year1>=9999){
                      NSLog(@"\n'%s' you input isn't right!\n",argv[3]);
                      return -1;
                  }
                  if(month<1||month>12)
                  {
                      NSLog(@"\n'%s' you input isn't right!\n",argv[2]);
                      return -1;
                  }
                  [display displayYear:year1 Month:month];

                  break;
              }
              default:
                  NSLog(@"\n please input data(cal,cal 2013,cal 2,2013)");
                  break;
          }

    return 0;
}
}
