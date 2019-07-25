//
//  UserProfileCardView.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 17/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

enum ViewStade: String {
    case PaymentMethod, MyList, MyData
}

class UserProfileCardView: UIView {

    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var userEmailLB: UILabel!
    
    @IBOutlet weak var mainStateTV: UITableView!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
}
