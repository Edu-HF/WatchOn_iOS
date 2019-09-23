//
//  SerieContent.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 22/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation

struct SerieContent: Codable {
    
    var serieID: Int?
    var serieName: String?
    var serieOriginalName: String?
    var serieSeasonsNum: Int?
    var serieEpisodesNum: Int?
    var serieOriginalLanguage: String?
    var seriePopularity: Double?
    var serieType: String?
    var serieVoteAverage: Double?
    var serieVoteNum: Double?
    
    init() {
        
        serieID = 0
        serieName = ""
        serieOriginalName = ""
        serieSeasonsNum = 0
        serieEpisodesNum = 0
        serieOriginalLanguage = ""
        seriePopularity = 0
        serieType = ""
        serieVoteAverage = 0
        serieVoteNum = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case serieID = "id"
        case serieName = "name"
        case serieOriginalName = "original_name"
        case serieSeasonsNum = "number_of_seasons"
        case serieEpisodesNum = "number_of_episodes"
        case serieOriginalLanguage = "original_language"
        case seriePopularity = "popularity"
        case serieType = "type"
        case serieVoteAverage = "vote_average"
        case serieVoteNum = "vote_count"
    }
}

struct ResponseSerie : Codable {
    var results: [SerieContent]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

