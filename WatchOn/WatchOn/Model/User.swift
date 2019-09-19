//
//  User.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 09/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import AuthenticationServices
import MFCard

class User: NSObject, NSCoding {
    
    var userID: String?
    var userFName: String?
    var userLName: String?
    var userEmail: String?
    var userPaymentMethod: WCard?
    var userFavList: [Int]?
    
    /*init(credencialIn: ASAuthorizationAppleIDCredential) {
        self.userID = credencialIn.user
        self.userFName = credencialIn.fullName?.givenName ?? ""
        self.userLName = credencialIn.fullName?.familyName ?? ""
        self.userEmail = credencialIn.email ?? ""
    }*/
    
    override init() {
        
        userID = "0"
        userFName = "Eduardo"
        userLName = "Herrera"
        userEmail = "soulfade@hotmail.com"
        userPaymentMethod = WCard()
        userFavList = [1920, 0192, 1928]
    }
    
    enum Key: String {
        case userID = "userID"
        case userFName = "userFName"
        case userLName = "userLName"
        case userEmail = "userEmail"
        case userPaymentMethod = "userPaymentMethod"
        case userFavList = "userFavList"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userID, forKey: Key.userID.rawValue)
        aCoder.encode(userFName, forKey: Key.userFName.rawValue)
        aCoder.encode(userLName, forKey: Key.userLName.rawValue)
        aCoder.encode(userEmail, forKey: Key.userEmail.rawValue)
        aCoder.encode(userPaymentMethod, forKey: Key.userPaymentMethod.rawValue)
        aCoder.encode(userFavList, forKey: Key.userFavList.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.userID = aDecoder.decodeObject(forKey: Key.userID.rawValue) as? String
        self.userFName = aDecoder.decodeObject(forKey: Key.userFName.rawValue) as? String
        self.userLName = aDecoder.decodeObject(forKey: Key.userLName.rawValue) as? String
        self.userEmail = aDecoder.decodeObject(forKey: Key.userEmail.rawValue) as? String
        self.userPaymentMethod = aDecoder.decodeObject(forKey: Key.userPaymentMethod.rawValue) as? WCard
        self.userFavList = aDecoder.decodeObject(forKey: Key.userFavList.rawValue) as? [Int]
    }
}
