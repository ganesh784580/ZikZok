//
//  ParentTabViewController.swift
//  StreamLabsAssignment
//
//  Created by Junior on 16/02/2019.
//  Copyright © 2019 streamlabs. All rights reserved.
//

import UIKit

class ParentTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = AppColorConstants.appThemeColor
        self.tabBar.tintColor =  AppColorConstants.primaryTextColor
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:  AppColorConstants.ForeGroundColor ], for:.selected)
        
        let feedPageViewController = FeedPageViewController()
        //let poolListNavigationController = UINavigationController(rootViewController: feedPageViewController)
        let poolListTabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "ic_home"), selectedImage: nil)
        feedPageViewController.tabBarItem = poolListTabBarItem
        
//        let settingsViewController = SettingsRouter.createModule()
//        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
//        let settingsViewTabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), selectedImage: nil)
//        settingsViewController.tabBarItem = settingsViewTabBarItem
        
        self.viewControllers = [feedPageViewController]
        
    }
}



