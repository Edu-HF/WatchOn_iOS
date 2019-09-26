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
    var serieBackDropPath: String?
    var seriePosterPath: String?
    var serieOriginalLanguage: String?
    var seriePopularity: Double?
    var serieSintaxis: String?
    var serieVoteAverage: Double?
    var serieVoteNum: Double?
    var serieIsSelected: Bool?
    
    init() {
        
        serieID = 0
        serieName = ""
        serieOriginalName = ""
        serieBackDropPath = ""
        seriePosterPath = ""
        serieOriginalLanguage = ""
        seriePopularity = 0
        serieSintaxis = ""
        serieVoteAverage = 0
        serieVoteNum = 0
        serieIsSelected = false
    }
    
    enum CodingKeys: String, CodingKey {
        case serieID = "id"
        case serieName = "name"
        case serieOriginalName = "original_name"
        case serieBackDropPath = "backdrop_path"
        case seriePosterPath = "poster_path"
        case serieOriginalLanguage = "original_language"
        case seriePopularity = "popularity"
        case serieSintaxis = "overview"
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

