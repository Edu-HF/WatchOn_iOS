//
//  UserProfileViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke
import SwiftKeychainWrapper
import MFCard

class UserProfileViewController: BaseViewController {
    
    private var mainUserPresenter = UserPresenter.sharedIntance
    private var mProfilePhotoIV: UIImageView!
    private var mProfilePhotoBtn: UIButton!
    private var mUserCardView: UserProfileCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        validateUserSession()
    }
    
    private func setupView() {
    
        setVCTitle(titleIn: "UserProfileUKey".localized())
        mUserCardView = UserProfileCardView.instanceFromNib()
        mUserCardView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 440)
        mUserCardView.center = self.view.center
        self.view.addSubview(mUserCardView)
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.buildProfilePhoto()
        })
        
        if let userData = mainUserPresenter.getUserData() {
            var userName = userData.userFName ?? "UserNameUKey".localized()
            userName += " "
            userName += userData.userLName ?? ""
            mUserCardView.userNameLB.text = userName
            mUserCardView.userEmailLB.text = userData.userEmail ?? "UserEmailKey".localized()
        }

    }

    
    private func validateUserSession() {
        if mainUserPresenter.isUserLogged() {
            self.present(LoginViewController(), animated: true, completion: nil)
        }
    }
    
    private func buildProfilePhoto() {
        
        mProfilePhotoIV = UIImageView(frame: CGRect(x: mUserCardView.frame.origin.x+240, y: mUserCardView.frame.origin.y - 40, width: 100, height: 100))
        mProfilePhotoIV.image = UIImage(named: "IMGPlaceHolder_IC")
        
        mProfilePhotoBtn = UIButton(frame: mProfilePhotoIV.frame)
        mProfilePhotoBtn.setTitle("", for: .normal)
        mProfilePhotoBtn.addTarget(self, action: #selector(onProfilePhotoClick), for: .touchUpInside)
        self.view.addSubview(mProfilePhotoIV)
        self.view.addSubview(mProfilePhotoBtn)
        
        DispatchQueue.main.async {
            let pathIMG = URL(fileURLWithPath: "")
            Nuke.loadImage(with: pathIMG, options: ImageLoadingOptions().loadIMGBaseOptions(), into: self.mProfilePhotoIV, progress: nil, completion: { _ in
                self.mProfilePhotoIV.resizeRoundedIMG()
            })
         }
    }
    
    @objc private func onProfilePhotoClick() {
        print("FUNCA")
    }
}
