# iOS Sphere In-App Message 연동

* [SDK 기본 연동](#SDK-기본-연동)
  * [메시지 이미지 링크 연동](#메시지-이미지-링크-연동)
* [추가 설정](#추가-설정)
  * [Message Display Delegate 설정](#Message-Display-Delegate-설정)

## SDK 기본 연동

> 인앱 메시지 기능을 사용하기 위해서는 SDK 연동가이드의 기본 연동이 필수적으로 완료되어야 메시지 수신이 가능합니다.

* [Sphere SDK iOS 연동가이드](https://github.com/tand-git/ios-sdk) : [기본 연동](https://github.com/tand-git/ios-sdk#기본-연동)

### 메시지 이미지 링크 연동

> 인앱 메시지의 이미지 링크가 설정이 되었다면 메시지 팝업이 표시된 후 이미지 클릭 시 해당 링크로 이동을 하게 됩니다.  
> 이미지 링크가 정상적으로 연동이 되지 않았다면 해당 링크로 이동없이 팝업이 닫히게 됩니다.

기본적으로 메시지의 이미지 링크는 SDK 내부에서 `UIApplication`의 `openURL`을 통해 아래 샘플 코드와 같이 링크를 실행하게 됩니다.  
만약 앱에서 `openURL`를 통해 링크 실행이 가능한 앱링크를 지원하지 않는 경우, `SPRMessageOpenLinkDelegate`를 등록하여 전달된 이미지 링크 페이지로 이동할 수 있도록 앱에서 직접 구현해야 합니다.  
정상적으로 링크를 실행하였다면 반드시 `true`를 결과로 반환해야 합니다.

`<Swift> - AppDelegate.swift`

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SphereMessageOpenLinkDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // SphereMessageOpenLinkDelegate 설정
        SphereInAppMessage.setMessageOpenLinkDelegate(self)

        return true
    }

    func openMessageLink(_ linkUrl: String) -> Bool {
        if let url = URL(string: linkUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
            return true
        }
        return false
    }
}
```

`<Objective-C> - AppDelegate.m`

```objectivec
@interface AppDelegate () <SPRMessageOpenLinkDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // SPRMessageOpenLinkListener 설정
    [SPRInAppMessage setMessageOpenLinkDelegate:self];

    return YES;
}

- (BOOL)openMessageLink:(NSString *)linkUrl {
    NSURL *url = [NSURL URLWithString:linkUrl];

    if ([UIApplication.sharedApplication canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
        } else {
            [UIApplication.sharedApplication openURL:url];
        }
        return true;
    }
    return false;
}

@end
```

## 추가 설정

### Message Display Delegate 설정

앱에서 `SPRMessageDisplayDelegate`를 등록하면 인앱 메시지가 화면에 보여지거나 사라질 때 해당 함수를 호출하여 앱에서 필요한 작업을 수행할 수 있습니다.

`<Swift> - AppDelegate.swift`

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SphereMessageDisplayDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // SphereMessageDisplayDelegate 설정
        SphereInAppMessage.setMessageOpenLinkDelegate(self)

        return true
    }

    func messageShown(forCampaign campaignName: String) {
    // 메시지가 화면에 표시될때 호출
    }
    
    func messageDismissed(forCampaign campaignName: String) {
    // 메시지가 화면에서 사라질때 호출
    }
    
    func messageClicked(forCampaign campaignName: String, linkUrl: String) {
    // 메시지의 이미지를 클릭하여 해당 링크로 이동될때 호출
    }
}
```

`<Objective-C> - AppDelegate.m`

```objectivec
@interface AppDelegate () <SPRMessageDisplayDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // SPRMessageDisplayDelegate 설정
    [SPRInAppMessage setMessageDisplayDelegate:self];

    return YES;
}

- (void)messageShownForCampaign:(NSString *)campaignName {
    // 메시지가 화면에 표시될때 호출
}

- (void)messageDismissedForCampaign:(NSString *)campaignName {
    // 메시지가 화면에서 사라질때 호출
}

- (void)messageClickedForCampaign:(NSString *)campaignName linkUrl:(NSString *)linkUrl {
    // 메시지의 이미지를 클릭하여 해당 링크로 이동될때 호출
}

@end
```
