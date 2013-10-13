//
//  main.m
//  Hello Objective-C
//
//  Created by wang on 13-9-25.
//  Copyright (c) 2013年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

int LenOfMonth(int year,int month)
{
    int dayNumber;    //计算天数
    //如果是小月，则 30 天
    if(month==4||month==6||month==9||month==11)
        dayNumber=30;
    else if(month==2){
       if((year%4==0&&year%100!=0)||(year%400==0)) dayNumber=29;       //闰年是29天 
        else dayNumber=28;}    
    //其他大月，则 31 天
    else
        dayNumber=31;
    return dayNumber;
}



int FirstDay(int year, int month)
{
    int  n=year-1900;
    int i;
    int  dayTotal1[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    int  dayTotal2[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    n=n+(n-1)/4+1;
    n=n%7;
    for(i=0;i<month-1;i++)
    {   if((year%4==0&&year%100!=0)||(year%400==0))
        n+=dayTotal2[i];
        else
      n+=dayTotal1[i];}
    if(month!=1)
        n%=7; 
    return n; 
}


int main(int argc, const char * argv[])
{
    int i,flagInput=0; 
    int monthi,flagweek,flagc,step,month,year;
    int  weekday[13], daysOfMonth[13];
    char str[100];
    int day[13];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit |NSYearCalendarUnit fromDate:[NSDate date]];
    while(1){
    NSInteger nowmonth= [components month];
    NSInteger nowyear= [components year];
    flagc=1;
    
    for(i=0;flagc==1;i++){   //获取指令
        scanf("%c",&str[i]);
        if(str[i]=='\n') flagc=0;
    }
    
    if((str[0]=='c')&&(str[1]=='a')&&(str[2]=='l')&&(str[3]=='\n')) step=1;  //分析指令
    else if((str[0]=='c')&&(str[1]=='a')&&(str[2]=='l')&&(str[3]==' ')&&(str[4]=='-')&&(str[5]=='m')&&(str[6]==' ')){
        i=7;
        nowmonth=0;
        while(str[i]!='\n'){
            nowmonth=nowmonth*10;
            nowmonth=nowmonth+(str[i]-48);
            i++;
        }
        if((nowmonth>0)&&(nowmonth<13))step=1;
        else     step=3;
    }else if((str[0]=='c')&&(str[1]=='a')&&(str[2]=='l')&&(str[3]==' ')&&(str[4]!='-')){
        i=4;
        nowmonth=0;
        nowyear=0;
        while((str[i]!='\n')&&(str[i]!=' ')){
            nowmonth=nowmonth*10;
            nowmonth=nowmonth+(str[i]-48);
            i++;
        }
        
        if(str[i]==' '){
            i=i+1;
            while(str[i]!='\n'){
                nowyear=nowyear*10;
                nowyear=nowyear+(str[i]-48);
                i++;
            }
            step=1;
            if((nowmonth>0)&&(nowmonth<13)&&(nowyear>0)&&(nowyear<10000))step=1;
            else     step=3;
        }else{
            year=nowmonth;
            if((year>0)&&(year<10000))step=2;
            else step=3;
        }}else{
            step=3;
        }
        
            
   
  
    if(step==1){
        weekday[nowmonth]=FirstDay(nowyear,nowmonth);
        daysOfMonth[nowmonth]=LenOfMonth(nowyear,nowmonth);
        day[nowmonth]=1;
         printf("%10d月", nowmonth);
         printf("%5d\n\n", nowyear);
        printf("日  一  二   三  四   五  六\n");
        for(i=0;i<weekday[nowmonth];i++)  //根据每月第一天是星期几，来决定输出每月前面的空格
            printf("%-4c",' ');       
        for(day[nowmonth]=1;day[nowmonth]<=daysOfMonth[nowmonth];day[nowmonth]++)   //根据每月的天数，输出日子
        {
            printf("%-4d",day[nowmonth]);
            weekday[nowmonth]=(weekday[nowmonth]+1)%7;    //计算出当前是星期几，决定判断是否回车
            if(weekday[nowmonth]==0)    //如果到了周末，则换行
                printf("\n");
        }
        printf("\n");
    }
      
    
        
   
     if(step==2){
    
    for(month=1;month<=12;month++)
    {   weekday[month]=FirstDay(year,month);    
        daysOfMonth[month]=LenOfMonth(year,month);
        day[month]=1;
    }
    printf("%48d\n\n",year);
    
    
    for(month=1;month<=12;month=month+3)
    {
        
        
        for(monthi=month;monthi<(month+3);monthi++)
        {
        printf("%13d月", monthi);
        printf("                 ");
        }
        printf("\n");
        for(monthi=month;monthi<(month+3);monthi++)
        {
           printf("日  一  二   三  四   五  六");
           printf("      ");
        }
        printf("\n");
        
        
        
        for(monthi=month;monthi<(month+3);monthi++)
        {
            for(i=0;i<weekday[monthi];i++)  //根据每月第一天是星期几，来决定输出每月前面的空格
            printf("%-4c",' ');
            flagweek=1;
            while(flagweek)
            {
                printf("%-4d",day[monthi]);
                weekday[monthi]=(weekday[monthi]+1)%7;
                if(weekday[monthi]==0) flagweek=0;
                day[monthi]++;
            }
                printf("    ");
        }
        printf("\n");
        
        while(day[month]<=daysOfMonth[month])
        {
            for(monthi=month;monthi<(month+3);monthi++)
            {
                flagweek=1;
                while(flagweek)
                {
                    if(day[monthi]>daysOfMonth[monthi]) printf("    ");
                    else printf("%-4d",day[monthi]);
                    weekday[monthi]=(weekday[monthi]+1)%7;
                    day[monthi]++;
                    if(weekday[monthi]==0)  flagweek=0;
                }
                printf("    ");
            }
            printf("\n");
        }
    
        printf("\n");
    }}
        
        if(step==3){
            printf("wrong\n");
        }
    
    }
return 0;
}

        
           
