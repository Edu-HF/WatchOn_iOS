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
    
    @IBOutlet weak var mAppleBtn: WButton!
    @IBOutlet weak var mTFIDBtn: WButton!
    @IBOutlet weak var mLogoIV: UIImageView!
    
    private var contextLA = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mLogoIV.animationAlpha(delay: 1, block: {
            self.mAppleBtn.animationSlideInHorizontal(delay: 0.5, direction: .Left, block: {})
            self.mTFIDBtn.animationSlideInHorizontal(delay: 0.5, direction: .Right, block: {})
        })
    }
    
    @IBAction func makeLoginTouchOrFaceID(_ sender: Any) {
        
        contextLA = LAContext()
        
        if contextLA.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            contextLA.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "ReasonFaceIDMSGKey".localized()) { (isSuccess, error) in
                
                DispatchQueue.main.async {
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
                            
                            var tempUser = User()
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
            }
        }else{
            self.showSomeMSGAlert(titleIn: "AppleTouchIDORFaceIDLoginKey".localized(), msgIn: "NotAppleTouchIDORFaceIDAvailableMGSKey".localized())
        }
    }
    
    @IBAction func makeLoginAppleID(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            let appleProvider = ASAuthorizationAppleIDProvider()
            let appleIDRequest = appleProvider.createRequest()
            appleIDRequest.requestedScopes = [.fullName, .email]
            
            let appleAuthController = ASAuthorizationController(authorizationRequests: [appleIDRequest])
            appleAuthController.delegate = self
            appleAuthController.presentationContextProvider = self
            
            appleAuthController.performRequests()
        } else {
            showSomeMSGAlert(titleIn: "AppleIDTitleKey".localized(), msgIn: "NotAppleIDAvailableMGSKey".localized())
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credencialOut as ASAuthorizationAppleIDCredential:
            let userInfo = User(credencialIn: credencialOut)
            if UserPresenter.sharedIntance.saveUser(userIn: userInfo) {
                self.dismiss(animated: true, completion: nil)
            }
        default:
            self.showSomeMSGAlert(titleIn: "AppleIDTitleKey".localized(), msgIn: "AppleIDErrorMSGKey".localized())
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.showSomeMSGAlert(titleIn: "AppleIDTitleKey".localized(), msgIn: "AppleIDErrorMSGKey".localized())
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
