//
//  ZDefaultUIjoinmeetingRoomVC.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation
import UIKit
import MobileRTC

class ZDefaultUIjoinmeetingRoomVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
        //NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
        self.JointMeeting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        if let meetingService = MobileRTC.shared().getMeetingService() {
//            meetingService.leaveMeeting(with: LeaveMeetingCmd.leave) // leave meeting
//            //meetingService.leaveMeeting(with: LeaveMeetingCmd.end) // end meeting
//        }
    }
    //Mark Join Meeting Methods
    func JointMeeting(){
            self.joinMeeting(meetingNumber: GenralSetting.Shared.meetingNumber, meetingPassword: "")
    }
    func joinMeeting(meetingNumber: String, meetingPassword: String) {
        MobileRTC.shared().getMeetingSettings()?.prePopulateWebinarRegistrationInfo(GenralSetting.Shared.webinarscreenEmail, username: GenralSetting.Shared.webinarscreenName)
        MobileRTC.shared().getMeetingSettings()?.enableCustomMeeting = false
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.delegate = self
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.meetingNumber = meetingNumber
            joinMeetingParameters.password = meetingPassword
            meetingService.joinMeeting(with: joinMeetingParameters)
        }
    }

}
// 1. Extend the ViewController class to adopt and conform to MobileRTCMeetingServiceDelegate. The delegate methods will listen for updates from the SDK about meeting connections and meeting states.
extension ZDefaultUIjoinmeetingRoomVC: MobileRTCMeetingServiceDelegate {

    // Is called upon in-meeting errors, join meeting errors, start meeting errors, meeting connection errors, etc.
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        switch error {
        case MobileRTCMeetError_PasswordError:
            print("Could not join or start meeting because the meeting password was incorrect.")
        default:
            print("Could not join or start meeting with MobileRTCMeetError: \(error) \(message ?? "")")
        }
    }

    // Is called when the user joins a meeting.
    func onJoinMeetingConfirmed() {
        print("Join meeting confirmed.")
    }

    // Is called upon meeting state changes.
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
        switch state {
        default: break
        }
        print("Current meeting state: \(state)")
    }
    
    //Meeting Ended
    func onMeetingEndedReason(_ reason: MobileRTCMeetingEndReason) {
        self.navigationController?.popViewController(animated: true)
       // self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
}
