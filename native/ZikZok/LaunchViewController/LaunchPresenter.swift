//
//  LaunchPresenter.swift
//  Creator
//
//  Created Gokul R on 25/07/18.
//  Copyright © 2018 Zoho. All rights reserved.

import UIKit

class LaunchPresenter
{
    weak private var view: LaunchViewProtocol?
    var interactor: LaunchInteractorInputProtocol?
    private let router: LaunchRouterProtocol

    init(interface: LaunchViewProtocol, interactor: LaunchInteractorInputProtocol?, router: LaunchRouterProtocol)
    {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        print("\n------\nLaunch Presenter Deinit\n------\n")
    }
}

extension LaunchPresenter: LaunchPresenterProtocol
{
    func viewDidLoad()
    {
        view?.startLoader()
        interactor?.checkLoginValidity()
    }
    
    func showLoaderForSignIn() {
        view?.hideLoginButton()
        view?.startLoader()
    }
    
    func hideLoaderShowSignIn() {
        view?.stopLoader()
        view?.showLoginButton()
    }
    
    func loginButtonTapped()
    {
        proceedToLoginScreen()
    }
    
    func proceedToLoginScreen() {
        view?.hideLoginButton()
        router.presentLoginScreen(presenter: self, window: UIApplication.shared.keyWindow)
        view?.startLoader()
    }
}

extension LaunchPresenter: LaunchInteractorOutputProtocol
{
    func userDataAvailable(_ available: Bool)
    {
        if available {

        }
        else
        {
            view?.stopLoader()
            view?.showLoginButton()
        }
        view?.setupView(isValidSession: available)
    }
    
    func handleTokenLimitExceedsError() {
        view?.stopLoader()
        view?.showLoginButton()
    }
    
    func handleFeedBack() {
        view?.stopLoader()
        view?.showLoginButton()
    }
    
    func handleSSOLoginError(errorMessage: String) {
        view?.stopLoader()
        view?.showLoginButton()
    }
}

extension LaunchPresenter: LoginServiceResponse
{
    func loginSuccessful()
    {
        router.showHomeScreen()
    }
    
    func loginCancelled()
    {
        view?.stopLoader()
        view?.showLoginButton()
    }
    
    func loginFailedWithError(_ error: Error?) {
//        guard let error = error else {
//            loginCancelled()
//            return
//        }
//        interactor?.checkForLoginError(error: error)
         loginCancelled()
    }
}

