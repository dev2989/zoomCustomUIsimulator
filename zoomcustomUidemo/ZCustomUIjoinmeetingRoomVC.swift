//
//  ZCustomUIjoinmeetingRoomVC.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation
import UIKit
import MobileRTC

class ZCustomUIjoinmeetingRoomVC: UIViewController ,MobileRTCCustomizedUIMeetingDelegate,MobileRTCPremeetingDelegate ,MobileRTCVideoServiceDelegate,MobileRTCWebinarServiceDelegate{
    
    var preVideoView: MobileRTCPreviewVideoView?
    var videoView: MobileRTCVideoView?
    var ActivevideoView: MobileRTCActiveVideoView?
    
    @IBOutlet var ActivityView:UIActivityIndicatorView!
    @IBOutlet var baseView:UIView!
    @IBOutlet var OverLayView:UIView!
    
    @IBOutlet var btnLeave:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
        //NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
        self.JointMeeting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.leaveMeeting(with: LeaveMeetingCmd_Leave) // leave meeting
            //meetingService.leaveMeeting(with: LeaveMeetingCmd.end) // end meeting
        }
    }
    //Mark Join Meeting Methods
    func JointMeeting(){
            self.joinMeeting(meetingNumber: GenralSetting.Shared.meetingNumber, meetingPassword: "")
    }
    func joinMeeting(meetingNumber: String, meetingPassword: String) {
        // Some use full property
        MobileRTC.shared().getMeetingSettings()?.setMuteAudioWhenJoinMeeting(true)
        MobileRTC.shared().getMeetingSettings()?.meetingLeaveHidden = false
        MobileRTC.shared().getMeetingSettings()?.meetingAudioHidden = true
        MobileRTC.shared().getMeetingSettings()?.meetingChatHidden = true
        MobileRTC.shared().getMeetingSettings()?.meetingInviteHidden = true
        MobileRTC.shared().getMeetingSettings()?.meetingShareHidden = true
       
        MobileRTC.shared().getMeetingSettings()?.qaButtonHidden = true
        MobileRTC.shared().getMeetingSettings()?.topBarHidden = false
        MobileRTC.shared().getMeetingSettings()?.bottomBarHidden = true
        MobileRTC.shared().getMeetingSettings()?.enableCustomMeeting = GenralSetting.Shared.jointmeetingType
        MobileRTC.shared().getMeetingSettings()?.meetingVideoHidden = false
        MobileRTC.shared().getMeetingSettings()?.prePopulateWebinarRegistrationInfo(GenralSetting.Shared.webinarscreenEmail, username: GenralSetting.Shared.webinarscreenName)
        
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        if let meetingService = MobileRTC.shared().getMeetingService() {
            #if false
            //customize meeting title
            ms.customizeMeetingTitle("Sample Meeting Title")
            #endif
            meetingService.delegate = self
            meetingService.customizedUImeetingDelegate = self
            
            // Create a MobileRTCMeetingJoinParam to provide the MobileRTCMeetingService with the necessary info to join a meeting.
            // In this case, we will only need to provide a meeting number and password.
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.userName = GenralSetting.Shared.webinarscreenName
            joinMeetingParameters.meetingNumber = meetingNumber
            joinMeetingParameters.password = meetingPassword
            

            // Call the joinMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
            // If the meeting number and meeting password are valid, the user will be put into the meeting. A waiting room UI will be presented or the meeting UI will be presented.
            meetingService.joinMeeting(with: joinMeetingParameters)
            
            
            
        }
    }
    @IBAction func leaveMeeting(){
        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.leaveMeeting(with: LeaveMeetingCmd_Leave) // leave meeting
            //meetingService.leaveMeeting(with: LeaveMeetingCmd.end) // end meeting
        }
    }
