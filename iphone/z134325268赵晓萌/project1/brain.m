//
//  brain.m
//  cal3
//
//  Created by ZhaoXM on 13-10-3.
//  Copyright (c) 2013年 ZhaoXM. All rights reserved.
//

#import "brain.h"
int month1[2][12] = {{31,28,31,30,31,30,31,31,30,31,30,31},{31,29,31,30,31,30,31,31,30,31,30,31}};
char* monthstr[12] = {"January","February","March","April","May","June","July","August","September","Octomber","November","December"};
@implementation brain


//初始化在输出12个月时用到的三个数组以及字符串
-(id)init
{

  if(self=[super init])
  {
      
      _store1=[[NSMutableArray alloc]init];
      _store2=[[NSMutableArray alloc]init];
      _store3=[[NSMutableArray alloc]init];
      _temString=[[NSMutableString alloc]init];
      
      
      
      
      
  }

return self;

}

//判断闰年、平年
-(BOOL)isLeapYear:(NSInteger)year
{
    if((year%4==0 && year%100!=0) || year%400==0)
    {
        return true;
    }
    else
    {
        return false;
    }
    
    
    
}

//计算第一天
-(int)calculateFirstDayYear:(NSInteger)year andMonth:(NSInteger)month
{
    int sum=0;
    for(int i=1900;i<year;i++)
    {
        if(i%4 != 0)
        {
            sum+=365;
        }
        else if (i%400 !=0)
        {
            sum+=366;
            
        }
        else if (i%100 !=0)
        {
            sum+=366;
            
        }
        else
        {
            sum+=365;
            
        }
        
        
    }
    int p=[self isLeapYear:year];
    
    for(int j=0;j<month-1;j++)
    {
        
        sum +=month1[p][j];
        
    }
    
    return (sum+1)%7;
    
}



//打印单一月份日历
-(void)printCalendarYear:(NSInteger)year andMonth:(NSInteger)month
{
    
  
    
    
    printf("   %s  %li\n",monthstr[month-1],(long)year);
     printf(" Su Mo Tu We Th Fr Sa\n");
    
    
    int firstDay=[self calculateFirstDayYear:year andMonth:month];
    if(firstDay!=0)
    {
        for(int i=1;i<=firstDay;i++)
        {
            printf("   ");
            
        }
    }
    int p=[self isLeapYear:year];
    for(int j=1;j<=month1[p][month-1];j++)
    {
        if(j<10)
        {
            printf("  %i",j);
        }
        else
        {
            printf(" %i",j);
        }
        if((j+firstDay)%7==0)
        {
            printf("\n");
        }
        
        
    }
printf("\n");
 
    
    
    
}



//3*4打印12个月的日历，_temstring存储一个月的日历，遍历遇到\n存入相应数组，三个月一打印
-(void)printTotalCalendarYear:(NSInteger)year andMonth:(NSInteger)month
{
   
     [ _temString setString:[NSString  stringWithFormat:@"  %s\n",monthstr[month-1] ]] ;
     [_temString appendString:@" Su Mo Tu We Th Fr Sa\n"];
    
    
    
    int firstDay=[self calculateFirstDayYear:year andMonth:month];
    if(firstDay!=0)
    {
        for(int i=1;i<=firstDay;i++)
        {
            [_temString appendString:@"   "];
            
        }
    }
    int p=[self isLeapYear:year];
    for(int j=1;j<=month1[p][month-1];j++)
    {
        if(j<10)
        {
            [_temString appendFormat: @"  %i",j ];
        }
        else
        {
            [_temString appendFormat:@" %i",j ];
        }
        if((j+firstDay)%7==0)
        {
           [_temString appendString:@"\n"];
        }
        
        
    }
    
    [_temString appendString:@"\n"];
   
    NSMutableString *temLine=[[NSMutableString alloc]init];
    
            for(int i=0;i<(int)[_temString length];i++)
            {
                
                NSString *tem=[_temString substringWithRange:NSMakeRange(i, 1)];
            
               
                
                if([tem isEqualToString:@"\n"])
                {
                   
                   //NSLog(@"%@aaaa%@wwwwwww%i",tem,temLine,i);
                    
                    if(month%3==1)
                    {
                        NSMutableString *temCopy=[temLine mutableCopy];
                       // NSLog(@"%i",(int)[temCopy length]);
                        if([_store1 count]==0)
                        {
                        for(int j=0;j<(int)(22-(int)[temCopy length])/2;j++)
                        {
                            [temLine insertString:@" " atIndex:0];
                        
                        }
                       
                        temCopy=[temLine mutableCopy];
                        }
                        for(int x=0;x<22-(int)[temCopy length];x++)
                        {
                        
                            [temLine appendString:@" "];
                            
                        }
                        [temLine appendString:@"  "];
                        temCopy=[temLine mutableCopy];
                    //[temLine appendString:@"  "];
                   // NSMutableString *temCopy=[temLine mutableCopy];
                    [_store1 addObject:temCopy];
                   // NSLog(@"%li",(unsigned long)_store1.count);
                    //NSLog(@"%@",[_store1 objectAtIndex:0]);
                   // printf("%s",[[_store1 objectAtIndex:0] UTF8String]);
                   
                    }
                    else if(month%3==2)
                    {
                        
                        NSMutableString *temCopy=[temLine mutableCopy];
                        
                        if([_store2 count]==0){
                        for(int j=0;j<(int)(22-(int)[temCopy length])/2;j++)
                        {
                            [temLine insertString:@" " atIndex:0];
                            
                        }
                        
                        temCopy=[temLine mutableCopy];
                        }
                        for(int x=0;x<22-(int)[temCopy length];x++)
                        {
                            [temLine appendString:@" "];
                            
                        }
                        [temLine appendString:@"  "];
                         temCopy=[temLine mutableCopy];
                        [_store2 addObject:temCopy];
                    // printf("%s",[[_store2 objectAtIndex:0] UTF8String]);
                    }
                    else 
                    {
                        
                         NSMutableString *temCopy=[temLine mutableCopy];
                        if([_store3 count]==0){
                        for(int j=0;j<(int)(22-(int)[temCopy length])/2;j++)
                        {
                            [temLine insertString:@" " atIndex:0];
                            
                        }
                        }
                        [temLine appendFormat:@"%@",tem];
                        temCopy=[temLine mutableCopy];
                        [_store3 addObject:temCopy];
                      //  printf("%10s",[[_store1 objectAtIndex:0] UTF8String]);
                    }
                    [temLine setString:@" "];
                    //NSLog(@"%@ffff%@wwwwwww%i",tem,temLine,i);
                   
                }
                else
                {
                
                    [temLine appendString:tem];
                
                }
             
                
            }
    
    if(month%3==0)
    {
        for(int i=0;i<7;i++)
       {
         
          printf("%s%s%s",[[_store1 objectAtIndex:i]UTF8String],[[_store2 objectAtIndex:i]UTF8String],[[_store3 objectAtIndex:i]UTF8String]);
        
          
       }
        [_store1 removeAllObjects];
        [_store2 removeAllObjects];
        [_store3 removeAllObjects];
    
        printf("\n");
    
    
    }
    


}


@end
