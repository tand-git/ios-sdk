import UIKit
import SphereSDK

class SampleAnalyticsViewController: UITableViewController {

    @IBAction func logEventClicked(_ sender: Any) {
        // 파라미터를 포함한 이벤트 기록
        let paramBuilder = SPRParamBuilder()
            .setStringParam("param_value", forName: "param_name_1")
            .setLongParam(1, forName: "param_name_2")
            .setDoubleParam(9.9, forName: "param_name_3")
        SphereAnalytics.logEvent("event_name_1", paramBuilder: paramBuilder)

        // 파라미터가 없는 이벤트 기록
        SphereAnalytics.logEvent("event_name_2", paramBuilder: nil)
    }

    @IBAction func userPropertyClicked(_ sender: Any) {
        let isLogIn = true

        if (isLogIn) { // 로그인: ON 상태

            // 사용자 아이디 설정
            SphereAnalytics.setUserId("[USER ID]")

            // 보유 포인트 설정
            SphereAnalytics.setRemainingPoint(1000)
            // 등급 설정
            SphereAnalytics.setGrade("vip")
            // 성별 설정
            SphereAnalytics.setGender("m") // 남성일 경우: "m"
//            SphereAnalytics.setGender("f") // 여성일 경우: "f"
            // 출생년도 설정
            SphereAnalytics.setBirthYear(1995) // 출생년도
            // 이메일 설정
            SphereAnalytics.setEmail("xxxx@xxxx.com")
            // 전화번호 설정
            SphereAnalytics.setPhoneNumber("821011112222")

        } else { // 로그아웃: OFF 상태

            // 사용자 아이디 초기화
            SphereAnalytics.setUserId(nil)

            // 보유 포인트 초기화
            SphereAnalytics.resetPoints()
            // 등급 초기화
            SphereAnalytics.setGrade(nil)
            // 성별 초기화
            SphereAnalytics.setGender(nil)
            // 출생년도 초기화
            SphereAnalytics.setBirthYear(0)
            // 이메일 초기화
            SphereAnalytics.setEmail(nil)
            // 전화번호 초기화
            SphereAnalytics.setPhoneNumber(nil)
        }
    }
}
