//
//  WCard.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 15/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import MFCard

class WCard: NSObject, NSCoding {
    
    var wHolderName: String?
    var wNumber: String?
    var wMonth: String?
    var wYear: String?
    var wCvc: String?
    var wPaymentType: String?
    var wType: String?
    var wUserID: Int?
    
    override init() {
        
        wHolderName = ""
        wNumber = ""
        wMonth = ""
        wYear = ""
        wCvc = ""
        wPaymentType = ""
        wType = ""
        wUserID = 0
    }
    
    enum Key: String {
        case wHolderName = "holderName"
        case wNumber = "number"
        case wMonth = "month"
        case wYear = "year"
        case wCvc = "cvc"
        case wPaymentType = "paymentType"
        case wType = "cardType"
        case wUserID = "userId"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(wHolderName, forKey: Key.wHolderName.rawValue)
        aCoder.encode(wNumber, forKey: Key.wNumber.rawValue)
        aCoder.encode(wMonth, forKey: Key.wMonth.rawValue)
        aCoder.encode(wYear, forKey: Key.wYear.rawValue)
        aCoder.encode(wCvc, forKey: Key.wCvc.rawValue)
        aCoder.encode(wPaymentType, forKey: Key.wPaymentType.rawValue)
        aCoder.encode(wType, forKey: Key.wType.rawValue)
        aCoder.encode(wUserID, forKey: Key.wUserID.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.wHolderName = aDecoder.decodeObject(forKey: Key.wHolderName.rawValue) as? String
        self.wNumber = aDecoder.decodeObject(forKey: Key.wNumber.rawValue) as? String
        self.wMonth = aDecoder.decodeObject(forKey: Key.wMonth.rawValue) as? String
        self.wYear = aDecoder.decodeObject(forKey: Key.wYear.rawValue) as? String
        self.wCvc = aDecoder.decodeObject(forKey: Key.wCvc.rawValue) as? String
        self.wPaymentType = aDecoder.decodeObject(forKey: Key.wPaymentType.rawValue) as? String
        self.wType = aDecoder.decodeObject(forKey: Key.wType.rawValue) as? String
        self.wUserID = aDecoder.decodeObject(forKey: Key.wUserID.rawValue) as? Int
        
    }
    
    func getWCardFromCard(cardIn: Card) -> WCard {
        self.wHolderName = cardIn.name
        self.wNumber = cardIn.number
        self.wMonth = cardIn.month?.rawValue
        self.wYear = cardIn.year
        self.wCvc = cardIn.cvc
        self.wPaymentType = cardIn.paymentType?.rawValue
        self.wType = cardIn.cardType?.rawValue
        self.wUserID = cardIn.userId
        
        return self
    }
    
    func getCardFromWCard() -> Card? {
        
        if self.wMonth != nil && self.wPaymentType != nil && self.wType != nil {
            let tempMonth = Month(rawValue: self.wMonth!)!
            let tempPaymentType = Card.PaymentType(rawValue: self.wPaymentType!)!
            let tempCardType = CardType(rawValue: self.wType!)!
            
            return Card(holderName: self.wHolderName ?? "", number: self.wNumber ?? "", month: tempMonth, year: self.wYear ?? "", cvc: self.wCvc ?? "", paymentType: tempPaymentType, cardType: tempCardType, userId: self.wUserID)
        }
        return nil
    }
}
