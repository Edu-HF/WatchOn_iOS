//
//  UserPresenter.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 15/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class UserPresenter: NSObject {

    class var sharedIntance: UserPresenter {
        struct Static {
            static let instance: UserPresenter = UserPresenter()
        }
        
        return Static.instance
    }
    
    override init() {}
    
    func isUserLogged() -> Bool {
        return KeychainWrapper.standard.object(forKey: Keys.USER_DATA_KEY) != nil
    }
    
    func logOut() -> Bool {
        return KeychainWrapper.standard.remove(key: Keys.USER_DATA_KEY)
    }
    
    func getUserData() -> User? {
        return KeychainWrapper.standard.object(forKey: Keys.USER_DATA_KEY) as? User
    }
    
    func saveUser(userIn: User) -> Bool {
        return KeychainWrapper.standard.set(userIn, forKey: Keys.USER_DATA_KEY, withAccessibility: .always)
    }
}
