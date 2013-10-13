#import <Foundation/Foundation.h>

@interface MyCal : NSObject
{
	int myMonth;
	int myYear;
}

- (void) setMyMonth:(int)myMonth;
- (void) setMyYear:(int)myYear;
- (void) printUsage;//��ӡ�÷�
- (void) printIncorrectMonthInfo:(const char *)m;//��ӡ������·���Ϣ
- (void) printIncorrectYearInfo:(const char *)y;//��ӡ����������Ϣ
- (void) printIncorrectParameterInfo:(const char *)p;//��ӡ����Ĳ�����Ϣ
- (void) printCalOfMonth:(const char *)m andYear:(const char *)y;//��ӡĳһ���ض����µ�����
- (void) printCalOfCurrentMonth;//��ӡ���µ�����
- (void) printMonthOfCurrentYear:(const char *)m withParameter:(const char *)p;//��ӡ�����ĳ������
- (void) printCalOfYear:(const char *)y;//��ӡĳ�������
@end
