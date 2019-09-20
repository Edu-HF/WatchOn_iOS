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
    var userName: String?
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
        userName = "Eduardo Herrera"
        userEmail = "soulfade@hotmail.com"
        userPaymentMethod = nil
        userFavList = []
    }
    
    enum Key: String {
        case userID = "userID"
        case userName = "userName"
        case userEmail = "userEmail"
        case userPaymentMethod = "userPaymentMethod"
        case userFavList = "userFavList"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userID, forKey: Key.userID.rawValue)
        aCoder.encode(userName, forKey: Key.userName.rawValue)
        aCoder.encode(userEmail, forKey: Key.userEmail.rawValue)
        aCoder.encode(userPaymentMethod, forKey: Key.userPaymentMethod.rawValue)
        aCoder.encode(userFavList, forKey: Key.userFavList.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.userID = aDecoder.decodeObject(forKey: Key.userID.rawValue) as? String
        self.userName = aDecoder.decodeObject(forKey: Key.userName.rawValue) as? String
        self.userEmail = aDecoder.decodeObject(forKey: Key.userEmail.rawValue) as? String
        self.userPaymentMethod = aDecoder.decodeObject(forKey: Key.userPaymentMethod.rawValue) as? WCard
        self.userFavList = aDecoder.decodeObject(forKey: Key.userFavList.rawValue) as? [Int]
    }
}
