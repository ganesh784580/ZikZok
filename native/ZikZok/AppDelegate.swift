//
//  AppDelegate.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import UIKit
import ZCCoreFramework

var clientId = "1000.NTPXM3IEINQQ1TFZIBDSWSAUYK10IH"
var clientSecret = "52c382a60978156b8c368d7abe4e40a4c08a9aca6a"
var urlScheme = "creatorcarpooling://"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


class LaunchController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let launchView = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()?.view {
            view.addSubview(launchView)
            launchView.translatesAutoresizingMaskIntoConstraints = false
            launchView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            launchView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            launchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            launchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}

extension AppDelegate : ZCCoreFrameworkDelegate {
    
    public func configuration() -> CreatorConfiguration {
        let creatorURL = "https://creator.zoho.com"
        let mapsURL = "https://maps.zoho.com"
        let creatorConfiguration  = CreatorConfiguration(creatorURL: creatorURL, mapsURL: mapsURL)
        return creatorConfiguration
    }
    
    func userName() -> String? {
        return nil
    }
    
    func loginUserId() -> String? {
        return nil
    }
    
    func oAuthToken(with completion: @escaping AccessTokenCompletion) {
        
        ZohoAuth.getOauth2Token { (token, error) in
            print("token=\(token)")
            if token == nil {
               // PoolingApphandler.sharedInstance.showLoginScreen(window: nil)
                completion(token,error)
            }
            else {
//                 AppDelegate.registerNotification()
                completion(token,error)
            }
        }
    }
    
}
