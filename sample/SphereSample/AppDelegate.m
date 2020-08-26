@import SphereSDK;

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 로그 활성화
    [SPRAnalytics enableLog:true];

    // Sphere Analytics SDK 초기화
    [SPRAnalytics configureWithAppKey:@"Your Sphere SDK App Key"];

    // Sphere In-App Message 활성화
//    [SPRInAppMessage start];

    return YES;
}

@end
