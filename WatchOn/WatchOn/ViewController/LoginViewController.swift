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
    private var userName: String = ""
    private var userEmail: String = ""

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
                        self.userName = nameTF.text ?? ""
                    })
                    
                    loginDataAlert.addTextField(configurationHandler: { (nameTF) in
                        nameTF.placeholder = "UserEmailKey".localized()
                        self.userEmail = nameTF.text ?? ""
                    })
                    
                    loginDataAlert.addAction(UIAlertAction(title: "CancelKey".localized(), style: .cancel, handler: { _ in
                        loginDataAlert.dismiss(animated: true, completion: nil)
                    }))
                    
                    loginDataAlert.addAction(UIAlertAction(title: "DoneKey".localized(), style: .default, handler: { _ in
                        print("Save USER")
                        loginDataAlert.dismiss(animated: true, completion: nil)
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
