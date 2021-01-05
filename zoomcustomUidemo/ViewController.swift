//
//  ViewController.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func JoinMeetingVC(){
        GenralSetting.Shared.meetingType = false
        let ZjoinmeetingVC = storyboard?.instantiateViewController(withIdentifier: "ZjoinmeetingVC") as? ZjoinmeetingVC
        navigationController?.pushViewController(ZjoinmeetingVC ?? UIViewController(), animated: true)
    }
    
    @IBAction func StartMeetingVC(){
        GenralSetting.Shared.meetingType = true
        let ZstartmeetingVC = storyboard?.instantiateViewController(withIdentifier: "ZstartmeetingVC") as? ZstartmeetingVC
        navigationController?.pushViewController(ZstartmeetingVC ?? UIViewController(), animated: true)
    }
    
    @IBAction func JointClientSDKMeetingVC(){
        GenralSetting.Shared.meetingType = false
        let ZstartmeetingVC = storyboard?.instantiateViewController(withIdentifier: "ZcustomUIClientSDKVC") as? ZcustomUIClientSDKVC
        navigationController?.pushViewController(ZstartmeetingVC ?? UIViewController(), animated: true)
    }

}

