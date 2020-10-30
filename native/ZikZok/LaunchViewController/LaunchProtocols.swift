//
//  LaunchProtocols.swift
//  Creator
//
//  Created Gokul R on 25/07/18.
//  Copyright © 2018 Zoho. All rights reserved.

import UIKit

//MARK: Wireframe -
protocol LaunchRouterProtocol: class
{
    func presentLoginScreen(presenter: LoginServiceResponse, window: UIWindow? )
    func showHomeScreen()
}

//MARK: Presenter -


//MARK: Interactor -
protocol LaunchInteractorOutputProtocol: class
{
    func userDataAvailable(_ available: Bool)
    func handleTokenLimitExceedsError()
    func handleSSOLoginError(errorMessage:String)
    func handleFeedBack()
    /* Interactor -> Presenter */
}

protocol LaunchInteractorInputProtocol: class
{
    var presenter: LaunchInteractorOutputProtocol?  { get set }

    func checkLoginValidity()
    func checkForLoginError(error:Error)
    /* Presenter -> Interactor */
}

//MARK: View -
protocol LaunchViewProtocol: class
{
    var presenter: LaunchPresenterProtocol?  { get set }

    func startLoader()
    func stopLoader()
    func showLoginButton()
    func hideLoginButton()
    func setupView(isValidSession: Bool)
    
    /* Presenter -> ViewController */
}

protocol LoginService
{
    var loginOutput: LoginServiceResponse? { get set }
    
    static func initialize(with window: UIWindow)
    
    func hasValidSession() -> Bool
    func showLoginScreen( window: UIWindow? )
}

protocol LoginServiceResponse
{
    func loginSuccessful()
    func loginCancelled()
    func loginFailedWithError(_ error: Error?)
}

protocol LaunchPresenterProtocol: class {
    var interactor: LaunchInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func loginButtonTapped()
    func showLoaderForSignIn()
    func hideLoaderShowSignIn()
}

protocol LogoutServiceResponse
{
    func logoutSuccessful()
    func logoutFailedWithError(_ error: Error)
}
