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

    private let favoritesWS: FavContentService = FavContentService()
    var mainErrorResponse: DynamicType<Error>?
    var movieFavContent: DynamicType<Content>?
    var serieFavContent: DynamicType<SerieContent>?
    class var sharedIntance: UserPresenter {
        struct Static {
            static let instance: UserPresenter = UserPresenter()
        }
        
        return Static.instance
    }
    
    override init() {}
    
    func isUserLogged() -> Bool {

        guard let user = getUserData() else { return false }
        
        if user.userEmail != nil {
            return true
        }
        
        return false
    }
    
    func logOut() -> Bool {
        UserDefaults.standard.removeObject(forKey: Keys.USER_DATA_KEY)
        return !isUserLogged()
    }
    
    func getUserData() -> User? {
  
        let uDefaults = UserDefaults.standard
        guard let userData = uDefaults.object(forKey: Keys.USER_DATA_KEY) as? Data else {
            return nil
        }
        
        guard let rUser = try? PropertyListDecoder().decode(User.self, from: userData) else {
            return nil
        }
                
        return rUser
    }
    
    func saveUser(userIn: User) -> Bool {
        
        do {
           try UserDefaults.standard.set(PropertyListEncoder().encode(userIn), forKey: Keys.USER_DATA_KEY)
        }catch {
            return false
        }
        
        return true
    }
    
    //MARK: Movie Favorites
    func getMovieContent() {
        
    }
    
    func isMovieFav(mContentIn: Content) -> Bool {
        var isMovieFav = false
        if let userData = self.getUserData() {
            if userData.userFavList != nil {
                userData.userFavList!.forEach {
                    if $0.cFavID == mContentIn.contentID {
                        isMovieFav = true
                    }
                }
            }
        }
        return isMovieFav
    }
    
    func addMovieContentToFav(mContentIn: Content) -> Bool {
        if var mUser = self.getUserData() {
            
            var mFav = FavContent()
            mFav.cFavID = mContentIn.contentID
            mFav.cFavName = mContentIn.contentTitle
            mFav.cFavSubName = mContentIn.contentOriginalTitle
            mFav.cFavIMG = mContentIn.contentPosterPath
            mFav.cFavType = "Movie"
            
            if mUser.userFavList == nil {
                mUser.userFavList = []
            }
            mUser.userFavList?.append(mFav)
            if self.saveUser(userIn: mUser) {
                return true
            }
        }
        
        return false
    }
    
    func removeMovieContentToFav(mContentIn: Content) -> Bool {
        if var mUser = self.getUserData() {
            if mUser.userFavList != nil {
                for (index, mFavContent) in mUser.userFavList!.enumerated() {
                    if mFavContent.cFavID == mContentIn.contentID {
                        mUser.userFavList?.remove(at: index)
                        if self.saveUser(userIn: mUser) {
                            return true
                        }
                    }
                }
            }
        }
        
        return false
    }
    
    //MARK: Series Favorites
    func getSerieDetail(serieIDIn: Int) {
        self.favoritesWS.getSerieDetail(serieIDIn: serieIDIn).done { (serieContentIn) in
            SerieContentPresenter.sharedInstance.mainSerieContentSelected.value = serieContentIn
            NotificationCenter.default.post(name: .ShowFavSerieDetail, object: nil)
        }.catch { (errorIn) in
            self.mainErrorResponse?.value = errorIn
        }
    }
    
    func isSerieFav(sContentIn: SerieContent) -> Bool {
        var isSerieFav = false
        if let userData = self.getUserData() {
            if userData.userFavList != nil {
                userData.userFavList!.forEach {
                    if $0.cFavID == sContentIn.serieID {
                        isSerieFav = true
                    }
                }
            }
        }
        return isSerieFav
    }
    
    func addSerieContentToFav(sContentIn: SerieContent) -> Bool {
        if var mUser = self.getUserData() {
            
            var mFav = FavContent()
            mFav.cFavID = sContentIn.serieID
            mFav.cFavName = sContentIn.serieName
            mFav.cFavSubName = sContentIn.serieOriginalName
            mFav.cFavIMG = sContentIn.seriePosterPath
            mFav.cFavType = "Serie"
            
            if mUser.userFavList == nil {
                mUser.userFavList = []
            }
            mUser.userFavList?.append(mFav)
            if self.saveUser(userIn: mUser) {
                return true
            }
        }
        
        return false
    }
    
    func removeSerieContentToFav(sContentIn: SerieContent) -> Bool {
        if var mUser = self.getUserData() {
            if mUser.userFavList != nil {
                for (index, mFavContent) in mUser.userFavList!.enumerated() {
                    if mFavContent.cFavID == sContentIn.serieID {
                        mUser.userFavList?.remove(at: index)
                        if self.saveUser(userIn: mUser) {
                            return true
                        }
                    }
                }
            }
        }
        
        return false
    }
}
