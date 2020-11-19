//
//  ViewController.swift
//  MessageSampleSwift
//
//  Created by Hwan on 2020/11/19.
//

import UIKit
import SphereSDK

class ViewController: UITableViewController {
    
    @IBAction func agreePushInfo(_ sender: UISwitch) {
        // 정보성 푸시 발송 동의 설정 (허용:true, 거부:false)
        let agree = sender.isOn
        SpherePushMessage.agree(forInformation: agree)
    }

    @IBAction func agreePushAd(_ sender: UISwitch) {
        // 광고성 푸시 발송 동의 설정 (허용:true, 거부:false)
        let agree = sender.isOn
        SpherePushMessage.agree(forAdvertisement: agree)
    }

    @IBAction func agreePushNight(_ sender: UISwitch) {
        // 야간 푸시 발송 동의 설정 (허용:true, 거부:false)
        let agree = sender.isOn
        SpherePushMessage.agree(atNight: agree)
    }
    
}

