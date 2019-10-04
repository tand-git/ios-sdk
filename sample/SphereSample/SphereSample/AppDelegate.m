@import SphereSDK;

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [SPRAnalytics setSessionTimeoutInterval:60]; // 1분
    [SPRAnalytics enableLog:true]; // 활성화

    [SPRApp configureWithAppKey:@"Your Sphere SDK App Key"];

    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {

    // 딥링크 설정
    [SPRAnalytics handleOpenUrl:url];

    return YES;
}

#if !defined(__IPHONE_12_0) || __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_12_0
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray*restorableObjects))restorationHandler {

    // 딥링크 설정
    [SPRAnalytics handleContinueUserActivity:userActivity];

    return YES;
}
#else
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {

    // 딥링크 설정
    [SPRAnalytics handleContinueUserActivity:userActivity];

    return YES;
}
#endif

@end
