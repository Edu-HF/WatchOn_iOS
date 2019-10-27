//
//  FavContent.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 09/10/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct FavContent: Codable {
    
    var cFavID: Int?
    var cFavName: String?
    var cFavSubName: String?
    var cFavIMG: String?
    var cFavType: String?
    
    enum CodingKeys: String, CodingKey{
        case cFavID = "cFavID"
        case cFavName = "cFavName"
        case cFavSubName = "cFavSubName"
        case cFavIMG = "cFavIMG"
        case cFavType = "cFavType"
    }
    
    init() {
        
        cFavID = 0
        cFavName = ""
        cFavSubName = ""
        cFavIMG = ""
        cFavType = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cFavID = try? container.decode(Int.self, forKey: .cFavID)
        cFavName = try? container.decode(String.self, forKey: .cFavName)
        cFavSubName = try? container.decode(String.self, forKey: .cFavSubName)
        cFavIMG = try? container.decode(String.self, forKey: .cFavIMG)
        cFavType = try? container.decode(String.self, forKey: .cFavType)
    }
}
