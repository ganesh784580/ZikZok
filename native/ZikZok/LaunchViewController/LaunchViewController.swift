//
//  LaunchViewController.swift
//  CarPooling
//
//  Created by temp-4400 on 15/08/20.
//  Copyright © 2020 Ganesh Arora. All rights reserved.
//


import UIKit

class LaunchViewController: UIViewController
{
    var presenter: LaunchPresenterProtocol?

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var appDisplayName: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        //containerView.backgroundColor = UIColor.black
        welcomeLabel.textColor = AppColorConstants.primaryBlackColor
        NotificationCenter.default.addObserver(self, selector: #selector(showLoaderForSignIn), name: Notification.Name("hideSignInButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSignInButton), name: Notification.Name("showSignInButton"), object: nil)
        presenter?.viewDidLoad()
        setupView()
    }
    
    @objc func showLoaderForSignIn() {
        presenter?.showLoaderForSignIn()
    }
    
    @objc func showSignInButton() {
        presenter?.hideLoaderShowSignIn()
    }
    
    @IBAction func tapGestureSelector(_ sender: Any)
    {
        
    }
    
    @IBAction func loginButtonSelector(_ sender: Any?)
    {
        presenter?.loginButtonTapped()
    }
    
    deinit {
        print("\n------\nLaunch ViewController Deinit\n------\n")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "hideSignInButton"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "showSignInButton"), object: nil)
    }
}

extension LaunchViewController: LaunchViewProtocol
{
     func setupView(isValidSession: Bool) {
           if isValidSession {
               let splashView = SplashView.instance()
               view.addSubview(splashView)
               splashView.fillSuperView()
           }
       }
    
    func startLoader()
    {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoader()
    {
        activityIndicator.stopAnimating()
    }
    
    func showLoginButton()
    {
        signInButton.alpha = 0
        signInButton.isHidden = false
         self.signInButton.alpha = 1
//        UIView.animate(withDuration: 0.3)
//        {
//            self.signInButton.alpha = 1
//        }
    }
    
    func hideLoginButton()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.signInButton.alpha = 0
        })
        { (animationCompleted) in
            self.signInButton.isHidden = true
        }
    }
    
    func setupView()
    {
        //Supporting for dark mode
       // setupSignInButton(signInButton)
        activityIndicator.color = AppColorConstants.appThemeColor
      //  signInButton.setBackgroundColor(AppColorConstants.secondaryBlueColor ?? UIColor.blue, for: .normal)
        appDisplayName.textColor = UIColor.purple
        signInButton.backgroundColor = appDisplayName.textColor
        showLoginButton()
        stopLoader()
    }
    
    
    func setupSignInButton(_ button: UIButton)
    {
       // button.setTitle(Strings.loginscreenLabelSignin, for: .normal)
      
    }
}

extension UIView {
func fillSuperView(with inset: UIEdgeInsets = UIEdgeInsets.zero)
   {
       if let superview = self.superview
       {
           self.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               self.topAnchor.constraint(equalTo: superview.topAnchor, constant: inset.top),
               self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset.left),
               self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset.bottom),
               self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset.right)
               ])
       }
    }
}
