//
//  GenralSetting.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import Foundation

class GenralSetting: NSObject {
    static let Shared = GenralSetting()
    
    var sdkKey = ""
    var sdkSecret = ""
    let domain = "zoom.us"

    var jointmeetingType: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "joinmeetingType")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "joinmeetingType")
            UserDefaults.standard.synchronize()
        }
    }
    
    var startmeetingType: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "startmeetingType")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "startmeetingType")
            UserDefaults.standard.synchronize()
        }
    }
    
    var meetingType: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "meetingType")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "meetingType")
            UserDefaults.standard.synchronize()
        }
    }
    
    var meetingNumber:String{
        get {
            return UserDefaults.standard.string(forKey: "meetingNumber")!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "meetingNumber")
            UserDefaults.standard.synchronize()
        }
    }
    var webinarscreenName:String{
        get {
            return UserDefaults.standard.string(forKey: "webinarscreenName")!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "webinarscreenName")
            UserDefaults.standard.synchronize()
        }
    }
    
    var webinarscreenEmail:String{
        get {
            return UserDefaults.standard.string(forKey: "webinarscreenEmail")!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "webinarscreenEmail")
            UserDefaults.standard.synchronize()
        }
    }
    
    var HostEmail:String{
        get {
            return UserDefaults.standard.string(forKey: "HostEmail")!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HostEmail")
            UserDefaults.standard.synchronize()
        }
    }
    var HostPassword:String{
        get {
            return UserDefaults.standard.string(forKey: "HostPassword")!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HostPassword")
            UserDefaults.standard.synchronize()
        }
    }
}
