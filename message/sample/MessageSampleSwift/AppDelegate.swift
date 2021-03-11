//
//  AppDelegate.swift
//  MessageSampleSwift
//
//  Created by Hwan on 2020/11/19.
//

import UIKit
import SphereSDK
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 푸시 알림 리스너 등록 (UNUserNotificationCenterDelegate)
        UNUserNotificationCenter.current().delegate = self

        // 푸시 알림 사용자 권한 요청
        // For iOS 10 display notification (sent via APNS)
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        application.registerForRemoteNotifications()

        // Firebase SDK 초기화
        FirebaseApp.configure()
        Messaging.messaging().delegate = self


        // Sphere SDK 초기화
        SphereAnalytics.configure(appKey: "Your Sphere SDK App Key")

        // Sphere 푸시 메시지 데이터 처리
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable:Any] {
            SpherePushMessage.handleReceiveNotificationUserInfo(userInfo)
        }

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        // Sphere SDK APNs 디바이스 토큰 설정
        SpherePushMessage.setAPNSDeviceToken(deviceToken)
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.


        // Sphere SDK 푸시 토큰 설정
        SpherePushMessage.setFcmToken(fcmToken)
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

        // 푸시메시지 커스텀 데이터 전달 처리
        let kYourPushLinkKey = "key_your_push_link"
        let userInfo = response.notification.request.content.userInfo
        if let link = userInfo[kYourPushLinkKey] {
            // 링크 페이지로 이동
        }

        completionHandler()
    }
}
