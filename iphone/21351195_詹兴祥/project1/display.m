//
//  display.m
//  calendar
//
//  Created by zsingsong on 13-10-5.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "display.h"
#import "Calendar.h"

@implementation display
+(void) spaceNotation:(int)n//输出空格符，n代表输出数量
{
    int i;
    for(i=0;i<n;i++)
    printf("%6c",' ');
}
+(void)displayYear:(int)y Month:(int)m //显示日历
{
int week,i,num,d;
    week=[Calendar weekByYear:y andMonth:m];
    NSLog(@"\n%20d年%02d月\n",y,m);
    printf("%6s%6s%6s%6s%6s%6s%6s\n","Sun","Mon","Tue","Wed","Thu","Fri","Sat");
    [self spaceNotation:week];
    num=[Calendar getDays:y ByMonth:m];
    for(i=1;i<=num;i++)
    {   printf("%6d",i);
        d=(week+i)%7;
        if(d==0)
            printf("\n");  }  
    printf("\n");
}

+(void)displayfun:(int)y Month:(int)m 
{
    int week,i,num,d;
    week=[Calendar weekByYear:y andMonth:m];
    
    printf("%22d月\n",m);
    printf("%6s%6s%6s%6s%6s%6s%6s\n","Sun","Mon","Tue","Wed","Thu","Fri","Sat");
    [self spaceNotation:week];
    num=[Calendar getDays:y ByMonth:m];
    for(i=1;i<=num;i++)
    {   printf("%6d",i);
        d=(week+i)%7;
        if(d==0)
            printf("\n");  }
    printf("\n");
}
+(NSMutableString*)generateSpace:(int)n
{
    NSMutableString *str=[NSMutableString new];
    for (int i=0; i<n; i++) {
    [str appendString:@" "];
    }
    return str ;
}

+(NSArray*)arrayFun:(NSMutableString*)element week:(int)week nextweek:(int)nextweek n:(int)n;
{int i,d;
bool flag=true;
    for(i=1;i<=n;i++)
    {  
        if (flag) {
            [element appendString:[self generateSpace:week*6]];
            flag=false;
        }
        [element appendFormat:@"%6d",i];
        d=(week+i)%7;
        if(d==0)
        {
            [element appendString:@","];
        }
    }
    
    [element appendString:[self generateSpace:(7-nextweek)*6]];
    [element appendString:@","];
    [element appendString:[self generateSpace:42]];
      flag=false;
    return [element componentsSeparatedByString:@","];
}

+(NSArray*)arrayFun1:(NSMutableString*)element week:(int)week n:(int)n;
{int i,d;
    bool flag=true;
    for(i=1;i<=n;i++)
    {
        if (flag) {
            [element appendString:[self generateSpace:week*6]];
            flag=false;
        }
        [element appendFormat:@"%6d",i];
        d=(week+i)%7;
        if(d==0)
        {
            [element appendString:@","];
        }
    }
   [element appendString:@","];
    flag=false;
    return [element componentsSeparatedByString:@","];
}

+(void)displayYear:(int)y
{   NSArray *monthArray=[[NSArray alloc]initWithObjects:@"",@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",nil];
    NSMutableString *fullYear=[NSMutableString new];
    int i,j,numdays1,numdays2,numdays3,week1,week2,week3;
     [fullYear appendFormat:@"\n%73d年\n\n",y];
    for (i=0;i<4; i++) {
        NSArray *array1=[NSArray new];
        NSArray *array2=[NSArray new];
        NSArray *array3=[NSArray new];
        NSMutableString *element1=[NSMutableString new];
        NSMutableString *element2=[NSMutableString new];
        NSMutableString *element3=[NSMutableString new];
        numdays1=[Calendar getDays:y ByMonth:(i*3+1)];
        numdays2=[Calendar getDays:y ByMonth:(i*3+2)];
        numdays3=[Calendar getDays:y ByMonth:(i*3+3)];
        week1=[Calendar weekByYear:y andMonth:(i*3+1)];
        week2=[Calendar weekByYear:y andMonth:(i*3+2)];
        week3=[Calendar weekByYear:y andMonth:(i*3+3)];
        [fullYear appendString:[self generateSpace:21]];
        [fullYear appendFormat:@"%@",[monthArray objectAtIndex:i*3+1]];
        [fullYear appendString:[self generateSpace:45]];
        [fullYear appendFormat:@"%@",[monthArray objectAtIndex:i*3+2]];
        [fullYear appendString:[self generateSpace:44]];
        [fullYear appendFormat:@"%@",[monthArray objectAtIndex:i*3+3]];
        [fullYear appendFormat:@"\n%6s%6s%6s%6s%6s%6s%6s","Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
        [fullYear appendFormat:@"%12s%6s%6s%6s%6s%6s%6s","Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
        [fullYear appendFormat:@"%12s%6s%6s%6s%6s%6s%6s\n","Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
       
        array1 =[self arrayFun:element1 week:week1 nextweek:week2 n:numdays1];
        array2 =[self arrayFun:element2 week:week2 nextweek:week3 n:numdays2];
        array3 =[self arrayFun1:element3 week:week3 n:numdays3];
        
        for (j=0; j<6; j++) {
            [fullYear appendString:[array1 objectAtIndex:j]];
            [fullYear appendString:[self generateSpace:6]];
            [fullYear appendString:[array2 objectAtIndex:j]];
            [fullYear appendString:[self generateSpace:6]];
            [fullYear appendString:[array3 objectAtIndex:j]];
            [fullYear appendString:@"\n\n"];
         }

    }
        NSLog(@"\n%@",fullYear);
}
@end
