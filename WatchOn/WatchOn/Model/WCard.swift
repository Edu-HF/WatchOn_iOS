//
//  WCard.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 15/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import MFCard

struct WCard: Codable {
    
    var wHolderName: String?
    var wNumber: String?
    var wMonth: String?
    var wYear: String?
    var wCvc: String?
    var wPaymentType: String?
    var wType: String?
    var wUserID: Int?
    
    enum CodingKeys: String, CodingKey{
        case wHolderName = "wHolderName"
        case wNumber = "wNumber"
        case wMonth = "wMonth"
        case wYear = "wYear"
        case wCvc = "wCvc"
        case wPaymentType = "wPaymentType"
        case wType = "wType"
        case wUserID = "wUserID"
    }
    
    init() {
        wHolderName = ""
        wNumber = ""
        wMonth = ""
        wYear = ""
        wCvc = ""
        wPaymentType = ""
        wType = ""
        wUserID = 0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        wHolderName = try? container.decode(String.self, forKey: .wHolderName)
        wNumber = try? container.decode(String.self, forKey: .wNumber)
        wMonth = try? container.decode(String.self, forKey: .wMonth)
        wYear = try? container.decode(String.self, forKey: .wYear)
        wCvc = try? container.decode(String.self, forKey: .wCvc)
        wPaymentType = try? container.decode(String.self, forKey: .wPaymentType)
        wType = try? container.decode(String.self, forKey: .wType)
        wUserID = try? container.decode(Int.self, forKey: .wUserID)
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
