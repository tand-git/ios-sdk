import UIKit
import SphereSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        SphereAnalytics.setSessionTimeoutInterval(60) // 1분
        SphereAnalytics.enableLog(true) // 활성화

        SphereAnalytics.configure(appKey: "Your Sphere SDK App Key")

        return true
    }
}
