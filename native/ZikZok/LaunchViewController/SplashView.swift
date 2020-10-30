//
//  PostAuthenticationView.swift
//  Creator
//
//  Created by Ganesh Arora on 05/04/19.
//  Copyright © 2019 Zoho. All rights reserved.
//

import Foundation
import UIKit

class SplashView: UIView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoView: UIImageView!
    
    var  splashWindow: UIWindow?
    
    static func instance() -> SplashView {
        let splashView = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)!.first as! SplashView
        splashView.setUpView()
        return splashView
    }
    
    func setUpView() {
         activityIndicator.color = AppColorConstants.appThemeColor
    }
    
    func show(showIndicator: Bool, window: UIWindow? = UIApplication.shared.keyWindow) {
        guard let window = window else { return }
        
        if #available(iOS 13.0, *), let windowScene = window.windowScene, let _ = windowScene.delegate {
            if (splashWindow == nil) {
                splashWindow = UIWindow(windowScene:  windowScene)
                let dummyViewController = UIViewController()
                splashWindow?.rootViewController = dummyViewController
                splashWindow?.rootViewController?.view.addSubview(self)
            }
            splashWindow?.isHidden = false
        }else{
             window.addSubview(self)
        }
        self.fillSuperView()
        if showIndicator {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func hideSplashForWindowScene( animation: Bool) {
        if animation {
            UIView.animate(withDuration: 0.25, animations: {
                self.splashWindow?.alpha = 0
            }, completion: { (_) in
                self.splashWindow?.alpha = 1
                self.splashWindow?.isHidden = true
                self.splashWindow = nil
            })
        } else {
            self.splashWindow?.isHidden = true
            self.splashWindow = nil
        }
    }
    
    func hide( animation: Bool) {
        if #available(iOS 13.0, *), let _ = splashWindow {
            hideSplashForWindowScene(animation: animation)
        } else {
            if animation {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alpha = 0
                    self.splashWindow?.alpha = 0
                }, completion: { (_) in
                     self.removeFromSuperview()
                     self.alpha = 1
                })
            } else {
                removeFromSuperview()
            }
        }
    }
}
