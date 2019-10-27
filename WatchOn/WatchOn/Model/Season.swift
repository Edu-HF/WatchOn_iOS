//
//  Season.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 28/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct Season: Codable {
    
    var sID: Int?
    var sName: String?
    var sNumber: Int?
    var sEpisodes: [Episode]?
    var sIsSelected: Bool?
    var sEposidesNA: Bool?
    
    enum CodingKeys: String, CodingKey {
        case sID = "id"
        case sName = "name"
        case sNumber = "season_number"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        sID = try? container?.decode(Int.self, forKey: .sID)
        sName = try? container?.decode(String.self, forKey: .sName)
        sNumber = try? container?.decode(Int.self, forKey: .sNumber)
    }
}




