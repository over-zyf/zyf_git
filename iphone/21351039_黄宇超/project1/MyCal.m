//
//  MyCal.m
//  mycal
//
//  Created by 宇超 黄 on 13-10-8.
//  Copyright (c) 2013年 宇超 黄. All rights reserved.
//

#import "MyCal.h"

@implementation MyCal
-(id)init
{
    if(self=[super init])
    {
        leap=0;
        year=0;
        month=0;
        months[0]="一月";months[1]="二月";months[2]="三月";months[3]="四月";months[4]="五月";months[5]="六月";
        months[6]="七月";months[7]="八月";months[8]="九月";months[9]="十月";months[10]="十一月";
        months[11]="十二月";
        
        dayOfMonth[0][0] = 0; dayOfMonth[0][1] = 31;  dayOfMonth[0][2] = 28; dayOfMonth[0][3] = 31;
        dayOfMonth[0][4] = 30; dayOfMonth[0][5] = 31;  dayOfMonth[0][6] = 30; dayOfMonth[0][7] = 31;
        dayOfMonth[0][8] = 31; dayOfMonth[0][9] = 30; dayOfMonth[0][10] = 31; dayOfMonth[0][11] = 30;
        dayOfMonth[0][12] = 31;
        dayOfMonth[1][0] = 0; dayOfMonth[1][1] = 31;  dayOfMonth[1][2] = 29; dayOfMonth[1][3] = 31;
        dayOfMonth[1][4] = 30; dayOfMonth[1][5] = 31;  dayOfMonth[1][6] = 30; dayOfMonth[1][7] = 31;
        dayOfMonth[1][8] = 31; dayOfMonth[1][9] = 30; dayOfMonth[1][10] = 31; dayOfMonth[1][11] = 30;
        dayOfMonth[1][12] = 31;
    }
    return self;
}
-(void)setYear:(NSInteger)y
{
    year=y;
    [self isLeapYear];
}
-(void)setMonth:(NSInteger)m
{
    month=m;
}
-(void)isLeapYear
{
    if((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))
        leap=1;
}
-(NSInteger)fisrtOfYear
{
    double s ;
    s=(year-1+floor((year-1)/4.0)-floor((year-1)/100.0)+floor((year-1)/400.0)+1);
    return (NSInteger)s%7;
}
//算出每个月前面的空格
-(NSInteger)firstDayOfMonth
{
    NSInteger sum=self.fisrtOfYear;
    for(int i=0;i<month;i++)
        sum+=dayOfMonth[leap][i];
    return sum%7;
}
//打印一个月的日历
-(void)printMonth
{
    NSInteger f=self.firstDayOfMonth;
    printf("     %s %ld\n",months[month-1],(long)year);
    printf("日 一 二 三 四 五 六\n");
    int space=(int)self.firstDayOfMonth;
    for(int i=0;i<space;i++)
        printf("   ");
    for(int i=1;i<=dayOfMonth[leap][month];i++)
    {
        printf("%2d ",i);
        f++;
        if(f%7==0)
            printf("\n");
    }
    printf("\n\n");
}
//打印每年
-(void)printYear
{
    NSInteger a[12];
    NSInteger k;
    int q[4][6][23]={0};
    for(int i=0;i<12;i++)
    {
        month=i+1;
        a[i]=self.firstDayOfMonth;
    }
    int aa,bb,cc;
    printf("                             %ld\n\n",(long)year);
    for (int i=0; i<4; i++) {
        switch(i)
        {
            case 0:printf("        一月                  二月                  三月\n");break;
            case 1:printf("        四月                  五月                  六月\n");break;
            case 2:printf("        七月                  八月                  九月\n");break;
            case 3:printf("        十月                 十一月                十二月\n");break;
        }
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");

        aa=bb=cc=1;
        for (int j=0; j<6; j++) {
            if (j==0) {
                for (k=a[3*i]; k<7; k++,aa++)
                    q[i][j][k]=aa;
                for(k=a[3*i+1]+8;k<15;k++,bb++)
                    q[i][j][k]=bb;
                for(k=a[3*i+2]+16;k<23;k++,cc++)
                    q[i][j][k]=cc;
            }
            else{
                for(k=0;k<7&&aa<=dayOfMonth[leap][3*i+1];k++,aa++)
                    q[i][j][k]=aa;
                for(k=8;k<15&&bb<=dayOfMonth[leap][3*i+2];k++,bb++)
                    q[i][j][k]=bb;
                for(k=16;k<23&&cc<=dayOfMonth[leap][3*i+3];k++,cc++)
                    q[i][j][k]=cc;
            }
            for(k=0;k<23;k++)
            {
                if(q[i][j][k]==0)
                {
                    if(k==7 || k==15)
                        printf(" ");
                    else
                    printf("   ");
                }
                else
                {
                    if (k==22) {
                        printf("%2d",q[i][j][k]);
                    }
                    else
                        printf("%2d ",q[i][j][k]);
                }
            }
            printf("\n");
            
        }

    }
    
}
@end
