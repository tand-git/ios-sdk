@import SphereSDK;

#import "SampleAnalyticsViewController.h"

@implementation SampleAnalyticsViewController

- (IBAction)logEventClicked:(id)sender {
    // 이벤트 파라미터 설정
    SPRParamBuilder *paramBuilder = [SPRParamBuilder builder];
    [paramBuilder setParamWithString:@"notebook" forName:@"item"];
    [paramBuilder setParamWithLong:1 forName:@"quantity"];
    [paramBuilder setParamWithDouble:9.9 forName:@"price"];
    // 이벤트 기록
    [SPRAnalytics logEventWithName:@"purchase" paramBuilder:paramBuilder];

    // 파라미터가 없는 이벤트 기록
    [SPRAnalytics logEventWithName:@"purchase_clicked" paramBuilder:nil];
}

- (IBAction)userPropertyClicked:(id)sender {

    BOOL isLogIn = true;

    if (isLogIn) { // 로그인: ON 상태

        // 사용자 아이디 설정
        [SPRAnalytics setUserId:@"[USER ID]"];

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

        // 사용자 포인트 설정
        [SPRAnalytics setRemainingPoint:1000]; // 현재 보유 포인트
        [SPRAnalytics setTotalEarnedPoint:5000]; // 총 적립 포인트
        [SPRAnalytics setTotalUsedPoint:4000]; // 총 사용 포인트

    } else { // 로그아웃: OFF 상태

        // 사용자 아이디 초기화
        [SPRAnalytics setUserId:nil];

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

        // 사용자 포인트 초기화
        [SPRAnalytics resetPoints];
    }

    // 커스텀 사용자 속성 설정
    [SPRAnalytics setUserProperty:@"user_property_value" forName:@"user_property_name"];
    // 커스텀 사용자 속성 초기화
//    [SPRAnalytics setUserProperty:nil forName:@"user_property_name"];
}

- (IBAction)resetUserPropertiesClicked:(id)sender {
    // 사용자 속성 전체 초기화
    [SPRAnalytics resetUserProperties];
}

@end
