//
//  AppDelegate.swift
//  zoomcustomUidemo
//
//  Created by Mahavir on 24/12/20.
//

import UIKit
import MobileRTC

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GenralSetting.Shared.sdkKey = ""
        GenralSetting.Shared.sdkSecret = ""
        setupSDK(sdkKey: GenralSetting.Shared.sdkKey, sdkSecret: GenralSetting.Shared.sdkSecret)
        return true
    }
    func setupSDK(sdkKey: String, sdkSecret: String) {
            let context = MobileRTCSDKInitContext()
            context.domain = GenralSetting.Shared.domain
            context.enableLog = true

            let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)

            if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {
                authorizationService.clientKey = sdkKey
                authorizationService.clientSecret = sdkSecret
                authorizationService.delegate = self
                authorizationService.sdkAuth()
            }
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
            // Obtain the MobileRTCAuthService from the Zoom SDK, this service can log in a Zoom user, log out a Zoom user, authorize the Zoom SDK etc.
            if let authorizationService = MobileRTC.shared().getAuthService() {
                // Call logoutRTC() to log the user out.
                authorizationService.logoutRTC()
            }
    }

}

extension AppDelegate: MobileRTCAuthDelegate {

    // Result of calling sdkAuth(). MobileRTCAuthError_Success represents a successful authorization.
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        switch returnValue {
        case MobileRTCAuthError_Success:
            print("SDK successfully initialized.")
        case MobileRTCAuthError_KeyOrSecretEmpty:
            assertionFailure("SDK Key/Secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK Key/Secret.")
        case MobileRTCAuthError_KeyOrSecretWrong, MobileRTCAuthError_Unknown:
            assertionFailure("SDK Key/Secret is not valid.")
        default:
            assertionFailure("SDK Authorization failed with MobileRTCAuthError: \(returnValue).")
        }
    }
    
    // Result of calling logIn(). 0 represents a successful login attempt.
       func onMobileRTCLoginReturn(_ returnValue: Int) {
           switch returnValue {
           case 0:
               print("Successfully logged in")
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("userLoggedIn"), object: nil)

               // This alerts the ViewController that login was successful.            NotificationCenter.default.post(name: Notification.Name("userLoggedIn"), object: nil)
           case 1002:
               print("Password incorrect")
           default:
               print("Could not log in. Error code: \(returnValue)")
           }
       }

       // Result of calling logoutRTC(). 0 represents a successful log out attempt.
       func onMobileRTCLogoutReturn(_ returnValue: Int) {
           switch returnValue {
           case 0:
               print("Successfully logged out")
           default:
               print("Could not log out. Error code: \(returnValue)")
           }
       }
}
