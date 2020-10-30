//
//  LaunchInteractor.swift
//  Creator
//
//  Created Gokul R on 25/07/18.
//  Copyright © 2018 Zoho. All rights reserved.

import UIKit


class LaunchInteractor
{
    weak var presenter: LaunchInteractorOutputProtocol?
    private var loginService: LoginService = ZikZokHandler.sharedInstance
    
    deinit {
        print("\n------\nLaunch Interactor Deinit\n------\n")
    }
}

extension LaunchInteractor: LaunchInteractorInputProtocol
{
    func checkForLoginError(error: Error) {
        
    }
    
    func checkLoginValidity()
    {
//        var hasAccessToken : Bool = loginService.hasValidSession()
//        presenter?.userDataAvailable(hasAccessToken)
    }
    
}
