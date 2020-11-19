//
//  ViewController.m
//  MessageSample
//
//  Created by Hwan on 2020/11/19.
//

@import SphereSDK;

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)agreePushInfo:(UISwitch *)sender {
    // 정보성 푸시 발송 동의 설정 (허용:true, 거부:false)
    BOOL agree = sender.on;
    [SPRPushMessage agreePushMessageForInformation:agree];
}

- (IBAction)agreePushAd:(UISwitch *)sender {
    // 광고성 푸시 발송 동의 설정 (허용:true, 거부:false)
    BOOL agree = sender.on;
    [SPRPushMessage agreePushMessageForAdvertisement:agree];
}

- (IBAction)agreePushNight:(UISwitch *)sender {
    // 야간 푸시 발송 동의 설정 (허용:true, 거부:false)
    BOOL agree = sender.on;
    [SPRPushMessage agreePushMessageAtNight:agree];
}

@end
