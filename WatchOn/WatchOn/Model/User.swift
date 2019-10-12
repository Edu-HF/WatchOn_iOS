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

struct User: Codable{
    
    var userID: String?
    var userName: String?
    var userEmail: String?
    var userIMGData: Data?
    var userPaymentMethod: WCard?
    var userFavList: [FavContent]?
    
    @available(iOS 13.0, *)
    init(credencialIn: ASAuthorizationAppleIDCredential) {
        self.userID = credencialIn.user
        var userTempName = (credencialIn.fullName?.givenName ?? "") + " "
        userTempName += credencialIn.fullName?.familyName ?? ""
        self.userName = userTempName
        self.userEmail = credencialIn.email ?? ""
        self.userFavList = []
    }
    
    init() {
        
        userID = "0"
        userName = "Eduardo Herrera"
        userEmail = "soulfade@hotmail.com"
        userIMGData = nil
        userPaymentMethod = nil
        userFavList = []
    }
    
    enum CodingKeys: String, CodingKey{
        case userID = "userID"
        case userName = "userName"
        case userEmail = "userEmail"
        case userIMGData = "userIMGData"
        case userPaymentMethod = "userPaymentMethod"
        case userFavList = "userFavList"
    }
}
