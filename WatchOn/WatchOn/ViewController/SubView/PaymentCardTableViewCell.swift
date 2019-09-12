//
//  PaymentCardTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 09/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import MFCard

class PaymentCardTableViewCell: UITableViewCell {

    @IBOutlet weak var mainCardView: MFCardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell() {
        mainCardView.delegate = self
        mainCardView.toast = true
    }
}

extension PaymentCardTableViewCell: MFCardDelegate {
    
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        
        if error != nil {
            print(error!)
            return
        }
        
        if let rCard = card {
            print(rCard.cardType!)
        }
    }
    
    func cardTypeDidIdentify(_ cardType: String) {
        print(cardType)
    }
    
    func cardDidClose() {}
}
