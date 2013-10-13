//
//  calendar.m
//  Calendar
//
//  Created by apple on 13-10-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "calendar.h"

@implementation calendar
@synthesize Year,Month,Week,Day;
-(int)calendarfistdaywithyear:(int)year month:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc] init];//初始化日期组件
    [comps setDay:1];//设置初始日期为1号
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];//初始化一个标准日历
    NSDate *date = [gregorian dateFromComponents:comps];//从日历中获得该日期的指针
    //[comps release];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];//初始化一个星期组件，来源为日历中该日期的指针
    int weekday = [weekdayComponents weekday];//调用星期组件中的weekday值，得到是星期几
    return weekday;

}
-(void) calendarwithmonth:(int)year month:(int)month
{
    calendar *cal=[[calendar alloc]init];
    printf("     %d年%d月\n",year,month);
    printf("日 一 二 三 四 五 六\n");
    int weekday=[cal calendarfistdaywithyear:year month:month];
    int temp=weekday-1;//欧美的星期标准比我们国家多一
    while(temp--)
        printf("   ");
    int m[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    if((year%4==0&&year%100!=0)||(year%400==0))
        m[1]=29;
    for(int i=1;i<=m[month-1];i++){
        if((i+weekday-2)%7==0)
        {
            if(i==1)
                  printf(" %d ",i);
           else{
                  printf("\n");
               if(i<10)
                     printf(" %d ",i);
                else printf("%d ",i);
            }
         }
        else {
            if(i<10)
                printf(" %d ",i);
            else printf("%d ",i);
         }
    }
   printf("\n");
}
+(void)calendarprintfformate:(int) year Fmonth:(int)f Smonth:(int)s Tmonth:(int)t;
{
    int weekday[12];
    int i,j,k;
    int temp,flag;
    int m[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    if((year%4==0&&year%100!=0)||(year%400==0))
        m[1]=29;
    calendar *cal=[[calendar alloc]init];
    for(i=0;i<12;i++){
        weekday[i]=[cal calendarfistdaywithyear:year month:i+1]-1;//欧美的星期标准比我们国家多一，把该年每月第一天的星期数存入数组
    }
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六 \n");
    temp=weekday[f-1];//获取第f个月第一天的星期数
    while(temp--)
        printf("   ");//第f月第一行第一天前面的空格
    i=j=k=1;
    flag=0;//设置输出第一行的标志
    while(i<=m[f-1]||j<=m[s-1]||k<=m[t-1]){//总外部循环以所有月份天数输出完作为结束
        while(i<=m[f-1]){
            if((i+weekday[f-1]-1)%7==0&&flag==0)//第f月输出为第一行，该换行时转入第s月第一行的输出
            {
                if(i==1)
                    printf(" %d ",i++);//第f月第一天时星期日时的处理
                else{
                    printf(" ");//两个月之间多一个空格
                    temp=weekday[s-1];
                    while(temp--)
                        printf("   ");//控制第s月第一行前面的空格
                    while(j<=m[s-1]&&flag==0){
                        if((j+weekday[s-1]-1)%7==0){//第s月输出为第一行，该换行时转入第t月第一行的输出
                            if(j==1)
                                printf(" %d ",j++);//第s月第一天时星期日时的处理
                            else{
                                printf(" ");//两个月之间多一个空格
                                temp=weekday[t-1];
                                while(temp--)
                                    printf("   ");//控制第t月第一行前面的空格
                                while(k<=m[t-1]&&flag==0){
                                    if((k+weekday[t-1]-1)%7==0){//第t月输出为第一行，改换行时把标志位flag＝1，输出换行
                                        if(k==1)
                                            printf(" %d ",k++);//第t月第一天时星期日时的处理
                                        else
                                        {
                                            flag++;
                                            printf("\n");
                                        }
                                    }
                                    else
                                        printf(" %d ",k++);//第t月第一行正常输出
                                }
                            }
                        }
                        else  printf(" %d ",j++);//第s月第一行正常输出
                    }
                }
                
            }
            else if (flag==0) printf(" %d ",i++);//第f月第一行正常输出
            else if(flag!=0){//输出不是第一行
                while(i<=m[f-1]||j<=m[s-1]||k<=m[t-1]){//输出结束的终止条件
                    if(i<10)
                        printf(" %d ",i++);
                    else if(i<=m[f-1]) printf("%d ",i++);
                    else{
                        i++;
                        printf("   ");
                    }//先输出第f月非第一行星期日的值，控制输出格式，如果值大于该月天数输出空格
                    
                    if((i+weekday[f-1]-1)%7==0){//第f月该换行时转入第s月的输入
                        printf(" ");//两个月之间多一个空格
                        while(i<=m[f-1]||j<=m[s-1]||k<=m[t-1]){
                            if(j<10)
                                printf(" %d ",j++);
                            else if(j<=m[s-1]) printf("%d ",j++);
                            else {
                                j++;
                                printf("   ");
                            }//先输出第s月非第一行星期日的值，控制输出格式，如果值大于该月天数输出空格
                            
                            
                            if((j+weekday[s-1]-1)%7==0)//第s月该换行时转入第t月的输入
                            {    printf(" ");//两个月之间多一个空格
                                while(i<=m[f-1]||j<=m[s-1]||k<=m[t-1]){
                                    if(k<10)
                                        printf(" %d ",k++);
                                    else if(k<=m[t-1]) printf("%d ",k++);
                                    else {
                                        k++;
                                        printf("   ");
                                    }//先输出第t月非第一行星期日的值，控制输出格式，如果值大于该月天数输出空格
                                    
                                    if((k+weekday[t-1]-1)%7==0){
                                        printf("\n");
                                        break;
                                    }//第t月该换行时换行并退出当前循环
                                    else{
                                        if(k<10)
                                            printf(" %d ",k++);
                                        else if(k<=m[t-1]) printf("%d ",k++);
                                        else {
                                            k++;
                                            printf("   ");
                                        }//第t月正常输出的输出格式，如果值大于该月天数输出空格
                                        
                                    }
                                    
                                }
                                break;//退出当前循环
                            }
                            else {
                                if(j<10)
                                    printf(" %d ",j++);
                                else if(j<=m[s-1]) printf("%d ",j++);
                                else {
                                    j++;
                                    printf("   ");
                                }//第s月正常输出的输出格式，如果值大于该月天数输出空格
                                
                            }
                            
                        }
                    }
                    else {
                        if(i<10)
                            printf(" %d ",i++);
                        else if(i<=m[f-1]) printf("%d ",i++);
                        else{
                            i++;
                            printf("   ");//第f月正常输出的输出格式，如果值大于该月天数输出空格
                        }
                    }
                    
                }
                
            }
        }
    }
    printf("\n");
    
}
-(void)calendar:(int)year
{
    //calendar *cal=[[calendar alloc]init];
    printf("                             %d年\n",year);
    printf("         一月                 二月                 三月\n");
    [calendar calendarprintfformate:year Fmonth:1 Smonth:2 Tmonth:3];
    printf("         四月                 五月                 六月\n");
    [calendar  calendarprintfformate:year Fmonth:4 Smonth:5 Tmonth:6];
    printf("         七月                 八月                 九月\n");
    [calendar  calendarprintfformate:year Fmonth:7 Smonth:8 Tmonth:9];
    printf("         十月                 十一月                十二月\n");
    [calendar  calendarprintfformate:year Fmonth:10 Smonth:11 Tmonth:12];
    
}
@end
