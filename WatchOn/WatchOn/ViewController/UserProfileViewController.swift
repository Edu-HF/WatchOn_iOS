//
//  UserProfileViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 07/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class UserProfileViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        let userCardView = UserProfileCardView.instanceFromNib()
        userCardView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 440)
        userCardView.center = self.view.center
        self.view.addSubview(userCardView)
    }

}
