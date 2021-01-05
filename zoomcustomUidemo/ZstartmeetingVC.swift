//
//  ZstartmeetingVC.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation
import UIKit

class ZstartmeetingVC: UIViewController {
    
    @IBOutlet var segment:UISegmentedControl!
    @IBOutlet var txtMeetingnumber:UITextField!
    @IBOutlet var txthostEmail:UITextField!
    @IBOutlet var txtHostpassword:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtMeetingnumber.text = ""
        txthostEmail.text = ""
        txtHostpassword.text = ""

        if(GenralSetting.Shared.startmeetingType){
            segment.selectedSegmentIndex = 1
        }else{
            segment.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func StartMeetingVC(){
        if(validateField()){
            GenralSetting.Shared.meetingNumber  = (txtMeetingnumber.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            GenralSetting.Shared.HostEmail  = (txthostEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            GenralSetting.Shared.HostPassword  = (txtHostpassword.text?.trimmingCharacters(in: .whitespacesAndNewlines))!

            if(GenralSetting.Shared.startmeetingType){
                let ZCustomUIjoinmeetingRoomVC = storyboard?.instantiateViewController(withIdentifier: "ZCustomUIjoinmeetingRoomVC") as? ZCustomUIjoinmeetingRoomVC
                navigationController?.pushViewController(ZCustomUIjoinmeetingRoomVC ?? UIViewController(), animated: true)
            }else{
                let ZDefaultStartMeetingVC = storyboard?.instantiateViewController(withIdentifier: "ZDefaultStartMeetingVC") as? ZDefaultStartMeetingVC
                navigationController?.pushViewController(ZDefaultStartMeetingVC ?? UIViewController(), animated: true)
            }
        }
    }
    @IBAction func MeetingTypeClicked(_sender:UISegmentedControl) {
        if _sender.selectedSegmentIndex == 1{
            GenralSetting.Shared.startmeetingType = true
        }else if _sender.selectedSegmentIndex == 0{
            GenralSetting.Shared.startmeetingType = false
        }else{
            GenralSetting.Shared.startmeetingType = false
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
        }else if (txthostEmail.text == nil){
            toastVC.sharedInstance.showToast(message:"please enter Host email", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txthostEmail.text == ""){
            toastVC.sharedInstance.showToast(message:"please enter Host email", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txtHostpassword.text == nil){
            toastVC.sharedInstance.showToast(message:"please enter Host password", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }else if (txtHostpassword.text == ""){
            toastVC.sharedInstance.showToast(message:"please enter Host password", font: .systemFont(ofSize: 12.0), target: self)
            valid = false
        }
        return valid
    }


}
extension ZstartmeetingVC:UITextFieldDelegate{
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
