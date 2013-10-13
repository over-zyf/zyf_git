//
//  main.m
//  zyf_cal
//
//  Created by zyf on 13-10-9.
//  Copyright (c) 2013年 zyf. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

char calorder[20];//输入的cal命令
int inputyear,inputmonth;//输入的年份，月份
long month,year,day;//当前的年月日

BOOL isleapyear(int x)
{
   // printf("%d\n",x);
    if((x%4==0&&x%100!=0)||(x%400==0))return YES;
    else return NO;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        //gets(calorder);
        //while(scanf("%[^\n]", calorder))
        while (gets(calorder))//读入命令
        {
            NSArray *getchineasemonth=[NSArray arrayWithObjects:@"一 月",@"二 月",@"三 月",@"四 月",@"五 月",@"六 月",@"七 月",@"八 月",@"九 月",@"十 月",@"十 一 月",@"十 二 月",nil];//输出时的月份
            NSString *weekout=[NSString stringWithFormat:@"日 一 二 三 四 五 六"];//输出时的星期
            int daysinmonth[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};//每个月的天数
            
            
            NSString *cal=[NSString stringWithUTF8String:calorder];//将命令以string形式存在cal中
            NSArray *array=[cal componentsSeparatedByString:@" "];//以空格为分隔符来切分输入命令
            NSString *iscal=@"cal";//用于判断是否是查询cal的命令
            if (![[array objectAtIndex:0] isEqualToString:iscal])//判断是否为规范的cal命令
            {
                NSLog(@"输入的命令不是查询日期的命令！请重新输入");
            }
            else
            {
                //获取当前日期
                NSDate* now = [NSDate date]; //获取当前时间
                //NSLog(@"%@",now);
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //实例化一个NSCalendar对象
                NSDateComponents *comps = [[NSDateComponents alloc] init]; //实例化一个NSDateComponents对象
                NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit ; //二进制的日期元素
                comps = [calendar components:unitFlags fromDate:now]; //调用components方法，返回NSDateComponents对象
                year = [comps year]; //获取当前年份存到year里
                month = [comps month]; //获取当前月份存到month里
                day = [comps day]; //获取当前天数存到day里
                
                //if (argc==1)//输入的命令为cal
                if([array count]==1)
                {
                    NSCalendar *gregorian = [[NSCalendar alloc]
                                             initWithCalendarIdentifier:NSGregorianCalendar];
                    //获取当月1号的星期
                    [comps setDay:1];
                    NSDate *date = [gregorian dateFromComponents:comps];
                    //[comps release];
                    NSDateComponents *weekdayComponents =
                    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
                    long weekday = [weekdayComponents weekday];
                    //NSLog(@"%ld",weekday);   //周二，值为3
                    weekday=(weekday-1+7)%7;
                    
                    if (isleapyear((int)year)==YES)//闰年
                    {
                        daysinmonth[2]++;
                    }
                    
                    //输出
                    NSLog(@"    %@ %ld",[getchineasemonth objectAtIndex:month-1],year);
                    NSLog(@"%@",weekout);
                    int curday=1;
                    for(int i=1;i<3*weekday;i++)printf(" ");
                    for(long i=weekday;curday<=daysinmonth[month];curday++)
                    {
                        if(i==0){printf("%2d",curday);}
                        else {printf("%3d",curday);}
                        i++;
                        if (i==7) {
                            printf("\n");
                            i=0;
                        }
                    }
                    printf("\n");
                }
                
                else if([array count]==2)//输入的命令为cal+year形式的
                {
                    char temp[20];//用于存cal这3个字的字符
                    sscanf(calorder, "%s%d",temp,&inputyear);//用于存储输入的月份年份
                    
                    //所要处理的日期为该年每个月的第一天
                    long monfirstweekday[13];//用于存该年每月的第一天为周几
                    for (int m=1; m<13; m++)
                    {
                        [comps setDay:1];
                        [comps setMonth:m];
                        [comps setYear:inputyear];
                        
                        NSCalendar *gregorian = [[NSCalendar alloc]
                                                 initWithCalendarIdentifier:NSGregorianCalendar];
                        NSDate *date = [gregorian dateFromComponents:comps];
                       // [comps release];
                        NSDateComponents *weekdayComponents =
                        [gregorian components:NSWeekdayCalendarUnit fromDate:date];
                        long weekday = [weekdayComponents weekday];
                        //NSLog(@"%ld",weekday);   //周二，值为3
                        monfirstweekday[m]=(weekday-1+7)%7;
                    }
                    
                    if (isleapyear(inputyear)==YES)//闰年
                    {
                        daysinmonth[2]++;
                    }
                    //输出
                    //////////////////////////////////////////////////////////////////////////
                    printf("                             %d\n\n",inputyear);
                    printf("        一月                  二月                  三月\n");
                    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
                    
                    int curday_1=1,curday_2=1,curday_3=1;//当前处理到几号
                    long curweek_1=monfirstweekday[1],curweek_2=monfirstweekday[2],curweek_3=monfirstweekday[3];//输出的该月curday为周几
                    BOOL isover_1=NO,isover_2=NO;
                    for (;curday_1<=daysinmonth[1]||curday_2<=daysinmonth[2]||curday_3<=daysinmonth[3]; )
                    {
                        
                        for (; curweek_1<7&&curday_1<=daysinmonth[1]; )
                        {
                            if(curday_1==1)
                                for(int i=1;i<3*monfirstweekday[1];i++)printf(" ");
                            
                            if(curweek_1==0){printf("%2d",curday_1);}
                            else if(curweek_1!=0){printf("%3d",curday_1);}
                            if(curday_1==daysinmonth[1])
                            {for(int i=0;i<3*(6-curweek_1);i++)printf(" ");}
                            curweek_1++;
                            curday_1++;
                            if (curweek_1==7)break;
                        }
                        curweek_1=0;
                        for (; curweek_2<7&&curday_2<=daysinmonth[2]; )
                        {
                            if(isover_1==YES&&curweek_2==0)printf("                    ");
                            
                            
                            if(curday_2==1)
                            {for(int i=1;i<3*monfirstweekday[2];i++)printf(" ");
                            printf("  ");}
                            
                            if(curweek_2==0){printf("%4d",curday_2);}
                            else if(curweek_2!=0){printf("%3d",curday_2);}
                            if(curday_2==daysinmonth[2])
                            {for(int i=0;i<3*(6-curweek_2);i++)printf(" ");}
                            curweek_2++;
                            curday_2++;
                            if (curweek_2==7)break;
                        }
                        curweek_2=0;
                        for (; curweek_3<7&&curday_3<=daysinmonth[3]; )
                        {
                            if(isover_2==YES&&curweek_3==0)
                            {
                                if (isover_1==YES) {
                                    printf("                                          ");
                                }
                                else printf("                    ");
                                ////
                                //printf("over2 %d\n",curday_2);
                            }
                            
                            
                            if(curday_3==1)
                            {for(int i=1;i<3*monfirstweekday[3];i++)printf(" ");
                               if(curweek_3!=0) printf("  ");}
                            
                            if(curweek_3==0){printf("%4d",curday_3);}
                            else if(curweek_3!=0){printf("%3d",curday_3);}
                            if(curday_3==daysinmonth[3]){printf("\n");curday_3++;break;}
                            curweek_3++;
                            curday_3++;
                            if (curweek_3==7){printf("\n");break;}
                        }
                        curweek_3=0;
                        if(curday_1>daysinmonth[1])isover_1=YES;
                        if(curday_2>daysinmonth[2])isover_2=YES;
                        //NSLog(@"*****%c",isover_1);
                        //NSLog(@"*****%c",isover_2);
                    }
                    printf("\n");
                    ////////////////////////////////////////////////////////////////////////
                    printf("        四月                  五月                  六月\n");
                    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
                    
                    int curday_4=1,curday_5=1,curday_6=1;//当前处理到几号
                    long curweek_4=monfirstweekday[4],curweek_5=monfirstweekday[5],curweek_6=monfirstweekday[6];//输出的该月curday为周几
                    BOOL isover_4=NO,isover_5=NO;
                    for (;curday_4<=daysinmonth[4]||curday_5<=daysinmonth[5]||curday_6<=daysinmonth[6]; )
                    {
                        
                        for (; curweek_4<7&&curday_4<=daysinmonth[4]; )
                        {
                            if(curday_4==1)
                                for(int i=1;i<3*monfirstweekday[4];i++)printf(" ");
                            
                            if(curweek_4==0){printf("%2d",curday_4);}
                            else if(curweek_4!=0){printf("%3d",curday_4);}
                            if(curday_4==daysinmonth[4])
                            {for(int i=0;i<3*(6-curweek_4);i++)printf(" ");}
                            curweek_4++;
                            curday_4++;
                            if (curweek_4==7)break;
                        }
                        curweek_4=0;
                        for (; curweek_5<7&&curday_5<=daysinmonth[5]; )
                        {
                            if(isover_4==YES&&curweek_5==0)printf("                    ");
                            
                            
                            if(curday_5==1)
                            {for(int i=1;i<3*monfirstweekday[5];i++)printf(" ");
                               if(curweek_5!=0) printf("  ");}
                            
                            if(curweek_5==0){printf("%4d",curday_5);}
                            else if(curweek_5!=0){printf("%3d",curday_5);}
                            if(curday_5==daysinmonth[5])
                            {for(int i=0;i<3*(6-curweek_5);i++)printf(" ");}
                            curweek_5++;
                            curday_5++;
                            if (curweek_5==7)break;
                        }
                        curweek_5=0;
                        for (; curweek_6<7&&curday_6<=daysinmonth[6]; )
                        {
                            if(isover_5==YES&&curweek_6==0)
                            {
                                if (isover_4==YES) {
                                    printf("                                          ");
                                }
                                else printf("                    ");
                            }
                           
                            
                            if(curday_6==1)
                            {for(int i=1;i<3*monfirstweekday[6];i++)printf(" ");
                               if(curweek_6!=0) printf("  ");}
                            
                            if(curweek_6==0){printf("%4d",curday_6);}
                            else if(curweek_6!=0){printf("%3d",curday_6);}
                            if(curday_6==daysinmonth[6]){printf("\n");curday_6++;break;}
                            curweek_6++;
                            curday_6++;
                            if (curweek_6==7){printf("\n");break;}
                        }
                        curweek_6=0;
                        if(curday_4>daysinmonth[4])isover_4=YES;
                        if(curday_5>daysinmonth[5])isover_5=YES;
                        //NSLog(@"*****%c",isover_1);
                        //NSLog(@"*****%c",isover_2);
                    }
                    printf("\n");
                    //////////////////////////////////////////////////////////////////////
                    printf("        七月                  八月                  九月\n");
                    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
                    
                    int curday_7=1,curday_8=1,curday_9=1;//当前处理到几号
                    long curweek_7=monfirstweekday[7],curweek_8=monfirstweekday[8],curweek_9=monfirstweekday[9];//输出的该月curday为周几
                    BOOL isover_7=NO,isover_8=NO;
                    for (;curday_7<=daysinmonth[7]||curday_8<=daysinmonth[8]||curday_9<=daysinmonth[9]; )
                    {
                        
                        for (; curweek_7<7&&curday_7<=daysinmonth[7]; )
                        {
                            if(curday_7==1)
                                for(int i=1;i<3*monfirstweekday[7];i++)printf(" ");
                            
                            if(curweek_7==0){printf("%2d",curday_7);}
                            else if(curweek_7!=0){printf("%3d",curday_7);}
                            if(curday_7==daysinmonth[7])
                            {for(int i=0;i<3*(6-curweek_7);i++)printf(" ");}
                            curweek_7++;
                            curday_7++;
                            if (curweek_7==7)break;
                        }
                        curweek_7=0;
                        for (; curweek_8<7&&curday_8<=daysinmonth[8]; )
                        {
                            if(isover_7==YES&&curweek_8==0)printf("                    ");
                            
                            
                            if(curday_8==1)
                            {for(int i=1;i<3*monfirstweekday[8];i++)printf(" ");
                               if(curweek_8!=0) printf("  ");}
                            
                            if(curweek_8==0){printf("%4d",curday_8);}
                            else if(curweek_8!=0){printf("%3d",curday_8);}
                            if(curday_8==daysinmonth[8])
                            {for(int i=0;i<3*(6-curweek_8);i++)printf(" ");}
                            curweek_8++;
                            curday_8++;
                            if (curweek_8==7)break;
                        }
                        curweek_8=0;
                        for (; curweek_9<7&&curday_9<=daysinmonth[9]; )
                        {
                            if(isover_8==YES&&curweek_9==0)
                            {
                                if (isover_7==YES) {
                                    printf("                                          ");
                                }
                                else printf("                    ");
                            }
                            
                            
                            if(curday_9==1)
                            {for(int i=1;i<3*monfirstweekday[9];i++)printf(" ");
                                if(curweek_9!=0)printf("  ");}
                            
                            if(curweek_9==0){printf("%4d",curday_9);}
                            else if(curweek_9!=0){printf("%3d",curday_9);}
                            if(curday_9==daysinmonth[9]){printf("\n");curday_9++;break;}
                            curweek_9++;
                            curday_9++;
                            if (curweek_9==7){printf("\n");break;}
                        }
                        curweek_9=0;
                        if(curday_7>daysinmonth[7])isover_7=YES;
                        if(curday_8>daysinmonth[8])isover_8=YES;
                        //NSLog(@"*****%c",isover_1);
                        //NSLog(@"*****%c",isover_2);
                    }
                    printf("\n");
                    ////////////////////////////////////////////////////////////////////////
                    printf("        十月                 十一月                十二月\n");
                    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
                    
                    int curday_10=1,curday_11=1,curday_12=1;//当前处理到几号
                    long curweek_10=monfirstweekday[10],curweek_11=monfirstweekday[11],curweek_12=monfirstweekday[12];//输出的该月curday为周几
                    BOOL isover_10=NO,isover_11=NO;
                    for (;curday_10<=daysinmonth[10]||curday_11<=daysinmonth[11]||curday_12<=daysinmonth[12]; )
                    {
                        
                        for (; curweek_10<7&&curday_10<=daysinmonth[10]; )
                        {
                            if(curday_10==1)
                                for(int i=1;i<3*monfirstweekday[10];i++)printf(" ");
                            
                            if(curweek_10==0){printf("%2d",curday_10);}
                            else if(curweek_10!=0){printf("%3d",curday_10);}
                            if(curday_10==daysinmonth[10])
                            {for(int i=0;i<3*(6-curweek_10);i++)printf(" ");}
                            curweek_10++;
                            curday_10++;
                            if (curweek_10==7)break;
                        }
                        curweek_10=0;
                        for (; curweek_11<7&&curday_11<=daysinmonth[11]; )
                        {
                            if(isover_10==YES&&curweek_11==0)printf("                    ");
                            
                            
                            if(curday_11==1)
                            {for(int i=1;i<3*monfirstweekday[11];i++)printf(" ");
                                if(curweek_11!=0) printf("  ");}
                            
                            if(curweek_11==0){printf("%4d",curday_11);}
                            else if(curweek_11!=0){printf("%3d",curday_11);}
                            if(curday_11==daysinmonth[11])
                            {for(int i=0;i<3*(6-curweek_11);i++)printf(" ");}
                            curweek_11++;
                            curday_11++;
                            if (curweek_11==7)break;
                        }
                        curweek_11=0;
                        for (; curweek_12<7&&curday_12<=daysinmonth[12]; )
                        {
                            if(isover_11==YES&&curweek_12==0)
                            {
                                if (isover_10==YES) {
                                    printf("                                          ");
                                }
                                else printf("                    ");
                            }
                            
                            
                            if(curday_12==1)
                            {for(int i=1;i<3*monfirstweekday[12];i++)printf(" ");
                                if(curweek_12!=0)printf("  ");}
                            
                            if(curweek_12==0){printf("%4d",curday_12);}
                            else if(curweek_12!=0){printf("%3d",curday_12);}
                            if(curday_12==daysinmonth[12]){printf("\n");curday_12++;break;}
                            curweek_12++;
                            curday_12++;
                            if (curweek_12==7){printf("\n");break;}
                        }
                        curweek_12=0;
                        if(curday_10>daysinmonth[10])isover_10=YES;
                        if(curday_11>daysinmonth[11])isover_11=YES;
                        //NSLog(@"*****%c",isover_1);
                        //NSLog(@"*****%c",isover_2);
                    }
                    printf("\n");

                }
                else //输入的参数有3个，cal+月+年，或者cal -m 月形式的
                {
                    if (calorder[4]=='-')//cal -m 月形式的
                    {
                        char t1[5],t2[5];//存cal和-m这两个参数
                        sscanf(calorder, "%s%s%d",t1,t2,&inputmonth);
                        
                        //所要处理的日期
                        [comps setDay:1];
                        [comps setMonth:inputmonth];
                        [comps setYear:year];
                        
                        NSCalendar *gregorian = [[NSCalendar alloc]
                                                 initWithCalendarIdentifier:NSGregorianCalendar];
                        NSDate *date = [gregorian dateFromComponents:comps];
                        //[comps release];
                        NSDateComponents *weekdayComponents =
                        [gregorian components:NSWeekdayCalendarUnit fromDate:date];
                        long weekday = [weekdayComponents weekday];
                        //NSLog(@"%ld",weekday);   //周二，值为3
                        weekday=(weekday-1+7)%7;
                        
                        if (isleapyear((int)year)==YES)//闰年
                        {
                            daysinmonth[2]++;
                        }
                        
                        //输出
                        NSLog(@"    %@ %ld",[getchineasemonth objectAtIndex:inputmonth-1],year);
                        NSLog(@"%@",weekout);
                        int curday=1;
                        for(int i=1;i<3*weekday;i++)printf(" ");
                        for(long i=weekday;curday<=daysinmonth[inputmonth];curday++)
                        {
                            if(i==0){printf("%2d",curday);}
                            else {printf("%3d",curday);}
                            i++;
                            if (i==7) {
                                printf("\n");
                                i=0;
                            }
                        }
                        printf("\n");
                    }
                    else//输入的命令为cal+month+year
                    {
                        char temp[20];//用于存cal这3个字的字符
                        sscanf(calorder, "%s%d%d",temp,&inputmonth,&inputyear);//用于存储输入的月份年份
                        
                        //所要处理的日期
                        [comps setDay:1];
                        [comps setMonth:inputmonth];
                        [comps setYear:inputyear];
                        
                        NSCalendar *gregorian = [[NSCalendar alloc]
                                                 initWithCalendarIdentifier:NSGregorianCalendar];
                        NSDate *date = [gregorian dateFromComponents:comps];
                        //[comps release];
                        NSDateComponents *weekdayComponents =
                        [gregorian components:NSWeekdayCalendarUnit fromDate:date];
                        long weekday = [weekdayComponents weekday];
                        //NSLog(@"%ld",weekday);   //周二，值为3
                        weekday=(weekday-1+7)%7;
                        
                        //输出
                        NSLog(@"    %@ %d",[getchineasemonth objectAtIndex:inputmonth-1],inputyear);
                        NSLog(@"%@",weekout);
                        int curday=1;
                        for(int i=1;i<3*weekday;i++)printf(" ");
                        
                        if (isleapyear(inputyear)==YES)//闰年
                        {
                            daysinmonth[2]++;
                        }
                        
                        for(long i=weekday;curday<=daysinmonth[inputmonth];curday++)
                        {
                            if(i==0){printf("%2d",curday);}
                            else {printf("%3d",curday);}
                            i++;
                            if (i==7)
                            {
                                printf("\n");
                                i=0;
                            }
                        }
                        printf("\n");
                    }
                }
                //[comps release];
            }
        }
    }
    return 0;
}

