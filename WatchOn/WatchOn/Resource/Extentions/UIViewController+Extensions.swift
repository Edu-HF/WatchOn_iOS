//
//  UIViewController+Extensions.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 09/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
    
    func presentAndDismiss(viewControllerIn: UIViewController) {
        let thisVC = self.presentedViewController ?? self
        self.dismiss(animated: true, completion: {
            thisVC.present(viewControllerIn, animated: true, completion: nil)
        })
    }
    
    func setVCTitle(titleIn: String) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "TamilSangamMN-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        navigationItem.title = titleIn
    }
    
    func dismissAndPresent(viewController: UIViewController) {
        let this = self.presentingViewController
        self.dismiss(animated: true, completion: {
            this?.present(viewController, animated: true, completion: nil)
        })
    }
    
    func dismissToPresent(viewController: UIViewController) {
        let this = self.presentingViewController
        self.dismiss(animated: false, completion: {
            this?.present(viewController, animated: false, completion: nil)
        })
    }
    
    func showSomeMSGAlert(titleIn: String, msgIn: String) {
        let mMSGAlert = UIAlertController.init(title: titleIn, message: msgIn, preferredStyle: .alert)
        
        mMSGAlert.addAction(UIAlertAction.init(title: "AcceptKey".localized(), style: .default, handler: { _ in
            mMSGAlert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(mMSGAlert, animated: true, completion: nil)
    }
    
    func buildBackBtn() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "BackOn_IC")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAct))
    }
    
    @objc func backAct() {
        _ = navigationController?.popViewController(animated: true)
    }
}
