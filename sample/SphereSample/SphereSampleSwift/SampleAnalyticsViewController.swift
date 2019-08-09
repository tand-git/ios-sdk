import UIKit
import SphereSDK

class SampleAnalyticsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendEventClicked(_ sender: Any) {
        let paramBuilder = SPRParamBuilder()
            .setStringParam("notebook", forName: "item")
            .setLongParam(1, forName: "quantity")
            .setDoubleParam(9.9, forName: "price")
        
        SphereAnalytics.logEvent("purchase", paramBuilder: paramBuilder)
    }

    @IBAction func userIdClicked(_ sender: Any) {
        // 사용자 아이디 설정
        SphereAnalytics.setUserId("User ID")
        // 사용자 아이디 초기화
        SphereAnalytics.setUserId(nil)
    }

    @IBAction func userPropertyClicked(_ sender: Any) {
        // 사용자 속성 설정
        SphereAnalytics.setUserProperty("user_property_value", forName: "user_property_name")
        // 사용자 속성 초기화
        SphereAnalytics.setUserProperty(nil, forName: "user_property_name")
        // 사용자 속성 전체 초기화
        SphereAnalytics.resetUserProperties()
    }

}