func showAttendeeVideo(videoView: MobileRTCActiveVideoView, withUserId userID: UInt) {
       
        videoView.showAttendeeVideo(withUserID: userID)
        
    guard let ms = MobileRTC.shared().getMeetingService() else {return}
        let size: CGSize = (ms.getUserVideoSize(userID))

        if __CGSizeEqualToSize(size, .zero) {
            return
        }
        videoView.setVideoAspect(MobileRTCVideoAspect_PanAndScan)
    }

    //Mark Custom UI delegate methods
    func onInitMeetingView() {
       // self.videoView = MobileRTCVideoView(frame: self.baseView.bounds)
        // self.videoView?.setVideoAspect(MobileRTCVideoAspect_PanAndScan)
        self.ActivevideoView = MobileRTCActiveVideoView(frame: self.baseView.bounds)
        self.ActivevideoView?.setVideoAspect(MobileRTCVideoAspect_PanAndScan)
        self.baseView.addSubview(self.ActivevideoView!)
    }
    
    func onDestroyMeetingView() {
        self.ActivevideoView!.removeFromSuperview()
       // self.videoVC.removeFromParent()
    }

    
    //MARK : Video delegate
    
    func onSinkMeetingActiveVideo(_ userID: UInt) {
        
        self.showAttendeeVideo(videoView: self.ActivevideoView!, withUserId: userID)
    }
    
    func onSinkMeetingVideoStatusChange(_ userID: UInt) {
        
    }
    
    func onMyVideoStateChange() {
        
    }
    
    func onSinkMeetingVideoStatusChange(_ userID: UInt, videoStatus: MobileRTCVideoStatus) {
        
    }
    
    func onSpotlightVideoChange(_ on: Bool) {
        
    }
    
    func onSinkMeetingPreviewStopped() {
        
    }
    
    func onSinkMeetingActiveVideo(forDeck userID: UInt) {
        
    }
    
    func onSinkMeetingVideoQualityChanged(_ qality: MobileRTCNetworkQuality, userID: UInt) {
        
    }
    
    func onSinkMeetingVideoRequestUnmute(byHost completion: @escaping (Bool) -> Void) {
        
    }
    
    func onSinkMeetingShowMinimizeMeetingOrBackZoomUI(_ state: MobileRTCMinimizeMeetingState) {
        
    }
    
    func sinkSchedultMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
        
    }
    
    func sinkEditMeeting(_ result: PreMeetingError, meetingUniquedID uniquedID: UInt64) {
        
    }
    
    func sinkDeleteMeeting(_ result: PreMeetingError) {
        
    }
    
    func sinkListMeeting(_ result: PreMeetingError, withMeetingItems array: [Any]) {
        
    }
    
    
    
    // MARK : Webinar delegates
    
    func onSinkQAConnectStarted() {
        
    }
    
    func onSinkQAConnected(_ connected: Bool) {
        
    }
    
    func onRefreshQAData() {
        
    }
    
    func onSinkQAOpenQuestionChanged(_ count: Int) {
        
    }
    
    func onSinkQAAddQuestion(_ questionID: String, success: Bool) {
        
    }
    
    func onSinkQAAddAnswer(_ answerID: String, success: Bool) {
        
    }
    
    func onSinkQuestionMarked(asDismissed questionID: String) {
        
    }
    
    func onSinkReopenQuestion(_ questionID: String) {
        
    }
    
    func onSinkReceiveQuestion(_ questionID: String) {
        
    }
    
    func onSinkReceiveAnswer(_ answerID: String) {
        
    }
    
    func onSinkUserLivingReply(_ questionID: String) {
        
    }
    
    func onSinkUserEndLiving(_ questionID: String) {
        
    }
    
    func onSinkVoteupQuestion(_ questionID: String, orderChanged: Bool) {
        
    }
    
    func onSinkRevokeVoteupQuestion(_ questionID: String, orderChanged: Bool) {
        
    }
    
    func onSinkDeleteQuestion(_ questionIDArray: [Any]) {
        
    }
    
    func onSinkDeleteAnswer(_ answerIDArray: [Any]) {
        
    }
    
    func onSinkQAAllowAskQuestionAnonymouslyNotification(_ beAllowed: Bool) {
        
    }
    
    func onSinkQAAllowAttendeeViewAllQuestionNotification(_ beAllowed: Bool) {
        
    }
    
    func onSinkQAAllowAttendeeUpVoteQuestionNotification(_ beAllowed: Bool) {
        
    }
    
    func onSinkQAAllowAttendeeAnswerQuestionNotification(_ beAllowed: Bool) {
        
    }
    
    func onSinkWebinarNeedRegister(_ registerURL: String) {
        
    }
    
    func onSinkJoinWebinarNeedUserNameAndEmail(completion: @escaping (String, String, Bool) -> Bool) {
            let username = GenralSetting.Shared.webinarscreenName
            let email = GenralSetting.Shared.webinarscreenEmail
            let ret = completion(username, email, false)
            print(String(format: "%zd", ret))
    }
    
    func onSinkPanelistCapacityExceed() {
        
    }
    
    func onSinkPromptAttendee2PanelistResult(_ errorCode: MobileRTCWebinarPromoteorDepromoteError) {
        
    }
    
    func onSinkDePromptPanelist2AttendeeResult(_ errorCode: MobileRTCWebinarPromoteorDepromoteError) {
        
    }
    
    func onSinkAllowAttendeeChatNotification(_ currentPrivilege: MobileRTCChatAllowAttendeeChat) {
        
    }
    
    func onSinkSelfAllowTalkNotification() {
        
    }
    
    func onSinkSelfDisallowTalkNotification() {
        
    }
    

}
// 1. Extend the ViewController class to adopt and conform to MobileRTCMeetingServiceDelegate. The delegate methods will listen for updates from the SDK about meeting connections and meeting states.
extension ZCustomUIjoinmeetingRoomVC: MobileRTCMeetingServiceDelegate {

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
        case MobileRTCMeetingState_InMeeting:do {
            self.ActivityView?.isHidden = true
            self.btnLeave.isHidden = false
        }
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
