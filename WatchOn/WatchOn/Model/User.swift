//
//  User.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 09/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import AuthenticationServices

struct User {
    
    var userID: String
    var userFName: String
    var userLName: String
    var userEmail: String
    
    /*init(credencialIn: ASAuthorizationAppleIDCredential) {
        self.userID = credencialIn.user
        self.userFName = credencialIn.fullName?.givenName ?? ""
        self.userLName = credencialIn.fullName?.familyName ?? ""
        self.userEmail = credencialIn.email ?? ""
    }*/
}
