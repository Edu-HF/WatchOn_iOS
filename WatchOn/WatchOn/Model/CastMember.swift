//
//  CastMember.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 01/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct CastMember: Codable {
    
    var cID: Int?
    var castID: Int?
    var castCharacter: String?
    var castCredictID: String?
    var castGenre: Int?
    var castMemberName: String?
    var castOrder: Int?
    var castMemberProfilePath: String?
    
    init() {
        
        cID = 0
        castID = 0
        castCharacter = ""
        castCredictID = ""
        castGenre = 0
        castMemberName = ""
        castOrder = 0
        castMemberProfilePath = ""
    }
    
    enum CodingKeys: String, CodingKey {
        
        case cID = "id"
        case castID = "cast_id"
        case castCharacter = "character"
        case castCredictID = "credit_id"
        case castGenre = "gender"
        case castMemberName = "name"
        case castOrder = "order"
        case castMemberProfilePath = "profile_path"
    }
}

struct ResponseCast: Codable {
    
    var cast: [CastMember]?
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
    }
}
