import UIKit
import SphereSDK

class SampleAnalyticsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 화면 이벤트 기록
        SphereAnalytics.logEvent("product_view", paramBuilder: nil)
    }

    @IBAction func logEventClicked(_ sender: Any) {
        // 이벤트 파라미터 설정
        let paramBuilder = SPRParamBuilder()
            .setStringParam("notebook", forName: "item")
            .setLongParam(1, forName: "quantity")
            .setDoubleParam(9.9, forName: "price")
        // 이벤트 기록
        SphereAnalytics.logEvent("purchase", paramBuilder: paramBuilder)

        // 파라미터가 없는 이벤트 기록
        SphereAnalytics.logEvent("purchase_clicked", paramBuilder: nil)
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
