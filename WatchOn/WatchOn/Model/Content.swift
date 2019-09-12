//
//  Content.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 21/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct Content: Codable {
    
    var contentID: Int
    var contentTitle: String
    var contentPupularity: Double?
    var contentPosterPath: String?
    var contentLang: String?
    var contentOriginalTitle: String
    var contentBGPoster: String?
    var contentSinoxsis: String?
    var contentReleaseDate: String?
    var contentVoteNum: Double?
    var contentVoteAverage: Double?
    var contentGenrersID: [Int]?
    var contentCast: DynamicType<[CastMember]> = DynamicType([])
    var contentMedia: DynamicType<[MediaData]> = DynamicType([])
    
    init() {
        
        contentID = 0
        contentTitle = ""
        contentPupularity = 0
        contentPosterPath = ""
        contentLang = ""
        contentOriginalTitle = ""
        contentBGPoster = ""
        contentSinoxsis = ""
        contentReleaseDate = ""
        contentVoteNum = 0
        contentVoteAverage = 0
        contentGenrersID = []
        contentCast.value = []
        contentMedia.value = []
    }
    
    enum CodingKeys: String, CodingKey {
        
        case contentID = "id"
        case contentTitle = "title"
        case contentPupularity = "popularity"
        case contentPosterPath = "poster_path"
        case contentLang = "original_language"
        case contentOriginalTitle = "original_title"
        case contentBGPoster = "backdrop_path"
        case contentSinoxsis = "overview"
        case contentReleaseDate = "release_date"
        case contentVoteNum = "vote_count"
        case contentVoteAverage = "vote_average"
        case contentGenrersID = "genre_ids"
    }

}

struct ResponseContent : Codable {
    var results: [Content]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
