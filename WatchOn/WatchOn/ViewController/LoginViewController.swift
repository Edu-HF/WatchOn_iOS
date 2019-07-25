//
//  LoginViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
