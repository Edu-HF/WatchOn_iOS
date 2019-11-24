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
        
        if let userData: User = UserPresenter.sharedIntance.getUserData() {
            if let wCardUser: WCard = userData.userPaymentMethod {
                if let currentCard: Card = wCardUser.getCardFromWCard() {
                    self.mainCardView.fillTextFieldFromCard(card: currentCard)
                }
            }
        }
    }
}

extension PaymentCardTableViewCell: MFCardDelegate {
    
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        
        if error != nil {
            print(error!)
            return
        }
        
        if let rCard = card {
            if var userData = UserPresenter.sharedIntance.getUserData() {
                var wCard = WCard()
                wCard.wHolderName = rCard.name
                wCard.wNumber = rCard.number
                wCard.wMonth = rCard.month.map { $0.rawValue }
                wCard.wYear = rCard.year
                wCard.wCvc = rCard.cvc
                wCard.wPaymentType = rCard.paymentType.map { $0.rawValue }
                wCard.wType = rCard.cardType.map { $0.rawValue }
                wCard.wUserID = rCard.userId
                userData.userPaymentMethod = wCard
                if UserPresenter.sharedIntance.saveUser(userIn: userData) {
                    NotificationCenter.default.post(Notification(name: .ShowCardSaveMSGNoti))
                }
            }
        }
    }
    
    func cardTypeDidIdentify(_ cardType: String) {
        print(cardType)
    }
    
    func cardDidClose() {}
}
