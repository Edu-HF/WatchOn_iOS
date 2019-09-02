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

enum APIResource {
    case getDiscoverMovies, getTrendingMovies, getPopularityMovies, getTopRatedMovies, getUpcomingMovies, getPopularitySeries, getTopRatedSeries, getUpcomingSeries, getGenres, getCast
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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDiscoverMovies, .getTrendingMovies, .getPopularityMovies, .getTopRatedMovies, .getUpcomingMovies, .getPopularitySeries, .getTopRatedSeries, .getUpcomingSeries, .getGenres, .getCast: return .get
        }
    }
}
