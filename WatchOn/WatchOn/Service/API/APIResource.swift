//
//  APIResource.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 21/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: URL { get }
    var urlPath: String { get }
}

enum MEDIAResourceKind: String {
    case YouTube = "https://www.youtube.com/watch?v="
    case Vimeo = "https://www.vimeo.com/watch?v="
}

enum APIResource {
    case getDiscoverMovies, getTrendingMovies, getPopularityMovies, getTopRatedMovies, getUpcomingMovies, getPopularitySeries, getTopRatedSeries, getUpcomingSeries, getGenres, getCast, getMedia, getLatestSeries
}

struct APIError: Codable {
    let success: Bool
    let error: APIErrorDesc
}

struct APIErrorDesc: Codable {
    let message, name: String
    let code: Int
}

extension APIResource: EndPointType {

    var baseURL: URL {
        let mainDict = Bundle.main.infoDictionary
        let bURL = mainDict?["SERVER_URL"] as! String
        return URL(string: bURL)!
    }
    
    var baseYouTubeURL: URL {
        let mainDict = Bundle.main.infoDictionary
        let baseYURL = mainDict?["YOUTUBE_URL"] as! String
        return URL(string: baseYURL)!
    }
    
    var urlPath: String {
        switch self {
            case .getDiscoverMovies: return "/discover/movie"
            case .getTrendingMovies: return "/trending/all/day"
            case .getPopularityMovies: return "/movie/popular"
            case .getTopRatedMovies: return "/movie/top_rated"
            case .getUpcomingMovies: return "/movie/upcoming"
            case .getPopularitySeries: return "/tv/popular"
            case .getTopRatedSeries: return "/tv/top_rated"
            case .getUpcomingSeries: return "/tv/latest"
            case .getGenres: return "/genre/movie/list"
            case .getCast: return "/movie/"
            case .getMedia: return "/movie/"
            
        case .getLatestSeries: return "/tv/latest"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDiscoverMovies, .getTrendingMovies, .getPopularityMovies, .getTopRatedMovies, .getUpcomingMovies, .getPopularitySeries, .getTopRatedSeries, .getUpcomingSeries, .getGenres, .getCast, .getMedia, .getLatestSeries: return .get
        }
    }
}
