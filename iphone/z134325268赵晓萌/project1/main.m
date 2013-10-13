//
//  main.m
//  cal3
//
//  Created by ZhaoXM on 13-9-29.
//  Copyright (c) 2013年 ZhaoXM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "brain.h"

//程序支持的日历查询范围从1970年1月1日至2050年12月31日

int main(int argc, const char * argv[])
{

    @autoreleasepool {
       
        //初始化对象
        brain *tem=[[brain alloc]init];
        
       //输入参数判断，若为cal，打印当年当月
       if(argc==1)
     
       {
           NSDate *today=[NSDate date];
           NSCalendar *gregorianCalendar=[[ NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
           NSDateComponents *timebody=[gregorianCalendar components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:today];
           NSInteger year=[timebody year];
           NSInteger month=[timebody month];
           
           [tem printCalendarYear:year andMonth:month];
           
       }
        
        
       //输入参数判断，若为cal 2013，打印2013全年
       else if(argc==2)
       
        {
            
            tem.year=0;
            int j=3;
            for(int i=0;i<4;i++)
            {
                
                int temple;
                temple=argv[1][i]-'0';
                tem.year+=temple*pow(10,j);
                j--;
                
            }

            if(tem.year>=1970&&tem.year<=2050)
            {
                
            printf("%34li\n",tem.year);
            printf("\n");
            
            

            for(int i=0;i<12;i++)
                
            {
              
                [tem printTotalCalendarYear:tem.year andMonth:i+1];
            
               
            }
            }
            else
            {
                printf("ERROR!\n");
                
            }
            
        }
        
        //输入参数判断
          else if(argc==3)
          {
              //若为cal －m 12，打印当年12月份日历
              const char cmd[]="-m";
              if(strcmp(argv[1],cmd)==0)
              {
                 
                  tem.month=0;
                  int j=1;
                  for(int i=0;i<2;i++)
                  {
                      
                      int temple;
                      temple=argv[2][i]-'0';
                      tem.month+=temple*pow(10,j);
                      j--;
                      
                  }
                  if(tem.month>=1&&tem.month<=12)
                  {
                      NSDate *today=[NSDate date];
                      NSCalendar *gregorianCalendar=[[ NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
                      NSDateComponents *timebody=[gregorianCalendar components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:today];
                      NSInteger year=[timebody year];
                      
                      
                      [tem printCalendarYear:year andMonth:tem.month];
                     
                  
                  }
                  else
                  {
                  
                      printf("ERROR!\n");
                  
                  }
                  

              
              
              }
              
              //若为cal 12 2012，打印2012年12月日历
   
              else
    
              {
                  
              
                  tem.year=0;
              
                  tem.month=0;
              
                  int j=1;
              
                  for(int i=0;i<2;i++)
             
                  {
                  
                  int temple;
                  temple=argv[1][i]-'0';
                  tem.month+=temple*pow(10,j);
                  j--;
                  
              
                  }
              
        
             
                  j=3;
              
                  for(int i=0;i<4;i++)
              
                  {
            
                  int temple;
                  temple=argv[2][i]-'0';
                  tem.year+=temple*pow(10,j);
                  j--;
            
              
                  }
        
        
                  if(tem.year>=1970&&tem.year<=2050&&tem.month>=1&&tem.month<=12)
        
                  {
        
            
                      [tem printCalendarYear:tem.year andMonth:tem.month];
        
        
        
                  }
        
                  else
        
                  {
            
           
                      printf("ERROR!\n");
            
        
                  }

   
              }
    

        
          
          }
     
    
    }
    
    return 0;

}

