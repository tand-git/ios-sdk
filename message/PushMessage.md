# iOS Sphere Push Message 연동

* [SDK 기본 연동](#SDK-기본-연동)
  * [Notification Service Extension](#Notification-Service-Extension)
  * [FCM 등록 토큰 설정](#FCM-등록-토큰-설정)
  * [사용자 푸시 동의 설정](#사용자-푸시-동의-설정)

## SDK 기본 연동

> 푸시 메시지 기능을 사용하기 위해서는 Sphere SDK 연동가이드의 기본 연동 및 FCM(Firebase Cloud Messaging) 클라이언트 앱 설정이 필수적으로 완료되어야 메시지 수신이 가능합니다.

* [iOS SDK 연동가이드](https://github.com/tand-git/ios-sdk) : [기본 연동](https://github.com/tand-git/ios-sdk#기본-연동)
* [iOS 기반 FCM(Firebase Cloud Messaging) 클라이언트 앱 설정](https://firebase.google.com/docs/cloud-messaging/ios/client)

### Notification Service Extension

> 이미지를 포함한 푸시 메시지를 보내기 위해서는 Xcode 프로젝트에 [Notification Service Extension](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension)을 추가해야 합니다.

자세한 사항은 아래에 나와있는 Firebase의 클라우드 메시징 가이드 및 Apple 개발자 문서를 통해 확인이 가능하며 실제 구현된 샘플은 Sphere 푸시 메시지 샘플 프로젝트를 참고하시기 바랍니다.

* [(Firebase) Set up the notification service extension](https://firebase.google.com/docs/cloud-messaging/ios/send-image#set_up_the_notification_service_extension)
* [(Apple Developer) Modifying Content in Newly Delivered Notifications](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications)
* [Sphere 푸시 메시지 샘플 소스](sample)

### FCM 등록 토큰 설정

> FCM(Firebase Cloud Messaging)을 통해 푸시 메시지를 전송하기 위해서는 FCM 등록 토큰이 필요합니다.

Firebase의 FIRMessagingDelegate를 통해 전달되는 FCM 토큰을 Sphere SDK에 전달해야 합니다.

`<Objective-C> - AppDelegate.m`

```objectivec
@import SphereSDK;
@import Firebase;

@interface AppDelegate () <FIRMessagingDelegate>
@end

@implementation AppDelegate

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {

    // Sphere SDK 푸시 토큰 설정
    [SPRPushMessage setFcmToken:fcmToken];
}

@end
```

`<Swift> - AppDelegate.swift`

```swift
import SphereSDK
import Firebase

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {

        // Sphere SDK 푸시 토큰 설정
        SpherePushMessage.setFcmToken(fcmToken)
    }
}
```

### 사용자 푸시 동의 설정

> 사용자의 푸시 동의 설정에 따라 푸시 메시지 발송 허용 여부를 판단하기 위해서는 해당 정보를 SDK에 설정해야 합니다.

정보성, 광고성 푸시 발송 동의 설정은 필수 항목이며, 야간 푸시 발송은 미설정 시 동의 거부 상태로서 야간에 푸시 메시지가 발송되지 않습니다.

`<Objective-C>`

```objectivec
// 정보성 푸시 발송 동의 설정 (허용:true, 거부:false)
[SPRPushMessage agreePushMessageForInformation:true];
// 광고성 푸시 발송 동의 설정 (허용:true, 거부:false)
[SPRPushMessage agreePushMessageForAdvertisement:true];
// 야간 푸시 발송 동의 설정 (허용:true, 거부:false)
[SPRPushMessage agreePushMessageAtNight:true];
```

`<Swift>`

```swift
// 정보성 푸시 발송 동의 설정 (허용:true, 거부:false)
SpherePushMessage.agree(forInformation: true)
// 광고성 푸시 발송 동의 설정 (허용:true, 거부:false)
SpherePushMessage.agree(forAdvertisement: true)
// 야간 푸시 발송 동의 설정 (허용:true, 거부:false)
SpherePushMessage.agree(atNight: true)
```

