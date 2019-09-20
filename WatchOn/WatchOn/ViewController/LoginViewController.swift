//
//  LoginViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import AuthenticationServices
import LocalAuthentication

class LoginViewController: BaseViewController {
    
    private var contextLA = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupView()
    }
    
    private func setupView() {
        
        /*let appleIDButton = ASAuthorizationAppleIDButton()
        appleIDButton.translatesAutoresizingMaskIntoConstraints = false
        appleIDButton.addTarget(self, action: #selector(didTapAppleIDButton), for: .touchUpInside)
        
        self.view.addSubview(appleIDButton)*/
    }
    
    /*@objc
    func didTapAppleIDButton() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let appleIDRequest = appleProvider.createRequest()
        appleIDRequest.requestedScopes = [.fullName, .email]
        
        let appleAuthController = ASAuthorizationController(authorizationRequests: [appleIDRequest])
        appleAuthController.delegate = self
        appleAuthController.presentationContextProvider = self
        
        appleAuthController.performRequests()
    }*/
    @IBAction func makeLoginTouchOrFaceID(_ sender: Any) {
        
        contextLA = LAContext()
        
        if contextLA.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            contextLA.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "ReasonFaceIDMSGKey".localized()) { (isSuccess, error) in
                
                if isSuccess {
                    
                    let loginDataAlert = UIAlertController(title: "LoginTitleAlertKey".localized(), message: "LoginMSGAlertKey".localized(), preferredStyle: .alert)
                    
                    loginDataAlert.addTextField(configurationHandler: { (nameTF) in
                        nameTF.placeholder = "UserNameKey".localized()
                    })
                    
                    loginDataAlert.addTextField(configurationHandler: { (nameTF) in
                        nameTF.placeholder = "UserEmailKey".localized()
                    })
                    
                    loginDataAlert.addAction(UIAlertAction(title: "CancelKey".localized(), style: .cancel, handler: { _ in
                        loginDataAlert.dismiss(animated: true, completion: nil)
                    }))
                    
                    loginDataAlert.addAction(UIAlertAction(title: "DoneKey".localized(), style: .default, handler: { _ in
                        
                        let tempUser = User()
                        if let userName = loginDataAlert.textFields?[0], let userEmail = loginDataAlert.textFields?[1] {
                            tempUser.userEmail = userEmail.text
                            tempUser.userName = userName.text
                        }
                        
                        if UserPresenter.sharedIntance.saveUser(userIn: tempUser) {
                            loginDataAlert.dismiss(animated: true, completion: nil)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }))
                    self.present(loginDataAlert, animated: true, completion: nil)
                }
            }
        }else{
            
        }
    }
    
    @IBAction func makeLoginAppleID(_ sender: Any) {
        
       
    }
}

/*extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credencialOut as ASAuthorizationAppleIDCredential:
            let userInfo = User(credencialIn: credencialOut)
            print(userInfo)
        default:
            print("Some Error")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Some Error")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}*/
