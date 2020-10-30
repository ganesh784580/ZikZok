//
//  SceneDelegate.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import UIKit
import SwiftUI
import ZCCoreFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Create the SwiftUI view that provides the window contents.
       
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let launchController = LaunchController()
            launchController.view.backgroundColor = UIColor.blue
            window.rootViewController = launchController
            self.window = window
            configureApp()
            showInitialController()
            observePreferenceSubmittedEvents()
            window.makeKeyAndVisible()
        }
    }
    
    
    func configureApp() {
        ZikZokHandler.sharedInstance.initialize(window: window)
    }
    
    
    
    public func observePreferenceSubmittedEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: ZikZokEvents.UserPreferenceSubmittedNotificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: ZikZokEvents.LoggedOutNotificationName, object: nil)
    }
    
    
    @objc func handle(notification: Notification) {
        let event = notification.object as! ZikZokEvents
        switch event {
        case .UserPreferenceSubmitted:
            print("Submitted")
        case .LoggedOut:
            Creator.flush()
            configureApp()
            showInitialController()
        default:
            print("not supported")
        }
    }
    
    func showInitialController() {
        print("log: Showing showInitialController")
        let launchController = LaunchRouter.createModule()
        window?.rootViewController = launchController
        self.window?.makeKeyAndVisible()
        if let launchController = launchController as? LaunchViewController{
            launchController.startLoader()
            launchController.hideLoginButton()
        }
        
        ZikZokAPIHandler.fetchMyUserInfo(shouldCacheResponse: true) { (result) in
            switch result {
            case .failure( _):
                print("log: userinfo failed")
                print("fetch userinfo failed")
                if let launchController = launchController as? LaunchViewController{
                    launchController.stopLoader()
                    launchController.showLoginButton()
                    launchController.loginButtonSelector(nil)
                }
            case .success(_):
                //ZikZokHandler.sharedInstance.showSplashView(showloader: true)
                self.window?.rootViewController = ParentTabViewController()
                
            }
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("log: from open url")
        guard let urlContext =  URLContexts.first else {
            return
        }
        var options = [UIApplication.OpenURLOptionsKey : Any]()
        
        options[UIApplication.OpenURLOptionsKey.sourceApplication] = urlContext.options.sourceApplication
        options[UIApplication.OpenURLOptionsKey.annotation] = urlContext.options.annotation
        
        
        let isHandled = ZohoAuth.handleURL(urlContext.url, sourceApplication: urlContext.options.sourceApplication, annotation: urlContext.options.annotation)
        if(isHandled){
            print("YEah handled")
        } else{
            
        }
    }
    
}

