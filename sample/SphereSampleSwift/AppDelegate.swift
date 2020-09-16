import UIKit
import SphereSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 로그 활성화
        SphereAnalytics.enableLog(true)

        // Sphere Analytics SDK 초기화
        SphereAnalytics.configure(appKey: "Your Sphere SDK App Key")

        return true
    }
}
