//
//  CmdAnalyzer.m
//  project1
//
//  Created by xyj on 13-10-11.
//  Copyright (c) 2013年 xyj. All rights reserved.
//

#import "CmdAnalyzer.h"

#import "CmdAnalyzer.h"
#import "MyCalendar.h"
@implementation CmdAnalyzer

-(id) init: (char*)str
{
    if(self = [super init])
    {
        strSource = str;
    }
    return self;
}
//去处多余的空格,将大写均变为小写
-(void) change2NormalCmd
{
    for(int i=0;strSource[i];i++)
    {
        if(strSource[i]==' ' &&i &&strSource[i-1]==' '){
            strcpy(strSource+i,strSource+i+1);
            i--;
        }
        if(strSource[i]>='A' && strSource[i]<='Z')
            strSource[i]=strSource[i]-'A'+'a';
    }
}
/*********************************************
 
 在字符串中数空格数
 
 *********************************************/
-(int) countSpaces: (int *)pSecondSpace
{
    int nCount = 0;
    *pSecondSpace = 0;
    for(int i=0;strSource[i];i++)
    {
        if(strSource[i]==' ')
        {
            nCount++;
            if(nCount == 2)*pSecondSpace = i;
        }
    }
    return nCount;
}
/*********************************************
 
 把字符串转化成数值
 
 *********************************************/
-(int) convertFromStr2Int
{
    int nResult = 0;
    for(int i=0; strSource[i]; i++)
    {
        nResult =nResult*10 + strSource[i] - '0';
    }
    return nResult;
}
/**********************************************
 
 在输入的指令中提取年份及月份
 若指令有误，返回false；
 若指令为cal 返回当前的年与月
 若指令为cal xx，返回指定年，月为0
 若指令为cal xx xx ，返回指定的年月
 
 **********************************************/
-(bool) getYearAndMonth: (int *)pYear AndMonth: (int *)pMonth
{
    strSource = strSource + 3;
    char* strTemp = strSource;
    
    int nSecondSpace;
    int nSpaceNum ;
    
    nSpaceNum = [self countSpaces: &nSecondSpace];
    
    if(nSpaceNum > 2)return false;
    if(nSpaceNum == 0)
        [MyCalendar getCurrentTime: pYear AndMonth: pMonth];
    else if(nSpaceNum == 1)
    {
        strSource = strTemp +1;
        *pYear =[self convertFromStr2Int];
        *pMonth = 0;
    }
    else
    {
        NSLog(@"%d",nSecondSpace);
        strSource = strTemp + nSecondSpace +1;
        *pYear =[self convertFromStr2Int];
        strTemp[nSecondSpace] = '\0';
        strSource = strTemp + 1;
        *pMonth =[self convertFromStr2Int];
    }
    return true;
}
@end
