//
//  main.m
//  cal
//
//  Created by J_bo on 13-10-9.
//  Copyright (c) 2013年 J_bo. All rights reserved.
//

#include<stdio.h>
#include<stdlib.h>
void main()
{
	int year,d,week,m,Y,w,c,i,j;
	printf("输入年份：");
	scanf("%d",&year);
	int month[]={31,0,31,30,31,30,31,31,30,31,30,31};
	if(year%4==0&&year%100!=0||year%400==0)
        month[1]=29;
	else month[1]=28;
	for(m=1;m<=12;m++)
	{
		int temp=0;
		if(m==1||m==2){
            temp=(m==1)?13:14;
            d = 1;
            week=(d+2*temp+3*(temp+1)/5+year+year/4-year/100+year/400)%7;
		}else
		{
			d = 1;
			week=(d+2*m+3*(m+1)/5+year+year/4-year/100+year/400+1)%7;
		}
        
        i=week;
        printf("\n              %d月\n",m);
        printf("  SUN  MON  TUE  WED  THU  FRI  SAT\n");
        //printf("  ");
        for(j=1;j<=week;j++)
            printf("     ");
        for(d=1;d<=month[m-1];d++)
        {
            i++;
            printf("%5d",d);
            if (i%7==0)
                printf("\n");
        }
        
        printf("\n");
    }
	system("pause");
    
}

