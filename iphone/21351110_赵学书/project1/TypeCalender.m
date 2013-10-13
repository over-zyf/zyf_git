//
//  TypeCalender.m
//  PrintCalender
//
//  Created by xueshuMac on 13-9-27.
//  Copyright (c) 2013年 xueshuMac. All rights reserved.
//

#import "TypeCalender.h"
//#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, __VA_ARGS__] UTF8String]);//去掉时间戳,NSLog(@"abc");会出问题，改为下面的就可以了。
#define NSLog(FORMAT, ...) printf("%s", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define  isYear(year) (year%4==0&&year%100!=0||year%400==0)?YES:NO//判断是否是闰年


@implementation TypeCalender
@synthesize  mounthNames;
int daysOfMonth1[12]={31,28,31,30,31,30,31,31,30,31,30,31};
int daysOfMonth2[12]={31,29,31,30,31,30,31,31,30,31,30,31};//闰年

int leftMonth[6][7]={0};
int middleMonth[6][7]={0};
int rightMonth[6][7]={0};


- (id)init
{
    if (self=[super init]) {
          self.mounthNames=@[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    }
    return (self);
}


-(int) daysOfMonth:(int) _month//返回这个月有多少天。用于打印天数
{
//    if(isYear(year))
//    {
//        return daysOfMonth2[_month-1];
//    }
//    else{
//       return   daysOfMonth1[_month-1];
//    }
    /////////////////////注意isYear(year) 必须得用（）
    return (isYear(year))?(daysOfMonth2[_month-1]) : (daysOfMonth1[_month-1]);
}

-(void) setYear:(int)_year
{
    year=_year;
}

-(void) setMonth:(int)_month
{
    month=_month;
}


-(int) weekInMonth:(int) _month//基姆拉尔森计算公式 //注意一月和二月看成去年的13月14月
{
    int y=year;
    if(_month==1||_month==2)
    {
        _month+=12;
        y--;
    }
    return  (1+2*_month+3*(_month+1)/5+y+y/4-y/100+y/400+1) % 7;
}

-(void)printTitle
{  //const char*  a=[[mounthNames objectAtIndex:month-1] UTF8String];
    NSLog(@"      %@  %d \n", [mounthNames objectAtIndex:month-1] ,year);
    NSLog(@"%@\n",self);

}

-(void)printOneMonth
{
     [self printTitle];
    int weekOfMonth=[self weekInMonth:month];
    int daysOfMonth=[self daysOfMonth:month];
    for (int i=0; i<weekOfMonth; i++) {
        NSLog(@"  ");
         NSLog(@" ");
               
    }
    
    for (int i=1; i<=daysOfMonth; i++) {
        if (weekOfMonth%7==6) {
            
            NSLog(@"%2d ",i);
            NSLog(@"\n");
            if (i==daysOfMonth) {
                return ;
            }
        }
        else
        {
            NSLog(@"%2d",i);
            NSLog(@" ");
        }
        weekOfMonth++;
    }
    NSLog(@"\n");
}

-(void)setQuarterMonth:(int)quarter
{
    for (int i=0; i<6; i++) {//数组置0
        for (int j=0; j<7; j++) {
            leftMonth[i][j]=0;
            middleMonth[i][j]=0;
            rightMonth[i][j]=0;
        }
    }
    //set data in array
    for (int i=1; i<=3; i++) {
        [self  setMonth:(quarter-1)*3+i];
        int daysOfMonth=[self daysOfMonth:(quarter-1)*3+i];
        int weekInMonth= [self weekInMonth:(quarter-1)*3+i];
        int ver=0;
        int hor=0;
        BOOL first=YES;
        //  int **p;
        
        for (int j=1; j<=daysOfMonth; j++) {
            if (first) {
                if (weekInMonth==7) {
                    hor=0;
                }else{
                    hor=weekInMonth;
                }
                first=NO;
            }
            switch (i) {
                case 1:
                    leftMonth[ver][hor]=j;
                    break;
                case 2:
                    middleMonth[ver][hor]=j;
                    break;
                case 3:
                    rightMonth[ver][hor]=j;
                    break;
                default:
                    break;
            }
            hor++;
            if (hor>6) {
                ver++;
                hor=0;
            }
        }
    }//for i
}

-(void)printQuarterMonth
{
    for ( int j=0; j<6; j++) {
        for (int i=1; i<=3; i++) {
            for (int k=0; k<7; k++) {
                switch (i) {
                    case 1:
                        if(leftMonth[j][k]==0)
                        {NSLog(@"   ");
                        }
                        else
                            NSLog(@"%2d ",leftMonth[j][k]);
                        break;
                    case 2:
                        if(middleMonth[j][k]==0)
                        {
                            NSLog(@"   ");
                        }
                        else
                            NSLog(@"%2d ",middleMonth[j][k]);
                        break;
                    case 3:
                        if(rightMonth[j][k]==0)
                        {
                            NSLog(@"   ");
                        }
                        else
                            NSLog(@"%2d ",rightMonth[j][k]);
                        break;
                    default:
                        break;
                }
            }//for k
            NSLog(@"\t");
        }//for i
        NSLog(@"\n");
    }//for j
}

-(void)printQuarter:(int) quarter
{
    int firstMonthOfQuarter=(quarter-1)*3;
    /*
      第四季度 ：十一月 十二月居中显示,此处只影响xcode里的输出
     */
   /* if (quarter==4) {         NSLog(@"\t%@\t\t\t%@\t\t\t%@\n",mounthNames[firstMonthOfQuarter],mounthNames[firstMonthOfQuarter+1],mounthNames[firstMonthOfQuarter+2]);
    }
    else*/

    NSLog(@"\t%@\t\t\t%@\t\t\t%@\n",mounthNames[firstMonthOfQuarter],mounthNames[firstMonthOfQuarter+1],mounthNames[firstMonthOfQuarter+2]);

    NSLog(@"%@   %@   %@\n",self,self,self);//表头
    [self setQuarterMonth:quarter];
    [self printQuarterMonth];
}

-(void) printOneYear
{   
    NSLog(@"\t\t\t\t%d\n\n",year);//输出年份2013，居中
    for (int i=1; i<=4; i++) {
          [ self printQuarter:i];
          }
}

-(void)print
{   if(month>0)
    {
        [self printOneMonth];
    }
    else
        [self printOneYear];
}


-(NSString *)description
{
    return  @" 日 一 二 三 四 五 六";
}

@end
