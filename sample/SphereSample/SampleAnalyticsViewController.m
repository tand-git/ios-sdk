@import SphereSDK;

#import "SampleAnalyticsViewController.h"

@implementation SampleAnalyticsViewController

- (IBAction)logEventClicked:(id)sender {
    // 파라미터를 포함한 이벤트 기록
    SPRParamBuilder *paramBuilder = [SPRParamBuilder builder];
    [paramBuilder setParamWithString:@"param_value" forName:@"param_name_1"];
    [paramBuilder setParamWithLong:1 forName:@"param_name_2"];
    [paramBuilder setParamWithDouble:9.9 forName:@"param_name_3"];
    [SPRAnalytics logEventWithName:@"event_name_1" paramBuilder:paramBuilder];

    // 파라미터가 없는 이벤트 기록
    [SPRAnalytics logEventWithName:@"event_name_2" paramBuilder:nil];
}

- (IBAction)userPropertyClicked:(id)sender {

    BOOL isLogIn = true;

    if (isLogIn) { // 로그인: ON 상태

        // 사용자 아이디 설정
        [SPRAnalytics setUserId:@"[USER ID]"];

        // 보유 포인트 설정
        [SPRAnalytics setRemainingPoint:1000];
        // 등급 설정
        [SPRAnalytics setGrade:@"vip"];
        // 성별 설정
        [SPRAnalytics setGender:@"m"]; // 남성일 경우: "m"
//        [SPRAnalytics setGender:@"f"]; // 여성일 경우: "f"
        // 출생년도 설정
        [SPRAnalytics setBirthYear:1995]; // 출생년도
        // 이메일 설정
        [SPRAnalytics setEmail:@"xxxx@xxxx.com"];
        // 전화번호 설정
        [SPRAnalytics setPhoneNumber:@"821011112222"];

    } else { // 로그아웃: OFF 상태

        // 사용자 아이디 초기화
        [SPRAnalytics setUserId:nil];

        // 보유 포인트 초기화
        [SPRAnalytics resetPoints];
        // 등급 초기화
        [SPRAnalytics setGrade:nil];
        // 성별 초기화
        [SPRAnalytics setGender:nil];
        // 출생년도 초기화
        [SPRAnalytics setBirthYear:0];
        // 이메일 초기화
        [SPRAnalytics setEmail:nil];
        // 전화번호 초기화
        [SPRAnalytics setPhoneNumber:nil];
    }
}

@end
