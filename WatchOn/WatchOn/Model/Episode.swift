//
//  Episode.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 28/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    var eID: Int?
    var eNumber: Int?
    var eName: String?
    
    enum CodingKeys: String, CodingKey {
        case eID = "id"
        case eName = "name"
        case eNumber = "episode_number"
    }
}

struct ResponseEpisode : Codable {
    var results: [Episode]?
    
    enum CodingKeys: String, CodingKey {
        case results = "episodes"
    }
}
