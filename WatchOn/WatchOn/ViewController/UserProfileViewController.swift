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
    private var mImagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .ShowFavMovieDetail, object: nil)
        NotificationCenter.default.removeObserver(self, name: .ShowFavSerieDetail, object: nil)
        NotificationCenter.default.removeObserver(self, name: .ShowCardSaveMSGNoti, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        validateUserSession()
        buildProfilePhoto()
        NotificationCenter.default.addObserver(self, selector: #selector(showMovieDetail), name: .ShowFavMovieDetail, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSerieDetail), name: .ShowFavSerieDetail, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showCardSaveMSG), name: .ShowCardSaveMSGNoti, object: nil)
    }
    
    private func setupView() {
    
        setVCTitle(titleIn: "UserProfileUKey".localized())
        mUserCardView = UserProfileCardView.instanceFromNib()
        mUserCardView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 440)
        mUserCardView.center = self.view.center
        self.view.addSubview(mUserCardView)
    }

    private func buildLogOutBtn() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "LogOut_IC"), style: .plain, target: self, action: #selector(logOutAct))
    }
    
    @objc private func logOutAct() {
        if mainUserPresenter.logOut() {
            self.tabBarController?.selectedIndex = 0
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func showMovieDetail() {
        self.navigationController?.pushViewController(DetailViewController(nibName: "DetailViewController", bundle: nil), animated: true)
    }
    
    @objc private func showSerieDetail() {
        self.navigationController?.pushViewController(SerieDetailViewController(nibName: "SerieDetailView", bundle: nil), animated: true)
    }
    
    private func validateUserSession() {
        
        if !mainUserPresenter.isUserLogged() {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }else {
            buildLogOutBtn()
            if let userData = mainUserPresenter.getUserData() {
                mUserCardView.userNameLB.text = userData.userName ?? "UserNameUKey".localized()
                mUserCardView.userEmailLB.text = userData.userEmail ?? "UserEmailKey".localized()
                mUserCardView.mainStateTV.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    self.buildProfilePhoto()
                })
            }
        }
    }
    
    private func buildProfilePhoto() {
        
        mProfilePhotoIV = UIImageView(frame: CGRect(x: self.view.frame.width-120, y: mUserCardView.frame.origin.y - 40, width: 100, height: 100))
       
        mProfilePhotoBtn = UIButton(frame: mProfilePhotoIV.frame)
        mProfilePhotoBtn.setTitle("", for: .normal)
        mProfilePhotoBtn.addTarget(self, action: #selector(onProfilePhotoClick), for: .touchUpInside)
        self.view.addSubview(mProfilePhotoIV)
        self.view.addSubview(mProfilePhotoBtn)
        
        DispatchQueue.main.async {
            if let userData = self.mainUserPresenter.getUserData() {
                if userData.userIMGData != nil  {
                    if let userIMG: UIImage = UIImage(data: userData.userIMGData!) {
                        self.mProfilePhotoIV.image = userIMG
                    }else {
                        self.mProfilePhotoIV.image = UIImage(named: "CAMPlaceHolder_IC")
                    }
                }
            }else {
                self.mProfilePhotoIV.image = UIImage(named: "CAMPlaceHolder_IC")
            }
            self.mProfilePhotoIV.resizeRoundedIMGCam()
         }
    }
    
    @objc private func onProfilePhotoClick() {
        let alertIMGPicker = UIAlertController.init(title: "SelectPhotoKey".localized(), message: "FromGaleryOrCamKey".localized(), preferredStyle: .actionSheet)
        
        alertIMGPicker.addAction(UIAlertAction(title: "CamKey".localized(), style: .default, handler: { _ in
            alertIMGPicker.dismiss(animated: true, completion: nil)
            self.showIMGPicker(.camera)
        }))
        
        alertIMGPicker.addAction(UIAlertAction(title: "GaleryKey".localized(), style: .default, handler: { _ in
            alertIMGPicker.dismiss(animated: true, completion: nil)
            self.showIMGPicker(.photoLibrary)
        }))
        
        alertIMGPicker.addAction(UIAlertAction.init(title: "CancelKey".localized(), style: .cancel, handler: nil))
        
        self.present(alertIMGPicker, animated: true, completion: nil)
    }
    
    private func showIMGPicker(_ sourceIn: UIImagePickerController.SourceType) {
        mImagePicker = UIImagePickerController()
        mImagePicker.delegate = self
        mImagePicker.sourceType = sourceIn
        self.present(mImagePicker, animated: true, completion: nil)
    }
    
    @objc private func showCardSaveMSG() {
        self.showSomeMSGAlert(titleIn: "PaymentMethodKey".localized(), msgIn: "PaymentMethodSaveMSGKey".localized())
    }
}

extension UserProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.mImagePicker.dismiss(animated: true, completion: nil)
        if var userData = self.mainUserPresenter.getUserData() {
            if let userIMG = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                userData.userIMGData = userIMG.pngData()
                if self.mainUserPresenter.saveUser(userIn: userData) {
                    self.validateUserSession()
                }
            }
        }
    }
}
