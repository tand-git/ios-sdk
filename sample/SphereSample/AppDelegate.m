@import SphereSDK;

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [SPRAnalytics setSessionTimeoutInterval:60]; // 1분
    [SPRAnalytics enableLog:true]; // 활성화

    [SPRAnalytics configureWithAppKey:@"Your Sphere SDK App Key"];

    return YES;
}

@end
