//
//  MediaData.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 05/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct MediaData: Codable {
    
    var mID: String?
    var mKey: String?
    var mName: String?
    var mSite: String?
    var mType: String?
    
    init() {
        
        mID = ""
        mKey = ""
        mName = ""
        mSite = ""
        mType = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case mID = "id"
        case mKey = "key"
        case mName = "name"
        case mSite = "site"
        case mType = "type"
    }
}

struct ResponseMediaData : Codable {
    var results: [MediaData]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
