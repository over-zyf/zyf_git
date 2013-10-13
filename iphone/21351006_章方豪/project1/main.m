//
//  main.m
//  cal
//
//  Created by zhangfh on 13-10-4.
//  Copyright (c) 2013年 zhangfh. All rights reserved.
//

#import <Foundation/Foundation.h>

char *week[7]={"Su","Mo","Tu","We","Th","Fr","Sa"};
char *months[12]={"January","February","March","April","May","June","July","August","September","October","November","December"};
int month1[12]={31,28,31,30,31,30,31,31,30,31,30,31};
int month2[12]={31,29,31,30,31,30,31,31,30,31,30,31};

int Firstday(int wday,int mday)  //根据输入日期计算月初是星期几
{
	int i,a=wday;
	for(i=mday;i>1;i--)
		a=(a+35-1)%7;
	return a;
}

bool Isleap(int y)  //判断是否为闰年
{
	if((y%4==0 && y%100!=0) || y%400==0)
		return true;
	else
		return false;
}

int fun_change(int year, int month, int day)  //基姆拉尔森计算公式，根据年月日计算星期
{
	if(month == 1 || month == 2)
	{
		month += 12;
        --year;
	}
	int week = -1;
	week = (day + 2 * month + 3 * (month + 1) / 5 + year + year / 4 -year / 100 +year / 400) % 7+1;
	if(week==7) week=0;
	return week; // 输出-1为错误
}

void disp(int days,int b)    //打印日历
{
	int i;
    int j;
    j = (b + 1) * 3 - 1;
	for(i = 0; i < 7; i++)
	{
		if(i == 0)
        {
            printf("%s", week[i]);
        }
		else
        {
            printf(" %s", week[i]);
        }
    }
    printf("\n");
    
	for(i = 1; i <= days; i++)
	{
		if(i == 1)
		{
			if(b % 7 == 0)
			{
                int k;
                for (k = 1; k < j; k++)
                {
                    printf(" ");
                }
                printf("%d", i);
				b = (b + 1) % 7;
			}
			else
			{
                int k;
                for (k = 1; k < j; k++)
                {
                    printf(" ");
                }
                printf("%d", i);
				if(b == 6)
                {
                    printf("\n");
                }
				b = (b + 1) % 7;
			}
		}
		else
		{
			if(b%7==0)
			{
                printf("%2d", i);
				b=(b+1)%7;
			}
			else
			{
                printf("%3d", i);
				if(b==6)
                {
                    printf("\n");
                }
				b=(b+1)%7;
			}
		}
	}
}


int main(int argc, char *argv[] )
{
	int firstd,year,month,day,week;
	int i,tmp;
	char tmp1[64];
	struct tm *date;
	time_t t;

	if(argc==1)
	{
		t = time(0);
		date=localtime(&t);
		strftime( tmp1, 64, "%B %Y",localtime(&t) );
        
		tmp=(15-strlen(months[date->tm_mon])) / 2;
		for(i=0;i<tmp;i++)
			printf(" ");
        puts(tmp1);
        
		year=1900+date->tm_year;
		firstd=Firstday(date->tm_wday,date->tm_mday);
        
		if(date->tm_mon==2)
		{
			if(Isleap(year))
				disp(month2[2],firstd);
			else
				disp(month1[2],firstd);
		}
		else
		{
			disp(month1[date->tm_mon],firstd);
		}
	}
    
	else if(argc==2)
	{
		if(strlen(argv[1])!=8)
			printf("日期格式输入错误!");
		else
		{
			year=0;
			for(i=0;i<4;i++)
				year=year*10+argv[1][i]-'0';
			if(year<1970||year>2050)
			{
				printf("超出范围");
				return 0;
			}
			month=(argv[1][4]-'0')*10+argv[1][5]-'0';
			if(month<1||month>12)
			{
                printf("日期错误");
				return 0;
			}
			day=(argv[1][6]-'0')*10+argv[1][7]-'0';
			if(Isleap(year))
			{
				if(day<1||day>month2[month-1])
				{
					printf("日期错误");
					return 0;
				}
			}
			else
			{
				if(day<1||day>month1[month-1])
				{
					printf("日期错误");
					return 0;
				}
			}
           
			week=fun_change(year,month,day);
			month-=1;
            
			tmp=(15-strlen(months[month]))/2;
			for(i=0;i<tmp;i++)
				printf(" ");
            printf("%s %d\n", months[month], year);
            
			firstd=Firstday(week,day);
            
			if(month==1)
			{
				if(Isleap(year))
					disp(month2[1],firstd);
				else
					disp(month1[1],firstd);
			}
			else
			{
				disp(month1[month],firstd);
			}
		}
		
	}
	else
		return 0;
	printf("\n");
	return 0; 
}
