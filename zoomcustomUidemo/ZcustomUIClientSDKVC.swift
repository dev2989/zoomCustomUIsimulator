//
//  ZcustomUIClientSDKVC.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation
import UIKit
import MobileRTC

class ZcustomUIClientSDKVC: UIViewController {
    @IBOutlet var baseView:UIView!
    @IBOutlet var OverLayView:UIView!
    @IBOutlet var btnLeave:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let objZmeetingroomVC = self.storyboard?.instantiateViewController(withIdentifier: "ZmeetingroomVC") as? ZmeetingroomVC
        //objZmeetingroomVC?.selectGeneredelegate = self
        self.view.addSubview((objZmeetingroomVC?.view)!)
        self.addChild(objZmeetingroomVC!)
        self.view.addSubview((objZmeetingroomVC?.view)!)
        objZmeetingroomVC?.didMove(toParent: self)
        // Do any additional setup after loading the view.
    }
    @IBAction func leaveMeeting(){
        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.leaveMeeting(with: LeaveMeetingCmd_Leave) // leave meeting
            //meetingService.leaveMeeting(with: LeaveMeetingCmd.end) // end meeting
        }
    }
}
