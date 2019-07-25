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
}
