# iOS Sphere Push Message 연동

* [SDK 연동](#SDK-연동)
* [FCM 등록 토큰 설정](#FCM-등록-토큰-설정)
  * [앱 실행중 메시지 수신 설정 & 클릭 통계 데이터 설정](#앱-실행중-메시지-수신-설정-&-클릭-통계-데이터-설정)
  * [사용자 푸시 동의 연동](#사용자-푸시-동의-연동)
* [심화 연동](#심화-연동)
  * [iOS 메시지에 이미지 수신 설정](#ios-메시지에-이미지-수신-설정)
  * [메시지 커스텀 오픈 연동](#메시지-커스텀-오픈-연동)
  
## SDK 연동

> 푸시 메시지 기능을 사용하기 위해서는 Sphere SDK 연동가이드의 기본 연동 및 FCM(Firebase Cloud Messaging) 클라이언트 앱 설정이 필수적으로 완료되어야 메시지 수신이 가능합니다.

* [Sphere SDK iOS 연동가이드](https://github.com/tand-git/ios-sdk) : [기본 연동](https://github.com/tand-git/ios-sdk#기본-연동)
* [iOS 기반 FCM(Firebase Cloud Messaging) 클라이언트 앱 설정](https://firebase.google.com/docs/cloud-messaging/ios/client)

SDK 기본 연동 및 푸시 메시지 연동이 모두 완료된 샘플 프로젝트는 아래 샘플 소스 참조 사이트에서 확인이 가능합니다.  
샘플 프로젝트를 통해 단말에서 메시지 전송 테스트를 하기 위해서는 Firebase 콘솔에서 샘플앱 프로젝트를 생성 후 발급받은 `GoogleService-Info.plist` 파일로 교체해야 테스트가 가능합니다.

* 샘플 소스: [https://github.com/tand-git/ios-sdk/tree/master/message/sample](https://github.com/tand-git/ios-sdk/tree/master/message/sample)

### FCM 등록 토큰 설정

> FCM(Firebase Cloud Messaging)을 통해 푸시 메시지를 전송하기 위해서는 FCM 등록 토큰이 필요합니다.

Firebase의 `FIRMessagingDelegate`를 통해 전달되는 FCM 토큰을 Sphere SDK에 전달해야 합니다.

`<Swift> - AppDelegate.swift`

```swift
import SphereSDK
import Firebase

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        ...

        // Sphere SDK 푸시 토큰 설정
        SpherePushMessage.setFcmToken(fcmToken)
    }
}
```

`<Objective-C> - AppDelegate.m`

```objectivec
@import SphereSDK;
@import Firebase;

@interface AppDelegate () <FIRMessagingDelegate>
@end

@implementation AppDelegate

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {

    ...

    // Sphere SDK 푸시 토큰 설정
    [SPRPushMessage setFcmToken:fcmToken];
}

@end
```

### 앱 실행중 메시지 수신 설정 & 클릭 통계 데이터 설정

> 푸시 알림 리스너 등록 설정이 연동되지 않을 경우 Sphere 콘솔에서 "메시지 오픈"에 대한 통계 데이터가 부정확할 수 있습니다.

앱 시작 시 푸시 알림 리스너를 등록하고 푸시 메시지 수신 및 클릭 시 실행되는 해당 메소드에서 전달된 `UNNotification` 또는 `UNNotificationResponse` 객체를 Sphere SDK로 전달해야 합니다.

`<Swift> - AppDelegate.swift`

```swift
import SphereSDK
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 푸시 알림 리스너 등록 (UNUserNotificationCenterDelegate)
        UNUserNotificationCenter.current().delegate = self

        // Sphere SDK 초기화
        SphereAnalytics.configure(appKey: "Your Sphere SDK App Key")

        // Sphere 푸시 메시지 데이터 처리
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable:Any] {
            SpherePushMessage.handleReceiveNotificationUserInfo(userInfo)
        }

        return true
    }
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        if (SpherePushMessage.isSphereNotification(notification)) {
            // Sphere 푸시 메시지 데이터 처리
            SpherePushMessage.handlePresent(notification)

        } else {
            // Sphere 푸시 메시지가 아닌 경우 처리
        }

        // 앱 실행 중 푸시 메시지 수신 시 알림창 표시 옵션 설정(변경 가능)
        if #available(iOS 14.0, *) {
            completionHandler([[.list, .banner]])
        } else {
            completionHandler([[.alert]])
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        if (SpherePushMessage.isSphereNotificationResponse(response)) {
            // Sphere 푸시 메시지 데이터 처리
            SpherePushMessage.handleReceive(response)

        } else {
            // Sphere 푸시 메시지가 아닌 경우 처리
        }

        completionHandler()
    }
}
```

`<Objective-C> - AppDelegate.m`

```objectivec
@import SphereSDK;
@import Firebase;

@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 푸시 알림 리스너 등록 (UNUserNotificationCenterDelegate)
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;

    // Sphere SDK 초기화
    [SPRAnalytics configureWithAppKey:@"Your Sphere SDK App Key"];

    // Sphere 푸시 메시지 데이터 처리
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [SPRPushMessage handleReceiveNotificationUserInfo:userInfo];
    }

    return YES;
}


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

    completionHandler();
}

@end
```

### 사용자 푸시 동의 연동

> 사용자의 푸시 동의 연동은 푸시 메시지 발송 허용 여부를 판단하기 위함이며, 해당 정보를 SDK에 설정해야 합니다.

> 로그인, 로그아웃 등 푸시동의정보 변경이 발생되는 위치에 SDK 설정이 필요합니다.

정보성, 광고성 푸시 발송 동의 설정은 필수 항목이며, 야간 푸시 발송은 미설정 시 동의 거부 상태로서 야간에 푸시 메시지가 발송되지 않습니다.

> 야간 광고성 동의 설정: 야간 시간대(밤 9시 ~ 아침 8시)에 메세지를 발송 시 광고성 알림 동의와 별도로 야간 알림 동의를 받아야 합니다.

`<Swift>`

```swift
// 정보성 푸시 발송 동의 설정 (허용:true, 거부:false)
SpherePushMessage.agree(forInformation: true)
// 광고성 푸시 발송 동의 설정 (허용:true, 거부:false)
SpherePushMessage.agree(forAdvertisement: false)
// 야간 푸시 발송 동의 설정 (허용:true, 거부:false)
SpherePushMessage.agree(atNight: false)

ex)
SpherePushMessage.agree(forInformation: false)
SpherePushMessage.agree(forAdvertisement: false)
// 야간 동의 설정이 있는 경우에만
//SpherePushMessage.agree(atNight: false)
if (isLogIn) { // 로그인: ON 상태 및 사용자 정보 변경 시 설정

    // 사용자 아이디 설정
    SphereAnalytics.setUserId("[USER ID]")
    ...
    // 사용자 동의정보 설정
    SpherePushMessage.agree(forInformation: true)
    SpherePushMessage.agree(forAdvertisement: ["동의설정값"])
    // 야간 동의 설정이 있는 경우에만
    //SpherePushMessage.agree(atNight: ["동의설정값"])
} else { // 로그아웃: OFF 상태

    // 사용자 아이디 초기화
    SphereAnalytics.setUserId(nil)
    ...
    // 비회원 동의정보 설정
    SpherePushMessage.agree(forInformation: true)
    SpherePushMessage.agree(forAdvertisement: ["동의설정값"])
    // 야간 동의 설정이 있는 경우에만
    //SpherePushMessage.agree(atNight: ["동의설정값"])

}

```

`<Objective-C>`

```objectivec
// 정보성 푸시 발송 동의 설정 (허용:true, 거부:false)
[SPRPushMessage agreePushMessageForInformation:true];
// 광고성 푸시 발송 동의 설정 (허용:true, 거부:false)
[SPRPushMessage agreePushMessageForAdvertisement:false];
// 야간 푸시 발송 동의 설정 (허용:true, 거부:false)
[SPRPushMessage agreePushMessageAtNight:false];

ex)
[SPRPushMessage agreePushMessageForInformation:false];
[SPRPushMessage agreePushMessageForAdvertisement:false];
// 야간 동의 설정이 있는 경우에만
//[SPRPushMessage agreePushMessageAtNight:false]; 
if (isLogIn) { // 로그인: ON 상태

    // 사용자 아이디 설정
    [SPRAnalytics setUserId:@"[USER ID]"];
    ...
    [SPRPushMessage agreePushMessageForInformation:true];
    [SPRPushMessage agreePushMessageForAdvertisement:["동의설정값"]];
    // 야간 동의 설정이 있는 경우에만 true|false 설정 
    //[SPRPushMessage agreePushMessageAtNight:["동의설정값"]]; 
} else { // 로그아웃: OFF 상태

    // 사용자 아이디 초기화
    [SPRAnalytics setUserId:nil];
    ...
    [SPRPushMessage agreePushMessageForInformation:true];
    [SPRPushMessage agreePushMessageForAdvertisement:["동의설정값"]];
    // 야간 동의 설정이 있는 경우에만 true|false 설정 
    //[SPRPushMessage agreePushMessageAtNight:["동의설정값"]];
}
```



## 심화 연동

### iOS 메시지에 이미지 수신 설정

> 이미지를 포함한 푸시 메시지 수신 시 이미지를 알림창에 표시하기 위해서는 Xcode 프로젝트에 [Notification Service Extension](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension)을 추가해야 합니다.  
> 앱에서 이미 FCM을 통해 전달된 푸시 메시지의 이미지를 표시하고 있거나 이미지를 포함한 푸시 메시지를 사용하지 않을 경우 추가 연동은 필요하지 않습니다.

자세한 사항은 아래에 나와있는 Firebase의 클라우드 메시징 가이드 및 Apple 개발자 문서를 통해 확인이 가능하며 실제 구현된 샘플은 Sphere 푸시 메시지 샘플 프로젝트에서도 참고할 수 있습니다.

* [(Firebase) Set up the notification service extension](https://firebase.google.com/docs/cloud-messaging/ios/send-image#set_up_the_notification_service_extension)
* [(Apple Developer) Modifying Content in Newly Delivered Notifications](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications)
* [Sphere 푸시 메시지 샘플 소스](sample)

### 메시지 커스텀 오픈 연동

> 푸시 메시지 전송 시 데이터(키/값)를 함께 전달하는 기능으로 Sphere 콘솔에서 푸시메시지 입력 시 키/값을 설정해야 합니다.
* 키-값(key-value) 이용가이드: [링크](https://lightning-individual-9c1.notion.site/Key-value-c28edf104b434417879e84864a0788d3)

데이터(키/값)와 함께 푸시메시지를 전송하면 메시지 클릭 시 실행되는 `AppDelegate`로 데이터가 전달됩니다.  
만약 링크를 통해 앱 내 특정 페이지로 이동할 경우 링크에 해당하는 키/값이 `AppDelegate`로 전달되면 해당 링크를 확인하여 링크 페이지로 이동하는 코드를 구현해야 합니다.

`<Swift> - AppDelegate.swift`

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 푸시메시지 커스텀 데이터 전달 처리
        let kYourPushLinkKey = "key_your_push_link"
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable:Any] {
            if let link = userInfo[kYourPushLinkKey] {
                // 링크 페이지로 이동
            }
        }

        return true
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        // 푸시메시지 커스텀 데이터 전달 처리
        let kYourPushLinkKey = "key_your_push_link"
        let userInfo = response.notification.request.content.userInfo
        if let link = userInfo[kYourPushLinkKey] {
            // 링크 페이지로 이동
        }

        completionHandler()
    }
}
```

`<Objective-C> - AppDelegate.m`

```objectivec
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 푸시메시지 커스텀 데이터 전달 처리
    NSString *yourPushLinkKey = @"key_your_push_link";
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo[yourPushLinkKey]) {
        NSString *link = userInfo[yourPushLinkKey];
        // 링크 페이지로 이동
    }

    return YES;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){

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
```
