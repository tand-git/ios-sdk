//
//  AppDelegate.m
//  MessageSample
//
//  Created by Hwan on 2020/11/19.
//

@import SphereSDK;
@import Firebase;

#import "AppDelegate.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate, FIRMessagingDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 푸시 알림 리스너 등록 (UNUserNotificationCenterDelegate)
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;

    // 푸시 알림 사용자 권한 요청
    // For iOS 10 display notification (sent via APNS)
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        // ...
    }];
    [application registerForRemoteNotifications];

    // Firebase SDK 초기화
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;


    // Sphere SDK 초기화
    [SPRAnalytics configureWithAppKey:@"Your Sphere SDK App Key"];

    // Sphere 푸시 메시지 데이터 처리
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [SPRPushMessage handleReceiveNotificationUserInfo:userInfo];
    }

    // 푸시메시지 커스텀 데이터 전달 처리
    NSString *yourPushLinkKey = @"key_your_push_link";
    if (userInfo[yourPushLinkKey]) {
        NSString *link = userInfo[yourPushLinkKey];
        // 링크 페이지로 이동
    }

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    // Sphere SDK APNs 디바이스 토큰 설정
    [SPRPushMessage setAPNSDeviceToken:deviceToken];
}

#pragma mark - FIRMessagingDelegate

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.


    // Sphere SDK 푸시 토큰 설정
    [SPRPushMessage setFcmToken:fcmToken];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){

    if ([SPRPushMessage isSphereNotification:notification]) {
        // Sphere 푸시 메시지 데이터 처리
        [SPRPushMessage handlePresentNotification:notification];

    } else {
        // Sphere 푸시 메시지가 아닌 경우 처리
    }

    // 앱 실행 중 푸시 메시지 수신 시 알림창 표시 옵션 설정(변경 가능)
    if (@available(iOS 14.0, *)) {
        completionHandler(UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner);
    } else {
        completionHandler(UNNotificationPresentationOptionAlert);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){

    if ([SPRPushMessage isSphereNotificationResponse:response]) {
        // Sphere 푸시 메시지 데이터 처리
        [SPRPushMessage handleReceiveNotificationResponse:response];

    } else {
        // Sphere 푸시 메시지가 아닌 경우 처리
    }

    // 푸시메시지 커스텀 데이터 전달 처리
    NSString *yourPushLinkKey = @"key_your_push_link";
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[yourPushLinkKey]) {
        NSString *link = userInfo[yourPushLinkKey];
        // 링크 페이지로 이동
    }

    completionHandler();
}

@end
