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

        // 푸시 알림 사용자 권한 요청
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: {_, _ in })
        application.registerForRemoteNotifications()

        // Firebase SDK 초기화
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        // Sphere SDK 초기화
        SphereAnalytics.configure(appKey: "Your Sphere SDK App Key")

        return true
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
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
}
