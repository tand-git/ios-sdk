@import SphereSDK;

#import "SampleAnalyticsViewController.h"

@interface SampleAnalyticsViewController ()

@end

@implementation SampleAnalyticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // 화면 이벤트 기록
    [SPRAnalytics logPageViewEventWithPageName:@"purchase_view"];
}

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

- (IBAction)userIdClicked:(id)sender {
    // 사용자 아이디 설정
    [SPRAnalytics setUserId:@"User ID"];
    // 사용자 아이디 초기화
    [SPRAnalytics setUserId:nil];
}

- (IBAction)userPropertyClicked:(id)sender {
    // 사용자 속성 설정
    [SPRAnalytics setUserProperty:@"user_property_value" forName:@"user_property_name"];
    // 사용자 속성 초기화
    [SPRAnalytics setUserProperty:nil forName:@"user_property_name"];
    // 사용자 속성 전체 초기화
    [SPRAnalytics resetUserProperties];
}

@end
