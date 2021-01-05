//
//  ZjoinmeetingVC.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation
import UIKit
import MobileRTC
class ZjoinmeetingVC: UIViewController {
    
    @IBOutlet var segment:UISegmentedControl!
    @IBOutlet var txtMeetingnumber:UITextField!
    @IBOutlet var txtWebinarscreenname:UITextField!
    @IBOutlet var txtWebinaremail:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMeetingnumber.text = ""
        txtWebinaremail.text = ""
        txtWebinarscreenname.text = ""
        if(GenralSetting.Shared.jointmeetingType){
            segment.selectedSegmentIndex = 1
        }else{
            segment.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func JoinMeetingVC(){
        if(validateField()){
            GenralSetting.Shared.meetingNumber  = (txtMeetingnumber.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            GenralSetting.Shared.webinarscreenName  = (txtWebinarscreenname.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            GenralSetting.Shared.webinarscreenEmail  = (txtWebinaremail.text?.trimmingCharacters(in: .whitespacesAndNewlines))!

            if(GenralSetting.Shared.jointmeetingType){
                let ZCustomUIjoinmeetingRoomVC = storyboard?.instantiateViewController(withIdentifier: "ZCustomUIjoinmeetingRoomVC") as? ZCustomUIjoinmeetingRoomVC
                navigationController?.pushViewController(ZCustomUIjoinmeetingRoomVC ?? UIViewController(), animated: true)
            }else{
                let ZDefaultUIjoinmeetingRoomVC = storyboard?.instantiateViewController(withIdentifier: "ZDefaultUIjoinmeetingRoomVC") as? ZDefaultUIjoinmeetingRoomVC
                navigationController?.pushViewController(ZDefaultUIjoinmeetingRoomVC ?? UIViewController(), animated: true)
            }
        }
    }
    
    @IBAction func MeetingTypeClicked(_sender:UISegmentedControl) {
        if _sender.selectedSegmentIndex == 1{
            GenralSetting.Shared.jointmeetingType = true
        }else if _sender.selectedSegmentIndex == 0{
            GenralSetting.Shared.jointmeetingType = false
        }else{
            GenralSetting.Shared.jointmeetingType = false
        }
    }

    @IBAction func backClicked(){
        //        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateField()->Bool{
        var valid:Bool = true
        if (txtMeetingnumber.text == nil){
            toastVC.sharedInstance.showToast(message:"please enter meeting number", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txtMeetingnumber.text == ""){
            toastVC.sharedInstance.showToast(message:"please enter meeting number", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txtWebinarscreenname.text == nil){
            toastVC.sharedInstance.showToast(message:"please enter webinare screen name", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txtWebinarscreenname.text == ""){
            toastVC.sharedInstance.showToast(message:"please enter webinare screen name", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txtWebinaremail.text == nil){
            toastVC.sharedInstance.showToast(message:"please enter webinare email", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txtWebinaremail.text == ""){
            toastVC.sharedInstance.showToast(message:"please enter webinare email", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }
        return valid
    }
}
extension ZjoinmeetingVC:UITextFieldDelegate{
    // UITextField Delegates
       func textFieldDidBeginEditing(_ textField: UITextField) {
       }
       func textFieldDidEndEditing(_ textField: UITextField) {
       }
       func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           return true;
       }
       func textFieldShouldClear(_ textField: UITextField) -> Bool {
           return true;
       }
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           return true;
       }
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           return true;
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder();
           self.view.endEditing(true)
           return true;
       }

}
