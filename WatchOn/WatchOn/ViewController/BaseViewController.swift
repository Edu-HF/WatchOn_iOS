//
//  BaseViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 08/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStandarView()
    }
    
    fileprivate func setupStandarView() {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor = .darkTwo
        self.tabBarController?.tabBar.barTintColor = .darkTwo
        self.view.backgroundColor = .homeBackground2
    }
}

extension BaseViewController {
    
    func dismissAndPresent(viewController: UIViewController) {
        let this = self.presentingViewController
        self.dismiss(animated: true, completion: {
            this?.present(viewController, animated: true, completion: nil)
        })
    }
}
