//
//  ZikZokHandler.swift
//  ZikZok
//
//  Created by temp-4400 on 29/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import UIKit
//import ZCUIFramework
import ZCCoreFramework

class ZikZokHandler {
    
    public var loginOutput: LoginServiceResponse?
    public var logoutOutput: LogoutServiceResponse?
    
    
    var userInfo: UserInfo?
    var settingsEntryForm : Form?
    var userInfoForm: Form?
    private var userProfileImage:  UIImage?
    static var userProfileImageFileName:  String = "UserProfileImage"
    
    static var sharedInstance: ZikZokHandler = {
        return ZikZokHandler()
    }()
    
    private var _splashView: SplashView?
    
    var splashView: SplashView? {
        get
        {
            if _splashView == nil {
                _splashView =  SplashView.instance()
            }
            return _splashView
        }
        set
        {
            _splashView = newValue
        }
    }
    
    func initialize(window: UIWindow?) {
        let scopeArray = ["ZohoCreator.meta.READ","ZohoCreator.data.READ","ZohoCreator.meta.CREATE","ZohoCreator.data.CREATE","aaaserver.profile.READ","ZohoContacts.userphoto.READ","ZohoContacts.contactapi.READ"]
        #if DEBUG
        print("scopeArray ----> \(scopeArray)")
        #endif
        ZohoAuth.initWithClientID(clientId, clientSecret: clientSecret, scope: scopeArray, urlScheme: urlScheme, mainWindow: window, accountsURL: "https://accounts.zoho.com")
        if   let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            Creator.configure(delegate: appdelegate)
        }
        //showLocationPermissioncoontroller()
    }
    
    public func showSplashView( showloader: Bool, window: UIWindow? = UIApplication.shared.keyWindow) {
        splashView?.show(showIndicator: showloader)
    }
    
    
    public func hideSplashView( animation: Bool ) {
        splashView?.hide(animation: animation)
        flushSplashView()
    }
    
    func flushSplashView() {
        splashView = nil
    }
    
    
}

extension ZikZokHandler: LoginService {
    
    static func initialize(with window: UIWindow) {
        
    }
    
    
    
    func hasValidSession() -> Bool {
        return false
    }
    
    
    func showLoginScreen(window: UIWindow?) {
        ZohoAuth.presentZohoSign(in: { (token, error) in
            if let _ = token, error == nil {
                self.loginOutput?.loginSuccessful()
            }else{
                self.loginOutput?.loginFailedWithError(error )
            }
        })
    }
}
