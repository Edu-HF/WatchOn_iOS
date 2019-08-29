//
//  Genre.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 27/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct Genre: Codable {
    
    var genreID: Int
    var genreName: String
    
    enum CodingKeys: String, CodingKey {
        
        case genreID = "id"
        case genreName = "name"
    }
}

struct ResponseGenre : Codable {
    var genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}
