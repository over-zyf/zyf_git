#import <Foundation/Foundation.h>

int days[]={1,1,1,1,1,1,1,1,1,1,1,1};   //全局变量定义每个月的天数
int weeks[12];                          //全局变量定义每个月第一天的星期数

int monthlong(int m,int y){             //m代表月数,y代表年数,此函数用于计算y年m月的天数
    int mday[]={31,28,31,30,31,30,31,31,30,31,30,31};
    if(y%400==0)
        mday[1]=29;
    else{
        if(y%100!=0)
            if(y%4==0)
                mday[1]=29;
    }
    return mday[m-1];
}

int calweek(int month,int year){        //month代表月数,y代表年数,此函数用于计算y年m月第一天的星期数
    int c,w;
    if(month<3){
        month+=12;
        year-=1;
    }
    c=year/100;
    year%=100;
    w=(year+(int)(year/4)+(int)(c/4)-2*c+(int)(26*(month+1)/10))%7;
    if(w<0)
        w+=7;
    return w;
}

void printday(int i,int y){             //i代表月数,y代表年数,此函数用于打印y年i月一行的日历,并且会考虑到
    for(int k=0;k<weeks[i-1];k++)       //首天的空格和末天的空格
        printf("   ");
    while(weeks[i-1]<=6){
        if(days[i-1]<=monthlong(i,y)){
    if(days[i-1]<10)
        printf("%d  ",days[i-1]);
    else
        printf("%d ",days[i-1]);
        }
        else
            printf("   ");
    days[i-1]++;
    weeks[i-1]++;
    }
        weeks[i-1]=0;
        printf(" ");
}

int main(int argc, const char * argv[])
{
    int y,m,error=0,flag=0;                            //y代表年数,m代表月数,error==0代表输入格式正确,error==1代表输入格式错误,flag为-m命令标志
    char *chmonth[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};

    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger iCurYear = [components year];
    NSInteger iCurMonth = [components month];
    m=iCurMonth;                        //获得当日所在月数
    y=iCurYear;                         //获得当日所在年数
    
    if(argc==3){                        //判断命令行参数类别
        if(!strcmp("-m",argv[1])){
            m=atoi(argv[2]);
            }
        else{
            if(strcmp("0",argv[1])&&atoi(argv[1])==0){  //判断是否为-m命令，否则打印出“无效指令”提示
                error=1;
                flag=1;
                printf("invalid instruction\n");
            }
            else{
                    m=atoi(argv[1]);
                    y=atoi(argv[2]);
        }
        }
    }
    else if(argc==2){
        y=atoi(argv[1]);
    }
    if(flag==0){
    if(m<1||m>12){                      //判断月份是否有效
        error=1;
        printf("month %d is not in range 1..12\n",m);
    }
    if(y<1||y>9999){                    //判断年份是否有效
        error=1;
        printf("year %d is not in range 1..9999\n",y);
    }
    }
    if(error==0){
    weeks[m-1]=calweek(m,y);
    if(argc!=2){
    printf("     %s %d\n",chmonth[m-1],y);
    printf("日 一 二 三 四 五 六\n");
    while(days[m-1]<=monthlong(m,y)){   //该while循环打印出了除打印全年以外情况下的月历
            printday(m,y);
            printf("\n");
        }
}
    else{                               //打印年历
        for(int i=1;i<=12;i++)
            weeks[i-1]=calweek(i,y);
        printf("                             %d\n\n",y);        
        printf("        一月                  二月                  三月\n");
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        do{
            printday(1,y);printday(2,y);printday(3,y);
            printf("\n");
        }while(days[0]<=monthlong(1,y)||days[1]<=monthlong(2,y)||days[2]<=monthlong(3,y));
        if(calweek(1,y)<5&&calweek(2,y)<5)
            printf("\n");               //控制每月共计占用8行
        printf("        四月                  五月                  六月\n");
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        do{
            printday(4,y);printday(5,y);printday(6,y);
            printf("\n");
        }while(days[3]<=monthlong(4,y)||days[4]<=monthlong(5,y)||days[5]<=monthlong(6,y));
        if(calweek(4,y)<6&&calweek(5,y)<5&&calweek(6,y)<6)
            printf("\n");        
        printf("        七月                  八月                  九月\n");
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        do{
            printday(7,y);printday(8,y);printday(9,y);
            printf("\n");
        }while(days[6]<=monthlong(7,y)||days[7]<=monthlong(8,y)||days[8]<=monthlong(9,y));
        if(calweek(7,y)<5&&calweek(8,y)<5&&calweek(9,y)<6)
            printf("\n");
        printf("        十月                 十一月                十二月\n");
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        do{
            printday(10,y);printday(11,y);printday(12,y);
            printf("\n");
        }while(days[9]<=monthlong(10,y)||days[10]<=monthlong(11,y)||days[11]<=monthlong(12,y));
        if(calweek(10,y)<5&&calweek(11,y)<6&&calweek(12,y)<5)
            printf("\n");
    }
    }
    return 0;
}










