import UIKit
import SphereSDK

class SampleAnalyticsViewController: UITableViewController {

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

    @IBAction func userPropertyClicked(_ sender: Any) {
        // 사용자 아이디 설정 - 로그인: ON 상태
        SphereAnalytics.setUserId("[USER ID]")
        // 사용자 아이디 초기화 - 로그아웃: OFF 상태
//        SphereAnalytics.setUserId(nil)

        // 등급 설정
        SphereAnalytics.setGrade("vip")
        // 성별 설정
        SphereAnalytics.setGender("m") // 남성일 경우: "m"
//        SphereAnalytics.setGender("f") // 여성일 경우: "f"
        // 출생년도 설정
        SphereAnalytics.setBirthYear(1995) // 출생년도
        // 이메일 설정
        SphereAnalytics.setEmail("xxxx@xxxx.com")
        // 전화번호 설정
        SphereAnalytics.setPhoneNumber("821011112222")

        // 사용자 포인트 설정
        SphereAnalytics.setRemainingPoint(1000) // 현재 보유 포인트
        SphereAnalytics.setTotalEarnedPoint(5000) // 총 적립 포인트
        SphereAnalytics.setTotalUsedPoint(4000) // 총 사용 포인트

        // 커스텀 사용자 속성 설정
        SphereAnalytics.setUserProperty("user_property_value", forName: "user_property_name")
        // 커스텀 사용자 속성 초기화
//        SphereAnalytics.setUserProperty(nil, forName: "user_property_name")
    }

    @IBAction func resetUserPropertiesClicked(_ sender: Any) {
        // 사용자 속성 전체 초기화
        SphereAnalytics.resetUserProperties()
    }
}
