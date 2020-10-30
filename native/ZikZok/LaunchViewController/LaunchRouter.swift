//
//  LaunchRouter.swift
//  Creator
//
//  Created Gokul R on 25/07/18.
//  Copyright © 2018 Zoho. All rights reserved.

import UIKit

#if WORK
var isMultipleWorkApp = false
#endif
class LaunchRouter
{
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController
    {
        let view = LaunchViewController()
        let interactor = LaunchInteractor()
        let router = LaunchRouter()
        let presenter = LaunchPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    deinit {
        print("\n------\nLaunch Router Deinit\n------\n")
    }
}

extension LaunchRouter: LaunchRouterProtocol
{
    func presentLoginScreen(presenter: LoginServiceResponse, window: UIWindow? )
    {
        var loginService : LoginService = ZikZokHandler.sharedInstance
        loginService.loginOutput = presenter
        loginService.showLoginScreen(window: window)
        
    }
    
    func showHomeScreen() {
        for scene in  UIApplication.shared.connectedScenes {
            if let windowScene = scene as? UIWindowScene,
                let windowSceneDelegate = windowScene.delegate as? SceneDelegate {
                windowSceneDelegate.showInitialController()
            }
        }
    }
}
