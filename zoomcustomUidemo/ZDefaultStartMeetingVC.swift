//
//  ZDefaultStartMeetingVC.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation
import MobileRTC

class ZDefaultStartMeetingVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
        if let authorizationService = MobileRTC.shared().getAuthService(), authorizationService.isLoggedIn() {
             startMeeting()
        } else {
            self.logIn(email: GenralSetting.Shared.HostEmail, password: GenralSetting.Shared.HostPassword)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        if let meetingService = MobileRTC.shared().getMeetingService() {
//            meetingService.leaveMeeting(with: LeaveMeetingCmd.leave) // leave meeting
//            //meetingService.leaveMeeting(with: LeaveMeetingCmd.end) // end meeting
//        }
    }
    // 1. Create the login method
        func logIn(email: String, password: String) {
            // 2. Obtain the MobileRTCAuthService from the Zoom SDK, this service can log in a Zoom user, log out a Zoom user, authorize the Zoom SDK etc.
            if let authorizationService = MobileRTC.shared().getAuthService() {
                 // 3. Call the login function in MobileRTCAuthService. This will attempt to log in the user.
                authorizationService.login(withEmail: email, password: password, rememberMe: false)
            }
        }

    // 4. Write the startMeeting method.
        func startMeeting() {
            // 5. Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
            if let meetingService = MobileRTC.shared().getMeetingService() {
                //6. Set the ViewContoller to be the MobileRTCMeetingServiceDelegate
                meetingService.delegate = self
                /*** 5. Create a MobileRTCMeetingStartParam to provide the MobileRTCMeetingService with the necessary info to start an instant meeting. In this case we will use MobileRTCMeetingStartParam4LoginlUser(), since the user has logged into Zoom. ***/
                let startMeetingParameters = MobileRTCMeetingStartParam4LoginlUser()
                let param:MobileRTCMeetingStartParam!
                param = startMeetingParameters
                param.meetingNumber = GenralSetting.Shared.meetingNumber
                // 6. Call the startMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
                meetingService.startMeeting(with: param)
                
            }
        }
    
    // MARK: - Internal
    
// 2. Add a selector for the userLoggedIn function that invokes startMeeting function for a logged in user.
    @objc func userLoggedIn() {
        startMeeting()
    }
}
// 1. Extend the ViewController class to adopt and conform to MobileRTCMeetingServiceDelegate. The delegate methods will listen for updates from the SDK about meeting connections and meeting states.
extension ZDefaultStartMeetingVC: MobileRTCMeetingServiceDelegate {

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
