import UIKit
import SphereSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        SphereAnalytics.setPageTrackingEnabled(false) // 비활성화
//        SphereAnalytics.setSessionTimeoutInterval(60) // 1분
//        SphereAnalytics.setAnalyticsCollectionEnabled(false) // 비활성화
        SphereAnalytics.enableLog(true) // 활성화

        SphereApp.configure(appKey: "Your Sphere SDK App Key")

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        SphereAnalytics.handleOpen(url)

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        SphereAnalytics.handleContinue(userActivity)

        return true;
    }
}
