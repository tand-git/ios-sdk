# Attribution 가이드

* [Attribution ID 설정 연동 가이드](#Attribution-ID-설정-연동-가이드)

## Attribution ID 설정 연동 가이드

Attribution ID 설정을 위해 Sphere SDK 초기화 이후 Attribution ID 설정을 위한 콜백(`SPRVendorCallback(objc) 또는 SphereVendorCallback(swift)`)을 등록하고 `updateAttributionId` 콜백 구현부에서 현재 연동된 Attribution ID를 설정합니다.

* Adjust iOS SDK 가이드: [Adjust Device Identifier](https://github.com/adjust/ios_sdk#adjust-device-identifier)
* AppsFlyer iOS SDK 가이드: [Get AppsFlyer ID](https://support.appsflyer.com/hc/en-us/articles/207032066-iOS-SDK-V6-X-integration-guide-for-developers#additional-apis-get-appsflyer-id)

* kochava iOS SDK 가이드: [Get Device ID](https://support.kochava.com/sdk-integration/ios-sdk-integration/ios-using-the-sdk/?scrollto=marker_13)

`<Objective-C> - AppDelegate.m`

```objectivec
@interface AppDelegate () <SPRVendorCallback>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Sphere Analytics SDK 초기화
    [SPRAnalytics configureWithAppKey:@"Your Sphere Analytics App Key"];

    // Attribution ID 설정 콜백 등록
    [SPRAttribution setVendorCallback:self];

    return YES;
}

- (void)updateAttributionId {
    // Adjust ID 설정
    NSString *attributionId = "업체별 ID값 입력"; //링크된 가이드 참조하여 작성

    // 어트리뷰션 업체명 입력가이드
    // Adjust : kVendorAdjust(상수값)
    // kochava : kochava
    [SPRAttribution setAttributionId:attributionId forVendor:kVendorAdjust];
    //[SPRAttribution setAttributionId:attributionId forVendor:@"kochava"];
}
@end
```

`<Swift> - AppDelegate.swift`

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Sphere Analytics SDK 초기화
        SphereAnalytics.configure(appKey: "Your Sphere Analytics App Key")

        // Attribution ID 설정 콜백 등록
        SphereAttribution.setVendorCallback(self)

        return true
    }
}

extension AppDelegate : SphereVendorCallback {
    func updateAttributionId() {
        //링크된 가이드 참조하여 작성
        let attributionId = "업체별 ID값 입력"; 
        // 어트리뷰션 업체명 입력가이드
        // Adjust : kVendorAdjust(상수값)
        // kochava : kochava
        SphereAttribution.setAttributionId(attributionId, forVendor: kVendorAdjust)
        //SphereAttribution.setAttributionId(attributionId, forVendor: "kochava")
    }
}
```
